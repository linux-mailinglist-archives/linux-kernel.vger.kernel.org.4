Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206726D3BD3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjDCCdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDCCda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:33:30 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A21AF1C;
        Sun,  2 Apr 2023 19:33:29 -0700 (PDT)
Received: from [10.128.10.193] (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 3C5025805A8;
        Mon,  3 Apr 2023 10:33:10 +0800 (CST)
Message-ID: <f4eabd56-2f91-05fc-b882-9dd8328f87ae@sangfor.com.cn>
Date:   Mon, 3 Apr 2023 10:33:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 8/8] selftests/ftrace: Add funcgraph-retval test case
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, chenhuacai@kernel.org,
        zhangqing@loongson.cn, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
 <ba23c2429f1ef798946ce65e21c7a7a2bff0019e.1680265828.git.pengdonglin@sangfor.com.cn>
 <20230402070406.177f09cc34f9860baf3e6ec2@kernel.org>
Content-Language: en-US
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <20230402070406.177f09cc34f9860baf3e6ec2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTU9LVh8fS0pNTk5KGEhJGFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6Mhw*Fz0KEjo4Kig4OkMw
        UUsKFEtVSlVKTUNLT0NCSkJJS0hOVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFNSktDNwY+
X-HM-Tid: 0a8744f6185f2eb7kusn3c5025805a8
X-HM-MType: 1
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/2 6:04, Masami Hiramatsu (Google) wrote:
> On Fri, 31 Mar 2023 05:47:44 -0700
> Donglin Peng <pengdonglin@sangfor.com.cn> wrote:
> 
>> Add a test case for the funcgraph-retval and funcgraph-retval-hex
>> trace options.
>>
>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
>> ---
>> v10:
>>   - Fix issues in selftest
>>
>> v8:
>>   - Fix issues in selftest
>> ---
>>   .../ftrace/test.d/ftrace/fgraph-retval.tc     | 43 +++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>   create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
>> new file mode 100644
>> index 000000000000..5819aa2dd6ad
>> --- /dev/null
>> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
>> @@ -0,0 +1,43 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +# description: ftrace - function graph print function return value
>> +# requires: options/funcgraph-retval options/funcgraph-retval-hex function_graph:tracer
>> +
>> +# Make sure that funcgraph-retval works
>> +
>> +fail() { # msg
>> +    echo $1
>> +    exit_fail
>> +}
>> +
>> +disable_tracing
>> +clear_trace
>> +
>> +read PID _ < /proc/self/stat
> 
> You can use "$$" for self pid.

Yeah, I will fix it.

> 
>> +[ -f set_ftrace_pid ] && echo ${PID} > set_ftrace_pid
>> +[ -f set_ftrace_filter ] && echo proc_reg_write > set_ftrace_filter
>> +[ -f set_graph_function ] && echo proc_reg_write > set_graph_function
> 
> You should set the required files for this test, so that the test result
> is always same. BTW, you need to set either 'set_ftrace_filter' or
> 'set_graph_function'.

Yes, but I discovered that set_ftrace_filter and set_graph_function rely 
on the CONFIG_DYNAMIC_FTRACE configuration, which means that these two 
files are not present when CONFIG_DYNAMIC_FTRACE is disabled, even if 
CONFIG_FUNCTION_GRAPH_RETVAL is enabled. Therefore, I think that these 
two trace files are not necessary for this test.

I will modify the above like this:

[ -f set_ftrace_pid ] && echo $$ > set_ftrace_pid
[ -f set_ftrace_filter ] && echo proc_reg_write > set_ftrace_filter

> 
>> +echo function_graph > current_tracer
>> +echo funcgraph-retval > trace_options
>> +
>> +set +e
>> +enable_tracing
>> +echo > /proc/interrupts
>> +disable_tracing
>> +set -e
>> +
>> +: "Test printing the error code in signed decimal format"
>> +echo nofuncgraph-retval-hex > trace_options
> 
> echo 0 > options/funcgraph-retval-hex
> 
> If you require 'options/funcgraph-retval-hex' file, you can use the
> file to set it or clear it.

Yeah.

> 
>> +count=`cat trace | grep 'proc_reg_write' | grep '= -5' | wc -l`
>> +if [ $count -eq 0 ]; then
>> +    fail "Return value can not be printed in signed decimal format"
>> +fi
>> +
>> +: "Test printing the error code in hexadecimal format"
>> +echo funcgraph-retval-hex > trace_options
> 
> Ditto.

Thanks.

> 
> Thanks,
> 
>> +count=`cat trace | grep 'proc_reg_write' | grep 'fffffffb' | wc -l`
>> +if [ $count -eq 0 ]; then
>> +    fail "Return value can not be printed in hexadecimal format"
>> +fi
>> +
>> +exit 0
>> -- 
>> 2.25.1
>>
> 
> 

