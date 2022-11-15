Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3789862ADDE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKOWLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKOWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:11:30 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3333F23E9E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:11:29 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k22so15596473pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkMnn2hGaVIkC9WoaV7C4n+L3kmdU9eKYGAAaB0CkLs=;
        b=omrubLvBhU67yWHuCUt157MtsLyqmOxlOY90kmUhIC+fxrSEJuMAhD3Q3dstqlRjRs
         QDAPvF0t3LvqGN2e/OQhw0tUQy9A7AIZfA9uibwsGGGcZcB2sFokQc5YWbymwn6sXU+D
         ua3URoZeBOQ1ejBwqsq8SFUbz9hL3lrJVgU692VI9J9wfdd9CwnTx/LIBlUz74GeC7i3
         5ei/ujLx0cfYNc0oAsg4vsKAMZLylCiUfzf1O7vSSMvITeHvsvZ+xyHJXkHPeyMYdFxC
         HxVFUVlB+mMdnbKusTfnG0V8VZGNMC+q7lq0AAvHDCYWZSijG43qQ2QOTplhFbBEsYKn
         resA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkMnn2hGaVIkC9WoaV7C4n+L3kmdU9eKYGAAaB0CkLs=;
        b=E+nlJMar2L2DgO1Sc1gXRBTudQqoLEQacarUGrkVmCq0ftz9ezgu8jwPLpYUVtY1Kb
         9m7jwKL3jNaxohu2+SVDILYAciNtJQg53p+DIUCYdncEga2EMHQFOhBoWzqnUdjGhJwq
         q24nqfCxkg462eRG8OV8VDkZ9824RxpbiBv6IzkUA4r+bf4wMNuULQZm8Xx6bcWO/W6O
         lNb/fwlsfBCuS0Mjq30l6BzbJgBTu4TPqc3D6b6wJPkZ83sW98atihERCf9rux25fnux
         ZpdpEhfou0OIXst4r/SCAu9mS0LBgKK46DCvSXuMw92chkniZDAojvp9COnfGDoYRJ0n
         g5RQ==
X-Gm-Message-State: ANoB5plwKjERjpfrVIklB7GUudrO8XEMwbY3B2v1/ENHxn9QQnI+mOZ6
        +Tfy8Xz1A5UJ7oRa/vnK4rdOmw==
X-Google-Smtp-Source: AA0mqf5Ej6WdaotiYIORVhIReaHaKonh/Grxk+AFuiPYZ68nUsc0E2HWyPHXEZNxvKIXYL2BFPpSzQ==
X-Received: by 2002:a63:b14:0:b0:470:18d4:f18d with SMTP id 20-20020a630b14000000b0047018d4f18dmr17900349pgl.295.1668550288686;
        Tue, 15 Nov 2022 14:11:28 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001785fa792f4sm10534216plg.243.2022.11.15.14.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:11:28 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     conor.dooley@microchip.com
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu, debug@rivosinc.com,
        jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: [PATCH v5] scripts/gdb: add lx_current support for riscv
Date:   Tue, 15 Nov 2022 14:10:51 -0800
Message-Id: <20221115221051.1871569-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d65bddf3-c58a-1420-bff9-8333c10edb56@microchip.com>
References: <d65bddf3-c58a-1420-bff9-8333c10edb56@microchip.com>
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
again in csr_sscratch CSR.

This patch assumes "tp" is pointing to task_struct. If value in
csr_sscratch is numerically greater than "tp" then it assumes csr_sscratch
is correct address of current task_struct. This logic holds when
   - hart is in user space, "tp" will be less than csr_sscratch.
   - hart is in kernel space but not in trap handler, "tp" will be more
     than csr_sscratch (csr_sscratch being equal to 0).
   - hart is executing trap handler
       - "tp" is still pointing to user mode but csr_sscratch contains
          ptr to task_struct. Thus numerically higher.
       - "tp" is  pointing to task_struct but csr_sscratch now contains
          either 0 or numerically smaller value (transiently holds
          user mode tp)

Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

---
Since patch has changed a little bit from v1 and I didn't include
changelog earlier, here it is.

v1 --> v2:
 - added logic to locate task_struct irrespective of priv
 - made locating task_struct agnostic to bitness(32 vs 64).
 - added caching of ulong type in scripts/gdb/linux/utils.py
 - added more descriptive commit message

v2 --> v3:
 - amended commit message and source line to fit column width

v3 --> v4:
 - amended commit message and remove whitespace in source
 - added Reviewed-by for reviewers

v4 --> v5:
 - changing the order of changelog and sign off/review tags in commit
---
---
 scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
 scripts/gdb/linux/utils.py |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..14c22f82449b 100644
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
+         if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
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

