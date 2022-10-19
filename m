Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04DC604FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJSSfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJSSfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:35:06 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE9A1290AD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r19so12265184qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3m/4y2MR8gwHAVKXn6zWeuE8EVdOtK5C6kZLltneEHw=;
        b=O8Wcj3siSaLUiNoAxNd7BSOg8sMUmChv4yD97G66TuQCFi1qqHnZOHyI+nNCFyjP4i
         GRNt2RuZwgV9JKMfqFAzEsLeUjymGFqIT+8RDtKlzQFpFAWkEKTGZm6Cce9TW/58S+lu
         RafzkGJ7dI0FtIE2qvCFWAXdGGDa+YAIru4m4Wz+VCdC4+OwCS/xq1jmqe6ZkC+1OGOu
         ydzeo/BuwDy6cyqI2ocdR3N06cpGcSGGRJrbW8CYxRNo2SbOtIf31mbiDPNuR/UorXiY
         66JpMoZ0cWDzTQoi6TmhRfbOVwmlEsoPhP4itaN4RSNqyVruts8FilGD8HvVZTb+33Cy
         efmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m/4y2MR8gwHAVKXn6zWeuE8EVdOtK5C6kZLltneEHw=;
        b=IgEbvNZoIP8bOk4JcGZbJ6/kVmQ18gx+8ZmlJeXKOn8QX0S8nP8cm16WOB4CTw+RG6
         UXp1FbmSAPckrYjSvZiUS8NxP/RkyCP3wm4HotrVwGC/isZkP4zTuPQyh2bM1pC5j0l6
         N6N42dAuFutH8yS7KCiFUIehZfu5AXatp5iDYYOeAs3XgkBHypd7B8XGwGjJVprrzap0
         hp4h5mzdThRfT+dEDwW7dXK91vBWqsxxoeRVnd3yLTxze7f2wiOE6CXrCJGZ5U5YZm69
         49vKw6RvOZKq78BZ5okCZUbntMEwSAjvqb6T11vYMOATFjkZ24U8PDHlljGtrvmLJygD
         Qobw==
X-Gm-Message-State: ACrzQf0oTfzY3msioZu7LEuEdQzR2ai7D4s44/RPfh9nDxh7MgrcPjqD
        4LIw/1IgT94Kigf2wZEzGiT09GCb/DPTFw==
X-Google-Smtp-Source: AMsMyM4mrUchVtySA1ZdmfnOuXHuUFsPnkVD1l6m3s7KCDUvatE8rSo+LBemxh2dP4CD2tlD622A5Q==
X-Received: by 2002:a05:622a:48c:b0:39c:f2c5:41eb with SMTP id p12-20020a05622a048c00b0039cf2c541ebmr7780649qtx.212.1666204501638;
        Wed, 19 Oct 2022 11:35:01 -0700 (PDT)
Received: from sophie ([143.244.47.100])
        by smtp.gmail.com with ESMTPSA id r28-20020ae9d61c000000b006ed30a8fb21sm5377417qkk.76.2022.10.19.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:35:00 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 0/5] memblock tests: add tests for memblock_alloc_exact_nid_raw
Date:   Wed, 19 Oct 2022 13:34:07 -0500
Message-Id: <cover.1666203642.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
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

v1 -> v2
PATCH 0:
- Add missing memblock_alloc_exact_nid_raw to subject line

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
 tools/testing/memblock/tests/alloc_nid_api.c  |  542 ++++----
 tools/testing/memblock/tests/alloc_nid_api.h  |    1 +
 tools/testing/memblock/tests/common.h         |    2 +
 8 files changed, 1425 insertions(+), 269 deletions(-)
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h

-- 
2.25.1

