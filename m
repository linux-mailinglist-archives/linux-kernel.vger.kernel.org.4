Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9A722178
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjFEIyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjFEIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:54:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E57F4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:54:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977c8423dccso350586366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955264; x=1688547264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaR2WNFqNGx/eAX68W0u03f1qI+xqWevt7sZeHw1kns=;
        b=YS+tvZW2+WP5X+w4p8u1pgC89OXL/syeJ+aVdb6kBSc2jmJpTl4dvRdoIAX3PNqNOF
         ERs4JAaRmw8rGH5xIBfWHa9O6VIcy6PJCUSZinU97jgsaqbZumjmUhgNfdWoD4QtHWHn
         58OZqasWAtX23SA9PWs1q1D2Zcm8RcE23dUfST3b8wfjatcgwAcmrFpseQaXgvu6w7W2
         Ya93pIxg4uXUOoyK1pSlrRSFuu9pgngPdtk/gR+ZG4QnQCKQ67Y7NArtABT4W8FYRARm
         LuGVsSEcLKRt9GVjhLHyKCxXa9wV13ulz45qQi2asLNhTs31hI8mVfx3KmDgJeTZs3Fw
         VjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955264; x=1688547264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaR2WNFqNGx/eAX68W0u03f1qI+xqWevt7sZeHw1kns=;
        b=gdQq/QBUwYyUrqHSxwxzsQjs/DHXV5HTSSpgTdWv/dLWTGUMIZePN8OZGY6quYr/95
         rjQ8fEsSDPXicQGVpWZ+UJKPITn8edFU2FFa3Pn9iOsFsCFmQOx2u1ZLuGM5tYu6/zo+
         UZ+9ACb/30XN512ndJ/LmDPk+NRueccJx5DYA8VxHGHRTcYva85qZdZyENulDs1vYlTF
         oeldy4iOmhw9hY6YXutL3LvI86byInXNsREpBIf9xAwejL0/L/2TMgruqH3H08HLMcnI
         dNORhdsZ75BP7vTUsjDc/jdGaK+KttlQ/ELiFYa3OEkFFgjYgSkWirm5PhklmYC6hxNO
         fsuw==
X-Gm-Message-State: AC+VfDxr1GfS7VR0zG8ULS6rTAbSq5IzyJzn8+1dbCq6loz9jvrm23ze
        6g18f2sS6LXGo8yL4+CFmFk=
X-Google-Smtp-Source: ACHHUZ6Zfr0gwm9DKTUjZgExYFyOj7HlGvdBX3OMdCt73XAfxwgC/mpsIzShz9KoP/7l48zZxKhvjA==
X-Received: by 2002:a17:907:7d8c:b0:96f:ddaa:c30d with SMTP id oz12-20020a1709077d8c00b0096fddaac30dmr5442977ejc.26.1685955264127;
        Mon, 05 Jun 2023 01:54:24 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-8-153.retail.telecomitalia.it. [82.53.8.153])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b00965c6c63ea3sm4048915ejb.35.2023.06.05.01.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:54:23 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH 0/7] mm: zswap: move writeback LRU from zpool to zswap
Date:   Mon,  5 Jun 2023 10:54:12 +0200
Message-Id: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
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

Based on mm-stable + commit 399ab221f3ff
("mm: zswap: shrink until can accept") currently in mm-unstable.

Domenico Cerasuolo (7):
  mm: zswap: add pool shrinking mechanism
  mm: zswap: remove page reclaim logic from zbud
  mm: zswap: remove page reclaim logic from z3fold
  mm: zswap: remove page reclaim logic from zsmalloc
  mm: zswap: remove shrink from zpool interface
  mm: zswap: simplify writeback function
  mm: zswap: remove zswap_header

 include/linux/zpool.h |  19 +--
 mm/z3fold.c           | 249 +----------------------------------
 mm/zbud.c             | 167 +-----------------------
 mm/zpool.c            |  48 +------
 mm/zsmalloc.c         | 294 +-----------------------------------------
 mm/zswap.c            | 159 +++++++++++++----------
 6 files changed, 104 insertions(+), 832 deletions(-)

-- 
2.34.1

