Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5F5F1129
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiI3RuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiI3RuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:50:05 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F47C6414
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:49:52 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:51946)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oeK8z-009VFZ-OC; Fri, 30 Sep 2022 11:49:49 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:52818 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oeK8y-00F3KT-Rt; Fri, 30 Sep 2022 11:49:49 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <202209301555.UK7B8MPo-lkp@intel.com>
Date:   Fri, 30 Sep 2022 12:49:42 -0500
In-Reply-To: <202209301555.UK7B8MPo-lkp@intel.com> (kernel test robot's
        message of "Fri, 30 Sep 2022 15:49:21 +0800")
Message-ID: <87mtagzr9l.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oeK8y-00F3KT-Rt;;;mid=<87mtagzr9l.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18zA4WaFTNapOMCqPJzxuVXsv+qeL58GQY=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 292 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (4.1%), b_tie_ro: 10 (3.6%), parse: 0.94
        (0.3%), extract_message_metadata: 16 (5.6%), get_uri_detail_list: 1.69
        (0.6%), tests_pri_-1000: 24 (8.1%), tests_pri_-950: 1.17 (0.4%),
        tests_pri_-900: 0.96 (0.3%), tests_pri_-90: 58 (20.0%), check_bayes:
        57 (19.5%), b_tokenize: 6 (1.9%), b_tok_get_all: 6 (2.1%),
        b_comp_prob: 1.80 (0.6%), b_tok_touch_all: 40 (13.7%), b_finish: 0.80
        (0.3%), tests_pri_0: 163 (55.9%), check_dkim_signature: 0.46 (0.2%),
        check_dkim_adsp: 2.7 (0.9%), poll_dns_idle: 0.92 (0.3%), tests_pri_10:
        3.1 (1.1%), tests_pri_500: 10 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] ipc/ipc_sysctl: Add missing include of linux/cred.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The kernel test robot recently reported[1][2] that in configurations
without CONFIG_COMPAT set the recent changes to ipc_permissions would
result in code that would not compile, as definitions present in
linux/cred.h were missing.

Include linux/cred.h explicitly in ipc/ipc_sysctl.c so that it builds
in all kernel configurations.

[1] https://lkml.kernel.org/r/202209301555.UK7B8MPo-lkp@intel.com
[2] https://lkml.kernel.org/r/202209301537.wYdDBROB-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 54e1011bd95a ("sysctl: Allow change system v ipc sysctls inside ipc namespace")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I have corrected the build error by adding the following patch
to the topic branch.

 ipc/ipc_sysctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 31282e0a630d..29c1d3ae2a5c 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -14,6 +14,7 @@
 #include <linux/ipc_namespace.h>
 #include <linux/msg.h>
 #include <linux/slab.h>
+#include <linux/cred.h>
 #include "util.h"
 
 static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
-- 
2.35.3

Eric
