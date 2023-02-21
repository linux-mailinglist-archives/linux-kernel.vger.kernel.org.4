Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5D069E4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjBUQhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjBUQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:31 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BFF2D155
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:27 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 62-20020a630241000000b004fb3343142dso1858593pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CiebZgZnEDP7VZY8GkyG9xLC+cq7WThHzeBIf6OXg2A=;
        b=jI478qIYl8eqgu3YXohpyPzECLUUXvFMIS+VtaoksIUpieQMTxJ7WVrtEPqL+SXA0R
         n28bqlflqmoXPFVylk4UPj+PnFocuOpDYwOtbN+ASUgjwpYRRNR2PSIXIPF+DeWz3u7z
         PMn0moezB10GhriN8s1FUiVpp7moukJ6tw4qNt7CAz6pIp14n1ede97Hv7AhAXg0pfUp
         6PvZOczLkRMN/XtBVpaoISkiKB4Nr0O60ZWjqMcRvOp+cZr+Fj3L6/Uor8Yb4dffGETM
         ddhL5c7x1xz6hJUr65iOEmQwwBEdtlV0+89js8ai8btv7XH3iLXu6C+4e5Nvays9rPTD
         WZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiebZgZnEDP7VZY8GkyG9xLC+cq7WThHzeBIf6OXg2A=;
        b=O4uVoUjWYYrCVkzvih7C9sWxP2G/qrOMLYjwbkaP0zU5DsaMPbPlBj8tSzoLop5XEH
         mpQQszLYOnAW7bPOuvhebaKOBUkQyID65cbyK6z15NVEim9encxVi/hzoWDDNnI8sqVl
         SiLPp2juqhfMvTl5Eeu7C1PM0Nb5YyqSi9jz7hv/OCDTVIP9NL+IglYzJpQwE82zzQtJ
         NJOrWED0x158EuzazMto+1R4boULZFL9fDz8E9SoTfz/UHlsqz8umKHS+fQ1y2cG3u8q
         0Xl5WHbKPOwK7Japh1TWrNWzb4xRbJ4S2VhY9ll4HjUJWssL2gWZBuLbr0bNEMftG+MA
         vvUA==
X-Gm-Message-State: AO0yUKVItbUBmK1aeAQFrii8q5xL8G5neyAVd2+KNlBt234nPNgpq1FQ
        fyFweU2dZdZI2ppcwZwBtWuKZ0gOAzzw
X-Google-Smtp-Source: AK7set/sjoRS/b8w2JVAxhnoQhQkHhjBNHss1dBGUzpg589CiqV6m1WV9H0wP2jbnxhKownzwWVPetSndLEN
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:902:f783:b0:199:1eba:e0ef with SMTP id
 q3-20020a170902f78300b001991ebae0efmr710853pln.4.1676997447502; Tue, 21 Feb
 2023 08:37:27 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:48 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-7-mizhang@google.com>
Subject: [PATCH v3 06/13] KVM: selftests: x86: Add the XFD check to IA32_XFD
 in #NM handler
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an extra check to IA32_XFD to ensure the behavior is consistent with
the AMX archtecture. In addition, repeat the checks across context switch
to ensure the values of IA32_XFD and IA32_XFD_ERR are well preserved.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index ac49b14460b6..296c954dfd6d 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -218,8 +218,10 @@ void guest_nm_handler(struct ex_regs *regs)
 	GUEST_SYNC(7);
 	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);
 	GUEST_SYNC(8);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);
 	/* Clear xfd_err */
 	wrmsr(MSR_IA32_XFD_ERR, 0);
 	/* xfd=0, enable amx */
-- 
2.39.2.637.g21b0678d19-goog

