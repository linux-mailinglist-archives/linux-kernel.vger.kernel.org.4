Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9412F6C288B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 04:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCUDZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 23:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCUDY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 23:24:56 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167892138;
        Mon, 20 Mar 2023 20:24:53 -0700 (PDT)
Received: from [10.128.10.193] (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 30C125801B8;
        Tue, 21 Mar 2023 11:24:45 +0800 (CST)
Message-ID: <1446d966-1b7d-322e-bdd9-d0cb4506c080@sangfor.com.cn>
Date:   Tue, 21 Mar 2023 11:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/2] tracing: Add documentation for funcgraph-retval
 and graph_retval_hex
To:     Ding Hui <dinghui@sangfor.com.cn>, mhiramat@kernel.org,
        rostedt@goodmis.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, huangcun@sangfor.com.cn,
        dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230320131650.482594-1-pengdonglin@sangfor.com.cn>
 <20230320131650.482594-3-pengdonglin@sangfor.com.cn>
 <4a88721a-ac78-bcad-1b33-f9027baab5ab@sangfor.com.cn>
Content-Language: en-US
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <4a88721a-ac78-bcad-1b33-f9027baab5ab@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQh5OVkhDGUlOSxgZTUoaT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDI6Vio*Kz0XVhAWQzQXL04v
        SgMaCzFVSlVKTUxCSE1CS0NNT0pNVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFIQ0hKNwY+
X-HM-Tid: 0a870232a40f2eb7kusn30c125801b8
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/21 10:31, Ding Hui wrote:
> On 2023/3/20 21:16, Donglin Peng wrote:
> 
>> +There are some limitations when using the funcgraph-retval currently:
>> +
>> +- Even if the function return type is void, a return value will still
>> +  be printed, and you can just ignore it.
>> +
>> +- Even if the return value is not an error code actually, it may be
>> +  displayed as an error code. You should read the code to check.
>> +  For example, both 0xfe and 0xfffe are be interpreted as -2.
> 
> For char and short types, displaying as signed decimal may be not 
> appropriate, because they are rarely used to store error code.
> 
> So in "smart" mode (graph_retval_hex=0), I suggest just smart convert 
> error value stored in int or pointer to signed decimal.

Yeah, I will remove the return value conversion for char and short
types in the "smart" mode.

> 
>> +- Only the value of the first return register will be recorded and
>> +  printed even if the return values may be stored in two registers
>> +  actually. For example, both the eax and edx are used to store a
>> +  64 bit return value in the x86 architecture, and the eax stores
>> +  the low 32 bit, the edx stores the high 32 bit, however only the
>> +  value stored in eax will be recorded and printed.
>> +
>>   You can put some comments on specific functions by using
>>   trace_printk() For example, if you want to put a comment inside
>>   the __might_sleep() function, you just have to include
> 

