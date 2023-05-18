Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8470857E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjERP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjERP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B0DE;
        Thu, 18 May 2023 08:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 189806507B;
        Thu, 18 May 2023 15:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0DBC433EF;
        Thu, 18 May 2023 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684425592;
        bh=YJow9DKK6sYbXrt3g/qCrb9h9XLtdcjJL3vgP2v0PY0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZSDmHWJrTkno0Kg5ZwRJgHbfwqJspdrdKCka01Hroqx5weZs77R6oMbsM1acwLlh5
         gMqOIQjz/V2AxpUoD/MD3QZR377vGS3Oy3iSBYgLJ3LSohn5NXmdaYHmCuHuzypuSQ
         SZId9ypZ3FuV7dpYw8BIWIPhPyAUchslVhsV6zgNNw/ZMNwrBcu2CaNeiina4B0aVM
         Kp7FeyslFjwjN8BHGN5oeq6/uh/lv1p0GSgkFWnKo83595ZPDlMV/56SbtbNgXjeO6
         jesNDrr/bsEzQ30UW4ocLeWr7Gk+uJjviw3ijwt6m7K3ZQ+zAOhh9O3f/TW9g3kzP7
         /DZ6Evuys5fGA==
Message-ID: <b1990459-4780-b139-9656-f00f34a2a375@kernel.org>
Date:   Thu, 18 May 2023 18:59:46 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v8 5/8] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
 <20230228-topic-qos-v8-5-ee696a2c15a9@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230228-topic-qos-v8-5-ee696a2c15a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,
Thanks for re-spinning the patches!

On 7.04.23 23:14, Konrad Dybcio wrote:
> Some (but not all) providers (or their specific nodes) require
> specific clocks to be turned on before they can be accessed. Failure
> to ensure that results in a seemingly random system crash (which
> would usually happen at boot with the interconnect driver built-in),
> resulting in the platform not booting up properly.
> 
> Limit the number of bus_clocks to 2 (which is the maximum that SMD
> RPM interconnect supports anyway) and handle non-scaling clocks
> separately. Update MSM8996 and SDM660 drivers to make sure they do
> not regress with this change.
> 
> This unfortunately has to be done in one patch to prevent either
> compile errors or broken bisect.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 40 ++++++++++++++++++++++++++++---------
>   drivers/interconnect/qcom/icc-rpm.h | 14 +++++++++++--
>   drivers/interconnect/qcom/msm8996.c | 22 +++++++++-----------
>   drivers/interconnect/qcom/sdm660.c  | 16 ++++++---------
>   4 files changed, 58 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index d79e508cb717..419b2122bebd 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -424,21 +424,20 @@ int qnoc_probe(struct platform_device *pdev)
>   	qnodes = desc->nodes;
>   	num_nodes = desc->num_nodes;
>   
> -	if (desc->num_bus_clocks) {
> -		cds = desc->bus_clocks;
> -		cd_num = desc->num_bus_clocks;
> +	if (desc->num_intf_clocks) {
> +		cds = desc->intf_clocks;
> +		cd_num = desc->num_intf_clocks;
>   	} else {
> -		cds = bus_clocks;
> -		cd_num = ARRAY_SIZE(bus_clocks);
> +		/* 0 intf clocks is perfectly fine */
> +		cd_num = 0;
>   	}
>   
> -	qp = devm_kzalloc(dev, struct_size(qp, bus_clks, cd_num), GFP_KERNEL);
> +	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
>   	if (!qp)
>   		return -ENOMEM;
>   
> -	qp->bus_clk_rate = devm_kcalloc(dev, cd_num, sizeof(*qp->bus_clk_rate),
> -					GFP_KERNEL);
> -	if (!qp->bus_clk_rate)
> +	qp->intf_clks = devm_kzalloc(dev, sizeof(qp->intf_clks), GFP_KERNEL);
> +	if (!qp->intf_clks)
>   		return -ENOMEM;
>   
>   	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
> @@ -446,6 +445,18 @@ int qnoc_probe(struct platform_device *pdev)
>   	if (!data)
>   		return -ENOMEM;
>   
> +	qp->num_intf_clks = cd_num;
> +	for (i = 0; i < cd_num; i++)
> +		qp->intf_clks[i].id = cds[i];

Sadly, this is introducing a superfluous compiler warning, which is a bit annoying.
Could you please add some initialization to silence it and re-send just this patch.

drivers/interconnect/qcom/icc-rpm.c: In function ‘qnoc_probe’:
drivers/interconnect/qcom/icc-rpm.c:450:28: warning: ‘cds’ may be used uninitialized in this 
function [-Wmaybe-uninitialized]
   450 |   qp->intf_clks[i].id = cds[i];
       |                         ~~~^~~

BR,
Georgi
