Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3316236BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiKIWns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKIWnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:43:46 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D332BF5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:43:45 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v28so61650pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 14:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gERt6h/ap8XHsVXDTKbPJYqRBL/jF7bzhvkaukkk6Qw=;
        b=mWvsHi3syvtdYmcYucOn75lrcunBDJSTaklSxe1mUeJ9sUHjr818yQOUISLHzaUnq4
         fP/uaWa40BGQyjTLGUZD/2W+xKQ5ygP/Rq40sm1mG4tMFAiEKh9HQrhaUL0MVqzHOT8U
         UGzZrBdTx0kpP8wTGcVXfivk3pDo2Cn3IER7cctkbrtRwdErrioynfY/mgFfC79aPiay
         ur9leRBSUIfoY7CwZJk7YRMDaIfeyNG+S3InRWkD9zWeugu0x3zdD3F3j1b8kvaxuIHD
         cDkW8rQ96jHytr7laT1i0Y7JswIVwjz+wuY+5Xf5eKNg5RBVMdubytf+XrinucJjEEBU
         MRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gERt6h/ap8XHsVXDTKbPJYqRBL/jF7bzhvkaukkk6Qw=;
        b=WythzooJyHmq8aqt2W1h+v/qjK9eW9/ECS0PMogXCHX9o+8g94gdo5V/wskVP9F/GJ
         hPmvd+YJwR+myhKNGcPBLjwgsySYyYLTiBJKkEmuFYdCWv8sEiIqtSzG2hgcDHvu/Mah
         kh/Nr0Gk2tY6RQo9oP3HmlOxzV3TnWToVEmdE1GbNoXnmsvrzIbMBwbbIMRZoH2i0fHE
         GfL8Efbe5LMUX+qJ28wT36KhNYGvawqV9gf1gNtCRAI4o3vu+0DQdBP2sfS61J5h8wrU
         lg5KTijaNgdfAb5PDZuHbzZ4Ocz3TIf94q6x9BCZ21py1kzvxMxbg2gOuKfbxBrLZ3l/
         CVaQ==
X-Gm-Message-State: ACrzQf0GknxLBa6Lv5MOb4FYb/HXID2S7nQ/Z4RlJS0mfgbWhHaBvgfa
        nuMzkjH6Pxgs1g3UFnQBJiOM3w==
X-Google-Smtp-Source: AMsMyM4vl0uMbAXjvECvZJb6ZCbCJxxPS+izkZIRDQPAbvlOJ7Aw3tNzOwaXDdpTrWoaZaluogtGXA==
X-Received: by 2002:a65:4c0e:0:b0:46a:eeb1:e78a with SMTP id u14-20020a654c0e000000b0046aeeb1e78amr53640227pgq.193.1668033824427;
        Wed, 09 Nov 2022 14:43:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7952d000000b0056c360af4e3sm8798683pfp.9.2022.11.09.14.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:43:43 -0800 (PST)
Date:   Wed, 9 Nov 2022 22:43:40 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Li Li <dualli@chromium.org>
Cc:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, surenb@google.com, arnd@arndb.de,
        masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v1 1/1] binder: return pending info for frozen async txns
Message-ID: <Y2wtHBPMyxfkKiSg@google.com>
References: <20221103190549.3446167-1-dualli@chromium.org>
 <20221103190549.3446167-2-dualli@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103190549.3446167-2-dualli@chromium.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:05:49PM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> An async transaction to a frozen process will still be successsfully

nit: sucessfully typo

> put in the queue. But this pending async transaction won't be processed
> until the target process is unfrozen at an unspecified time in the
> future. Pass this important information back to the user space caller
> by returning BR_TRANSACTION_PENDING.
> 
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  drivers/android/binder.c            | 23 ++++++++++++++++++++---
>  drivers/android/binder_internal.h   |  3 ++-
>  include/uapi/linux/android/binder.h |  7 ++++++-
>  3 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 880224ec6abb..a097b89f6a7a 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2728,7 +2728,10 @@ binder_find_outdated_transaction_ilocked(struct binder_transaction *t,
>   *
>   * Return:	0 if the transaction was successfully queued
>   *		BR_DEAD_REPLY if the target process or thread is dead
> - *		BR_FROZEN_REPLY if the target process or thread is frozen
> + *		BR_FROZEN_REPLY if the target process or thread is frozen and
> + *			the sync transaction was rejected
> + *		BR_TRANSACTION_PENDING if the target process is frozen and the
> + *			async transaction was successfully queued
>   */
>  static int binder_proc_transaction(struct binder_transaction *t,
>  				    struct binder_proc *proc,
> @@ -2807,6 +2810,9 @@ static int binder_proc_transaction(struct binder_transaction *t,
>  		binder_stats_deleted(BINDER_STAT_TRANSACTION);
>  	}
>  
> +	if (oneway && proc->is_frozen)

Do you need the inner lock here for proc->is_frozen?

> +		return BR_TRANSACTION_PENDING;
> +
>  	return 0;
>  }
>  
> @@ -3607,9 +3613,16 @@ static void binder_transaction(struct binder_proc *proc,
>  	} else {
>  		BUG_ON(target_node == NULL);
>  		BUG_ON(t->buffer->async_transaction != 1);
> -		binder_enqueue_thread_work(thread, tcomplete);
>  		return_error = binder_proc_transaction(t, target_proc, NULL);
> -		if (return_error)
> +		/*
> +		 * Let the caller know its async transaction reaches a frozen

nit: I believe you meant s/its/when or similar?

> +		 * process and is put in a pending queue, waiting for the target
> +		 * process to be unfrozen.
> +		 */
> +		if (return_error == BR_TRANSACTION_PENDING)
> +			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
> +		binder_enqueue_thread_work(thread, tcomplete);

I wonder if switching the order of queuing the tcomplete here and waking
up the target thread inside binder_proc_transaction() will have any
performance implications if this task gets scheduled out.

> +		if (return_error && return_error != BR_TRANSACTION_PENDING)
>  			goto err_dead_proc_or_thread;
>  	}
>  	if (target_thread)
> @@ -4440,10 +4453,13 @@ static int binder_thread_read(struct binder_proc *proc,
>  			binder_stat_br(proc, thread, cmd);
>  		} break;
>  		case BINDER_WORK_TRANSACTION_COMPLETE:
> +		case BINDER_WORK_TRANSACTION_PENDING:
>  		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT: {
>  			if (proc->oneway_spam_detection_enabled &&
>  				   w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
>  				cmd = BR_ONEWAY_SPAM_SUSPECT;
> +			else if (w->type == BINDER_WORK_TRANSACTION_PENDING)
> +				cmd = BR_TRANSACTION_PENDING;
>  			else
>  				cmd = BR_TRANSACTION_COMPLETE;
>  			binder_inner_proc_unlock(proc);
> @@ -6170,6 +6186,7 @@ static const char * const binder_return_strings[] = {
>  	"BR_FAILED_REPLY",
>  	"BR_FROZEN_REPLY",
>  	"BR_ONEWAY_SPAM_SUSPECT",
> +	"BR_TRANSACTION_PENDING"
>  };
>  
>  static const char * const binder_command_strings[] = {
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index abe19d88c6ec..6c51325a826f 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -133,7 +133,7 @@ enum binder_stat_types {
>  };
>  
>  struct binder_stats {
> -	atomic_t br[_IOC_NR(BR_ONEWAY_SPAM_SUSPECT) + 1];
> +	atomic_t br[_IOC_NR(BR_TRANSACTION_PENDING) + 1];
>  	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
>  	atomic_t obj_created[BINDER_STAT_COUNT];
>  	atomic_t obj_deleted[BINDER_STAT_COUNT];
> @@ -152,6 +152,7 @@ struct binder_work {
>  	enum binder_work_type {
>  		BINDER_WORK_TRANSACTION = 1,
>  		BINDER_WORK_TRANSACTION_COMPLETE,
> +		BINDER_WORK_TRANSACTION_PENDING,
>  		BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT,
>  		BINDER_WORK_RETURN_ERROR,
>  		BINDER_WORK_NODE,
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index e72e4de8f452..c21b3b3eb4e4 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -450,7 +450,7 @@ enum binder_driver_return_protocol {
>  
>  	BR_FROZEN_REPLY = _IO('r', 18),
>  	/*
> -	 * The target of the last transaction (either a bcTRANSACTION or
> +	 * The target of the last sync transaction (either a bcTRANSACTION or
>  	 * a bcATTEMPT_ACQUIRE) is frozen.  No parameters.
>  	 */
>  
> @@ -460,6 +460,11 @@ enum binder_driver_return_protocol {
>  	 * asynchronous transaction makes the allocated async buffer size exceed
>  	 * detection threshold.  No parameters.
>  	 */
> +
> +	BR_TRANSACTION_PENDING = _IO('r', 20),
> +	/*
> +	 * The target of the last async transaction is frozen.  No parameters.
> +	 */
>  };
>  
>  enum binder_driver_command_protocol {
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
