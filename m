Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF27070F900
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjEXOpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbjEXOpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:45:15 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE501A4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:45:07 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:32916)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q1pjc-007WwM-J3; Wed, 24 May 2023 08:45:04 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:53910 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q1pjb-00BGTu-L9; Wed, 24 May 2023 08:45:04 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
        <20230522025124.5863-4-michael.christie@oracle.com>
        <20230522123029.GA22159@redhat.com>
        <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
        <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
        <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
        <20230524141022.GA19091@redhat.com>
Date:   Wed, 24 May 2023 09:44:29 -0500
In-Reply-To: <20230524141022.GA19091@redhat.com> (Oleg Nesterov's message of
        "Wed, 24 May 2023 16:10:23 +0200")
Message-ID: <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q1pjb-00BGTu-L9;;;mid=<87ttw1zt4i.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/h3a+xGe9HgY6D1YHRegHcTvlq0mGfsXU=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 367 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.9%), b_tie_ro: 9 (2.4%), parse: 0.79 (0.2%),
         extract_message_metadata: 3.1 (0.8%), get_uri_detail_list: 1.01
        (0.3%), tests_pri_-2000: 3.4 (0.9%), tests_pri_-1000: 2.5 (0.7%),
        tests_pri_-950: 1.45 (0.4%), tests_pri_-900: 1.25 (0.3%),
        tests_pri_-200: 1.02 (0.3%), tests_pri_-100: 3.5 (0.9%),
        tests_pri_-90: 95 (25.9%), check_bayes: 92 (25.1%), b_tokenize: 6
        (1.6%), b_tok_get_all: 7 (2.0%), b_comp_prob: 2.2 (0.6%),
        b_tok_touch_all: 72 (19.6%), b_finish: 1.21 (0.3%), tests_pri_0: 226
        (61.6%), check_dkim_signature: 0.54 (0.1%), check_dkim_adsp: 12 (3.2%),
         poll_dns_idle: 9 (2.6%), tests_pri_10: 2.4 (0.7%), tests_pri_500: 8
        (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/23, Eric W. Biederman wrote:
>>
>> I want to point out that we need to consider not just SIGKILL, but
>> SIGABRT that causes a coredump, as well as the process peforming
>> an ordinary exit(2).  All of which will cause get_signal to return
>> SIGKILL in this context.
>
> Yes, but probably SIGABRT/exit doesn't really differ from SIGKILL wrt
> vhost_worker().

Actually I think it reveals that exiting with SIGABRT will cause
a deadlock.

coredump_wait will wait for all of the threads to reach
coredump_task_exit.  Meanwhile vhost_worker is waiting for
all of the other threads to reach exit_files to close their
file descriptors.


So it looks like the final pieces of work will actually need to be moved
into to vhost_xxx_flush or vhost_xxx_release to avoid the exiting
threads from waiting on each other, instead of depending upon the
vhost_worker to do the work.

Which gets back to most of your other questions.

>> It is probably not the worst thing in the world, but what this means
>> is now if you pass a copy of the vhost file descriptor to another
>> process the vhost_worker will persist, and thus the process will persist
>> until that copy of the file descriptor is closed.
>
> Hadn't thought about it.
>
> I am fighting with internal bugzillas today, will try to write another
> email tomorrow.
>
> But before that, I would like to have an answer to my "main" question in
> my previois email. Otherwise I am still not sure I understand what exactly
> we need to fix.

Let me repeat your "main" question just for clarity here.

If a signal comes in after the signal_pending check but before the
"work->fn(work)" call is "work->fn(work)" expected to run correctly
with signal_pending() or fatal_signal_pending returning true?


Eric





