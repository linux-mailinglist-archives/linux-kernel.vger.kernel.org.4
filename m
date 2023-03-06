Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF546AC37F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCFOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCFOjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:39:09 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5707B6EBE;
        Mon,  6 Mar 2023 06:38:40 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id A9DF4D27;
        Mon,  6 Mar 2023 15:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678113198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcx1Z+mQ9kyIzZhbOPRPBb/rBVGlQz4iqABIHXKcMdQ=;
        b=qGYyny0k3uTeywGiVxJ/2RN7/630Mg6LmAREuV62PulrksrBG56Gjvo9vd5OzirIkH/dSs
        M8J7T9Mqg0lFR+mSm1qnsxrHLybpNp96s/mchZac8HrGnNsv8pmtvXxixAUFPowOJ6bbn+
        Wbsl6GZQNecz36uVxM08f1gsfEsQOvaEL67AI5o4b9VC7E0napHqUZNJSAanD00jdwFv/u
        /jRs5Lsb0TLXBRrBUiKiGBQxzH93eLCELLngGyh1ct4KQmDIbHGZs7fTTvAVEePUIsruB2
        cF+QVD8u9HNeli3/8w2anDdJZmcQhLk30oNB1yxZNcZuyCnnh44l7Sr+KakSDw==
From:   Michael Walle <michael@walle.cc>
To:     william.gray@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
        broonie@kernel.org, jay.dolan@accesio.com, jhentges@accesio.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quarium@gmail.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 2/3] gpio: pcie-idio-24: Migrate to the regmap API
Date:   Mon,  6 Mar 2023 15:33:09 +0100
Message-Id: <20230306143309.758690-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b96429c66e7caca05d9fb93805e11650fdbad312.1678106722.git.william.gray@linaro.org>
References: <b96429c66e7caca05d9fb93805e11650fdbad312.1678106722.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> For the PCIe-IDIO-24 series of devices, the following BARs are
> available:
> 
>     BAR[0]: memory mapped PEX8311
>     BAR[1]: I/O mapped PEX8311
>     BAR[2]: I/O mapped card registers
> 
> There are 24 FET Output lines, 24 Isolated Input lines, and 8 TTL/CMOS
> lines (which may be configured for either output or input). The GPIO
> lines are exposed by the following card registers:
> 
>     Base +0x0-0x2 (Read/Write): FET Outputs
>     Base +0xB (Read/Write): TTL/CMOS
>     Base +0x4-0x6 (Read): Isolated Inputs
>     Base +0x7 (Read): TTL/CMOS
> 
> In order for the device to support interrupts, the PLX PEX8311 internal
> PCI wire interrupt and local interrupt input must first be enabled.
> 
> The following card registers for Change-Of-State may be used:
> 
>     Base +0x8-0xA (Read): COS Status Inputs
>     Base +0x8-0xA (Write): COS Clear Inputs
>     Base +0xB (Read): COS Status TTL/CMOS
>     Base +0xB (Write): COS Clear TTL/CMOS
>     Base +0xE (Read/Write): COS Enable
> 
> The COS Enable register is used to enable/disable interrupts and
> configure the interrupt levels; each bit maps to a group of eight inputs
> as described below:
> 
>     Bit 0: IRQ EN Rising Edge IN0-7
>     Bit 1: IRQ EN Rising Edge IN8-15
>     Bit 2: IRQ EN Rising Edge IN16-23
>     Bit 3: IRQ EN Rising Edge TTL0-7
>     Bit 4: IRQ EN Falling Edge IN0-7
>     Bit 5: IRQ EN Falling Edge IN8-15
>     Bit 6: IRQ EN Falling Edge IN16-23
>     Bit 7: IRQ EN Falling Edge TTL0-7
> 
> An interrupt is asserted when a change-of-state matching the interrupt
> level configuration respective for a particular group of eight inputs
> with enabled COS is detected.
> 
> The COS Status registers may be read to determine which inputs have
> changed; if interrupts were enabled, an IRQ will be generated for the
> set bits in these registers. Writing the value read from the COS Status
> register back to the respective COS Clear register will clear just those
> interrupts.
> 
> Cc: Arnaud de Turckheim <quarium@gmail.com>
> Cc: John Hentges <jhentges@accesio.com>
> Cc: Jay Dolan <jay.dolan@accesio.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

FWIW, the gpio-regmap part looks good:

Reviewed-by: Michael Walle <michael@walle.cc>

-michael
