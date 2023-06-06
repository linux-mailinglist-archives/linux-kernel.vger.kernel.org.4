Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D472407C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjFFLGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjFFLGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8EBE8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686049515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MCwDwfPHJIt+6tk1yiL/jEP6sCYRuTSRBSo5L9XNdFs=;
        b=HjanKBCyWod3hzBFGtALuNIBrVhEUs+14zRm4DB/inhvGxCayBc9qt/Eer0vTD1kD6Mo/5
        tEtu+ncWqjE9Ydb04449FVwiQpT9e9AuhZ+L0pkXMWS5aY5XAbDF2mg7vK0/j2nkw0kU55
        h/BxylXn3izccP5Xg9MHhjYKtWS1MP8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-pqXRnz_lPFyt2Li51mKfBw-1; Tue, 06 Jun 2023 07:05:13 -0400
X-MC-Unique: pqXRnz_lPFyt2Li51mKfBw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C74E3C0F220;
        Tue,  6 Jun 2023 11:05:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id C689340218C;
        Tue,  6 Jun 2023 11:05:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Jun 2023 13:04:50 +0200 (CEST)
Date:   Tue, 6 Jun 2023 13:04:48 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST 2/2] signal: Don't disable preemption in
 ptrace_stop() on PREEMPT_RT.
Message-ID: <20230606110447.GA7542@redhat.com>
References: <20230606085524.2049961-1-bigeasy@linutronix.de>
 <20230606085524.2049961-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606085524.2049961-3-bigeasy@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch LGTM, but I am a bit confused by the changelog/comments,
I guess I missed something...

On 06/06, Sebastian Andrzej Siewior wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2328,11 +2328,16 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
>  	 * The preempt-disable section ensures that there will be no preemption
>  	 * between unlock and schedule() and so improving the performance since
>  	 * the ptracer has no reason to sleep.
> +	 *
> +	 * This optimisation is not doable on PREEMPT_RT due to the spinlock_t
> +	 * within the preempt-disable section.
>  	 */
> -	preempt_disable();
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_disable();

Not only we the problems with cgroup_enter_frozen(), afaics (please correct me)
this optimisation doesn't work on RT anyway?

IIUC, read_lock() on RT disables migration but not preemption, so it is simply
too late to do preempt_disable() before unlock/schedule. The tracer can preempt
the tracee right after do_notify_parent_cldstop().

Oleg.

