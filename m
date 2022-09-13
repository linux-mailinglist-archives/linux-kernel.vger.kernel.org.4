Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3BD5B6742
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiIMFVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIMFVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:21:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3954DF17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:21:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w2so4234223qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=62h1MAuVwSbDjXD0anEf/eJ0jHXwRdLYrtgnbPgF46c=;
        b=PHLM5nNHcw/mZE3RfBdcDO078m4ywJx+nGSQgee8Wpum/WvcDe7TTI2RFaG5GK8mWP
         mN0+oXW1TWJGxAcJM681w1dgcSGrt0EpXHEp2nml9ryloG83BRFZyeChUWuJpCkMwoae
         b+f6IBKmleMb4zdI8qTbpaZfAMsAUqmmwRZVWJs0Go/fkThNytTv6T7ad2lsWKDlbdNG
         1apYxz3r/wi+AQJ/vI/Bbs5A5EsVtIvxieDF6ACfbB/hiOUkmrH/cH6p19RLckDESwEV
         4/5dDJlI6rFq0oGIfVT/RC/hTs8dl2KDQSnwhwSGlx8iDvt4397zabEAv/wnnGSt5Mb2
         0aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=62h1MAuVwSbDjXD0anEf/eJ0jHXwRdLYrtgnbPgF46c=;
        b=C5tGQMNVYIllb2hgcZQg83IkDjQHSDm9C27oBEu68JkAjj/Rf4Do+2KIehaDNaLJsQ
         lA+bv1FnkkHYtz26H21C2SE481yKbdwUq0ELQjw9POkDWH1Z/bGk/Nhq7i3kE64QSUFj
         ROAvZRI614sBo2eUa0EOdWg8hq5vqC/AgaiOmTHTV0H7KsMAfPcxwXf68JVmMl0iM8Qc
         f/+N2hDOg/dfR6zHV009TTH2K130LcP2x0RTARIJpxLPMF/bdSMNKhLil5Es+leHsSme
         t/NH1jcWEn3Uk2iC0JEq7dhrHa1cGj50hce0OjvvGa4iBe80FOf0soBZakZUFg1WmBnZ
         XxTQ==
X-Gm-Message-State: ACgBeo2M8n58lPkG/Djrp4/xW0lLL44tE73woioU/H6EnmycTlnOCKn4
        LrRNGJixDh7Gz5iIIJAHap+04hPomxI=
X-Google-Smtp-Source: AA6agR4ETJJpeh0g20GjLpaXbfz2QyHtazk7T7p9YBS7fImF4XKNuTMVTUMx6C1nxc1Iy1Kktm7NtA==
X-Received: by 2002:ac8:5f82:0:b0:35b:b35e:74ff with SMTP id j2-20020ac85f82000000b0035bb35e74ffmr7485496qta.574.1663046488454;
        Mon, 12 Sep 2022 22:21:28 -0700 (PDT)
Received: from sophie ([45.134.140.166])
        by smtp.gmail.com with ESMTPSA id k20-20020a05620a415400b006c479acd82fsm9376839qko.7.2022.09.12.22.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 22:21:27 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v6 0/4] memblock tests: add NUMA tests for memblock_alloc_try_nid*
Date:   Tue, 13 Sep 2022 00:21:08 -0500
Message-Id: <cover.1663046060.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add additional tests for memblock_alloc_try_nid() and
memblock_alloc_try_nid_raw() that use a simulated physical
memory that is set up with multiple NUMA nodes. Additionally, most of
these tests set nid != NUMA_NO_NODE.

To set up a simulated physical memory with multiple NUMA nodes, patch 1
introduces setup_numa_memblock(). This function uses a previously
allocated dummy physical memory. It can be used in place of
setup_memblock() in tests that need to simulate a NUMA system.

These tests are run twice, once for memblock_alloc_try_nid() and once
for memblock_alloc_try_nid_raw(), so that both functions are tested with
the same set of tests. When the tests run memblock_alloc_try_nid(), they
test that the entire memory region is zero. When the tests run
memblock_alloc_try_nid_raw(), they test that the entire memory region is
nonzero.

---
Changelog

v5 -> v6
Based on feedback from David Hildenbrand:
PATCH 1:
- tests/common.c, tests/common.h:
    + setup_numa_memblock():
        * Change nodes[] from const int to const unsigned int
        * Remove "&& node_fracs[i] > 0" from the assert()
PATCH 2:
- tests/alloc_nid_api.c:
    + Update node_fractions[] type to static const unsigned int to
      reflect changes in PATCH 1

v4 -> v5
Based on feedback from David Hildenbrand:
PATCH 1:
- tests/common.c:
    + setup_numa_memblock():
        * Change nodes[] to int basis points (one hundredth of 1% or
          1/10000) instead of phys_addr_t fraction denominators
        * Rename parameter nodes[] to node_fracs[]
PATCH 2:
- tests/alloc_nid_api.c:
    + Update node_fractions[] to reflect changes in PATCH 1

v3 -> v4
Based on feedback from David Hildenbrand:
PATCH 1:
- tests/common.h:
    + Remove #define MEM_FACTOR
PATCH 2:
- tests/alloc_nid_api.c:
    + Add missing blank line after alloc_nid_test_flags = flags;
PATCH 2, PATCH 3, PATCH 4:
- tests/alloc_nid_api.c:
    + Define variables in new tests in a single block
    + Change "cleared memory region" to "memory region" in comment
      blocks for new tests

Based on feedback from Mike Rapoport:
PATCH 1:
- tests/common.c:
    + Remove node_sizes[] array
- tests/common.c, tests/common.h:
    + Combine setup_numa_memblock_generic() and setup_numa_memblock():
        * Remove setup_numa_memblock(void)
        * Change setup_numa_memblock_generic() to setup_numa_memblock()
          and remove the factor and node_cnt parameters
        * Change nodes[] parameter to an array containing the
        * denominators
          of the fractions of MEM_SIZE contained in each node
          e.g., if nodes[0] = SZ_8, node 0 will contain 1/8th of
MEM_SIZE    
PATCH 2:
- tests/alloc_nid_api.c:
    + Add node_fractions[] array:
        * Based on values from node_sizes[] array previously in PATCH 1
        * Update to fit the new nodes[] parameter of
        * setup_numa_memblock()

v2 -> v3
PATCH 2, PATCH 3, PATCH 4:
- tests/alloc_nid_api.c:
    + Edits for consistency between tests and test naming styles:
        * Change "numa_top_down" to "top_down_numa"
        * Change "numa_bottom_up" to "bottom_up_numa"
        * Move "generic" to immediately before "check"
        * alloc_try_nid_bottom_up_numa_small_node_check() and
          alloc_try_nid_bottom_up_numa_node_reserved_check():
            - Separate size definition from its declaration

Updates based on changes to the dependent patch set noted above:
PATCH 2, PATCH 3, PATCH 4:
- tests/alloc_nid_api.c:
    + get_func_testing():
        * Rename to get_memblock_alloc_try_nid_name().
    + Update calls to verify_mem_content() to assert_mem_content().

v1 -> v2
Updates based on changes to the dependent patch set noted above:
PATCH 2, PATCH 3, PATCH 4:
- tests/alloc_nid_api.c:
    + Update calls to verify_mem_content() to include the flags parameter
      required by the new, common verify_mem_content() function.
---

Rebecca Mckeever (4):
  memblock tests: add simulation of physical memory with multiple NUMA
    nodes
  memblock tests: add top-down NUMA tests for memblock_alloc_try_nid*
  memblock tests: add bottom-up NUMA tests for memblock_alloc_try_nid*
  memblock tests: add generic NUMA tests for memblock_alloc_try_nid*

 .../testing/memblock/scripts/Makefile.include |    2 +-
 tools/testing/memblock/tests/alloc_nid_api.c  | 1466 ++++++++++++++++-
 tools/testing/memblock/tests/alloc_nid_api.h  |   16 +
 tools/testing/memblock/tests/common.c         |   31 +
 tools/testing/memblock/tests/common.h         |   22 +-
 5 files changed, 1524 insertions(+), 13 deletions(-)

-- 
2.25.1

