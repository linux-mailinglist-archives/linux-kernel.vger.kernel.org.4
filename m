Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D4D71902E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjFABs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFABsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:48:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5BA3;
        Wed, 31 May 2023 18:48:52 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QWpqy5DdHzLqM9;
        Thu,  1 Jun 2023 09:45:50 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 09:48:49 +0800
Subject: Re: [PATCH] acpi: Fix header declaration of acpi_arch_dma_setup() w/o
 CONFIG_ACPI
To:     Dave Jiang <dave.jiang@intel.com>, <lpieralisi@kernel.org>,
        <sudeep.holla@arm.com>
CC:     kernel test robot <lkp@intel.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <168477156440.3873520.6153672647621739139.stgit@djiang5-mobl3>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0953941a-ad4e-ba7e-4f4e-64c47de71f0b@huawei.com>
Date:   Thu, 1 Jun 2023 09:48:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <168477156440.3873520.6153672647621739139.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Sorry for the late reply, I have some comments inline.

On 2023/5/23 0:06, Dave Jiang wrote:
> arm64 build can be done without CONFIG_ACPI. The ifdef bits for
> acpi_arch_dma_setup() is placed inside CONFIG_ACPI. When CONFIG_ACPI is
> not set, this causes warning reported by kernel test bot. Move the
> prototype declaration for acpi_arch_dma_setup() outside of CONFIG_ACPI.

...

> 
>>> drivers/acpi/arm64/dma.c:7:6: warning: no previous prototype for function 'acpi_arch_dma_setup' [-Wmissing-prototypes]
>     void acpi_arch_dma_setup(struct device *dev)
>          ^
>     drivers/acpi/arm64/dma.c:7:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void acpi_arch_dma_setup(struct device *dev)
>     ^
>     static
>     1 warning generated.

drivers/acpi can only be compiled with CONFIG_ACPI=y, so
drivers/acpi/arm64/ will be the same, not sure how to trigger
this compile warning.

I disable CONFIG_ACPI on my ARM64 machine, but didn't get the
warning you reported.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305200933.afKCLlxS-lkp@intel.com/

How to generate the kernel config file as you kindly attached in the
link?

Thanks
Hanjun
