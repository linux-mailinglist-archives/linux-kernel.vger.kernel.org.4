Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ADD7012DB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbjELX6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbjELX6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:58:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B222D68
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:58:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso19326502276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935892; x=1686527892;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2B9ylj6BFfnRpivqhld1/fhZhP2W8ss3stfOx6ALHRA=;
        b=MH/xgRcl+oUPdxpSL89+G1Evz0eAj37oZvyPdlEMzSK1W1bXq+MdFgI5o0PFEYAlrO
         84MDZRwz1cr6sqxQFVeYXxgCRAiORqaDDNQL7zorctuToCxpbKuXepJ7AKbwyEawuaKO
         XQl82PD3sX+QBkC3xy7I+TlYA/iQK9Bitn3+jhNRz+kcr4U8pUaiTj3lELHkiqAXaJx9
         WfElw7DOVD034UIRYtbMCksCxNLOtIskaVofeeGZGVhH2M4NcSVX2TPPAklY8Sf9/7Cd
         GL45qL8Ne0EeZ2bnWg1kgrhJ43j5rMQBBv5Twk/6UdsKtfLGHSNBixyjLoymaxL9gi+F
         raeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935892; x=1686527892;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2B9ylj6BFfnRpivqhld1/fhZhP2W8ss3stfOx6ALHRA=;
        b=Sgv2Nd8kukbpbz3RwOHvViTy3i/A2GLsXY15CKQkU2WpSI9mEmz/tRllQ3iC9ckxks
         j8DfFwYmXcoZGhAH15s4yhGM1zKl1UNHdluN9K3bF6fdIsE8lHFW4AHCQe/XiWiYcVUg
         4K2JvT155/LNFIDy7EDnt3EDk8uqxHz8CQMfZCJqg0eg9pmGSDTByIYJVUPN+3m/H21y
         Ilz5HXlDC2ut3259mqWEQPVmGWcVBv8GUsUFqSvBa1NCgT32a86s5wTMNp3GUtYq+VIK
         e4jKpYEXtRQUl5PUemB3HNDoeNYMaUJLot739dUtwX+Mqqp5fPk//09EG8/pD38B5n7C
         4hjQ==
X-Gm-Message-State: AC+VfDxURxfOHGpTsWMX5sptKC81Lz89DP541Vsn7QbwiHw89Fhx9U8i
        U7zHQJ+2oA4Uk+jGPi96yu3bDIQ=
X-Google-Smtp-Source: ACHHUZ6Xqq7MGiMsUQfneARzg6AUQPg2lvYwWTI9d6Hj3TtAyRo8Lm8UF/z4RPzRYWDX4z/Wbww4swU=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:ff6:108b:739d:6a1c])
 (user=pcc job=sendgmr) by 2002:a05:6902:154b:b0:ba6:db51:a7e4 with SMTP id
 r11-20020a056902154b00b00ba6db51a7e4mr2646213ybu.11.1683935892703; Fri, 12
 May 2023 16:58:12 -0700 (PDT)
Date:   Fri, 12 May 2023 16:57:49 -0700
Message-Id: <20230512235755.1589034-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH 0/3] mm: Fix bug affecting swapping in MTE tagged pages
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

[1] https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/

Peter Collingbourne (3):
  mm: Move arch_do_swap_page() call to before swap_free()
  mm: Call arch_swap_restore() from arch_do_swap_page() and deprecate
    the latter
  arm64: mte: Simplify swap tag restoration logic and fix uninitialized
    tag issue

 arch/arm64/include/asm/mte.h     |  4 ++--
 arch/arm64/include/asm/pgtable.h | 14 ++------------
 arch/arm64/kernel/mte.c          | 32 +++-----------------------------
 arch/arm64/mm/mteswap.c          |  7 +++----
 include/linux/pgtable.h          | 26 +++++++++++++-------------
 mm/memory.c                      | 26 +++++++++++++-------------
 6 files changed, 36 insertions(+), 73 deletions(-)

-- 
2.40.1.606.ga4b1b128d6-goog

