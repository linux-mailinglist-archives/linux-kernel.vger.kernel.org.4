Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24D8747580
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjGDPmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGDPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:42:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA59E7E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:42:42 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QwRnl1rrLzLndS;
        Tue,  4 Jul 2023 23:40:27 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 23:42:38 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1: Properly lock VPEs when doing a
 directLPI invalidation
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kunkun Jiang <jiangkunkun@huawei.com>,
        <wanghaibin.wang@huawei.com>
References: <20230617073242.3199746-1-maz@kernel.org>
 <b665e102-eba9-cd4f-5b4e-ccbd77444233@huawei.com>
 <86wmzgx1va.wl-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <ee9123ca-95fc-4482-cee1-965cfe6b89b4@huawei.com>
Date:   Tue, 4 Jul 2023 23:42:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <86wmzgx1va.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2023/7/4 2:54, Marc Zyngier wrote:
> On Thu, 29 Jun 2023 15:52:24 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> Hi Marc,
>>
>> Nit: I think the Subject header can be changed to 'irqchip/gic-v4' as
>> the bug it fixes only affects GICv4 HW. v4.1 is unaffected.
> 
> I'm not so sure.
> 
> v4.0 didn't allow direct invalidation of VPE doorbells (we had to use
> the fake device hack), except for the HiSi special that implemented
> DirectLPI despite the presence of multiple ITSs. It was a violation of
> the architecture, but it really saved the day by making invalidations
> cheap enough.

[ I should've mentioned that I had reproduced the bug and tested your
patch on my 920, which is, yeah, a HiSi implementation of GICv4.0 with
DirectLPI supported. But ]

> 
> Only with v4.1 did we get architectural support for doorbell
> invalidation via a register instead of a command for a fake device.
> 
> So as far as the architecture is concerned, this should only affect
> v4.1. As a side effect, it also affect HiSi's v4.0 implementations.

... iiuc the bug we're fixing is that we perform a register based
invalidation for doorbells (via its_vpe_[un]mask_irq/its_vpe_send_inv),
acquire and release the per-RD lock with a *race* against a concurrent
its_map_vm(), which would modify the vpe->col_idx behind our backs and
affect the lock we're looking for.

its_vpe_[un]mask_irq() are callbacks for the v4.0 irqchip, i.e.,
its_vpe_irq_chip.

With v4.1, we switch to use its_vpe_4_1_irq_chip and invalidate
doorbells by sending the new INVDB command (and shouldn't be affected by
this bug).

Thanks,
Zenghui
