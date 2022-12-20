Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62D6523BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiLTPep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiLTPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:34:39 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8501AF3B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:34:37 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 38-20020a630b26000000b004773803dda1so7397859pgl.17
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFWkgUzHga/e5JHoMlfzC+mErHa+mSIMGGohb+jRGNo=;
        b=fi7fXpoGUB+Abb4BxUCuSzcg9/bZWNR15BAEfaXLucXwwrahK1PJ697VeDtiRT4SDW
         1KZjgyicGKoWPnFA1A5xjVMowe+BbXe1aYE0cbAqSydDf2ZKkB9IImY26fl6v0sw0mcp
         n/HMxH8Ir5eo/6xTYmdSvrfa5hWCT9ChexUnI54r9i7jnnJK5g2QOLQ1qybAzIMBXfc+
         J+dUFEhSzcNy40FlO/YyaXiwGAxt9Ex7ZKlubMfs7E/swYdGTH0sW4OylwZh4v/SE1/c
         GmgSlWBhlH1gSuOPHDAPmJuXzEyV87lM3KR62lW72dtSbS72cqbYempUuPLdRw3fUhJD
         Dllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFWkgUzHga/e5JHoMlfzC+mErHa+mSIMGGohb+jRGNo=;
        b=DNNRdqeT2Lp3flEy+1fh8Edo1K4BKlAHpdKyAmOKtma/uK0Lz1/cYvJeDlgLVczsEp
         SZnwxSzx8Xvtx3LciBSe8+rEbyu/XXfbJWE8LGVki1mZ1tNn50OkChKVfjBWANpjrFTv
         IvYLrk3fP1AA4rnhzB2uB1kplySGeU3TA2TyurY3qosKXHu7OHLhef/DXBqZAGOvOyd/
         DbaN225apr5+tp2JoQ3q1fLV0B5OrjaSrEOvnLAroHcrW5rxfPZQMdb66Ek1mlDd/TQB
         Ztr5hWszdNLy4JpxDe8eNLNdws/80METr8cz1H0+TubX7Lge3M01XfYOc+min58EwmAS
         8knQ==
X-Gm-Message-State: ANoB5pkWp4+m3+xqtdWJdeAziAalAHGSMG621enVU4cqb/3vuiegEAqC
        /cB9VHNEtk7up9gi8konGRlkxQ/C04Y=
X-Google-Smtp-Source: AA0mqf6qTu63JLlBKDJPaqZlXXwD4ay4Xx0F3GWmKRs52hOMT92vTE2a0VAU8MbZURY6+FipY1ueZiaNCIY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2350:b0:189:8ea3:7455 with SMTP id
 c16-20020a170903235000b001898ea37455mr51904343plh.19.1671550476739; Tue, 20
 Dec 2022 07:34:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 20 Dec 2022 15:34:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220153427.514032-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Sanity check inputs to kvm_handle_memory_failure()
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

Add a sanity check in kvm_handle_memory_failure() to assert that a valid
x86_exception structure is provided if the memory "failure" wants to
propagate a fault into the guest.  If a memory failure happens during a
direct guest physical memory access, e.g. for nested VMX, KVM hardcodes
the failure to X86EMUL_IO_NEEDED and doesn't provide an exception pointer
(because the exception struct would just be filled with garbage).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 312aea1854ae..da4bbd043a7b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13132,6 +13132,9 @@ int kvm_handle_memory_failure(struct kvm_vcpu *vcpu, int r,
 			      struct x86_exception *e)
 {
 	if (r == X86EMUL_PROPAGATE_FAULT) {
+		if (KVM_BUG_ON(!e, vcpu->kvm))
+			return -EIO;
+
 		kvm_inject_emulated_page_fault(vcpu, e);
 		return 1;
 	}

base-commit: 9d75a3251adfbcf444681474511b58042a364863
-- 
2.39.0.314.g84b9a713c41-goog

