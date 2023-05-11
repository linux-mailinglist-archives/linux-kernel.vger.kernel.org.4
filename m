Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F496FFD90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjEKX7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbjEKX70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:59:26 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2077693
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643aad3bbf3so4667212b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683849564; x=1686441564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MEk4ljfjUrhYUrSteJqpKxRY6vJbyA6fFCK+rB7er/I=;
        b=ZTKfWcodlx+iAl7zxea0FMeNu6SZzfQ391F9NdQdcDalTF810JiIW+11fnDFvCxftW
         YOTk1GcXRemaIFDnJKfDJ/9ZIhmJ1DrnF7eQkl4olnIjpXECV+zr50SHuMQjl8aUvgZf
         V2fsmPRUBzHwTR28iFSim2t7wgW2DeJxeoZka9mF7A6lBburlYrEB+VUaTAW13EZVAUY
         I3HBUF6UkvWU1AI/DxsLzCDqlR8HVMF7IeVpF+zjpJdMHrOJQT9gAIhHybKb761iF4U5
         mvM430WKhXJFE/Yk9hCXHdfFvsdG422kHWf3cMn8wRH80p2g8sdw43iZxtoogclofmgg
         lQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683849564; x=1686441564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEk4ljfjUrhYUrSteJqpKxRY6vJbyA6fFCK+rB7er/I=;
        b=NfAUNdb+455EIfdBilzvnxmb02y2Gj1jy/vyXocZGDYRqjyvg0YzJJbPVfIZ7RyRsQ
         imuKuejTJJIg48xprHwCQPemtVqyze5AazWQ8sP9zGU4W3EwC4B4+cFOlzVqbAuI7Pq2
         JKSnYfxK02hRtpaOqW6VUdpqPs5DxYm/u3ZeQar299PzX6OfVimeteotOLbw+tYSFvd2
         vJVxzVoEllmRjffwWfy/c4twwkLIOC7Fdr0wuU7O4upl5RO7mJpTKqY4BQiN26Mo/rBt
         z8nQphORgWKiF/n335cZdzPK82hahXFLfNk2iWyFsrf7eyOaCUpDs744Hoi/q3wm2iQp
         GBwg==
X-Gm-Message-State: AC+VfDy+3Mwuu4V9DN5tgu4X/PFCQXUcOB3t3Oz5aMbiXnNj//QJYxDw
        A3yjTa3ZVMuICSxPNSqJFqQVMe8vEvk=
X-Google-Smtp-Source: ACHHUZ5l3rRuanjYbp1RV2ouAwFxf1cJNWLF+jyC0+yqQArFREl4t0+hRDySD9cYAS6UIzzTM7dmmv4jZPI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2cf:b0:643:4b03:4930 with SMTP id
 b15-20020a056a0002cf00b006434b034930mr5941851pft.0.1683849564339; Thu, 11 May
 2023 16:59:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 May 2023 16:59:11 -0700
In-Reply-To: <20230511235917.639770-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230511235917.639770-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511235917.639770-4-seanjc@google.com>
Subject: [PATCH 3/9] KVM: x86/mmu: Delete the "dbg" module param
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>
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

Delete KVM's "dbg" module param now that its usage in KVM is gone (it
used to guard pgprintk() and rmap_printk()).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 5 -----
 arch/x86/kvm/mmu/mmu_internal.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f6918c0bb82d..2b65a62fb953 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -112,11 +112,6 @@ static int max_huge_page_level __read_mostly;
 static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
 
-#ifdef MMU_DEBUG
-bool dbg = 0;
-module_param(dbg, bool, 0644);
-#endif
-
 #define PTE_PREFETCH_NUM		8
 
 #include <trace/events/kvm.h>
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 9c9dd9340c63..9ea80e4d463c 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -9,8 +9,6 @@
 #undef MMU_DEBUG
 
 #ifdef MMU_DEBUG
-extern bool dbg;
-
 #define MMU_WARN_ON(x) WARN_ON(x)
 #else
 #define MMU_WARN_ON(x) do { } while (0)
-- 
2.40.1.606.ga4b1b128d6-goog

