Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434E8644813
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiLFPeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiLFPeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:34:04 -0500
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0822B26B;
        Tue,  6 Dec 2022 07:34:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=0;PH=DS;RN=16;SR=0;TI=SMTPD_---0VWhZXz6_1670340837;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VWhZXz6_1670340837)
          by smtp.aliyun-inc.com;
          Tue, 06 Dec 2022 23:33:59 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        jarkko@kernel.org, naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com
Subject: [RFC PATCH 0/2] ACPI: APEI: handle synchronous exceptions in task work
Date:   Tue,  6 Dec 2022 23:33:52 +0800
Message-Id: <20221206153354.92394-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, both synchronous and asynchronous error are queued and handled by a
dedicated kthread in workqueue. Memory failure for synchronous error is
synced by a trick.

Although the task could be killed by page fault, the memory failure is handled
in a kthread context so that the hwpoison-aware mechanisms, e.g. PF_MCE_EARLY,
early kill, does not work as expected.

To this end, separate synchronous and asynchronous error handling into
different paths like X86 does:

- task work for synchronous error.
- and workqueue for asynchronous error.

This patch set is based on a new UEFI proposal submitted by our colleague Yingwen.[1]

> Background:
> 
> In ARM world, two type events (Sync/Async) from hardware IP need OS/VMM take different actions. 
> Current CPER memory error record is not able to distinguish sync/async type event right now. 
> Current OS/VMM need to take extra actions beyond CPER which is heavy burden to identify the 
> two type events
>  
> Sync event (e.g. CPU consume poisoned data) --> Firmware  -> CPER error log  --> OS/VMM take recovery action.
> Async event (e.g. Memory controller detect UE event)  --> Firmware  --> CPER error log  --> OS take page action. 
> 
> 
> Proposal: 
>
> - In section description Flags field(UEFI spec section N.2, add sync flag as below. OS/VMM 
>  could depend on this flag to distinguish sync/async events.
> - Bit8 – sync flag; if set this flag indicates that this event record is synchronous(e.g. 
>  cpu core consumes poison data, then cause instruction/data abort); if not set, this event record is asynchronous.
> 
> Best regards,
> Yingwen Chen
> 
> [ Shuai Xue: The thread is only opened to the member of UEFI Workgroup.
>   Paste here for discussion.]

[1] https://members.uefi.org/wg/uswg/mail/thread/9453

Shuai Xue (2):
  ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
    synchronous events
  ACPI: APEI: separate synchronous error handling into task work

 drivers/acpi/apei/ghes.c | 120 ++++++++++++++++++++++-----------------
 include/linux/cper.h     |  22 +++++++
 2 files changed, 89 insertions(+), 53 deletions(-)

-- 
2.20.1.12.g72788fdb

