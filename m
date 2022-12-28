Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE3565813D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiL1Q0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiL1Q0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:26:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271251C433;
        Wed, 28 Dec 2022 08:22:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A27B26157B;
        Wed, 28 Dec 2022 16:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE0EC433D2;
        Wed, 28 Dec 2022 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672244563;
        bh=TLSddST3Zd4iQ0/tZ2EwZ5APMtWwAlF5wdkqkwXHFMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3XWQcQQQ6N9JohXPz9leVVnW7Hd1yMZpsxUmhYywShYZIowiw2xS9nKfFj+QfG8w
         WpKxNvoDwuLowI2LIDT2UZIMKJ1gjj4wSAn4ZQsADooFB9D7gPlWfqHK7AeiZ5LMV+
         riFA5IPZiSR1MngCwWeS25CUrBlxZ1tuuJkXX8e7xKSu33jdokYmvkL5QS8xmRreaP
         bSfRczg86+Yz+T4uSg+VtaS5tufhii8OAL9uf9fY3QGNf5p0Tvj4ry2qRMKeY9nUjm
         HUZLdS/Tq3PhLP7D5AVtjhQmg8PYWX349Lh4yNbZGun8x55JOGnKuWsYXerxKof320
         tXm+O6ZP1mU7Q==
Date:   Wed, 28 Dec 2022 10:22:40 -0600
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
Subject: Re: [PATCH v1 2/3] remoteproc: qcom: q6v5: Do not report crash if
 SSR is disabled
Message-ID: <20221228162240.y2eaki6tzhkprxg3@builder.lan>
References: <cover.1662995608.git.quic_gokukris@quicinc.com>
 <1a548f4e7373c12159f8d866dc0e12d224460036.1662995608.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a548f4e7373c12159f8d866dc0e12d224460036.1662995608.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:00:39AM -0700, Gokul krishna Krishnakumar wrote:
> In case recovery is disabled, do not report the rproc crash
> to the framework. If recovery is enabled after we start the
> crash handler we may end up in a weird state by informing
> clients of a crash twice, resulting in undefined behaviour.
> 

Afaict rproc_report_crash() schedules work which does nothing useful if
!rproc->recovery_disabled.

Can you please help me understand the issue you're seeing, and
preferably spell out what the resulting weird state is.

Thanks,
Bjorn

> Change-Id: If0d9bf5aa2c6f9e25adcefaca14b2de60fcb1a7a
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 89f5384..1b9e1e1 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -103,6 +103,8 @@ static void qcom_q6v5_crash_handler_work(struct work_struct *work)
>  
>  	mutex_lock(&rproc->lock);
>  
> +	rproc->state = RPROC_CRASHED;
> +
>  	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
>  		if (subdev->stop)
>  			subdev->stop(subdev, true);
> @@ -139,8 +141,8 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>  	q6v5->running = false;
>  	if (q6v5->rproc->recovery_disabled)
>  		schedule_work(&q6v5->crash_handler);
> -
> -	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
> +	else
> +		rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -163,8 +165,8 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>  	q6v5->running = false;
>  	if (q6v5->rproc->recovery_disabled)
>  		schedule_work(&q6v5->crash_handler);
> -
> -	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
> +	else
> +		rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 2.7.4
> 
