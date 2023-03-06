Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92BC6AC370
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCFOgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCFOgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:36:44 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFE532E42;
        Mon,  6 Mar 2023 06:36:16 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E33EB164C;
        Mon,  6 Mar 2023 15:35:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678113329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1B+vQ9jUvb0XuC28lF696ECAnddLFijBB7M8fB4ToY=;
        b=VuqXn6OLtrw3jBWI6/XwhgibVi0mKlaVNBqe/bgsLrSvkD9O6DPxZv37h4Nm2RYypZMQQJ
        2S04l6pWG2Q1VQkuV1KtKdrWLR33Ar60TioR5f+DAehOvbFyAk1QYYrtqpaRyra+0ilopT
        Bdc7+purDnJHaz4q9Pi9U1kn8NRRLiBUGBeQLVDRzl6qLQ82kxAoLIQEETMOXapTa7Dg0y
        aFl8WC9dlE4K/AdFCstS8x4ART4KaDX2nWGnSEE0zr6Ijmr6PUnClVpQ5DZXCExnpoVSKs
        JFpvkq4MO7q/gb7e36ZfU3I0IcHbqT862XyruF6y3udWGflF9fsLCxtJ4ohHog==
From:   Michael Walle <michael@walle.cc>
To:     william.gray@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdemetrotion@winsystems.com, techsupport@winsystems.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 3/3] gpio: ws16c48: Migrate to the regmap API
Date:   Mon,  6 Mar 2023 15:35:23 +0100
Message-Id: <20230306143523.759040-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <4b6cd42426521808962d68a44952b95818fc5daf.1678106722.git.william.gray@linaro.org>
References: <4b6cd42426521808962d68a44952b95818fc5daf.1678106722.git.william.gray@linaro.org>
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
> The WinSystems WS16C48 provides the following registers:
> 
>     Offset 0x0-0x5: Port 0-5 I/O
>     Offset 0x6: Int_Pending
>     Offset 0x7: Page/Lock
>     Offset 0x8-0xA (Page 1): Pol_0-Pol_2
>     Offset 0x8-0xA (Page 2): Enab_0-Enab_2
>     Offset 0x8-0xA (Page 3): Int_ID0-Int_ID2
> 
> Port 0-5 I/O provides access to 48 lines of digital I/O across six
> registers, each bit position corresponding to the respective line.
> Writing a 1 to a respective bit position causes that output pin to sink
> current, while writing a 0 to the same bit position causes that output
> pin to go to a high-impedance state and allows it to be used an input.
> Reads on a port report the inverted state (0 = high, 1 = low) of an I/O
> pin when used in input mode. Interrupts are supported on Port 0-2.
> 
> Int_Pending is a read-only register that reports the combined state of
> the INT_ID0 through INT_ID2 registers; an interrupt pending is indicated
> when any of the low three bits are set.
> 
> The Page/Lock register provides the following bits:
> 
>     Bit 0-5: Port 0-5 I/O Lock
>     Bit 6-7: Page 0-3 Selection
> 
> For Bits 0-5, writing a 1 to a respective bit position locks the output
> state of the corresponding I/O port. Writing the page number to Bits 6-7
> selects that respective register page for use.
> 
> Pol_0-Pol_2 are accessible when Page 1 is selected. Writing a 1 to a
> respective bit position selects the rising edge detection interrupts for
> that input line, while writing a 0 to the same bit position selects the
> falling edge detection interrupts.
> 
> Enab_0-Enab_2 are accessible when Page 2 is selected. Writing a 1 to a
> respective bit position enables interrupts for that input line, while
> writing a 0 to that same bit position clears and disables interrupts for
> that input line.
> 
> Int_ID0-Int_ID2 are accessible when Page 3 is selected. A respective bit
> when read as a 1 indicates that an edge of the polarity set in the
> corresponding polarity register was detected for the corresponding input
> line. Writing any value to this register clears all pending interrupts
> for the register.
> 
> Cc: Paul Demetrotion <pdemetrotion@winsystems.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Same here, gpio-regmap part looks good:

Reviewed-by: Michael Walle <michael@walle.cc>

-michael
