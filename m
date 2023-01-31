Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7422C6838F4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjAaVzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAaVzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:55:16 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C7485A7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1675202105; x=1706738105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wrckb9mlh8yXx5gPqo3dLsOrcTZgI0LG6DD2w9k7peE=;
  b=PuF6XV4UUZogkL6ckapnYW7GRZmyUZ7ykPsSV+qciwIkFUiKALGnLlmW
   HYssHi93THJJrefQbQg5G1FfSO4zoy+RcvoB1pstSTC+34ea8UemQ0/BU
   Cnmyzyq1JMedzl8JB+dRO+LZF6la+iuI2E4AGK1zXxVo+GH9BFmQ4j8LW
   E=;
X-IronPort-AV: E=Sophos;i="5.97,261,1669075200"; 
   d="scan'208";a="177024314"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:55:03 +0000
Received: from EX13MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com (Postfix) with ESMTPS id D5FBD40DBD;
        Tue, 31 Jan 2023 21:54:59 +0000 (UTC)
Received: from EX19D002ANA003.ant.amazon.com (10.37.240.141) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Tue, 31 Jan 2023 21:54:57 +0000
Received: from b0f1d8753182.ant.amazon.com.com (10.43.162.56) by
 EX19D002ANA003.ant.amazon.com (10.37.240.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24;
 Tue, 31 Jan 2023 21:54:53 +0000
From:   Takahiro Itazuri <itazur@amazon.com>
To:     <x86@kernel.org>
CC:     Takahiro Itazuri <itazur@amazon.com>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cpufeatures: Add AMD-specific IBRS hint bits
Date:   Tue, 31 Jan 2023 21:54:39 +0000
Message-ID: <20230131215439.17294-1-itazur@amazon.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D32UWB004.ant.amazon.com (10.43.161.36) To
 EX19D002ANA003.ant.amazon.com (10.37.240.141)
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMD-specific IBRS-related hint bits to enable pass-through to KVM
guests. KVM_GET_SUPPORTED_CPUID masks capability bits that KVM does not
recognize even when host sets these bits. Making KVM recognize these
allows VMMs to pass through host values to KVM guests without
explicitly modifying KVM_GET_SUPPORTED_CPUID results.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 arch/x86/include/asm/cpufeatures.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index fdb8e09234ba..3447a9be1616 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -328,7 +328,10 @@
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_IBRS_ALWAYS_ON	(13*32+16) /* "" Inidrect Branch Restricted Speculation always-on preferred */
 #define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* "" Single Thread Indirect Branch Predictors always-on preferred */
+#define X86_FEATURE_AMD_IBRS_PREFERRED	(13*32+18) /* "" Indirect Branch Restricted Speculation preferred over software */
+#define X86_FEATURE_AMD_IBRS_SAME_MODE	(13*32+19) /* "" Indirect Branch Restricted Speculation provides same mode protection */
 #define X86_FEATURE_AMD_PPIN		(13*32+23) /* Protected Processor Inventory Number */
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
-- 
2.38.0

