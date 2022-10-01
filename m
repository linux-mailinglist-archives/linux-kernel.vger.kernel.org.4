Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BA5F17F0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiJABDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiJABCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:02:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9998170B07
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:28 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u5-20020a170902e80500b00178944c46aaso4239388plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=+WScKi0/mMhleZMiFA5QnxX58HadmgDv+cqGuX0Jda4=;
        b=cAugleHNQ/u7kS9PbZqNOStNuoBnqWLdeRydC5oHYD6JR02YZNq1eDEucHpVKHM8Wq
         tGdN/HOt+VhcwOQxW8s/Lrkkb+ygvfbU2nPFoCAgY0YK6sy46d9SrxNy8QyuzloPp4SB
         Qte7oIgg70A1twdSvSKt+PQamrh/zqaEX2Iu+ZOTLHCm1nVBzwMiqmlz8ZKh14Q52fFk
         QhdW0mAxKsLrrWYq1ndHWpZFMZv6JwaVKEfwWvy73+TFhBF2DZIfapMR2W+vt+pcV6yi
         +yfuls6iOwO5KNWn6wuVzvR0mQPcdT767HWWTHqM8KBp3KQ+nWwrfC/d+oYn3KBuXUv/
         1BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=+WScKi0/mMhleZMiFA5QnxX58HadmgDv+cqGuX0Jda4=;
        b=sJKCQdikhF77RDbZ4ffF2ttOYq8zeJrlPHhyI2n2vDtJv3AcrvcUQutSHUtlPidM4/
         yhAZt1dIHj45h4UdxKN38qC4m+tZ3W1nHVDHNs+mkDimQuJP0cri1LjQbr1Y1JWWgz8q
         3mK+L7pabVU4wuL4jRIZkz1UbK+YzUmtiA0yKkIyGyXv25Td3T1u34DBKlbkuGseD/eC
         kOdc0lBUKEmakniWpiDBMCiHIlBiljgRyZgIV/kUUr9GAkMa7mBKnJGf6vTKdvqOf9JF
         UBt5ZwX9vq6g4E44QD0R9FkUI+AojjYBdR0inJ9nOqlWENAmFzqKdTO0xmJy4tJjJUUC
         PHPQ==
X-Gm-Message-State: ACrzQf0tTIrKQ9aj5OEMXCD0EiyqZYnBJoFqxBmoJzXibHoLBL2yryhn
        5R71/FNAQsP7ERQnNljxGvVZua+3n1g=
X-Google-Smtp-Source: AMsMyM48IICgWWJ1X/KSjuc2D9WLLMfuymLJrtN4U6/7sbxvvyPeFInciHCCDI4y7x8Lg7Ak4K+jy061XDU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:641:b0:202:8568:4180 with SMTP id
 q1-20020a17090a064100b0020285684180mr988078pje.227.1664586010770; Fri, 30 Sep
 2022 18:00:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:59:14 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-32-seanjc@google.com>
Subject: [PATCH v4 31/32] Revert "KVM: SVM: Do not throw warning when calling
 avic_vcpu_load on a running vcpu"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
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

Turns out that some warnings exist for good reasons.  Restore the warning
in avic_vcpu_load() that guards against calling avic_vcpu_load() on a
running vCPU now that KVM avoids doing so when switching between x2APIC
and xAPIC.  The entire point of the WARN is to highlight that KVM should
not be reloading an AVIC.

Opportunistically convert the WARN_ON() to WARN_ON_ONCE() to avoid
spamming the kernel if it does fire.

This reverts commit c0caeee65af3944b7b8abbf566e7cc1fae15c775.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 953b1fd14b6d..35b0ef877e53 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1038,6 +1038,7 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		return;
 
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

