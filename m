Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653375EA94C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiIZO4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiIZO4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:56:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D85A753A8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:26:52 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mbk2P1hz7zlXFv;
        Mon, 26 Sep 2022 21:22:37 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:26:51 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:26:50 +0800
Message-ID: <6fc308aa-a0ac-3f0e-b484-352512ad6793@huawei.com>
Date:   Mon, 26 Sep 2022 21:26:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ARM: mm: Provide better fault message for permission
 fault
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220919103845.100809-1-wangkefeng.wang@huawei.com>
 <YzF7X2PBdps2MaG/@shell.armlinux.org.uk>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YzF7X2PBdps2MaG/@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/26 18:13, Russell King (Oracle) wrote:
> On Mon, Sep 19, 2022 at 06:38:45PM +0800, Kefeng Wang wrote:
>> If there is a permission fault in __do_kernel_fault(), we only
>> print the generic "paging request" message which don't show
>> read, write or excute information, let's provide better fault
>> message for them.
> I don't like this change. With CPUs that do not have the ability to
> relocate the vectors to 0xffff0000, the vectors live at address 0,
> so NULL pointer dereferences can produce permission faults.
The __do_user_fault(), do_DataAbort() and do_PrefetchAbort() shows
the FSR when printing, we could do it in die_kernel_fault(), and
which will be easy for us to check whether the page fault is permision
fault,


--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -111,8 +111,8 @@ static void die_kernel_fault(const char *msg, struct 
mm_struct *mm,
  {
         bust_spinlocks(1);
         pr_alert("8<--- cut here ---\n");
-       pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
-                msg, addr);
+       pr_alert("Unable to handle kernel %s (0x%08x) at virtual address 
%08lx\n",
+                msg, fsr, addr);

         show_pte(KERN_ALERT, mm, addr);
         die("Oops", regs, fsr);


or,

> I would much rather we did something similar to what x86 does:
>
>          pr_alert("#PF: %s %s in %s mode\n",
>                   (error_code & X86_PF_USER)  ? "user" : "supervisor",
>                   (error_code & X86_PF_INSTR) ? "instruction fetch" :
>                   (error_code & X86_PF_WRITE) ? "write access" :
>                                                 "read access",
>                               user_mode(regs) ? "user" : "kernel");
>
> As we already print whether we're in user or kernel mode in the
> register dump, there's no need to repeat that. I think we just
> need an extra line to decode the FSR PF and write bits.

We could decode the FSR register,

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c

index 46cccd6bf705..406e0210c3c5 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -113,6 +113,10 @@ static void die_kernel_fault(const char *msg, 
struct mm_struct *mm,
         pr_alert("8<--- cut here ---\n");
         pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
                  msg, addr);
+       pr_alert("FSR: 0x%08x, LNX_PF = %u, CM = %u, WnR = %u\n", fsr,
+                (fsr & FSR_LNX_PF) >> FSR_LNX_PF_SHIFT,
+                (fsr & FSR_CM) >> FSR_CM_SHIFT,
+                (fsr & FSR_WRITE) >> FSR_WRITE_SHIFT);

         show_pte(KERN_ALERT, mm, addr);
         die("Oops", regs, fsr);
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index 83b5ab32d7a4..18f882aa2b32 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -5,9 +5,12 @@
  /*
   * Fault status register encodings.  We steal bit 31 for our own purposes.
   */
-#define FSR_LNX_PF             (1 << 31)
-#define FSR_CM                 (1 << 13)
-#define FSR_WRITE              (1 << 11)
+#define FSR_LNX_PF_SHIFT       (31)
+#define FSR_LNX_PF             (1 << FSR_LNX_PF_SHIFT)
+#define FSR_CM_SHIFT           (13)
+#define FSR_CM                 (1 << FSR_CM_SHIFT)
+#define FSR_WRITE_SHIFT                (11)
+#define FSR_WRITE              (1 << FSR_WRITE_SHIFT)
  #define FSR_FS4                        (1 << 10)
  #define FSR_FS3_0              (15)
  #define FSR_FS5_0              (0x3f)


What's your option ?

>
