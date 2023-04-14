Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543636E297D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjDNR3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjDNR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:29:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276D5BB0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:29:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t66-20020a254645000000b00b74680a7904so19777333yba.15
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681493370; x=1684085370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KPViUvkFxC3TgEpc/g+CHYNB1CL2Y9j6aLSEKzBNRU4=;
        b=bfUCUQuKiETTWlzQAbfjNWEznPFMMabCQwMyvFryGC5wRD7C7JsvkTJRpUdEZwuD3d
         EmNvtIVJ1PzWXZp48dtSC3Uqt+Qd7L6LI6SYR2R18kQn4tOvoKZvDTWk28yQdgjV/t+g
         aEQHdU35HFceLmkmPdsoDUlmW9uweT8xG74XVcOTweM7F/e4vvyBkpSw2ZfUszXVuX67
         16Y20IFlGTWB08vhSSrtkSoRM6c/HGCuncpoLyYgPWweOItK5ELHtnPUFzjbLrNEYcNm
         uWOezjyZmaPewp35SfIf/iN4YAyxULNabW1cY5mFVAaVM+373vhmIlEchR/iiRJYdrBd
         +lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493370; x=1684085370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPViUvkFxC3TgEpc/g+CHYNB1CL2Y9j6aLSEKzBNRU4=;
        b=Npds7Kbseb3BAcg3yIgvwvXqXliK5LungbByN0spXSmrQOmm/WKE5wSIxwQAEuQGae
         2c5KoLva6+iRsM24uM3hPku19+Bcp3WP7umI4y/vL8uSaxAT6w/mrC8QcPPsS5ovNfn8
         KcQmbiNRZBNVaAlV9Z3M5xmLUy9PKodU7EeqlQ7gsvE/dMr+1ffh3DtjkQEbR2+M7LIA
         WtleIhOj4yLqjmkcZEOew2FIVv8lzz6pUmzSb8x9MCrDl4cCf0WD14cZMrXLuEUObh2H
         0HvzNEBSJpNK6ZGEvqwbsnJ4XSTW828PwYcL35nMQkJKiOsiVSBjR24L2skb7p9KlJ3P
         sh5A==
X-Gm-Message-State: AAQBX9e5oFhSlxSyQP7c7xr8NJ57xmKUqg3COIZenpkBOKiMgDQRUeZe
        0EelUh3edqCdqB0jPRMWqBHWXUU/Nb2G
X-Google-Smtp-Source: AKy350aLcIkj/hYVjZbP05g2b5z8MsRd71+scXvLOlNSX4p4BB89Fk+7FtQuUnznnwYfU5yATegzNaTrdaKg
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a81:c406:0:b0:54d:913b:c9e8 with SMTP id
 j6-20020a81c406000000b0054d913bc9e8mr3919984ywi.5.1681493369929; Fri, 14 Apr
 2023 10:29:29 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:29:19 +0000
In-Reply-To: <20230414172922.812640-1-rananta@google.com>
Mime-Version: 1.0
References: <20230414172922.812640-1-rananta@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414172922.812640-5-rananta@google.com>
Subject: [PATCH v3 4/7] KVM: arm64: Flush only the memslot after write-protect
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Ricardo Koller <ricarkol@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

After write-protecting the region, currently KVM invalidates
the entire TLB entries using kvm_flush_remote_tlbs(). Instead,
scope the invalidation only to the targeted memslot. If
supported, the architecture would use the range-based TLBI
instructions to flush the memslot or else fallback to flushing
all of the TLBs.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index e3673b4c10292..2ea6eb4ea763e 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -996,7 +996,7 @@ static void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 	write_lock(&kvm->mmu_lock);
 	stage2_wp_range(&kvm->arch.mmu, start, end);
 	write_unlock(&kvm->mmu_lock);
-	kvm_flush_remote_tlbs(kvm);
+	kvm_flush_remote_tlbs_memslot(kvm, memslot);
 }
 
 /**
-- 
2.40.0.634.g4ca3ef3211-goog

