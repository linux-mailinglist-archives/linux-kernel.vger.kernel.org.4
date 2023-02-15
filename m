Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C4697E82
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBOOif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBOOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:38:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501778A5E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:38:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r2so19366067wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDDQpcu4wlArU6dZYMfeUKSEQsg6b1kdryOeCUrFQlc=;
        b=NWWiA7pEQ+rkqfq6PxjAcfVNFkh/3naJV1qTqerZm0mmH+bBEsJWA+oh5IwlpOL+AR
         KXJ7H0JHrAp17b0C+1P0EDUTnuDad6z1StppmmFKeMYRzqBEF3AGsqgBNWd1EXa3LGM+
         tapyOWmDfrPK0EU9s24YUWPS6qTqye3oovAJGa1pJupXz6nwhjkr+q6Reclx3sk9qFJu
         XBx6069D3Wbt7BpXxmJ9T1iuGjsn1zcCKIfJYCvjGHUacLH4MuHMP6cQh14cOZVXoq7a
         /29ySlqZo/dPkpGQ3aqKvkoH086Qd9+B+FfSjJzwbgfmBhtWniu+UssrHq8ODeuVJoTf
         BBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDDQpcu4wlArU6dZYMfeUKSEQsg6b1kdryOeCUrFQlc=;
        b=jyCSAbkhgq9OMO6nQU89B0KSXnSnEfLjeDZOvylXUd700pAq7brM2y7PjUcs+W8iTm
         FK3APN8Hl+3HHVBJpp3UA3U9HJ/3dEpKUE8KAOUDSz3zk8cTD4HeNanj23/NgGcAtWmH
         lvuTfJ8gi1D3Jv6KeAf+r7JhBVEhde/9cyocphk414p0dtY/O84FmCzezTfnxFio+JAj
         SGlwjD3xNK49GSZvVfIc0u1yY0UnqqI2vQygnkIO/MRULVBe/Zt8+I6mOvaRZLizB6JH
         fg+lqbrFagmDv+zKEaeiLi+hk3cb7pEu8fzEiE0U9rXodmhz293s2ou90uH8RPjfd8pl
         Vf6g==
X-Gm-Message-State: AO0yUKUpGwb+Qa8Y18CNM9KhIX+a3BblMrgAMdG9yuMuNNOH/eau1O6g
        xByp0xjVU6UXbNN1kYLoxKsPsQ==
X-Google-Smtp-Source: AK7set9Df7sPhWCSuF3fCAo3V27citHHiLZ7aQJdxJGeprd+nLleiF9LWkfZ3+y7qC+M4ZRkrTuxnA==
X-Received: by 2002:a5d:5552:0:b0:2c5:5dbf:1cc2 with SMTP id g18-20020a5d5552000000b002c55dbf1cc2mr1659354wrw.32.1676471910785;
        Wed, 15 Feb 2023 06:38:30 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id q4-20020a05600000c400b002c54737e908sm13906189wrx.91.2023.02.15.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:38:30 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>
Subject: [PATCH v8 2/3] powerpc: Move script to check relocations at compile time in scripts/
Date:   Wed, 15 Feb 2023 15:36:25 +0100
Message-Id: <20230215143626.453491-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215143626.453491-1-alexghiti@rivosinc.com>
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Ghiti <alex@ghiti.fr>

Relocating kernel at runtime is done very early in the boot process, so
it is not convenient to check for relocations there and react in case a
relocation was not expected.

Powerpc architecture has a script that allows to check at compile time
for such unexpected relocations: extract the common logic to scripts/
so that other architectures can take advantage of it.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
---
 arch/powerpc/tools/relocs_check.sh | 18 ++----------------
 scripts/relocs_check.sh            | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)
 create mode 100755 scripts/relocs_check.sh

diff --git a/arch/powerpc/tools/relocs_check.sh b/arch/powerpc/tools/relocs_check.sh
index 63792af00417..6b350e75014c 100755
--- a/arch/powerpc/tools/relocs_check.sh
+++ b/arch/powerpc/tools/relocs_check.sh
@@ -15,21 +15,8 @@ if [ $# -lt 3 ]; then
 	exit 1
 fi
 
-# Have Kbuild supply the path to objdump and nm so we handle cross compilation.
-objdump="$1"
-nm="$2"
-vmlinux="$3"
-
-# Remove from the bad relocations those that match an undefined weak symbol
-# which will result in an absolute relocation to 0.
-# Weak unresolved symbols are of that form in nm output:
-# "                  w _binary__btf_vmlinux_bin_end"
-undef_weak_symbols=$($nm "$vmlinux" | awk '$1 ~ /w/ { print $2 }')
-
 bad_relocs=$(
-$objdump -R "$vmlinux" |
-	# Only look at relocation lines.
-	grep -E '\<R_' |
+${srctree}/scripts/relocs_check.sh "$@" |
 	# These relocations are okay
 	# On PPC64:
 	#	R_PPC64_RELATIVE, R_PPC64_NONE
@@ -44,8 +31,7 @@ R_PPC_ADDR16_LO
 R_PPC_ADDR16_HI
 R_PPC_ADDR16_HA
 R_PPC_RELATIVE
-R_PPC_NONE' |
-	([ "$undef_weak_symbols" ] && grep -F -w -v "$undef_weak_symbols" || cat)
+R_PPC_NONE'
 )
 
 if [ -z "$bad_relocs" ]; then
diff --git a/scripts/relocs_check.sh b/scripts/relocs_check.sh
new file mode 100755
index 000000000000..137c660499f3
--- /dev/null
+++ b/scripts/relocs_check.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Get a list of all the relocations, remove from it the relocations
+# that are known to be legitimate and return this list to arch specific
+# script that will look for suspicious relocations.
+
+objdump="$1"
+nm="$2"
+vmlinux="$3"
+
+# Remove from the possible bad relocations those that match an undefined
+# weak symbol which will result in an absolute relocation to 0.
+# Weak unresolved symbols are of that form in nm output:
+# "                  w _binary__btf_vmlinux_bin_end"
+undef_weak_symbols=$($nm "$vmlinux" | awk '$1 ~ /w/ { print $2 }')
+
+$objdump -R "$vmlinux" |
+	grep -E '\<R_' |
+	([ "$undef_weak_symbols" ] && grep -F -w -v "$undef_weak_symbols" || cat)
-- 
2.37.2

