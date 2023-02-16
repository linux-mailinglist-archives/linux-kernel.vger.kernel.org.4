Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A169990C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjBPPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:40:13 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC38252A2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:40:12 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jk14so2403436plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dckOt9ZcX3PBA7dkA4NwToXQbFSTM3HdmIxpC2CHEx4=;
        b=SUuT3baKGqj/B16sQzWVhF0tjHQKfms9VZGD+WjuO36OsuaSh7+WjyDOo+bAWJzfrJ
         uZ3//iMlKj9mB6z4VYu8pW7ClECgdkx1roDBTvkjmsN/3/cIV1OMt1kOgkPVtkUfJE3N
         RASXvWPlRvWntkgi5HO0Ye1XoedAjkY3JBO4eHkmcvuXMbtyuZPjCNNdFSzWXRDzF5q0
         b66EbxOKorT9apZ7d2jlViVQklpGd+GfANyvuNHhnhghbY7SaRzfDiy8IR6BF/WroZI2
         8SZ7EghKlHHrMVn7SXjiclXB+m3LUmQhAjoLwSK2uJwQoKukbBGcVu0k//FMi/JYzDyQ
         HHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dckOt9ZcX3PBA7dkA4NwToXQbFSTM3HdmIxpC2CHEx4=;
        b=vHbP80IAJG4lIRA0nGMCLzHzZ/gXhIMdjUGuK/NS+4tDHBiAH5hfVd1hPipcb+n7Vn
         kIjN6BC5daoBV3SD/39LTf6uc3HR6lhTrwNDQTro9YyVvDCYO+ka+NnIn8IoaHyL/C7f
         kT/9cNPz7j9RUX0I7KYkHfxDBWIA59OGg6kD+xB4PYjMm6Kb6MgLSuRHBvkaYm6kGoSR
         Kp8/dDO5rLFLGyXriV6ifQCKrdqXkzMi+4x8JTj3EIuqhw7ooC2f/Lv0KBkFLJSgKSdY
         KoE5Zsvht6S8C7adf67V2dHwxVossTMBXBHKzdyQTQVEsHVETYcfSbms870YlwVXT2Jh
         5DyQ==
X-Gm-Message-State: AO0yUKXmjZ2oXnUQUWeh2Xa9swnYox2nal6lTLxdR7kZaExjzWRJ05Xv
        spBmH6wpZXEP6/rzAIOReFFB28BaFW8=
X-Google-Smtp-Source: AK7set/XqpIhCR7j8BMd2RQ9Ula/mGwPCwieixfJI/WKtIm/kACaG+6hUlNZUS3qS7saWkTGLrnLiQ==
X-Received: by 2002:a17:902:e5c3:b0:19a:a80e:a6d5 with SMTP id u3-20020a170902e5c300b0019aa80ea6d5mr7406336plf.23.1676562011281;
        Thu, 16 Feb 2023 07:40:11 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id bi12-20020a170902bf0c00b00194c1281ca9sm1468078plb.166.2023.02.16.07.40.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2023 07:40:10 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V3 00/14] kvm: x86/mmu: Share the same code to invalidate each vTLB entry 
Date:   Thu, 16 Feb 2023 23:41:06 +0800
Message-Id: <20230216154115.710033-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

FNAME(invlpg) and FNAME(sync_page) invalidate vTLB entries but in
slightly different methods.

Make them use the same method and share the same code.

Patch 1: Address a subtle bug reported by Sean Christopherson.
Patch 2-6: Add FNAME(sync_page)
Patch 7-14: Refactor code which uses FNAME(invlpg) and finally use FNAME(sync_page).

Changed from V2:
	Convert the address type and fix subtle bug
	Check mmu->sync_page pointer before calling it
	Fix the defination of KVM_MMU_ROOT_XXX

[V2]: https://lore.kernel.org/lkml/20230207155735.2845-1-jiangshanlai@gmail.com/
[V1]: https://lore.kernel.org/lkml/20230105095848.6061-1-jiangshanlai@gmail.com/

Lai Jiangshan (13):
  KVM: x86/mmu: Use 64-bit address to invalidate to fix a subtle bug
  kvm: x86/mmu: Move the check in FNAME(sync_page) as
    kvm_sync_page_check()
  kvm: x86/mmu: Check mmu->sync_page pointer in kvm_sync_page_check()
  kvm: x86/mmu: Set mmu->sync_page as NULL for direct paging
  kvm: x86/mmu: Move the code out of FNAME(sync_page)'s loop body into
    mmu.c
  kvm: x86/mmu: Reduce the update to the spte in FNAME(sync_spte)
  kvm: x86/mmu: Use KVM_MMU_ROOT_XXX for kvm_mmu_invalidate_addr()
  kvm: x86/mmu: Use kvm_mmu_invalidate_addr() in kvm_mmu_invpcid_gva()
  kvm: x86/mmu: Use kvm_mmu_invalidate_addr() in
    nested_ept_invalidate_addr()
  kvm: x86/mmu: Allow the roots to be invalid in FNAME(invlpg)
  kvm: x86/mmu: Remove FNAME(invlpg) and use FNAME(sync_spte) to update
    vTLB instead.
  kvm: x86/mmu: Remove @no_dirty_log from FNAME(prefetch_gpte)
  kvm: x86/mmu: Skip calling mmu->sync_spte() when the spte is 0

Sean Christopherson (1):
  KVM: x86/mmu: Sanity check input to kvm_mmu_free_roots()

 arch/x86/include/asm/kvm_host.h |  17 ++-
 arch/x86/kvm/mmu/mmu.c          | 201 ++++++++++++++++++++----------
 arch/x86/kvm/mmu/paging_tmpl.h  | 209 +++++++++-----------------------
 arch/x86/kvm/vmx/nested.c       |   5 +-
 arch/x86/kvm/x86.c              |   4 +-
 5 files changed, 205 insertions(+), 231 deletions(-)

-- 
2.19.1.6.gb485710b

