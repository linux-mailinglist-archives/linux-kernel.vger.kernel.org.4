Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AB070CFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjEWAvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjEWAvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:51:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D3455A9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:44:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561eb6c66f6so58230817b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684802595; x=1687394595;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SK35moxCE6AhlCZl4FimQ53XrewZjdQKUPUW9jfTNhI=;
        b=JF9VmGvn6ME+aV3DWd+moD6DHriILl/eHSLrRAVbk557Nfyq2aEPhsaPiGBpDbWYew
         xfxlvpIcDqTn+OyodXR//4275XAoEeYjxwdP8/SeVRQSlV9QMoEG8a3I0GYpUHbADTXi
         BO0ai4br/mZs2NpalBibKFHY6KZ4WD2OYLEBP5rVthGV4zZXo73DugZVaCiFg4N10L5J
         y3ow4VUMSVguwSU9N8aUagGsIBAOX6iR6VVTKqq5fCbzvHjN3f3blh1NFR8W7EXCmsJj
         sFhkDMgC+eXM3eLCgw3471dz7sjLpCIriVTG3t6mKGIBUQCgosKE3bott3R7ljUVNJdY
         TnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684802595; x=1687394595;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SK35moxCE6AhlCZl4FimQ53XrewZjdQKUPUW9jfTNhI=;
        b=N6XWR515mEelrHyqBaXRqgFZ0/PhZpLS9ucoVwmZonLknH0wEKQuCRHwtt0Z12ygzi
         75AlaPFOQKDBLa1e+mAfbx16NdVg939PtxhsYOXd3QcSKrMrWBzi6oU51YrV5rj5T68I
         tLYzEJC5UnHUZIk2cs+YAM6krlURHDAxY9KtEdgxCgLI17f2u5vftNvyoce387H9cMYd
         wdyNcar5REJtMf32hhGs8Ogxs4dzHTIiKiTZOiVGkguLcIVVGo8PKxt4Hw/PTTqDQD4M
         p0UG17ZzfZKXxuxdt71rev2IYKR/72s33hzmPiJQqydZcWX82K/Hr9rIEpY6hxCzBt+m
         iwUw==
X-Gm-Message-State: AC+VfDztJc/DilLFCrtMGTe8lgExRRI0j0CylK3HnD8WLJ2VEf7f3c3N
        HGLl7diRj82l1vDtif5peyXOzXU=
X-Google-Smtp-Source: ACHHUZ56AYrmc0MsawE025S+h8rVdf9CVXEi3oX5IjzyzrBK6rGupgdJl7OAemYukbnsFVJHjsbsG3s=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:3d33:90fe:6f02:afdd])
 (user=pcc job=sendgmr) by 2002:a81:e508:0:b0:552:b607:634b with SMTP id
 s8-20020a81e508000000b00552b607634bmr7917763ywl.4.1684802594841; Mon, 22 May
 2023 17:43:14 -0700 (PDT)
Date:   Mon, 22 May 2023 17:43:07 -0700
Message-Id: <20230523004312.1807357-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v4 0/3] mm: Fix bug affecting swapping in MTE tagged pages
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        "=?UTF-8?q?Qun-wei=20Lin=20=28=E6=9E=97=E7=BE=A4=E5=B4=B4=29?=" 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "=?UTF-8?q?Chinwen=20Chang=20=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?=" 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "=?UTF-8?q?Kuan-Ying=20Lee=20=28=E6=9D=8E=E5=86=A0=E7=A9=8E=29?=" 
        <Kuan-Ying.Lee@mediatek.com>,
        "=?UTF-8?q?Casper=20Li=20=28=E6=9D=8E=E4=B8=AD=E6=A6=AE=29?=" 
        <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>
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

This patch series reworks the logic that handles swapping in page
metadata to fix a reported bug [1] where metadata can sometimes not
be swapped in correctly after commit c145e0b47c77 ("mm: streamline COW
logic in do_swap_page()").

- Patch 1 fixes the bug itself, but still requires architectures
  to restore metadata in both arch_swap_restore() and set_pte_at().

- Patch 2 makes it so that architectures only need to restore metadata
  in arch_swap_restore().

- Patch 3 changes arm64 to remove support for restoring metadata
  in set_pte_at().

[1] https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/

v4:
- Rebased onto v6.4-rc3
- Reverted change to arch/arm64/mm/mteswap.c; this change was not
  valid because swapcache pages can have arch_swap_restore() called
  on them multiple times

v3:
- Added patch to call arch_swap_restore() from unuse_pte()
- Rebased onto arm64/for-next/fixes

v2:
- Call arch_swap_restore() directly instead of via arch_do_swap_page()

Peter Collingbourne (3):
  mm: Call arch_swap_restore() from do_swap_page()
  mm: Call arch_swap_restore() from unuse_pte()
  arm64: mte: Simplify swap tag restoration logic

 arch/arm64/include/asm/mte.h     |  4 ++--
 arch/arm64/include/asm/pgtable.h | 14 ++----------
 arch/arm64/kernel/mte.c          | 37 ++++++--------------------------
 mm/memory.c                      |  7 ++++++
 mm/swapfile.c                    |  7 ++++++
 5 files changed, 25 insertions(+), 44 deletions(-)

-- 
2.40.1.698.g37aff9b760-goog

