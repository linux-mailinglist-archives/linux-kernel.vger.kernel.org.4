Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9494A734473
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 02:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjFRAJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 20:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRAJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 20:09:13 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAE6170A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 17:09:12 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b5381523bcso13573095ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 17:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687046951; x=1689638951;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymRd0fdFh05CtNVNiLUjlDKK/2gV3v4AfyLZi4whH8g=;
        b=rMMgGNr8vOsgIkOwkRLQIIhyAjefMdQun+/xW0SYS17CmY6HzQ06lgWc6nsxtEfJTv
         Ht+YODtZPWTHujruU9N3ACex9+1Dv9mnBumypRTC2rrba1NQNUZyxoh2qvP++oAnMbOe
         FTLLemr0Z4m1wethMrX1dXSWMKUgENWDCm7hM9la9tX8ZgYuWu8nJ5eeioSr8a3YWGvE
         2FfkBIalA3Jc0giJsyLWj+lRkA2dnltrX66kqGs7FTP48zPkLEpNFf00nJy/53tnaBRA
         TH6QP/ReTgdCAU4enlYNi7Exx5f1Yojwdz8ryHo3mJ7Rqw3+6KkY56ON8inJK6Pzqik1
         0h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687046951; x=1689638951;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymRd0fdFh05CtNVNiLUjlDKK/2gV3v4AfyLZi4whH8g=;
        b=cPtQ93aL+cX/0o+A0LALXa9oM/YbMF/xsdosv/9UOKstjL+WNld29Ass3/BHe2GTVR
         0IpUl9AhPz38/2o6AIENtLQKDipSHsgNiI57O9HOq+puZSC0E3WUs0VrHDBXNPOcQjIN
         7HnHlyu4m2jAHROBLgoDMVpdCyDH/jQ01ZGWIrJZNsujkq5eN7o5+Y2N+5yyF5V5nb9P
         QOa8Z5cN9htVRpOO9DCNsJUD5fxMSgVq+vBfyNFYJHK2g71i9owg8uo+ZrP5ezgKLHsZ
         Pve1jWjMhIKO5gax3NkzP63reBKuERlb/OtEs8ZSSVLGLJaOg2554Q2blhSMWoDJ3ldD
         PGyQ==
X-Gm-Message-State: AC+VfDyCl6PDhD/P0wDYBdDl/ZVycdhb9aJTa0pbGUcUyGmdagX/2w6B
        En2IExYJWuBockE/km6LzR4/PwC6wHoJ
X-Google-Smtp-Source: ACHHUZ7GBo3wRFRwvXCrjp6qeYjQCJ/WI3qJ0vD6yL18cd/w9bx5ricJ9hcD5llEl1GlDMxTKrwzIOWwXMmF
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:902:a705:b0:1b3:ec39:f41b with SMTP id
 w5-20020a170902a70500b001b3ec39f41bmr915256plq.7.1687046951468; Sat, 17 Jun
 2023 17:09:11 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Sun, 18 Jun 2023 00:08:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230618000856.1714902-1-mizhang@google.com>
Subject: [PATCH 0/6] KVM: Documentation: Update document description for
 kvm_mmu_page and kvm_mmu_page_role
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

When reading the KVM MMU documentation for nested virtualization, I feel
that the description of kvm_mmu_page (and kvm_mmu_page_role) has been
lagging for around 1-2 years. The descriptions for several fields in struct
kvm_mmu_page and struct kvm_mmu_page_role are missing. So I think it might
be good to add them to make it consistent with the current code.

Note that there are still some fields not added in this series:
 - kvm_mmu_page.nx_huge_page_disallowed
 - kvm_mmu_page.possible_nx_huge_page_link
 - kvm_mmu_page.hash_link
 - kvm_mmu_page.link

For the above, I thought the description might be just better to be
inlined or there is already good description inlined.

Mingwei Zhang (6):
  KVM: Documentation: Add the missing guest_mode in kvm_mmu_page_role
  KVM: Documentation: Update the field name gfns in kvm_mmu_page
  KVM: Documentation: Add the missing ptep in kvm_mmu_page
  KVM: Documentation: Add the missing tdp_mmu_root_count into
    kvm_mmu_page
  KVM: Documentation: Add the missing mmu_valid_gen into kvm_mmu_page
  KVM: Documentation: Add the missing tdp_mmu_page into kvm_mmu_page

 Documentation/virt/kvm/x86/mmu.rst | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)


base-commit: 265b97cbc22e0f67f79a71443b60dc1237ca5ee6
-- 
2.41.0.162.gfafddb0af9-goog

