Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666376867AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjBAN4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBAN4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:56:21 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1CD09182
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:55:12 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 67888110045203;
        Wed,  1 Feb 2023 21:54:40 +0800 (CST)
Received: from didi-ThinkCentre-M920t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 21:54:40 +0800
Date:   Wed, 1 Feb 2023 21:54:33 +0800
X-MD-Sfrom: fuyuanli@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   fuyuanli <fuyuanli@didiglobal.com>
To:     <pmladek@suse.com>, <akpm@linux-foundation.org>,
        <linux@rasmusvillemoes.dk>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] hung_task: Print message when hung_task_warnings gets down
 to zero.
Message-ID: <20230201135416.GA6560@didi-ThinkCentre-M920t-N000>
Mail-Followup-To: pmladek@suse.com, akpm@linux-foundation.org,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's useful to report it when hung_task_warnings gets down to zero,
so that we can know if kernel log was lost or there is no hung task
was detected.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
---
 kernel/hung_task.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index bb2354f73ded..ff479c51143d 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -142,6 +142,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 
 		if (sysctl_hung_task_all_cpu_backtrace)
 			hung_task_show_all_bt = true;
+		if (!sysctl_hung_task_warnings)
+			pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");
 	}
 
 	touch_nmi_watchdog();
-- 
2.17.1

