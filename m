Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF301746B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGDHxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjGDHwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:52:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61E19A9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:52:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55b66ca1c80so1811224a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688457126; x=1691049126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qee/VKQzM1LmZxAkmmj2aucWtJOH/l94Gljx+K2KDa8=;
        b=k+iMyiIZ/rvkyJFLnpCxfPh2kihs9hKp7WCZMgRJ/KWcfxGthOuSTxsh7ufzJA/Bf/
         mzh6BZEJrCQrd57esW6bSICX4N5fXXviTpScCU4T+p1S9Ex1CyHnmwVooY7ZQFENwzJz
         zEkI3p/OBQ13cxCJNgSaA3m+7cI5QWfuYcJr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457126; x=1691049126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qee/VKQzM1LmZxAkmmj2aucWtJOH/l94Gljx+K2KDa8=;
        b=AlqucU/+808gQrjnU+2waZjXIzd5TkqdZbIgDkhnSZrHBZNW7hG1av5cbU6CQhz6Jk
         zeoek8zuJ+flq89QbnAZB3tgRLDoATIJssoaDdmUjl9+maZvQ8HQtcGxgikFvAehXIKi
         lUbKg/gt7Rqo6y+CVu5rmxVigECJt7pYpSC/+PxEtymd0W7KAoGs/aUrzg9YGoJdqcPW
         TL64l+NytmGEQw/vZapkaxflQLbTB4Y0S5OdT9mrovQ7dajV0+chEiR8PehfRmPHbDv9
         b4H3Vn1qgrlvQ8PUOnNfHhokXbTIKxrygfMJy/5tyZ5N9mN2dFBbbbkTIMOhAQ0Xk4fu
         HlhQ==
X-Gm-Message-State: AC+VfDyGE9T8q4wjBFfUotnlh1cipGANlX/OpftxZ6oYrEWTM8wTk1rM
        ppfp8uZcDqsB63Lo6D2/m3lKxg==
X-Google-Smtp-Source: ACHHUZ6+9ouW33wDPBoDXHeV/P1AI/Ns1TtvrKGhlPJ4FwNyTE2MhXe7ejlBjshhe6QIZRhVgVHIEg==
X-Received: by 2002:a05:6a20:8f0c:b0:117:a2f3:3c93 with SMTP id b12-20020a056a208f0c00b00117a2f33c93mr13849232pzk.2.1688457126666;
        Tue, 04 Jul 2023 00:52:06 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a11b:bff7:d8ae:bb0])
        by smtp.gmail.com with UTF8SMTPSA id jm23-20020a17090304d700b001b51b3e84cesm16610112plb.166.2023.07.04.00.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:52:06 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v7 8/8] KVM: remove __gfn_to_pfn_memslot
Date:   Tue,  4 Jul 2023 16:50:53 +0900
Message-ID: <20230704075054.3344915-9-stevensd@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230704075054.3344915-1-stevensd@google.com>
References: <20230704075054.3344915-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

All callers have been migrated to __kvm_follow_pfn.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 virt/kvm/kvm_main.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0f7b41f220b6..5b5afd70f239 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2712,39 +2712,6 @@ kvm_pfn_t __kvm_follow_pfn(struct kvm_follow_pfn *foll)
 }
 EXPORT_SYMBOL_GPL(__kvm_follow_pfn);
 
-kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
-			       bool atomic, bool interruptible, bool *async,
-			       bool write_fault, bool *writable, hva_t *hva)
-{
-	kvm_pfn_t pfn;
-	struct kvm_follow_pfn foll = {
-		.slot = slot,
-		.gfn = gfn,
-		.flags = FOLL_GET,
-		.atomic = atomic,
-		.allow_write_mapping = !!writable,
-	};
-
-	if (write_fault)
-		foll.flags |= FOLL_WRITE;
-	if (async)
-		foll.flags |= FOLL_NOWAIT;
-	if (interruptible)
-		foll.flags |= FOLL_INTERRUPTIBLE;
-
-	pfn = __kvm_follow_pfn(&foll);
-	if (pfn == KVM_PFN_ERR_NEEDS_IO) {
-		*async = true;
-		pfn = KVM_PFN_ERR_FAULT;
-	}
-	if (hva)
-		*hva = foll.hva;
-	if (writable)
-		*writable = foll.writable;
-	return pfn;
-}
-EXPORT_SYMBOL_GPL(__gfn_to_pfn_memslot);
-
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 		      bool *writable)
 {
-- 
2.41.0.255.g8b1d071c50-goog

