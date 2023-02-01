Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6712A686F15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBATo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBATo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:44:28 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476B878ACB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:44:26 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p26so43432688ejx.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 11:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Glsk6GqDCsK8JWqYgY447JDtR2RT71OPsgo1ighXW0M=;
        b=M5+kSariHHFLd57G6JYUJC8w45gG+h+MnDfBiVK5ZKHLd8tzimsCFikYk86NLSjyrD
         lAmiHje922XfYOZuI33DBjAWsP0ZVKeGSAuGQsRFRpf7Ptb9M2ZKb2gZdX1G79k5wbYP
         mTPZBQRSlm0nIkRjmADmOcevI2yvbx/SHxx0J1j5BnkeMuyIC6XwCJlmKAgRZ4cNoC6I
         Eq2y+szd+cmuK37d0a9+xkWiGaGLeY1haLU/g4gWKVUmAOxKYKV8RTe6GZohRhlac393
         2dHCJdXE4J/6VDG6EgEr1ifjokVdliqhWfReqo4Hp6b7DW71TjozBcAjitW3pIZ9ebuE
         miXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Glsk6GqDCsK8JWqYgY447JDtR2RT71OPsgo1ighXW0M=;
        b=i+nWkqwhjdhW2ON3nvZN+FNqG+TVypyVc4Ofp9ABtjVFzbjPuoh8yhbLcFFGGrVeJF
         MEHPPzfpFmJohRWRforxlt5b8XPUDCuXMEc6XZ9igYDu50dogz9od+hB1nVcsk34wEJl
         UZQqB91eyadg55QOTB5wdq+d3hHXKylhNlOGg6U3sdic/WlDY5D/HcKgbDGvsV0eZjI2
         2as/NZnnz5KDHoCIU3Dcx/RRSbuCVkBL/ABwdhH4Z7C5CAo0HGpgmAXSKbrzQzN8AQik
         9LTpCR87/m4DnPjXYq5x/vCqo3R41zG4DuHGrPex2opdqQ49DS+Tbc1w5A1u/HLbE4ok
         ppkg==
X-Gm-Message-State: AO0yUKXhG91jxwQAAOh3vDAj3WnAbNvgSBWvSaqqW/ZH3QZSFRNm1Xth
        zrRSIG8v+ULnc3SaU9e/qbqWQw==
X-Google-Smtp-Source: AK7set8h3Jz/AwqKX5SGPy+s9WPMBP1SFKRVcLcrvfE99A9ePySNvis13Wmu8Q8TFYZiHIqLFPoFtQ==
X-Received: by 2002:a17:906:4941:b0:88c:a3f0:4e3f with SMTP id f1-20020a170906494100b0088ca3f04e3fmr3699428ejt.22.1675280664798;
        Wed, 01 Feb 2023 11:44:24 -0800 (PST)
Received: from nuc.fritz.box (p200300f6af111a00277482c051eca183.dip0.t-ipconnect.de. [2003:f6:af11:1a00:2774:82c0:51ec:a183])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b00869f2ca6a87sm10397579ejd.135.2023.02.01.11.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 11:44:24 -0800 (PST)
From:   Mathias Krause <minipli@grsecurity.net>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH v3 0/6] KVM: MMU: performance tweaks for heavy CR0.WP users
Date:   Wed,  1 Feb 2023 20:45:58 +0100
Message-Id: <20230201194604.11135-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: https://lore.kernel.org/kvm/20230118145030.40845-1-minipli@grsecurity.net/

This series is a resurrection of the missing pieces of Paolo's previous
attempt[1] to avoid needless MMU roots unloading. The performance gap
between TDP and legacy MMU is still existent, especially noticeable under
grsecurity which implements kernel W^X by toggling CR0.WP, which happens
very frequently.

Patches 1-13 and 17 of the old series had been merged, but, unfortunately,
the remaining parts never saw a v3. I therefore took care of these, took
Sean's feedback into account[2] and simplified the whole approach to just
handle the case we care most about explicitly.

Patch 1 is a v3 of [3], addressing Sean's feedback.

Patch 2 is specifically useful for grsecurity, as handle_cr() is by far
*the* top vmexit reason.

Patch 3 is the most important one, as it skips unloading the MMU roots for
CR0.WP toggling.

Sean was suggesting another change on top of v2 of this series, to skip
intercepting CR0.WP writes completely for VMX[4]. That turned out to be
yet another performance boost and is implemenmted in patch 6.

While patches 1 and 2 bring small performance improvements already, the
big gains come from patches 3 and 6.

I used 'ssdd 10 50000' from rt-tests[5] as a micro-benchmark, running on a
grsecurity L1 VM. Below table shows the results (runtime in seconds, lower
is better):

                         legacy     TDP    shadow
    kvm.git/queue        11.55s   13.91s    75.2s
    + patches 1-3         7.32s    7.31s    74.6s
    + patches 4-6         4.89s    4.89s    73.4s

This series builds on top of kvm.git/queue, namely commit de60733246ff
("Merge branch 'kvm-hw-enable-refactor' into HEAD").

Patches 1-3 didn't change from v2, beside minor changlog mangling.

Patches 4-6 are new to v3.

Thanks,
Mathias

[1] https://lore.kernel.org/kvm/20220217210340.312449-1-pbonzini@redhat.com/
[2] https://lore.kernel.org/kvm/YhATewkkO%2Fl4P9UN@google.com/
[3] https://lore.kernel.org/kvm/YhAB1d1%2FnQbx6yvk@google.com/
[4] https://lore.kernel.org/kvm/Y8cTMnyBzNdO5dY3@google.com/
[5] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git

Mathias Krause (5):
  KVM: VMX: Avoid retpoline call for control register caused exits
  KVM: x86: Do not unload MMU roots when only toggling CR0.WP
  KVM: x86: Make use of kvm_read_cr*_bits() when testing bits
  KVM: x86/mmu: Fix comment typo
  KVM: VMX: Make CR0.WP a guest owned bit

Paolo Bonzini (1):
  KVM: x86/mmu: Avoid indirect call for get_cr3

 arch/x86/kvm/kvm_cache_regs.h   |  3 ++-
 arch/x86/kvm/mmu/mmu.c          | 31 ++++++++++++++++++++-----------
 arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
 arch/x86/kvm/mmu/spte.c         |  2 +-
 arch/x86/kvm/pmu.c              |  4 ++--
 arch/x86/kvm/vmx/capabilities.h |  1 +
 arch/x86/kvm/vmx/nested.c       |  4 ++--
 arch/x86/kvm/vmx/vmx.c          | 15 ++++++++++++---
 arch/x86/kvm/vmx/vmx.h          |  8 ++++++++
 arch/x86/kvm/x86.c              |  9 +++++++++
 10 files changed, 58 insertions(+), 21 deletions(-)

-- 
2.39.1

