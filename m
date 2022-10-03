Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C3A5F3823
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJCVxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJCVxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:53:46 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CAB2AC6C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:53:46 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:58092)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofTNh-00928v-C1; Mon, 03 Oct 2022 15:53:45 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:44656 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofTNg-008ZSa-J2; Mon, 03 Oct 2022 15:53:45 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Date:   Mon, 03 Oct 2022 16:53:38 -0500
Message-ID: <87r0zowp3x.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ofTNg-008ZSa-J2;;;mid=<87r0zowp3x.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+j6XwdcQxX2W59WMBKK3JRt7AJ8C/bHYI=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 268 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 12 (4.4%), b_tie_ro: 10 (3.8%), parse: 0.83
        (0.3%), extract_message_metadata: 3.6 (1.3%), get_uri_detail_list:
        1.35 (0.5%), tests_pri_-1000: 3.8 (1.4%), tests_pri_-950: 1.28 (0.5%),
        tests_pri_-900: 0.96 (0.4%), tests_pri_-90: 58 (21.8%), check_bayes:
        57 (21.3%), b_tokenize: 5 (1.9%), b_tok_get_all: 7 (2.6%),
        b_comp_prob: 2.2 (0.8%), b_tok_touch_all: 39 (14.5%), b_finish: 0.97
        (0.4%), tests_pri_0: 167 (62.5%), check_dkim_signature: 0.44 (0.2%),
        check_dkim_adsp: 3.1 (1.1%), poll_dns_idle: 0.93 (0.3%), tests_pri_10:
        2.2 (0.8%), tests_pri_500: 8 (3.1%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull signal-for-v5.20 from the git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/signal-for-v5.20
  HEAD: 9a95f78eab70deeb5a4c879c19b841a6af5b66e7 signal: Drop signals received after a fatal signal has been processed

Recently I had a conversation where it was pointed out to me that
SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
difficult for a tracer to handle.

Keeping SIGKILL working after the process has been killed is pain
from an implementation point of view.

So since the debuggers don't want this behavior let's see if we can
remove this wart for the userspace API

If a regression is detected it should only need to be the last change
that is the reverted.  The other two are just general cleanups that
make the last patch simpler.

Eric W. Biederman (3):
      signal: Ensure SIGNAL_GROUP_EXIT gets set in do_group_exit
      signal: Guarantee that SIGNAL_GROUP_EXIT is set on process exit
      signal: Drop signals received after a fatal signal has been processed

 fs/coredump.c                |  2 +-
 include/linux/sched/signal.h |  1 +
 kernel/exit.c                | 20 +++++++++++++++++++-
 kernel/fork.c                |  2 ++
 kernel/signal.c              |  3 ++-
 5 files changed, 25 insertions(+), 3 deletions(-)

