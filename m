Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F24C6549A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiLWAOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiLWAN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:13:59 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FED26543
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:13:58 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e6-20020aa78c46000000b005772151d489so1786803pfd.15
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CXtB6MmWgwzdyhdYI6wgxsbgDPgAgTn0fSY+N59/F8=;
        b=drpNHVsxlEQPFFOKpXIeD+HdXUVwglQVf5P3SjgrGRWkac+ExKksqwf2uJcdq6tNAY
         dzE7DEuw9lOfVmG4IPSHg9ge2WxIe4c3sdbOoBHOuRakO+snBcaTDAt0Ex/WGTRsTYrg
         b5/8VhWaubp4zJlxmRXrbSSUC/MfGw3nZVk63VY7yoLpxgLU80KPH4J/51ITcwYHISkT
         Swk4EqO7j+tz4b98gJSbEof3ugrIy8hT5k/XbiZx9Q3rbrQs9Fmj+j09Njf0tHrQX6pX
         xl2cickkH5OxZPemDApPAiesiswRMUt/uQVQeLGXWKtqOABdpBLcolSi9Qf3ao4VZmEm
         XyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CXtB6MmWgwzdyhdYI6wgxsbgDPgAgTn0fSY+N59/F8=;
        b=JTTWEkMYgxTvuTglGXIvSWNh4K+cYxPbP33hwB5WGwEuG0nWJ07cQoGmFjXu1iTYT8
         Yh7vmLNhKql+WzGFv9QC27CAJO/4IwJEy9soax1D0fLTyRUc5B9PX8tj+Yp3y88b064I
         RUd1dvyBVmLWIIeWnB+7KGfPMjz5L5dygrKS2Y0N1hMKF7+Rcj0YJyZYJM5CyPSQNJvn
         Wy/Y5EPeBuYHrGdBKr0BFTu2iR382kCuzJ2YeKhPwnNtRoOzut7UvFdaCyy+Rkf+X0Kt
         eqdepf7cFI0xa2o2SYRS+eJd9hiC+GzF1VkaujxYQMHXHIPeOPceabOuxCeIYf94OTOA
         zk0Q==
X-Gm-Message-State: AFqh2kpJa7r7Da8ISeZERH0QevQovMxGrlAz/9Yu3sADJw09/mRtI7ni
        497B3BtDF7rajsICrDuP9FrQAYTyInXMqSmN
X-Google-Smtp-Source: AMrXdXv4c3s22lQ8qQxnMVuKAij3ndlrk3aTTDiiOZmva1SV1pclFaT3/V/1VZXr2KoAYvuhAnpCUB0B/vE4Bscr
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:349b:b0:576:91fa:8ed0 with
 SMTP id cp27-20020a056a00349b00b0057691fa8ed0mr603715pfb.15.1671754437896;
 Thu, 22 Dec 2022 16:13:57 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:45 +0000
In-Reply-To: <20221223001352.3873203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221223001352.3873203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-2-vannapurve@google.com>
Subject: [V3 PATCH 1/8] KVM: selftests: private_mem: Use native hypercall
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

CVMs need to execute hypercalls as per the cpu type without relying on
KVM emulation.

Execute hypercall from the guest using native instructions.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/private_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/private_mem.c b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
index 2b97fc34ec4a..5a8fd8c3bc04 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
@@ -24,7 +24,7 @@
 static inline uint64_t __kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
 	uint64_t flags)
 {
-	return kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> PAGE_SHIFT, flags, 0);
+	return kvm_native_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> PAGE_SHIFT, flags, 0);
 }
 
 static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
-- 
2.39.0.314.g84b9a713c41-goog

