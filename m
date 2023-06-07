Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8A7264BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbjFGPfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjFGPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:35:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA7E83
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:35:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-65314ee05c6so3569334b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686152137; x=1688744137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WynTZywqtD9l/8Uu7YWD6wPNKsCzbnxA089t4XpU9S0=;
        b=sz/Q/VZHuMNxLcYWBhr2CpgetfCyMTJPFOpENYTBz5m0omfdAXEmSB8LkK+b3cMOE+
         o3gCZ+STSX+6lvIaq7CLfQj6d21MIsWfpb1at7x6PyYS0bPDCocYbG/tLQi5Kd6+wrhn
         iQW/EA2QbKUoF5NkcAhxRvuUf1chRA1koJRFYljNOLwwhWY2FdO6NSxRAYHgs3TBsr06
         BlF9zhGsSXt73gNwYCySpHJuxlOTZ+BiKNPIQBHYo9tG4nbIK2sZjfiGCOZxnufBH1RJ
         y0BvOatmH2lBVpHpn+nNyEafKMzih8gScEUYfAaFaVW9hEprzzXilOkxRhRi3w4zoAe2
         W74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152137; x=1688744137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WynTZywqtD9l/8Uu7YWD6wPNKsCzbnxA089t4XpU9S0=;
        b=Csc17TPK5fhSfoMIKtuZ33KNiYXVuCa+Aje/1DwhKCQRKT6y8FKJbhpB4R0AUn/2Pr
         4EXcIjeTzAdrCsr61on/OFQEixucqvnESDWffaxYfzAbFuDfmImMhOIAzHBMmyoIVEBm
         mHqGLU4jy55AHXwHNAU+wW+jEbM+qrXCbriPnVfJsNBEK03UIEJ85uiUL2oV23EcqbzX
         EV8yTFPFlMKqYUoah4zgp4f1JDobsLpQtmVqVHb0/+UXVFC2Z4dCkhUcYfWedoN3XV3M
         vESW4HRshW7yMvQoUUnQNilbkMPQjhM4brKh9QzWAyquV7T8xZiRMxKlTzcOUS0fyyR6
         /pwA==
X-Gm-Message-State: AC+VfDz6ECsfBwjt6t2BPmZCiNWR+9uynCXuRX/Eld3ykqlZP6adKoiw
        PevUuHGVb6gOvEmtRRbDR6NjGw==
X-Google-Smtp-Source: ACHHUZ6hPcb8IZWL+xcho5q6ecO8XViI22CKuZFj3x0r3uJBkmCsnZMaBvLw/ZH8qYTIrFp2CyB68A==
X-Received: by 2002:a05:6a20:7484:b0:10b:7243:c212 with SMTP id p4-20020a056a20748400b0010b7243c212mr1540781pzd.42.1686152136646;
        Wed, 07 Jun 2023 08:35:36 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:daf4:d6b6:e616:7e23])
        by smtp.gmail.com with ESMTPSA id a10-20020a62bd0a000000b0063b86aff031sm8564988pff.108.2023.06.07.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:35:36 -0700 (PDT)
Date:   Wed, 7 Jun 2023 09:35:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: Re: [PATCH v4 2/2] remoteproc: qcom: Add remoteproc tracing
Message-ID: <ZICjxXSUkiHQH0IY@p14s>
References: <cover.1685486994.git.quic_gokukris@quicinc.com>
 <bd949ac8225abb842630bd7f4a2d45334c58f17f.1685486994.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd949ac8225abb842630bd7f4a2d45334c58f17f.1685486994.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gokul,

On Wed, May 31, 2023 at 02:28:40PM -0700, Gokul krishna Krishnakumar wrote:
> This change attempts to add traces for start, stop, crash
> subsystem/subdevice events, these will serve as standard checkpoints in
> code and could help in debugging the failures in subdevice/subsystem
> prepare, start, stop and unprepare functions. This will also breakdown
> the time taken for each step in remoteproc bootup/shutdown process.
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/qcom_common.c     | 37 ++++++++++++++++++++++++++++
>  drivers/remoteproc/qcom_q6v5.c       |  9 +++++++
>  drivers/remoteproc/remoteproc_core.c |  8 ++++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 020349f8979d..5bf6b8bc67c5 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  #include <linux/soc/qcom/smem.h>
> +#include <trace/events/remoteproc_tracepoints.h>
>  
>  #include "remoteproc_internal.h"
>  #include "qcom_common.h"
> @@ -186,6 +187,10 @@ static int glink_subdev_start(struct rproc_subdev *subdev)
>  
>  	glink->edge = qcom_glink_smem_register(glink->dev, glink->node);
>  
> +	trace_rproc_subdev_event(dev_name(glink->dev->parent),
> +					"glink", "start",
> +					PTR_ERR_OR_ZERO(glink->edge));
> +
>  	return PTR_ERR_OR_ZERO(glink->edge);
>  }
>  
> @@ -194,6 +199,11 @@ static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>  
>  	qcom_glink_smem_unregister(glink->edge);
> +
> +	trace_rproc_subdev_event(dev_name(glink->dev->parent),
> +					"glink", "stop",
> +					PTR_ERR_OR_ZERO(glink->edge));
> +
>  	glink->edge = NULL;
>  }
>  
> @@ -201,6 +211,10 @@ static void glink_subdev_unprepare(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>  
> +	trace_rproc_subdev_event(dev_name(glink->dev->parent),
> +					"glink", "unprepare",
> +					PTR_ERR_OR_ZERO(glink->edge));
> +
>  	qcom_glink_ssr_notify(glink->ssr_name);
>  }
>  
> @@ -295,6 +309,10 @@ static int smd_subdev_start(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>  
> +	trace_rproc_subdev_event(dev_name(smd->dev->parent),
> +					"smd", "start",
> +					PTR_ERR_OR_ZERO(smd->edge));
> +
>  	smd->edge = qcom_smd_register_edge(smd->dev, smd->node);
>  
>  	return PTR_ERR_OR_ZERO(smd->edge);
> @@ -304,6 +322,10 @@ static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>  {
>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>  
> +	trace_rproc_subdev_event(dev_name(smd->dev->parent),
> +					"smd", "stop",
> +					PTR_ERR_OR_ZERO(smd->edge));
> +
>  	qcom_smd_unregister_edge(smd->edge);
>  	smd->edge = NULL;
>  }
> @@ -420,6 +442,10 @@ static int ssr_notify_prepare(struct rproc_subdev *subdev)
>  		.crashed = false,
>  	};
>  
> +	trace_rproc_subdev_event(ssr->info->name,
> +					"ssr", "QCOM_SSR_BEFORE_POWERUP",
> +					data.crashed);
> +
>  	srcu_notifier_call_chain(&ssr->info->notifier_list,
>  				 QCOM_SSR_BEFORE_POWERUP, &data);
>  	return 0;
> @@ -432,6 +458,9 @@ static int ssr_notify_start(struct rproc_subdev *subdev)
>  		.name = ssr->info->name,
>  		.crashed = false,
>  	};
> +	trace_rproc_subdev_event(ssr->info->name,
> +					"ssr", "QCOM_SSR_AFTER_POWERUP",
> +					data.crashed);
>  
>  	srcu_notifier_call_chain(&ssr->info->notifier_list,
>  				 QCOM_SSR_AFTER_POWERUP, &data);
> @@ -446,6 +475,10 @@ static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
>  		.crashed = crashed,
>  	};
>  
> +	trace_rproc_subdev_event(ssr->info->name,
> +					"ssr", "QCOM_SSR_BEFORE_SHUTDOWN",
> +					data.crashed);
> +
>  	srcu_notifier_call_chain(&ssr->info->notifier_list,
>  				 QCOM_SSR_BEFORE_SHUTDOWN, &data);
>  }
> @@ -458,6 +491,10 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>  		.crashed = false,
>  	};
>  
> +	trace_rproc_subdev_event(ssr->info->name,
> +					"ssr", "QCOM_SSR_AFTER_SHUTDOWN",
> +					data.crashed);
> +
>  	srcu_notifier_call_chain(&ssr->info->notifier_list,
>  				 QCOM_SSR_AFTER_SHUTDOWN, &data);
>  }
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 497acfb33f8f..cf3f322be65e 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -15,6 +15,7 @@
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
>  #include <linux/remoteproc.h>
> +#include <trace/events/remoteproc_tracepoints.h>
>  #include "qcom_common.h"
>  #include "qcom_q6v5.h"
>  
> @@ -113,6 +114,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>  		dev_err(q6v5->dev, "watchdog without message\n");
>  
>  	q6v5->running = false;
> +	trace_rproc_interrupt_event(q6v5->rproc, "q6v5_wdog", msg);
>  	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
>  
>  	return IRQ_HANDLED;
> @@ -134,6 +136,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>  		dev_err(q6v5->dev, "fatal error without message\n");
>  
>  	q6v5->running = false;
> +	trace_rproc_interrupt_event(q6v5->rproc, "fatal", msg);
>  	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>  
>  	return IRQ_HANDLED;
> @@ -165,6 +168,8 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
>  	if (!ret)
>  		disable_irq(q6v5->handover_irq);
>  
> +	trace_rproc_interrupt_event(q6v5->rproc, "Ready", !ret ? "-ETIMEDOUT":"done");
> +
>  	return !ret ? -ETIMEDOUT : 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);
> @@ -180,6 +185,8 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
>  
>  	q6v5->handover_issued = true;
>  
> +	trace_rproc_interrupt_event(q6v5->rproc, "handover", "Proxy votes removed");
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -216,6 +223,8 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon)
>  
>  	qcom_smem_state_update_bits(q6v5->state, BIT(q6v5->stop_bit), 0);
>  
> +	trace_rproc_interrupt_event(q6v5->rproc, "Stop", ret ? "done":"-EETIMEDOUT");
> +
>  	return ret == 0 ? -ETIMEDOUT : 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 1cd4815a6dd1..d8dc91a15477 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -38,6 +38,7 @@
>  #include <linux/virtio_ring.h>
>  #include <asm/byteorder.h>
>  #include <linux/platform_device.h>
> +#include <trace/events/remoteproc_tracepoints.h>
>  
>  #include "remoteproc_internal.h"
>  
> @@ -1270,6 +1271,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  
>  	/* load the ELF segments to memory */
>  	ret = rproc_load_segments(rproc, fw);
> +	trace_rproc_load_event(rproc, ret);

I would move this trace point to function rproc_load_segments() and rename it to
trace_rproc_load_segment_event().

>  	if (ret) {
>  		dev_err(dev, "Failed to load program segments: %d\n", ret);
>  		return ret;
> @@ -1305,6 +1307,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  
>  	/* Start any subdevices for the remote processor */
>  	ret = rproc_start_subdevices(rproc);
> +

Spurious change

>  	if (ret) {
>  		dev_err(dev, "failed to probe subdevices for %s: %d\n",
>  			rproc->name, ret);
> @@ -1729,6 +1732,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  		return ret;
>  	}
>  
> +	trace_rproc_stop_event(rproc, crashed ? "crash stop" : "stop");
> +
>  	rproc_unprepare_subdevices(rproc);
>  
>  	rproc->state = RPROC_OFFLINE;
> @@ -1939,6 +1944,8 @@ int rproc_boot(struct rproc *rproc)
>  		dev_info(dev, "attaching to %s\n", rproc->name);
>  
>  		ret = rproc_attach(rproc);
> +		trace_rproc_start_event(rproc, ret);

Same here - please move the trace point to rproc_attach() and renamit it
trace_rproc_attach_event().

> +
>  	} else {
>  		dev_info(dev, "powering up %s\n", rproc->name);
>  
> @@ -1950,6 +1957,7 @@ int rproc_boot(struct rproc *rproc)
>  		}
>  
>  		ret = rproc_fw_boot(rproc, firmware_p);
> +		trace_rproc_start_event(rproc, ret);
> 

Same

Thanks,
Mathieu

>  		release_firmware(firmware_p);
>  	}
> -- 
> 2.40.1
> 
