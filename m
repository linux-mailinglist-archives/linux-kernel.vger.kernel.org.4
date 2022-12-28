Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC865810C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiL1QYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiL1QX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:23:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A56D2189;
        Wed, 28 Dec 2022 08:20:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83945B816F4;
        Wed, 28 Dec 2022 16:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51644C433F0;
        Wed, 28 Dec 2022 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672244443;
        bh=n+AL8sJppicQ0AnwFa/E3rCM32uk82yPOrot2Ng0Yc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2vmrUTGqESNwoNT9N51PkG4DvFWQx4y3mrZ20VufCuy4/jQQ8q2di13kbhd2G77J
         e0zTCPJEYuIRw1SMRqmL8kyQrmSHgzx40IrtrMlmEjLMedyNWFm1LDZ06eV5Cyw8bP
         QYJUcSGjGTZlE7g99qM117n4iTIlFC7hq7scH42WtpQvaZ4xUkwsMhCxN08AjGN3tR
         +O1YkzpRP1d5EjigucUS6u0rK4KWHBfFbBLIoeFvrOsaoJhpQTYTHRP9Q1N9ctuSO1
         Z8pqpWHJYulompAbH3zQtRZShfMFVpGzo6tu5TA8Jxm08Si/xj0QAiy5AN00Lw1Boz
         i/Dh8S7OOFNIA==
Date:   Wed, 28 Dec 2022 10:20:40 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v1 1/3] remoteproc: qcom: q6v5: Send subdevice
 notifications before panic
Message-ID: <20221228162040.m3ucsyau3s55rkfn@builder.lan>
References: <cover.1662995608.git.quic_gokukris@quicinc.com>
 <842a6b6307d26874959d29f2065aad544ff0b86c.1662995608.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842a6b6307d26874959d29f2065aad544ff0b86c.1662995608.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:00:38AM -0700, Gokul krishna Krishnakumar wrote:

Looking back, I don't think I gave you proper feedback on this feature.
Sorry about that Gokul.

> Subdevice notifications after a remoteproc has crashed are useful to any
> clients that might want to preserve data pertaining to the driver after the
> remoteproc crashed. Sending subdevice notifications before triggering a
> kernel panic gives these drivers the time to do collect this information.

The elephant in the room here is the call to panic(), this deserves more
attention in the commit messages.

> 
> Change-Id: Id6e55fb038b70f54ff5854d2adff72b74b6a9570

Please remember to remove your Gerrit Change-Id when posting to the
list.

> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5.c | 31 +++++++++++++++++++++++++++++++
>  drivers/remoteproc/qcom_q6v5.h |  2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 497acfb..89f5384 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -15,6 +15,7 @@
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
>  #include <linux/remoteproc.h>
> +#include <linux/delay.h>
>  #include "qcom_common.h"
>  #include "qcom_q6v5.h"
>  
> @@ -94,6 +95,29 @@ int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5)
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_unprepare);
>  
> +static void qcom_q6v5_crash_handler_work(struct work_struct *work)
> +{
> +	struct qcom_q6v5 *q6v5 = container_of(work, struct qcom_q6v5, crash_handler);
> +	struct rproc *rproc = q6v5->rproc;
> +	struct rproc_subdev *subdev;
> +
> +	mutex_lock(&rproc->lock);
> +
> +	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
> +		if (subdev->stop)
> +			subdev->stop(subdev, true);
> +	}
> +
> +	mutex_unlock(&rproc->lock);
> +
> +	/*
> +	 * Temporary workaround until ramdump userspace application calls
> +	 * sync() and fclose() on attempting the dump.
> +	 */

I'm not able to see how this would happen, you only schedule_work() if
rproc->recovery_disabled and the coredump generation will only happen if
!rproc->recovery_disabled.

Also, the reason I can see for invoking panic() here would be to gather
a full system coredump to do post mortem analysis of all systems
involved. So why would you capture a coredump as well? (This needs to be
documented clearly...)

> +	msleep(100);
> +	panic("Panicking, remoteproc %s crashed\n", q6v5->rproc->name);

As you might know, calling panic() is frowned upon. But I can see the
benefit of being able to do full system post mortem analysis.

I do however think that your patch indicates a shortcoming (to you) in
the remoteproc_core's recovery logic. So please fix that shortcoming,
rather than circumventing it in your driver.

I.e. make it possible to get rproc_crash_handler_work() behave like you
want it to, with a good motivation to why you want that.

Regards,
Bjorn

> +}
> +
>  static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>  {
>  	struct qcom_q6v5 *q6v5 = data;
> @@ -113,6 +137,9 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>  		dev_err(q6v5->dev, "watchdog without message\n");
>  
>  	q6v5->running = false;
> +	if (q6v5->rproc->recovery_disabled)
> +		schedule_work(&q6v5->crash_handler);
> +
>  	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
>  
>  	return IRQ_HANDLED;
> @@ -134,6 +161,9 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>  		dev_err(q6v5->dev, "fatal error without message\n");
>  
>  	q6v5->running = false;
> +	if (q6v5->rproc->recovery_disabled)
> +		schedule_work(&q6v5->crash_handler);
> +
>  	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>  
>  	return IRQ_HANDLED;
> @@ -354,6 +384,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>  	if (IS_ERR(q6v5->path))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>  				     "failed to acquire interconnect path\n");
> +	INIT_WORK(&q6v5->crash_handler, qcom_q6v5_crash_handler_work);
>  
>  	return 0;
>  }
> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
> index 5a859c4..b1654be 100644
> --- a/drivers/remoteproc/qcom_q6v5.h
> +++ b/drivers/remoteproc/qcom_q6v5.h
> @@ -29,6 +29,8 @@ struct qcom_q6v5 {
>  	int handover_irq;
>  	int stop_irq;
>  
> +	struct work_struct crash_handler;
> +
>  	bool handover_issued;
>  
>  	struct completion start_done;
> -- 
> 2.7.4
> 
