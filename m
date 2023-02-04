Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0768AC79
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjBDVIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjBDVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:08:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457FE1206B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 13:08:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso11903649pjj.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 13:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhJdmY9n68T9YoeltiaCGwu97Wb3Uy2dgfeoJGaZ/Mw=;
        b=iDIxotW/7OTSNGcbmxa8+muLWIqnTK8OFg6tZ55lJefql4omSvNQKuaCVZK1eUcqEw
         s0hEgJenBb3BiYKVKLUZXhdmCX2NwRxSWWEltHjY+3yFb/RGciuZ820QNcyRy68kuj5X
         tmhFgKcY1IhIdTV5YSKb4TM6fyUE1Wwlg5ClzVCsmGQZVRVAHDsxVYP6M78jzHRgqt2F
         1V8h2BNLzFXvf6FohlGx3DARceX3lL6UIDy2t2aqpw3Q8crz/5S7Klcsr9kBaJCQaHI5
         WxwVFBpS15MLvCghqYeN1p943QbdL2Ldke5HGC4ITOzjVssWj9STox8IwIi/LE8G34VM
         bJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhJdmY9n68T9YoeltiaCGwu97Wb3Uy2dgfeoJGaZ/Mw=;
        b=IH0KGUFMMeNu/LrIEwXGyaUxFYh+82k1NS8AqV+zHZb9z/Nl/oaEroFcSpWcEk/ahu
         mzxZFMvAhzdZJ2cuH02Bk/VlWC5PV5fx5g6jSvklDgjdm7n52DjDp6lKFEapj1W8e2CY
         YzuVi9FRzj3IAbS5EJ8rNMaCg4M1pdBIzk9pxl6yraD88OBh7tRoNDKSdhSOxXZR/gt1
         /wH3nuG/mzYb96lje7vXz+/jKNbRaHMLfdukqVXOaVfoJMkOSx4bI7bLz/pYZBw40Elc
         le9Qx5XIwBy6gUQ7UMZQUXzJzNKCr4HC2IJ/mgPjuY2h3tQogK2SHvEqkI7yQPfctPer
         bVSA==
X-Gm-Message-State: AO0yUKVuXJ+p3JJROS97Hm+rPbY4p8oxzAVkFor0drVgJh2rxzcxpqs+
        3NfaOaWznIKj2118L6YjfgM=
X-Google-Smtp-Source: AK7set85Er5kJCbOki3tz2FdTvn1h8yA2R/va1K409GbrH0FFIa9tp9PA3khlQH7oi+g5eTHBmyhbA==
X-Received: by 2002:a05:6a20:3c88:b0:bf:7b3a:fd59 with SMTP id b8-20020a056a203c8800b000bf7b3afd59mr15156235pzj.54.1675544895410;
        Sat, 04 Feb 2023 13:08:15 -0800 (PST)
Received: from sc2-hs2-b1628.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090acc0a00b00219186abd7csm3781203pju.16.2023.02.04.13.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 13:08:14 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Date:   Sat,  4 Feb 2023 21:08:07 +0000
Message-Id: <20230204210807.3930-1-namit@vmware.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") broke
kprobes.  Setting a probe-point on 1 byte conditional jump can cause the
kernel to crash, as the branch target is not sign extended.

Fix by using s8 instead of char and use immediate.value instead of
immediate.bytes for consistency.

Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b36f3c367cb2..6a56d56b3817 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -625,7 +625,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 		/* 1 byte conditional jump */
 		p->ainsn.emulate_op = kprobe_emulate_jcc;
 		p->ainsn.jcc.type = opcode & 0xf;
-		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
+		p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
 		break;
 	case 0x0f:
 		opcode = insn->opcode.bytes[1];
-- 
2.34.1

