Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE56456EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiLGJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLGJ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:56:26 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E53723C;
        Wed,  7 Dec 2022 01:56:20 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1D29B5FD0F;
        Wed,  7 Dec 2022 12:56:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1670406978;
        bh=MeyZS1C097c7vm9u/U2p29/LpWIfrJPZFDkzyd4cMZo=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=OVvn+Ko0YW8OZUv6+1GPnEEcZgsg9LDpAzMe4Yc8hlfkjf010iENIt867fRrT5WPU
         JUWnvAjuqfzIZurCiYRBXyS0XKeuO7vjfrMRuNL95pih1DrPtyO9+uUilKet8xCDQ5
         3L1iHIPx7UhK0t6foLL4iFqrqIjojaaJ1RASOADnaAFOw1mX6pgxPfKB/aPMRBTS7w
         1/j20jOqaKTpuLr0k1bL4S7+nSsS1aIYdtaGLSNaimtUkASJa9f9mXdZn7nrq0JHfO
         b7SY7oMcr0IHPHtFSYIw4e7MKvdV9I+Pcwf0/hXIHgzT1w5DKXuO6Uhop+OGUFPKki
         55oCzG/UQW+sw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Dec 2022 12:56:14 +0300 (MSK)
Date:   Wed, 7 Dec 2022 12:56:14 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <ye.xingchen@zte.com.cn>
CC:     <andriy.shevchenko@linux.intel.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <u.kleine-koenig@pengutronix.de>,
        <petrm@nvidia.com>, <olteanv@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: bma180: Convert to use sysfs_emit_at() API
Message-ID: <20221207095614.z4gv3q76hfx47qs2@CAB-WSD-L081021>
References: <202212071003192805636@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202212071003192805636@zte.com.cn>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/07 07:54:00 #20676529
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 10:03:19AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

I think it would be better, if you provide one cover letter as 0/3 patch
and three nested real patches to each iio/accel driver which you want to
rework: adxl372, bma180, mma8452. Or fix all iio drivers (no only accel)
and send all of these changes as nested patches for one cover letter.

Please refer to https://www.kernel.org/doc/html/latest/process/submitting-patches.html

and use the following commands to generate such patches hierarchy:

$ git format-patch --cover-letter -o patches ...
$ git send-email \     
      --annotate \               
      --to="john.doe@kernel.org" \               
      --cc="linux-iio@vger.kernel.org" \
      --cc="linux-kernel@vger.kernel.org" \
      --smtp-debug 1 \                  
      patches/*

> ---
>  drivers/iio/accel/bma180.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index eb697eeb4301..9e3e5dfdded7 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -488,8 +488,7 @@ static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned int n,
>  	for (i = 0; i < n; i++) {
>  		if (!vals[i])
>  			continue;
> -		len += scnprintf(buf + len, PAGE_SIZE - len,
> -			micros ? "0.%06d " : "%d ", vals[i]);
> +		len += sysfs_emit_at(buf, len, micros ? "0.%06d " : "%d ", vals[i]);
>  	}
>  	buf[len - 1] = '\n';
> 
> -- 
> 2.25.1

-- 
Thank you,
Dmitry
