Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3151646133
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiLGSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLGSgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:36:43 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D85FC3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:36:42 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q71so17134513pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1b653XqKdE+ACkzobajku7SrEFL8PYTT2ucOENSGGQU=;
        b=BLOIftrH9HeVn1463TiO4mC1wIwJbuww9ZFfHvVAMMkZllcS5dP7hC8xxHhEvcfpHc
         mnViOVvb2jwyCK2ZC+Q2jBMMvkFlNA1cwAh0aYQDqeD4SL5GYK7JHDlzTdexb9acMshh
         58gmbcqptqC4Hrb6TDKCOdCK058K6+RfeG1CMByknUeVrY1u+SVQvYOVgyMsbYrwUPRb
         9NAjnNTt8U4+/yXqOfoppggzzcq1JE6y3Lo2PPvhSM3JqlL0N9+1CNwQe5eFxyoChXQP
         9WBLo7G3mPhCbloQ9FX8w3nQ/+PNYV/ELa7X2S8Xwl8TvtzijDS05nJhbuhC0BKn4aqO
         N3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b653XqKdE+ACkzobajku7SrEFL8PYTT2ucOENSGGQU=;
        b=5AuNXrO1N3bXCb2Ae/Akgi8+cIYQ0MUAvbjGry+ECRVdt2SaGVDIKlfSlvbJ/+7K7l
         myK/Cbv10uK851Lv21MhZKSrLJWT0ujdrKYBVu23o1OMwq0Wl3BMrOpdifdCkyhRdL47
         GKbLdphfgvSYIKn/A5lQy+pQ6jQP5GlTm5P/16LYgJ6V6VcKalEDW2qoLvD9LRKcx6UD
         +xjoQWyGcI3cIslExWcmrWYr01WT8pXWKFHqf4vNndzTZbZiq3ouBkWTYuxMhVIq2uzV
         Z+6S9FSd/11HazxZEul7RnPbW9qBziqgTm4NEcfrBVykgz23LsnDCDvv3nDIcnWAJYfs
         O8aw==
X-Gm-Message-State: ANoB5pkk2/iWn56Qsmu1oZ+XqIEpkUMde1uLR4xhS+a9zV+QeuNId+X3
        rGNpAJdnrwvHbrEcq1KbqCVcQg==
X-Google-Smtp-Source: AA0mqf4Vmxwo0MGusyBmh4fpv4U1HnTv6DSe5jj7GvspXF9DPDnm3NOb9z5gYTUJIDZXQFA1+85R5w==
X-Received: by 2002:a63:f5a:0:b0:470:18d4:f18d with SMTP id 26-20020a630f5a000000b0047018d4f18dmr66096148pgp.295.1670438202238;
        Wed, 07 Dec 2022 10:36:42 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:5942:e1b3:57a1:f106])
        by smtp.gmail.com with ESMTPSA id c73-20020a624e4c000000b00575448ab0fdsm13895741pfb.114.2022.12.07.10.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 10:36:41 -0800 (PST)
Date:   Wed, 7 Dec 2022 11:36:39 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_clew@quicinc.com,
        quic_mojha@quicinc.com
Subject: Re: [PATCH v6 1/1] remoteproc: core: do pm_relax when in
 RPROC_OFFLINE state
Message-ID: <20221207183639.GB527346@p14s>
References: <20221206015957.2616-1-quic_aiquny@quicinc.com>
 <20221206015957.2616-2-quic_aiquny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206015957.2616-2-quic_aiquny@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 09:59:57AM +0800, Maria Yu wrote:
> Make sure that pm_relax() happens even when the remoteproc
> is stopped before the crash handler work is scheduled.
> 
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 8768cb64f560..7419e1460f2a 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1862,12 +1862,18 @@ static void rproc_crash_handler_work(struct work_struct *work)
>  
>  	mutex_lock(&rproc->lock);
>  
> -	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
> +	if (rproc->state == RPROC_CRASHED) {
>  		/* handle only the first crash detected */
>  		mutex_unlock(&rproc->lock);
>  		return;
>  	}
>  
> +	if (rproc->state == RPROC_OFFLINE) {
> +		/* Don't recover if the remote processor was stopped */
> +		mutex_unlock(&rproc->lock);
> +		goto out;
> +	}
> +
>  	rproc->state = RPROC_CRASHED;
>  	dev_err(dev, "handling crash #%u in %s\n", ++rproc->crash_cnt,
>  		rproc->name);
> @@ -1877,6 +1883,7 @@ static void rproc_crash_handler_work(struct work_struct *work)
>  	if (!rproc->recovery_disabled)
>  		rproc_trigger_recovery(rproc);
>  
> +out:
>  	pm_relax(rproc->dev.parent);

I have applied this patch.

Thanks,
Mathieu

>  }
>  
> -- 
> 2.17.1
> 
