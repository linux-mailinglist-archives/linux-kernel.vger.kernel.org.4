Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7867C68E8D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBHHRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBHHRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:17:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BC23250B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:17:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id mi9so17513816pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mF+edaz35nB9S8Qt/XzsoPGtfNqnG8Rw26Jya4WGTVw=;
        b=Pt5UYwpikls4pV7FLVu2oPYN/hjz6XYT1juyXYYbOjrqylWVxL2vAmGmImAJ4xCi+4
         GQvgjuA+FEKtFFm8SaIYM16ubfkle4gIWsTMcmJZr6jdJGhcDrwgLs7rGvp8KVH/bUnN
         g+8d2rL514EM/rJrTgYTnOuTVVaheiykA6WlTgk217/Ayy5x5Qylf0cgvvYLa4YAehmg
         EGoUMh7YMxqJ+bt4FY/3vrFtaLom/fsG752ID1izVhrMDExGqQSLlZe5UFXE5p3Ongbr
         eZrUN5FK4FUZFrWXkZwdRJy1EBL3flVJTBzKAbL8QdKRXaw+/oUQ+KE0lve04+qgu5hc
         CvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mF+edaz35nB9S8Qt/XzsoPGtfNqnG8Rw26Jya4WGTVw=;
        b=QliODhQAPm0+tZQ2cPpkiAn8GruqJ85uC6jopkjOOkmNAATJlzly9AlhPdgHLH9Ahc
         3O556NrlH54xCscRUGqynfChM/Irivh64fL3fG6YXeJrxZesh01YwzJW/Vj4ktF+nWE3
         qykPTI8/P4rbOi5Uab1ScepraInkFGFUmEDXJ3SIECF1wkH7ogC+y14ldRzkir2+JCNj
         1CmH7Zr6y0riOuQctB0Ajeje3nJp2N7MxnBOm7TULk6Zb7PbPtvSxnV0jy8QSw9N2xM1
         c7ZRT39+GGg7Y58tS12eU7VSakNkc+IHyobB5zMM2VGEmadnLO/5udedqwUxGCJ1+N98
         0fGg==
X-Gm-Message-State: AO0yUKVJRDfsdQskjsFHMP4gagoT1fZUgADSWaf68DJ5AZ/vnlWF4/k1
        LWpPD2g/zsIWHeVKZD9sNgo=
X-Google-Smtp-Source: AK7set+gfFuKNLyRiHbADT5EwRuHJqdvHSIPniKzCo/rquS6Ww84kCX6iJhbS8RCeKOihvq+fU/kIw==
X-Received: by 2002:a17:902:d2cf:b0:195:e590:c7c6 with SMTP id n15-20020a170902d2cf00b00195e590c7c6mr6164501plc.22.1675840631484;
        Tue, 07 Feb 2023 23:17:11 -0800 (PST)
Received: from sc2-hs2-b1628.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902ead400b0017a032d7ae4sm7507831pld.104.2023.02.07.23.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 23:17:10 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] x86/kprobes: Fix 1 byte conditional jump target
Date:   Wed,  8 Feb 2023 07:17:08 +0000
Message-Id: <20230208071708.4048-1-namit@vmware.com>
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
kernel to crash, as the branch target is not sign-extended and instead
zero-extended.

In fact, there is no need for any casting of immediate.value since sign
extension is already done during its decoding in insn_get_immediate().

Fix by removing the casting of the 1 byte conditional jump target.
Future patches can also remove the casting (and sign extension) in other
cases in which immediate.value is being used.

Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>

---

v1->v2: Removing the casting completely [Dave]
---
 arch/x86/kernel/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b36f3c367cb2..695873c0f50b 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -625,7 +625,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 		/* 1 byte conditional jump */
 		p->ainsn.emulate_op = kprobe_emulate_jcc;
 		p->ainsn.jcc.type = opcode & 0xf;
-		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
+		p->ainsn.rel32 = insn->immediate.value;
 		break;
 	case 0x0f:
 		opcode = insn->opcode.bytes[1];
-- 
2.34.1

