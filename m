Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABEB74CA55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGJDWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGJDWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:22:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE67DF9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688959328; x=1720495328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FeTrK2ed9EXENbT/tuue9blgvUIiruInOFAC1KECqjA=;
  b=dcMW02oDFb2KpYRQf8n0kpHZPer+jsHmwUoaQWQ1aaC9iAf0G5fHXL/L
   G/2DOCZMyqxbeFOOJVA470Qb45vR/SrtaAe0IwJUob+pU5ttql28nMaZi
   kW2TFr3KOjYM3X+UGR4rkui74lBn1otXVjngdTj2C6xvxO4QfH8xyLwqP
   bb3RLkopKHzFQScxGKRQfDQU2BhUdWqdSMqP9+BXR/98w+bSSkhyb3SqL
   tNyuAafYmJCHWWNXnt0Gz18j9E60PqwjyBQUMEsNnfHGyi1ylu7glxaeX
   ocq8klXHUN1je12HPZDs3NKrhrvZkCGfvifkwdnmJxln8N26xdreZ5kwZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="395027755"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="395027755"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 20:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="894636164"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="894636164"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.118])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 20:22:04 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     tglx@linutronix.de, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH] cpu/SMT: Fix cpu_smt_possible() comment
Date:   Mon, 10 Jul 2023 11:21:21 +0800
Message-Id: <20230710032121.8341-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment of cpu_smt_possible() is not aligned with the changelog of
commit e1572f1d08be ("cpu/SMT: create and export cpu_smt_possible()"),
and it is wrong.

Fix cpu_smt_possible() comment.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 7e8f1b044772..f6811c857102 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -676,7 +676,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
 }
 
-/* Returns true if SMT is not supported of forcefully (irreversibly) disabled */
+/* Returns true if SMT is supported and not forcefully (irreversibly) disabled */
 bool cpu_smt_possible(void)
 {
 	return cpu_smt_control != CPU_SMT_FORCE_DISABLED &&
-- 
2.34.1

