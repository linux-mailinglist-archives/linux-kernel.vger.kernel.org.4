Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4771F79B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjFBBPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjFBBPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:15:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85E199
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:15:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4eefd2so2089016276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685668526; x=1688260526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XNDrDuYa3iWJuXJKyD6gXhX5XFme5N3YEsdm0o31DEg=;
        b=Po+suhv+8tQfEJPqRxrACOHdjZJr6yLdW6VxkO02vb+MHxsu4VMYOZCpTcDebrWjnK
         5738//eSrPOHNp0DY8SragBWqRMzBLxVXuVgfE4ougaCogMIJw+nETG6kjdb36Z2Htzq
         lNYjNs/6RjAfL2Jqnx6VBZgmnJRAAZJvBw4rqJCA+LsNxX8JDl/scqSO3oqh9fopdqQI
         t9LFrhwbk8UNBGby9BfGJsomRdX8VCDme789sKFtZDc0jjmTUsnKOmec0hPIYSPkMfYW
         nrMt+UVVLwW/9wqxKSlQupZAiVTTRmQIP84xeBBr8ThQH5X5pnhXfNofP/yD4wyFV22W
         JLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668526; x=1688260526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNDrDuYa3iWJuXJKyD6gXhX5XFme5N3YEsdm0o31DEg=;
        b=NfaccLyLt7Em4dRDcqo2obuINgsRz/wAgk4VdUBzt4MFzhB+0e5+QFE4EFN4z7Ymet
         5xY1TMzzWZyD4AZ76X6r+nBe9tV8k0YWGbKv+viIl58QkC3NmDPznRixXEvQ74ESYtMZ
         3eQzPWEBW2AONkXIg1E7x8vKQCq/BBxMlpR5BliA7AEPfdUEXzoiNL1eVtfLaqhHxpml
         30C1Nak5NeBbyCWuac35+MZxrU3PEGywtuIvEXTlyQb11bMbvOPk2gpL+QjpIakl7QAw
         NxwgwgJwyhdaqAKqHQHzcpfalS8jPz8H7E5p862WHhxw1rcGwioZE9ll6X+xa09tZM0Y
         f6zQ==
X-Gm-Message-State: AC+VfDyVZQ+c3leO44koY60hw6FsYWVin9IOvHnI1b/aiO6YEdxfSTmo
        JViv8H7WHgzEOl4o0g/zRLcEiswRYas=
X-Google-Smtp-Source: ACHHUZ7cPfIKclr7oNjHZSfTJTSx+pWLxljxRhAfi0IWAULdDfsjibdjwFE12QVJhJMmwgImQyv2yaQT3d4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:adc6:0:b0:b8f:6b84:33cb with SMTP id
 d6-20020a25adc6000000b00b8f6b8433cbmr714516ybe.11.1685668526648; Thu, 01 Jun
 2023 18:15:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Jun 2023 18:15:18 -0700
In-Reply-To: <20230602011518.787006-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230602011518.787006-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602011518.787006-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: x86/mmu: Trigger APIC-access page reload iff vendor
 code cares
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
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

Request an APIC-access page reload when the backing page is migrated (or
unmapped) if and only if vendor code actually plugs the backing pfn into
structures that reside outside of KVM's MMU.  This avoids kicking all
vCPUs in the (hopefully infrequent) scenario where the backing page is
migrated/invalidated.

Unlike VMX's APICv, SVM's AVIC doesn't plug the backing pfn directly into
the VMCB and so doesn't need a hook to invalidate an out-of-MMU "mapping".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 01a11ce68e57..beb507d82adf 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1600,7 +1600,8 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (tdp_mmu_enabled)
 		flush = kvm_tdp_mmu_unmap_gfn_range(kvm, range, flush);
 
-	if (range->slot->id == APIC_ACCESS_PAGE_PRIVATE_MEMSLOT)
+	if (kvm_x86_ops.set_apic_access_page_addr &&
+	    range->slot->id == APIC_ACCESS_PAGE_PRIVATE_MEMSLOT)
 		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
 
 	return flush;
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

