Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF372FDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbjFNMC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243772AbjFNMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:02:54 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 869BF1996
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:02:52 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.116])
        by gateway (Coremail) with SMTP id _____8AxX+trrIlkRB4FAA--.10899S3;
        Wed, 14 Jun 2023 20:02:51 +0800 (CST)
Received: from [10.20.42.116] (unknown [10.20.42.116])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax6ORqrIlk3pQaAA--.10230S3;
        Wed, 14 Jun 2023 20:02:50 +0800 (CST)
Subject: Re: [PATCH V1 0/4] irqchip/loongson: Fix some loongson irqchip
 drivers
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn
Reply-To: loongson-kernel@lists.loongnix.cn
References: <20230614111426.5545-1-lvjianmin@loongson.cn>
Message-ID: <526be6a1-b965-a694-def9-c0a6c1693327@loongson.cn>
Date:   Wed, 14 Jun 2023 20:02:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230614111426.5545-1-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax6ORqrIlk3pQaAA--.10230S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr4xJr13Jry3Ar4kKFykJFc_yoW3Jwc_CF
        WI9rs7ur4Igr4xXay29ry0vFy3WFWjg3Wq9ryqq34rW39ag3Wayr4akwnxGa1xGF48GFn3
        ZrsYgryfA347CosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbqAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7
        McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F
        4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUI0eHUU
        UUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

So sorry for this wrong series which is old, please skip them.

Thanks.
Jianmin

On 2023/6/14 下午7:14, Jianmin Lv wrote:
> The patch series provide some fixes for loongson-liointc and loongson-pch-pic driver.
> 
> Jianmin Lv (2):
>    irqchip/loongson-pch-pic: Fix initialization of HT vector register
>    irqchip/loongson-liointc: Fix IRQ trigger polarity
> 
> Liu Peibao (1):
>    irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment
> 
> Yinbo Zhu (1):
>    irqchip/loongson-liointc: Add IRQCHIP_SKIP_SET_WAKE flag
> 
>   drivers/irqchip/irq-loongson-liointc.c |  9 +++++----
>   drivers/irqchip/irq-loongson-pch-pic.c | 10 ++++------
>   2 files changed, 9 insertions(+), 10 deletions(-)
> 

