Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D746C5CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCWCkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCWCkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:40:37 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BBC4EE4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:40:33 -0700 (PDT)
X-ASG-Debug-ID: 1679539227-086e23383d19100001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id QpwZbisuEymkhbcz (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 23 Mar 2023 10:40:27 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 23 Mar
 2023 10:40:27 +0800
Received: from silvia-OptiPlex-3010.zhaoxin.com (10.29.8.47) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Mar 2023 10:40:26 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   silviazhao <silviazhao-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <silviazhao@zhaoxin.com>, <cooperyan@zhaoxin.com>
Subject: [PATCH 0/3] Add PMC support for Zhaoxin Yongfeng architecture
Date:   Thu, 23 Mar 2023 10:40:23 +0800
X-ASG-Orig-Subj: [PATCH 0/3] Add PMC support for Zhaoxin Yongfeng architecture
Message-ID: <20230323024026.823-1-silviazhao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1679539227
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 710
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0209
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.106421
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMC support for Zhaoxin Yongfeng architecture.
Dave Hansen suggested to use macros instead of open-coded model numbers.
So create arch/x86/include/asm/zhaoxin-family.h to introduce macros for
Zhaoxin family numbers.
https://lkml.org/lkml/2023/3/16/841

silviazhao (3):
  x86/cpu/zhaoxin: Introduce macros for Zhaoxin family numbers
  perf/x86/zhaoxin: Replace open-coded model number with macros
  perf/x86/zhaoxin: Add Yongfeng support

 arch/x86/events/zhaoxin/core.c        | 55 ++++++++++++++++++---------
 arch/x86/include/asm/zhaoxin-family.h | 19 +++++++++
 2 files changed, 57 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/include/asm/zhaoxin-family.h

-- 
2.17.1

