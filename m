Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4274365CF85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjADJ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjADJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:27:26 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E518712AA5;
        Wed,  4 Jan 2023 01:27:24 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3047iuVw032302;
        Wed, 4 Jan 2023 10:27:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=6xh5pAXEYT99LT/t8U9ik3ip5kLuSrEFuQdju6O96Pg=;
 b=AxgBjJx7JqFS7fLwbKQjc9Mq3oEY7Cc8g2UUspDl7JiuiaME8812BVELFoVMj+MpzIHe
 PR98xQ/5+HjWiecmrXsAna8OJvs3aYq4JLnCBLqYcdfNgsvd5KUS+GNUdBXJ2WqoAYSh
 wfZQq94TQX+2OxEyzDu8dLLVn3mPn3Xmofy7nTl2HRHl0lf7YYzdrolpGLzDdEKnUR6R
 Holcf2GyGn//u7++ADvFgQjBeoB6yicMcvcQDbtyHFzjeCGL0hVOVM55cBETcXqEgCwW
 BzUkQl2T6Mx+aLbgBFOBgku/oFkfIqtPM64CL5M/h8Fv3CFtlwi5gctjcUb9q6HMKPdX jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtcupt4tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 10:27:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D50C710002A;
        Wed,  4 Jan 2023 10:27:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BAD0F21512C;
        Wed,  4 Jan 2023 10:27:14 +0100 (CET)
Received: from [10.129.166.172] (10.129.166.172) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 4 Jan
 2023 10:27:14 +0100
Message-ID: <b2ad42cb-fe09-73f5-8d7d-ac4f22817bac@foss.st.com>
Date:   Wed, 4 Jan 2023 10:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/1] media: i2c: st-vgxy61: Use asm intead of
 asm-generic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230103145219.40226-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <20230103145219.40226-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.129.166.172]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_05,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for your patch.

On 1/3/23 15:52, Andy Shevchenko wrote:
> There is no point to specify asm-generic for the unaligned.h.
> Drop the 'generic' suffix and move the inclusion to be after
> the non-media linux/* ones.
> 
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/i2c/st-vgxy61.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/st-vgxy61.c b/drivers/media/i2c/st-vgxy61.c
> index 826baf4e064d..5dcabee6677d 100644
> --- a/drivers/media/i2c/st-vgxy61.c
> +++ b/drivers/media/i2c/st-vgxy61.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2022 STMicroelectronics SA
>   */
>  
> -#include <asm-generic/unaligned.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> @@ -15,6 +14,9 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +

Any particular reason not to keep the alphabetical sort ?

>  #include <media/mipi-csi2.h>
>  #include <media/v4l2-async.h>
>  #include <media/v4l2-ctrls.h>

-- 
Regards,

Benjamin
