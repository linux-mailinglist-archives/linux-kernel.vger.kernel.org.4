Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490286C4321
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCVG0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCVG0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:26:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79C95A19D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:26:51 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PhJM05jlKzSnX0;
        Wed, 22 Mar 2023 14:23:24 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 14:26:48 +0800
Message-ID: <6d1859b0-20f3-05a8-d8d6-dfb0c9985985@huawei.com>
Date:   Wed, 22 Mar 2023 14:26:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
From:   Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     "Gowans, James" <jgowans@amazon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230317095300.4076497-1-jgowans@amazon.com>
 <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
 <001d516c1bb6f0b6d2344f1ae160e796d003c24c.camel@amazon.com>
Content-Language: en-US
In-Reply-To: <001d516c1bb6f0b6d2344f1ae160e796d003c24c.camel@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/17 19:49, Gowans, James 写道:
> On Fri, 2023-03-17 at 18:12 +0800, Yipeng Zou wrote:
>> It seems that we have the same solution.
> That's a good sign! :D
>
>> (I introduced a new flow handler).
> I considered this, but IMO a new handler isn't the way to go: we already have a
> bit of handler proliferation going on here. As mentioned in my commit message
> there this is starting to get closer to handle_edge_eoi_irq, and adding a new
> generic handler which is a mix of the two existing seems to just add more
> confusion: which one should a driver owner use? I think it'll be great if we can
> enhance the existing generic handlers to cater for the various edge cases and
> perhaps even merge these generic handlers in future.
>
> What are your thoughts on this approach compared to your proposal?

Hi,

I also agree with you, enhance the existing generic handlers is a good 
way to go.

Too many generic handlers really confuse developers.

> There is also the "delay the affinity change of LPI until the next interrupt
> acknowledge" option described in the previous thread [0]. I also considered that
> but seeing as the handle_edge_irq does the approach implemented here of setting
> the PENDING flag and then re-running it, it seemed like good prior art to draw
> on. Is that option of enabling CONFIG_GENERIC_PENDING_IRQ a viable? IMO the
> generic handlers should be resilient to this so I would prefer this fix than
> depending on the user to know to set this config option.


About CONFIG_GENERIC_PENDING_IRQ is actually some attempts we made 
before under the suggestion of Thomas.

This patch is valid for our problem. However, the current config is only 
supported on x86, and some code modifications are required on arm.

In our patch, the config cannot be perfectly supported on arm like x86. 
Refer to the patch below.

This has led to some changes in the original behavior of modifying 
interrupting affinity, from the next interrupt taking effect to the next 
to the next interrupt taking effect.

So, in general, I also prefer the fix which make generic handlers be 
resilient than introduce an CONFIG_GENERIC_PENDING_IRQ for gic.


diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index 1cb392fb16d0..64cfa5e38d89 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1678,6 +1678,12 @@ static int its_select_cpu_other(const struct 
cpumask *mask_val)
  }
  #endif

+static void its_irq_chip_eoi(struct irq_data *d)
+{
+       irq_move_irq(d);
+       irq_chip_eoi_parent(d);
+}
+
  static int its_set_affinity(struct irq_data *d, const struct cpumask 
*mask_val,
                             bool force)
  {
@@ -2026,7 +2032,7 @@ static struct irq_chip its_irq_chip = {
         .name                   = "ITS",
         .irq_mask               = its_mask_irq,
         .irq_unmask             = its_unmask_irq,
-       .irq_eoi                = irq_chip_eoi_parent,
+       .irq_eoi                = its_irq_chip_eoi,
         .irq_set_affinity       = its_set_affinity,
         .irq_compose_msi_msg    = its_irq_compose_msi_msg,
         .irq_set_irqchip_state  = its_irq_set_irqchip_state,
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index ab5505d8caf1..3c829bb4f649 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -33,7 +33,9 @@ config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ

  # Support for delayed migration from interrupt context
  config GENERIC_PENDING_IRQ
-       bool
+       bool "Support for delayed migration from interrupt context"
+       depends on SMP
+       default n

  # Support for generic irq migrating off cpu before the cpu is offline.
  config GENERIC_IRQ_MIGRATION
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index def48589ea48..bcb61ee69c20 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -117,3 +117,5 @@ void __irq_move_irq(struct irq_data *idata)
         if (!masked)
                 idata->chip->irq_unmask(idata);
  }
+
+void __weak irq_force_complete_move(struct irq_desc *desc) { }

> JG
>
> [0]https://lore.kernel.org/all/b0f2623b-ec70-d57e-b744-26c62b1ce523@huawei.com/

-- 
Regards,
Yipeng Zou

