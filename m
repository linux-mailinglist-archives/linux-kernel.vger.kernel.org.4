Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BDB7012BB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbjELXwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbjELXva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:51:30 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5760AD3F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-25017576284so5358959a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935450; x=1686527450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LxDcS09oj97Wx6mpqCitfgO/wEihL/zs3WwclzJXVrs=;
        b=3UXj1nizRj4oLlTnGsYo1jkyfL9mkU7aP/AxzLjzcVWd8MZkQxCNMnS23/8RJLUodw
         ok0SC36DquJdKQxN0hVH2pSrfB/YpQoZ+CuGE0RKez4/PELDoIiFFBzGqSy72J+ABaaq
         GWVTkuyWWe6Tawuv1GiXVa+yG8hjXRwVLP72B8xy5qR/7Hdii+1lAGNeR5AzErGSj8m9
         gwg8AQX2Ds6B/Uah4Wo0jc/YRzmzCj0Cnbuf2MQ8taXsF9E035Mhg+npjUwXrmSfYxXv
         Diw7E7tGb2lO1KIw4MRr1dv/yBVPkPcpcpc06jetvGRD/CVzjuA/1axT0GN8S+Tn5KGZ
         rGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935450; x=1686527450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxDcS09oj97Wx6mpqCitfgO/wEihL/zs3WwclzJXVrs=;
        b=XMQt9YVm50ebgQ7FMzr9FYLlZgaJn2gdbJqRmodwi0YEgV/Frw1Ar9lywiYcyG0q85
         E4g9+fjRBKje5PH7PDE1lHDdz+TIVb4+5h1rWngBVvSe/QrVdPdeNZBIrLmFastsw9+i
         MXVz+/eQ1HHrEZ0+QfhgK8ubFHr/x7iQ1tfCFQHBv0jUGfuMO+UotyG/R1l5zh/Dyas8
         PaLVl7T19fN7YMp97uEt7KHQ9fPKNq2t8aF9qNqITVn51YSs51VfPln8733rkrrT7pb4
         yHO0pAACQEWcGrsrspNBTegBaLqdq+RIZJmLTILALLX8MWtfimrLYAITFNrX0g8Xs5T1
         koMA==
X-Gm-Message-State: AC+VfDwU5S4CZIX+/uabBpGnUfz0ce9EZg9/sSTnlkqRFK3HoB+pbnNQ
        5JgkciLbgvvctb0uKGzQOb+eROHhIhY=
X-Google-Smtp-Source: ACHHUZ48zczwBDKdvB3sWp2+ob+YdKHROmTh6zcvA3LCitTa2KUmje9WaICS5+vDj+EmmtaYbGyho3TFxQ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:482:b0:244:9147:ee20 with SMTP id
 bh2-20020a17090b048200b002449147ee20mr8107720pjb.0.1683935450341; Fri, 12 May
 2023 16:50:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:19 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-12-seanjc@google.com>
Subject: [PATCH v3 11/18] KVM: SVM: Make KVM_AMD depend on CPU_SUP_AMD or CPU_SUP_HYGON
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

Make building KVM SVM support depend on support for AMD or Hygon.  KVM
already effectively restricts SVM support to AMD and Hygon by virtue of
the vendor string checks in cpu_has_svm(), and KVM VMX supports depends
on one of its three known vendors (Intel, Centaur, or Zhaoxin).

Add the CPU_SUP_HYGON clause even though CPU_SUP_HYGON selects CPU_SUP_AMD
to document that KVM SVM support isn't just for AMD CPUs, and to prevent
breakage should Hygon support ever become a standalone thing.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 8e578311ca9d..0d403e9b6a47 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -102,7 +102,7 @@ config X86_SGX_KVM
 
 config KVM_AMD
 	tristate "KVM for AMD processors support"
-	depends on KVM
+	depends on KVM && (CPU_SUP_AMD || CPU_SUP_HYGON)
 	help
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
-- 
2.40.1.606.ga4b1b128d6-goog

