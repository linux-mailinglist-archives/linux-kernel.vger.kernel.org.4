Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3895C5F17F1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiJABDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiJABCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:02:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E26F03D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:28 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n10-20020a170902e54a00b001782663dcaeso4220178plf.18
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=m33xJ9pBizwrUhfQsmYman/PfJNtqiYZN3F07u+sy1s=;
        b=doAqyYMrLEzGmhnjgT6yRYK7FatZK4uscBSQzAbeNRy6MapfWpyqdXnFh3wypzCsOr
         TxoqSN1pxXYXVE9ZgnJD2PS/6pdikSa6RhfSwUtCmulZucCneYFMl1EimC0x9U5NfX9F
         2wMhWUgqLM1l+jWiTllRy8PRAMLyhps/RW7pbgQ9vhby954awA8PF9MzpzudnSjGXJjy
         ewti38RQOPTmHgRWxtymWTcb0W2e0d11sAI5rm4DiuQDCMHdrT1N17ltv+HfwTMDsJGA
         td6n4ndMZwTN2LEnEVXwvtwQKfxUKYAtfBiXtblqS8PsMxGIg/zL85mD54fFctwlWw/t
         pa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=m33xJ9pBizwrUhfQsmYman/PfJNtqiYZN3F07u+sy1s=;
        b=TUMwUsaUoWwBEi4PgO7G3liiFyp5+ue++IyJ39uuf6AflC+09C/3tgktyNnySexenI
         TMCcLN7V2lx195wcjpYLSDumU+StMgkzEQ5B+aB814ZORbc+tbwUBC0Cid5ARmz9+4oQ
         AD8U+qmW3GhI0sfhvzVhbpYCAHXtIIWRbe5zZjP9BAnpTj6OBlBQZcu+9isTyKBL/K3I
         0GEk5eKDeclemzMFdgAlF5pvs+zrRJDwgrKFXjKXgqCGGanZzkAjSID09EB8T2U3QCCA
         DgZ/z4sVMkw7zAYfCwdidd+VDcW3F+0h5LEAFAlJsq4HF0NUdq3Qer37Cr6SuXNWwO6H
         zKJw==
X-Gm-Message-State: ACrzQf3fwi18LfSlH+yYH5p37kplqCf4viWijqUGW/43+KR193ADocq7
        yG2biLo2/hiachY5kPF276fYUc1+J5A=
X-Google-Smtp-Source: AMsMyM7UFxKVxA9e+lSlEe4vjVtsXH9VjJy9Tw0FAaHrLe0l+PQMiOkThtLnqVYDU9iOBTic3GqUzGrzkAQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1c8e:b0:205:783b:fe32 with SMTP id
 oo14-20020a17090b1c8e00b00205783bfe32mr1009086pjb.39.1664586009100; Fri, 30
 Sep 2022 18:00:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:59:13 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-31-seanjc@google.com>
Subject: [PATCH v4 30/32] KVM: SVM: Ignore writes to Remote Read Data on AVIC
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
2.38.0.rc1.362.ged0d419d3c-goog

