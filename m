Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259276A3BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjB0HbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:31:03 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5B81ABCA;
        Sun, 26 Feb 2023 23:31:01 -0800 (PST)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PQBwt0KKhzrSJV;
        Mon, 27 Feb 2023 15:30:22 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 15:30:27 +0800
Message-ID: <42e9b829-196b-25b2-7c10-c64748af25d9@huawei.com>
Date:   Mon, 27 Feb 2023 15:30:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf v2] riscv, bpf: fix patch_text implicit declaration
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230227072016.14618-1-rdunlap@infradead.org>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230227072016.14618-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/27 15:20, Randy Dunlap wrote:
> bpf_jit_comp64.c uses patch_text(), so add <asm/patch.h> to it
> to prevent the build error:
> 
> ../arch/riscv/net/bpf_jit_comp64.c: In function 'bpf_arch_text_poke':
> ../arch/riscv/net/bpf_jit_comp64.c:691:23: error: implicit declaration of function 'patch_text'; did you mean 'path_get'? [-Werror=implicit-function-declaration]
>    691 |                 ret = patch_text(ip, new_insns, ninsns);
>        |                       ^~~~~~~~~~
> 
> Fixes: 596f2e6f9cf4 ("riscv, bpf: Add bpf_arch_text_poke support for RV64")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202302271000.Aj4nMXbZ-lkp@intel.com
> Cc: Pu Lehui <pulehui@huawei.com>
> Cc: Luke Nelson <luke.r.nels@gmail.com>
> Cc: Xi Wang <xi.wang@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: "Björn Töpel" <bjorn@kernel.org>
> Cc: linux-riscv@lists.infradead.org
> ---
> v2: add header file directly to bpf_jit_comp64.c (Pu Lehui)
>      change patch target to bpf (for fixes)
> 
>   arch/riscv/net/bpf_jit_comp64.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff -- a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -10,6 +10,7 @@
>   #include <linux/filter.h>
>   #include <linux/memory.h>
>   #include <linux/stop_machine.h>
> +#include <asm/patch.h>
>   #include "bpf_jit.h"
>   
>   #define RV_REG_TCC RV_REG_A6

Acked-by: Pu Lehui <pulehui@huawei.com>
