Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599F573BE58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjFWSYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:24:12 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B982705;
        Fri, 23 Jun 2023 11:24:11 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NHWFtR021356;
        Fri, 23 Jun 2023 11:23:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=N4cBXKiqQoHumBIO8HOOlbE89/9qqO4mK3b+3S9K7aA=;
 b=A+5ZQl0hDNGGl1dpP1Xuozpis0YZXR8uX+6AQApMM3Kl6j7hUjpL7nPVS6wctNp0DzQW
 WMvE1ZHwIlCFJU88xpwU7i/w77tLV/NwQhlsYYKIHQ6kMxui4S6KYozvZSiS0gbCqYCc
 RgItba2R7oGpnoNpc2o8m+1WTx8hCHtiweOPoXGzjHIzfqCsJSB9RacPjlwiNkrVFdpp
 r5HRJGqq4L+80uvPRr0B3/m3rMbvKBjFsYWf7mhnO0LPdsMtHzQzhlma68+I66wRr4Yp
 a+SMxjaXtaPASz5loX4+wfxa2slVNIc4io3eQJ/ntvW1ifzqpu38gyxkFjuPDFjFfW7i Yg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rcur5m1rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 11:23:46 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 23 Jun
 2023 11:23:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 23 Jun 2023 11:23:44 -0700
Received: from TJ-POWEREDGE.marvell.com (TJ-POWEREDGE.marvell.com [10.28.8.3])
        by maili.marvell.com (Postfix) with ESMTP id 3EDB53F7045;
        Fri, 23 Jun 2023 11:23:39 -0700 (PDT)
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     <john.g.garry@oracle.com>, <will@kernel.org>,
        <mike.leach@linaro.org>, <suzuki.poulose@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <irogers@google.com>,
        <adrian.hunter@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        <lcherian@marvell.com>, <areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH 0/1] Fix Coresight instruction synthesis logic
Date:   Fri, 23 Jun 2023 23:52:03 +0530
Message-ID: <20230623182204.25199-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KXUj6crzgeEd10tmLHfgo9ZtrUgZaCP_
X-Proofpoint-GUID: KXUj6crzgeEd10tmLHfgo9ZtrUgZaCP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_10,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use perf to catpure Coresight trace and generate instruction
trace using 'perf script', we get the following output:

# perf record -e cs_etm/@tmc_etr0/ -C 9 taskset -c 9 sleep 1
# perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent
...
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed54 coresight_timeout+0x28
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed58 coresight_timeout+0x2c
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed5c coresight_timeout+0x30
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed60 coresight_timeout+0x34
 perf  9024/9024  [009]  2690.650470551:      instructions:   jmp                                  0 ffffb305591aed7c coresight_timeout+0x50
 perf  9024/9024  [009]  2690.650470551:      instructions:   jmp                                  0 ffffb305591aed80 coresight_timeout+0x54
 perf  9024/9024  [009]  2690.650470551:      instructions:   jmp                                  0 ffffb305591aed84 coresight_timeout+0x58
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aede4 coresight_timeout+0xb8
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aede8 coresight_timeout+0xbc
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aedec coresight_timeout+0xc0
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aedf0 coresight_timeout+0xc4
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccec ete_sysreg_read+0x0
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccf0 ete_sysreg_read+0x4
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccf4 ete_sysreg_read+0x8
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccf8 ete_sysreg_read+0xc
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccfc ete_sysreg_read+0x10
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bcd00 ete_sysreg_read+0x14

This output has the following issues:
1. Non-branch instructions have mnemonics of branch instructions (Column 6)
2. Branch target address is missing (Column 7)

This patch fixes these issues by changing the logic of instruction syntehsis
for the Coresight trace queues.

Output after applying the patch:
 ...
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed54 coresight_timeout+0x28
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed58 coresight_timeout+0x2c
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed5c coresight_timeout+0x30
 perf  6111/6111  [008]   457.332794461:      instructions:   jmp                   ffffb305591aed7c ffffb305591aed60 coresight_timeout+0x34
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed7c coresight_timeout+0x50
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed80 coresight_timeout+0x54
 perf  6111/6111  [008]   457.332794461:      instructions:   jcc                   ffffb305591aede4 ffffb305591aed84 coresight_timeout+0x58
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591aede4 coresight_timeout+0xb8
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591aede8 coresight_timeout+0xbc
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591aedec coresight_timeout+0xc0
 perf  6111/6111  [008]   457.332794462:      instructions:   call                  ffffb305591bccec ffffb305591aedf0 coresight_timeout+0xc4
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccec ete_sysreg_read+0x0
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccf0 ete_sysreg_read+0x4
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccf4 ete_sysreg_read+0x8
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccf8 ete_sysreg_read+0xc
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccfc ete_sysreg_read+0x10
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bcd00 ete_sysreg_read+0x14

Tanmay Jagdale (1):
  perf: cs-etm: Fixes in instruction sample synthesis

 tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

-- 
2.34.1

