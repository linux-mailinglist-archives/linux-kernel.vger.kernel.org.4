Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E805B72CABC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjFLPxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFLPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:53:09 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3396710E2;
        Mon, 12 Jun 2023 08:53:08 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:40524)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q8jqs-0087ZJ-2N; Mon, 12 Jun 2023 09:53:06 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:35760 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q8jqr-00G1o3-4k; Mon, 12 Jun 2023 09:53:05 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
        <ZIZSPyzReZkGBEFy@dread.disaster.area>
        <20230612015145.GA11441@frogsfrogsfrogs>
        <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
        <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
        <20230612153629.GA11427@frogsfrogsfrogs>
Date:   Mon, 12 Jun 2023 10:52:37 -0500
In-Reply-To: <20230612153629.GA11427@frogsfrogsfrogs> (Darrick J. Wong's
        message of "Mon, 12 Jun 2023 08:36:29 -0700")
Message-ID: <87zg54r83e.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q8jqr-00G1o3-4k;;;mid=<87zg54r83e.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19l2ouqJHn9zcO+QmRcaljj7Zv6Ie2q7/g=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Darrick J. Wong" <djwong@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 310 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 14 (4.5%), b_tie_ro: 11 (3.7%), parse: 1.16
        (0.4%), extract_message_metadata: 3.9 (1.3%), get_uri_detail_list:
        1.13 (0.4%), tests_pri_-2000: 4.2 (1.4%), tests_pri_-1000: 2.7 (0.9%),
        tests_pri_-950: 1.44 (0.5%), tests_pri_-900: 1.17 (0.4%),
        tests_pri_-200: 1.03 (0.3%), tests_pri_-100: 5.0 (1.6%),
        tests_pri_-90: 60 (19.3%), check_bayes: 58 (18.7%), b_tokenize: 6
        (1.9%), b_tok_get_all: 7 (2.4%), b_comp_prob: 2.1 (0.7%),
        b_tok_touch_all: 37 (12.0%), b_finish: 1.35 (0.4%), tests_pri_0: 193
        (62.2%), check_dkim_signature: 0.58 (0.2%), check_dkim_adsp: 3.4
        (1.1%), poll_dns_idle: 1.43 (0.5%), tests_pri_10: 2.2 (0.7%),
        tests_pri_500: 10 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can someone who can reproduce the hang run this test patch.

I am currently drawing a blank looking at the changes, so I am
proposing some debug code to help us narrow things down.

Can someone who can reproduce this run the code below?

The tests reproducing this don't appear to use use /dev/host-net or
/dev/vhost-vsock.  So if the WARN_ON's trigger it is a good sign
that code connected to the WARN_ON's are wrong.

If the WARN_ON's don't trigger I suspect the code in kernel/fork.c

But as I said staring at the code I don't see anything wrong.

Eric


diff --git a/fs/coredump.c b/fs/coredump.c
index 88740c51b942..e9acf0a2d2f0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -374,6 +374,7 @@ static int zap_process(struct task_struct *start, int exit_code)
 			/* The vhost_worker does not particpate in coredumps */
 			if ((t->flags & (PF_USER_WORKER | PF_IO_WORKER)) != PF_USER_WORKER)
 				nr++;
+			else WARN_ON_ONCE(true);
 		}
 	}
 
diff --git a/kernel/exit.c b/kernel/exit.c
index edb50b4c9972..56002a58ec33 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -437,6 +437,7 @@ static void coredump_task_exit(struct task_struct *tsk)
 		}
 		__set_current_state(TASK_RUNNING);
 	}
+	else if (core_state) WARN_ON_ONCE(true);
 }
 
 #ifdef CONFIG_MEMCG
diff --git a/kernel/signal.c b/kernel/signal.c
index 2547fa73bde5..1be27dbbce62 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1371,6 +1371,7 @@ int zap_other_threads(struct task_struct *p)
 		/* Don't require de_thread to wait for the vhost_worker */
 		if ((t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
 			count++;
+		else WARN_ON_ONCE(true);
 
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
