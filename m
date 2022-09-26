Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BC65E97A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 03:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiIZBOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 21:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiIZBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 21:14:43 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22C6341;
        Sun, 25 Sep 2022 18:14:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQe-WH6_1664154876;
Received: from 30.240.121.51(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VQe-WH6_1664154876)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 09:14:37 +0800
Message-ID: <58b7485d-94fa-f333-ff14-9a4a1ce0284a@linux.alibaba.com>
Date:   Mon, 26 Sep 2022 09:14:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] drivers/perf: fix return value check in
 ali_drw_pmu_probe()
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20220924032127.313156-1-sunke32@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20220924032127.313156-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/24 AM11:21, Sun Ke 写道:
> In case of error, devm_ioremap_resource() returns ERR_PTR(),
> and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
> 
> Fixes: cf7b61073e45 ("drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC")
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Good catch, thank you for fixing.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Cheers,
Shuai



> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index 82729b874f09..a7689fecb49d 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -658,8 +658,8 @@ static int ali_drw_pmu_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	drw_pmu->cfg_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (!drw_pmu->cfg_base)
> -		return -ENOMEM;
> +	if (IS_ERR(drw_pmu->cfg_base))
> +		return PTR_ERR(drw_pmu->cfg_base);
>  
>  	name = devm_kasprintf(drw_pmu->dev, GFP_KERNEL, "ali_drw_%llx",
>  			      (u64) (res->start >> ALI_DRW_PMU_PA_SHIFT));
