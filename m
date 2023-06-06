Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370D3724D11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbjFFT3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbjFFT3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:29:15 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E821703
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:29:08 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id ca18e2360f4ac-77751dc936eso555474439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686079747; x=1688671747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmdPfikIRRvnyRjXE+lL2qXckkyOSYAQTpf3USgKEV0=;
        b=NHF1fXOFFod7VAbBEt8UCeYZ0LWUlIN+Z6b57RJ3dYkbyPMi44oby9chiAOpKFs6un
         rhxs+wXMHvdYt4NYsIrtkVl2YKSo3zk8tNR2TwujCnBckhIbpVAaktlHB3QijHKNfJUe
         hkb8y/6aZZhYsF9WaKPqZYo3xyz17qUNtYekIJTDlgCURWGI245/YxQk2wkmQm7hJ4hL
         xayxtGHFCypiY81y05iqASARTfMp4rlZxyu38FOX8d7dloa7uO6fa0YCW5u90zQup9cK
         dJkRfasVP0S5ITGJLJepNh3XaHWNfVUfe+xqGnGRaOc8k4fa1vead1/j2XUFEnm8uJDb
         bDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686079747; x=1688671747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmdPfikIRRvnyRjXE+lL2qXckkyOSYAQTpf3USgKEV0=;
        b=NSO+S3uS8MgJxxBQ7ZxIR6uNDBez5dPrSl5iYaClY93AfH2jAlNzDzRPFxeTWD0dsz
         0a65HWYikWOJXfLcJ8HScrQY6vIEEyqmQVSWFStI0i0nU8VloaMouWheaIlO/R5M+j/I
         yP3TuXzxqz4VrHJVsof4GR06aK9OrmGIpfm/rnveS4cnuWUd+D7S3v3xdBSgU4Rn3gOf
         1HHDXOZnWDIjxkrPdHk6rUT/cjZ015BtS6DvNwWjpnc5skFYpVKZ67XG8H2oTDFdMlCx
         vpMMxk7sYBgw/v9ldGOLjGWS9ZC3Z4LvAR+dmnMcdaWdS0yfr3JYBKdFs55D2h86NVC9
         kTcQ==
X-Gm-Message-State: AC+VfDyWzMqizf3kY/qqw8q+LNpmIVabIGntIGH/lGz9gvz8wyl/Bg7U
        xhnFaBhQyUlBMrGKSZRrc0k5fbisWdM6
X-Google-Smtp-Source: ACHHUZ7BFKutOddfAvI8ltY6fxG4ugpMD+YbWGB0EQ+yV6UaPweh0t3ry+B0nZFcGDzDjvtX8EMf8dfFMhPB
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a6b:6e01:0:b0:774:9732:324 with SMTP id
 d1-20020a6b6e01000000b0077497320324mr1569372ioh.2.1686079747656; Tue, 06 Jun
 2023 12:29:07 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:28:56 +0000
In-Reply-To: <20230606192858.3600174-1-rananta@google.com>
Mime-Version: 1.0
References: <20230606192858.3600174-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606192858.3600174-6-rananta@google.com>
Subject: [PATCH v5 5/7] KVM: arm64: Flush only the memslot after write-protect
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
index c3ec2141c3284..94f10e670c100 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -992,7 +992,7 @@ static void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 	write_lock(&kvm->mmu_lock);
 	stage2_wp_range(&kvm->arch.mmu, start, end);
 	write_unlock(&kvm->mmu_lock);
-	kvm_flush_remote_tlbs(kvm);
+	kvm_flush_remote_tlbs_memslot(kvm, memslot);
 }
 
 /**
-- 
2.41.0.rc0.172.g3f132b7071-goog

