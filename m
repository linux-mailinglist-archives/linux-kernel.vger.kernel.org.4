Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A26C9734
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCZRf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:35:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2ED4C03
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:35:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-541888850d4so66582007b3.21
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679852123;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8RaHSVWTJSnn02Olin7w+pvQXlMrY8VwSVjxsNhW3jw=;
        b=PHZst7jsbRQmhKifgwxo7mStAuo/tpfibTL8fS17ydBfof+K9WnRKB36/a5TOKJ8/t
         v7ppzG+XE+wbInX2Gj2xRtLzQMVyhiEJ8wi8Noeigcl3jn8Bm6yde690czGaxdXdX606
         to18odJKzZiqBdSQOp5yogYYtvELKByEwwgkSZVjwrh2IihvN+d6WCGCa9CrADDbWWuT
         XRTgEeCTAl9XKjDu4mCPE5di5Ia/OZJ6/MshPIzCtGwnZH9Eyp1Mz7IVINGvDhYDr/cV
         5o6DvLaEItsmgWSTnaC9WmxHvtHBparGbDOD1WDLodtn6E3MUZYIs6n8G4e1gN/5BzmR
         kPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679852123;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RaHSVWTJSnn02Olin7w+pvQXlMrY8VwSVjxsNhW3jw=;
        b=Yb11y37Z5CpXXVIwZaIwnD0ynle7Pppd0Yy+g6qx7VEVttmAVZijHTH89pta6r3mpG
         y2EDpQf804cDrsqHc+fL4sdattlXw7+38i1BgoTNK+EZBODa1owMvUN6ZamP6x1RIZOv
         LfVT2H8Q1hMOWlhl0wiEY8DT6Kb3/H5zlfG0YPkx+RvbftC2s2tOcYrA2pczGaxNXX/k
         5HlfxwU4qO8/UUC8o5mBbPG53/fz2NIcDJJel89vSNktiCScM/Uddmlx/7UaaNdQqnlg
         pOWQFRbXfxX0teBcexr5ucOeqq0Hd+ndRIOm4zcK9ozf0EhD5oxhBuZNYMBgBcNSzlXK
         vVcA==
X-Gm-Message-State: AAQBX9ebci0XAdD3zr0TUF0AO4Vql60P0pX3H/exqFbF3XknYJGo+/LV
        5kYTi1SlGFEQqIQ+TSghGzPX6jjBgmThWw==
X-Google-Smtp-Source: AKy350YojcWSKkpB3jG6a7FElkGpMoXsRM6pAISAmXcv+NTb/O9Iww2Zv/YDDmhzI3miclD8+ShCBVLT4UXJBQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:a742:0:b0:541:a0cc:2a09 with SMTP id
 e63-20020a81a742000000b00541a0cc2a09mr4212382ywh.7.1679852123705; Sun, 26 Mar
 2023 10:35:23 -0700 (PDT)
Date:   Sun, 26 Mar 2023 17:35:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230326173511.710749-1-joychakr@google.com>
Subject: [PATCH v3 0/2] spi: dw: DW SPI DMA Driver updates
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch series adds support for 32 bits per word trasfers using DMA
and some defensive checks around dma controller capabilities.
---
V1 Changes : Add support for AxSize=4 bytes to support 32bits/word
---
V1->V2 Changes : Add dma capability check to make sure  address widths
are supported
---
V2->V3 Changes : Split changes , add DMA direction check and other
cosmetic chnages.
---

Joy Chakraborty (2):
  spi: dw: Add 32 bpw support to DW DMA Controller
  spi: dw: Add dma controller capability checks

 drivers/spi/spi-dw-dma.c | 67 +++++++++++++++++++++++++++++++---------
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

