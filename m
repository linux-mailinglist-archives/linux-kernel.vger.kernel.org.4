Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1329F74E728
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGKGWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGKGWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:22:39 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEBEE51
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:22:38 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-1b3ca17f2a6so4368769fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689056557; x=1691648557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAOhq9P07eLDplhtLTT1tcsIlFj5k7H1L3tXJlOgLCo=;
        b=d/u6KhCWa+HbTlst+lD44hjx/uPE6mkYk8t/U1cgZQ+rG8uR0vspAyOXTJytNDgvLu
         MKkpktIPWohmTYwzXkUYnCPq9FhZePT1kmmrcT2gnKLqlv2V9Xq92sAeI2OaW38wT/BT
         qCCcNEiv9xmMr8ANRmAwl8Li/Eqd/xvnolI9r64CY2cF9Rtsnc2zu7mE/7MvlMnXnz5J
         CMLUKgQJ/0H0z/OeOj3P9EEDixuEf/yupESXVfYvVJ1AXgTb+pqRAAvLjQNlEHplPnZa
         g3pPbSzasjHeQW1LmR/V2+J4sbYSnJW0+riWcIurE0vuIx8JLtXgYbkbRQNuoeGx8wDy
         B5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689056557; x=1691648557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAOhq9P07eLDplhtLTT1tcsIlFj5k7H1L3tXJlOgLCo=;
        b=MVhe7EPNp+U+xKOUfYRCmDtpvoauw5fUusxmKyeukovcJY18RxhlGQkusm0aVKazYS
         jWz3q2bEwxdT66f2l/Nco3Bjv1kPNiGz7tc1sBrchhuTi2h5Xll2nocBeJoo0ARwCY0j
         NK7L3LZ5xaPlAikFcojBFvyEA2gZrNOg7m5XNmnptCwY1nl8jxjVD+LznQ9mZ8d69h/p
         Jtmp4LcgAalAcF0kGXkYXiUfVSzG0+OHEEY3qp43OvEOTKXa3P4oxKywNxCN1s3SvCPW
         o6d/Uemh8QOa42YCXXbRZ+TM8nwhxiwDCMBl291kgJKSQJTZDN7sJYJWXXMrp7Y0we5U
         jCdQ==
X-Gm-Message-State: ABy/qLZXjLtbEFTsRBeKr1qJBD+QeMPQf8aBLpOcXyNI7xjFoiFJtERv
        g93Ak8i6LTW0kr2RCETcXIY=
X-Google-Smtp-Source: APBJJlFhEu3/+l2Bh3HqICI1LhF877BOhGd5qBNEfGuzvLWsezxC7hd4093W8ajADVsZYNQII5ZQ7w==
X-Received: by 2002:a05:6870:b48e:b0:1aa:f3:5b3b with SMTP id y14-20020a056870b48e00b001aa00f35b3bmr16428956oap.17.1689056557536;
        Mon, 10 Jul 2023 23:22:37 -0700 (PDT)
Received: from localhost ([212.107.28.55])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090ae50300b0025edb720cc1sm968558pjy.22.2023.07.10.23.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 23:22:37 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Celeste Liu <CoelacanthusHex@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: [PATCH] riscv: entry: set a0 prior to syscall_handler
Date:   Tue, 11 Jul 2023 14:21:47 +0800
Message-ID: <20230711062202.3542367-1-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we test seccomp with 6.4 kernel, we found errno has wrong value.
If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
get ENOSYS. We got same result with 9c2598d43510 ("riscv: entry: Save a0
prior syscall_enter_from_user_mode()").

Compared with x86 and loongarch's implementation of this part of the
function, we think that regs->a0 = -ENOSYS should be advanced before
syscall_handler to fix this problem. We have written the following patch,
which can fix this problem after testing. But we don't know enough about
this part of the code to explain the root cause. Hope someone can find
a reasonable explanation. And we'd like to reword this commit message
according to the explanation in v2

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Reported-by: Felix Yan <felixonmars@archlinux.org>
Co-developed-by: Ruizhe Pan <c141028@gmail.com>
Signed-off-by: Ruizhe Pan <c141028@gmail.com>
Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
Tested-by: Felix Yan <felixonmars@archlinux.org>
---
 arch/riscv/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d2..ccadb5ffd063c 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -301,6 +301,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
+		regs->a0 = -ENOSYS;
 
 		riscv_v_vstate_discard(regs);
 
@@ -308,8 +309,6 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		if (syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
-		else
-			regs->a0 = -ENOSYS;
 
 		syscall_exit_to_user_mode(regs);
 	} else {
-- 
2.41.0

