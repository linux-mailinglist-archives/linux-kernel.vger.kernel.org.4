Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6281C63695F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiKWS6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiKWS6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:58:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EEB5A6CF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:58:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so2960051pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWaagzOk9zMNOAZyOy8bc0Y6K7qbOoK1v1I3u1GoRaY=;
        b=fubQIi5tXuVOsTMltBgdbbDO7JL8EXf+ZuG81LEBXYGXSGt/FhosagYWuqWGbyHuZm
         wcJ3YXMn7GJVVRq1joN1VjKjDv/xDjdUG/YXUCAZiiyOfJbwAOo1XhgM8sZs0L1ZwILI
         /fyklASZCe4JvuZXOYgEkwI9Vk5+caRcaG28YWOK1m/5yyRPI8sD+YhEkINd/ehGjGXI
         YKXTjdvema283kO9ooVfRo1JulkHNscysD0yakpqsixvNviWVZNAo4uYk5L7UigOw8IS
         8vsivNOcpQzFGMtIDro1CAFHH3/P2cmZnTSGZDbC+OMyGGxVTQUhiajl9hyesMTNNVLP
         SSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWaagzOk9zMNOAZyOy8bc0Y6K7qbOoK1v1I3u1GoRaY=;
        b=BagZcYebfFMVXpZDkNdoOiRhWQT2emiyze3323hkhB2g9098Z5BLBObICVbNj+HMaS
         KO64/YkUE63heUZQCSwWabuA3Muc/1AgyBL1qhzs4wZGg0iODr5o8+65Ki7BqqlO0WFU
         zNTGChxxMsw6MbpDHX5lenEP4GXyPzYhmUzRbcQviKRr6VfbU5WYz745GdxWbyQXJL3h
         mH0QEOQiojPYwjl3XN3kr9LyLFpyEKDNieOhcWJtlgWjbqR2TFt4lS2u1zF/Bc9Ix0Y0
         Q6fBNiCjYLvlIFdMpQzSLo/CRp3oPYS5VUFWNPYHcxlJh74xoccNOBGi1MLavkH653mG
         IZFw==
X-Gm-Message-State: ANoB5pk5oCBge+gQ1QGQWaU59bFRgcRud3bhU3WTHXv3sqHMu0liOr95
        1g6IEM6Zu3yCMhizmy0xOocI+w==
X-Google-Smtp-Source: AA0mqf7OGhN2Sbd8Zu7+aU+RUc2WvaTOwNsnDCTkd4g3Ryyd+PpuEsm3pw/YA91DXTCGn7HAW4WvVA==
X-Received: by 2002:a17:90b:1650:b0:218:6ad0:52c5 with SMTP id il16-20020a17090b165000b002186ad052c5mr4442697pjb.44.1669229914531;
        Wed, 23 Nov 2022 10:58:34 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f54f00b00188fdae6e0esm12868203plf.44.2022.11.23.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:58:33 -0800 (PST)
Date:   Wed, 23 Nov 2022 18:58:29 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Li Li <dualli@chromium.org>
Cc:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, surenb@google.com, arnd@arndb.de,
        masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] binder: return pending info for frozen async txns
Message-ID: <Y35tVQb2y+gRdfpb@google.com>
References: <20221110203405.611600-1-dualli@chromium.org>
 <20221110203405.611600-2-dualli@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110203405.611600-2-dualli@chromium.org>
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

On Thu, Nov 10, 2022 at 12:34:05PM -0800, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> An async transaction to a frozen process will still be successfully
> put in the queue. But this pending async transaction won't be processed
> until the target process is unfrozen at an unspecified time in the
> future. Pass this important information back to the user space caller
> by returning BR_TRANSACTION_PENDING.
> 
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  drivers/android/binder.c            | 31 +++++++++++++++++++++++------
>  drivers/android/binder_internal.h   |  3 ++-
>  include/uapi/linux/android/binder.h |  7 ++++++-
>  3 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 880224ec6abb..a798f6661488 100644
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
> @@ -2738,6 +2741,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
>  	bool oneway = !!(t->flags & TF_ONE_WAY);
>  	bool pending_async = false;
>  	struct binder_transaction *t_outdated = NULL;
> +	bool frozen = false;
>  
>  	BUG_ON(!node);
>  	binder_node_lock(node);
> @@ -2751,15 +2755,16 @@ static int binder_proc_transaction(struct binder_transaction *t,
>  
>  	binder_inner_proc_lock(proc);
>  	if (proc->is_frozen) {
> +		frozen = true;
>  		proc->sync_recv |= !oneway;
>  		proc->async_recv |= oneway;
>  	}
>  
> -	if ((proc->is_frozen && !oneway) || proc->is_dead ||
> +	if ((frozen && !oneway) || proc->is_dead ||
>  			(thread && thread->is_dead)) {
>  		binder_inner_proc_unlock(proc);
>  		binder_node_unlock(node);
> -		return proc->is_frozen ? BR_FROZEN_REPLY : BR_DEAD_REPLY;
> +		return frozen ? BR_FROZEN_REPLY : BR_DEAD_REPLY;
>  	}
>  
>  	if (!thread && !pending_async)
> @@ -2770,7 +2775,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
>  	} else if (!pending_async) {
>  		binder_enqueue_work_ilocked(&t->work, &proc->todo);
>  	} else {
> -		if ((t->flags & TF_UPDATE_TXN) && proc->is_frozen) {
> +		if ((t->flags & TF_UPDATE_TXN) && frozen) {
>  			t_outdated = binder_find_outdated_transaction_ilocked(t,
>  									      &node->async_todo);
>  			if (t_outdated) {
> @@ -2807,6 +2812,9 @@ static int binder_proc_transaction(struct binder_transaction *t,
>  		binder_stats_deleted(BINDER_STAT_TRANSACTION);
>  	}
>  
> +	if (oneway && frozen)
> +		return BR_TRANSACTION_PENDING;
> +
>  	return 0;
>  }
>  
> @@ -3607,9 +3615,16 @@ static void binder_transaction(struct binder_proc *proc,
>  	} else {
>  		BUG_ON(target_node == NULL);
>  		BUG_ON(t->buffer->async_transaction != 1);
> -		binder_enqueue_thread_work(thread, tcomplete);
>  		return_error = binder_proc_transaction(t, target_proc, NULL);
> -		if (return_error)
> +		/*
> +		 * Let the caller know when async transaction reaches a frozen
> +		 * process and is put in a pending queue, waiting for the target
> +		 * process to be unfrozen.
> +		 */
> +		if (return_error == BR_TRANSACTION_PENDING)
> +			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
> +		binder_enqueue_thread_work(thread, tcomplete);
> +		if (return_error && return_error != BR_TRANSACTION_PENDING)
>  			goto err_dead_proc_or_thread;
>  	}
>  	if (target_thread)
> @@ -4440,10 +4455,13 @@ static int binder_thread_read(struct binder_proc *proc,
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
> @@ -6170,6 +6188,7 @@ static const char * const binder_return_strings[] = {
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

This looks good. Could you rename the new op to signify the frozen
scenario though? We might have some other instances of pending
transactions in the future so might as well be specific here.
