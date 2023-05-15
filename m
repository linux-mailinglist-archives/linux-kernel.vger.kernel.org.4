Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852AB702C21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbjEOL6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbjEOL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:58:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074532D60
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:55:40 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QKd780JgPzsRpS;
        Mon, 15 May 2023 19:53:40 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 19:55:37 +0800
Message-ID: <c9b6939c-f072-c4aa-b721-3cd0b2fd5635@huawei.com>
Date:   Mon, 15 May 2023 19:55:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] riscv: fix kprobe __user string arg print fault issue
Content-Language: en-US
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230504072910.3742842-1-ruanjinjie@huawei.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230504072910.3742842-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On 2023/5/4 15:29, Ruan Jinjie wrote:
> On riscv qemu platform, when add kprobe event on do_sys_open() to show
> filename string arg, it just print fault as follow:
> 
> echo 'p:myprobe do_sys_open dfd=$arg1 filename=+0($arg2):string flags=$arg3
> mode=$arg4' > kprobe_events
> 
> bash-166     [000] ...1.   360.195367: myprobe: (do_sys_open+0x0/0x84)
> dfd=0xffffffffffffff9c filename=(fault) flags=0x8241 mode=0x1b6
> 
> bash-166     [000] ...1.   360.219369: myprobe: (do_sys_open+0x0/0x84)
> dfd=0xffffffffffffff9c filename=(fault) flags=0x8241 mode=0x1b6
> 
> bash-191     [000] ...1.   360.378827: myprobe: (do_sys_open+0x0/0x84)
> dfd=0xffffffffffffff9c filename=(fault) flags=0x98800 mode=0x0
> 
> As riscv do not select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
> the +0($arg2) addr is processed as a kernel address though it is a
> userspace address, cause the above filename=(fault) print. So select
> ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to avoid the issue, after that the
> kprobe trace is ok as below:
> 
> bash-166     [000] ...1.    96.767641: myprobe: (do_sys_open+0x0/0x84)
> dfd=0xffffffffffffff9c filename="/dev/null" flags=0x8241 mode=0x1b6
> 
> bash-166     [000] ...1.    96.793751: myprobe: (do_sys_open+0x0/0x84)
> dfd=0xffffffffffffff9c filename="/dev/null" flags=0x8241 mode=0x1b6
> 
> bash-177     [000] ...1.    96.962354: myprobe: (do_sys_open+0x0/0x84)
> dfd=0xffffffffffffff9c filename="/sys/kernel/debug/tracing/events/kprobes/"
> flags=0x98800 mode=0x0
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Acked-by: Björn Töpel <bjorn@rivosinc.com>
> ---
> v2:
> - add the config in alphabetical order
> ---
> v3:
> - change signed-off-by to use full name
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d2967fefa1d7..b08ed929e220 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -26,6 +26,7 @@ config RISCV
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MMIOWB
> +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PMEM_API
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SET_DIRECT_MAP if MMU
