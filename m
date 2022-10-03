Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116865F381F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJCVwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJCVwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:52:08 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787F2A425
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:52:07 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:57598)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofTM6-00923e-Vs; Mon, 03 Oct 2022 15:52:07 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:42764 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofTM6-008ZIN-9Y; Mon, 03 Oct 2022 15:52:06 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Hangyu Hua <hbh25y@gmail.com>
Date:   Mon, 03 Oct 2022 16:52:00 -0500
Message-ID: <87wn9gwp6n.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ofTM6-008ZIN-9Y;;;mid=<87wn9gwp6n.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18x75VD8z+DdRJz6+51rUxCasqWHzOH18U=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 202 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (5.6%), b_tie_ro: 10 (4.8%), parse: 0.68
        (0.3%), extract_message_metadata: 2.6 (1.3%), get_uri_detail_list:
        0.73 (0.4%), tests_pri_-1000: 3.6 (1.8%), tests_pri_-950: 1.20 (0.6%),
        tests_pri_-900: 0.96 (0.5%), tests_pri_-90: 50 (24.9%), check_bayes:
        48 (24.1%), b_tokenize: 3.7 (1.8%), b_tok_get_all: 4.0 (2.0%),
        b_comp_prob: 1.37 (0.7%), b_tok_touch_all: 36 (18.0%), b_finish: 0.91
        (0.5%), tests_pri_0: 112 (55.4%), check_dkim_signature: 0.44 (0.2%),
        check_dkim_adsp: 3.0 (1.5%), poll_dns_idle: 1.12 (0.6%), tests_pri_10:
        2.1 (1.0%), tests_pri_500: 9 (4.6%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ipc: mqueue: fix possible memory leak in init_mqueue_fs()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull retire_mq_sysctls-for-v5.19 from the git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/retire_mq_sysctls-for-v5.19
  HEAD: c579d60f0d0cd87552f64fdebe68b5d941d20309 ipc: mqueue: fix possible memory leak in init_mqueue_fs()

A fix for a unlikely but possible memory leak.

Hangyu Hua (1):
      ipc: mqueue: fix possible memory leak in init_mqueue_fs()

 ipc/mqueue.c | 1 +
 1 file changed, 1 insertion(+)
