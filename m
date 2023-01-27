Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312B367DC61
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjA0CxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjA0Cwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:52:54 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDDC19F1E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:52:50 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vw16so10105191ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ndi8r0k5qmI5H0mD72hydSKAWjCqri28uGHpAKNsfwI=;
        b=J+MEjZcEMAozPoJMzOMGFuLh/rXFwKnSkJCp7M6wYzV1qCJ411aGKRONcTDWmZnpQt
         60GCM69y32AM+8403zNk7TEwhFLcnZy+uTOYTZ1csLL8Fazp3sJQ5I7pPU6hL+Ma0CoL
         XooGUzX2iRIgrCoeTjE/d35TENVosv26T/K+nOae75Yw6bkPgRzg2pEemK9qr7oQ8DTK
         pWncSuCGRMmjNPAdPHAo+UypK/FBOhv2CuKtDMpKEIi9jjJqnfewmFdXlqd0s/H2lIGT
         4dzc6RYV6rxqX7ECkEfB/AjYfGeLoIQrLco7rH3EKPXErc10gO2zX0k4r4GFrQwq698Q
         ZSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ndi8r0k5qmI5H0mD72hydSKAWjCqri28uGHpAKNsfwI=;
        b=sdRhWO/ZC7muirQy7A30sZFcHqav4rV0SwJwGierv6Gi1K4bfAGVDVRCqFtUx/idQO
         G1Dp3U5xGhWA1ZEHWXZc0XWKOelhg3bSqD4pwQkYtWc49+uVw+3yS2CgGu2qsWwwZ1Xh
         /dZ8lbb7pgVvzAjIxW0PiUDMhKeX5WB/zFskaQDZSH5e2zXVOyAYTny+riYLKyP8Yp/v
         uyWcGgFooXqIhUdzva85XvK2wq7viCCcYNjHn9GmkGH2HTQlZOfHtIy4qdNOVWTFJ7Lq
         ZWFv1KeQTv/F7Wo2Pi99crS3PwNCG3IKtitFpyM/rcOpPlRhCLUy9WbtaMa4AKT6WnOt
         sqGA==
X-Gm-Message-State: AFqh2krrJWdGpSCphW6Yn2GYkBV7V89mfrSkyF8Eu+3Kj59q8JEIocMz
        D0vdO3iMUDpG8qcoCxWrnR1ixw==
X-Google-Smtp-Source: AMrXdXu57VRGjXM7FMcpSFGz84LKNvBjg3pMXc2fVdX3CF8xPg1MMVN07PY+9CCaJ4FuB43Vd0BIVA==
X-Received: by 2002:a17:907:8c14:b0:84c:e9c4:5751 with SMTP id ta20-20020a1709078c1400b0084ce9c45751mr41792387ejc.74.1674787968997;
        Thu, 26 Jan 2023 18:52:48 -0800 (PST)
Received: from localhost (88-113-101-73.elisa-laajakaista.fi. [88.113.101.73])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906945000b0084d46461852sm1432144ejx.126.2023.01.26.18.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:52:48 -0800 (PST)
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
Subject: [PATCH RFC 2/8] KVM: SVM: fix: initialize `npinned`
Date:   Fri, 27 Jan 2023 02:52:31 +0000
Message-Id: <20230127025237.269680-3-jarkko@profian.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230127025237.269680-1-jarkko@profian.com>
References: <20230127025237.269680-1-jarkko@profian.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Dohrmann <erbse.13@gmx.de>

If UPM is enabled and getting the PFN fails, `npinned` is never set, but is
read for the call to `unpin_user_pages`.

Link: https://lore.kernel.org/lkml/Y6Sgwp%2FBofzCUrQe@notebook/
Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d3468d1533bd..6d3162853c33 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -510,7 +510,7 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 	unsigned long npages, size;
-	int npinned;
+	int npinned = 0;
 	unsigned long locked, lock_limit;
 	struct page **pages;
 	unsigned long first, last;
-- 
2.38.1

