Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC06A6C407C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCVCmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVCmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:42:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153293C7BF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:42:11 -0700 (PDT)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PhCP40LY7zKsyG;
        Wed, 22 Mar 2023 10:39:52 +0800 (CST)
Received: from [10.174.186.25] (10.174.186.25) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 10:42:08 +0800
Message-ID: <e1f373f2-59ec-dc26-1624-f4b9d4ede254@huawei.com>
Date:   Wed, 22 Mar 2023 10:42:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] arm64/signal: Add tpidr2/za/zt sigframe size in
 comment
To:     Mark Brown <broonie@kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <20230317124915.1263-1-sundongxu3@huawei.com>
 <20230317124915.1263-4-sundongxu3@huawei.com>
 <e47440be-5dcd-4d2c-b7ff-8d45c9f82537@sirena.org.uk>
Content-Language: en-US
From:   Dongxu Sun <sundongxu3@huawei.com>
In-Reply-To: <e47440be-5dcd-4d2c-b7ff-8d45c9f82537@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500004.china.huawei.com (7.185.36.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/17 21:03, Mark Brown wrote:
> On Fri, Mar 17, 2023 at 08:49:14PM +0800, Dongxu Sun wrote:
> 
>>   *	0x8a0		sve_context (vl <= 64) (optional)
>> + *	 0x10		tpidr2_context (optional)
>> + *	 0x10		za_context (optional)
> 
> The size of the ZA context is variable, going with what the SVE has a VL
> which might fit into the base context should be included but that's
> complicated what with it likely appearing after another variably sized
> frame.
> 
>> + *	 0x10		zt_context (optional)
> 
> The ZT context is never this small, it's always got register contents if
> present.

The context size of ZA and ZT here is wrong due to oversight. The ZA context size is related to the SVL, and the ZT context size may also get changed with further extensions.
> 
>>   *	 0x20		extra_context (optional)
>>   *	 0x10		terminator (null _aarch64_ctx)
>>   *
>> - *	0x510		(reserved for future allocation)
>> + *	0x4e0		(reserved for future allocation)
> 
> TBH I'm not sure this comment is actually useful or helpful, it's
> already not fully taking into account the variablility of the SVE frame
> size (quoting a fixed value) and with the way we allocate things once
> we've gone into the extra_context we'll allocate new frames from there
> so even smaller frames like the tpidr2_context will go there.  I'm not
> sure trying to suggest a layout/ordering is clarifying anything for
> anyone.

Thanks for your point, considering the scalability of SME/SME2, maybe there is no need to add layout suggestion. So, let's discard this commit:)

Thanks，
Dongxu

