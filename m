Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3905267DC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjA0Cw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjA0Cwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:52:53 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065F12588
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:52:48 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ss4so10141182ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvDB910gEnDe36r/d/OlU/tDXP9cfG+XamOvClg0hhM=;
        b=BzSw5d6UEYdPaSMNL7TRDHRg+ZiCgJhM58Jauidl5iIaudeSgClPDXxx846FiEkusi
         k/9e4Ovl0cC2wEel4w44fQzwZaTO1P+Cm9ceYmOPGj03Zru3OuNZ9RoYAbqURRXt3xuB
         yzvpdv6WE6a1KiwnKep0F2tB7jwUwAg/RE/EK707Mxc0TqfXsE251OjEGdpMdoni1sPR
         J7HzYf81LXJhDwM/5QypcRYkpA5JlXwP3PZ2Gyf2cyRUNw2x5q5pmlQXjy/oTIks+qh+
         AWCTCnJhGP6LLtDorft9W+u7/V0EmZRUZckUUKBbiSu7MCr0eoUu/BC8JaT+eEuppzNO
         jL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvDB910gEnDe36r/d/OlU/tDXP9cfG+XamOvClg0hhM=;
        b=yPr3gcQWrsGKFhjOc6no1GLudNq1Jb1aqAHdV85oWYohLJ6UMXO1YJIfKgsNKtDyJR
         1SdfR/nb15B/0vSgmZF3f/qjr2WE+53yvEc6urmjsKJr4NcwVXQkqiulxq/+7SWtFaO+
         2gTieR/QnKcqEcBci7FJnQy9rJZlpjcLp1bygFI+dnN6jUoIxh6jF3GiV/HtueKQkeH/
         xuDafivUD/NI/SWLgFExLyu9KTllFkXDUVegx2GuZRPyj7XYjC/ZDovSQU+LFBqF3zQS
         mM0whV1GKoJ5aRGi0tRuFYeWULI1w3AHcbS3LFyH8cl/AOA9zLTez2WeGdBLcZfGhCBq
         ulHA==
X-Gm-Message-State: AFqh2koMBIxJhY77O73qM8wZvkT0BKjuqSfP1vLjoiStUdnKOWU4JioF
        kmOtVbvNbOoZV49P+tU2qeJi7Q==
X-Google-Smtp-Source: AMrXdXsspIeDg5UBSefPlJ9BA3aTdIjSp6b+qGoQ7eX8kyEz4T9uIsYKYt+oGstAiBvvqnlrjFh5og==
X-Received: by 2002:a17:907:7248:b0:872:b1d7:8028 with SMTP id ds8-20020a170907724800b00872b1d78028mr53553920ejc.3.1674787967402;
        Thu, 26 Jan 2023 18:52:47 -0800 (PST)
Received: from localhost (88-113-101-73.elisa-laajakaista.fi. [88.113.101.73])
        by smtp.gmail.com with ESMTPSA id fp35-20020a1709069e2300b00878683acac3sm1448899ejc.112.2023.01.26.18.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:52:47 -0800 (PST)
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
Subject: [PATCH RFC 1/8] KVM: SVM: fix: calculate end instead of passing size
Date:   Fri, 27 Jan 2023 02:52:30 +0000
Message-Id: <20230127025237.269680-2-jarkko@profian.com>
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

The third parameter of `kvm_vm_do_hva_range_op` doesn't take the size
of the range, but the end of the range.

Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
Link: https://lore.kernel.org/lkml/Y6Sgwp%2FBofzCUrQe@notebook/
Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 855f5e702240..d3468d1533bd 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -500,7 +500,7 @@ static int sev_get_memfile_pfn(struct kvm *kvm, unsigned long addr,
 			       unsigned long size, unsigned long npages,
 			       struct page **pages)
 {
-	return kvm_vm_do_hva_range_op(kvm, addr, size,
+	return kvm_vm_do_hva_range_op(kvm, addr, addr + size,
 				      sev_get_memfile_pfn_handler, pages);
 }
 
-- 
2.38.1

