Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD9070860B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjERQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjERQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF87B3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684427171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N0VBaOKRYTVXJE7z+8gKbNWq3wyr8YL28adwGI5M+8Q=;
        b=DCORfyWOWZTH4RUdQkYEotrbDaBDq7rmrung2Il2lcqgbVhprM9KfA50kpxNsE/MWdKpcr
        ua7nQYShRBddGbZvgbJVDqKupq3fSK2rPxgB5eFzrPnoslVenEU5VBehEF2WfO2RGgv/hu
        b0Z5QD1xUtHl2eZt+Ed1cJGdn/7nXOc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-xlcIGl63Ncy0qqjYJ0vFaw-1; Thu, 18 May 2023 12:26:07 -0400
X-MC-Unique: xlcIGl63Ncy0qqjYJ0vFaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E18C805F58;
        Thu, 18 May 2023 16:26:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D4651121314;
        Thu, 18 May 2023 16:26:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 May 2023 18:25:52 +0200 (CEST)
Date:   Thu, 18 May 2023 18:25:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Message-ID: <20230518162508.GB20779@redhat.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
 <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I too do not understand the 1st change in this patch ...

On 05/18, Mike Christie wrote:
>
> In the other patches we do:
>
> if (get_signal(ksig))
> 	start_exit_cleanup_by_stopping_newIO()
> 	flush running IO()
> 	exit()
>
> But to do the flush running IO() part of this I need to wait for it so
> that's why I wanted to be able to dequeue the SIGKILL and clear the
> TIF_SIGPENDING bit.

But get_signal() will do what you need, dequeue SIGKILL and clear SIGPENDING ?

	if ((signal->flags & SIGNAL_GROUP_EXIT) ||
	     signal->group_exec_task) {
		clear_siginfo(&ksig->info);
		ksig->info.si_signo = signr = SIGKILL;
		sigdelset(&current->pending.signal, SIGKILL);

this "dequeues" SIGKILL,

		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
			&sighand->action[SIGKILL - 1]);
		recalc_sigpending();

this clears TIF_SIGPENDING.

> Or I don't need this specifically. In patch 0/8 I said I knew you guys
> would not like it :) If I just have a:
>
> if (fatal_signal())
> 	clear_fatal_signal()

see above...


Well... I think this code is actually wrong if if SIGSTOP is pending and
the task is PF_IO_WORKER, but this is also true for io-threads so we can
discuss this separately.

Oleg.

