Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596D25BF152
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiITXfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiITXej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:34:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F1E796BB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:32:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-349e6acbac9so36947077b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=xUOdAjq4HghazHAVl8uNVyB4YOKA/waPzXFg86fSMzY=;
        b=GNllrm4L9CZmpMD9pUmTSbbWaQ2LqdS5FhgNQXlKhue1ouCs813O4ecTeppy5hzlD8
         DXlt249g1xAabM9LHj6lHJw1NSEnmBtvT2lrw/qIhnxx6TS57AQ2Ps6gzvHKqOtxemnJ
         pHosztHMSzde6gStbqA+/7DuWZTDzvsxi/MA6RK+b/2cw35l1oqFqcnt+9Evp194dyy7
         Frs3Lt3dM2Z8nnQXyjenPltVU4RhtZ4gZpIorxiAHT1qJenMswhN9md8+CgDl/VEPKiC
         acxyEM9ftA3rcvzVcVaFM4+r+GWYTWyBoqOQO3ccaRpdBmea5lemgrfmgTbzkCqTCt75
         l+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=xUOdAjq4HghazHAVl8uNVyB4YOKA/waPzXFg86fSMzY=;
        b=k7AFR/pRmyesFSHXrWbufIobbeRtKEsoEq2tjAbppD9nWayxHitr4ylZ+J0PycKngP
         n0SFZjnGyJ0jeTMeMJ4Y43Nmv9QYNn0YIoexo5QOD8RGiLoG1rrALib7Z6G89WRyGUji
         Qg5bj0Vcf0gc/GvFHFEvyBQcFew2r+wnxH3ycbZIGH4fhwtomAdWW3/MXrL6a4aa66Xi
         nYHSgG3VJkepUAujPn0UjpEcuc3Wh5oU7Q17vzvBcMq76EpwqbTZmbMi3OkCtrC0o4+O
         eR+6FpqT0p5caNHP3xHxrwxAxzyZGd3uYOQBLyfiqxYXpL8h1dxgFye2xGLc7EXKx8A7
         w2/g==
X-Gm-Message-State: ACrzQf3NJIjKBLjlbr1GT9xnr+CXo0kwoON0BqWXvPc+0sCowViMsCI8
        PORd5+fGao4V+GZbgHvFZib7M7sENgQ=
X-Google-Smtp-Source: AMsMyM4445S/CUA4Jiq0RDx3o58oHuxBMaDY5o5srIKAlusEo6GR3leX7sjWCZQbW23SxbfuEamg6P+BCKc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4c45:0:b0:345:4178:1805 with SMTP id
 z66-20020a814c45000000b0034541781805mr22344482ywa.114.1663716742852; Tue, 20
 Sep 2022 16:32:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 20 Sep 2022 23:31:33 +0000
In-Reply-To: <20220920233134.940511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220920233134.940511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220920233134.940511-28-seanjc@google.com>
Subject: [PATCH v3 27/28] KVM: SVM: Ignore writes to Remote Read Data on AVIC
 write traps
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
index 17e64b056e4e..953b1fd14b6d 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -631,6 +631,9 @@ static int avic_unaccel_trap_write(struct kvm_vcpu *vcpu)
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
2.37.3.968.ga6b4b080e4-goog

