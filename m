Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD507717210
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjE3Xxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjE3XxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:53:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B26D9102;
        Tue, 30 May 2023 16:53:15 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id C1CAA20FC478;
        Tue, 30 May 2023 16:53:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1CAA20FC478
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685490792;
        bh=OnNeNVSXO4ERkaHgFCtG87kG7AJD7W63eM8/Z9KuQYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjeeYvha+B2nxh6wbsBLm+UDoVXiEgiDGz5pSBxsZK1mzeyJ2FUM9wvakPcF+nlnp
         +QQnVM1844JyP3ncObsRr2dSaNiXB/wxPX90MMI9p7jbIxYJVcXBRTKvCxqMB0jN64
         UrUQxOH+JW9hk3vIBdozhs+zM6S0ZgheYtuAkzao=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH 5/5] tracing/user_events: Add auto-del flag documentation
Date:   Tue, 30 May 2023 16:53:04 -0700
Message-Id: <20230530235304.2726-6-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530235304.2726-1-beaub@linux.microsoft.com>
References: <20230530235304.2726-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now a flag for user_events to use when registering events to
auto delete events upon the last reference put. Add the new flag,
USER_EVENT_REG_AUTO_DEL, to user_events documentation files to let
people know how to use it.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 Documentation/trace/user_events.rst | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index f79987e16cf4..946da25be812 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -39,6 +39,14 @@ DIAG_IOCSREG.
 
 This command takes a packed struct user_reg as an argument::
 
+  enum user_reg_flag {
+        /* Event will auto delete upon last reference closing */
+        USER_EVENT_REG_AUTO_DEL		= 1U << 0,
+
+        /* This value or above is currently non-ABI */
+        USER_EVENT_REG_MAX		= 1U << 1,
+  };
+
   struct user_reg {
         /* Input: Size of the user_reg structure being used */
         __u32 size;
@@ -49,7 +57,7 @@ This command takes a packed struct user_reg as an argument::
         /* Input: Enable size in bytes at address */
         __u8 enable_size;
 
-        /* Input: Flags for future use, set to 0 */
+        /* Input: Flags can be any of the above user_reg_flag values */
         __u16 flags;
 
         /* Input: Address to update when enabled */
@@ -73,10 +81,13 @@ The struct user_reg requires all the above inputs to be set appropriately.
   This must be 4 (32-bit) or 8 (64-bit). 64-bit values are only allowed to be
   used on 64-bit kernels, however, 32-bit can be used on all kernels.
 
-+ flags: The flags to use, if any. For the initial version this must be 0.
-  Callers should first attempt to use flags and retry without flags to ensure
-  support for lower versions of the kernel. If a flag is not supported -EINVAL
-  is returned.
++ flags: The flags to use, if any. Callers should first attempt to use flags
+  and retry without flags to ensure support for lower versions of the kernel.
+  If a flag is not supported -EINVAL is returned.
+
+  **USER_EVENT_REG_AUTO_DEL**
+        When the last reference is closed for the event, the event will delete
+        itself automatically as if the delete IOCTL was issued by a user.
 
 + enable_addr: The address of the value to use to reflect event status. This
   must be naturally aligned and write accessible within the user program.
-- 
2.25.1

