Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828BA7032C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbjEOQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbjEOQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:20:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31C62685;
        Mon, 15 May 2023 09:20:55 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684167654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oq2w5/T8vszaBUacwCVwqQ0dStHOmx2WxWGJ0zePsOE=;
        b=OadXmL65HTOLMouOg2/E4ln0eS+vJOI5AFhby61iDjlkoVIG3BrmMqqAPPR8vBH9fkGiL+
        0cSPSnVpFVTCo+idbSui8tRIK7cWXnMCOsCJmnsedgErujeaAufNtaQv18bgVAl+GdC9N4
        /rL/5HGXVPRBNGBiVAbrodDXQf0K7GGqTeR9ggQ6ieflvPKnSh8NzyAQt/fYT6x6/aklcy
        JkUIsO0pBb7stMzLbBip5bJEmaf5u9tAXYZujP9YDd+LFhG2U2qvCVIBN+THiZ/WDINgE5
        7qnpqt33q43t5qtmOPUSMLE5Jp2y15KwdGCXXWXPfwKQRCciqJXZuMmfF5sb0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684167654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oq2w5/T8vszaBUacwCVwqQ0dStHOmx2WxWGJ0zePsOE=;
        b=sTBpwz/NMkKJNkl6z7kyf8JxmwAbmrSDnGKipLMiePIISXpqhdTOXLUbGlZd5ULNxW8VpZ
        0yC/vVYXck0BLUDQ==
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH] Documentation: core-api/cpuhotplug: Fix state names
Date:   Mon, 15 May 2023 18:20:38 +0200
Message-Id: <20230515162038.62703-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic allocated hotplug states in documentation and comment above
cpuhp_state enum do not match the code. To not get confused by wrong
documentation, change to proper state names.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 Documentation/core-api/cpu_hotplug.rst | 10 +++++-----
 include/linux/cpuhotplug.h             |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index f75778d37488..95ead18dd9e0 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -404,8 +404,8 @@ multi-instance state the following function is available:
 * cpuhp_setup_state_multi(state, name, startup, teardown)
 
 The @state argument is either a statically allocated state or one of the
-constants for dynamically allocated states - CPUHP_PREPARE_DYN,
-CPUHP_ONLINE_DYN - depending on the state section (PREPARE, ONLINE) for
+constants for dynamically allocated states - CPUHP_BP_PREPARE_DYN,
+CPUHP_AP_ONLINE_DYN - depending on the state section (PREPARE, ONLINE) for
 which a dynamic state should be allocated.
 
 The @name argument is used for sysfs output and for instrumentation. The
@@ -597,7 +597,7 @@ notifications on online and offline operations::
 Setup and teardown a dynamically allocated state in the ONLINE section
 for notifications on offline operations::
 
-   state = cpuhp_setup_state(CPUHP_ONLINE_DYN, "subsys:offline", NULL, subsys_cpu_offline);
+   state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "subsys:offline", NULL, subsys_cpu_offline);
    if (state < 0)
        return state;
    ....
@@ -606,7 +606,7 @@ for notifications on offline operations::
 Setup and teardown a dynamically allocated state in the ONLINE section
 for notifications on online operations without invoking the callbacks::
 
-   state = cpuhp_setup_state_nocalls(CPUHP_ONLINE_DYN, "subsys:online", subsys_cpu_online, NULL);
+   state = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "subsys:online", subsys_cpu_online, NULL);
    if (state < 0)
        return state;
    ....
@@ -615,7 +615,7 @@ for notifications on online operations without invoking the callbacks::
 Setup, use and teardown a dynamically allocated multi-instance state in the
 ONLINE section for notifications on online and offline operation::
 
-   state = cpuhp_setup_state_multi(CPUHP_ONLINE_DYN, "subsys:online", subsys_cpu_online, subsys_cpu_offline);
+   state = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "subsys:online", subsys_cpu_online, subsys_cpu_offline);
    if (state < 0)
        return state;
    ....
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f1001dca0e0..7b30f5cbf415 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -48,7 +48,7 @@
  *    same section.
  *
  * If neither #1 nor #2 apply, please use the dynamic state space when
- * setting up a state by using CPUHP_PREPARE_DYN or CPUHP_PREPARE_ONLINE
+ * setting up a state by using CPUHP_BP_PREPARE_DYN or CPUHP_AP_ONLINE_DYN
  * for the @state argument of the setup function.
  *
  * See Documentation/core-api/cpu_hotplug.rst for further information and
-- 
2.30.2

