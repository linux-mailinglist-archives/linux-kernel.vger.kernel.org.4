Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D1A5BEB06
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiITQVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiITQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:20:29 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373746E2D2;
        Tue, 20 Sep 2022 09:19:08 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KDepPC000541;
        Tue, 20 Sep 2022 18:18:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Fuzpo1KA9EIvuO1nutCFARCuxN7c93A8fo/K8BWKVew=;
 b=M1CQli7vwCwLhN5pNP82HDR2NS5W3gsGkUTVc4QXTsgvDroMBo2E9upVF2NU0s+MHpX9
 HK54VKgoiHjeBY2jjp9M2XJZNyAhrbpk5YuTYbncLGcUxIoubqKhO0EfzWGOHwI75GS4
 NEUb1jmgwk1nkl2clsoyMLF5ixBvicf1QjlgS9AHTKrrTFAQ4iTlXQ5WiwxZcPh4jEdk
 Osc1MZH7hF3oPx2TzCje0ksS2fq5+wuy8LUBNCf02wlQUEgPawx31Ns7pq3o5Zor/VI0
 1cbIUv83paRUKoeUzCaycvAf0jBMbze/rjg1yvWELQsEHs3M+3jlJxeHbud7Mxs6Zjlj Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jn6atts7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 18:18:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D2C6C10002A;
        Tue, 20 Sep 2022 18:18:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CDF1824B8A4;
        Tue, 20 Sep 2022 18:18:52 +0200 (CEST)
Received: from [10.201.22.245] (10.75.127.45) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 18:18:49 +0200
Message-ID: <954af8b0-7bc2-b0ea-f5ec-8e25e24b7d95@foss.st.com>
Date:   Tue, 20 Sep 2022 18:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH] rpmsg: char: Avoid double destroy of default endpoint
To:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shengjiu.wang@gmail.com>
References: <1663310366-720-1-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
In-Reply-To: <1663310366-720-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shengjiu,

On 9/16/22 08:39, Shengjiu Wang wrote:
> The rpmsg_dev_remove() in rpmsg_core is the place for releasing
> this default endpoint.
> 
> So need to avoid destroying the default endpoint in
> rpmsg_chrdev_eptdev_destroy(), this should be the same as
> rpmsg_eptdev_release(). Otherwise there will be double destroy
> issue that ept->refcount report warning:
> 
> refcount_t: underflow; use-after-free.
> 
> Call trace:
>  refcount_warn_saturate+0xf8/0x150
>  virtio_rpmsg_destroy_ept+0xd4/0xec
>  rpmsg_dev_remove+0x60/0x70
> 
> Fixes: bea9b79c2d10 ("rpmsg: char: Add possibility to use default endpoint of the rpmsg device")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 0850ae34fb88..562d545ac0d3 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -76,7 +76,8 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
>  
>  	mutex_lock(&eptdev->ept_lock);
>  	if (eptdev->ept) {
> -		rpmsg_destroy_ept(eptdev->ept);
> +		if (!eptdev->default_ept)
> +			rpmsg_destroy_ept(eptdev->ept);
>  		eptdev->ept = NULL;
>  	}
>  	mutex_unlock(&eptdev->ept_lock);


Good catch!
I tried to reproduce it but without success. Do you set a specific config?

Concerning the patch:

Could you add a comment, to help to understand the condition?
something like "The default endpoint is released by the rpmsg core"

With that Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Thanks,
Arnaud
