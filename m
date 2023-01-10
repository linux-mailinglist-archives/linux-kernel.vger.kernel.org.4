Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E873663AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjAJIO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbjAJIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:14:16 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9501664CC;
        Tue, 10 Jan 2023 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673338454; x=1704874454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BvmrsO2wFPW4UkzHnUm2F4oYnGhEQj0M0Tj+WlrTJ2s=;
  b=h/rucVaSrBb/5fcqa3i1Yp4Yf+3NSxhqtaD8Rl4+3aGSlHDc+/Sv45Id
   QqucjQH19u43sws7AA/d0mC0GpbXpTZf8UXhz0Q6/T4uRHArlP7DcsM80
   IS2F7JdIy7PaK4bs4WHAZCs7qtU41un35ZhZog7tlbDeS81J9RHkRBwpS
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jan 2023 00:14:14 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 00:14:13 -0800
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 00:14:12 -0800
Date:   Tue, 10 Jan 2023 00:14:11 -0800
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
CC:     <andersson@kernel.org>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>
Subject: Re: [PATCH V7 2/2] firmware: qcom: scm: Add wait-queue handling logic
Message-ID: <20230110081410.GB2082@quicinc.com>
References: <20230110063745.16739-1-quic_sibis@quicinc.com>
 <20230110063745.16739-3-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230110063745.16739-3-quic_sibis@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 10 2023 12:07, Sibi Sankar wrote:

...

> +static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_args *waitq,
> +					   struct arm_smccc_res *res)
> +{
> +	int ret;
> +	struct arm_smccc_args resume;
> +	u32 wq_ctx, smc_call_ctx, flags;
> +	struct arm_smccc_args *smc = waitq;
> +
> +	do {
> +		__scm_smc_do_quirk(smc, res);
> +
> +		if (res->a0 == QCOM_SCM_WAITQ_SLEEP) {
> +			wq_ctx = res->a1;
> +			smc_call_ctx = res->a2;
> +			flags = res->a3;
> +
> +			if (!dev)
> +				return -EPROBE_DEFER;
> +
> +			ret = qcom_scm_lookup_completion(wq_ctx);

I see that this function has been created in response to Bjorn's comment [1]
about avoiding the dev_get_drvdata() call, but I would prefer to not use this
function as it hides the fact that the wait_for_completion() is occurring here.

Knowing where the waiting is happening is useful not just for understanding
code flow but also for debugging issues in the future.

...

> +static struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx)
> +{

This function is called qcom_scm_lookup_wq() but there is no looking up
occurring here. Could this comment be added for context?

/* FW currently only supports a single wq_ctx (zero).
 * TODO: Update this logic to include dynamic allocation and lookup of
 * completion structs when FW supports more wq_ctx values.
 */

> +	/* assert wq_ctx is zero */
> +	if (wq_ctx != 0) {
> +		dev_err(scm->dev, "No waitqueue found for wq_ctx %d\n", wq_ctx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return &scm->waitq_comp;
> +}
> +
...

[1] https://lore.kernel.org/lkml/20221208221125.bflo7unhcrgfsgbr@builder.lan/
