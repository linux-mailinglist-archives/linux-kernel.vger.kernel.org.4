Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21566A77AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCAXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCAXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:33:01 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C9C3866B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:32:58 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id m5so4978766uae.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FeuWO1CjmVd+hjiHrdfFptk3qAqxlXVOpLYxHpbPoMk=;
        b=WJnh5hlGci68HiRLyG79x3u4rovbsavBZHZuR8lMJCuQbybDL2liIrmKv/gzFSNTLF
         Mhk4fUTjpJVcxCw/2fiU3/xmdKCzxA+zINwPRhVGsy8dAgNJgQtg5j9TyKg2XU7OTh3j
         JQYLOdGR2ehMLg3r0WrSm1wbVfF9s5efcCpWPI9E2YKTrqCHyBFHzl1SOxaHE2k2vBYB
         C53K+XmXlc594gCMULLcpmwbxz3GlAt+9Nk3bs8ccrpIb2G0hQtLWGbACynAmihOzKYa
         CiG6L9qz1Ocdbo521fd3B6iCeYMW+PY9orV14/wBXt1iyOv7bo4LHCXMNhXcE0nhhb3b
         2BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FeuWO1CjmVd+hjiHrdfFptk3qAqxlXVOpLYxHpbPoMk=;
        b=Cv8CbKUAek7arvkZx+GRai6y69Fd3kIYTRxJhRsEhQ/cQfGBvWxXaRie9gJyHLYbnD
         dhHhieT5bK0NqsakD+OqZ+B7VSaodl5tVVShByqKwdssldKJqUUWu0DehHfVxhGSsp7y
         tYJt2nCpgQB2mhsvQxYVB5KmDxFQ9lt3jc71mrqVVFEJOuEQJKnmRmSdA/vFnDhNzoF7
         qr0dEtOBOYERZtrYJtH7wS2hzG30l/J0RuxSzoBLp/2df6MScYB8aHhXsYMvF/YgszQ6
         CNvE7z2riKyjB9jRkSweG8nT2YMfXE62tQTkBwbxU9xKFwVuUwPgKG3U/i9OpAoDeIcL
         4iDA==
X-Gm-Message-State: AO0yUKUyl3UBTSeUW9EjxVExnmqAGNaR2q2P/D4okilw6jyIpT1GDjxH
        bv7EkgL0sTwZDl+48brbApsY6kaM7Mi7ynphUHvZ+g==
X-Google-Smtp-Source: AK7set9+Szwg/MF+U5fSr1gGmRga2npeRJiCdtd+i0GE46DrxKPQzMKQxRY1Hf2q/WM0J9f0VNUjzxafeTFF7J3FXGA=
X-Received: by 2002:a05:6122:1210:b0:401:73f4:dfe with SMTP id
 v16-20020a056122121000b0040173f40dfemr4563991vkc.3.1677713577603; Wed, 01 Mar
 2023 15:32:57 -0800 (PST)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 1 Mar 2023 15:32:46 -0800
Message-ID: <CAJ+vNU2SC_Q3RWdeO9-mKDYC_TK8_vzefvGz_++O8StJer_h3Q@mail.gmail.com>
Subject: mmc: core: Disable card detect during shutdown
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Jan Glauber <jan.glauber@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've encountered a hang on shutdown on octeontx (CN8030 SoC, THUNDERX
architecture) that I bisected to commit 66c915d09b94 ("mmc: core:
Disable card detect during shutdown").

It looks like the OMP5 Pyra ran into this as well related to a
malfunctioning driver [1]

In the case of MMC_CAVIUM_THUNDERX the host controller supports
multiple slots each having their own CMD signal but shared clk/data
via the following dt:

mmc@1,4 {
        compatible = "cavium,thunder-8890-mmc";
        reg = <0xc00 0x00 0x00 0x00 0x00>;
        #address-cells = <0x01>;
        #size-cells = <0x00>;
        clocks = <0x0b>;

        /* eMMC */
        mmc-slot@0 {
                compatible = "mmc-slot";
                reg = <0>;
                vmmc-supply = <&mmc_supply_3v3>;
                max-frequency = <35000000>;
                no-1-8-v;
                bus-width = <8>;
                no-sdio;
                no-sd;
                mmc-ddr-3_3v;
                cap-mmc-highspeed;
        };

        /* microSD */
        mmc-slot@1 {
                compatible = "mmc-slot";
                reg = <1>;
                vmmc-supply = <&mmc_supply_3v3>;
                max-frequency = <35000000>;
                no-1-8-v;
                broken-cd;
                bus-width = <4>;
                cap-sd-highspeed;
        };
};

mmc_add_host is only called once for mmc0 and I can't see any printk
debugging added to __mmc_stop_host (maybe because serial/console has
been disabled by that point?).

It appears that what causes this hang is the 'broken-cd' which enables
the detect change polling on mmc1. I have the ability to flip the CMD
signal routing thus making mmc0 the microSD and mmc1 the eMMC and when
I do that there isn't an issue so I think what happens is in the case
where mmc polling is enabled on mmc1 but not mmc0 (as above) the
polling causes a hang after __mmc_stop_host() is called for mmc0.

Any ideas?

Best Regards,

Tim

[1] https://lore.kernel.org/all/55A0788B-03E8-457E-B093-40FD93F1B9F3@goldelico.com/
