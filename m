Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DDF7428E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjF2Owi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjF2Owf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:52:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254052D56
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:52:31 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QsLyJ335hz1HBZb;
        Thu, 29 Jun 2023 22:52:08 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 22:52:25 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1: Properly lock VPEs when doing a
 directLPI invalidation
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kunkun Jiang <jiangkunkun@huawei.com>,
        <wanghaibin.wang@huawei.com>
References: <20230617073242.3199746-1-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <b665e102-eba9-cd4f-5b4e-ccbd77444233@huawei.com>
Date:   Thu, 29 Jun 2023 22:52:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20230617073242.3199746-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2023/6/17 15:32, Marc Zyngier wrote:
> We normally rely on the irq_to_cpuid_[un]lock() primitives to make
> sure nothing will change col->idx while performing a LPI invalidation.

"change col_idx while performing a vLPI invalidation"?

> However, these primitives do not cover VPE doorbells, and we have
> some open-coded locking for that. Unfortunately, this locking is
> pretty bogus.
> 
> Instead, extend the above primitives to cover VPE doorbells and
> convert the whole thing to it.
> 
> Fixes: f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual exclusion between vPE affinity change and RD access")
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: wanghaibin.wang@huawei.com

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Nit: I think the Subject header can be changed to 'irqchip/gic-v4' as
the bug it fixes only affects GICv4 HW. v4.1 is unaffected.

Thanks,
Zenghui
