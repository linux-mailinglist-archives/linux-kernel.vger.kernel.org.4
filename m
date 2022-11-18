Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7704062FC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbiKRSZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbiKRSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:25:08 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C01942F5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:24:12 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 62so5641135pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6E6GpRuxKdp+o4hP203uhjB5+UZzDZfAaY7rEhcjmoU=;
        b=dgQqcKyOimQp9XMKebGUyN62bGP1UyhSB1dXOIepkhFhQ0u7EuSIgK+z8cl7HS0+ax
         EqjZZK1zIob55ymdYqhT4IwS7jEI8Yeh0p9KpRYMBIqts3w/93LM7KdqmxEccD1GjB0/
         ruUhKy7pFSb+aul93ooT1CmBJg7TjTKLBPA9SnHqaellRHZbJ+9aPHmTieZMt0Aa+N90
         1tbhlT0FU6eSn3xTFq7s9fGhTR/ToyRuCe+zP4quCJ5KU4E/4WlTNSheFhu0kfEyKnRB
         zUueRTftg+8PW0Egi+dD0SaWA7Ydcn2IH4geFv5val8I4nMWaNzp9QjMDd+l0dariIM8
         437g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6E6GpRuxKdp+o4hP203uhjB5+UZzDZfAaY7rEhcjmoU=;
        b=il9z2VrBQxBvPEW3mU2lR40y56CHKS/9ZasuAywkkQzQmW63+O8uL0A8uBNXcdz6Ys
         B2exOBfKrjrCO/9nKn+Ti3vWtsNcRmZJ0/SgOUtQMd3uwNrRT9ztAJ2MiZgjqA/FLkSq
         Zx9EJslBj37I1EeJMLrLzQnbHXqPGriwKFvAMDDlqBOPSPK/y2nPrHIxYdkNT/vym4VJ
         8Hd5fwKKnvzbwxk1PuMBnhz0T3y1lk5jW5KnOpUWCzMBQtCNb/isAYyEuDfSYpjPWXAZ
         /NzDC7/4kKTp3L/uBB2dh3juJkqs6klHI3TKja+FgMZAWkeW1OjbR8jDfjKuu9X0ohyW
         al/Q==
X-Gm-Message-State: ANoB5pl3yBHaeB3ZISJvYIRCNvrP6QrDV+esVeAWpMScw4RTrhryi0t6
        66xxKshuw4wzhJhkDSxMojnWEwIE7deBrg==
X-Google-Smtp-Source: AA0mqf5zgsVV7oRh+CV3HKJU4wUgwbbvSp/lEnKSpxJnGLy1BHF55AFr3NEynmec+wCEg86cArFiFA==
X-Received: by 2002:a63:fa49:0:b0:476:f92f:885b with SMTP id g9-20020a63fa49000000b00476f92f885bmr7784709pgk.31.1668795849138;
        Fri, 18 Nov 2022 10:24:09 -0800 (PST)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b00188fcc4fc00sm2304255pln.79.2022.11.18.10.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:24:08 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v5 0/6] Implement writeback for zsmalloc
Date:   Fri, 18 Nov 2022 10:24:01 -0800
Message-Id: <20221118182407.82548-1-nphamcs@gmail.com>
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
v5:
  * Add a new patch that eliminates unused code in zpool and simplify
    the logic for storing evict handler in zbud/z3fold (patch 2)
  * Remove redudant fields in zs_pool (previously required by zpool)
    (patch 3)
  * Wrap under_reclaim and deferred handle freeing logic in CONFIG_ZPOOL
    (patch 6) (suggested by Minchan Kim)
  * Move a small piece of refactoring from patch 6 to patch 4.
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

There are 6 patches in this series:

Johannes Weiner (2):
  zswap: fix writeback lock ordering for zsmalloc
  zpool: clean out dead code

Nhat Pham (4):
  zsmalloc: Consolidate zs_pool's migrate_lock and size_class's locks
  zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
  zsmalloc: Add zpool_ops field to zs_pool to store evict handlers
  zsmalloc: Implement writeback mechanism for zsmalloc

 mm/z3fold.c   |  36 +-----
 mm/zbud.c     |  32 +----
 mm/zpool.c    |  10 +-
 mm/zsmalloc.c | 334 ++++++++++++++++++++++++++++++++++++++++----------
 mm/zswap.c    |  37 +++---
 5 files changed, 303 insertions(+), 146 deletions(-)

--
2.30.2
