Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081E76E0684
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDMFq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMFqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:46:55 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DDBE40
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:46:53 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PxpVg6Yncz4xVnK;
        Thu, 13 Apr 2023 13:46:51 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl2.zte.com.cn with SMTP id 33D5klSF069087;
        Thu, 13 Apr 2023 13:46:47 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 13 Apr 2023 13:46:48 +0800 (CST)
Date:   Thu, 13 Apr 2023 13:46:48 +0800 (CST)
X-Zmail-TransId: 2b0364379748ffffffffc3a-dc384
X-Mailer: Zmail v1.0
Message-ID: <202304131346489021903@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
Cc:     <imbrenda@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY3IDAvNl0ga3NtOiBzdXBwb3J0IHRyYWNraW5nIEtTTS1wbGFjZWQgemVyby1wYWdlcw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 33D5klSF069087
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6437974B.000/4PxpVg6Yncz4xVnK
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
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

the patch uses pte_mkdirty (related with architecture) to mark KSM-placed
zero pages. Some architecture(like sparc64) treat R/O dirty PTEs as
writable, which will break KSM pages state (wrprotect) and affect
the KSM functionality. For safety, we restrict this feature only to the 
tested and known-working architechtures (ARM, ARM64, and X86) fow now.

Change log
----------
v6->v7:
This is an all-newed version which is different from v6 which relys on KSM's
rmap_item. The patch series don't rely on rmap_item but pte_dirty, so the
general handling of tracking KSM-placed zero-pages is simplified a lot.

For safety, we restrict this feature only to the tested and known-working
architechtures (ARM, ARM64, and X86) fow now.

xu xin (6):
  ksm: support unsharing KSM-placed zero pages
  ksm: count all zero pages placed by KSM
  ksm: add ksm zero pages for each process
  ksm: add documentation for ksm zero pages
  ksm: update the calculation of KSM profit
  selftest: add a testcase of ksm zero pages

 Documentation/admin-guide/mm/ksm.rst              | 26 +++++---
 fs/proc/base.c                                    |  3 +
 include/linux/ksm.h                               | 27 ++++++++
 include/linux/mm_types.h                          | 11 +++-
 mm/Kconfig                                        | 23 ++++++-
 mm/ksm.c                                          | 28 ++++++++-
 mm/memory.c                                       |  7 ++-
 tools/testing/selftests/mm/ksm_functional_tests.c | 75 +++++++++++++++++++++++
 8 files changed, 187 insertions(+), 13 deletions(-)

-- 
2.15.2
