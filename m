Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064C770865E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjERRFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjERRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F03D10FA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684429463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pZ7Kv25n2l/rgGBMQe8NyD9v4RBua/FQCAYmOFizbRM=;
        b=Z4vsiFUSG9gfh09i/6uDv/3kAvSl+LVNIK58l3QfWjqudCy8/dSry3VdKZBnl81dMmHW1J
        9NXjSAf7/Q91x15x5xuhN7IDUdoYlrznXMDNVAuAD1zpZ93AuDC9k+QMtmC/vPXCghS0zr
        N73zbmH5C5LBquxnrr8Y680UIfBf1j8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-oX24YEzFMHeZcFcVgyOA3A-1; Thu, 18 May 2023 13:04:20 -0400
X-MC-Unique: oX24YEzFMHeZcFcVgyOA3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 865E73806633;
        Thu, 18 May 2023 17:04:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4FC7440C2063;
        Thu, 18 May 2023 17:04:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 May 2023 19:04:04 +0200 (CEST)
Date:   Thu, 18 May 2023 19:04:00 +0200
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
Message-ID: <20230518170359.GC20779@redhat.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
 <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
 <20230518162508.GB20779@redhat.com>
 <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18, Mike Christie wrote:
>
> On 5/18/23 11:25 AM, Oleg Nesterov wrote:
> > I too do not understand the 1st change in this patch ...
> >
> > On 05/18, Mike Christie wrote:
> >>
> >> In the other patches we do:
> >>
> >> if (get_signal(ksig))
> >> 	start_exit_cleanup_by_stopping_newIO()
> >> 	flush running IO()
> >> 	exit()
> >>
> >> But to do the flush running IO() part of this I need to wait for it so
> >> that's why I wanted to be able to dequeue the SIGKILL and clear the
> >> TIF_SIGPENDING bit.
> >
> > But get_signal() will do what you need, dequeue SIGKILL and clear SIGPENDING ?
> >
> > 	if ((signal->flags & SIGNAL_GROUP_EXIT) ||
> > 	     signal->group_exec_task) {
> > 		clear_siginfo(&ksig->info);
> > 		ksig->info.si_signo = signr = SIGKILL;
> > 		sigdelset(&current->pending.signal, SIGKILL);
> >
> > this "dequeues" SIGKILL,

OOPS. this doesn't remove SIGKILL from current->signal->shared_pending

> >
> > 		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> > 			&sighand->action[SIGKILL - 1]);
> > 		recalc_sigpending();
> >
> > this clears TIF_SIGPENDING.

No, I was wrong, recalc_sigpending() won't clear TIF_SIGPENDING if
SIGKILL is in signal->shared_pending

> I see what you guys meant. TIF_SIGPENDING isn't getting cleared.
> I'll dig into why.

See above, sorry for confusion.



And again, there is another problem with SIGSTOP. To simplify, suppose
a PF_IO_WORKER thread does something like

	while (signal_pending(current))
		get_signal(...);

this will loop forever if (SIGNAL_GROUP_EXIT || group_exec_task) and
SIGSTOP is pending.

Oleg.

