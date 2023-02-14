Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29308696A39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjBNQsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBNQsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:48:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE53AAE;
        Tue, 14 Feb 2023 08:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B03DB81BF9;
        Tue, 14 Feb 2023 16:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F89C433EF;
        Tue, 14 Feb 2023 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676393292;
        bh=pIGfIUyELnj1r2C49mieQLwNusabnsLyOs47P3KXPeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsLd7sab/dP2RG1Pz26VDBcWibqcVpaT1tF6jRx0V50LaGHdqEm2Np7ZsPkd88UUW
         iqyCGDk908fqDScRlH9julU5+ZOWipd1CfWqStaGT+kDdkOD9vPhNoLBXdbl5QsyjD
         YabVD8VkJhZf36QMa9xlBLk8OP/yHzpvU5cLtNBhlLOjvhlO/tchaLLblYafV+cGyf
         u7xbGv44ZIPh5pwZR2WfAOXE8kkJ0kfOYn082Ca94D0s+TkUfUTkIUpWRL5Kn0T7s+
         mWn6h+x0N5GPBDzWnAMEG8K/4TpLTheWNezIFCn2YNEcC6dUXTnuwT15AlrIThrv3Q
         f2l1m7dd2HTug==
Date:   Tue, 14 Feb 2023 08:50:16 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc:     mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: sysfs/debugfs: fix race while updating
 recovery flag
Message-ID: <20230214165016.fteeddbwjjyiwxwb@ripper>
References: <20230201054609.14575-1-quic_satyap@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201054609.14575-1-quic_satyap@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:46:08PM -0800, Satya Durga Srinivasu Prabhala wrote:
> When multiple clients try to update the recovery flag, it is
> possible that, race condition would lead to undesired results
> as updates to recovery flag isn't protected by any mechanism
> today. To avoid such issues, take remoteproc mutex lock before
> updating recovery flag and release the lock once done.
> 

The only query of recovery_disabled that I can see is in
rproc_crash_handler_work(), outside of any lock. So I'm not able to see
the issue you're referring to.

Can you please help me understand better?

Thanks,
Bjorn

> Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
> ---
> v1 -> v2:
> - addressed comments from Mukesh Ojha
>   1. take & release lock only while updating recovery flag
>   2. update debugfs
> 
>  drivers/remoteproc/remoteproc_debugfs.c | 4 ++++
>  drivers/remoteproc/remoteproc_sysfs.c   | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index b86c1d09c70c..2c44d375024e 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -226,10 +226,14 @@ rproc_recovery_write(struct file *filp, const char __user *user_buf,
>  
>  	if (!strncmp(buf, "enabled", count)) {
>  		/* change the flag and begin the recovery process if needed */
> +		mutex_lock(&rproc->lock);
>  		rproc->recovery_disabled = false;
> +		mutex_unlock(&rproc->lock);
>  		rproc_trigger_recovery(rproc);
>  	} else if (!strncmp(buf, "disabled", count)) {
> +		mutex_lock(&rproc->lock);
>  		rproc->recovery_disabled = true;
> +		mutex_unlock(&rproc->lock);
>  	} else if (!strncmp(buf, "recover", count)) {
>  		/* begin the recovery process without changing the flag */
>  		rproc_trigger_recovery(rproc);
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 8c7ea8922638..628e0de9a132 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -50,10 +50,14 @@ static ssize_t recovery_store(struct device *dev,
>  
>  	if (sysfs_streq(buf, "enabled")) {
>  		/* change the flag and begin the recovery process if needed */
> +		mutex_lock(&rproc->lock);
>  		rproc->recovery_disabled = false;
> +		mutex_unlock(&rproc->lock);
>  		rproc_trigger_recovery(rproc);
>  	} else if (sysfs_streq(buf, "disabled")) {
> +		mutex_lock(&rproc->lock);
>  		rproc->recovery_disabled = true;
> +		mutex_unlock(&rproc->lock);
>  	} else if (sysfs_streq(buf, "recover")) {
>  		/* begin the recovery process without changing the flag */
>  		rproc_trigger_recovery(rproc);
> -- 
> 2.38.1
> 
