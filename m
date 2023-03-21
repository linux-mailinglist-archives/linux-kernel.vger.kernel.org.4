Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AA6C33B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCUOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:07:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC65C22C91;
        Tue, 21 Mar 2023 07:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E9DAB816A4;
        Tue, 21 Mar 2023 14:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E5AC433EF;
        Tue, 21 Mar 2023 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679407595;
        bh=0DAjlMi66OXkEkdTGqATRWU4fPPzde7nZPBSgSjlrvM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uHIK4ZDzrJRuQHL4/zcmwMKMGfx6dvwcws/wDy2sUSSdIWPyTu0W4QpiybjSqqRlK
         QBQOkVmwZEVNQEqjb+txk0DGMdP7GHZn3etowQBppIrmiJAecwwzvQdZKmRZOe0nXe
         W0dAS+vnzm83zkYwWTEA+TFuRZ83+2skzFNndbwBgnNeSnReO/Rl7XoR8wXM1krKE4
         InuvdKNvoNT20xuD8EtqlRoKTmBOfVJM1qnXjYi6h4LmSMvRsC+8OOCf4vkKL7B+Jn
         GsHs/N/KU18zUxpr1Buvmy1rVkqJCgv6WVXh0M5wFGxch5nE62AtYSktdT5fkOOSNO
         vtEkj5GU5bBpw==
Message-ID: <2f54ae85-f7b9-4666-cc05-6aa034028789@kernel.org>
Date:   Tue, 21 Mar 2023 16:06:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/9] interconnect: qcom: rpm: Add support for
 specifying channel num
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-2-815606092fff@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230228-topic-qos-v7-2-815606092fff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for the patch!

On 8.03.23 23:40, Konrad Dybcio wrote:
> Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
> one channel. This should be taken into account in bandwidth calcualtion,
> as we're supposed to feed msmbus with the per-channel bandwidth. Add
> support for specifying that and use it during bandwidth aggregation.
> 

This looks good, but do you have any follow-up patch to use this and set
the channels in some driver?

BR,
Georgi

> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
>   drivers/interconnect/qcom/icc-rpm.h | 2 ++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 35fd75ae70e3..27c4c6497994 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -317,6 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>   {
>   	struct icc_node *node;
>   	struct qcom_icc_node *qn;
> +	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>   	int i;
>   
>   	/* Initialise aggregate values */
> @@ -334,7 +335,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>   	list_for_each_entry(node, &provider->nodes, node_list) {
>   		qn = node->data;
>   		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> -			agg_avg[i] += qn->sum_avg[i];
> +			if (qn->channels)
> +				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
> +			else
> +				sum_avg[i] = qn->sum_avg[i];
> +			agg_avg[i] += sum_avg[i];
>   			agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
>   		}
>   	}
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 8ba1918d7997..8aed5400afda 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -66,6 +66,7 @@ struct qcom_icc_qos {
>    * @id: a unique node identifier
>    * @links: an array of nodes where we can go next while traversing
>    * @num_links: the total number of @links
> + * @channels: number of channels at this node (e.g. DDR channels)
>    * @buswidth: width of the interconnect between a node and the bus (bytes)
>    * @sum_avg: current sum aggregate value of all avg bw requests
>    * @max_peak: current max aggregate value of all peak bw requests
> @@ -78,6 +79,7 @@ struct qcom_icc_node {
>   	u16 id;
>   	const u16 *links;
>   	u16 num_links;
> +	u16 channels;
>   	u16 buswidth;
>   	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>   	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
> 

