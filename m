Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4034A6C7F87
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCXOIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:08:32 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5191030F3;
        Fri, 24 Mar 2023 07:08:29 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4D4D65FD31;
        Fri, 24 Mar 2023 17:08:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679666906;
        bh=GIGUes9grLnNpOjpVxn5S3xYCykF4Trt90IBGzePe04=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=lRJky/Xg2KQO+O20y0BWvrEDEx+EJmS6r1yMCY51bcRaLCQWyU8xUryY/LahRM/8k
         VRweX6RTh6eYUQWdfUN54YNfkG+9lWHJisJ/eTwFaVb5LPaaxImpmPfhSSh+xKW+A5
         tIDo3Iin2Ckgw5T6f/TOy3X5FQJIlRpXrtlSb+fuZ7GNKpIc4Ien0GBXGZm/r1D4+P
         x1I0CcqvwJtTaI7JMQ2eLkNgT/7I5h+Qw0F7XVA3Vpot5OlWQcJtFxtihb6gq45dxG
         ddR9c7TVee6FScYbadJq5l+GkBHbMEOnT4uHWDqEhZl/IcxSXBQQdetVPv5DZ2Bi9D
         W1c2VRTLfShbw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 24 Mar 2023 17:08:26 +0300 (MSK)
Date:   Fri, 24 Mar 2023 17:08:25 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <jianxin.pan@amlogic.com>
CC:     <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <rockosov@gmail.com>
Subject: Re: [PATCH v2] firmware: meson_sm: populate platform devices from sm
 device tree data
Message-ID: <20230324140825.tnrufiqypfv2m3ze@CAB-WSD-L081021>
References: <20230324140141.6743-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230324140141.6743-1-ddrokosov@sberdevices.ru>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
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

Sorry, I've missed the changelog. Please find it below if any.

On Fri, Mar 24, 2023 at 05:01:41PM +0300, Dmitry Rokosov wrote:
> In some meson boards, secure monitor device has children, for example,
> power secure controller. By default, secure monitor isn't the bus in terms
> of device tree subsystem, so the of_platform initialization code doesn't
> populate its device tree data. As a result, secure monitor's children
> aren't probed at all.
> 
> Run the 'of_platform_populate()' routine manually to resolve such issues.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---

Changes v2 since v1 at [1]:
    - decline the device tree /firmware based solution
    - introduce devm_of_platform_populate() solution in the meson sm driver

Links:
    [1] https://lore.kernel.org/all/20230323185548.13731-1-ddrokosov@sberdevices.ru/

> ---
>  drivers/firmware/meson/meson_sm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 77aa5c6398aa..b79d0e316cb1 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -316,7 +316,7 @@ static int __init meson_sm_probe(struct platform_device *pdev)
>  	if (sysfs_create_group(&pdev->dev.kobj, &meson_sm_sysfs_attr_group))
>  		goto out_in_base;
>  
> -	return 0;
> +	return devm_of_platform_populate(dev);
>  
>  out_in_base:
>  	iounmap(fw->sm_shmem_in_base);
> -- 
> 2.36.0
> 

-- 
Thank you,
Dmitry
