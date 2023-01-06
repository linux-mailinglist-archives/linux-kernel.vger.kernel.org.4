Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833D65F8F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjAFBRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjAFBQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:16:30 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8C765AF2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:14:22 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-47ede4426e1so3120787b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0PXIy8RA30k82n5MqadBULMYpw3jcQQNxAI0MLkfm2o=;
        b=ARYzhqPubKAcUMlq5dSBX0xvRbkdMD3Z7If0ag7prbjxIne2GkJ8lAhHrtaEOpMtq7
         wIIAhYz1/Ajx9d5Cslo0C4NAiwSy8WApA2ndyhaXFs6IngyBWHUw8/RvgrKmAvHUhpkO
         cyOgu6KCI3mBFPHHb5Py5lPdjDvIYKL4PgTbXDJoeb9G5AmvTkBPp7JhJ96D5XJeOmNF
         H71WGUwe4Z9AK+ykt/tiEyDRK2He33wLTdGnjX2xFBC78IVPGeo7k2WIXLG0DcCUuoTc
         xxOGpURmrBMBR/Kj4dorDzcHumIWTMXaSANO4lHr0MkNbDkcual08RTxiy0tgP3OCVKT
         4hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PXIy8RA30k82n5MqadBULMYpw3jcQQNxAI0MLkfm2o=;
        b=vCoZhtwVQpHeNmymXkVIXtq6YTrS0tyIqlCkjrrekGFFl53Rtoo3B1N/KlycD2Fb0R
         inpI0m8i+kQw3MpObC4qQyIMz2Z1tIy5TpDvlq3RBl+ADVXQmmDIiVydzl5NpJSIcYC1
         KeAmaW4VC+/MBpGuaoiM95H5IKgLGj1zOP++vrXLeqgbJhFR6fPUlX+Ku/6+lBFYxgXJ
         lm1U0x90ROO8J+IgZqj0aVpHo+R5ap1QOr2Fq2ed15qFZn3/3KusB1PYZzfi5PfxHEzZ
         OXmZ/wkJ3LIbGCIAf0kUFXzDbFERG2DswQ3sXIj4uNgRUFyi+AnO+DCh80zn/CXdCOIR
         SP2w==
X-Gm-Message-State: AFqh2kr8f4nPYGfjD/IgnOS9KPZ1FxuK/9XcxtQj0dhPoWcoF2mw21WL
        W3J3z0QJhvMYIQEO6Q0U3DrYEUr0Zo8=
X-Google-Smtp-Source: AMrXdXt4VBg4zaH9HqqIlH27H/G6sq0m1dLXG6txeQ75uTMkvGpBIpTSTbajtVV7xXJrKV//LkmnjgWpK6g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d095:0:b0:7b6:daae:ad50 with SMTP id
 h143-20020a25d095000000b007b6daaead50mr235713ybg.89.1672967643231; Thu, 05
 Jan 2023 17:14:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:13:02 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-30-seanjc@google.com>
Subject: [PATCH v5 29/33] KVM: SVM: Ignore writes to Remote Read Data on AVIC
 write traps
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
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

Drop writes to APIC_RRR, a.k.a. Remote Read Data Register, on AVIC
unaccelerated write traps.  The register is read-only and isn't emulated
by KVM.  Sending the register through kvm_apic_write_nodecode() will
result in screaming when x2APIC is enabled due to the unexpected failure
to retrieve the MSR (KVM expects that only "legal" accesses will trap).

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 2c6737f72bd4..ff08732469cb 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -628,6 +628,9 @@ static int avic_unaccel_trap_write(struct kvm_vcpu *vcpu)
 	case APIC_DFR:
 		avic_handle_dfr_update(vcpu);
 		break;
+	case APIC_RRR:
+		/* Ignore writes to Read Remote Data, it's read-only. */
+		return 1;
 	default:
 		break;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

