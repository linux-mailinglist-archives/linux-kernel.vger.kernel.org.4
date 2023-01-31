Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8DC682646
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAaIX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjAaIX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:23:27 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA880125A3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:23:24 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P5dHJ30kGzJqr9;
        Tue, 31 Jan 2023 16:18:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 16:23:20 +0800
Message-ID: <78883f84-dceb-9b24-b1f3-321d84091a85@huawei.com>
Date:   Tue, 31 Jan 2023 16:23:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5.10] arm64: fix a concurrency issue in
 emulation_proc_handler()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <haibinzhang@tencent.com>, <hewenliang4@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230131065211.2826133-1-ruanjinjie@huawei.com>
 <Y9jC2msv2q39+ZA1@kroah.com>
Content-Language: en-US
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <Y9jC2msv2q39+ZA1@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/31 15:27, Greg KH wrote:
> On Tue, Jan 31, 2023 at 02:52:11PM +0800, ruanjinjie wrote:
>> This patch is addressing an issue in stable linux-5.10 only.
>>
>> In linux-6.1, the related code is refactored in 124c49b1b("arm64:
>> armv8_deprecated: rework deprected instruction handling") and
>> this issue was incidentally fixed. However, the patch changes a lot and
>> is not specific to this issue.
> 
> Then what about 5.15.y?  You can not upgrade to that kernel and have a
> regression, right?

This patch has a pre-dependency af483947d ("arm64: fix oops in
concurrently setting insn_emulation sysctls"), which has not merged into
branches except 5.10.y, so the other branches don't apply.

> 
> And nit, you need a ' ' before the '(' character.
> 
> But why can we just not take the original commit that fixed this issue?
> That way almost always is the best (prevents regressions, makes
> backports easier, is actually tested, etc.) ?

Thank you! It is ok to take the original commit to fix this issue.

> 
> thanks,
> 
> greg k-h
