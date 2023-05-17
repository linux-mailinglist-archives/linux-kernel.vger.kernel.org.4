Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110337063FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjEQJVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEQJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:21:11 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F14F9;
        Wed, 17 May 2023 02:21:07 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1B9505FD3C;
        Wed, 17 May 2023 12:21:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684315264;
        bh=RNtSPTsChdoOmWN48xhocv0ib4nuoqO6MTiNN7FBB/o=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Nc5YRgA71yBkDgwb1swll2Bqo0LbVF1YzbomjtfeSHSCx4FPphmDfhiMOPZy8FyS5
         KbXkICXgMmqghO865VFmrue4gotkqjXYyChVU6pc20cv/lh2wt2EmRFj7jsmR0KlJ1
         1VyipSLSHIHzJaQCnUt7PjfSV1Bwr6fO60OlfNDtAuJduFUQbLbjoLOPNtYSOjICyb
         6wYFFpBVRhFQ9WQ+UiRC1oW2cXFjWe5AIOmzG5GYiYqfD/ZJkqqzP1irY9ovJS6qob
         EQLdfDOfp3fRptD0GNcABuCM5eHXoeB3Extck6o4MNPgkGOOHXKt2+DuSEs0PLuUxB
         wc4jH6mOWuOiQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 17 May 2023 12:21:01 +0300 (MSK)
Date:   Wed, 17 May 2023 12:21:00 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     George Stark <gnstark@sberdevices.ru>, <jic23@kernel.org>,
        <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <andy.shevchenko@gmail.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
Message-ID: <20230517092100.wgnfuzdhgotlvv22@CAB-WSD-L081021>
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/17 06:42:00 #21327754
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

On Tue, May 16, 2023 at 09:08:26PM +0200, Martin Blumenstingl wrote:
> Hi George,
> 
> thank you for this patch!
> 
> On Mon, May 15, 2023 at 11:06 PM George Stark <gnstark@sberdevices.ru> wrote:
> >
> > From: George Stark <GNStark@sberdevices.ru>
> >
> > According to datasheets of supported meson SOCs
> > length of ADC_CLK_DIV field is 6 bits long
> I have a question about this sentence which doesn't affect this patch
> - it's only about managing expectations:
> Which SoC are you referring to?
> This divider is only relevant on older SoCs that predate GXBB (S905).
> To my knowledge all SoCs from GXBB onwards place the divider in the
> main or AO clock controller, so this bitmask is irrelevant there.
> 

We are currently working with the A1 SoC family, specifically the A113L
variant. According to the datasheet for the A113L, the ADC_CLK_DIV can
be found in the SAR_ADC_REG3 register as a 6-bit value located within
bits 15 through 10.

> > Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> > Signed-off-by: George Stark <GNStark@sberdevices.ru>
> Since my question above doesn't affect this patch:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

-- 
Thank you,
Dmitry
