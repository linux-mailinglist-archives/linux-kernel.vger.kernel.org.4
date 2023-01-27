Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6767DC73
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjA0C7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjA0C73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:59:29 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117362E825
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:59:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x10so3598527edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AfdCkm99SUvFdMCwe3pmsh5HVt3esnvMEJqsrZ3avo=;
        b=Lw1+9lxRR1sCal3wO6yNlAF8+j0tzSaG6hT7ZAC0A3jRdh3kWNAYuNi3k9VAtAYzwz
         cRRJvKXPtkUVoLy/D4sdhQonLjdbrnM4mhrp0qX7BmIVcJz4YsvPn/shgWzCi/Kzvm3C
         zpETtZRlY4wgwyw/2mQql77cpoS9qrXsPAJOc+BhpfV2SqlFEoOfsSObsrF/5Bsa8Y+S
         mnG+KiJZf0Aa+/VD4SsSLw3xKHxqWyxTVE2W1bcgLbn1EtsmXP73vWqxmOUKsZS1wOkJ
         jddWmBuUWcevsiwNrV8QVHDtc5yDnT567smEvCwgTyrXSZe42zwVI/i3JGnOeVJLJVkO
         2buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AfdCkm99SUvFdMCwe3pmsh5HVt3esnvMEJqsrZ3avo=;
        b=ZzFfhFXsNJCnr6/JwkDkCxCJb6sOu+eySndCUwPrTz52MFtFEjn5GuYV7oPzjbVblr
         oyS+E2xl1G97kkTCfaeLEtIudGWDh321b8zLR+zdOLANPjf0N/3TXxYnA811OfhYJcw6
         YKiGIUiLkFq7bkL5HMF787sTvpxZct2pOFx1AwvJPy0xrxS1yuTJE1r3lIbIfOCOveoh
         7W34YpLDFy3EjMDTvoyqM3VjOP4rw65W3hl4/x/n8S8nAbo//djukA2rDT0jBEEW7Oba
         czFrDHyoUv4sHLT0ko63O0b1ciKIN4iVtATg7aGeHUT4tF67QywmAuIg00XSqiLxzdBd
         VGIw==
X-Gm-Message-State: AO0yUKVZezsUuKNDHuAVVwRvwTqHxr8bDCVblMgX8ur/p7Dn8jZ4ZDLz
        Srx1ZpeLkcvCHPqmOaHafr+GFg==
X-Google-Smtp-Source: AK7set+kjf7R52Itk1uYZWSVD4lmM+dajN2l5hFV3IOKd8xZCRy/syQHhhueg9DbhXmkvK6dFOjXUw==
X-Received: by 2002:a05:6402:1946:b0:4a0:bb2e:3af0 with SMTP id f6-20020a056402194600b004a0bb2e3af0mr5605958edz.1.1674788366587;
        Thu, 26 Jan 2023 18:59:26 -0800 (PST)
Received: from localhost (88-113-101-73.elisa-laajakaista.fi. [88.113.101.73])
        by smtp.gmail.com with ESMTPSA id p11-20020a50cd8b000000b004972644b19fsm1614757edi.16.2023.01.26.18.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:59:26 -0800 (PST)
From:   Jarkko Sakkinen <jarkko@profian.com>
Cc:     Harald Hoyer <harald@profian.com>, Tom Dohrmann <erbse.13@gmx.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Jarkko Sakkinen <jarkko@profian.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC 0/8] Enarx fixes for AMD SEV-SNP hypervisor v7
Date:   Fri, 27 Jan 2023 02:59:22 +0000
Message-Id: <20230127025922.270463-1-jarkko@profian.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A set of fixes that we've applied on top of SNP v7 patches for running Enarx.

References:
* https://github.com/enarx/linux/releases/tag/v6.1-enarx-upm-1
* https://hackmd.io/@enarx/HJKSlW2Lo

Jarkko Sakkinen (3):
  KVM: SVM: KVM_SEV_SNP_LAUNCH_RESET_VECTOR
  crypto: ccp: Prevent a spurious SEV_CMD_SNP_INIT triggered by
    sev_guest_init()
  crypto: ccp: Move __sev_snp_init_locked() call inside
    __sev_platform_init_locked()

Tom Dohrmann (5):
  KVM: SVM: fix: calculate end instead of passing size
  KVM: SVM: fix: initialize `npinned`
  KVM: SVM: write back corrected CPUID page
  KVM: SVM: fix: add separate error for missing slot
  KVM: SVM: fix: Don't return an error for `GHCB_MSR_PSC_REQ`

 arch/x86/include/asm/svm.h   | 15 ++++--
 arch/x86/kvm/svm/sev.c       | 89 +++++++++++++++++++++++++++++-------
 arch/x86/kvm/svm/svm.h       |  1 +
 drivers/crypto/ccp/sev-dev.c | 63 ++++++++++---------------
 include/linux/psp-sev.h      | 15 ------
 include/uapi/linux/kvm.h     |  5 ++
 6 files changed, 113 insertions(+), 75 deletions(-)

-- 
2.38.1

