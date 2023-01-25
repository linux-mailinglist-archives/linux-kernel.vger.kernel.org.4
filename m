Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27F67B5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjAYPSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjAYPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:18:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA010F2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674659846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+72qkNOq5RMTaBAvY8lwUcPUyphuIdSxxM26w+0GHU=;
        b=c7u4HON1/V7O5j7yiP0wz5WBLPf5N4sr8DWElIbuHS73A4WCMEihqBbNdWGBFQWfuH05mh
        luIUna6jlKOl7Q17FNVcLACCFAaG/vkwx+Kx36n36V802ZS4AG7OrRnoGuhaVheQfT8tHB
        Z8vO0WFZ0emDB/YGRMhSIL9NV6GPEQ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-eZuIKS6RP-CEviKn2zUA_g-1; Wed, 25 Jan 2023 10:17:23 -0500
X-MC-Unique: eZuIKS6RP-CEviKn2zUA_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D039801779;
        Wed, 25 Jan 2023 15:17:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-195-63.brq.redhat.com [10.40.195.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id DCC141121333;
        Wed, 25 Jan 2023 15:17:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Jan 2023 16:17:20 +0100 (CET)
Date:   Wed, 25 Jan 2023 16:17:17 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH v2] posix-timers: Support delivery of signals to the
 current thread
Message-ID: <20230125151717.GB13746@redhat.com>
References: <20221216171807.760147-1-dvyukov@google.com>
 <20230112112411.813356-1-dvyukov@google.com>
 <20230125124304.GA13746@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125124304.GA13746@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25, Oleg Nesterov wrote:
>
> Other than that I see nothing wrong in this patch, but I forgot everything
> about posix timers many years ago ;)

Stupid question. Am I right that in posix_timer_event()

	same_thread_group(current, pid_task(timr->it_pid, PIDTYPE_PID))

is always true?

If yes, perhaps we can do a much simpler change which doesn't even affect API?
See the trivial patch below.

send_sigqueue(PIDTYPE_TGID) notify any thread in thread group, so this doesn't
really change the semantics, just complete_signal() will likely choose "current"
as a target for signal_wake_up() and iiuc this is what we want for balancing?

Oleg.


diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 5dead89308b7..e38b53a0f814 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -336,6 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 int posix_timer_event(struct k_itimer *timr, int si_private)
 {
 	enum pid_type type;
+	struct pid *pid;
 	int ret;
 	/*
 	 * FIXME: if ->sigq is queued we can race with
@@ -350,8 +351,9 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
 	 */
 	timr->sigq->info.si_sys_private = si_private;
 
-	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type);
+	type = (timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_PID : PIDTYPE_TGID;
+	pid = (type == PIDTYPE_PID) ? timr->it_pid : task_pid(current);
+	ret = send_sigqueue(timr->sigq, pid, type);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }

