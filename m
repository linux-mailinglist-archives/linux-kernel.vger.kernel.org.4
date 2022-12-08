Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB6A6478A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLHWLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLHWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:11:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67EF63A2;
        Thu,  8 Dec 2022 14:11:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76BB7B82444;
        Thu,  8 Dec 2022 22:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D071C433EF;
        Thu,  8 Dec 2022 22:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670537488;
        bh=DB+0qMdKjtuxVBpAklpgw2thOEWwaefsw0lzLkWkLpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0bYfFmHU+daqGdraT30YlPTACU8OUdlbyHTuwfGhha5v0Qo6Zq0QIG2NQTDtRnvG
         RXeTHbL75PxC/I1GCruhkIkQEnYtwtyRtPATX0QKuvsmYF5Ty1k9bYHPzudFDMMaJ3
         6T+Vushs1vCbCbcg8Ajg5BPsR2XueNHigZw9eAwWlySt+3PpFDw1Vg4dzS+bPPa8nu
         6+T1Ws0FH/yXEGYhc7g8/VAr9N5DJ6Q9WEWOEh3g8/eva1EiTaxR+7PhPkWT5rCXje
         9aSGMkxcdMEEyXs8m5oZNalaxSN61901/Znvcjh3X3EC12hAQ25ClMR6XRr7U8mRgJ
         AnMy5QTjNqPdw==
Date:   Thu, 8 Dec 2022 16:11:25 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, robimarko@gmail.com,
        quic_gurus@quicinc.com, quic_rjendra@quicinc.com
Subject: Re: [PATCH V6 2/2] firmware: qcom: scm: Add wait-queue handling logic
Message-ID: <20221208221125.bflo7unhcrgfsgbr@builder.lan>
References: <20221208064031.2875-1-quic_sibis@quicinc.com>
 <20221208064031.2875-3-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208064031.2875-3-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 12:10:31PM +0530, Sibi Sankar wrote:
> diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
[..]
> +static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_args *waitq,
> +					   struct arm_smccc_res *res)
> +{
> +	struct qcom_scm *scm;
> +	struct completion *wq = NULL;
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
> +			scm = dev_get_drvdata(dev);
> +			wq = qcom_scm_lookup_wq(scm, wq_ctx);
> +			if (IS_ERR_OR_NULL(wq)) {
> +				dev_err(dev, "No waitqueue found for wq_ctx %d: %ld\n",
> +					wq_ctx, PTR_ERR(wq));
> +				return PTR_ERR(wq) ? : -EINVAL;
> +			}
> +
> +			wait_for_completion(wq);

I think it would be cleaner to push the lookup + wait_for_completion
into a function in qcom_scm.c. Then you don't need to pull the drvdata
and you have the wq handling grouped in one place.

> +			fill_wq_resume_args(&resume, smc_call_ctx);
> +			smc = &resume;
> +			wq = NULL;
> +		}
> +	} while (res->a0 == QCOM_SCM_WAITQ_SLEEP);
> +
> +	return 0;
> +}
[..]
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
[..]
> +struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx)
> +{
> +	int err;
> +	unsigned long flags;
> +	u32 wq_ctx_idr = wq_ctx;
> +	struct completion *wq = NULL;
> +
> +	spin_lock_irqsave(&scm->waitq.idr_lock, flags);
> +	wq = idr_find(&scm->waitq.idr, wq_ctx);
> +	if (wq)
> +		goto out;
> +
> +	wq = &scm->waitq.waitq_comp;

The idr here gives an impression of providing similar functionality as
in the previous post, but will actually always provide the same
completion. As such, if the firmware would start to use multiple wq_ctx
I believe this would should up as something fairly non-trivial to debug.

I think it's better to make this dead simple and assert that wq_ctx is 0
and just return the one and only completion.

> +
> +	err = idr_alloc_u32(&scm->waitq.idr, wq, &wq_ctx_idr,
> +			    U32_MAX, GFP_ATOMIC);

PS. Thinking about it further, imagine the firmware people deciding to
be funny and allocating the wq_ctx in a cyclic fashion. The idr will
consume all your ram after a while...

Regards,
Bjorn

> +	if (err < 0)
> +		wq = ERR_PTR(err);
> +
> +out:
> +	spin_unlock_irqrestore(&scm->waitq.idr_lock, flags);
> +	return wq;
> +}
