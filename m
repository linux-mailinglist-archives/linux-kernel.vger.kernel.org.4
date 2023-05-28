Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3471376A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjE1Blk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 21:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1Blj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 21:41:39 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA12D8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 18:41:39 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38252)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q35Pd-004hje-8d; Sat, 27 May 2023 19:41:37 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:55318 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q35Pb-003vjS-Tg; Sat, 27 May 2023 19:41:36 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info,
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
        <c6e9a5db-798f-fa40-5ae2-a41f2d8ebab5@oracle.com>
Date:   Sat, 27 May 2023 20:41:29 -0500
In-Reply-To: <c6e9a5db-798f-fa40-5ae2-a41f2d8ebab5@oracle.com> (Mike
        Christie's message of "Thu, 25 May 2023 11:15:59 -0500")
Message-ID: <87a5xpkzau.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q35Pb-003vjS-Tg;;;mid=<87a5xpkzau.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+V2Qg3ULEu3+aeUbHP6A32iBYl7ldKMoo=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mike Christie <michael.christie@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 721 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 14 (2.0%), b_tie_ro: 12 (1.7%), parse: 1.60
        (0.2%), extract_message_metadata: 5 (0.7%), get_uri_detail_list: 1.58
        (0.2%), tests_pri_-2000: 5 (0.7%), tests_pri_-1000: 4.0 (0.5%),
        tests_pri_-950: 1.95 (0.3%), tests_pri_-900: 1.59 (0.2%),
        tests_pri_-200: 1.28 (0.2%), tests_pri_-100: 5 (0.7%), tests_pri_-90:
        458 (63.5%), check_bayes: 455 (63.1%), b_tokenize: 8 (1.1%),
        b_tok_get_all: 228 (31.6%), b_comp_prob: 3.4 (0.5%), b_tok_touch_all:
        212 (29.4%), b_finish: 0.89 (0.1%), tests_pri_0: 200 (27.8%),
        check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 3.0 (0.4%),
        poll_dns_idle: 1.25 (0.2%), tests_pri_10: 2.2 (0.3%), tests_pri_500: 7
        (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> On 5/23/23 7:15 AM, Oleg Nesterov wrote:
>> 
>> Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
>> before we call work->fn(). Is it "safe" to run this callback with
>> signal_pending() or fatal_signal_pending() ?
>
> The questions before this one I'll leave for the core vhost devs since
> they know best.

Let me ask a clarifying question:

Is it only the call to schedule() in vhost_worker that you are worried
about not sleeping if signal_pending() or fatal_signal_pending()?

Is there concern that the worker functions aka "work->fn()" will also
have killable or interruptible sleeps that also will misbehave.

We can handle schedule() in vhost_worker without problem.

If a worker function has interruptible or killable sleeps that will turn
into busy waits or worse not sleeping long enough that seems like a
problem.  There is no way to guarantee that the outer loop of
vhost_worker will protect the worker functions from signal_pending()
or fatal_signal_pending() becoming true.


Eric
