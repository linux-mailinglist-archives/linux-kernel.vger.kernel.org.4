Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F2C623892
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiKJBEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiKJBD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:03:58 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFBB222AA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:03:57 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id k11-20020aa792cb000000b00558674e8e7fso185199pfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 17:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDDHXPhFkGdnX95qrgqVPt+r6rQuoMhyEFBChOuB5Os=;
        b=MZXsVlUfoTlGHrSgXpEusui6O66VcUV2rNkXmCsIYuB2zgTgveT3K6JVT4csrJd90U
         SXCtzooBnC8HqrgOJJN9VQBbR0m2YhW0tTeK2fda96kBkTbEk/gi3H/UzM/lhIwnbOWb
         0b4fuRW57MXJcr/4xBfNJViYkwGD6hAcn/q3fOV4E2kXE7ozNQ5oN/bz/A5ijG/OGtWj
         QFlvR7+yF8Y6jGGv8gp6B3Pb1uGJXRvP+Yyk9UM61o9KayrsP+Ow4bmX5eKnilzn7HQ0
         f48hnQDwHp0VZU99uhTmFSBmeX2FmSI4WZYvVLzKIR7WrPJH5MimWY7Oxac8y0BQs2Mo
         xF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDDHXPhFkGdnX95qrgqVPt+r6rQuoMhyEFBChOuB5Os=;
        b=mlQhiSm5Re9SbrukBp5KX8/foVo7vJYJl4WXNB603ou3zSTxo48quwMnrPJ/uvEpmJ
         PlRfu/FXXNUh2xjj2GiUIhUgKAxjus/hpoJrswkIBxrsPF45DT0b4P4FkrHfylwqYdrB
         uBGp9Ptf6c03NtGEMTB/MrGwQYbgZM/dyQlkb4NTm059OqbxU9wYaN5l7WU+qcPUKbmb
         UJE4NcreP3mJqZ1nQHbD8GqH2jIRvJpWxhx/xiZmq1AKMOjRp5LTlDRSq7uNBwKNipe3
         ZluUBXPV/rfaTEimgROlL+lvCSkq/uheLPXSQKnoSULZuE34m2gn2R9k2nRC6mxKg64i
         N2hA==
X-Gm-Message-State: ACrzQf3hdZWSVc/iDijkJJKTZ2LHN+AYJD/7CYiQiFztDWRlTqxBe7tm
        SE05Hsbd+ZBw0hJR9AGy8hN1+1Lhpwg=
X-Google-Smtp-Source: AMsMyM7m81/Mbrrd3QVHFCB5IYx7Mek7wWQ+j7ee25Sj5VzTZu5i1gn4NeN2p5sgfqY453GnHEeBXIikYUs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:72c4:b0:212:f923:2f90 with SMTP id
 l4-20020a17090a72c400b00212f9232f90mr1211629pjk.93.1668042236783; Wed, 09 Nov
 2022 17:03:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 01:03:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110010354.1342128-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Remove unnecessary export of kvm_cpu_has_pending_timer()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Don't export x86's kvm_cpu_has_pending_timer(), the helper isn't used by
KVM x86's vendor modules.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index d8d50558f165..04a009fbdf8a 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -31,7 +31,6 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 
 	return r;
 }
-EXPORT_SYMBOL(kvm_cpu_has_pending_timer);
 
 /*
  * check if there is a pending userspace external interrupt

base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 
2.38.1.431.g37b22c650d-goog

