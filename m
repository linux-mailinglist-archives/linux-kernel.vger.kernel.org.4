Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E02734483
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 02:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjFRAJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjFRAJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 20:09:22 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1521715
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 17:09:21 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-25e89d51bf2so954846a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 17:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687046960; x=1689638960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kxL2IQh8QsyzT6M8Esvdn0S5tsYGjEEcYbokMBIJOOA=;
        b=zAN4yl/yAf39StZnUGptrfSOQsv6LlI7o2HkFCAMqcoRQjjCgZ3r19ALi5wJn9JDPy
         u6bIXwRmOwOC838v8rtUVWtWyBTAhG48OwwangQhrI26phyUC36Mvw7FPmof3d4i8thI
         HskS9RE2wxly89AwCkzpOj3R7prtSydMxkqZ+ZJoQqCLhsVvoRJvCeU+kw56/h1Tq95V
         7xTx0H2mqfVUQNCwvin9J+4qUr0oZUX9SHG46zY+WPcusQv2dEzJTLeI1M/Uezu0MucY
         L0UArTP0fH+mSE7lERHIcQo2OODhzgmX1Azw0C2c/LZKL+qteyd4lSCgMSMmgLFAuRQz
         TPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687046960; x=1689638960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxL2IQh8QsyzT6M8Esvdn0S5tsYGjEEcYbokMBIJOOA=;
        b=e8V4GWiODzNCxvtIYfHozOaCNaSunfr9yFN6YT+EIOu59SkObewqDsR7vc81lzxdue
         4hnTnUW86mbYRB0PFAJgRrKqTUVGtJ9Js/Tzy7R77jkCB5t/CdMyKMWvN9kkkdACuYkU
         Woil14VVURJ2yig/c7UTGO0BL30ztjdGYQPUpD+rlvBGqyzRcs1jgEie7iFz3ljungxv
         BgDJvojlzH2VDVcTsvwIoT2MayuXYXAkTUSIMBeGLuVktEpaHAlmzkic+OYQS9X50yl5
         /XFbBCcNsOvrNzbd27cOKfykGwSJJNc43mn1JYITIoOj4UlK1iEm27xQDfP9w/SF9HKd
         lt2A==
X-Gm-Message-State: AC+VfDwvTpihndxAD6OIIpZIOopQNPKsggGblthVZI+yMNMM7Dt97JO5
        29cumViPryLj1sXFAjlrLcZWrPKR0Sgv
X-Google-Smtp-Source: ACHHUZ667rmHgnnVMFyiOS98UlXH2hDjVOn68VnJ+dNKWA2D/uGC0vcKPrekHRymKGd05CoJKmuP1cPxyqdg
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:1a15:b0:654:8eb9:4607 with SMTP id
 g21-20020a056a001a1500b006548eb94607mr1818385pfv.4.1687046960661; Sat, 17 Jun
 2023 17:09:20 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Sun, 18 Jun 2023 00:08:55 +0000
In-Reply-To: <20230618000856.1714902-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230618000856.1714902-1-mizhang@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230618000856.1714902-6-mizhang@google.com>
Subject: [PATCH 5/6] KVM: Documentation: Add the missing mmu_valid_gen into kvm_mmu_page
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmu_valid_gen into kvm_mmu_page description. mmu_valid_gen is used in
shadow MMU for fast zapping. Update the doc to reflect that.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 Documentation/virt/kvm/x86/mmu.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
index 3dce2426ad6d..0dbdb7fb8cc6 100644
--- a/Documentation/virt/kvm/x86/mmu.rst
+++ b/Documentation/virt/kvm/x86/mmu.rst
@@ -208,6 +208,10 @@ Shadow pages contain the following information:
     The page is not backed by a guest page table, but its first entry
     points to one.  This is set if NPT uses 5-level page tables (host
     CR4.LA57=1) and is shadowing L1's 4-level NPT (L1 CR4.LA57=1).
+  mmu_valid_gen:
+    Used by comparing against kvm->arch.mmu_valid_gen to check whether the
+    shadow page is obsolete thus a convenient variable for fast zapping.
+    Note that TDP MMU does not use mmu_valid_gen.
   gfn:
     Either the guest page table containing the translations shadowed by this
     page, or the base page frame for linear translations.  See role.direct.
-- 
2.41.0.162.gfafddb0af9-goog

