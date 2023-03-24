Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065566C7FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjCXONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjCXONt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:13:49 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC61D515;
        Fri, 24 Mar 2023 07:13:43 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 881A55FD34;
        Fri, 24 Mar 2023 17:13:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679667221;
        bh=B7CmNMAJdYjHdEvEWYvmv46K1UaDZlTyHHFzSrMmmy8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=fcTCQhToIJaeKCoTNwHH9E+n1GtpHIciXhbS0m6Toks9D2HKRlseuyhdMo9QAnics
         MgQfEZ7+knMATbnanZL17d9guEpYBJL+RZeMhh+5gBpMFarNcy9ElwmBIEKSWbuUdA
         O7cveLmtgjNhT85Bwk9PHS/LrVc7oyuvU3cjdCo/UoHSaY8FcVT+Lr4m1qqfqhnihe
         AJ36EV+qN8dLgCp3qcyQy5QDwWSgCuYInaeAPin6Ip90/Oa3ChoKi4+qAdCQWAImPN
         uEmYjB1YA1fky7DcPYKwkUB+Ec3LyNWreyrnHPuh3OW38R4ZOt9adu33R9FTq9NaGk
         YvHE+/R6MiT4w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 24 Mar 2023 17:13:41 +0300 (MSK)
Date:   Fri, 24 Mar 2023 17:13:40 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>
CC:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jianxin.pan@amlogic.com>,
        <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <rockosov@gmail.com>
Subject: Re: [PATCH v2] firmware: meson_sm: populate platform devices from sm
 device tree data
Message-ID: <20230324141340.5dkuqip5zbuwjv3x@CAB-WSD-L081021>
References: <20230324140141.6743-1-ddrokosov@sberdevices.ru>
 <f1088121-02c7-86da-d603-7c2015030b0e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f1088121-02c7-86da-d603-7c2015030b0e@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/24 06:52:00 #21002836
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 03:05:53PM +0100, neil.armstrong@linaro.org wrote:
> On 24/03/2023 15:01, Dmitry Rokosov wrote:
> > In some meson boards, secure monitor device has children, for example,
> > power secure controller. By default, secure monitor isn't the bus in terms
> > of device tree subsystem, so the of_platform initialization code doesn't
> > populate its device tree data. As a result, secure monitor's children
> > aren't probed at all.
> > 
> > Run the 'of_platform_populate()' routine manually to resolve such issues.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >   drivers/firmware/meson/meson_sm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> > index 77aa5c6398aa..b79d0e316cb1 100644
> > --- a/drivers/firmware/meson/meson_sm.c
> > +++ b/drivers/firmware/meson/meson_sm.c
> > @@ -316,7 +316,7 @@ static int __init meson_sm_probe(struct platform_device *pdev)
> >   	if (sysfs_create_group(&pdev->dev.kobj, &meson_sm_sysfs_attr_group))
> >   		goto out_in_base;
> > -	return 0;
> > +	return devm_of_platform_populate(dev);
> 
> You should check return and jump to out_in_base on error instead.
> 
> Neil
> 

Ah, exactly. There is one direct non-devm ioremap above. I hurried up,
sorry.

> >   out_in_base:
> >   	iounmap(fw->sm_shmem_in_base);
> 

-- 
Thank you,
Dmitry
