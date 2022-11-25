Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1D63826F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiKYCeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiKYCd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:33:57 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A1201A6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:33:56 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so1457364pjd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3tX8c48SkCwp4614P1MZhKByQyd6IaaDpUY4QZpiCs=;
        b=K8mWPNqL2s5XUfZHJTMpQCvAD2CWcuE/ue2pBfeMUMxUdsOS8Uvh/liwOaUFUoWlu+
         JfeEmpmuzkjipWPfzWH9UOJkvl+ccxupfhUIw3+ucLZyu4T1Pd5YiuFvU94+SBuLfrUP
         /yZY0nj8RaY9lS24bnFN5RFJropy5/eHJ1Ur4fi0hytRRWJO+SfBMvBDYlR8ABU/ZSuh
         PqcKUjBX96UMIjvrKy/NfoZyHfgw+R5/LSko+Bn0SKn0EN0B0ccEyLvDmcou1LKXyVfT
         4/FYkZM7DVtPWZ+IJojx+TvwB83xC4DpFsp8qOq42pl2eEJe0bCSg6F5dSfmcQdHTxML
         RbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3tX8c48SkCwp4614P1MZhKByQyd6IaaDpUY4QZpiCs=;
        b=8H6yealCHJQTOovjHtbxKBXUW6SZZR4J2PEzm7wJ+hyHLI3iOSp22kGwQ19U+z2BwI
         9RTkI/o64gTpmyaKdVPVaQi+5TqVwi9NU7wXi4/gGoMnRpuDwZGFDOSy6ze3RcFlpX3s
         AGijuMgOv6R2M85pACDdPHV+Z/lkoua6O+V11vyuXJGd0BavowxLrs9jMUXc8BRalzNg
         x8ZQinZ0n+Kanr5mlUMlRftxWVIUGWSxo6rCxcTb9UtJK5Gd0zmJLmj/iNl5sF1hJej2
         c7R9W+hg7o+OktjAgue/Lz45SnT2SMPLmfs0pg5W9mOfQCFD77ZY15UNGXZ7XuoGW7Ug
         GXWg==
X-Gm-Message-State: ANoB5pmNde/6aXRap8oFUaaZ+WWs1xqUB1tPw0GCx5hqhNU/ufVE6o9I
        NqHFAjQyiZxRJOZGwBsAUuA=
X-Google-Smtp-Source: AA0mqf5e7DUEU3j8h8l+QvwtCqp7FENf0a5yblGhOl7nnKz7Z4bsnMDA7OJaD6/f6EJYUyRh4Lpiig==
X-Received: by 2002:a17:902:cec8:b0:189:2b93:3f9f with SMTP id d8-20020a170902cec800b001892b933f9fmr17825231plg.109.1669343635994;
        Thu, 24 Nov 2022 18:33:55 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m127-20020a625885000000b0056bc5ad4862sm1893822pfb.28.2022.11.24.18.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 18:33:55 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 1/2] x86/asm/bitops: Replace __fls() by its generic builtin implementation
Date:   Fri, 25 Nov 2022 11:33:29 +0900
Message-Id: <20221125023330.195581-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221125023330.195581-1-mailhol.vincent@wanadoo.fr>
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
 <20221125023330.195581-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below snippet:

  #include <linux/bitops.h>

  unsigned int foo(unsigned long word)
  {
  	return __fls(word);
  }

produces this on GCC 12.1.0:

  0000000000000000 <foo>:
     0:	f3 0f 1e fa          	endbr64
     4:	e8 00 00 00 00       	call   9 <foo+0x9>
     9:	53                   	push   %rbx
     a:	48 89 fb             	mov    %rdi,%rbx
     d:	e8 00 00 00 00       	call   12 <foo+0x12>
    12:	48 0f bd c3          	bsr    %rbx,%rax
    16:	5b                   	pop    %rbx
    17:	31 ff                	xor    %edi,%edi
    19:	e9 00 00 00 00       	jmp    1e <foo+0x1e>

and that on clang 14.0.6:

  0000000000000000 <foo>:
     0:	f3 0f 1e fa          	endbr64
     4:	e8 00 00 00 00       	call   9 <foo+0x9>
     9:	53                   	push   %rbx
     a:	50                   	push   %rax
     b:	48 89 fb             	mov    %rdi,%rbx
     e:	e8 00 00 00 00       	call   13 <foo+0x13>
    13:	48 89 1c 24          	mov    %rbx,(%rsp)
    17:	48 0f bd 04 24       	bsr    (%rsp),%rax
    1c:	48 83 c4 08          	add    $0x8,%rsp
    20:	5b                   	pop    %rbx
    21:	c3                   	ret

The implementation from <asm-generic/bitops/builtin-__fls.h> [1]
produces the exact same code on GCC and below code on clang:

  0000000000000000 <foo>:
     0:	f3 0f 1e fa          	endbr64
     4:	e8 00 00 00 00       	call   9 <foo+0x9>
     9:	53                   	push   %rbx
     a:	48 89 fb             	mov    %rdi,%rbx
     d:	e8 00 00 00 00       	call   12 <foo+0x12>
    12:	48 0f bd c3          	bsr    %rbx,%rax
    16:	5b                   	pop    %rbx
    17:	c3                   	ret

The builtin implementation is better for two reasons:

  1/ it saves two instructions on clang (a push and a stack pointer
     decrement).

  2/ when used on constant expressions, the compiler is only able to
     fold the builtin version (c.f. [2]).

For those two reasons, replace the assembly implementation by its
builtin counterpart.

[1] https://elixir.bootlin.com/linux/v6.0/source/include/asm-generic/bitops/builtin-__fls.h
[2] commit 146034fed6ee ("x86/asm/bitops: Use __builtin_ffs() to evaluate constant expressions")

CC: Borislav Petkov <bp@suse.de>
CC: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/bitops.h | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 2edf68475fec..a31453d7686d 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -285,19 +285,7 @@ static __always_inline unsigned long variable_ffz(unsigned long word)
 	 (unsigned long)__builtin_ctzl(~word) :	\
 	 variable_ffz(word))
 
-/*
- * __fls: find last set bit in word
- * @word: The word to search
- *
- * Undefined if no set bit exists, so code should check against 0 first.
- */
-static __always_inline unsigned long __fls(unsigned long word)
-{
-	asm("bsr %1,%0"
-	    : "=r" (word)
-	    : "rm" (word));
-	return word;
-}
+#include <asm-generic/bitops/builtin-__fls.h>
 
 #undef ADDR
 
-- 
2.37.4

