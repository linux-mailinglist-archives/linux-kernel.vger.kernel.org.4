Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A005370E075
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbjEWPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEWPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:31:09 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66A1FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:31:07 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:34090)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q1Tyb-00EE6n-4l; Tue, 23 May 2023 09:31:05 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:45292 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q1TyZ-007oCX-Qg; Tue, 23 May 2023 09:31:04 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
In-Reply-To: <20230522025124.5863-2-michael.christie@oracle.com> (Mike
        Christie's message of "Sun, 21 May 2023 21:51:22 -0500")
References: <20230522025124.5863-1-michael.christie@oracle.com>
        <20230522025124.5863-2-michael.christie@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 23 May 2023 10:30:35 -0500
Message-ID: <87fs7n9ias.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q1TyZ-007oCX-Qg;;;mid=<87fs7n9ias.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+s/DSlpo+vEYOge0Lgj9pKdKRgJGOmkLw=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mike Christie <michael.christie@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 715 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.4%), b_tie_ro: 8 (1.2%), parse: 1.52 (0.2%),
         extract_message_metadata: 22 (3.1%), get_uri_detail_list: 3.0 (0.4%),
        tests_pri_-2000: 18 (2.5%), tests_pri_-1000: 3.9 (0.5%),
        tests_pri_-950: 1.86 (0.3%), tests_pri_-900: 1.55 (0.2%),
        tests_pri_-200: 1.25 (0.2%), tests_pri_-100: 11 (1.5%), tests_pri_-90:
        67 (9.4%), check_bayes: 62 (8.6%), b_tokenize: 13 (1.8%),
        b_tok_get_all: 9 (1.3%), b_comp_prob: 3.9 (0.5%), b_tok_touch_all: 31
        (4.4%), b_finish: 1.04 (0.1%), tests_pri_0: 558 (78.1%),
        check_dkim_signature: 0.60 (0.1%), check_dkim_adsp: 10 (1.4%),
        poll_dns_idle: 8 (1.1%), tests_pri_10: 3.9 (0.5%), tests_pri_500: 9
        (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] signal: Don't always put SIGKILL in shared_pending
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> When get_pending detects the task has been marked to be killed we try to
       ^^^^^^^^^^^ get_signal
> clean up the SIGKLL by doing a sigdelset and recalc_sigpending, but we
> still leave it in shared_pending. If the signal is being short circuit
> delivered there is no need to put in shared_pending so this adds a check
> in complete_signal.
>
> This patch was modified from Eric Biederman <ebiederm@xmission.com>
> original patch.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  kernel/signal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..3dc99b9aec7f 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1052,6 +1052,14 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>  			signal->flags = SIGNAL_GROUP_EXIT;
>  			signal->group_exit_code = sig;
>  			signal->group_stop_count = 0;
> +
> +			/*
> +			 * The signal is being short circuit delivered so
> +			 * don't set pending.
> +			 */
> +			if (type != PIDTYPE_PID)
> +				sigdelset(&signal->shared_pending.signal, sig);
> +
>  			t = p;
>  			do {
>  				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);

Oleg Nesterov <oleg@redhat.com> writes:
>
> Eric, sorry. I fail to understand this patch.
>
> How can it help? And whom?

You were looking at why recalc_sigpending was resulting in
TIF_SIGPENDING set.

The big bug was that get_signal was getting called by the thread after
the thread had realized it was part of a group exit.

The minor bug is that SIGKILL was stuck in shared_pending and causing
recalc_sigpending to set TIF_SIGPENDING after get_signal removed the
per thread flag that asks the thread to exit.



The fact is that fatal signals (that pass all of the checks) are
delivered right there in complete_signal so it does not make sense from
a data structure consistency standpoint to leave the fatal signal (like
SIGKILL) in shared_pending.

Outside of this case it will only affect coredumps and other analyzers
that run at process exit.



One thing I am looking at is that the vhost code shares a common problem
with the coredump code to pipes.  There is code that tests
signal_pending() and does something with it after signal processing has
completed.

Fixing the data structure to be consistent seems like one way to handle
that situation.

Eric
