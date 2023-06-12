Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3174C72BD22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjFLJyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjFLJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:53:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238A05FEE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso6155891a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562700; x=1689154700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfQ5vz07/mwEtSuWTr+saoqBNiKtLGt2UshbSYxHSJg=;
        b=F+XqBLr/1WjE7Ug2RtuXe2SdhSpBlzDj3oGQnRyVt1d/dtCaD+XXpwXcDrZw4+n2MZ
         QcEloaAnK59jSL/5pZxzXeDNBVnna91t1rbQmJuA1G5y4xNfdWcL6PKmxm0QoCCV/qu2
         mNGA+kPy4057ftxU0VgtHcN01tER2TP3wdJwspu25m7B0kpb1bY3KfUsP438ktxuSIda
         e/vrpHFjfXX6hV5LCpYJDUeE8eYFpVZ1TvmC58OO/oBmiHAWcTatJ2pO9X9L8k3QwE6P
         qz0nSOPl576ztcw/4bZysXhbje4eRw7CgIJcxnpHZe38MTpgslcyzdYI+CnbHUGjrMbu
         ccvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562700; x=1689154700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfQ5vz07/mwEtSuWTr+saoqBNiKtLGt2UshbSYxHSJg=;
        b=lqc9trwNz02n5D5Cdyesu61pbdpEu18iCrCD55xAyVRTjDjz6W+Z6te9b7WO/i4E7p
         GFyPHx/d/kTFVpsyqMqNsoZtvW7mD/XE6K3Am5SB0lkMwItcdm0dcCGVLE091/0nREiE
         8nLZcF/UJ4zFgfmnkfL3s6HS7oT/IfDEejUeKReGk/UqfY/x5soY4FPE3H4C+Kh8yxZJ
         KfhvFwrTxrnGZLankF36Dh+22su4vo1wNAcDjzY5ETfmp0NLW/1Km8UpWaZ32n8ldPNj
         UVoyv6FB4+pPS7Z7UBwqe63ndOCJCcTWm5HBe2H5O1fYzPcvX7T2Lm1/xNQUlQF2g7Ju
         bH9Q==
X-Gm-Message-State: AC+VfDz5UiwIAQFHW1ayiLEdnaElcKkM4dD8DSO5yq1wBw8Ra4pFWZpC
        1m6/hPFyvO2cTDaLt/aMv4k=
X-Google-Smtp-Source: ACHHUZ6kT4+nqOwRUSv2g8qLyoK/ZLbw0Hrp5QDubdNrVy0Gdaq60JjrgieMiw4EYdkUPFCgb34eIQ==
X-Received: by 2002:a17:907:1b1c:b0:966:5730:c3fe with SMTP id mp28-20020a1709071b1c00b009665730c3femr8843144ejc.52.1686562700314;
        Mon, 12 Jun 2023 02:38:20 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-212-171-43-8.retail.telecomitalia.it. [212.171.43.8])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm4951358ejb.98.2023.06.12.02.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:38:19 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 0/7] mm: zswap: move writeback LRU from zpool to zswap
Date:   Mon, 12 Jun 2023 11:38:08 +0200
Message-Id: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to improve the zswap reclaim mechanism by reorganizing
the LRU management. In the current implementation, the LRU is maintained
within each zpool driver, resulting in duplicated code across the three
drivers. The proposed change consists in moving the LRU management from
the individual implementations up to the zswap layer.

The primary objective of this refactoring effort is to simplify the
codebase. By unifying the reclaim loop and consolidating LRU handling
within zswap, we can eliminate redundant code and improve
maintainability. Additionally, this change enables the reclamation of
stored pages in their actual LRU order. Presently, the zpool drivers
link backing pages in an LRU, causing compressed pages with different
LRU positions to be written back simultaneously.

The series consists of several patches. The first patch implements the
LRU and the reclaim loop in zswap, but it is not used yet because all
three driver implementations are marked as zpool_evictable.
The following three commits modify each zpool driver to be not
zpool_evictable, allowing the use of the reclaim loop in zswap.
As the drivers removed their shrink functions, the zpool interface is
then trimmed by removing zpool_evictable, zpool_ops, and zpool_shrink.
Finally, the code in zswap is further cleaned up by simplifying the
writeback function and removing the now unnecessary zswap_header.

Based on mm-stable + commit 414fb1ae68b7("mm: zswap: support exclusive
loads") currently in mm-unstable.

V2:
- fixed lru list init/del/del_init (Johannes)
- renamed pool.lock to lru_lock and added lock ordering comment (Yosry)
- trimmed zsmalloc even more (Johannes | Nhat)
- moved ref drop out of writeback function  (Johannes)

V3:
- rebased on commit 414fb1ae68b7 ("mm: zswap: support exclusive loads")
- renamed zswap_shrink to zswap_reclaim_entry (Yosry)
- compacted reclaim entry function dropping tree_entry (Johannes)
- deleted .shrink = NULL from driver-specific patches and re-worded
commit messages (Minchan and Johannes)
- fixed some indentations and comments (Johannes)

Domenico Cerasuolo (7):
  mm: zswap: add pool shrinking mechanism
  mm: zswap: remove page reclaim logic from zbud
  mm: zswap: remove page reclaim logic from z3fold
  mm: zswap: remove page reclaim logic from zsmalloc
  mm: zswap: remove shrink from zpool interface
  mm: zswap: simplify writeback function
  mm: zswap: remove zswap_header

 include/linux/zpool.h |  20 +--
 mm/z3fold.c           | 249 +-------------------------
 mm/zbud.c             | 167 +-----------------
 mm/zpool.c            |  48 +----
 mm/zsmalloc.c         | 396 ++----------------------------------------
 mm/zswap.c            | 190 +++++++++++---------
 6 files changed, 134 insertions(+), 936 deletions(-)

-- 
2.34.1

