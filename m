Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA7560537C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJSWyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJSWxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:53:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E61C4913;
        Wed, 19 Oct 2022 15:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74147B82613;
        Wed, 19 Oct 2022 22:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7092AC433D6;
        Wed, 19 Oct 2022 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219972;
        bh=uR3n4sd7YL1HyOsu+8JWkGcLCOQx1HzMBqQTU9et6qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MudD4mWVsH4OKH8R/UCNB9WB4gMubzlQQJXXD7DhCK5AUYLLEJ0Z4ey4c6KIb7SBc
         UCaFW+ekWwlzX4aElV4S+z3jGqZgTzQZLF+9OVdpITrAP+UrWi2HJahWuurCPaDGLW
         mtsmx3a6Qp9QkM32dVr79buxJPIuWzX9DuAzzn0UO6axdmMd1BKnUfl+AnzPGX1Mz9
         gvLGzr3uWLkf6H4LjqH+NGUxcMhe3dJbwf3N8UNuNO0iJk5vhNqt341Neslqf52224
         8gqo6JMXor5qplnrAJDiMc83EJ4llYZ8rv1vUC3DOYgdLg9YeWxIqR3aIK7pYXSn5F
         lb8jWj4HmUUVQ==
Date:   Wed, 19 Oct 2022 17:52:49 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [RESEND PATCH v2 4/5] firmware: qcom: scm: Add wait-queue helper
 functions
Message-ID: <20221019225249.h2b3a7qfhhahay25@builder.lan>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
 <1661898311-30126-5-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661898311-30126-5-git-send-email-quic_gurus@quicinc.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 03:25:10PM -0700, Guru Das Srinagesh wrote:
> When the firmware (FW) supports multiple requests per VM, and the VM
> also supports it via the `allow-multi-call` device tree flag, the
> floodgates are thrown open for them to all reach the firmware at the
> same time.
> 
> Since the firmware currently being used has limited resources, it guards
> them with a resource lock and puts requests on a wait-queue internally
> and signals to HLOS that it is doing so. It does this by returning two
> new return values in addition to success or error: SCM_WAITQ_SLEEP and
> SCM_WAITQ_WAKE.
> 
>   1) SCM_WAITQ_SLEEP:
> 
>   	When an SCM call receives this return value instead of success
>   	or error, FW has placed this call on a wait-queue and
>   	has signalled HLOS to put it to non-interruptible sleep. (The
> 	mechanism to wake it back up will be described in detail in the
> 	next patch for the sake of simplicity.)
> 
> 	Along with this return value, FW also passes to HLOS `wq_ctx` -
> 	a unique number (UID) identifying the wait-queue that it has put
> 	the call on, internally. This is to help HLOS with its own
> 	bookkeeping to wake this sleeping call later.
> 
> 	Additionally, FW also passes to HLOS `smc_call_ctx` - a UID
> 	identifying the SCM call thus being put to sleep. This is also
> 	for HLOS' bookkeeping to wake this call up later.
> 
> 	These two additional values are passed via the a1 and a2
> 	registers.
> 
> 	N.B.: The "ctx" in the above UID names = "context".
> 
>   2) SCM_WAITQ_WAKE:
> 
>   	When an SCM call receives this return value instead of success
>   	or error, FW wishes to signal HLOS to wake up a (different)
>   	previously sleeping call.
> 
>   	FW tells HLOS which call to wake up via the additional return
>   	values `wq_ctx`, `smc_call_ctx` and `flags`. The first two have
>   	already been explained above.
> 
>   	`flags` can be either WAKE_ONE or WAKE_ALL. Meaning, wake either
>   	one, or all, of the SCM calls that HLOS is associating with the
>   	given `wq_ctx`.
> 
> A sleeping SCM call can be woken up by either an interrupt that FW
> raises, or via a SCM_WAITQ_WAKE return value for a new SCM call.
> 
> The handshake mechanism that HLOS uses to talk to FW about wait-queue
> operations involves three new SMC calls. These are:
> 
>   1) get_wq_ctx():
> 
>     	Arguments: 	None
>     	Returns:	wq_ctx, flags, more_pending
> 
>     	Get the wait-queue context, and wake up either one or all of the
>     	sleeping SCM calls associated with that wait-queue.
> 
>     	Additionally, repeat this if there are more wait-queues that are
>     	ready to have their requests woken up (`more_pending`).
> 
>   2) wq_resume(smc_call_ctx):
> 
>   	Arguments:	smc_call_ctx
> 
>   	HLOS needs to issue this in response to receiving an
>   	IRQ, passing to FW the same smc_call_ctx that FW
>   	receives from HLOS via the get_wq_ctx() call.
> 
>   3) wq_wake_ack(smc_call_ctx):
> 
>   	Arguments:	smc_call_ctx
> 
>   	HLOS needs to issue this in response to receiving an
>   	SCM_WAITQ_WAKE, passing to FW the same smc_call_ctx that FW
>   	passed to HLOS via the SMC_WAITQ_WAKE call.
> 
> (Reminder that the full handshake mechanism will be detailed in the
> subsequent patch.)
> 
> Also add the interrupt handler that wakes up a sleeping SCM call.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  drivers/firmware/qcom_scm-smc.c |  56 +++++++++++++++++++
>  drivers/firmware/qcom_scm.c     | 119 +++++++++++++++++++++++++++++++++++++++-
>  drivers/firmware/qcom_scm.h     |  12 ++++
>  3 files changed, 186 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
> index 66193c2..4150da1 100644
> --- a/drivers/firmware/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom_scm-smc.c
> @@ -53,6 +53,62 @@ static void __scm_smc_do_quirk(const struct arm_smccc_args *smc,
>  	} while (res->a0 == QCOM_SCM_INTERRUPTED);
>  }
>  
> +static void fill_wq_resume_args(struct arm_smccc_args *resume, u32 smc_call_ctx)

These two functions are used in the next patch only, so please move them
there.

> +{
> +	memset(resume->args, 0, ARRAY_SIZE(resume->args));
> +
> +	resume->args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
> +			 ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
> +			 SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_RESUME));
> +
> +	resume->args[1] = QCOM_SCM_ARGS(1);
> +
> +	resume->args[2] = smc_call_ctx;
> +}
> +
> +static void fill_wq_wake_ack_args(struct arm_smccc_args *wake_ack, u32 smc_call_ctx)
> +{
> +	memset(wake_ack->args, 0, ARRAY_SIZE(wake_ack->args));
> +
> +	wake_ack->args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
> +			 ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
> +			 SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_ACK));
> +
> +	wake_ack->args[1] = QCOM_SCM_ARGS(1);
> +
> +	wake_ack->args[2] = smc_call_ctx;
> +}
> +
> +static void fill_get_wq_ctx_args(struct arm_smccc_args *get_wq_ctx)

Afaict, this is only called once, right below. So please inline this
snippet in scm_get_wq_ctx()

> +{
> +	memset(get_wq_ctx->args, 0, ARRAY_SIZE(get_wq_ctx->args));
> +
> +	get_wq_ctx->args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
> +			 ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
> +			 SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_GET_WQ_CTX));
> +}
> +
> +int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending)
> +{
> +	int ret;
> +	struct arm_smccc_args get_wq_ctx = {0};
> +	struct arm_smccc_res get_wq_res;
> +
> +	fill_get_wq_ctx_args(&get_wq_ctx);
> +
> +	__scm_smc_do_quirk(&get_wq_ctx, &get_wq_res);
> +	/* Guaranteed to return only success or error, no WAITQ_* */
> +	ret = get_wq_res.a0;
> +	if (ret)
> +		return ret;
> +
> +	*wq_ctx = get_wq_res.a1;
> +	*flags  = get_wq_res.a2;
> +	*more_pending = get_wq_res.a3;
> +
> +	return 0;
> +}
> +
>  static void __scm_smc_do(const struct arm_smccc_args *smc,
>  			 struct arm_smccc_res *res, bool atomic)
>  {
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 978706a..9ae3fcf 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -3,8 +3,12 @@
>   * Copyright (C) 2015 Linaro Ltd.
>   * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
> +#define pr_fmt(fmt)     "qcom-scm: %s: " fmt, __func__

No thanks, please use dev_err().

> +
>  #include <linux/platform_device.h>
> +#include <linux/idr.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/cpumask.h>
>  #include <linux/export.h>
>  #include <linux/dma-mapping.h>
> @@ -13,10 +17,13 @@
>  #include <linux/types.h>
>  #include <linux/qcom_scm.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/clk.h>
>  #include <linux/reset-controller.h>
> +#include <linux/spinlock.h>
> +#include <linux/ktime.h>
>  #include <linux/arm-smccc.h>
>  
>  #include "qcom_scm.h"
> @@ -30,6 +37,12 @@ bool qcom_scm_allow_multicall = false;
>  #define SCM_HAS_IFACE_CLK	BIT(1)
>  #define SCM_HAS_BUS_CLK		BIT(2)
>  
> +struct qcom_scm_waitq {
> +	struct idr idr;
> +	spinlock_t idr_lock;
> +	struct work_struct scm_irq_work;
> +};
> +
>  struct qcom_scm {
>  	struct device *dev;
>  	struct clk *core_clk;
> @@ -37,6 +50,7 @@ struct qcom_scm {
>  	struct clk *bus_clk;
>  	struct icc_path *path;
>  	struct reset_controller_dev reset;
> +	struct qcom_scm_waitq waitq;
>  
>  	/* control access to the interconnect path */
>  	struct mutex scm_bw_lock;
> @@ -62,10 +76,14 @@ struct qcom_scm_mem_map_info {
>  static const u8 qcom_scm_cpu_cold_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
>  	0, BIT(0), BIT(3), BIT(5)
>  };
> +

This seems unrelated.

>  static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
>  	BIT(2), BIT(1), BIT(4), BIT(6)
>  };
>  
> +#define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
> +#define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
> +
>  static const char * const qcom_scm_convention_names[] = {
>  	[SMC_CONVENTION_UNKNOWN] = "unknown",
>  	[SMC_CONVENTION_ARM_32] = "smc arm 32",
> @@ -1328,11 +1346,92 @@ bool qcom_scm_is_available(void)
>  }
>  EXPORT_SYMBOL(qcom_scm_is_available);
>  
> +struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx)
> +{
> +	struct completion *wq = NULL;
> +	u32 wq_ctx_idr = wq_ctx;
> +	unsigned long flags;
> +	int err;
> +
> +	spin_lock_irqsave(&scm->waitq.idr_lock, flags);
> +	wq = idr_find(&scm->waitq.idr, wq_ctx);
> +	if (wq)
> +		goto out;
> +
> +	wq = devm_kzalloc(scm->dev, sizeof(*wq), GFP_ATOMIC);

I don't know how the wq_ctx are picked by the secure size, but as
written here there's no guarantee that this won't consume all system
memory after some time.


Is the worst-case number of requests waiting really bad enough that we
need an advanced data structure here?

How about just having a linked list with all currently waiting processes
and then loop over that in scm_waitq_flag_handler() to wake them up
selectively?

> +	if (!wq) {
> +		wq = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	init_completion(wq);
> +
> +	err = idr_alloc_u32(&scm->waitq.idr, wq, &wq_ctx_idr,
> +			    U32_MAX, GFP_ATOMIC);
> +	if (err < 0) {
> +		devm_kfree(scm->dev, wq);
> +		wq = ERR_PTR(err);
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&scm->waitq.idr_lock, flags);
> +	return wq;
> +}
> +
> +void scm_waitq_flag_handler(struct completion *wq, u32 flags)

This is indeed handling the waitq_flag, but I find that it would be
cleaner if this was:

void qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx, bool wake_all)

> +{
> +	switch (flags) {
> +	case QCOM_SMC_WAITQ_FLAG_WAKE_ONE:
> +		complete(wq);
> +		break;
> +	case QCOM_SMC_WAITQ_FLAG_WAKE_ALL:
> +		complete_all(wq);
> +		break;
> +	default:
> +		pr_err("invalid flags: %u\n", flags);
> +	}
> +}
> +
> +static void scm_irq_work(struct work_struct *work)
> +{
> +	int ret;
> +	u32 wq_ctx, flags, more_pending = 0;
> +	struct completion *wq_to_wake;
> +	struct qcom_scm_waitq *w = container_of(work, struct qcom_scm_waitq, scm_irq_work);
> +	struct qcom_scm *scm = container_of(w, struct qcom_scm, waitq);
> +
> +	do {
> +		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
> +		if (ret) {
> +			pr_err("GET_WQ_CTX SMC call failed: %d\n", ret);

You have scm->dev, so use dev_err().

> +			return;
> +		}
> +
> +		wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
> +		if (IS_ERR_OR_NULL(wq_to_wake)) {
> +			pr_err("No waitqueue found for wq_ctx %d: %ld\n",
> +					wq_ctx, PTR_ERR(wq_to_wake));
> +			return;
> +		}
> +
> +		scm_waitq_flag_handler(wq_to_wake, flags);
> +	} while (more_pending);
> +}
> +
> +static irqreturn_t qcom_scm_irq_handler(int irq, void *p)
> +{
> +	struct qcom_scm *scm = p;
> +
> +	schedule_work(&scm->waitq.scm_irq_work);

All the worker does is to query and wake up sleeping processes, why
can't this be done here in the threaded irq handler directly?

> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int qcom_scm_probe(struct platform_device *pdev)
>  {
>  	struct qcom_scm *scm;
>  	unsigned long clks;
> -	int ret;
> +	int irq, ret;
>  
>  	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
>  	if (!scm)
> @@ -1402,12 +1501,29 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	platform_set_drvdata(pdev, scm);

I'm not able to figure out why this is needed, please drop if possible.

> +
>  	__scm = scm;
>  	__scm->dev = &pdev->dev;
>  
> +	spin_lock_init(&__scm->waitq.idr_lock);
> +	idr_init(&__scm->waitq.idr);
>  	qcom_scm_allow_multicall = of_property_read_bool(__scm->dev->of_node,
>  							"allow-multi-call");
>  
> +	INIT_WORK(&__scm->waitq.scm_irq_work, scm_irq_work);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq) {
> +		ret = devm_request_threaded_irq(__scm->dev, irq, NULL,
> +			qcom_scm_irq_handler, IRQF_ONESHOT, "qcom-scm", __scm);
> +		if (ret < 0) {
> +			pr_err("Failed to request qcom-scm irq: %d\n", ret);

You have scm->dev, please use it in dev_err().

> +			idr_destroy(&__scm->waitq.idr);
> +			return ret;
> +		}
> +	}
> +
>  	__get_convention();
>  
>  	/*
> @@ -1423,6 +1539,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  
>  static void qcom_scm_shutdown(struct platform_device *pdev)
>  {
> +	idr_destroy(&__scm->waitq.idr);

You can still have interrupts coming in and work scheduled, that will
use the idr. You need to ensure that can't happen.

Regards,
Bjorn

>  	/* Clean shutdown, disable download mode to allow normal restart */
>  	if (download_mode)
>  		qcom_scm_set_download_mode(false);
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index c0a4d6b..ae3a331 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -62,6 +62,11 @@ struct qcom_scm_res {
>  	u64 result[MAX_QCOM_SCM_RETS];
>  };
>  
> +struct qcom_scm;
> +extern struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx);
> +extern void scm_waitq_flag_handler(struct completion *wq, u32 flags);
> +extern int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
> +
>  #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
>  extern int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>  			  enum qcom_scm_convention qcom_convention,
> @@ -131,6 +136,11 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>  #define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
>  #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02
>  
> +#define QCOM_SCM_SVC_WAITQ			0x24
> +#define QCOM_SCM_WAITQ_ACK			0x01
> +#define QCOM_SCM_WAITQ_RESUME			0x02
> +#define QCOM_SCM_WAITQ_GET_WQ_CTX		0x03
> +
>  extern void __qcom_scm_init(void);
>  
>  /* common error codes */
> @@ -141,6 +151,8 @@ extern void __qcom_scm_init(void);
>  #define QCOM_SCM_EINVAL_ARG	-2
>  #define QCOM_SCM_ERROR		-1
>  #define QCOM_SCM_INTERRUPTED	1
> +#define QCOM_SCM_WAITQ_SLEEP	2
> +#define QCOM_SCM_WAITQ_WAKE	3
>  
>  static inline int qcom_scm_remap_error(int err)
>  {
> -- 
> 2.7.4
> 
