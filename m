Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D270ED5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbjEXFvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjEXFvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:51:46 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3470C1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:51:43 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QR0gJ6zZ8z8RTWf;
        Wed, 24 May 2023 13:51:40 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 34O5pY5c047952;
        Wed, 24 May 2023 13:51:34 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 24 May 2023 13:51:36 +0800 (CST)
Date:   Wed, 24 May 2023 13:51:36 +0800 (CST)
X-Zmail-TransId: 2b05646da5e8ffffffffcd2-a2267
X-Mailer: Zmail v1.0
Message-ID: <202305241351365661923@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
Cc:     <imbrenda@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <jiang.xuexin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY5IDAvNV0ga3NtOiBzdXBwb3J0IHRyYWNraW5nIEtTTS1wbGFjZWQgemVyby1wYWdlcw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 34O5pY5c047952
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 646DA5EC.001/4QR0gJ6zZ8z8RTWf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

The core idea of this patch set is to enable users to perceive the number
of any pages merged by KSM, regardless of whether use_zero_page switch has
been turned on, so that users can know how much free memory increase is
really due to their madvise(MERGEABLE) actions. But the problem is, when
enabling use_zero_pages, all empty pages will be merged with kernel zero
pages instead of with each other as use_zero_pages is disabled, and then
these zero-pages are no longer monitored by KSM.

The motivations to do this is seen at:
https://lore.kernel.org/lkml/202302100915227721315@zte.com.cn/

In one word, we hope to implement the support for KSM-placed zero pages
tracking without affecting the feature of use_zero_pages, so that app
developer can also benefit from knowing the actual KSM profit by getting
KSM-placed zero pages to optimize applications eventually when
/sys/kernel/mm/ksm/use_zero_pages is enabled.

Change log
----------
v8->v9:
------
(1) The previous [PATCH v8 4/6] is squashed into the current [PATCH v9 2/5].

(2) Improve the codes as David's suggestions.

v7->v8:
-------
(1) Since [1] which fix the bug of pte_mkdirty on sparc64 that makes pte
    writable, then we can remove the architechture restrictions of our
	features.
(2) Improve the scheme of update ksm_zero_pages: add the handling case when
    khugepaged replaces a shared zeropage by a THP. 

[1] https://lore.kernel.org/all/20230411141529.428991-2-david@redhat.com/

v6->v7:
-------
This is an all-newed version which is different from v6 which relys on KSM's
rmap_item. The patch series don't rely on rmap_item but pte_dirty, so the
general handling of tracking KSM-placed zero-pages is simplified a lot.

For safety, we restrict this feature only to the tested and known-working
architechtures (ARM, ARM64, and X86) fow now.

xu xin (5):
  ksm: support unsharing KSM-placed zero pages
  ksm: count all zero pages placed by KSM
  ksm: add ksm zero pages for each process
  ksm: consider KSM-placed zeropages when calculating KSM profit
  selftest: add a testcase of ksm zero pages

 Documentation/admin-guide/mm/ksm.rst              | 25 ++++++--
 fs/proc/base.c                                    |  1 +
 include/linux/ksm.h                               | 22 +++++++
 include/linux/mm_types.h                          |  9 ++-
 mm/khugepaged.c                                   |  2 +
 mm/ksm.c                                          | 28 ++++++--
 mm/memory.c                                       |  5 +-
 tools/testing/selftests/mm/ksm_functional_tests.c | 78 ++++++++++++++++++++++-
 8 files changed, 154 insertions(+), 16 deletions(-)

-- 
2.15.2
