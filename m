Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23B6C3FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCVBsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCVBsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:48:30 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13CDBF2;
        Tue, 21 Mar 2023 18:48:29 -0700 (PDT)
Received: from [10.128.10.193] (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 5BCED58042A;
        Wed, 22 Mar 2023 09:48:23 +0800 (CST)
Message-ID: <5f7b6ecb-7729-e9d9-5a13-24ad74a4bb83@sangfor.com.cn>
Date:   Wed, 22 Mar 2023 09:48:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 1/2] function_graph: Support recording and printing the
 return value of function
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230321084650.769212-1-pengdonglin@sangfor.com.cn>
 <20230321084650.769212-2-pengdonglin@sangfor.com.cn>
 <89607a60-d3a7-4f89-84ae-bf3e65efb487@spud>
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <89607a60-d3a7-4f89-84ae-bf3e65efb487@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBhPVhpITB1NTU5IHh9KT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6Kio6Kz0UHxU9KSkCFxo*
        PyhPCUhVSlVKTUxCT09CTEtPTk1KVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFISUtCNwY+
X-HM-Tid: 0a870700c6d92eb7kusn5bced58042a
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/22 6:27, Conor Dooley wrote:
> On Tue, Mar 21, 2023 at 01:46:49AM -0700, Donglin Peng wrote:
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index c5e42cc37604..3efa4f645a39 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -139,6 +139,7 @@ config RISCV
>>   	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>>   	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>>   	select HAVE_FUNCTION_GRAPH_TRACER
>> +	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>>   	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> 
> BTW, and this is such a minor nit, but if you end up having to do a respin
> of this for some other reason, would you mind adding the new option in
> alphabetical order?

Thanks, no problem.

> 
> Thanks,
> Conor.

