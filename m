Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDF692FA0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBKI72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:59:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEF639BBC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:59:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id sa10so21192130ejc.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnf/AZ9GP2RhL+LEsB6MvZxI/zvPo/2+atKP7xm+gf4=;
        b=CoSPmSMhx6xUdomaudYbJwR0WldT8r72G3Dp3bYc0NrabFHS1CNz/6m/2fMRik7fIi
         gx0bMukoH5x3CUZCVf2Na66H5pqc3VDj4PCfHmDObxQyDHlHoBvWw7/WoJ1SM8URW/lE
         h7fYgcejI3lfLVVyvTrAh+XhaIZX/VVaRuiHorP145x52GjQKbMJi2OHps8ohsgHNuup
         lAy5WSG54AcNNT1KF/j+6ucQZGCVgH9GYQYmQe4ue+kBR0rsUZChk0EoNPf9pMWU9jWD
         HSOdaaOQP7WACd+GHIRFrGye8OeQAxqEsnDjQ0NjPBTewM3aItogEPznjZxviJaoCz87
         CeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wnf/AZ9GP2RhL+LEsB6MvZxI/zvPo/2+atKP7xm+gf4=;
        b=4yUvMF4OsGUuV1MIVas+NomAJJ5QMbz7Zc2DT4a8ayj4IngVOHZBfUxzDFp3ohiRSW
         COzI7tqSBYvbuo3m0rDgBJrT4+t30fFE83/7Yx7i7s4B9P+qZp2V5OCwDnNhc0kPpOTS
         O5k+WnhdLNR6VTnit57QtvauEici7r2twoR9ZXTccv4xaZXBMpuj7BtYysTw49/2XiWL
         gufhgRGK262XhK1WcEx//ny2UTy6XW5Jy066okqiHmIfgh0FjkIRBevsAXcruM4hUUsZ
         4gVmcBfp8UxJSXyoHCj3CRMHHNOfzxydnhknPSIMWwbKEOMaj98E8ZDVDSZT3OG+Wr64
         N7KA==
X-Gm-Message-State: AO0yUKU2rv0orb5tTAMPJbKjbCHpHnF9dNwxvJqSlD3RCd9YpJvqH0ui
        SREpbSXDNf433aXwhRnVQ9U=
X-Google-Smtp-Source: AK7set+vHUjgIVR1MdD/iEktCR/BkvMGt6Tye3pqZWRnhQ+IorxnmLLgto8soMyVavMyTsa65xEm3w==
X-Received: by 2002:a17:906:1e8c:b0:878:52cd:9006 with SMTP id e12-20020a1709061e8c00b0087852cd9006mr17235337ejj.69.1676105962888;
        Sat, 11 Feb 2023 00:59:22 -0800 (PST)
Received: from gmail.com (1F2EF6B7.nat.pool.telekom.hu. [31.46.246.183])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906474400b008aac143d9afsm3589933ejs.58.2023.02.11.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 00:59:22 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 11 Feb 2023 09:59:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86 fixes
Message-ID: <Y+dY6DLyJsOMyf87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-02-11

   # HEAD: f545e8831e70065e127f903fc7aca09aa50422c7 x86/cpu: Add Lunar Lake M

Fix a kprobes bug, plus add a new Intel model number to the
upstream <asm/intel-family.h> header for drivers to use.

 Thanks,

	Ingo

------------------>
Kan Liang (1):
      x86/cpu: Add Lunar Lake M

Nadav Amit (1):
      x86/kprobes: Fix 1 byte conditional jump target


 arch/x86/include/asm/intel-family.h | 2 ++
 arch/x86/kernel/kprobes/core.c      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 347707d459c6..cbaf174d8efd 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -123,6 +123,8 @@
 #define INTEL_FAM6_METEORLAKE		0xAC
 #define INTEL_FAM6_METEORLAKE_L		0xAA
 
+#define INTEL_FAM6_LUNARLAKE_M		0xBD
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
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
