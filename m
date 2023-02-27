Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6FA6A3A40
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 06:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjB0FD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 00:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0FDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 00:03:25 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF8ABDE7;
        Sun, 26 Feb 2023 21:03:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VcW98lz_1677474198;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VcW98lz_1677474198)
          by smtp.aliyun-inc.com;
          Mon, 27 Feb 2023 13:03:20 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        jarkko@kernel.org, naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     xiexiuqi@huawei.com, lvying6@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com
Subject: [PATCH v2 0/2] ACPI: APEI: handle synchronous exceptions with proper si_code
Date:   Mon, 27 Feb 2023 13:03:13 +0800
Message-Id: <20230227050315.5670-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v1:
- synchronous events by notify type
- Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/

Currently, both synchronous and asynchronous error are queued and handled
by a dedicated kthread in workqueue. And Memory failure for synchronous
error is synced by a cancel_work_sync trick which ensures that the
corrupted page is unmapped and poisoned. And after returning to user-space,
the task starts at current instruction which triggering a page fault in
which kernel will send SIGBUS to current process due to VM_FAULT_HWPOISON.

However, the memory failure recovery for hwpoison-aware mechanisms does not
work as expected. For example, hwpoison-aware user-space processes like
QEMU register their customized SIGBUS handler and enable early kill mode by
seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
the process by sending a SIGBUS signal in memory failure with wrong
si_code: BUS_MCEERR_AO si_code to the actual user-space process instead of
BUS_MCEERR_AR.

To address this problem:

- PATCH 1 sets mf_flags as MF_ACTION_REQUIRED on synchronous events which
  indicates error happened in current execution context
- PATCH 2 separates synchronous error handling into task work so that the
  current context in memory failure is exactly belongs to the task
  consuming poison data.

Then, kernel will send SIGBUS with proper si_code in kill_proc().

Lv Ying and XiuQi also proposed to address similar problem and we discussed
about new solution to add a new flag(acpi_hest_generic_data::flags bit 8) to
distinguish synchronous event. [2][3] The UEFI community still has no response.
After a deep dive into the SDEI TRM, the SDEI notification should be used for
asynchronous error. As SDEI TRM[1] describes "the dispatcher can simulate an
exception-like entry into the client, **with the client providing an additional
asynchronous entry point similar to an interrupt entry point**". The client
(kernel) lacks complete synchronous context, e.g. systeam register (ELR, ESR,
etc). So notify type is enough to distinguish synchronous event.

[1] https://developer.arm.com/documentation/den0054/latest/
[2] https://lore.kernel.org/linux-arm-kernel/20221205160043.57465-4-xiexiuqi@huawei.com/T/
[3] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/

Shuai Xue (2):
  ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
    synchronous events
  ACPI: APEI: handle synchronous exceptions in task work

 drivers/acpi/apei/ghes.c | 134 ++++++++++++++++++++++++---------------
 include/acpi/ghes.h      |   3 -
 mm/memory-failure.c      |  13 ----
 3 files changed, 82 insertions(+), 68 deletions(-)

-- 
2.20.1.12.g72788fdb

