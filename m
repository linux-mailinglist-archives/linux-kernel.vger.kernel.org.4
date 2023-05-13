Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1611570130D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbjEMAgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbjEMAgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:36:09 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE864EFE
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:08 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643a9203dc2so5890873b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683938167; x=1686530167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=imcOaGkZAhtv0KvByjHYg/L+5O3EycYmRlnN5iZFB4Y=;
        b=U5+Q5AXJHkAU35wpnGLBPjphoKZTaHkEJDuj5UMIwyqKaq6mJuEU/6neP+0/SWCsb5
         NFesLARPQGcYZENv7TNTcjy4a5Rawvaq1zSQzjqS85yJCnvRPjQNxUoYKjrUwmWdAwRl
         ferixHNQ08N4q/G3XE/ZSOUCDOrmMzXMiJzZDM+uJRNzJMQEjPTlaPWvDzhYvfXzI/FM
         YtLSzbNzKOyKXXtQuh/Ucl+SagOra0HjqcetFJbXHnwTDK4FzH1iQX/RH1iIvX2IqiM+
         9ggCnY4bYnmh0gVz5Qa+0Nmsu8298HQZMepAoUQTXTaxZ/VoMcpUt+FH6CaI+e7WDf7O
         4tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683938167; x=1686530167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imcOaGkZAhtv0KvByjHYg/L+5O3EycYmRlnN5iZFB4Y=;
        b=XNkBMYTZcn7jBeUrfWnqZJmZVwgSKORM8VVasNgAjGWkW0/Y9oFwoFHTRVDEgmdsW6
         iiXw6LkN/EsPN0m2dKxPB7WfTsZNp3E9/H9cG0JkOP+qbzUW45FCTF+NGZ3yKsPQt/fe
         WzLR4XghsWOh3zqtgXHUvK/NsCzmx2YsqWowkFK4GZVAtRaU0JX7Q52y8HShx6vc1tK9
         d7Vl/tUMUz70+9ccIjp1Z9Grawv3p3a7VmVM8Hf2IQlb6fqN4R+s2ZZNiY5EOQaC0hpa
         zY6WdUyvA0zeTWOHjHABlrCd/gwTtTVecsB667VkpLfCwWwdogGXMQOI6ZklgrY0SzLJ
         CbcA==
X-Gm-Message-State: AC+VfDxDTAm901SDiy/HavulE0QLLfFDQPcX2ISOiquP3SreQ4WaAUj3
        +ro14UIkzF7FT6pDX53oznXxIB97vlY=
X-Google-Smtp-Source: ACHHUZ4ATdqjI09a0zYXv4vbgfOF3+JF1scamk8//exztPkDhizmSIJXd2nKwBguV5wWxX5iDi6+9Cdy+VM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:d5a:b0:643:536b:e764 with SMTP id
 n26-20020a056a000d5a00b00643536be764mr7181559pfv.4.1683938167743; Fri, 12 May
 2023 17:36:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 17:35:33 -0700
In-Reply-To: <20230513003600.818142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230513003600.818142-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230513003600.818142-2-seanjc@google.com>
Subject: [PATCH v3 01/28] drm/i915/gvt: Verify pfn is "valid" before
 dereferencing "struct page"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     kvm@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the pfn found by gfn_to_pfn() is actually backed by "struct
page" memory prior to retrieving and dereferencing the page.  KVM
supports backing guest memory with VM_PFNMAP, VM_IO, etc., and so
there is no guarantee the pfn returned by gfn_to_pfn() has an associated
"struct page".

Fixes: b901b252b6cf ("drm/i915/gvt: Add 2M huge gtt support")
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 4ec85308379a..58b9b316ae46 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1183,6 +1183,10 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	pfn = gfn_to_pfn(vgpu->vfio_device.kvm, ops->get_pfn(entry));
 	if (is_error_noslot_pfn(pfn))
 		return -EINVAL;
+
+	if (!pfn_valid(pfn))
+		return -EINVAL;
+
 	return PageTransHuge(pfn_to_page(pfn));
 }
 
-- 
2.40.1.606.ga4b1b128d6-goog

