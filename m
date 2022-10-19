Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B026053DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJSXXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJSXXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:23:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1A8157F4F;
        Wed, 19 Oct 2022 16:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7A78B824C3;
        Wed, 19 Oct 2022 23:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7936C433D6;
        Wed, 19 Oct 2022 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666221783;
        bh=L7blzLZIgHff1Om+qct1zigc8Vm22Xe7ad6V/1IyyPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtQfXaXfd/XpEUvcMlHwpHzcH+QLOp5Qs7PIIZ2KiEdJKG14466nMjqjYxuux5vmg
         QaxAKq1J3Nei+GDXlmXljNAy/OYl10SwRs/2UjUcDH+2I+zZjw4NPRTiXJK5OUWj6/
         2QhPG/HG5Qf1oOivrZ5N7k6bRsDJKdCnHjXwQT2KD0hAQg8hvDb3XXa7WAQOIhg3A7
         aQmPfJ3RfIu6w8DzCoRw0NVjhsZ5FHKjbGqKNQK2bgGD8E4D+rdNmM7TOfMhYj/Mce
         ZwBWxdWO6wMSKzQQNnynK8EjSd4dV3gsapemRTCOSIwKRO6cJF4nd1OQdITHYDA9Py
         Im8gR91pbDkcA==
Date:   Wed, 19 Oct 2022 18:23:00 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [RESEND PATCH v2 5/5] firmware: qcom: scm: Add wait-queue
 handling logic
Message-ID: <20221019232300.pw4cpbzlvputury2@builder.lan>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
 <1661898311-30126-6-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1661898311-30126-6-git-send-email-quic_gurus@quicinc.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 03:25:11PM -0700, Guru Das Srinagesh wrote:
> Add logic to handle QCOM_SCM_WAITQ_SLEEP or QCOM_SCM_WAITQ_WAKE return
> codes.
> 
> Scenario 1: Requests made by 2 different VMs:
> 
>   VM_1                     VM_2                            Firmware
>     │                        │                                 │
>     │                        │                                 │
>     │                        │                                 │
>     │                        │                                 │
>     │      REQUEST_1         │                                 │
>     ├────────────────────────┼─────────────────────────────────┤
>     │                        │                                 │
>     │                        │                              ┌──┼──┐
>     │                        │                              │  │  │
>     │                        │     REQUEST_2                │  │  │
>     │                        ├──────────────────────────────┼──┤  │
>     │                        │                              │  │  │Resource
>     │                        │                              │  │  │is busy
>     │                        │       {WQ_SLEEP}             │  │  │
>     │                        │◄─────────────────────────────┼──┤  │
>     │                        │  wq_ctx, smc_call_ctx        │  │  │
>     │                        │                              └──┼──┘
>     │   REQUEST_1 COMPLETE   │                                 │
>     │◄───────────────────────┼─────────────────────────────────┤
>     │                        │                                 │
>     │                        │         IRQ                     │
>     │                        │◄─-------------------------------│
>     │                        │                                 │
>     │                        │      get_wq_ctx()               │
>     │                        ├────────────────────────────────►│
>     │                        │                                 │
>     │                        │                                 │
>     │                        │◄────────────────────────────────┤
>     │                        │   wq_ctx, flags, and            │
>     │                        │        more_pending             │
>     │                        │                                 │
>     │                        │                                 │
>     │                        │ wq_resume(smc_call_ctx)         │
>     │                        ├────────────────────────────────►│
>     │                        │                                 │
>     │                        │                                 │
>     │                        │      REQUEST_2 COMPLETE         │
>     │                        │◄────────────────────────────────┤
>     │                        │                                 │
>     │                        │                                 │
> 
> Scenario 2: Two Requests coming in from same VM:
> 
>   VM_1                                                     Firmware
>     │                                                          │
>     │                                                          │
>     │                                                          │
>     │                                                          │
>     │      REQUEST_1                                           │
>     ├──────────────────────────────────────────────────────────┤
>     │                                                          │
>     │                                                     ┌────┼───┐
>     │                                                     │    │   │
>     │                                                     │    │   │
>     │                                                     │    │   │
>     │      REQUEST_2                                      │    │   │
>     ├─────────────────────────────────────────────────────┼───►│   │
>     │                                                     │    │   │Resource
>     │                                                     │    │   │is busy
>     │      {WQ_SLEEP}                                     │    │   │
>     │◄────────────────────────────────────────────────────┼────┤   │
>     │      wq_ctx, req2_smc_call_ctx                      │    │   │
>     │                                                     │    │   │
>     │                                                     └────┼───┘
>     │                                                          │
>     │      {WQ_WAKE}                                           │
>     │◄─────────────────────────────────────────────────────────┤
>     │      wq_ctx, req1_smc_call_ctx, flags                    │
>     │                                                          │
>     │                                                          │
>     │      wq_wake_ack(req1_smc_call_ctx)                      │
>     ├─────────────────────────────────────────────────────────►│
>     │                                                          │
>     │      REQUEST_1 COMPLETE                                  │
>     │◄─────────────────────────────────────────────────────────┤
>     │                                                          │
>     │                                                          │
>     │      wq_resume(req_2_smc_call_ctx)                       │
>     ├─────────────────────────────────────────────────────────►│
>     │                                                          │
>     │      REQUEST_2 COMPLETE                                  │
>     │◄─────────────────────────────────────────────────────────┤
>     │                                                          │
> 
> With the exception of get_wq_ctx(), the other two newly-introduced SMC
> calls, wq_ack() and wq_resume() can themselves return WQ_SLEEP (these
> nested rounds of WQ_SLEEP are not shown in the above diagram for the
> sake of simplicity). Therefore, introduce a new do-while loop to handle
> multiple WQ_SLEEP return values for the same parent SCM call.
> 
> Request Completion in the above diagram refers to either a success
> return value (zero) or error (and not SMC_WAITQ_SLEEP or
> SMC_WAITQ_WAKE).
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  drivers/firmware/qcom_scm-smc.c | 76 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 69 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
> index 4150da1..09cca48 100644
> --- a/drivers/firmware/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom_scm-smc.c
> @@ -53,6 +53,9 @@ static void __scm_smc_do_quirk(const struct arm_smccc_args *smc,
>  	} while (res->a0 == QCOM_SCM_INTERRUPTED);
>  }
>  
> +#define IS_WAITQ_SLEEP_OR_WAKE(res) \
> +	(res->a0 == QCOM_SCM_WAITQ_SLEEP || res->a0 == QCOM_SCM_WAITQ_WAKE)
> +
>  static void fill_wq_resume_args(struct arm_smccc_args *resume, u32 smc_call_ctx)
>  {
>  	memset(resume->args, 0, ARRAY_SIZE(resume->args));
> @@ -109,25 +112,77 @@ int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending)
>  	return 0;
>  }
>  
> -static void __scm_smc_do(const struct arm_smccc_args *smc,
> +static int scm_smc_do_quirk(struct device *dev, struct arm_smccc_args *smc,

There was a reasoning behind using the somewhat cryptic name
__scm_smc_do_quirk(), but wrapping it in a function with the same name
without the underscores is probably just going to confuse the reader
even more.

How about __scm_smc_do_quirk_handle_waitq() ?

> +			    struct arm_smccc_res *res)
> +{
> +	struct completion *wq = NULL;
> +	struct qcom_scm *qscm;
> +	u32 wq_ctx, smc_call_ctx, flags;
> +
> +	do {
> +		__scm_smc_do_quirk(smc, res);
> +
> +		if (IS_WAITQ_SLEEP_OR_WAKE(res)) {
> +			wq_ctx = res->a1;
> +			smc_call_ctx = res->a2;
> +			flags = res->a3;
> +
> +			if (!dev)
> +				return -EPROBE_DEFER;
> +
> +			qscm = dev_get_drvdata(dev);
> +			wq = qcom_scm_lookup_wq(qscm, wq_ctx);
> +			if (IS_ERR_OR_NULL(wq)) {
> +				pr_err("No waitqueue found for wq_ctx %d: %ld\n",

You have dev here, use dev_err()

> +						wq_ctx, PTR_ERR(wq));
> +				return PTR_ERR(wq);
> +			}
> +
> +			if (res->a0 == QCOM_SCM_WAITQ_SLEEP) {
> +				wait_for_completion(wq);
> +				fill_wq_resume_args(smc, smc_call_ctx);
> +				wq = NULL;
> +				continue;

This is the last statement before the condition is evaluated again, so
this continue should be a nop.

> +			} else {

The use of IS_WAITQ_SLEEP_OR_WAKE() hides the fact that a0 can only be
QCOM_SCM_WAITQ_WAKE here. I think you should make it explicit with:
			} else if (res->a0 == QCOM_SCM_WAITQ_WAKE) {

> +				fill_wq_wake_ack_args(smc, smc_call_ctx);
> +				continue;
> +			}
> +		} else if (!res->a0 || (long)res->a0 < 0) {
> +			/*
> +			 * Success, or error.
> +			 * wq will be set only if a prior WAKE happened.
> +			 * Its value will be the one from the prior WAKE.
> +			 */
> +			if (wq)
> +				scm_waitq_flag_handler(wq, flags);
> +			break;

The next thing that will happen is that the condition in the loop will
be evaluated and the loop will be broken. So you don't need this break.


It's also not entirely obvious that the first half of this loop will
acquire the wq and always loop, so that at some point the second part
will run to wake up the wq - right before leaving the loop.

I think it would be easier to reason about if you move this chunk below
the loop.

do {
	__scm_smc_do_quirk();
	if (IS_WAITQ_SLEEP_OR_WAKE()) {
		...
	}
while (IS_WAITQ_SLEEP_OR_WAKE());

if (wq)
	scm_waitq_flag_handler(wq, flags);

return 0;



If you also make sure to only set "wq" in the QCOM_SCM_WAITQ_WAKE case
you will make it clearer that the if (!res->a0) is there to capture the
case where we acked the wakeup and the ack was successful.


One question though, if the wakeup ack fails, should we still wake up
the requested wq? Perhaps it doesn't matter? As the woken up wq would
just face a QCOM_SCM_WAITQ_SLEEP again?

> +		}
> +	} while (IS_WAITQ_SLEEP_OR_WAKE(res));
> +
> +	return 0;
> +}
> +
> +static int __scm_smc_do(struct device *dev, struct arm_smccc_args *smc,
>  			 struct arm_smccc_res *res, bool atomic)
>  {
> -	int retry_count = 0;
> +	int ret, retry_count = 0;
>  
>  	if (atomic) {
>  		__scm_smc_do_quirk(smc, res);
> -		return;
> +		return 0;
>  	}
>  
>  	do {
>  		if (!qcom_scm_allow_multicall)
>  			mutex_lock(&qcom_scm_lock);
>  
> -		__scm_smc_do_quirk(smc, res);
> +		ret = scm_smc_do_quirk(dev, smc, res);
>  
>  		if (!qcom_scm_allow_multicall)
>  			mutex_unlock(&qcom_scm_lock);
>  
> +		if (ret)
> +			return ret;
>  
>  		if (res->a0 == QCOM_SCM_V2_EBUSY) {
>  			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> @@ -135,6 +190,8 @@ static void __scm_smc_do(const struct arm_smccc_args *smc,
>  			msleep(QCOM_SCM_EBUSY_WAIT_MS);
>  		}
>  	}  while (res->a0 == QCOM_SCM_V2_EBUSY);
> +
> +	return 0;
>  }
>  
>  
> @@ -143,7 +200,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>  		   struct qcom_scm_res *res, bool atomic)
>  {
>  	int arglen = desc->arginfo & 0xf;
> -	int i;
> +	int i, ret;
>  	dma_addr_t args_phys = 0;
>  	void *args_virt = NULL;
>  	size_t alloc_len;
> @@ -195,19 +252,24 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>  		smc.args[SCM_SMC_LAST_REG_IDX] = args_phys;
>  	}
>  
> -	__scm_smc_do(&smc, &smc_res, atomic);
> +	ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
> +	/* ret error check follows after args_virt cleanup*/
>  
>  	if (args_virt) {
>  		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
>  		kfree(args_virt);
>  	}
>  
> +	if (ret)
> +		return ret;
> +
>  	if (res) {
>  		res->result[0] = smc_res.a1;
>  		res->result[1] = smc_res.a2;
>  		res->result[2] = smc_res.a3;
>  	}
>  
> -	return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
> +	ret = (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;

This is not necessary, right?

Regards,
Bjorn

>  
> +	return ret;
>  }
> -- 
> 2.7.4
> 
