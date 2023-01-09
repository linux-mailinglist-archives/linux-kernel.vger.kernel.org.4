Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C87662233
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjAIJxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjAIJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:57 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF22413D2A;
        Mon,  9 Jan 2023 01:51:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b17so1423081pld.7;
        Mon, 09 Jan 2023 01:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rxew3ajMkQ4bWs7+VLjcEpNUZ+iv1uP6LViYhl+6XNo=;
        b=ch9O8aLAyIywf0SGwOnngbKDBlFDadiZ826y64a3tRfyZGtRT3tTaW9bXsSE6hyKL6
         Hohrec581Dgv4feylcCX20L3Ra2vJ+SjtuOIJmfXGRzwNxQ6kOe4I8ll6Uq3GzlqVlMd
         ZpedJQdyM19MFLpuxG4lrJU4KKX5Izm+ygZ3iaYxiY3OeDjiHWouY5oTobnLtzAMZ5+C
         YlH7LNO25vDHwKty94vWy2r8XOmq8p7vPd7Sr78r8CaN+QJqqmhx9cXMSM+s6yCv+4lO
         C2EV2HMKcilV6mNkrcVByZenJ/pcn6yHv3gAnUvdwV64kXxRwYF2xHyhjBj4eWgLTSnC
         eN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rxew3ajMkQ4bWs7+VLjcEpNUZ+iv1uP6LViYhl+6XNo=;
        b=pZ/aYmqhhg7jPCrVc02gPZhRrAFbN5NTquLb9ff7JFNKv1+EcqYkwpuXlEHtxOY2BW
         JZPVKBKHwGQTcmoMzjUEKQkyXTr7uZawOCqxB5qZUkqxmn1UJix2OTpxgb031M/Srr9/
         CC3r9tm9du6xns62TVXJXbBDH6XecW743We+wUfzALF3da2D2iw81PfAsStzG7/aVQMi
         WMz5c28oT0My5tDNKL9yWwX1Ic/0uK9c6zZzsJvg1Fsoi+cwRpH3Mxy4OE3bQCSngwlC
         vJ7zVYRUfbeJ98qN8lgFZoQlnN4P7NMhBAz0ZxQuqxHOkOPf8iFPKoeI+d+QFLNbRbEs
         /OKA==
X-Gm-Message-State: AFqh2kqLb6YWaBlExGFNsP9me84jv8csIsvxCB8wJxTOVW63x/qltaZC
        tVHlO0jsNiQb0F9mYtLUdV0=
X-Google-Smtp-Source: AMrXdXuCovS+m6D/GwjSQ52aBkZhAvLOHDVXNu0oWROEUDgQeInMFn0/M8eThf5UqGc53oYSD6zgjQ==
X-Received: by 2002:a17:90a:fcf:b0:226:ed62:576e with SMTP id 73-20020a17090a0fcf00b00226ed62576emr9082736pjz.34.1673257880448;
        Mon, 09 Jan 2023 01:51:20 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090a2f0600b00226156cf039sm6827424pjd.44.2023.01.09.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:51:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2843F105013; Mon,  9 Jan 2023 16:51:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/8] Documentation: kvx: Wrap diagrams in literal code block
Date:   Mon,  9 Jan 2023 16:51:02 +0700
Message-Id: <20230109095108.21229-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24167; i=bagasdotme@gmail.com; h=from:subject; bh=RmQw3dvwG456+kl9oktVQc8IZ2fTICciIBt3vtjbgfU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMm7H3e9PHFBYE6QQ9zdtybHipI07m3sN5W8tdfu/eWaHl2d C6caO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRMBeG/0WajB7LXu7uutDIVPyxdO 1L/jVnH04+GvbMaemJhf8z13Aw/M/ZpJ1T4adk4pop5Pn1jOr1rA8irfO+K4h6V3plOdrLMwIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap code path diagrams in literal code block, just like other diagrams
in the kernel documentation. This avoids confusion with other constructs
(tables, block quotes, and inline substitutions).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kvx/kvx-exceptions.rst | 241 ++++++++++++++-------------
 Documentation/kvx/kvx-iommu.rst      |  64 +++----
 Documentation/kvx/kvx-mmu.rst        |  41 +++--
 Documentation/kvx/kvx.rst            |  96 +++++------
 4 files changed, 225 insertions(+), 217 deletions(-)

diff --git a/Documentation/kvx/kvx-exceptions.rst b/Documentation/kvx/kvx-exceptions.rst
index d3e52f30285223..bb9010efb14196 100644
--- a/Documentation/kvx/kvx-exceptions.rst
+++ b/Documentation/kvx/kvx-exceptions.rst
@@ -10,21 +10,21 @@ The offset depends on which exception vector the cpu wants to jump to:
 * $ev + 0x80 for interrupt
 * $ev + 0xc0 for syscall
 
-Then, handlers are laid in the following order:
+Then, handlers are laid in the following order::
 
-        +-------------+
-        |             |
-        |   Syscall   |
-        +-------------+
-        |             |
-        |  Interrupts |
-        +-------------+
-        |             |
-        |    Traps    |
-        +-------------+
-        |             | ^
-        |    Debug    | | Stride
-BASE -> +-------------+ v
+          +-------------+
+          |             |
+          |   Syscall   |
+          +-------------+
+          |             |
+          |  Interrupts |
+          +-------------+
+          |             |
+          |    Traps    |
+          +-------------+
+          |             | ^
+          |    Debug    | | Stride
+  BASE -> +-------------+ v
 
 
 Interrupts, and traps are serviced similarly, ie:
@@ -99,65 +99,66 @@ When handling a signal, the path is the following:
 7 - User application is restored at the exact point it was interrupted
     before.
 
+    ::
 
-        +----------+
-        |    1     |
-        | User app | @func
-        |  (user)  |
-        +---+------+
-            |
-            | it/trap/scall
-            |
-        +---v-------+
-        |    2      |
-        | exception |
-        | handling  |
-        | (kernel)  |
-        +---+-------+
-            |
-            | Check if signal are pending, if so, handle signals
-            |
-        +---v--------+
-        |    3       |
-        | do_signal  |
-        |  handling  |
-        |  (kernel)  |
-        +----+-------+
-             |
-             | Return to user signal handler
-             |
-        +----v------+
-        |    4      |
-        |  signal   |
-        |  handler  |
-        |  (user)   |
-        +----+------+
-             |
-             | Return to sigreturn trampoline
-             |
-        +----v-------+
-        |    5       |
-        |  syscall   |
-        |rt_sigreturn|
-        |  (user)    |
-        +----+-------+
-             |
-             | Syscall to rt_sigreturn
-             |
-        +----v-------+
-        |    6       |
-        |  sigreturn |
-        |  handler   |
-        |  (kernel)  |
-        +----+-------+
-             |
-             | Modify context to return to original func
-             |
-        +----v-----+
-        |    7     |
-        | User app | @func
-        |  (user)  |
-        +----------+
+            +----------+
+            |    1     |
+            | User app | @func
+            |  (user)  |
+            +---+------+
+                |
+                | it/trap/scall
+                |
+            +---v-------+
+            |    2      |
+            | exception |
+            | handling  |
+            | (kernel)  |
+            +---+-------+
+                |
+                | Check if signal are pending, if so, handle signals
+                |
+            +---v--------+
+            |    3       |
+            | do_signal  |
+            |  handling  |
+            |  (kernel)  |
+            +----+-------+
+                 |
+                 | Return to user signal handler
+                 |
+            +----v------+
+            |    4      |
+            |  signal   |
+            |  handler  |
+            |  (user)   |
+            +----+------+
+                 |
+                 | Return to sigreturn trampoline
+                 |
+            +----v-------+
+            |    5       |
+            |  syscall   |
+            |rt_sigreturn|
+            |  (user)    |
+            +----+-------+
+                 |
+                 | Syscall to rt_sigreturn
+                 |
+            +----v-------+
+            |    6       |
+            |  sigreturn |
+            |  handler   |
+            |  (kernel)  |
+            +----+-------+
+                 |
+                 | Modify context to return to original func
+                 |
+            +----v-----+
+            |    7     |
+            | User app | @func
+            |  (user)  |
+            +----------+
 
 Registers handling
 ==================
@@ -174,62 +175,62 @@ Interrupts and traps
 
 When interrupt and traps are triggered, we only save the caller-saved registers.
 Indeed, we rely on the fact that C code will save and restore callee-saved and
-hence, there is no need to save them. This path is the following:
+hence, there is no need to save them. This path is the following::
 
-     +------------+          +-----------+        +---------------+
-IT   | Save caller| C Call   | Execute C |  Ret   | Restore caller| Ret from IT
-+--->+   saved    +--------->+  handler  +------->+     saved     +----->
-     | registers  |          +-----------+        |   registers   |
-     +------------+                               +---------------+
+       +------------+          +-----------+        +---------------+
+  IT   | Save caller| C Call   | Execute C |  Ret   | Restore caller| Ret from IT
+  +--->+   saved    +--------->+  handler  +------->+     saved     +----->
+       | registers  |          +-----------+        |   registers   |
+       +------------+                               +---------------+
 
 However, when returning to user, we check if there is work_pending. If a signal
 is pending and there is a signal handler to be called, then we need all
 registers to be saved on the stack in the pt_regs before executing the signal
 handler and restored after that. Since we only saved caller-saved registers, we
 need to also save callee-saved registers to restore them correctly when
-returning to user. This path is the following (a bit more complicated !):
+returning to user. This path is the following (a bit more complicated !)::
 
-      +------------+
-      | Save caller|          +-----------+  Ret   +------------+
- IT   |   saved    | C Call   | Execute C | to asm | Check work |
- +--->+ registers  +--------->+  handler  +------->+   pending  |
-      | to pt_regs |          +-----------+        +--+---+-----+
-      +------------+                                  |   |
-                        Work pending                  |   | No work pending
-         +--------------------------------------------+   |
-         |                                                |
-         |                                   +------------+
-         v                                   |
-  +------+------+                            v
-  | Save callee |                    +-------+-------+
-  |   saved     |                    | Restore caller|  RFE from IT
-  | registers   |                    |     saved     +------->
-  | to pt_regs  |                    |   registers   |
-  +--+-------+--+                    | from pt_regs  |
-     |       |                       +-------+-------+
-     |       |         +---------+           ^
-     |       |         | Execute |           |
-     |       +-------->+ needed  +-----------+
-     |                 |  work   |
-     |                 +---------+
-     |Signal handler ?
-     v
-+----+----------+ RFE to user +-------------+       +--------------+
-|   Copy all    | handler     |  Execute    |  ret  | rt_sigreturn |
-|   registers   +------------>+ user signal +------>+ trampoline   |
-| from pt_regs  |             |  handler    |       |  to kernel   |
-| to user stack |             +-------------+       +------+-------+
-+---------------+                                          |
-                         syscall rt_sigreturn              |
-         +-------------------------------------------------+
-         |
-         v
-+--------+-------+                      +-------------+
-|   Recopy all   |                      | Restore all |  RFE
-| registers from +--------------------->+    saved    +------->
-|   user stack   |       Return         |  registers  |
-|   to pt_regs   |    from sigreturn    |from pt_regs |
-+----------------+  (via ret_from_fork) +-------------+
+        +------------+
+        | Save caller|          +-----------+  Ret   +------------+
+   IT   |   saved    | C Call   | Execute C | to asm | Check work |
+   +--->+ registers  +--------->+  handler  +------->+   pending  |
+        | to pt_regs |          +-----------+        +--+---+-----+
+        +------------+                                  |   |
+                          Work pending                  |   | No work pending
+           +--------------------------------------------+   |
+           |                                                |
+           |                                   +------------+
+           v                                   |
+    +------+------+                            v
+    | Save callee |                    +-------+-------+
+    |   saved     |                    | Restore caller|  RFE from IT
+    | registers   |                    |     saved     +------->
+    | to pt_regs  |                    |   registers   |
+    +--+-------+--+                    | from pt_regs  |
+       |       |                       +-------+-------+
+       |       |         +---------+           ^
+       |       |         | Execute |           |
+       |       +-------->+ needed  +-----------+
+       |                 |  work   |
+       |                 +---------+
+       |Signal handler ?
+       v
+  +----+----------+ RFE to user +-------------+       +--------------+
+  |   Copy all    | handler     |  Execute    |  ret  | rt_sigreturn |
+  |   registers   +------------>+ user signal +------>+ trampoline   |
+  | from pt_regs  |             |  handler    |       |  to kernel   |
+  | to user stack |             +-------------+       +------+-------+
+  +---------------+                                          |
+                           syscall rt_sigreturn              |
+           +-------------------------------------------------+
+           |
+           v
+  +--------+-------+                      +-------------+
+  |   Recopy all   |                      | Restore all |  RFE
+  | registers from +--------------------->+    saved    +------->
+  |   user stack   |       Return         |  registers  |
+  |   to pt_regs   |    from sigreturn    |from pt_regs |
+  +----------------+  (via ret_from_fork) +-------------+
 
 
 Syscalls
diff --git a/Documentation/kvx/kvx-iommu.rst b/Documentation/kvx/kvx-iommu.rst
index 96b74ce71acb3e..69eca8d1bc37a1 100644
--- a/Documentation/kvx/kvx-iommu.rst
+++ b/Documentation/kvx/kvx-iommu.rst
@@ -63,39 +63,39 @@ IOMMU implementation
 --------------------
 
 The kvx is providing several IOMMUs. Here is a simplified view of all IOMMUs
-and translations that occurs between memory and devices:
+and translations that occurs between memory and devices::
 
- +---------------------------------------------------------------------+
- | +------------+     +---------+                          | CLUSTER X |
- | | Cores 0-15 +---->+ Crypto  |                          +-----------|
- | +-----+------+     +----+----+                                      |
- |       |                 |                                           |
- |       v                 v                                           |
- |   +-------+        +------------------------------+                 |
- |   |  MMU  |   +----+ IOMMU x4 (secure + insecure) |                 |
- |   +---+---+   |    +------------------------------+                 |
- |       |       |                                                     |
- +--------------------+                                                |
-        |        |    |                                                |
-        v        v    |                                                |
-    +---+--------+-+  |                                                |
-    |    MEMORY    |  |     +----------+     +--------+     +-------+  |
-    |              +<-|-----+ IOMMU Rx |<----+ DMA Rx |<----+       |  |
-    |              |  |     +----------+     +--------+     |       |  |
-    |              |  |                                     |  NoC  |  |
-    |              |  |     +----------+     +--------+     |       |  |
-    |              +--|---->| IOMMU Tx +---->| DMA Tx +---->+       |  |
-    |              |  |     +----------+     +--------+     +-------+  |
-    |              |  +------------------------------------------------+
-    |              |
-    |              |     +--------------+     +------+
-    |              |<--->+ IOMMU Rx/Tx  +<--->+ PCIe +
-    |              |     +--------------+     +------+
-    |              |
-    |              |     +--------------+     +------------------------+
-    |              |<--->+ IOMMU Rx/Tx  +<--->+ master Soc Peripherals |
-    |              |     +--------------+     +------------------------+
-    +--------------+
+  +---------------------------------------------------------------------+
+  | +------------+     +---------+                          | CLUSTER X |
+  | | Cores 0-15 +---->+ Crypto  |                          +-----------|
+  | +-----+------+     +----+----+                                      |
+  |       |                 |                                           |
+  |       v                 v                                           |
+  |   +-------+        +------------------------------+                 |
+  |   |  MMU  |   +----+ IOMMU x4 (secure + insecure) |                 |
+  |   +---+---+   |    +------------------------------+                 |
+  |       |       |                                                     |
+  +--------------------+                                                |
+         |        |    |                                                |
+         v        v    |                                                |
+     +---+--------+-+  |                                                |
+     |    MEMORY    |  |     +----------+     +--------+     +-------+  |
+     |              +<-|-----+ IOMMU Rx |<----+ DMA Rx |<----+       |  |
+     |              |  |     +----------+     +--------+     |       |  |
+     |              |  |                                     |  NoC  |  |
+     |              |  |     +----------+     +--------+     |       |  |
+     |              +--|---->| IOMMU Tx +---->| DMA Tx +---->+       |  |
+     |              |  |     +----------+     +--------+     +-------+  |
+     |              |  +------------------------------------------------+
+     |              |
+     |              |     +--------------+     +------+
+     |              |<--->+ IOMMU Rx/Tx  +<--->+ PCIe +
+     |              |     +--------------+     +------+
+     |              |
+     |              |     +--------------+     +------------------------+
+     |              |<--->+ IOMMU Rx/Tx  +<--->+ master Soc Peripherals |
+     |              |     +--------------+     +------------------------+
+     +--------------+
 
 
 There is also an IOMMU dedicated to the crypto module but this module will not
diff --git a/Documentation/kvx/kvx-mmu.rst b/Documentation/kvx/kvx-mmu.rst
index 59bda2afc9abde..832fb7c41a49d8 100644
--- a/Documentation/kvx/kvx-mmu.rst
+++ b/Documentation/kvx/kvx-mmu.rst
@@ -157,14 +157,17 @@ We only support three levels for the page table and 4KB for page size.
 3 levels page table
 -------------------
 
-...-----+--------+--------+--------+--------+--------+
-      40|39    32|31    24|23    16|15     8|7      0|
-...-----++-------+--+-----+---+----+----+---+--------+
-         |          |         |         |
-         |          |         |         +--->  [11:0] Offset (12 bits)
-         |          |         +------------->  [20:12] PTE offset (9 bits)
-         |          +----------------------->  [29:21] PMD offset (9 bits)
-         +---------------------------------->  [39:30] PGD offset (10 bits)
+::
+
+  ...-----+--------+--------+--------+--------+--------+
+        40|39    32|31    24|23    16|15     8|7      0|
+  ...-----++-------+--+-----+---+----+----+---+--------+
+           |          |         |         |
+           |          |         |         +--->  [11:0] Offset (12 bits)
+           |          |         +------------->  [20:12] PTE offset (9 bits)
+           |          +----------------------->  [29:21] PMD offset (9 bits)
+           +---------------------------------->  [39:30] PGD offset (10 bits)
+
 Bits 40 to 64 are signed extended according to bit 39. If bit 39 is equal to 1
 we are in kernel space.
 
@@ -175,12 +178,14 @@ PTE format
 
 About the format of the PTE entry, as we are not forced by hardware for choices,
 we choose to follow the format described in the RiscV implementation as a
-starting point.
+starting point::
+
+  +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
+  | 63..23  | 22..13 | 12 | 11..10 | 9 | 8 | 7 | 6 | 5 | 4 | 3..2 | 1 | 0 |
+  +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
+      PFN     Unused   S    PageSZ   H   G   X   W   R   D    CP    A   P
+
 
- +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
- | 63..23  | 22..13 | 12 | 11..10 | 9 | 8 | 7 | 6 | 5 | 4 | 3..2 | 1 | 0 |
- +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
-     PFN     Unused   S    PageSZ   H   G   X   W   R   D    CP    A   P
        where:
         P: Present
         A: Accessed
@@ -231,10 +236,12 @@ kvx implementation to use them is based on other architectures (such as arc
 or xtensa) and uses a wrapping ASN counter containing both cycle/generation and
 asn.
 
-+---------+--------+
-|63     10|9      0|
-+---------+--------+
-  Cycle      ASN
+::
+
+  +---------+--------+
+  |63     10|9      0|
+  +---------+--------+
+    Cycle      ASN
 
 This ASN counter is incremented monotonously to allocate new ASNs. When the
 counter reaches 511 (9 bit), TLB is completely flushed and a new cycle is
diff --git a/Documentation/kvx/kvx.rst b/Documentation/kvx/kvx.rst
index 8ce0703de6813b..20c3666f445e26 100644
--- a/Documentation/kvx/kvx.rst
+++ b/Documentation/kvx/kvx.rst
@@ -15,17 +15,17 @@ On kvx, we have 4 levels of privilege level starting from 0 (most
 privileged one) to 3 (less privilege one). A system of owners allows
 to delegate ownership of resources by using specials system registers.
 
-The 2 main software stacks for Linux Kernel are the following:
+The 2 main software stacks for Linux Kernel are the following::
 
-+-------------+       +-------------+
-| PL0: Debug  |       | PL0: Debug  |
-+-------------+       +-------------+
-| PL1: Linux  |       | PL1: HyperV |
-+-------------+       +-------------+
-| PL2: User   |       | PL2: Linux  |
-+-------------+       +-------------+
-|             |       | PL3: User   |
-+-------------+       +-------------+
+  +-------------+       +-------------+
+  | PL0: Debug  |       | PL0: Debug  |
+  +-------------+       +-------------+
+  | PL1: Linux  |       | PL1: HyperV |
+  +-------------+       +-------------+
+  | PL2: User   |       | PL2: Linux  |
+  +-------------+       +-------------+
+  |             |       | PL3: User   |
+  +-------------+       +-------------+
 
 In both cases, the kvx support for privileges has been designed using
 only relative PL and thus should work on both configurations without
@@ -201,45 +201,45 @@ to it, the kernel sends an interrupt using a mailbox.
 If the L2$ node is not present in the device tree, then, the RM will directly go
 into sleeping.
 
-Boot diagram:
+Boot diagram::
 
-           RM                       PE 0
-                          +
-       +---------+        |
-       |  Boot   |        |
-       +----+----+        |
-            |             |
-            v             |
-      +-----+-----+       |
-      |  Prepare  |       |
-      | L2 shared |       |
-      |  memory   |       |
-      |(registers)|       |
-      +-----+-----+       |
-            |             |      +-----------+
-            +------------------->+   Boot    |
-            |             |      +-----+-----+
-            v             |            |
-   +--------+---------+   |            |
-   | L2 firmware      |   |            |
-   | parameters:      |   |            |
-   | r0 = registers   |   |            |
-   | r1 = DTB         |   |            |
-   +--------+---------+   |            |
-            |             |            |
-            v             |            |
-    +-------+--------+    |     +------+------+
-    |  L2 firmware   |    |     | Wait for L2 |
-    |   execution    |    |     | to be ready |
-    +-------+--------+    |     +------+------+
-            |             |            |
-     +------v-------+     |            v
-     | L2 requests  |     |     +------+------+
-+--->+   handling   |     |     |   Enable    |
-|    +-------+------+     |     | L2 caching  |
-|            |            |     +------+------+
-|            |            |            |
-+------------+            +            v
+             RM                       PE 0
+                            +
+         +---------+        |
+         |  Boot   |        |
+         +----+----+        |
+              |             |
+              v             |
+        +-----+-----+       |
+        |  Prepare  |       |
+        | L2 shared |       |
+        |  memory   |       |
+        |(registers)|       |
+        +-----+-----+       |
+              |             |      +-----------+
+              +------------------->+   Boot    |
+              |             |      +-----+-----+
+              v             |            |
+     +--------+---------+   |            |
+     | L2 firmware      |   |            |
+     | parameters:      |   |            |
+     | r0 = registers   |   |            |
+     | r1 = DTB         |   |            |
+     +--------+---------+   |            |
+              |             |            |
+              v             |            |
+      +-------+--------+    |     +------+------+
+      |  L2 firmware   |    |     | Wait for L2 |
+      |   execution    |    |     | to be ready |
+      +-------+--------+    |     +------+------+
+              |             |            |
+       +------v-------+     |            v
+       | L2 requests  |     |     +------+------+
+  +--->+   handling   |     |     |   Enable    |
+  |    +-------+------+     |     | L2 caching  |
+  |            |            |     +------+------+
+  |            |            |            |
+  +------------+            +            v
 
 
 Since this driver is started early (before SMP boot), A lot of drivers are not
-- 
An old man doll... just what I always wanted! - Clara

