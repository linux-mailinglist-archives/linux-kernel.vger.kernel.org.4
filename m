Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA663B9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiK2Gto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiK2Gte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:49:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4B537E3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 22:49:28 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bx10so8433329wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 22:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lmVjYexoERFRLmswRpO1q36g6awLl71zVxT5hQ15vcg=;
        b=ntk/FH9EbBtwfWvoMIOUfe9FsgBTlcvBWzIX7MVys87ufBo39LkWymGd0In84CowLn
         4zIscMlAYgrIwoSOF+t0A6A69nIVOwcJWtvqLCXVF+WvGJg6lhGrIeZHrVfLjjMi+DiQ
         FePqtvkUemS2vBWUoY5IqccNWo2ZWvZKSCjxRPxvwRRL8KzlFdWaOiu6Obii7UrRHdD+
         99DKQaDAmDwjsGwa3aCftxFFGOloKd6RJ9Fq0hTCNQtIkqFPShRiwzHkJhPhv2o+LkDb
         naMDb4HwaV4/wuRCq7L1tBrOqdE/S8gfkRyZ+BULYGMGvE08GSql13KsaLpwTZIFhchP
         Q3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmVjYexoERFRLmswRpO1q36g6awLl71zVxT5hQ15vcg=;
        b=CtWXgbGIad9poFz7656tTNSZVBYnZ4uCzxl8LnSd3X7oOC7JWEf7QF6Zy/NdA8QWN7
         eE5QPPXDEnjP59Vx5aMQiZ30++TOfS9AlcgY1lJH8yn1Mnt70xwrvHIkf5M42kI5cjJn
         nYqZUePVs+HQ3sbvv/LKNVrLUf7Gul9wvN1KjaGSKsKR+mOExK1KiY54h2WJk8KDaHWp
         RqIKnkBNl5/vsWYMIxdX2AhFXENRAD+OxPVQUe1OwzGQBvnkzjsSdEPX6x/6VCFNZIZy
         hQwFawLiT4X4hzm/gN2K61YzSicG+vm9UzvE8a5n+4TQPD2DUBbUy/seqdb3dOeOtZfU
         PGQQ==
X-Gm-Message-State: ANoB5plU1rZCmp4jHkhEzKwHsIMkZC21WUTwf6FX55YeJQNNNRFeXLRU
        EFxbDtlwX19/Mrf6dxNwoZGdBw==
X-Google-Smtp-Source: AA0mqf5dlqn3HBjFPq2nAmDpPb3yIbAlXddjpobxrmlhDjs9DMdVfaLD9GLImkT+T+Q53hDWdMOb6g==
X-Received: by 2002:adf:ee8a:0:b0:242:2d:c679 with SMTP id b10-20020adfee8a000000b00242002dc679mr14065313wro.369.1669704567012;
        Mon, 28 Nov 2022 22:49:27 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id i18-20020adfb652000000b0022e36c1113fsm6071466wre.13.2022.11.28.22.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 22:49:26 -0800 (PST)
Date:   Tue, 29 Nov 2022 07:49:25 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>, palmer@dabbelt.com,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: Re: [PATCH v2 12/12] riscv: defconfig: Enable the Allwinner D1
 platform and drivers
Message-ID: <20221129064925.kjjqrzmi3fm67akt@kamzik>
References: <20221125234656.47306-1-samuel@sholland.org>
 <20221125234656.47306-13-samuel@sholland.org>
 <Y4JBa52o4Yemv/uj@spud>
 <11740765.nUPlyArG6x@diego>
 <6aad3b63-498e-b13a-af49-b5af0d4e721e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6aad3b63-498e-b13a-af49-b5af0d4e721e@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 09:17:38PM +0000, Conor Dooley wrote:
> On 28/11/2022 21:11, Heiko Stübner wrote:
> > Am Samstag, 26. November 2022, 17:40:11 CET schrieb Conor Dooley:
> >> On Fri, Nov 25, 2022 at 05:46:56PM -0600, Samuel Holland wrote:
> >>> Now that several D1-based boards are supported, enable the platform in
> >>> our defconfig. Build in the drivers which are necessary to boot, such as
> >>> the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
> >>> and watchdog (which may be left enabled by the bootloader).
> >>
> >> All of that looks good.
> >>
> >>> Other common
> >>> onboard peripherals are enabled as modules.
> >>
> >> This I am not sure about though. I'll leave that to Palmer since I'm
> >> pretty sure it was him that said it, but I thought the plan was only
> >> turning on stuff required to boot to a console & things that are
> >> generally useful rather than enabling modules for everyone's "random"
> >> drivers. Palmer?
> > 
> > Isn't the defconfig meant as a starting point to get working systems
> > with minimal config effort? At least that was always the way to go on arm
> > so far :-) .
> > 
> > So having boot-required drivers built-in with the rest enabled as modules
> > for supported boards will allow people to boot theirs without headaches.
> > 
> > Disabling unneeded drivers if you're starved for storage space in a special
> > project is always easier than hunting down all the drivers to enable for a
> > specific board. 
> 
> I wouldn't mind being able to turn on all the PolarFire SoC stuff and
> yeah, that would be the way that arm64 does it. But I do recall hearing
> that I should not turn stuff on this way, when I initially tried to
> turn stuff on via selects, got a nack and asked if I could do this instead.
> 
> But it may be that I misremember, which is why I appealed to the Higher
> Powers for clarification :)

FWIW, I don't worry too much about modules in defconfig because I always
immediately apply a 'LSMOD=$PWD/L localmodconfig' to it, where the L
file is an lsmod output which only includes modules I need.

Thanks,
drew

> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
