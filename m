Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2C273E7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjFZSU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjFZSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:20:22 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256CBE72
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:20:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5343c1d114cso3100848a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687803620; x=1690395620;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLkOqFBqzxISaAPXvkquQKhRu0SdyzbY5DGmTu4+Hvw=;
        b=AYDUYzQpWi8ajKHoe59FrRLQcfX/0p6LyRw367BPktD9D6lnOb3ggKrmdSCgKBi35f
         1WrnyOjRZC+OnT/6I/RarxYLT3B7KfgFElgegoeA3LeqPq/Ckz1KV15KMCHOosBcbj5G
         XuQguKctQn4dMmKjBsjnwXsJar/f7rQbE+U4uTdpzcQ2EDg1N2e8/9peRSVqe4X+3j/T
         1mtOJSx4ozdN26yxXROVYb3WWwdq5tlUiFpIBvac8c+boS2JsRmgmmRYwO6RDl5/TaFX
         DDds2TfDedx07LhtvT0sCvr6VsdD9I9m9i/kGl0qAJZ132DJbzL64h8Yns9HKVxqN3pE
         HXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803620; x=1690395620;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLkOqFBqzxISaAPXvkquQKhRu0SdyzbY5DGmTu4+Hvw=;
        b=jDobbu5WqQkoC7EDa5oHKrkMnQ30B0gXF6fJ9iNYNBgm5laJ9WeUYnRUMWjk/HHmsQ
         gEgU/A/yAHLwxTcmRvTFdV09syUf37nhNFwCzRK6d7oujT8D3GtZYwApxLLqg8/Z2Fra
         8iqAoN4v8i7Colk6QS5wPbCRGxxGp5upu6WSG0dBDrmblvS3BoYMe6pXHx5y58sdSp5l
         IePhKEXnNx8ofo5Rs+CM803LBKNXQ8AU3TUNdGG0bFKoRCDKYUMQ4DWCFAbLwSotEYZz
         XEv0jHUemOg/W9XLC2S+Pq5TGVjn8j1A/RpfUjCdc4LqebV41VBf/Os4VkzWfpUzAzqU
         Yn6g==
X-Gm-Message-State: AC+VfDykswPDMGAbeyRHtceLVu3mFYvieYcfYjfysjOJucmdVdcVqGSq
        GoSR2oxo+XKkY3eHC0zamFgAQ0TJV15t
X-Google-Smtp-Source: ACHHUZ7keLSbAZ3MaL4XmHCyaZDIRrGlvoU983qhxl3+1WfiiduDVXrP04RaUv8dDRVC917/rpxbniEtJ+DP
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a63:2218:0:b0:530:8673:a183 with SMTP id
 i24-20020a632218000000b005308673a183mr3772554pgi.4.1687803620605; Mon, 26 Jun
 2023 11:20:20 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 26 Jun 2023 18:20:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230626182016.4127366-1-mizhang@google.com>
Subject: [PATCH v2 0/6] Update document description for kvm_mmu_page and kvm_mmu_page_role
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, Xu Yilun <yilun.xu@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 2nd version and I made some changes according to feedback:

v1 -> v2:
 - Update the shortlog and commit messages [Zhi].
 - Refactor the description in mmu.rst [Yilun, Kai]

v1: https://lore.kernel.org/all/20230618000856.1714902-1-mizhang@google.com/

Mingwei Zhang (6):
  KVM: Documentation: Add the missing description for guest_mode in
    kvm_mmu_page_role
  KVM: Documentation: Update the field name gfns and its description in
    kvm_mmu_page
  KVM: Documentation: Add the missing description for ptep in
    kvm_mmu_page
  KVM: Documentation: Add the missing description for tdp_mmu_root_count
    into kvm_mmu_page
  KVM: Documentation: Add the missing description for mmu_valid_gen into
    kvm_mmu_page
  KVM: Documentation: Add the missing description for tdp_mmu_page into
    kvm_mmu_page

 Documentation/virt/kvm/x86/mmu.rst | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)


base-commit: 0b210faf337314e4bc88e796218bc70c72a51209
-- 
2.41.0.162.gfafddb0af9-goog

