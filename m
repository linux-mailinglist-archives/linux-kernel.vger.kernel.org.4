Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B79629391
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiKOItk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiKOIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:49:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D83EF5B6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:49:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id l2so12523078pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDByETx1OVv/ToHgra70XmddV8aLSLYjbfOVuUtVUdA=;
        b=efIjWq1qpJbOkdAufChryyAS7BGpLb40UjUYYHCrOH4VmIF8UEsFamcHZpm9b3MCkr
         DBZDZyhpN8hrX8GXGIB/XTfbR6aH/zjQmgZC4WThNXjwv4E0yex2T4OEXFSHUp4ipSbu
         VuTbNYcPj25M2JP4LXssjHphTCgprCHIN1ExEqqZe3qyobBmMuXP7RfaDni79DQXL1+x
         UmSAnk7Twr34PFKD8egLFLJXYM8t09IhWUlIkwdXV9UenflcdzkhVZfNFtq9jc7R6ZiY
         UwIluASviXxgVcKTlZlF9BC+h6EyRkcPRFuNzhWTM2XR3TqfUrinh/8c0asCRaqTH6VM
         g+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDByETx1OVv/ToHgra70XmddV8aLSLYjbfOVuUtVUdA=;
        b=Hi+bqz9RFW5KJNq9o9Xdelqdj1TrllCzdUWUpTwIWSvQ8hgpiuVdHAdAiE5XcWywji
         a773OU+xvPsNPliJfjNg51KaUcPL4oNDFjefIcVbuDEXMrn1usC4ScYSNid8NHUOc1/8
         Q6Jqzu56r0dUyYyDII2FPuo6lRalNtFHvnkjDzrs7vGZ3wdhvvrY+5f5pmAYOrYajVni
         fsz4Byfq7C4suNybA+pRzRBf59qT1Kg7iylqidaWcPzjDvmUtf+WsHH8eX6uICyZRJxZ
         OFd7NkBoM03/W8FttQs4pIf1CzUSE9B48a8wdAirDvVXT0Bnk0sbE/HoCr885lU3oDA+
         u8Eg==
X-Gm-Message-State: ANoB5pnHmLpKvWvqJrkIzo/4ILchzXZ0jud0b1G4c223lVnhWQyTFae6
        +MTwoo4iXr4JEX4qrr2EY8q0Eg==
X-Google-Smtp-Source: AA0mqf7jUj8DKZ+OSGC5Z0W0WMqhVST/H+mSyaO8yRIXIlTxlnWfDQd6HDTjJ9P9oDyZr3XSEx0tDA==
X-Received: by 2002:a17:90a:aa12:b0:218:4859:287c with SMTP id k18-20020a17090aaa1200b002184859287cmr1134445pjq.204.1668502176038;
        Tue, 15 Nov 2022 00:49:36 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id w37-20020a631625000000b00464858cf6b0sm7224125pgl.54.2022.11.15.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 00:49:35 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     debug@rivosinc.com
Cc:     aou@eecs.berkeley.edu, jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Subject: [PATCH v3] scripts/gdb: add lx_current support for riscv
Date:   Tue, 15 Nov 2022 00:49:23 -0800
Message-Id: <20221115084923.1822572-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115012917.1781185-1-debug@rivosinc.com>
References: <20221115012917.1781185-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csr_sscratch CSR holds current task_struct address when hart is in
user space. Trap handler on entry spills csr_sscratch into "tp" (x2)
register and zeroes out csr_sscratch CSR. Trap handler on exit reloads
"tp" with expected user mode value and place current task_struct address
again in csr_scratch CSR.

This patch assumes "tp" is pointing to task_struct. If value in
csr_scratch is numerically greater than "tp" then it assumes csr_scratch
is correct address of current task_struct. This logic holds when
   - hart is in user space, "tp" will be less than csr_scratch.
   - hart is in kernel space but not in trap handler, "tp" will be more
     than csr_scratch (csr_scratch being equal to 0).
   - hart is executing trap handler
       - "tp" is still pointing to user mode but csr_scratch contains
          ptr to task_struct. Thus numerically higher.
       - "tp" is  pointing to task_struct but csr_scratch now contains
          either 0 or numerically smaller value (transiently holds
          user mode tp)

Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
 scripts/gdb/linux/utils.py |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..ca5215a660c7 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -173,6 +173,21 @@ def get_current_task(cpu):
          else:
              raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
                                 "while running in userspace(EL0)")
+    elif utils.is_target_arch("riscv"):
+         current_tp = gdb.parse_and_eval("$tp")
+         scratch_reg = gdb.parse_and_eval("$sscratch")
+
+         # by default tp points to current task
+         current_task = current_tp.cast(task_ptr_type)
+
+         # scratch register is set 0 in trap handler after entering kernel.
+         # When hart is in user mode, scratch register is pointing to task_struct.
+         # and tp is used by user mode. So when scratch register holds larger value
+         # (negative address as ulong is larger value) than tp, then use scratch register.
+         if (scratch_reg.cast(utils.get_ulong_type()) >  current_tp.cast(utils.get_ulong_type())):
+             current_task = scratch_reg.cast(task_ptr_type)
+
+         return current_task.dereference()
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index 1553f68716cc..ddaf3089170d 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -35,12 +35,17 @@ class CachedType:
 
 
 long_type = CachedType("long")
+ulong_type = CachedType("ulong")
 atomic_long_type = CachedType("atomic_long_t")
 
 def get_long_type():
     global long_type
     return long_type.get_type()
 
+def get_ulong_type():
+    global ulong_type
+    return ulong_type.get_type()
+
 def offset_of(typeobj, field):
     element = gdb.Value(0).cast(typeobj)
     return int(str(element[field].address).split()[0], 16)
-- 
2.25.1

