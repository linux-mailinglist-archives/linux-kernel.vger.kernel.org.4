Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739B2648EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLJNgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLJNgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:36:06 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677E717073;
        Sat, 10 Dec 2022 05:36:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=0;PH=DS;RN=19;SR=0;TI=SMTPD_---0VWy3O4v_1670679359;
Received: from 30.221.144.117(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VWy3O4v_1670679359)
          by smtp.aliyun-inc.com;
          Sat, 10 Dec 2022 21:36:00 +0800
Message-ID: <81dc3225-bd4c-22d6-ba62-b12f26e655e3@linux.alibaba.com>
Date:   Sat, 10 Dec 2022 21:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 0/4] arm64: improve handle synchronous External Data
 Abort
Content-Language: en-US
To:     Xie XiuQi <xiexiuqi@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, james.morse@arm.com, rafael@kernel.org,
        tony.luck@intel.com, robert.moore@intel.com, bp@alien8.de,
        devel@acpica.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tanxiaofei@huawei.com, wangxiongfeng2@huawei.com,
        lvying6@huawei.com, naoya.horiguchi@nec.com,
        wangkefeng.wang@huawei.com,
        Bixuan Cui <cuibixuan@linux.alibaba.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20221205160043.57465-1-xiexiuqi@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20221205160043.57465-1-xiexiuqi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/6 AM12:00, Xie XiuQi wrote:
> This series fix some issue for arm64 synchronous External Data Abort.
> 
> 1. fix unhandled processor error
> According to the RAS documentation, if we cannot determine the impact
> of the error based on the details of the error when an SEA occurs, the
> process cannot safely continue to run. Therefore, for unhandled error,
> we should signal the system and terminate the process immediately.
> 
> 2. improve for handling memory errors
> 
> If error happened in current execution context, we need pass
> MF_ACTION_REQUIRED flag to memory_failure(), and if memory_failure()
> recovery failed, we must handle this case, other than ignore it.
> 
> ---
> v3: add improve for handing memory errors
> v2: fix compile warning reported by kernel test robot.
> 
> Xie XiuQi (4):
>   ACPI: APEI: include missing acpi/apei.h
>   arm64: ghes: fix error unhandling in synchronous External Data Abort
>   arm64: ghes: handle the case when memory_failure recovery failed
>   arm64: ghes: pass MF_ACTION_REQUIRED to memory_failure when sea
> 
>  arch/arm64/kernel/acpi.c      |  6 ++++++
>  drivers/acpi/apei/apei-base.c |  5 +++++
>  drivers/acpi/apei/ghes.c      | 31 ++++++++++++++++++++++++-------
>  include/acpi/apei.h           |  1 +
>  include/linux/mm.h            |  2 +-
>  mm/memory-failure.c           | 24 +++++++++++++++++-------
>  6 files changed, 54 insertions(+), 15 deletions(-)
> 

Hi, XiuQi,

As we discussed, if you want to fix this problem before the new UEFI version comes out,
you need a another patch separated synchronous error handling into task work when SEA
notification is used. Be careful that do not break error handling of other notification
type.

A reference code is pasted bellow.

Thank you.

Best Regards,
Shuai

----

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 57cae48ebc1f..1982a5e3fd8c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -445,15 +445,71 @@ static void ghes_kick_task_work(struct callback_head *head)
 	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
 }

+/**
+ * struct mce_task_work - for synchronous RAS event
+ *
+ * @twork:                callback_head for task work
+ * @pfn:                  page frame number of corrupted page
+ * @flags:                fine tune action taken
+ *
+ * Structure to pass task work to be handled before
+ * ret_to_user via task_work_add().
+ */
+struct mce_task_work {
+	struct callback_head twork;
+	u64 pfn;
+	int flags;
+};
+
+static void memory_failure_cb(struct callback_head *twork)
+{
+	int rc;
+	struct mce_task_work *twcb =
+		container_of(twork, struct mce_task_work, twork);
+
+	rc = memory_failure(twcb->pfn, twcb->flags);
+	kfree(twcb);
+
+	if (!rc)
+		return;
+	/*
+	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
+	 * to the current process with the proper error info,
+	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
+	 *
+	 * In both cases, no further processing is required.
+	 */
+	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
+		return;
+
+	pr_err("Memory error not recovered");
+	force_sig(SIGBUS);
+}
+
 static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 {
 	unsigned long pfn;
+	struct mce_task_work *twcb;

 	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
 		return false;

 	pfn = PHYS_PFN(physical_addr);
-	memory_failure_queue(pfn, flags);
+
+	if (flags == MF_ACTION_REQUIRED && task->mm) {
+		twcb = kmalloc(sizeof(*twcb), GFP_ATOMIC);
+		if (!twcb)
+			return false;
+
+		twcb->pfn = pfn;
+		twcb->flags = flags;
+		init_task_work(&twcb->twork, memory_failure_cb);
+		task_work_add(current, &twcb->twork, TWA_RESUME);
+		return false;
+	} else {
+		memory_failure_queue(pfn, flags);
+	}
+
 	return true;
 }

-- 
2.20.1.12.g72788fdb
