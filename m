Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2220B74D415
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGJLCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjGJLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:02:49 -0400
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B42F5CE;
        Mon, 10 Jul 2023 04:02:48 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANMnu019754;
        Mon, 10 Jul 2023 05:23:22 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANMlf019752;
        Mon, 10 Jul 2023 05:23:22 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 03/13] Implement CAP_TRUST capability.
Date:   Mon, 10 Jul 2023 05:23:09 -0500
Message-Id: <20230710102319.19716-4-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230710102319.19716-1-greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TSEM was designed to support a Trust Orchestration System (TOS)
security architecture.  A TOS based system uses the concept of a
minimum Trusted Computing Base of utilities, referred to as trust
orchestrators, that maintain workloads in a trusted execution
state.  The trust orchestrators are thus, from a security
perspective, the most security privileged processes running on
the platform.

The CAP_ML (machine modeling) capability is defined as a
capability that allows a process to alter the modeling and hence
the trust status of the platform.  In a fully orchestrated system
only the trust orchestrator carry this capability bit and then
drop the capability for the execution of the workload.  This is
designed to prevent a security vulnerability in workloads to be
leveraged to create an entity that could conduct adversarial
modifications to the trust status of the platform.

With the introduction of TSEM there are three generic mechanisms
for implementing security contols, each with its own capability
bit for management, ie:

DAC - CAP_DAC_ADMIN

MAC - CAP_MAC_ADMIN

Security modeling - CAP_ML

Having a separate capability bit for security modeling allows DAC
and classic label or path based MAC systems to be implemented in
the context of a security modeling namespace.  Looking forward it
is not unreasonable to consider the implementation of a modeling
policy that would verify the status of extended attributes being
used for label based MAC controls.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 include/uapi/linux/capability.h     | 6 +++++-
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 3d61a0ae055d..4a17c9774505 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -417,7 +417,11 @@ struct vfs_ns_cap_data {
 
 #define CAP_CHECKPOINT_RESTORE	40
 
-#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
+/* Allow modifications to the trust status of the system */
+
+#define CAP_ML	41
+
+#define CAP_LAST_CAP         CAP_ML
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c380775d41..f367c269bbdb 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -30,7 +30,7 @@
 		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
 		"checkpoint_restore"
 
-#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
+#if CAP_LAST_CAP > CAP_ML
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.39.1

