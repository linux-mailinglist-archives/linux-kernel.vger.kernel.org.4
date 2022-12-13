Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00D764AF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiLMGJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiLMGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:09:21 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D619286
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:09:20 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ep17-20020a17090ae65100b00219702c495cso1339189pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3rYplRUH90lferx/1QrjPQLbygHUDtj5qeJE1KQCTqc=;
        b=EI40B1d/Mbv8m0VRGcWzxsd7VuKCZkwAPkWVNlQv9uYdsZdudkMdcUKtlj3sz3lzDa
         LUEvap9m5gVbRVLArHGjcPy1pJ1T0m1vx5tGFB7nzLVu6AbFptybI8XxoFizChEiw11b
         Xluwh7PxOVZthsV34BGOkV0j7R35fZic+oWBLpklUUJMaeKQh0ePUgTdiBi1QwYG9uQ/
         Y8VI8cc/xhlGHau44SRNm3GSt4rYlXVCNL1nR2HMxr47eALh9q6z3n65fdaXu06LCVWV
         HngCvPGCyXTRA5NAp54D7J80f9dtcUdssrAsbngPyX1B17IdPjhXDZyFtP0PwjqGOjP/
         5dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rYplRUH90lferx/1QrjPQLbygHUDtj5qeJE1KQCTqc=;
        b=hvGRlDqTI6QGpjl01FPxoAWz0h4xA2OiI0eVCFDVWadu/uyajAcBmbiB6eWe8qFX4X
         bDwmG9tPYOzxs+KgOx76uY8VqIhITGwyySGVAik96KU3ZP6Zm+7NxUG/1MUvcSENxm9D
         1y5bFdbrAXWSXAnjNaUC6hz1pfW4ZfjpS5e7v9GMZLVMy0RmWv6idAOhfGnOSzL/UzMB
         0ueUedHNSAWsI7rU+LsM1HUi9PQl4g8QKe4crjmYtTahRlnLPZDHU3bSCokISRYtOl3X
         7d1LqBX5D7SFw0zCTLq0GFnwqkMc0W/LJ6AFWTCg0rvJtDDSy475QVxNkvIp4+KCgd69
         0Sqw==
X-Gm-Message-State: ANoB5pngMIQVTDV/KItmC8iADC4yumxhV6RxKVZP3i1NPgBiZ+Lti8Oz
        sFKwNUDA8bUrKgk1qc8FI+33aFV9zQ0=
X-Google-Smtp-Source: AA0mqf59poWFoBEYN/ZqdGI/4uRVPx0JCk1L8iDLHBT4JiNXVR0fo+3paILjT1aP4fCgo/AxBSkuWshdn50=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1991:0:b0:578:5559:d5a5 with SMTP id
 139-20020a621991000000b005785559d5a5mr501316pfz.74.1670911759951; Mon, 12 Dec
 2022 22:09:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 06:09:07 +0000
In-Reply-To: <20221213060912.654668-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213060912.654668-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213060912.654668-3-seanjc@google.com>
Subject: [PATCH 2/7] KVM: VMX: Allow VM-Fail path of VMREAD helper to be instrumented
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
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

Allow instrumentation in the VM-Fail path of __vmcs_readl() so that the
helper can be used in noinstr functions, e.g. to get the exit reason in
vmx_vcpu_enter_exit() in order to handle NMI VM-Exits in the noinstr
section.  While allowing instrumentation isn't technically safe, KVM has
much bigger problems if VMREAD fails in a noinstr section.

Note, all other VMX instructions also allow instrumentation in their
VM-Fail paths for similar reasons, VMREAD was simply omitted by commit
3ebccdf373c2 ("x86/kvm/vmx: Move guest enter/exit into .noinstr.text")
because VMREAD wasn't used in a noinstr section at the time.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx_ops.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 842dc898c972..5838489e719b 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -100,8 +100,10 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 	return value;
 
 do_fail:
+	instrumentation_begin();
 	WARN_ONCE(1, "kvm: vmread failed: field=%lx\n", field);
 	pr_warn_ratelimited("kvm: vmread failed: field=%lx\n", field);
+	instrumentation_end();
 	return 0;
 
 do_exception:
-- 
2.39.0.rc1.256.g54fd8350bd-goog

