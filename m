Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5F069E7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBUStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBUSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:49:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D22A6C4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:49:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C920B8109D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8665C433A0;
        Tue, 21 Feb 2023 18:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677005364;
        bh=Pq1/EGne3LaGE8RJqGaU426y8oEgl4zvqIPCQIl6Ii8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuQrnBTM6zmFnApUBUKl3tuyCnwcWoiMcvD6Jaj23nlDqxIUbYnYgaiL7M1s2pQVd
         RPbx/e2zE8SFaBuwFa063d5141E+dQcajNGtR12wlIMM+olITT6pFJ3bT0oJnizKRO
         JQWITQ/vklpjFWHvoNtVTNJeDPQB6/iwv+L3bcUbYMpbyBsr4VCEy0phVzL+lzcudy
         JvNU7qiNy38PQnnKIXaWGxLG6y+mOI5X47Lu0IQKAZ4C0Ti8R+G2tLRdOMj7pzuXrv
         w9BUJFnH/9QMvsXvOXR9VhEoIHSxGL7c7g9l+ib1keIJhRlBzC/wsZtu/bDOTg08fV
         wHd8CXxFNOlYw==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     pjt@google.com, evn@google.com, jpoimboe@kernel.org,
        tglx@linutronix.de, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, pawan.kumar.gupta@linux.intel.com,
        kim.phillips@amd.com, alexandre.chartre@oracle.com,
        daniel.sneddon@linux.intel.com, corbet@lwn.net, bp@suse.de,
        linyujun809@huawei.com, kpsingh@kernel.org, jmattson@google.com
Subject: [PATCH v2 2/2] Documentation/hw-vuln: Document the interaction between IBRS and STIBP
Date:   Tue, 21 Feb 2023 19:49:08 +0100
Message-Id: <20230221184908.2349578-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230221184908.2349578-1-kpsingh@kernel.org>
References: <20230221184908.2349578-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain why STIBP is needed with legacy IBRS as currently implemented
(KERNEL_IBRS) and why STIBP is not needed when enhanced IBRS is enabled.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index c4dcdb3d0d45..e193ee13dc9a 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -479,8 +479,17 @@ Spectre variant 2
    On Intel Skylake-era systems the mitigation covers most, but not all,
    cases. See :ref:`[3] <spec_ref3>` for more details.
 
-   On CPUs with hardware mitigation for Spectre variant 2 (e.g. Enhanced
-   IBRS on x86), retpoline is automatically disabled at run time.
+   On CPUs with hardware mitigation for Spectre variant 2 (e.g. IBRS
+   or enhanced IBRS on x86), retpoline is automatically disabled at run time.
+
+   Setting the IBRS bit implicitly enables STIBP which guards against
+   cross-thread branch target injection on SMT systems. On systems with enhanced
+   IBRS, the kernel sets the bit once, which keeps cross-thread protections
+   always enabled, obviating the need for an explicit STIBP. On CPUs with legacy
+   IBRS, the kernel clears the IBRS bit on returning to user-space, thus also
+   disabling the implicit STIBP. Consequently, STIBP needs to be explicitly
+   enabled to guard against cross-thread attacks in userspace.
+
 
    The retpoline mitigation is turned on by default on vulnerable
    CPUs. It can be forced on or off by the administrator
@@ -504,9 +513,12 @@ Spectre variant 2
    For Spectre variant 2 mitigation, individual user programs
    can be compiled with return trampolines for indirect branches.
    This protects them from consuming poisoned entries in the branch
-   target buffer left by malicious software.  Alternatively, the
-   programs can disable their indirect branch speculation via prctl()
-   (See :ref:`Documentation/userspace-api/spec_ctrl.rst <set_spec_ctrl>`).
+   target buffer left by malicious software.
+
+   On legacy IBRS systems, at return to userspace, implicit STIBP is disabled
+   because the kernel clears the IBRS bit. In this case, the userspace programs
+   can disable indirect branch speculation via prctl() (See
+   :ref:`Documentation/userspace-api/spec_ctrl.rst <set_spec_ctrl>`).
    On x86, this will turn on STIBP to guard against attacks from the
    sibling thread when the user program is running, and use IBPB to
    flush the branch target buffer when switching to/from the program.
-- 
2.39.2.637.g21b0678d19-goog

