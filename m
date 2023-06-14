Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A771730901
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjFNUNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFNUNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:13:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E58C3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686773632; x=1718309632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vVKZY+8DOmXEeWJ7p8EgdE3zXkLDQvwOA7M2hUI/z+4=;
  b=PA5PUoH3hWCCu0yHrz/etmNfGjW6FTD5OcPse6g/M9tigqLDeLUo/bcE
   XXNek+MQaNSi87QcvbCqVYtDzOw7R55Hbytl6ow3gr6mcXIyPdWw1+y89
   Ey8a1+8/Jj52EP6FewqnsvtnyuyLBW9RZqiRzbyckOaoyCUKWd91q2RbJ
   sUhIhulCoxdRWHpmeh4/IqT6qFHz1hzpj04ily161jzST0LlO2SXkW7+k
   w/VQDtPd9//OQGqTcSp4sntQwoXDEda3Cw2uDJlKSIgE4zXvo6BteiLb8
   BKVVPiSGEKyXDbTCgrTywr+56LMfy8LAJ1XoBVt/KhX7UAQ7SqImg1DrG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="445096125"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="445096125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 13:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="824952540"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="824952540"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2023 13:13:52 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH] x86/smpboot: Remove a stray comment about CPU hotplug
Date:   Wed, 14 Jun 2023 20:13:01 +0000
Message-Id: <20230614201301.1308363-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This old comment is irrelavant to the logic of disabling interrupts and
could be misleading. Remove it.

Some history - commit 'e1367daf3eed5 ("[PATCH] cpu state clean after hot
remove")' introduced this comment a while back. However, while
refactoring the play_dead code, commit 'a21f5d88c17a ("x86: unify x86_32
and x86_64 play_dead into one function")' missed moving it to the
appropriate location.

Now, hlt_play_dead() resembles the code that the comment was initially
added for, but, it doesn't make sense anymore because an offlined cpu
could also be put into other states such as mwait.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/smpboot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce1ece4..64dd4703c1ff 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1734,9 +1734,6 @@ void play_dead_common(void)
 	/* Ack it */
 	(void)cpu_report_death();
 
-	/*
-	 * With physical CPU hotplug, we should halt the cpu
-	 */
 	local_irq_disable();
 }
 
-- 
2.34.1

