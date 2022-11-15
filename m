Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4838D628F34
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiKOB3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKOB3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:29:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836D5FDA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 17:29:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y4so11773724plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 17:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9j9azrr5inQKGRnsCPduX09/ehA5bMl/3GVVoPZxxc=;
        b=MuozMWB88+EewPEyNda8KjeV+i3ykswg0ciKOoKOZKVds7D6FKlZ1PWiILdbrIfKH7
         m2WJm9MpxqEJAoLH8TJtxSh7qhUbiuV93o76f4Fki6iYkPp3X3etEV6UWInE5Tynd6y3
         QpgbLkWVJ198yRocUG9mJYy10E7Tr89DYG43pHnwJv7sROQN2iwaaePwLu4A1/F1Dpq+
         Q6XcYpwyXVsGFiqv34i6wc3WeuQoOQeTk3RkHGocK+500+xfgBlI5GD9JtUC+lOnBbas
         w/GLYCUq0XzCQwtag0i8nbBmPYyWTYakKYR3Lyu46Pawqv45zbFfnejsAiGEHecCiKLh
         mEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9j9azrr5inQKGRnsCPduX09/ehA5bMl/3GVVoPZxxc=;
        b=C4mZFLu4FDLodQZ3dET2/6E/LGNHOHQFnGd5wLM2924LzJGkfE+Bq6W1vaE4p4Fo9w
         FU4EsMRKShOdg0PepZ2oH2U24NR8HcqP3F8EpIC7luvEcc/4lWWtnEMh7eb+Av906toX
         r2rJDDAe6rILHx33rLDLffyPAVdDUj8jG6cu7+iJsqor22b2otvObv22fBFWov1SXPhS
         AHPXEHrU4H2lwx64goydrHNEnshLkwMQvJkrthdfIJP6uyGfRnNWtgATolj8OZpeyLsp
         2OrgsRFsVs+L3Sf4v/qZjyykPUesfrqPaItHYwwBlGeXpG5iXy4VchQDrfsPCctlUpgk
         ud2w==
X-Gm-Message-State: ANoB5pnomXSUbAcECMjKOi0pM2EXcO7NX2zLI0vMaQZfCKwexk2PJEw8
        UGmB706x9bETirgitpljCxWXjw==
X-Google-Smtp-Source: AA0mqf4pZXY8/SPXCsrlGjQCb/4iYLUpAyb1vYtv/I+ZXIRBp6wRswqnXyiHp/HCceOIdg1ojiCc2A==
X-Received: by 2002:a17:902:7283:b0:17f:def6:a483 with SMTP id d3-20020a170902728300b0017fdef6a483mr1805442pll.66.1668475771239;
        Mon, 14 Nov 2022 17:29:31 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e127-20020a621e85000000b0056bb06ce1cfsm7587231pfe.97.2022.11.14.17.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:29:30 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     debug@rivosinc.com
Cc:     aou@eecs.berkeley.edu, jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: [PATCH v2] scripts/gdb: add lx_current support for riscv
Date:   Mon, 14 Nov 2022 17:29:17 -0800
Message-Id: <20221115012917.1781185-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111195938.1499148-2-debug@rivosinc.com>
References: <20221111195938.1499148-2-debug@rivosinc.com>
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

csr_sscratch CSR holds current task_struct address when hart is in user space.
trap handler on entry spills csr_sscratch into "tp" (x2) register and zeroes out
csr_sscratch CSR. trap handler on exit reloads "tp" with expected user mode value
and place current task_struct address again in csr_scratch CSR.

This patch assumes "tp" is pointing to task_struct. If value in csr_scratch is numerically
greater than "tp" then it assumes csr_scratch is correct address of current task_struct.
This logic holds when
   - hart is in user space, "tp" will be less than csr_scratch.
   - hart is in kernel space but not in trap handler, "tp" will be more than csr_scratch.
   - hart is executing trap handler
           - "tp" is still pointing to user mode but csr_scratch contains ptr to task_struct.
             numerically higher.
           - "tp" is now pointing to task_struct but csr_scratch now contains either 0 or numerically
              smaller value.

Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
 scripts/gdb/linux/utils.py |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..fd818d7896ce 100644
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
+         # So when scratch register holds higher value (negative address as ulong is bigger value) than tp,
+         # then use scratch register
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

