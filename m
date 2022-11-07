Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335A61EAF9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKGG2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiKGG20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:28:26 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3C185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:28:22 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id s196so9605314pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gESaC/QebZdJA16HSVzV9tPozTBglPTDEtVQXTkj2UU=;
        b=Xzeqy1YkQcevZO12QOh+1c8dSOHMsQmeHtMBq3ijmKZt/+a5ptiVhD5jAPi6/HJSOI
         Anh11AMBwGED4HjWZuadB5WYTBzKLYaKrkb1YdFm5CmMiirwskKQPswEMgNR/aLDzlyU
         NOZtg2KGjeNGfBtEbwg5PND7SOkmn0JIFw38tT9h5vaSH8pf2ZPGE+vWiuvYiFAJ7QuF
         PxLkDu+82fYWTWSnlKHHmu9mSuIrkPY0iwXIfsNCLz9ylUSYcYN8Dg6OMLK6bxhtpA3Z
         xB6RNJDsTfHsLrG8LSXkimXCOqP3FqDIEEuako6Nftta1nNHPGe9EVvB0mG4jsv8v7W6
         pMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gESaC/QebZdJA16HSVzV9tPozTBglPTDEtVQXTkj2UU=;
        b=O4nRNo/iCIXsrdmjrZOD2ufBMyWkf5+ksWcXCncbneN1hbSTIAJccXPNk0gzwl4XcE
         FWNtccObZPbNOvGFW4Hyhyhsy/Zgv55V4HLPaiT4jvITTZwi5qZuW5dqC5FOQ7n4zrrS
         YA2O1+DHnAsdfV0Xi68knWrOypNidkQSsB5Zb0M3whoFJqb5f1ScqFu5UWTHdC/a3l7P
         fCwrZFZJBDk7cNhZVLBHPi6A7Bx3Dc8Vv3WyzDab0/02lVV+W4moLBUSlfqZ8xEH7bHm
         arXFZNbqnfGlSY5NfY7ZYhTmXSfVQwG0N0ZBTtzyzcqbMUd7f35AlTCqqVWW/BbIZJbL
         1eSw==
X-Gm-Message-State: ACrzQf0IxbIZ7e8YVCYz5R4LE5SfOi/RiVOQLu617b1RjXFS3VYVIfH7
        SfnCz35L2OLCrjP1jNj5uS8=
X-Google-Smtp-Source: AMsMyM6uDiYnMW9Z2bsJ7lcZVYWRuMulQznKIiOODsTd6Z0NV/jL77a5M6lwFI5AOGAHt43VJmrGqg==
X-Received: by 2002:aa7:8502:0:b0:56c:349e:c18b with SMTP id v2-20020aa78502000000b0056c349ec18bmr49004534pfn.1.1667802501925;
        Sun, 06 Nov 2022 22:28:21 -0800 (PST)
Received: from sophie ([89.46.114.207])
        by smtp.gmail.com with ESMTPSA id w135-20020a62828d000000b0056bc742d21esm3715595pfd.176.2022.11.06.22.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 22:28:21 -0800 (PST)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 0/5] memblock tests: add tests for memblock_alloc_exact_nid_raw
Date:   Mon,  7 Nov 2022 00:28:04 -0600
Message-Id: <cover.1667802195.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add tests for memblock_alloc_exact_nid_raw(). There are two
sets of tests: range tests and NUMA tests. The range tests use a normal
(i.e., UMA) simulated physical memory and set the nid to NUMA_NO_NODE. The
NUMA tests use a simulated physical memory that is set up with multiple
NUMA nodes. Additionally, most of the NUMA tests set nid != NUMA_NO_NODE.

For the range tests, the TEST_F_EXACT flag is used to run the same set of
range tests used for memblock_alloc_try_nid_raw(). The NUMA tests have the
same setup as the corresponding test for memblock_alloc_try_nid_raw(), but
several of the memblock_alloc_exact_nid_raw() tests fail to allocate
memory in setups where the memblock_alloc_try_nid_raw() test would
allocate memory. Also, some memblock_alloc_exact_nid_raw() tests drop the
lower limit of the requested range in order to allocate within the
requested node, but the same setup in a memblock_alloc_try_nid_raw() test
allocates within the requested range.

---
Changelog

v3 -> v4
Based on feedback from David Hildenbrand:
PATCH 1:
- alloc_nid_api.c:
    + Add assert to ensure that TEST_F_EXACT flag only occurs with
      TEST_F_RAW flag

v2 -> v3
Based on feedback from David Hildenbrand:
PATCH 1:
- alloc_nid_api.c, alloc_nid_api.h, common.h:
    + Add TEST_F_EXACT flag so that tests in alloc_nid_api.c can be run
      with that flag to test memblock_alloc_exact_nid_raw()
- alloc_exact_nid_api.c:
    + Update to run range tests in alloc_nid_api.c with TEST_F_EXACT flag
      instead of using a separate set of tests
- alloc_nid_api.c:
    + Rename tests and other functions by removing "_try" so that the
      function names are general enough to refer to any of the
      memblock_alloc_*nid*() functions of the memblock API

v1 -> v2
PATCH 0:
- Add missing memblock_alloc_exact_nid_raw to subject line
---

Rebecca Mckeever (5):
  memblock tests: introduce range tests for memblock_alloc_exact_nid_raw
  memblock tests: add top-down NUMA tests for
    memblock_alloc_exact_nid_raw
  memblock tests: add bottom-up NUMA tests for
    memblock_alloc_exact_nid_raw
  memblock tests: add generic NUMA tests for
    memblock_alloc_exact_nid_raw
  memblock tests: remove completed TODO item

 tools/testing/memblock/Makefile               |    2 +-
 tools/testing/memblock/TODO                   |    7 +-
 tools/testing/memblock/main.c                 |    2 +
 .../memblock/tests/alloc_exact_nid_api.c      | 1113 +++++++++++++++++
 .../memblock/tests/alloc_exact_nid_api.h      |   25 +
 tools/testing/memblock/tests/alloc_nid_api.c  |  546 ++++----
 tools/testing/memblock/tests/alloc_nid_api.h  |    1 +
 tools/testing/memblock/tests/common.h         |    2 +
 8 files changed, 1428 insertions(+), 270 deletions(-)
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h

-- 
2.34.1

