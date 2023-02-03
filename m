Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7AA68A2F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBCT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjBCT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:28:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22733A0015
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:28:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p202-20020a25d8d3000000b00858a2a2cc15so5750040ybg.21
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 11:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HYLbgv7PVml2TewJA39IQMx5unqixaCZm+fzISzoQck=;
        b=MgHXL1T0AXZF0y1gq0TZV5NccJ6+f+xPNHRDSplMsbk2zAu+iuQSSjXQim55qlV6h3
         J5BW9kwO39dl0DDltWIVGmC79n7ioUTCHgdkosNuKFGf3wVF5A5pnhPx5OdJHrrrX3Cz
         xQeKJSrNWA5vgguVlHbPoul8GTEXnmhUk7re+cseIeXl7gez+iS2VhCfK/Ok0wPNiXdK
         nHmljn7nW0Sqsxk7EVjaL98w20RQf1849MlevOLP8abKDVh87rbMt/Eecdiz5FuLAEXF
         nnY0dwqCP63oZU4lwAqAEFEGABZiksibqZbclqOW/p9rlvLzf8M9x3uFV5vitlozfRML
         Jzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYLbgv7PVml2TewJA39IQMx5unqixaCZm+fzISzoQck=;
        b=fsZFjUIYuy2XBCKPdXkHYKipk3fFC1T/s5x+fM/kHGO0dvmlaeNxTbmjUCBW4zPBUu
         atLqlbUZeHs9qRAdZcb4wCdNAfSwnGTjtBOirDtMEHMC+JLSGh18XxX9HjakDW73PITw
         EsLTSL9q7jN6x6WGcnrpwSliMpbjXatv7NlJ9P9FbvU8X5y2n4IHAfmlTZy88RVlIoIk
         AWaVrd83B7B5b7e2ZIf3qGeK4ZaWLyC55g6y7tvKpfDkplEs2Hiyy0lXhqYVlETheY2d
         5ZUb9i+Qaf0zcDS2D/hZaU/T2WHL1it14DNeFhV6Mxbm+YxxRnHCjQ/8zGB9B24htILk
         CBFg==
X-Gm-Message-State: AO0yUKXhpkqroBeekS05rOSQ8BwHwvmjc85BIl4RrLt6vXXOvMnCL3kc
        3NQx4dso984XUw+lElO0Z+oSc0ijRAjN
X-Google-Smtp-Source: AK7set9tMt2ictEwC0laTJjdU9Gpl1wadKBy8dHydjqUNDIzhAF9w3jVmI1LdZ8KKfYqfs166mHqCEt8qjfK
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a81:449:0:b0:524:3a4d:14b1 with SMTP id
 70-20020a810449000000b005243a4d14b1mr532193ywe.174.1675452505354; Fri, 03 Feb
 2023 11:28:25 -0800 (PST)
Date:   Fri,  3 Feb 2023 11:28:17 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230203192822.106773-1-vipinsh@google.com>
Subject: [Patch v2 0/5] Optimize clear dirty log
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series has optimized control flow of clearing dirty log and
improved its performance by ~38%. Patch 2 has more details about
optimization.

It also got rid of many variants of the handle_changed_spte family of
functions and converged logic to one handle_changed_spte() function. It
also remove tdp_mmu_set_spte_no_[acc_track|dirty_log] and various
booleans for controlling them.

Thanks
Vipin

v2:
- Clear dirty log and age gfn range does not go through
  handle_changed_spte, they handle their SPTE changes locally to improve
  their speed.
- Clear only specific bits atomically when updating SPTEs in clearing
  dirty log and aging gfn range functions.
- Removed tdp_mmu_set_spte_no_[acc_track|dirty_log] APIs.
- Converged all handle_changed_spte related functions to one place.

v1: https://lore.kernel.org/lkml/20230125213857.824959-1-vipinsh@google.com/

Vipin Sharma (5):
  KVM: x86/mmu: Make separate function to check for SPTEs atomic write
    conditions
  KVM: x86/mmu: Optimize SPTE change flow for clear-dirty-log
  KVM: x86/mmu: Optimize SPTE change for aging gfn range
  KVM: x86/mmu: Remove handle_changed_spte_dirty_log()
  KVM: x86/mmu: Merge all handle_changed_pte* functions.

 arch/x86/kvm/mmu/tdp_iter.h |  29 +++++--
 arch/x86/kvm/mmu/tdp_mmu.c  | 163 +++++++++++-------------------------
 2 files changed, 72 insertions(+), 120 deletions(-)

-- 
2.39.1.519.gcb327c4b5f-goog

