Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324A568DD68
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjBGP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjBGP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:56:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B236128850
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:56:17 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so12436989pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/5CduqiheNr7yH0yLOOjbHloVd5ZsvlvVOG7WqiWy4=;
        b=Xuccf//4lGBEyHUl6zSIRxbM8f9wkchu6F+vh++i/SClOItQE/wI5zEtX6yOef/XjT
         tVgr6mEk/luokbp42Ws9LuGcQI6BhdU8giR5qfpzRODq8nPxiFZS2KeGsmSwTdPmzd/6
         8APLHXFVSKxA3ClGA6d6Sk49bA67/kU4Uqqsz5IEmVjLPLEbztalXowImAPK2Yozviii
         XWVD3Lxvm+Eaaw/qcj+5eOcC18ItoDPj65WuKOg5E/eiEfuub67E6ptO6ZaBtCE2AVLf
         XO+HTzXV+0vyQWq426TkacOI5DytR3yvtJK4PdiwPjaNA0wVhDVfkvEWMjWTdOqB6Rkg
         AxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/5CduqiheNr7yH0yLOOjbHloVd5ZsvlvVOG7WqiWy4=;
        b=N7+0KOF7OcT7lzUKhiJWmDDB1RQPwywjx81yr8RIRXvPOx1hFISYfuwI5o74ZLyEdC
         QQ6VCH7zV6VtP4Cp2QhZzj/RFRfFfMN9RIfIgQd0U+KsSp6S4IfcJ7D3N51L7hJPFNIY
         BOJUjyYYI+OC0M5h6I2eAoHie69Dd3x1Wg7t6i/X4lOVNA4EFmu9HP4IOq8UtzrjgLwC
         g9cpDlurFf41ieUE4kRdHE6/gofzTPYW+t4fmvyzJTeDLxFOjdISCjcRWEi8YbzMizdo
         U7OpIawV2TrqBJPWyexzd1WerslNt2uxvE5I6RyO18hrnxwiYyCvcq1ChNxkCFb8FaT0
         nV6g==
X-Gm-Message-State: AO0yUKX7CJX0qGd2zskiFero3M23JMSgo86QNaUYAKqBPTeriJtC3V+o
        BTo3aLHz13rSIeVj6gGiL1oa5yOHvKQ=
X-Google-Smtp-Source: AK7set9y9blJBdb0ktueDpivNZp1G56hL3w8stzwri5giX70xZ/4UyXj9/omh7rJfgKqIBt4pddKRw==
X-Received: by 2002:a17:90b:4f4e:b0:230:b47b:101 with SMTP id pj14-20020a17090b4f4e00b00230b47b0101mr4484113pjb.39.1675785376903;
        Tue, 07 Feb 2023 07:56:16 -0800 (PST)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090a65c700b0022c9eddaf9dsm8358480pjs.0.2023.02.07.07.56.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2023 07:56:16 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V2 0/8] kvm: x86/mmu: Share the same code to invalidate each vTLB entry 
Date:   Tue,  7 Feb 2023 23:57:26 +0800
Message-Id: <20230207155735.2845-1-jiangshanlai@gmail.com>
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

[V1]: https://lore.kernel.org/lkml/20230105095848.6061-1-jiangshanlai@gmail.com/

Lai Jiangshan (8):
  kvm: x86/mmu: Use KVM_MMU_ROOT_XXX for kvm_mmu_invalidate_gva()
  kvm: x86/mmu: Use kvm_mmu_invalidate_gva() in kvm_mmu_invpcid_gva()
  kvm: x86/mmu: Use kvm_mmu_invalidate_gva() in
    nested_ept_invalidate_addr()
  kvm: x86/mmu: Set mmu->sync_page as NULL for direct paging
  kvm: x86/mmu: Move the code out of FNAME(sync_page)'s loop body into
    mmu.c
  kvm: x86/mmu: Remove FNAME(invlpg)
  kvm: x86/mmu: Reduce the update to the spte in FNAME(sync_page)
  kvm: x86/mmu: Remove @no_dirty_log from FNAME(prefetch_gpte)

 arch/x86/include/asm/kvm_host.h |   7 +-
 arch/x86/kvm/mmu/mmu.c          | 177 +++++++++++++++++----------
 arch/x86/kvm/mmu/paging_tmpl.h  | 209 +++++++++-----------------------
 arch/x86/kvm/vmx/nested.c       |   5 +-
 arch/x86/kvm/x86.c              |   2 +-
 5 files changed, 178 insertions(+), 222 deletions(-)

-- 
2.19.1.6.gb485710b

