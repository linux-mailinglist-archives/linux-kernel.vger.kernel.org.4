Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0256C7C99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjCXKaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjCXK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:29:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885C131
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:29:52 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O4jujo024321;
        Fri, 24 Mar 2023 05:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=H3Al6fxftb4sYSq8AeR6Z82rHyYTeUIs6TxuWGnCgFc=;
 b=M3mE0KyMQ/lsqGR0YBSbUf8ZbXwxCaYCljMErDy720aMJUtOXprdfYYcPOE4O/i8J/t2
 J6TW8AHVGLJ42a4bcXOha9xIaIcDvgJjC/vEDxuAR3ftHCGW5n/vePpOA2Y8UoB1GiM0
 foIvASGLFpCfK4FP+mlqc6B0k4Is3Ka8fo1glfAgtcBtpqekiUiNIPD3J4P3Shw2jBrV
 3AW4K5A4cD2SsXd8gRkUREtyV/az6FFGrUMKP/yizScwVZel3Ip2e4c0It4UD4KgTZcs
 pHJpRbs2mA2oXUAteTIkf45mKWvnT9Zv9KzffhoNl0Yre9KviStCgx+HoUvbeDmcmQkF IA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pgy7drtsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 05:29:17 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 24 Mar
 2023 05:29:16 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 24 Mar 2023 05:29:16 -0500
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1381CB06;
        Fri, 24 Mar 2023 10:29:16 +0000 (UTC)
Message-ID: <ceac5217-2fae-7d56-341f-6527ef3f538e@opensource.cirrus.com>
Date:   Fri, 24 Mar 2023 10:29:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: cs35l56: Fix an unsigned comparison which can never
 be negative
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <broonie@kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230324022303.121485-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230324022303.121485-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -kcnwc-THJq-5LmDGdDARbCNF7iboNym
X-Proofpoint-GUID: -kcnwc-THJq-5LmDGdDARbCNF7iboNym
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 02:23, Jiapeng Chong wrote:
> The variable 'rv' is defined as unsigned type, so the following if
> statement is invalid, we can modify the type of rv to int.
> if (rv < 0) {
> 	dev_err(cs35l56->dev, "irq: failed to get pm_runtime:
> 		%d\n", rv);
> 	goto err_unlock;
> }
> 
> ./sound/soc/codecs/cs35l56.c:333:5-7: WARNING: Unsigned expression compared with zero: rv < 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4599
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   sound/soc/codecs/cs35l56.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
> index 90fc79b5666d..d97b465f0d3c 100644
> --- a/sound/soc/codecs/cs35l56.c
> +++ b/sound/soc/codecs/cs35l56.c
> @@ -321,7 +321,9 @@ irqreturn_t cs35l56_irq(int irq, void *data)
>   	struct cs35l56_private *cs35l56 = data;
>   	unsigned int status1 = 0, status8 = 0, status20 = 0;
>   	unsigned int mask1, mask8, mask20;
> -	unsigned int rv, val;
> +	unsigned int val;
> +	int rv;
> +
>   	irqreturn_t ret = IRQ_NONE;
>   
>   	if (!cs35l56->init_done)

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
