Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660395F07AD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiI3JcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiI3JbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC2CE6FE;
        Fri, 30 Sep 2022 02:31:13 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dy7Z1sRZEFnjSsETOF3Vr3pl4eE0nfn/KZaaQgEH9OI=;
        b=RDrJr5ZQdGLBFN1CfK6aAOHjk68R/qIZmf0hdc0jPxiX81pPiEb2VRxDSwRRSo8xbGYS6j
        gfk2cPVlguK2u3xDLP0wdnZTpyhqdD505Tt7Cxjq+2Ws1+hSxxIyqwIWkT/P0xPpqFYCW9
        WK42ppgY6oQeAWtE9P1rXLj9efGXy4uirDFCa+SDMfm3gsGouxqNyz0LtSJp1O9J2Imvdw
        Hm/LOGIr9GWzTqIS9QgmAd4CmvtSsm3lxZ+SO6H8db1RgoxrFtaMdYv+MLRVPvGVRR58Dj
        IWZlkyO7oBUq2XLTNaZU6KUW4II2eYW2xECjSlG4Rz4ihXvFuMWW2MG+pcXKRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dy7Z1sRZEFnjSsETOF3Vr3pl4eE0nfn/KZaaQgEH9OI=;
        b=6OWPHVynqXD1N5CBRMXtFuCFmJKlqkm3sOSSNKrOf7HBQkbnO9b52rRFoSnlnWZ+qN4bPY
        igE9u8yykZbmN4BQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928095805.596-3-ravi.bangoria@amd.com>
References: <20220928095805.596-3-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166453026954.401.8391072210080091414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     610c238041fbc682936d34132362a54a802600fe
Gitweb:        https://git.kernel.org/tip/610c238041fbc682936d34132362a54a802600fe
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 28 Sep 2022 15:27:52 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:54 +02:00

perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions

IBS_OP_DATA2 DataSrc provides detail about location of the data
being accessed from by load ops. Define macros for legacy and
extended DataSrc values.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220928095805.596-3-ravi.bangoria@amd.com
---
 arch/x86/include/asm/amd-ibs.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index f3eb098..cb2a5e1 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -6,6 +6,22 @@
 
 #include <asm/msr-index.h>
 
+/* IBS_OP_DATA2 DataSrc */
+#define IBS_DATA_SRC_LOC_CACHE			 2
+#define IBS_DATA_SRC_DRAM			 3
+#define IBS_DATA_SRC_REM_CACHE			 4
+#define IBS_DATA_SRC_IO				 7
+
+/* IBS_OP_DATA2 DataSrc Extension */
+#define IBS_DATA_SRC_EXT_LOC_CACHE		 1
+#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE		 2
+#define IBS_DATA_SRC_EXT_DRAM			 3
+#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE		 5
+#define IBS_DATA_SRC_EXT_PMEM			 6
+#define IBS_DATA_SRC_EXT_IO			 7
+#define IBS_DATA_SRC_EXT_EXT_MEM		 8
+#define IBS_DATA_SRC_EXT_PEER_AGENT_MEM		12
+
 /*
  * IBS Hardware MSRs
  */
