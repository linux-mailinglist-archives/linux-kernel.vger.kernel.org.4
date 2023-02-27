Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2A36A4BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjB0UD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0UDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:03:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3709EDD;
        Mon, 27 Feb 2023 12:03:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D484B80C94;
        Mon, 27 Feb 2023 20:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB412C433D2;
        Mon, 27 Feb 2023 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677528199;
        bh=L1hXB8aev1OB4sehbJ+LYymCKbtXDt8zn4Fj8SbEDdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hjh+RhQM5Frh2Y0d6+hbW2Uid+PrJOA3YIoiQd6Ea6veVMrCWOZ3RU+buTo5dl9KD
         FM0r8XCOFnFkyWK5EtVI2zoOmhdThjDYsbuXcA1OPeqlXPpD4Xjp+d/Bu5a6k/mYUp
         MNI/baP+IZLc25GMkGEkiuvLCangBfY3j3K31ZPJqFzHmXgEE/h4JzRXg3ric3tcIQ
         AsOSNcpwE7aroqKLVJuHM5/pM9qzD8SRM1flI8QVR3TAr/ZMKpbR9UMzB9+w5XDkcw
         cdjQkHIPhyQs8+rqhl7u4j43jvA3r/MYMzl3Ibp6nmpxtRA/z16AxORFHHmTdTnEfY
         +qsQlNiMid3tA==
Date:   Mon, 27 Feb 2023 12:06:39 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] remoteproc: qcom: Add remoteproc tracing
Message-ID: <20230227200639.fei5rsb5omaquhqn@ripper>
References: <20230224165142.17745-1-quic_gokukris@quicinc.com>
 <20230224165142.17745-2-quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224165142.17745-2-quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 08:51:42AM -0800, Gokul krishna Krishnakumar wrote:
> This change adds traces to the following rproc events:
> 1. subdevices events - (STRAT/STOP/CRASH)
> 2. subsystem events - (START/STOP/CRASH)
> 3. RPROC framework events - (Firmware Load/Authentication)
> 

Thanks for proposing the introduction of tracepoints, this is something
we have talked about for years, but no one has shown enough
need/interest to do the work.

Most of the proposed tracepoints would however be very useful if you
move them one step up (or down...) in the stack.

I.e. please move them into the common code.

> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/Makefile           |  3 ++-
>  drivers/remoteproc/qcom_common.c      | 25 +++++++++++++++++++
>  drivers/remoteproc/qcom_q6v5.c        |  3 +++
>  drivers/remoteproc/qcom_q6v5_pas.c    | 17 +++++++++++++
>  drivers/remoteproc/qcom_sysmon.c      | 13 ++++++++++
>  drivers/remoteproc/qcom_tracepoints.c | 10 ++++++++
>  include/trace/events/rproc_qcom.h     | 36 +++++++++++++++++++++++++++
>  7 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/remoteproc/qcom_tracepoints.c
>  create mode 100644 include/trace/events/rproc_qcom.h
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 91314a9b43ce..e52fa815ddc0 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -22,7 +22,8 @@ obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
>  obj-$(CONFIG_MESON_MX_AO_ARC_REMOTEPROC)+= meson_mx_ao_arc.o
>  obj-$(CONFIG_PRU_REMOTEPROC)		+= pru_rproc.o
>  obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
> -obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
> +obj-$(CONFIG_QCOM_RPROC_COMMON)		+= rproc_qcom_common.o
> +rproc_qcom_common-y			:= qcom_common.o qcom_tracepoints.o
>  obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
>  obj-$(CONFIG_QCOM_Q6V5_ADSP)		+= qcom_q6v5_adsp.o
>  obj-$(CONFIG_QCOM_Q6V5_MSS)		+= qcom_q6v5_mss.o
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index a0d4238492e9..7da3259be14a 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  #include <linux/soc/qcom/smem.h>
> +#include <trace/events/rproc_qcom.h>
>  
>  #include "remoteproc_internal.h"
>  #include "qcom_common.h"
> @@ -26,6 +27,10 @@
>  #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
>  #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
>  
> +#define GLINK_SUBDEV_NAME	"glink"
> +#define SMD_SUBDEV_NAME		"smd"
> +#define SSR_SUBDEV_NAME		"ssr"
> +
>  #define MAX_NUM_OF_SS           10
>  #define MAX_REGION_NAME_LENGTH  16
>  #define SBL_MINIDUMP_SMEM_ID	602
> @@ -189,6 +194,8 @@ static int glink_subdev_start(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>  
> +	trace_rproc_qcom_event(dev_name(glink->dev->parent), GLINK_SUBDEV_NAME, "start");

Please do add individual events, rather than adding a single
trace_printk()-like event. That allows the user to selectively enable
events, and it becomes convenient to use the events in debugging.

> +
>  	glink->edge = qcom_glink_smem_register(glink->dev, glink->node);
>  
>  	return PTR_ERR_OR_ZERO(glink->edge);
[..]
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6cc4e13c5d36..27d3a6f8c92f 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -24,6 +24,7 @@
>  #include <linux/soc/qcom/mdt_loader.h>
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
> +#include <trace/events/rproc_qcom.h>
>  
>  #include "qcom_common.h"
>  #include "qcom_pil_info.h"
> @@ -206,10 +207,13 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>  	int ret;
>  
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_load", "enter");
> +
>  	/* Store firmware handle to be used in adsp_start() */
>  	adsp->firmware = fw;
>  
>  	if (adsp->dtb_pas_id) {
> +		trace_rproc_qcom_event(dev_name(adsp->dev), "dtb_firmware_loading", "enter");
>  		ret = request_firmware(&adsp->dtb_firmware, adsp->dtb_firmware_name, adsp->dev);
>  		if (ret) {
>  			dev_err(adsp->dev, "request_firmware failed for %s: %d\n",
> @@ -231,6 +235,8 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  			goto release_dtb_metadata;
>  	}
>  
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_load", "exit");

I believe it would be more useful to capture the error path as well.

> +
>  	return 0;
>  
>  release_dtb_metadata:
> @@ -247,6 +253,8 @@ static int adsp_start(struct rproc *rproc)
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>  	int ret;
>  
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_start", "enter");
> +
>  	ret = qcom_q6v5_prepare(&adsp->q6v5);
>  	if (ret)
>  		return ret;
> @@ -276,6 +284,7 @@ static int adsp_start(struct rproc *rproc)
>  	}
>  
>  	if (adsp->dtb_pas_id) {
> +	        trace_rproc_qcom_event(dev_name(adsp->dev), "dtb_auth_reset", "enter");
>  		ret = qcom_scm_pas_auth_and_reset(adsp->dtb_pas_id);
>  		if (ret) {
>  			dev_err(adsp->dev,
> @@ -289,6 +298,8 @@ static int adsp_start(struct rproc *rproc)
>  	if (ret)
>  		goto disable_px_supply;
>  
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "Q6_firmware_loading", "enter");

I would like this to contain move useful information, e.g. what file is
it that we're trying to load?

And you only put "enter" here because you have a single tracepoint, it
doesn't add any value...

> +
>  	ret = qcom_mdt_load_no_init(adsp->dev, adsp->firmware, rproc->firmware, adsp->pas_id,
>  				    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
>  				    &adsp->mem_reloc);
> @@ -296,6 +307,7 @@ static int adsp_start(struct rproc *rproc)
>  		goto release_pas_metadata;
>  
>  	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "Q6_auth_reset", "enter");
>  

When is this tracepoint useful to you? (Same with the mdt loader above)

Should mdt-loader and scm drivers have their own tracepoints defined?
They are after all called from a variety of other drivers...

>  	ret = qcom_scm_pas_auth_and_reset(adsp->pas_id);
>  	if (ret) {
> @@ -303,6 +315,7 @@ static int adsp_start(struct rproc *rproc)
>  			"failed to authenticate image and release reset\n");
>  		goto release_pas_metadata;
>  	}
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "Q6_auth_reset", "exit");
>  
>  	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
>  	if (ret == -ETIMEDOUT) {
> @@ -364,6 +377,8 @@ static int adsp_stop(struct rproc *rproc)
>  	int handover;
>  	int ret;
>  
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_stop", "enter");
> +
>  	ret = qcom_q6v5_request_stop(&adsp->q6v5, adsp->sysmon);
>  	if (ret == -ETIMEDOUT)
>  		dev_err(adsp->dev, "timed out on wait\n");
> @@ -385,6 +400,8 @@ static int adsp_stop(struct rproc *rproc)
>  	if (handover)
>  		qcom_pas_handover(&adsp->q6v5);
>  
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_stop", "exit");

You're missing an opportunity to convey the success/failure by not using
"ret".

> +
>  	return ret;
>  }
>  
[..]
> diff --git a/include/trace/events/rproc_qcom.h b/include/trace/events/rproc_qcom.h
> new file mode 100644
> index 000000000000..b8748873ab25
> --- /dev/null
> +++ b/include/trace/events/rproc_qcom.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 The Linux Foundation. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM rproc_qcom
> +
> +#if !defined(_TRACE_RPROC_QCOM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RPROC_QCOM_H
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(rproc_qcom_event,
> +
> +	TP_PROTO(const char *name, const char *event, const char *subevent),
> +
> +	TP_ARGS(name, event, subevent),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__string(event, event)
> +		__string(subevent, subevent)

Please ensure that your trace events are carrying useful information;
as seen above, subevent is not useful in all cases, and in several other
cases you're missing useful information.

Please think beyond printk, and please consider that these buffers could
be consumed by a machine.

Regards,
Bjorn

> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__assign_str(event, event);
> +		__assign_str(subevent, subevent);
> +	),
> +
> +	TP_printk("%s: %s: %s", __get_str(name), __get_str(event), __get_str(subevent))
> +);
> +#endif /* _TRACE_RPROC_QCOM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> -- 
> 2.39.2
> 
