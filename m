Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE8704373
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEPCfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:35:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8C19BC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:35:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b24c1deso590865276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684204520; x=1686796520;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9idPu53ZjVHtwYigNYCClhylP4MevS6nQx9iaoA1FqE=;
        b=qg1/oXxW4HMIEgzqfnFQltjTLrihl9n8+ZqSP2kxW3MUyySEJep6tZEI0JAp2d2Ov4
         vqPhyhZVxB50nViGKe3SSdGBMiIyAeNywyKZakLWog1hEmPCYMUjvQw/Vx+RcjwtSSCW
         RTFesV5A/gVb7ZHHlX9moH2DQvP+U2oGZPMsfStL2GZ/hIfQp54Tl+zXMhAbbh5mZohK
         vZlzAMNjC0oBGwNVPe/VV3bXPcx36IK9qzqt61WEofdqh2C7U/G3YJmdpUMQhSAr38KR
         h3xmrYYTXbvTbG81E49RACeVJkzvkoDx70wyFJmq7L26xzqeZHedYFCioT2FurgwftFY
         zteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684204520; x=1686796520;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9idPu53ZjVHtwYigNYCClhylP4MevS6nQx9iaoA1FqE=;
        b=WSo2N+Dd1E+r3PH788CnUMht1VMur9FnlKBhMRgi7I6YFJX1+KPd2E1XM0ZAIbn0Lb
         D2Glmsnyl59otlDKAWd2ON5Av+jqc7eVR8xGYF1nAejeKEfTKwSW+cAboTzid1BYQvo0
         qJRZ2PpMYxhy/QXxcM0PY1j7zOjVladtqEoMn1+ZoIbGSfrOVtJ42rZELeqiOy6AzvwR
         O/DekWz5kWXwdjnyHLFCQvuka2r56e0Co24VMwBlxGmI/jUzubAuGK3jdUbFTH8fTYQx
         q+xI3GIwOcffUms/kPuYmRbCPgSjkqdbb+tI58w8lg9T/+xSak7R6XOMpqqPOefUjITr
         W3+w==
X-Gm-Message-State: AC+VfDyc60TjEFD41nGBF09MWV2YdaVAfh5r/ineKM55wFs3aGn5knLL
        A0M9GIS0jnDKJMN5fMRKm96cuFw=
X-Google-Smtp-Source: ACHHUZ7hY7nEFfNjcj6aemkZbM6LRWtQddySi4jNsUgtytp5xn1nzuPtZhOti+EOFgfx7N2fNayWk+U=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:c825:9c0b:b4be:8ee4])
 (user=pcc job=sendgmr) by 2002:a25:6542:0:b0:b95:4128:bff6 with SMTP id
 z63-20020a256542000000b00b954128bff6mr21566342ybb.1.1684204520689; Mon, 15
 May 2023 19:35:20 -0700 (PDT)
Date:   Mon, 15 May 2023 19:35:11 -0700
Message-Id: <20230516023514.2643054-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2 0/2] mm: Fix bug affecting swapping in MTE tagged pages
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

v2:
- Call arch_swap_restore() directly instead of via arch_do_swap_page()

Peter Collingbourne (2):
  mm: Call arch_swap_restore() from do_swap_page()
  arm64: mte: Simplify swap tag restoration logic and fix uninitialized
    tag issue

 arch/arm64/include/asm/mte.h     |  4 ++--
 arch/arm64/include/asm/pgtable.h | 14 ++------------
 arch/arm64/kernel/mte.c          | 32 +++-----------------------------
 arch/arm64/mm/mteswap.c          |  7 +++----
 mm/memory.c                      |  7 +++++++
 5 files changed, 17 insertions(+), 47 deletions(-)

-- 
2.40.1.606.ga4b1b128d6-goog

