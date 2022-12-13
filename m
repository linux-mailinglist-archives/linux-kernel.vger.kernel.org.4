Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558AF64AC24
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiLMARN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiLMARB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:17:01 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7D1B1DF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:00 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d7-20020a170902b70700b0018f4bf00569so4485723pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=50NFsGS1gSOqQ2w00aLYWRGBkzdJNxkXiT3Fli6/1cM=;
        b=RntXhatCOZ04vpV0zIzdgaGWEbEYWk8Tq2GqIJpFXE4mrCLaeCAJtuH3Pg5qOsSZzA
         1Gqy/YZa0zBtj07ZFJ3tG6JMU4KCwOCm/T5sRILXI0FlH/D3wvVplQBIPjqei4UiNSPI
         a4CMtR25N2guRMk4/FjZQT66KbdmGZvSmJlduBn3hy8nk92rzsUvPrUX7aO4GCwcug4r
         IISJJpierbdfQO0Tx5DjkAG7XdtEDOe0ET8V9SUwuL6ZIfaqYtasTr4PpcRAdWCxFgWs
         Kkr9KxexYZ3AH7JENAv+5XPPnw2pUX56FhSnDCQabgZG3QL18mqbMFLUmMRLOpQWMQ2/
         O29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50NFsGS1gSOqQ2w00aLYWRGBkzdJNxkXiT3Fli6/1cM=;
        b=wKGXAfsXE90Wf+8ZbClHIl2UVGcvApGSyFzX89sqdRcP3NBLtJgRfBdv7jMw7OPHrl
         ivL1/Ky8jlaArGRiYuJDRGjMXXOZH35/TcOSGtQhzVZMeN8N9OBnV3jAdf5CGBUaMhtF
         xwrChMU3xktk5v+4At3641aJOc/orvL8jWWu9S+m5C2SYH5JvIXJBKHxD1asAqfmMHET
         Eiu4Rvk9nk5XkXqnP9s2R/X+Ul0DQVgZUDQL4kyXLQEuuD1T1dMUwTr+WGfnzAwdOVtr
         BCGXQOpoUFkWb0RVeQTHVF2ZNX1f/+t1kqPenO2P3gnVAI2hMZW5XLeoluiT7D6SeS3m
         gkYQ==
X-Gm-Message-State: ANoB5pnJ+Po1DfdsIA7VqW4dl+RBTvvjb8t/j7nnw9t+52BixcvPJdX8
        17Edj+udjqXYe4Qt6JWJpZFmqvgs9YE=
X-Google-Smtp-Source: AA0mqf4F87lnfsrUQXXGQjwWJclGxioxHjaqJbg+kPkH4OzPOkmZnoLhZ3jfHM5GA0UKCp57pLd7VyYImGw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2ecb:b0:219:5b3b:2b9f with SMTP id
 h11-20020a17090a2ecb00b002195b3b2b9fmr4271pjs.2.1670890619791; Mon, 12 Dec
 2022 16:16:59 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 00:16:41 +0000
In-Reply-To: <20221213001653.3852042-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213001653.3852042-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213001653.3852042-3-seanjc@google.com>
Subject: [PATCH 02/14] KVM: selftests: Delete dead code in x86_64/vmx_tsc_adjust_test.c
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>
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

Delete an unused struct definition in x86_64/vmx_tsc_adjust_test.c.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 5943187e8594..ff8ecdf32ae0 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -49,11 +49,6 @@ enum {
 	NUM_VMX_PAGES,
 };
 
-struct kvm_single_msr {
-	struct kvm_msrs header;
-	struct kvm_msr_entry entry;
-} __attribute__((packed));
-
 /* The virtual machine object. */
 static struct kvm_vm *vm;
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

