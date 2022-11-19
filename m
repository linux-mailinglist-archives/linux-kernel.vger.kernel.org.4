Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD3663087A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiKSBdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiKSBdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:33:20 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E415BB13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:37:49 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x11-20020a056a000bcb00b0056c6ec11eefso3954382pfu.14
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXGFKO/EkpuIeqVDphBNVjuhQ/zqYCH5ABXNmG1D7zQ=;
        b=jsKeef8KYLqC5oBCrTT2cPmdPYbyBgcZWYsC8Tjtf9Vil5QubiQoihVm/PBx+ruzR7
         QwVuNwUGHTkeKsiG+Y4hkOmRTHJhzK4jISwRnOysFoWcOXeZD6153GkTo7VLDkCiMD9z
         g5U6Wutc69WUe05MvhbcYon/90cX1HO3xxkeekLBjZGqQGebpI504/Bn/FoJ3yZYXW9T
         3xjkz1beKaeYcXWSA/WEefdEz8zxDl0hPPOKYqmeyjmFAfm3KKRMf99QFtdFf42zN6lO
         MeOvWsHHpba+S0EV+zIvejO3/mBh2Cb6j2LFa/N0bHha6nt1Hbomi+0KlVrK+it73JvX
         3GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXGFKO/EkpuIeqVDphBNVjuhQ/zqYCH5ABXNmG1D7zQ=;
        b=njxaeKPfgQY5EIbNmT6WTBfTOrVTCgNn4lnxintBTHeGRvciZLKrL72Utp5IHDpvcV
         oyZKN2dXVpR4uIseAT8VnqrU1DVx5T4mAo2DlrlgL3kHJgmDfUtu2xrXZwBF7iwe2+Z8
         AW8YG3D2QjZxx0hlZjBTnRUTuJmyneU9IYe2DYQbD+zJYCUZup1FsUh7heqKcAmx+SnC
         FI+Z6UNmmgyxqhmlo52tVDRCkUH6jTAJaAEatisIbXbWslOlvYgbgGJIJVO/i5MONbkQ
         mvrE56ECWbgL20WY2k+mmYaCYS4/rMcsng/1fFCNJt8Ot7MUhp8TtmVfV3Sg4DVe2+o7
         08lQ==
X-Gm-Message-State: ANoB5pnU3rZ8pbXhi4/fPIKDI2aVPXzy4QBRrUMrPUFvngCmjZQo1R+d
        vAi836R7ENsl7YLLkRgBJgYmgomoPjs=
X-Google-Smtp-Source: AA0mqf7IxIMf2B9LDq5ip8bGacxM5fpViFwU5IxlL6NRcOx+wOegVERvKTCXqg6eFFjl9iFqS9H3NsVVqx8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1cd4:0:b0:56b:deea:72e9 with SMTP id
 c203-20020a621cd4000000b0056bdeea72e9mr10102088pfc.47.1668818269339; Fri, 18
 Nov 2022 16:37:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 19 Nov 2022 00:37:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221119003747.2615229-1-seanjc@google.com>
Subject: [PATCH] KVM: VMX: Access @flags as a 32-bit value in __vmx_vcpu_run()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access @flags using 32-bit operands when saving and testing @flags for
VMX_RUN_VMRESUME, as using 8-bit operands is unnecessarily fragile due
to relying on VMX_RUN_VMRESUME being in bits 0-7.  The behavior of
treating @flags a single byte is a holdover from when the param was
"bool launched", i.e. is not deliberate.

Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmenter.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 0b5db4de4d09..5bd39f63497d 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -69,8 +69,8 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	 */
 	push %_ASM_ARG2
 
-	/* Copy @flags to BL, _ASM_ARG3 is volatile. */
-	mov %_ASM_ARG3B, %bl
+	/* Copy @flags to EBX, _ASM_ARG3 is volatile. */
+	mov %_ASM_ARG3L, %ebx
 
 	lea (%_ASM_SP), %_ASM_ARG2
 	call vmx_update_host_rsp
@@ -106,7 +106,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	mov (%_ASM_SP), %_ASM_AX
 
 	/* Check if vmlaunch or vmresume is needed */
-	testb $VMX_RUN_VMRESUME, %bl
+	test $VMX_RUN_VMRESUME, %ebx
 
 	/* Load guest registers.  Don't clobber flags. */
 	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
@@ -128,7 +128,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Load guest RAX.  This kills the @regs pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
-	/* Check EFLAGS.ZF from 'testb' above */
+	/* Check EFLAGS.ZF from 'test VMX_RUN_VMRESUME' above */
 	jz .Lvmlaunch
 
 	/*

base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 
2.38.1.584.g0f3c55d4c2-goog

