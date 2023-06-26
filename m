Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1173E805
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjFZSUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjFZSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:20:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD510D7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:20:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd6df68105cso5081392276.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687803627; x=1690395627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DC1JUUoeIHOkdglYQmr1DfzfpGQE2uWlWtSL5MUhKa8=;
        b=xYtXcmWxk0P1fCDcWTRmRHQ213fqB4rQuiXjexvxKc69fWrbx+jG1hAwG0llCkpycZ
         vIxsx2SNm225hbYaBdJVqoTck9XSOJKHlXh8DXvyqKg1GDw5gd8l+hSpY9QBLAiV12RY
         rv75429GaSsLG1+mV89FXylyGQezn4c2bMvPj3UN87MBkxdRUBLLYdkdL6DAdn3RGg72
         VAUFRTosn8/60fdz9qwFv3TJRj28bLsYQui4hfKh76McyD8vBN0+at6FZ+BkOw316Td+
         oESmYoDPXCHZZNA1rzDVevcOJ+5+8ZFPleApgNlncNDFxrTYp6OUsyfuI65KKgKe+AdK
         ayrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803627; x=1690395627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DC1JUUoeIHOkdglYQmr1DfzfpGQE2uWlWtSL5MUhKa8=;
        b=jRPxCKFmkeKJ9T65hqU8oVDhCDo5RBP2DIdfzK0j+oAUnKYQn2IYw1Rd5fsuO2czeZ
         iO+lGRilTmHGR9GjOe7gVhnBg+dIM/FDyTrUcnKrMxBhVeyo9KDhbKNNCAfUXL3NU2FY
         5luJzfWj7R2sSEzP33WwhzAd7o9/g9eYm6T+sfMqf3A0oxOuOFanC4PkLLRh4uZtlNGg
         zIQLe2IzCVi4j2h+LLwEVAzSnCHZJ3u4cdYY4YsnXPQNttatlKV2hDgftGmsZL04NDb2
         Y5KBcZ2VpmtM4790j7Wrn1eVbBz1Xt8LjsSec1i10EkwJWgyRZX95oldW9Z7AXj9ERK4
         Xdag==
X-Gm-Message-State: AC+VfDw2Z4coUMeP7K/Iur1lg9M14ThdOcGg66rPEwLo+LYlHrRgBZsD
        ofNALnBH+FRELaoGc8rpVQ3dtC0ukfPu
X-Google-Smtp-Source: ACHHUZ488Z5RLeNgsxoRg10Vnlrts0vwlnMOG3/l4w4TY2cIGhoT7SAOtLcxmF27YNT6IpiCb3oib0lZxORJ
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:18c4:b0:c1c:e037:136c with SMTP id
 ck4-20020a05690218c400b00c1ce037136cmr3172718ybb.0.1687803627815; Mon, 26 Jun
 2023 11:20:27 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 26 Jun 2023 18:20:14 +0000
In-Reply-To: <20230626182016.4127366-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230626182016.4127366-1-mizhang@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230626182016.4127366-5-mizhang@google.com>
Subject: [PATCH v2 4/6] KVM: Documentation: Add the missing description for
 tdp_mmu_root_count into kvm_mmu_page
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, Xu Yilun <yilun.xu@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>
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

Add the description of tdp_mmu_root_count into kvm_mmu_page description.
tdp_mmu_root_count is an atomic counter used only in TDP MMU. Its usage and
meaning is slightly different with root_counter in shadow MMU. Update the
doc.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 Documentation/virt/kvm/x86/mmu.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
index 5cd6cd5e8926..97d695207e11 100644
--- a/Documentation/virt/kvm/x86/mmu.rst
+++ b/Documentation/virt/kvm/x86/mmu.rst
@@ -231,6 +231,11 @@ Shadow pages contain the following information:
     A counter keeping track of how many hardware registers (guest cr3 or
     pdptrs) are now pointing at the page.  While this counter is nonzero, the
     page cannot be destroyed.  See role.invalid.
+  tdp_mmu_root_count:
+    An atomic reference counter in TDP MMU root page that allows for parallel
+    accesses.  Accessing the page requires lifting the counter value. The
+    initial value is set to 2 indicating one reference from vCPU and one
+    from TDP MMU itself. Note this field is a union with root_count.
   parent_ptes:
     The reverse mapping for the pte/ptes pointing at this page's spt. If
     parent_ptes bit 0 is zero, only one spte points at this page and
-- 
2.41.0.162.gfafddb0af9-goog

