Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3807562E3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbiKQSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiKQSLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:11:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5D682209
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:11:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-370624ca2e8so25923677b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wteh+NFEi1GAsB9oF3PCiWMRRI+co3r9IDe7/2rAE34=;
        b=nMPxbK2ewjH+fsYNZqiLd//2LrKs65SwyM7mNXN787ZD4W6hIOaTT53xBtzBuwe83f
         dPp8qx9NrhlldMjEFYsXhWxhpArwLywx3EZ5yiRT9eCxLDCW2IyhYOwLtAnlL0wg8slI
         8OMjRj6j07oCEOVTquGO1qFYXxy1XvyLgRXhOMv7B/OhbZbgtPsw9gFwd1D7YBQSRH4F
         EVkBwDdJV5Gzegu0E/MV/fztUe+LBFRAUgq58rdCy767/vUbt02dcLrd0ATI4ibZc3AM
         8hluEOAvA6br6+3UyzVP7s6kTDbf78BNguWrUs1opz1P7+su76qBu1ToVn6P8e4UKWH3
         /l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wteh+NFEi1GAsB9oF3PCiWMRRI+co3r9IDe7/2rAE34=;
        b=v+tpHOz/IoKJR+jjW3s9DPogzlNab/GHIO4tvreTOJGe7pz8nkLszdiaX5pYpyeoOB
         mjDuGOTj/zlCU/sgM8VHthiV+H4xwWL00tF6kTRtxY7vBGvRMVqOxQsexM8n8z/xlakj
         VQHlUFEgYVsZYVG0jR/Fcu2VAZH7TVTqUPaHol84+DBwyjLqOVwRvrCsfQBgcK7I7L1n
         7vPBe4cltE9/OnC7TdW+c9YrUBnm2N36fdjzKD2iOZPtVLrprD+Tx1v4/GE/O9XGduR7
         44QYnXnQB1mBhK8vpni5JCPULH5hJg113Xn+L+HqC6PjkEmks98pFErHvlHWLsm2RvQZ
         Jemg==
X-Gm-Message-State: ANoB5pnXKptbAo+DvbCVvEXVyjQxcs4vOkcIa4L8wTq+bENPg8IjvWjb
        pkxmedbLwWnTAHEzN+IM/vsz4XvbM0Xh9eVgOcCAF1XqkGDMJIB3mJs8dyaQA71WMX8+Bt/dW/u
        IftkB5IWv+NOpto5it0BR6SY6ONARVF3BwUsrAG8HKpt/1a9r2TjeryMDLp5GcKzptYVHCUCXl8
        vznS6i12g=
X-Google-Smtp-Source: AA0mqf6V5BCoS8nuaZkX6AKXJwgdSPrsb9yINktEj3ef0TIf06GgqLN7xzlorDuSHRHkCtTI+xWz5xk/yNS8Crmgvg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a25:74c1:0:b0:6de:47e2:e344 with SMTP
 id p184-20020a2574c1000000b006de47e2e344mr3355252ybc.450.1668708709870; Thu,
 17 Nov 2022 10:11:49 -0800 (PST)
Date:   Thu, 17 Nov 2022 18:11:27 +0000
In-Reply-To: <20221117181127.1859634-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221117181127.1859634-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221117181127.1859634-3-dionnaglaze@google.com>
Subject: [PATCH v2 2/2] kvm: sev: If ccp is busy, report throttled to guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Gonda <pgonda@google.com>
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

The ccp driver can be overloaded even with 1 HZ throttling. The return
value of -EBUSY means that there is no firmware error to report back to
user space, so the guest VM would see this as exitinfo2 = 0. The false
success can trick the guest to update its the message sequence number
when it shouldn't have.

Instead, when ccp returns -EBUSY, we report that to userspace as the
throttling return value.

Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: John Allen <john.allen@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Gonda <pgonda@google.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/kvm/svm/sev.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3ced06c6e07a..81e4862126fb 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3335,7 +3335,13 @@ static void snp_handle_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t
 		goto unlock;
 
 	rc = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, &err);
-	if (rc)
+	/*
+	 * The ccp driver can return -EBUSY if the PSP is overloaded, so
+	 * we offer that as a throttling signal too.
+	 */
+	if (rc == -EBUSY)
+		rc = SNP_GUEST_REQ_THROTTLED;
+	else if (rc)
 		/* use the firmware error code */
 		rc = err;
 
@@ -3368,7 +3374,7 @@ static void snp_handle_ext_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gp
 	if (snp_throttle_guest_request(sev)) {
 		rc = SNP_GUEST_REQ_THROTTLED;
 		goto e_fail;
-	}
+       }
 
 	data_gpa = vcpu->arch.regs[VCPU_REGS_RAX];
 	data_npages = vcpu->arch.regs[VCPU_REGS_RBX];
@@ -3392,7 +3398,14 @@ static void snp_handle_ext_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gp
 
 	rc = snp_guest_ext_guest_request(&req, (unsigned long)sev->snp_certs_data,
 					 &data_npages, &err);
-	if (rc) {
+	/*
+	 * The ccp driver can return -EBUSY if the PSP is overloaded, so
+	 * we offer that as a throttling signal too.
+	 */
+	if (rc == -EBUSY) {
+		rc = SNP_GUEST_REQ_THROTTLED;
+		goto cleanup;
+	} else if (rc) {
 		/*
 		 * If buffer length is small then return the expected
 		 * length in rbx.
-- 
2.38.1.584.g0f3c55d4c2-goog

