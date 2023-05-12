Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4351A7012AC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbjELXu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbjELXus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:50:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E935A6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba71ed074ceso5953360276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935439; x=1686527439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qe0nkbWmCyKJWkQTDDVLIYD5KqVMDGWynhMHlJu7zeU=;
        b=kuAgRvu3zYo75pMBLrsRWnCeJ6ZWtulbQUnM7oeEwamoK+Zc5KgVon4oD78DPBbWJ/
         paP5o3BlKZZai9QliuryvolqTkGnu7dwmvN5aXHU3vA0cBm836XGpDkcL6uzXYYSKsFE
         It71ivzWEZpyzTW73EHv5HbVEhM12XFcE6/pv4EugGd2+YoD4xnLzrjMAgYuXFTUuMsF
         lLfsSpC7gfP9BS+ss0xjTpZ9LEvne+rjriNsbVTIewGLvyChSUM7vy6aSV0AJnC/aFov
         qqUnJMNuqephjTPbZtNpuyzV2BJKXtsnUedsBl5q1DlogroDOv5wa4Xp09Eo2ab1Uzln
         WbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935439; x=1686527439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qe0nkbWmCyKJWkQTDDVLIYD5KqVMDGWynhMHlJu7zeU=;
        b=BthjzqUdnjBTsbCg7cqRhRyQTMcqY+L+b4uk2jqUrDtPkt4mgQsLJBur5cCA3o3cuL
         ic9LGFrkjHnqUCoUelduZYBuQrxRsNomQIvKaMnEvTZWVQKBnR1PjADMY9Ud/NRsliyh
         PNFIPAAFdyVIj+L6JmSOF75vg1M3NG6PegOOhh8VVSxluxjENRu6DXCHxWHr1cHfVU6n
         1mOflE3LUzfDStmxzs0UBFY8nC3Q8SbdMVwxMo80ml59JdCciIMVlBVswbgBeWg16Vas
         fb7vYopJWoVKe5qaeImSRYyY8bOB8XAsyfYOVkF3sk9IUyQjEWJ8SsJk6BSgg+5GbBEv
         YUow==
X-Gm-Message-State: AC+VfDzVZSrnTgwoTAZmp69GF6elYD6wWlyk4qplXNiD/5QRb1QYGrIC
        mYwhnL8qjc/t0wFinZQo925LHOi2NJM=
X-Google-Smtp-Source: ACHHUZ6MgC4/o0S6diyWnfqcy1rtJCbXK7+pyhMdZw0rPyM78v2GBCE10SqJ/Z4EPnuBcnGBn9PVTM/I59c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:78ce:0:b0:55d:9e7c:72c0 with SMTP id
 t197-20020a8178ce000000b0055d9e7c72c0mr17732359ywc.0.1683935439368; Fri, 12
 May 2023 16:50:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:13 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-6-seanjc@google.com>
Subject: [PATCH v3 05/18] x86/reboot: Disable virtualization during reboot iff
 callback is registered
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to disable virtualization during an emergency reboot if and only
if there is a registered virt callback, i.e. iff a hypervisor (KVM) is
active.  If there's no active hypervisor, then the CPU can't be operating
with VMX or SVM enabled (barring an egregious bug).

Note, IRQs are disabled, which prevents KVM from coming along and enabling
virtualization after the fact.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 92b380e199a3..20f7bdabc52e 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -22,7 +22,6 @@
 #include <asm/reboot_fixups.h>
 #include <asm/reboot.h>
 #include <asm/pci_x86.h>
-#include <asm/virtext.h>
 #include <asm/cpu.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
@@ -545,7 +544,7 @@ static void emergency_reboot_disable_virtualization(void)
 	 * Do the NMI shootdown even if virtualization is off on _this_ CPU, as
 	 * other CPUs may have virtualization enabled.
 	 */
-	if (cpu_has_vmx() || cpu_has_svm(NULL)) {
+	if (rcu_access_pointer(cpu_emergency_virt_callback)) {
 		/* Safely force _this_ CPU out of VMX/SVM operation. */
 		cpu_emergency_disable_virtualization();
 
-- 
2.40.1.606.ga4b1b128d6-goog

