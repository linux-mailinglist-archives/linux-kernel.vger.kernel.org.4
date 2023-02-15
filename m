Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B0697D58
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjBON3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBON3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:29:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEED8A5F;
        Wed, 15 Feb 2023 05:28:33 -0800 (PST)
Date:   Wed, 15 Feb 2023 13:28:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676467712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4F0ou3VX9jn2+Yq4FUDUy8SBBZh5JpvHrJaRSMBy0D8=;
        b=eF0tDCjAtu/pO3fOIBXW+OEovGcPHvd40A3uv0FRQfTJ7MFBM6KPvt0rM30aPKECEPG53M
        5+tqosy60CknZpBnihwFgwUxyW5q7cwOJQB+a1fspUFF5PJcnDk9B6b5JNpgg8HQH+TegT
        e7yuIq/zoqteyKsKP36esXzbYoRyYmy1UTgJkWIAbMt3GDLMZ2LsOhvPIymD50xeLSAzxA
        Haxk2XgqcH9Gh0RFOGrlXijuyIvEgj4q6Y/3t+Up4b4Wa+XFnyN/LKI8GJeD9ElAWHWuir
        tPzwYl7EgUn/drJBjRjrwwCKYhjbpShWKiaRcs/rvzEP7kJ+1uE0pupx9Jikow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676467712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4F0ou3VX9jn2+Yq4FUDUy8SBBZh5JpvHrJaRSMBy0D8=;
        b=YpN8hqf8nT909o2W5GLnFFWRd/w+Klfv+pAtDSeRnGvysLiN+e+vn1/huDrRNg0DKmxkTG
        Jhchz/pCfaX+HqAA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Make 64-bit defconfig the default
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230215091706.1623070-1-arnd@kernel.org>
References: <20230215091706.1623070-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <167646771153.4906.1352893962848318738.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     f9bb7f6a7eb0efd282f7364115f97e652677a29b
Gitweb:        https://git.kernel.org/tip/f9bb7f6a7eb0efd282f7364115f97e652677a29b
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 15 Feb 2023 10:16:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 15 Feb 2023 14:20:17 +01:00

x86/build: Make 64-bit defconfig the default

Running 'make ARCH=x86 defconfig' on anything other than an x86_64
machine currently results in a 32-bit build, which is rarely what
anyone wants these days.

Change the default so that the 64-bit config gets used unless
the user asks for i386_defconfig, uses ARCH=i386 or runs on
a system that "uname -m" identifies as i386/i486/i586/i686.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230215091706.1623070-1-arnd@kernel.org
---
 arch/x86/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 73ed982..b399759 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -3,10 +3,10 @@
 
 # select defconfig based on actual architecture
 ifeq ($(ARCH),x86)
-  ifeq ($(shell uname -m),x86_64)
-        KBUILD_DEFCONFIG := x86_64_defconfig
-  else
+  ifeq ($(shell uname -m | sed -e 's/i.86/i386/'),i386)
         KBUILD_DEFCONFIG := i386_defconfig
+  else
+        KBUILD_DEFCONFIG := x86_64_defconfig
   endif
 else
         KBUILD_DEFCONFIG := $(ARCH)_defconfig
