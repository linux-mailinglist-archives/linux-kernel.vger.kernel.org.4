Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BC705D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjEQCV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjEQCVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:21:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5810CF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8338f2103so234765276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684290083; x=1686882083;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbvIotRGfeUI08jv8AEiwlw+JO4JY4xCfZlRx6U3EOo=;
        b=KUAjUFSPrTObC3hg/4eFzGEAYHdVyshHZdyrXJc5KM2+ApESlbodJxFclR3YXvSKuy
         kLOT6ZdR4Ohc4e6WLZv+NG13YniC23eIgKsDzKhXjT4gOGcOJ2uRdUt0pqfkKLiCkksk
         lkw8+v3lrxIgT5X4LzGBewpBv4Dud1I+wY37cJ3oSnYl/yPDUDK/Up98aTyjDQ04NhMP
         jTiiQChMP2VXsYI8jCvRhbkJjo5tai4Kx77eSn2JI3ORttioIag8vv05s95dP3/TmsMw
         MbTWpSFmhHnKx78X/4B6zv31Tl0ERVcNveLr1aTw7w/wCj644yKhpI3JdT9AtVh1ISco
         lYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684290083; x=1686882083;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbvIotRGfeUI08jv8AEiwlw+JO4JY4xCfZlRx6U3EOo=;
        b=YgbQZyxEz/NqqkT1dOLxk/5eYzaIP/5Vq8p8cdqDF3AVXaWFMlGsiLzBeEJyqJ+/js
         kK5SnIsdDAYNjxENQr0dgRVgK0C4GbRSx/VNX2ggZJcvsKMUVM1RGg88Sd98gXnIEppH
         W4upg6nIJvq/iUWMIYqn9DNxHLWoZ1jowRF8skSRK5PvntEAiFlRh4CXFr1bPsrf7Ru/
         8EMREEULK6ckyw9GgKbxo2AVKoFkv2HbbS0LE1FrRBWZISr+A5zH0UlXX2q1CL+SfQVk
         JFFY7ruPyqcDZgYn7G8VTwn4hbFLqn4SrmURu4q9wjw3mF0cYnVxxmQvZlr2BMHDR+Zo
         NJAw==
X-Gm-Message-State: AC+VfDy9G+pBoeXzizfyHjMXakVs0PgRskJKowwgTPOvFtANHwvKDSLt
        ZOVmwpS1Xc5KWwbUM6DPIaacMbk=
X-Google-Smtp-Source: ACHHUZ4fdjqimU4JmDpRktxQF9oQ9T6d7e3Yb7VykHUg7Ik7O9Au34ajlZWnInBmmASi8g9Q5p5F+oI=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:b3a7:7c59:b96b:adaa])
 (user=pcc job=sendgmr) by 2002:a25:7708:0:b0:ba8:1b23:8e66 with SMTP id
 s8-20020a257708000000b00ba81b238e66mr1996246ybc.9.1684290083311; Tue, 16 May
 2023 19:21:23 -0700 (PDT)
Date:   Tue, 16 May 2023 19:21:10 -0700
Message-Id: <20230517022115.3033604-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v3 0/3] mm: Fix bug affecting swapping in MTE tagged pages
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
 arch/arm64/mm/mteswap.c          |  7 +++---
 mm/memory.c                      |  7 ++++++
 mm/swapfile.c                    |  7 ++++++
 6 files changed, 28 insertions(+), 48 deletions(-)

-- 
2.40.1.606.ga4b1b128d6-goog

