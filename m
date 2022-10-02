Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C122D5F273A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJBXmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 19:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJBXl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:41:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EBB20BC6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 16:41:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q9so8391791pgq.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 16:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=K1+ujuS9rqCSmbxUr61tQx4cOoHP31Js/8cHUq4/Flw=;
        b=diHO58ujrziq2ObADNTZgfJrNmD6sFjKO0fCU63e62LlOE8DNv5edj/TsFhmpwYfyi
         FCnmmMWmnvhnaHkbR+ptopSIQwOJ+uYWCBVyuUTVtWbHUjJnec5TCCqQAheiG7ctNzDV
         rfQTuJE6z/k4UqzS0pTcqzH6VrgucmtBPjI2+mY3Q0G8OJ1c4nJ5z5KFUaYYAfkckTbT
         wXx8ztP2d28sRqAjekO+gQDyK2eUOoKZ3WiRuZTgq/7ejSjqKq436VD/NDuzYS801n1L
         tmLa4WUqPbgvjoeEQKQZL+3p0vccCtY0KeLYyLgCrUyX5jr40451a51zRzzsK74VqyY3
         HgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=K1+ujuS9rqCSmbxUr61tQx4cOoHP31Js/8cHUq4/Flw=;
        b=kzuwobXt27Okmwyak3qd5hGNLUsarDLE7cQ6H+HMoteinNiudF6tYie53/qpFtpJWW
         yOyLkuOZzBKKHh87QA2eQOjVLzipRpUMDC1tLQH6/V5mKIaQjtUFpjBuDe/nuUl4qOmA
         rxG9eWfI6IwZbMhuwXgJnkRqJDjL16qzVdlwVRlKXTk5InRWfOigGXPIH4rq4P5RzMa+
         RjvEjtSmrE2u4LGTwkYr/U6Wrk6uHAyMaYUCfbcwKx3sU17toVPKadA9QK9nORTZcf/u
         pKscJoBOZwOZKqkO9xrzZFktFAqGoehDqHhd5rSbUqJWpWXuUNL9meFVDoKN61XpPgB+
         wX9w==
X-Gm-Message-State: ACrzQf3LpeIpUVlg7J/tjoWhzZbsb8jrmqn+sGAw9ATJ214Ln3pFq8Xk
        Gak4cKtmIAY3HudkMwaG7Bo=
X-Google-Smtp-Source: AMsMyM6mHuI4PX/nmbU8e+KWbjq40HakViNtPmEvquBDQNbB681TrrztNWPDYaMm/lZ8/KgpvOOoeQ==
X-Received: by 2002:a63:250:0:b0:43c:1f18:a471 with SMTP id 77-20020a630250000000b0043c1f18a471mr16693395pgc.373.1664754116924;
        Sun, 02 Oct 2022 16:41:56 -0700 (PDT)
Received: from sophie ([89.46.114.181])
        by smtp.gmail.com with ESMTPSA id z1-20020a17090a608100b00205f013f275sm8869457pji.22.2022.10.02.16.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 16:41:56 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 0/5] memblock tests: add tests for memblock_alloc_exact_nid_raw
Date:   Sun,  2 Oct 2022 18:41:33 -0500
Message-Id: <cover.1664753534.git.remckee0@gmail.com>
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
NUMA nodes. Additionally, most of these tests set nid != NUMA_NO_NODE.

The range tests are very similar to the range tests for
memblock_alloc_try_nid_raw(). The NUMA tests have the same setup as the
corresponding test for memblock_alloc_try_nid_raw(), but several of the
memblock_alloc_exact_nid_raw() tests fail to allocate memory in setups
where the memblock_alloc_try_nid_raw() test would allocate memory. Also,
some memblock_alloc_exact_nid_raw() tests drop the lower limit of the
requested range in order to allocate within the requested node, but the
same setup in a memblock_alloc_try_nid_raw() test allocates within the
requested range.

---
Changelog

v1 -> v2
PATCH 0:
- Add missing memblock_alloc_exact_nid_raw to subject line
---

Rebecca Mckeever (5):
  memblock tests: add range tests for memblock_alloc_exact_nid_raw
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
 .../memblock/tests/alloc_exact_nid_api.c      | 2299 +++++++++++++++++
 .../memblock/tests/alloc_exact_nid_api.h      |   25 +
 5 files changed, 2328 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h

-- 
2.25.1

