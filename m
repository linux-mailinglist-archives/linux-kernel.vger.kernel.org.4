Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323C268215D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjAaB0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAaBZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:25:58 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84E4222EF;
        Mon, 30 Jan 2023 17:25:53 -0800 (PST)
Received: from dggpemm500015.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P5S4F0sPPzRnvL;
        Tue, 31 Jan 2023 09:23:41 +0800 (CST)
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 09:25:51 +0800
Subject: Re: [PATCH v3 1/8] ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <ndesaulniers@google.com>, <ojeda@kernel.org>,
        <peterz@infradead.org>, <rafael.j.wysocki@intel.com>,
        <revest@chromium.org>, <robert.moore@intel.com>,
        <rostedt@goodmis.org>, <will@kernel.org>,
        "liwei (GF)" <liwei391@huawei.com>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
 <20230123134603.1064407-2-mark.rutland@arm.com>
 <f2f5dfc6-3deb-9fce-a9be-9386e844a9cf@huawei.com>
 <Y9ebIY/pWz0Ms9S6@FVFF77S0Q05N>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <60ec7607-7c5c-1a6e-18c9-8025cb2f289f@huawei.com>
Date:   Tue, 31 Jan 2023 09:25:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <Y9ebIY/pWz0Ms9S6@FVFF77S0Q05N>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/30 18:25, Mark Rutland 写道:
> On Sat, Jan 28, 2023 at 04:46:48PM +0800, Wangshaobo (bobo) wrote:
>> 锟斤拷 2023/1/23 21:45, Mark Rutland 写锟斤拷:
>>> +config DYNAMIC_FTRACE_WITH_CALL_OPS
>>> +	def_bool y
>>> +	depends on HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
>>> +
>> Hi Mark,
> 
> Hi,
> 
>> I have test your patches and it looks fine with my sample module,
> 
> Thanks for testing!
> 
>> but here setting DYNAMIC_FTRACE_WITH_CALL_OPS to y immutably may increase the
>> .text section size by 5% or more, how about making this to optional^^
> 
> We could consider making this optional. I had not made this optional so far as
> in the future I'd like to make this the only implementation of ftrace on arm64
> (once we can drop the old mcount version, and once we've sorted out the
> incompatibility with CFI). In the mean time, it probably makes sense to have
> the option at least to enable testing of each of the two forms.
> 
> Is your concern that the overall kernel image size is larger, or do you care
> specifically about the size of the .text section for some reason?
> 
> Thanks,
> Mark
Embedded devices may pay more attention to Image size, and which may 
also indirectly affects performance, for more reason, I think making 
sense to have the option for testing is more important.

-- Wang ShaoBo
> 
>>
>> -- Wang ShaoBo
>>>    config DYNAMIC_FTRACE_WITH_ARGS
>>>    	def_bool y
>>>    	depends on DYNAMIC_FTRACE
>>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>>> index 442438b93fe9..e634b80f49d1 100644
