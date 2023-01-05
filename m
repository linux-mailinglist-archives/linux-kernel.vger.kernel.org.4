Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4B65E865
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjAEJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjAEJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:57:35 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456854FD63
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:57:35 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cl14so2856464pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 01:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8r6dwMdHsrpTUxza2Gmd/q/3+CXwtM/BlaVF6ITa+4=;
        b=YU4SsLFo2FTpo+ODl2F714/MqxXRaUdwFykAPTgTx3Xh24liNZx3ocfZAzjFhl4PgG
         gBrn5ptGmxAVVRzs2p/7BXPefLpw5CWnpkq4KCShlY+J27aIJhIzDZ/Li2izwVxH7yMi
         EgtRg00GwV174un9BFcCxULRN0vWMP8jqZtOFl/cgQHmmfurb+1jkHD3jXT/gxNLXKPl
         mdZ8pf7r21DYHnJGCIb559KspPGAViutpqsk0jCOq19zpdARPAi/oULKZPRDnK0Wf5LP
         KFQyB98SL2TJ3CXepLuQ6189JYcPeydsypaBGqSn/TVJj6LSoGqSEpYuA+OcG+4Br27t
         /zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8r6dwMdHsrpTUxza2Gmd/q/3+CXwtM/BlaVF6ITa+4=;
        b=tnbqp9ZNp2Tw/HUziadIj/zrt7w5GShX4tlAZo5V3gHfwrVJqKbZg1zyRHQbUQQcas
         y7p/9UPx6Rz19l9ZTH5Gig+eydBgpqzEt9PfTh6QLKms9qu/8QNb0NkrgOlvGghskBWy
         qFk2fpKaFeeirxBiTqDHN4FM6xJVZwBMMXvXISOth+0M9JfbNMOCMQhzourYn3eFQ2Gu
         zGRAazsnBdr/hfCw8Prw5UXJMOsxR6f1zqwXXbSOAGiF01cytYDciQ4Gky+E7o1QLrHd
         7rTqkBF0tCO8uEb7umYV6HWTQn20dyktF3QZ76kqRDIqTNE0HAU8MNDJJKkXA3eWgG6/
         0eEw==
X-Gm-Message-State: AFqh2kqgm2jQAKuaVMsrPQXH44u7wsoyztEvpa1/dapPL7atYjUWHJIx
        ZlFMVsKFgjQfM3SvHZLDtkQdYVg5wAs=
X-Google-Smtp-Source: AMrXdXs0oFP6ik19EP1xKng2qMT2hBe9BK+hBXx20MeBsF1VLnmZVPqq5Ay8uqhcJO6lRGJSYYa5TQ==
X-Received: by 2002:a17:902:c382:b0:192:4e35:e048 with SMTP id g2-20020a170902c38200b001924e35e048mr52579727plg.35.1672912654443;
        Thu, 05 Jan 2023 01:57:34 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b0017ec1b1bf9fsm6966985plh.217.2023.01.05.01.57.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2023 01:57:33 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH 0/7] kvm: x86/mmu: Share the same code to invalidate each vTLB entry 
Date:   Thu,  5 Jan 2023 17:58:41 +0800
Message-Id: <20230105095848.6061-1-jiangshanlai@gmail.com>
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

Lai Jiangshan (7):
  kvm: x86/mmu: Use KVM_MMU_ROOT_XXX for kvm_mmu_invalidate_gva()
  kvm: x86/mmu: Use kvm_mmu_invalidate_gva() in kvm_mmu_invpcid_gva()
  kvm: x86/mmu: Use kvm_mmu_invalidate_gva() in
    nested_ept_invalidate_addr()
  kvm: x86/mmu: Reduce the update to the spte in FNAME(sync_page)
  kvm: x86/mmu: Move the code out of FNAME(sync_page)'s loop body into
    mmu.c
  kvm: x86/mmu: Remove FNAME(invlpg)
  kvm: x86/mmu: Remove @no_dirty_log from FNAME(prefetch_gpte)

 arch/x86/include/asm/kvm_host.h |   7 +-
 arch/x86/kvm/mmu/mmu.c          | 177 +++++++++++++++++----------
 arch/x86/kvm/mmu/paging_tmpl.h  | 207 ++++++++------------------------
 arch/x86/kvm/vmx/nested.c       |   5 +-
 arch/x86/kvm/x86.c              |   2 +-
 5 files changed, 176 insertions(+), 222 deletions(-)

-- 
2.19.1.6.gb485710b

