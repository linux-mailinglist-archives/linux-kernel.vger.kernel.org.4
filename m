Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBA6647CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjAJRzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjAJRyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:54:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005E06ECAF;
        Tue, 10 Jan 2023 09:54:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F609B818EB;
        Tue, 10 Jan 2023 17:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EECC433D2;
        Tue, 10 Jan 2023 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673373280;
        bh=qmNUGuo/b0UqRA+8ZzfjsJz3OHO/rP4/69lPal4OxRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1i43UfqHxKz2yzK+hQJqNbxJktuF3a2owbDWM4c2lsedU03mvPuMxV20GL/SXXHN
         XRR7YELJNMHbpT0wz6mfkOFrzsE9YuI1GrQT94YAqs775sTVf+kwFMyHjZcISMHJNX
         VzAv8Xw8aZeg+cP6NwUA7lr+JCyWcnFXT+pXbCci8mlgv41xdVTIbCtu8xHcwxLLc0
         Y6NmE5fFUs2YPPjHie7UXfphxv63KtfU3DTop5S6wDbmlZH4UWQIQyn95NTShjSlFS
         f5j4Ovtg/tnOJxvoYSegJijuk+/OhWJ8iRasA2bJgKULHKeBfzYZkEP4eWHdSZ8Y4R
         Bu+zRp7In1YTQ==
Date:   Tue, 10 Jan 2023 11:54:37 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        robimarko@gmail.com
Subject: Re: [PATCH V7 2/2] firmware: qcom: scm: Add wait-queue handling logic
Message-ID: <20230110175437.pfnhn3zdlzxnymts@builder.lan>
References: <20230110063745.16739-1-quic_sibis@quicinc.com>
 <20230110063745.16739-3-quic_sibis@quicinc.com>
 <20230110081410.GB2082@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110081410.GB2082@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:14:11AM -0800, Guru Das Srinagesh wrote:
> On Jan 10 2023 12:07, Sibi Sankar wrote:
> 
> ...
> 
> > +static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_args *waitq,
> > +					   struct arm_smccc_res *res)
> > +{
> > +	int ret;
> > +	struct arm_smccc_args resume;
> > +	u32 wq_ctx, smc_call_ctx, flags;
> > +	struct arm_smccc_args *smc = waitq;
> > +
> > +	do {
> > +		__scm_smc_do_quirk(smc, res);
> > +
> > +		if (res->a0 == QCOM_SCM_WAITQ_SLEEP) {
> > +			wq_ctx = res->a1;
> > +			smc_call_ctx = res->a2;
> > +			flags = res->a3;
> > +
> > +			if (!dev)
> > +				return -EPROBE_DEFER;
> > +
> > +			ret = qcom_scm_lookup_completion(wq_ctx);
> 
> I see that this function has been created in response to Bjorn's comment [1]
> about avoiding the dev_get_drvdata() call, but I would prefer to not use this
> function as it hides the fact that the wait_for_completion() is occurring here.
> 

My reasoning here is that I don't want the waiting for the completion
that happen in one part of the driver and the completion happening in a
completely different one.

> Knowing where the waiting is happening is useful not just for understanding
> code flow but also for debugging issues in the future.
> 

Absolutely agree, this should be named to make that obvious to the
reader.

> ...
> 
> > +static struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx)
> > +{
> 
> This function is called qcom_scm_lookup_wq() but there is no looking up
> occurring here. Could this comment be added for context?
> 
> /* FW currently only supports a single wq_ctx (zero).
>  * TODO: Update this logic to include dynamic allocation and lookup of
>  * completion structs when FW supports more wq_ctx values.
>  */
> 

Agree.

Regards,
Bjorn

> > +	/* assert wq_ctx is zero */
> > +	if (wq_ctx != 0) {
> > +		dev_err(scm->dev, "No waitqueue found for wq_ctx %d\n", wq_ctx);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	return &scm->waitq_comp;
> > +}
> > +
> ...
> 
> [1] https://lore.kernel.org/lkml/20221208221125.bflo7unhcrgfsgbr@builder.lan/
