Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CA6C577B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjCVU0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjCVU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:26:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A88C967;
        Wed, 22 Mar 2023 13:16:28 -0700 (PDT)
Date:   Wed, 22 Mar 2023 20:14:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679516097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NQQuVQiY/sIoaQ5n0A3D+PWJlpQRmQdA8vFtOkT8Gsk=;
        b=SLjWGkDXuJNDL12fSJydNVRbfzMtf5EXpP/AgYUjbmgIkT94WYBN8kaTVJEXxAfZMqbL4Q
        KY7XhbNjLJtVOxtcKO6IbPQlagTQWNSqEo/hBcbhZ3S8FpbbMRtvQy5VLqf6/zt0j39gMU
        t92SdepPx2ES7UzpBsX3+1UCjwKV5Ki6clPmtvKg4uUpDIR+fBDTk8xexBt8xenKULsCGg
        YQbIR0a/bP/TvWXW38V9HN6iQVwvrZ+7I1JnzXSBzU/2C2BrjUbp4J9CGa5o+kcXVR2gof
        2XpARYNvAgEBW0iv9L2fkhLFKM1YSjElDG6idVYsmwvxCIQ5WrsHVb8LkiMcvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679516097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NQQuVQiY/sIoaQ5n0A3D+PWJlpQRmQdA8vFtOkT8Gsk=;
        b=sLiVViCR4387AXb2Bqoab1YuTB76BZwWUIjmIk3eZIpNLJYRaXOlP1BcO0rEE6DTQVj8kj
        sVsJQ6jcC8qMi7DA==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] Documentation/x86: Explain the state component
 permission for guests
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167951609339.5837.3788677511456464455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     5fbff260755750559aa12a30f6fa7f8a863666f1
Gitweb:        https://git.kernel.org/tip/5fbff260755750559aa12a30f6fa7f8a863666f1
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Fri, 20 Jan 2023 16:19:00 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 13:08:02 -07:00

Documentation/x86: Explain the state component permission for guests

Commit 980fe2fddcff ("x86/fpu: Extend fpu_xstate_prctl() with guest
permissions") extends a couple of arch_prctl(2) options for VCPU threads.
Add description for them.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thiago Macieira <thiago.macieira@intel.com>
Reviewed-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/20230121001900.14900-5-chang.seok.bae%40intel.com
---
 Documentation/x86/xstate.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index 23b1c9f..ae5c69e 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -143,3 +143,32 @@ entry if the feature is in its initial configuration.  This differs from
 non-dynamic features which are always written regardless of their
 configuration.  Signal handlers can examine the XSAVE buffer's XSTATE_BV
 field to determine if a features was written.
+
+Dynamic features for virtual machines
+-------------------------------------
+
+The permission for the guest state component needs to be managed separately
+from the host, as they are exclusive to each other. A coupled of options
+are extended to control the guest permission:
+
+-ARCH_GET_XCOMP_GUEST_PERM
+
+ arch_prctl(ARCH_GET_XCOMP_GUEST_PERM, &features);
+
+ ARCH_GET_XCOMP_GUEST_PERM is a variant of ARCH_GET_XCOMP_PERM. So it
+ provides the same semantics and functionality but for the guest
+ components.
+
+-ARCH_REQ_XCOMP_GUEST_PERM
+
+ arch_prctl(ARCH_REQ_XCOMP_GUEST_PERM, feature_nr);
+
+ ARCH_REQ_XCOMP_GUEST_PERM is a variant of ARCH_REQ_XCOMP_PERM. It has the
+ same semantics for the guest permission. While providing a similar
+ functionality, this comes with a constraint. Permission is frozen when the
+ first VCPU is created. Any attempt to change permission after that point
+ is going to be rejected. So, the permission has to be requested before the
+ first VCPU creation.
+
+Note that some VMMs may have already established a set of supported state
+components. These options are not presumed to support any particular VMM.
