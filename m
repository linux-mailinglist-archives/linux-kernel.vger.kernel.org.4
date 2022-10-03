Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB78C5F381B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJCVuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJCVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:50:20 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6A205EE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:50:18 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:35772)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofTKK-000VE9-HB; Mon, 03 Oct 2022 15:50:16 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:53614 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofTKJ-004GLv-Q1; Mon, 03 Oct 2022 15:50:16 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 03 Oct 2022 16:49:22 -0500
Message-ID: <877d1gy3vh.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ofTKJ-004GLv-Q1;;;mid=<877d1gy3vh.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+0B+6LkpidxuSnZU5F7CmIn/TEQ2/SSq0=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 231 ms - load_scoreonly_sql: 0.14 (0.1%),
        signal_user_changed: 12 (5.0%), b_tie_ro: 10 (4.3%), parse: 0.74
        (0.3%), extract_message_metadata: 2.7 (1.2%), get_uri_detail_list:
        0.76 (0.3%), tests_pri_-1000: 3.3 (1.4%), tests_pri_-950: 1.18 (0.5%),
        tests_pri_-900: 0.97 (0.4%), tests_pri_-90: 76 (32.8%), check_bayes:
        74 (32.2%), b_tokenize: 3.7 (1.6%), b_tok_get_all: 4.1 (1.8%),
        b_comp_prob: 1.44 (0.6%), b_tok_touch_all: 62 (27.0%), b_finish: 0.73
        (0.3%), tests_pri_0: 116 (50.1%), check_dkim_signature: 0.43 (0.2%),
        check_dkim_adsp: 2.8 (1.2%), poll_dns_idle: 0.93 (0.4%), tests_pri_10:
        2.1 (0.9%), tests_pri_500: 8 (3.7%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] signal: break out of wait loops on kthread_stop()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull interrupting_kthread_stop-for-v5.20 from the git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/interrupting_kthread_stop-for-v5.20
  HEAD: a7c01fa93aeb03ab76cd3cb2107990dd160498e6 signal: break out of wait loops on kthread_stop()

This is a small tweak to kthread_stop so it breaks out of
interruptible waits, that don't explicitly test for kthread_stop.
These interruptible waits occassionaly occur in kernel threads do to
code sharing.

Jason A. Donenfeld (1):
      signal: break out of wait loops on kthread_stop()

 kernel/kthread.c | 1 +
 1 file changed, 1 insertion(+)
