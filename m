Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE24470E0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbjEWPkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjEWPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:40:07 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B781FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:40:06 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:34724)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q1U7I-003qxd-SS; Tue, 23 May 2023 09:40:05 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:41738 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q1U7H-007qRy-L3; Tue, 23 May 2023 09:40:04 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, oleg@redhat.com,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
        <20230522025124.5863-4-michael.christie@oracle.com>
        <20230522153852-mutt-send-email-mst@kernel.org>
Date:   Tue, 23 May 2023 10:39:56 -0500
In-Reply-To: <20230522153852-mutt-send-email-mst@kernel.org> (Michael
        S. Tsirkin's message of "Mon, 22 May 2023 15:40:48 -0400")
Message-ID: <87cz2r83ar.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q1U7H-007qRy-L3;;;mid=<87cz2r83ar.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19NgfMb/ImKg6q5N6Tu8xjjRvYEjWNx4d8=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;"Michael S. Tsirkin" <mst@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 411 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.1 (1.0%), b_tie_ro: 2.8 (0.7%), parse: 0.65
        (0.2%), extract_message_metadata: 3.0 (0.7%), get_uri_detail_list:
        1.46 (0.4%), tests_pri_-2000: 2.2 (0.5%), tests_pri_-1000: 1.79 (0.4%),
         tests_pri_-950: 0.92 (0.2%), tests_pri_-900: 0.90 (0.2%),
        tests_pri_-200: 0.63 (0.2%), tests_pri_-100: 9 (2.1%), tests_pri_-90:
        58 (14.1%), check_bayes: 57 (13.8%), b_tokenize: 6 (1.6%),
        b_tok_get_all: 9 (2.3%), b_comp_prob: 1.83 (0.4%), b_tok_touch_all: 36
        (8.9%), b_finish: 0.63 (0.2%), tests_pri_0: 313 (76.1%),
        check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 4.4 (1.1%),
        poll_dns_idle: 0.95 (0.2%), tests_pri_10: 2.6 (0.6%), tests_pri_500: 9
        (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Sun, May 21, 2023 at 09:51:24PM -0500, Mike Christie wrote:
>> When switching from kthreads to vhost_tasks two bugs were added:
>> 1. The vhost worker tasks's now show up as processes so scripts doing ps
>> or ps a would not incorrectly detect the vhost task as another process.
>> 2. kthreads disabled freeze by setting PF_NOFREEZE, but vhost tasks's
>> didn't disable or add support for them.
>> 
>> To fix both bugs, this switches the vhost task to be thread in the
>> process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
>> get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
>> SIGKILL/STOP support is required because CLONE_THREAD requires
>> CLONE_SIGHAND which requires those 2 signals to be suppported.
>> 
>> This a modified version of patch originally written by Linus which
>> handles his review comment to himself to rename ignore_signals to
>> block_signals to better represent what it now does. And it includes a
>> change to vhost_worker() to support SIGSTOP/KILL and freeze, and it
>> drops the wait use per Oleg's review comment that it's no longer needed
>> when using CLONE_THREAD.
>> 
>> Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>>  drivers/vhost/vhost.c      | 17 ++++++++++++++++-
>>  include/linux/sched/task.h |  2 +-
>>  kernel/fork.c              | 12 +++---------
>>  kernel/signal.c            |  1 +
>>  kernel/vhost_task.c        | 16 ++++------------
>>  5 files changed, 25 insertions(+), 23 deletions(-)
>> 
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index a92af08e7864..bf83e9340e40 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -338,6 +338,7 @@ static int vhost_worker(void *data)
>>  	struct vhost_worker *worker = data;
>>  	struct vhost_work *work, *work_next;
>>  	struct llist_node *node;
>> +	bool dead = false;
>>  
>>  	for (;;) {
>>  		/* mb paired w/ kthread_stop */
>> @@ -349,8 +350,22 @@ static int vhost_worker(void *data)
>>  		}
>>  
>>  		node = llist_del_all(&worker->work_list);
>> -		if (!node)
>> +		if (!node) {
>>  			schedule();
>> +			/*
>> +			 * When we get a SIGKILL our release function will
>> +			 * be called. That will stop new IOs from being queued
>> +			 * and check for outstanding cmd responses. It will then
>> +			 * call vhost_task_stop to tell us to return and exit.
>> +			 */
>> +			if (!dead && signal_pending(current)) {
>> +				struct ksignal ksig;
>> +
>> +				dead = get_signal(&ksig);
>> +				if (dead)
>> +					clear_thread_flag(TIF_SIGPENDING);
>
>
> Does get_signal actually return true only on SIGKILL then?

get_signal returns the signal that was dequeued, or 0 if no signal was
dequeued.

For these threads that block all but SIGSTOP and SIGKILL get_signal
should properly never return any signal.  As SIGSTOP and SIGKILL are
handled internally to get_signal.

However get_signal was modified to have a special case for io_uring
and now the vhost code so that extra cleanup can be performed, before
do_exit is called on the thread.  That special case causes get_signal
to return when with the value of SIGKILL when the process exits.

The process can exit with do_group_exit aka exit(2) or any fatal signal
not just SIGKILL, and get_signal on these threads will return.

Eric
