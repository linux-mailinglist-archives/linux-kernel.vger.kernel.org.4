Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C983867DC68
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjA0CxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjA0Cw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:52:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED273A94
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:52:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bk15so10174072ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StelL4wsO29LR8nB0aGR0Fd/rNc2KxKHeacoJZC3JEA=;
        b=rJPQ1b6n0TTbKa5oK/yEhAGlz4YH8SVPWpbWnyQ3ZOZ+zg7bHARRXawA87PyJNj8Yy
         QlezLMi1bWPLnqdnvRqG1xVJRLKrMVQkd8DkzwY1wmLwJGf2SUiRqxctW8Bn/A+Rvz71
         T/MPOQGcE4oUcTGpkKa7tNoexZ17HV57voQOykxUUTBFIwKNV1AkG5T3ffe4LGuCyIha
         g5aEIEE051Id2bzB9KSImREqwJFuwOWMRW1Xr5GCByxoFOBAJuk431jxI+2EJNJKZy+2
         1KPFa0p2umXyjVRwvZlQNj8TMOD+7B3vrNRj2JfNMQY/soM1x9VEWyfOWX1V97YNBg6p
         FXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StelL4wsO29LR8nB0aGR0Fd/rNc2KxKHeacoJZC3JEA=;
        b=8BKD76dBQ09osNIiTdQOa1oODZTaMD7OrUb7CDBvdVOFRCc82tjlYlTMLC/5ppKjCG
         XmXOX37NL8qftK8pYsj+oswXyyVkzmak8TMoQ75PF/vRW4TnysgZThSrzp/jQD09e/nm
         X6w15/5NC0F5hS8IRsp+/PjKbLt+gdRVGLwBVpXDaMIk8qMK00HASGxrrBZTUGTpvlRg
         G/mY8wd8cnmPi8HxQCfF8Aj1rWlt+CE3NVd0gEbNtD1bjeKHdcmiynztMrccfuyzza+3
         81aX4tbGN6++mLMpsp+AUX3j7IdVQMSEYp37yc1QnwAMvffIh/MVnk3q8MRwldw+IqZA
         UmEw==
X-Gm-Message-State: AO0yUKWy8bJAmXaSL6prAxtXpYUolDRNlhCXPpJfoXryuEMdmKB6mLO7
        fmD9+jbPslNTDZy8VH8KXqrk2Q==
X-Google-Smtp-Source: AK7set8X1Dv3Pb3VVVFTanpM/yt9cJ2b7ru1LxBQY2X1BhqvYX8iVppND7RNqHfvHs5TfePKFulUeA==
X-Received: by 2002:a17:906:6582:b0:878:61d8:d7c2 with SMTP id x2-20020a170906658200b0087861d8d7c2mr4346366ejn.39.1674787973865;
        Thu, 26 Jan 2023 18:52:53 -0800 (PST)
Received: from localhost (88-113-101-73.elisa-laajakaista.fi. [88.113.101.73])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090658c600b00878621bd86bsm1452083ejs.164.2023.01.26.18.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:52:53 -0800 (PST)
From:   Jarkko Sakkinen <jarkko@profian.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Harald Hoyer <harald@profian.com>, Tom Dohrmann <erbse.13@gmx.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jarkko Sakkinen <jarkko@profian.com>,
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH RFC 5/8] KVM: SVM: fix: Don't return an error for `GHCB_MSR_PSC_REQ`
Date:   Fri, 27 Jan 2023 02:52:34 +0000
Message-Id: <20230127025237.269680-6-jarkko@profian.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230127025237.269680-1-jarkko@profian.com>
References: <20230127025237.269680-1-jarkko@profian.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Dohrmann <erbse.13@gmx.de>

There's no reason to return an error when encountering an page state change
request (PSC request) because that's normal behaviour on the guest's part.
Instead 0 should be returned to cause a VM exit so that userspace can handle
the page state change request.

Link: https://lore.kernel.org/lkml/Y77J7C2E9Xd1QcmZ@notebook/
Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d76127f1499a..899c78d03c35 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4068,7 +4068,7 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 		vcpu->run->vmgexit.ghcb_msr = control->ghcb_gpa;
 		vcpu->arch.complete_userspace_io = snp_complete_psc_msr_protocol;
 
-		ret = -1;
+		ret = 0;
 		break;
 	case GHCB_MSR_TERM_REQ: {
 		u64 reason_set, reason_code;
-- 
2.38.1

