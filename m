Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69C5BF151
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiITXev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiITXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:34:18 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D39786E8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:32:45 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y22-20020a626416000000b0054769104b0cso2502098pfb.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=VSS9P4anBFtLf4B9B5LJylk6y1/+T/yH5E3Gi46su5c=;
        b=dzsAR999gAs5GI60MjtbEHw4Ha/P3CgSWfoPQo+P1oGkQfkJGxCOO8KVHK+jiDCOip
         Dq5472xUqeafNkymSqfry21kzntpgn2WKqFC3+REW0Wx64ayEeTgGLzEULjQOS1DrggQ
         erpBK+2sNCkvu3XVL/M99PwZkjL4NwLAKqGtpoi7WOuRWsw60fxIPvCXn/tZVBvoqHf9
         YtArUePHaI/K2gcgIlT166ynrxbeS2KYNMXZ+hVw4ch9X7wv+1mTki606d+Ky0Pho56C
         v0EgLgu/uRuWd5TYowHX3TVLuamYHv2sUrWVDMEwWK9NIFbgxBeDE+2zzGSEYx7pgs2Z
         g62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=VSS9P4anBFtLf4B9B5LJylk6y1/+T/yH5E3Gi46su5c=;
        b=IrxI8BxIM9KjRScnd2w9veAwCDDHGQaQLrouLdfTSSXvFH+UVpiZ/RYA0x+kMLx1aK
         7If9thtXGfGa0qjBRHkfhhZh4wETmeIbUJWHGJ90l7aC41K/JI4V4sF2PFOUg6VytZ/N
         UsiW4QdOnRm3+noNEjXcx8GmDryLxRI90Ya75obgsd8NfPIf+SMnMVTnUSDnAdiykjuT
         M8iu7vL9/aKEnix63X6y5fOiIfP0Gmun5kj7RFliwYasCZc5J+XRgG/1Q+2VAfzCVYoO
         1UEaD/jPKR+MBJfzUId/uvcB4v3g6jBwIbTMaGaTf5JeZng3Wzvrhbyuo8U5y9JrDzFL
         msNw==
X-Gm-Message-State: ACrzQf3tH5Z2Ce1Idp1dPlLKmyDSrEMQF4zFOlE/nPezkNbwH4O2YL5j
        +/wPqilRegXPxgv7KNOQpVvatPasWao=
X-Google-Smtp-Source: AMsMyM5AYuJd6z3doTqWLCrZVEZtzqlgEgckGLurEasrMrybraXxa+ZuJxu+ZTtvOe7/iw9ugkJWD8ci2mc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP id
 d15-20020a056a0010cf00b0052848c379e0mr25917775pfu.18.1663716744442; Tue, 20
 Sep 2022 16:32:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 20 Sep 2022 23:31:34 +0000
In-Reply-To: <20220920233134.940511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220920233134.940511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220920233134.940511-29-seanjc@google.com>
Subject: [PATCH v3 28/28] Revert "KVM: SVM: Do not throw warning when calling
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.37.3.968.ga6b4b080e4-goog

