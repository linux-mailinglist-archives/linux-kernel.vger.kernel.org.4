Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F385FD95C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJMMmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJMMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:42:17 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD03F335;
        Thu, 13 Oct 2022 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665664936; x=1697200936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DDxHuzFElSkhLvRoAX2SUbrk2+xaF4zvbaesNAF5MwY=;
  b=kT0YjtD/fiYkcFIug0FrNt6tiELzdb0UVNHqksML3rkSuqFTtD03gHkj
   FTcpGQOx0IFNCkiXykJ+wn1Dh0Gkyei9z5ehL7OoDHCH38rr1fE/5tXG5
   u1AWQtDvLBKBuhTP5PVpNBqBf6Cd6sr7KB+fN5S+bTD5kehmbtrkGG4sk
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Oct 2022 05:42:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 05:42:15 -0700
Received: from [10.216.35.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 05:42:12 -0700
Message-ID: <994c01b3-253c-9cc1-1a15-4f17226c2f7d@quicinc.com>
Date:   Thu, 13 Oct 2022 18:12:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] remoteproc: core: avoid duplicated rproc-virtio.[x]
 device
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <arnaud.pouliquen@foss.st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Peng Fan <peng.fan@nxp.com>
References: <20221013123214.750320-1-peng.fan@oss.nxp.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221013123214.750320-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/13/2022 6:02 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When there are multiple remoteproc cores(i.MX8QM has dual CM4), there
> will be duplicated platform device created. When 1st CM4 rproc got
> probed, rproc-virtio.0 was registered. Then 2nd CM4 rproc continue
> register rproc-virtio.o will report failure.
> 
> So use PLATFORM_DEVID_AUTO here. Then the kernel log will has such:
> rproc-virtio rproc-virtio.1.auto: registered virtio0 (type 7)
> 
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>    I think this issue will happen when more than one rproc, saying CM4 + DSP,
> or CM4 + CM4.
>    I thought to add a index to rproc, then use
>    'rproc->index * rvdev_data.index' as the id, but seems a bit complicated
>    compared with use PLATFORM_DEVID_AUTO.
> 
> 
>   drivers/remoteproc/remoteproc_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 8768cb64f560..03a26498e879 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -509,7 +509,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>   	rvdev_data.rsc_offset = offset;
>   	rvdev_data.rsc = rsc;
>   
> -	pdev = platform_device_register_data(dev, "rproc-virtio", rvdev_data.index, &rvdev_data,
> +	pdev = platform_device_register_data(dev, "rproc-virtio", PLATFORM_DEVID_AUTO, &rvdev_data,
>   					     sizeof(rvdev_data));
>   	if (IS_ERR(pdev)) {
>   		dev_err(dev, "failed to create rproc-virtio device\n");


Looks to be same as

https://lore.kernel.org/lkml/1665628087-20829-1-git-send-email-shengjiu.wang@nxp.com/

-Mukesh
