Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA862E221
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiKQQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiKQQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:38:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806597993F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so5938037pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+c2guzYAy3KEmovKT5HAVBgQbsytJbBWzUeTnpwgE6Y=;
        b=QWTuhSLRP8sFHQssMb37CLfEHNWt+Ye/lVD3Yw08WjqYkk+8DFwtMeec9h2ZSaqrto
         9S+Ro1YZfL5TPdmzJBupzkudHvTu/8EbGHccyCp0b/nPmIxnXdCF+abvgAohcaV4rmI7
         x2g1mMc+D+vS9MrcwCSaiE+zkKNM+EVFwVtoUqpLj+CPzBzfQe2WvpEzJ0ADdvtgpijX
         HBbLIMhBzdFnPdBuApdkx43HKo4Hn+vln58Q60Y4nqtNeTmSM4dw5wwS5INOzKGQ8e7R
         hNehNUm5yMTLY1b8HXv8ceCDqTd3WkODn7Pv+jIN5U8o6OfIXel2H4r+msSJ25thYbwE
         +K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c2guzYAy3KEmovKT5HAVBgQbsytJbBWzUeTnpwgE6Y=;
        b=8Km/byH1vzRnt3s/k/qTEeiGYVYTXp45m0jI2V33asKdq0aaDrC4xE5O2KzX1ejO2I
         mFF3rAeWntBpEfBxkPagEg9uIwGkj7Az92keXnWckgFlvMIs2a5W0aCa8y5tdl/qwiXZ
         QdJohdumNeF4++Z2zjD+JCxKpw6hiPvm3xddzCDj+k8MWpgOTmvBuvxlBS6nuahg74PC
         Sqlz+mXH61JLd0FT6EwGQm6sW6OUkUxAGdceQtnnl4xqx9LAgRt6JbIqzNWYBy7LU02o
         B80GI3vlQHoAcDmIFN6hAmwCPuXYDSEThh1+rNDt0z9Zj3IoRK5VpfTL0E5ssOFJgE69
         mnIA==
X-Gm-Message-State: ANoB5pnL1p7omOETuhvRhgarVg2De9j4OnPwNq8/W5gExA1wuaUwfyUG
        sgBDz6URwp7Xn+c4kLD66p6scVLctSD67w==
X-Google-Smtp-Source: AA0mqf6KPDoFnyIhTMz5eYPN1D+XbB1r7bmV525cp8MQrDwdceNwajqZWkZzzjKc+yd3fLv3gJQeCg==
X-Received: by 2002:a17:90a:d805:b0:213:a95:88bd with SMTP id a5-20020a17090ad80500b002130a9588bdmr9470314pjv.98.1668703120971;
        Thu, 17 Nov 2022 08:38:40 -0800 (PST)
Received: from localhost (fwdproxy-prn-009.fbsv.net. [2a03:2880:ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b0016c50179b1esm1617955plx.152.2022.11.17.08.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:38:40 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v4 0/5] Implement writeback for zsmalloc
Date:   Thu, 17 Nov 2022 08:38:34 -0800
Message-Id: <20221117163839.230900-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Changelog:
v4:
  * Wrap the new LRU logic in CONFIG_ZPOOL (patch 3).
    (suggested by Minchan Kim)
v3:
  * Set pool->ops = NULL when pool->zpool_ops is null (patch 4).
  * Stop holding pool's lock when calling lock_zspage() (patch 5).
    (suggested by Sergey Senozhatsky)
  * Stop holding pool's lock when checking pool->ops and retries.
    (patch 5) (suggested by Sergey Senozhatsky)
  * Fix formatting issues (.shrink, extra spaces in casting removed).
    (patch 5) (suggested by Sergey Senozhatsky)

v2:
  * Add missing CONFIG_ZPOOL ifdefs (patch 5)
    (detected by kernel test robot).

Unlike other zswap's allocators such as zbud or z3fold, zsmalloc
currently lacks the writeback mechanism. This means that when the zswap
pool is full, it will simply reject further allocations, and the pages
will be written directly to swap.

This series of patches implements writeback for zsmalloc. When the zswap
pool becomes full, zsmalloc will attempt to evict all the compressed
objects in the least-recently used zspages.

There are 5 patches in this series:

Johannes Weiner (1):
  zswap: fix writeback lock ordering for zsmalloc

Nhat Pham (4):
  zsmalloc: Consolidate zs_pool's migrate_lock and size_class's locks
  zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
  zsmalloc: Add ops fields to zs_pool to store evict handlers
  zsmalloc: Implement writeback mechanism for zsmalloc

 mm/zsmalloc.c | 359 +++++++++++++++++++++++++++++++++++++++++---------
 mm/zswap.c    |  37 +++---
 2 files changed, 315 insertions(+), 81 deletions(-)

--
2.30.2
