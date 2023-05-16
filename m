Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835BA70439E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEPCxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEPCxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:53:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97706E58
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:53:08 -0700 (PDT)
Received: from dggpemm500003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QL12g6S5WzsRv1;
        Tue, 16 May 2023 10:51:07 +0800 (CST)
Received: from [10.67.145.254] (10.67.145.254) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 10:53:06 +0800
Message-ID: <5e42a892-3826-6370-9702-fefee88bf339@hisilicon.com>
Date:   Tue, 16 May 2023 10:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] irqchip: gic-v3: Collection table support muti pages
To:     Marc Zyngier <maz@kernel.org>
References: <1684152604-12621-1-git-send-email-wangwudi@hisilicon.com>
 <86jzx9n4qg.wl-maz@kernel.org>
 <41cbc6cb4e964fe0bbba87f52110b1c3@hisilicon.com>
From:   wangwudi <wangwudi@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <41cbc6cb4e964fe0bbba87f52110b1c3@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.145.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/16 9:57, wangwudi 写道:
> 
> 
> -----邮件原件-----
> 发件人: Marc Zyngier [mailto:maz@kernel.org] 
> 发送时间: 2023年5月15日 20:45
> 收件人: wangwudi <wangwudi@hisilicon.com>
> 抄送: linux-kernel@vger.kernel.org; Thomas Gleixner <tglx@linutronix.de>
> 主题: Re: [PATCH] irqchip: gic-v3: Collection table support muti pages
> 
> On Mon, 15 May 2023 13:10:04 +0100,
> wangwudi <wangwudi@hisilicon.com> wrote:
>>
>> Only one page is allocated to the collection table.
>> Recalculate the page number of collection table based on the number of 
>> CPUs.
> 
> Please document *why* we should even consider this. Do you know of any existing implementation that is so large (or need so much memory for its collection) that it would result in overflowing the collection table?

Each CPU occupies an entry in the collection table. When there are a large number of CPUs and only one page of the collection table, some CPUs fail to execute ITS-MAPC cmd, and fail to receive LPI interrupts.

For example, GITS_BASER indicates that the page_size of the collection table is 4 KB, the entry size is 16 Bytes, and only 256 entries can be stored on one page.
When the number of CPUs is more than 256(which is common in the SMP system of the server), the subsequent CPUs cannot receive the LPI.

It is noticed by code review, not by on actual HW.

> 
> Thanks,
> 
> 	M.
> 
> --
> Without deviation from the norm, progress is not possible.
