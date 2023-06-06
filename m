Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389F1724710
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbjFFO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbjFFO5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:57:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B71722
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:56:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977ed383b8aso267584266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686063397; x=1688655397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mynbaLKp576BHmSfRlc0g7QtomnRapZLg6iYg51c7rM=;
        b=HZFfeto2Hpkc8haUjf586/zizHwIWfxy54etAJ8opWaDiMrtkcozh2lhBj2GJ5Csqp
         s380xukhPMxOUdUMrzVqiGBEmqz9peeNS9eCFS1CqT1EH1sPedvXMsU23QTDY9qV0ZbQ
         OIpfZd4BHw7WI0mD8CD9zAi16IywuEYet6eN6X+nNTZu896ay/a57WTBwC/1762uZfQq
         p8GY+HAi6gzLIw9YAB6suWiJ2KNp8Y9T5HaFDvVIGlk/s83l0Xy6pdHP10ykOoTodOVr
         Z2H8aKyl9FDoK11m3xIMZiqkkRYIPWL6m/1rRmm5frE7Bxcskqxk5XEZ5D7IaxbGOJTl
         p7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063397; x=1688655397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mynbaLKp576BHmSfRlc0g7QtomnRapZLg6iYg51c7rM=;
        b=jkxK/+ZrfLeOfzH8vED8D6niE8gMsECTV250p6q5Uu37XjA0DSLdFZj2cBznX7kQnf
         nAVnXWwRvYcnxFG67OEpKSoq+lI674wtuLHlqd9UP67nGkOrlCQQIsqPXaarCjKLc6Rg
         yUzISRwxyfDJRLEAtUHrLnwZlGKC+cRi9EYHjE6tWyJvpHWtNjhBnZ1UvvGrOneLqFvm
         qhyJJPlThJe9sDBrw9bopnDKtVWtRgGR2qoVDDZvx5NFCvH550Sbw8BROHjPh6AUHEaO
         YAKnZ1bUqngqeJfne7prE3PHLoLnGCgwqh/oQDpgoPHWX0cwEH2+sO+P2ryaKrzNRoPE
         X5Gg==
X-Gm-Message-State: AC+VfDyA4PQOOEoQTJ+gCciGCH/uBHyFP/J/W+RgfK0p8bvN0cSxZ/O+
        edCZWOdcoOpOglZqfmwt5nA=
X-Google-Smtp-Source: ACHHUZ4w1k23VEPCguV/eGyv90uhN0XUS6iHP2BMNwDcQ+wNM6n1ovfNYeFanG6cupnjFpvDRoSh5Q==
X-Received: by 2002:a17:907:7da4:b0:974:1c98:d38e with SMTP id oz36-20020a1709077da400b009741c98d38emr2902003ejc.2.1686063396590;
        Tue, 06 Jun 2023 07:56:36 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-214-132.retail.telecomitalia.it. [82.53.214.132])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709063e4f00b00965c529f103sm5619618eji.86.2023.06.06.07.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:56:36 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH v2 0/7] mm: zswap: move writeback LRU from zpool to zswap
Date:   Tue,  6 Jun 2023 16:56:04 +0200
Message-Id: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
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

V2:
- fixed lru list init/del/del_init (Johannes)
- renamed pool.lock to lru_lock and added lock ordering comment (Yosry)
- trimmed zsmalloc even more (Johannes | Nhat)
- moved ref drop out of writeback function  (Johannes)

Domenico Cerasuolo (7):
  mm: zswap: add pool shrinking mechanism
  mm: zswap: remove page reclaim logic from zbud
  mm: zswap: remove page reclaim logic from z3fold
  mm: zswap: remove page reclaim logic from zsmalloc
  mm: zswap: remove shrink from zpool interface
  mm: zswap: simplify writeback function
  mm: zswap: remove zswap_header

 include/linux/zpool.h |  19 +-
 mm/z3fold.c           | 249 +-------------------------
 mm/zbud.c             | 167 +-----------------
 mm/zpool.c            |  48 +----
 mm/zsmalloc.c         | 396 ++----------------------------------------
 mm/zswap.c            | 186 +++++++++++---------
 6 files changed, 130 insertions(+), 935 deletions(-)

-- 
2.34.1

