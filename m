Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E05A61F21C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKGLpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGLpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:45:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0724BCE1C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:45:06 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5TpG3lCQzpWG1;
        Mon,  7 Nov 2022 19:41:26 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 19:45:04 +0800
Message-ID: <a5a79265-be08-0375-ad50-fbe568c7a769@huawei.com>
Date:   Mon, 7 Nov 2022 19:45:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] tracing: fix memory leak in tracing_read_pipe
To:     <linux-kernel@vger.kernel.org>
CC:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
References: <1667819090-4643-1-git-send-email-wangyufen@huawei.com>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <1667819090-4643-1-git-send-email-wangyufen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/7 19:04, Wang Yufen 写道:
> kmemleak reports this issue:
>
> unreferenced object 0xffff888105a18900 (size 128):
>    comm "test_progs", pid 18933, jiffies 4336275356 (age 22801.766s)
>    hex dump (first 32 bytes):
>      25 73 00 90 81 88 ff ff 26 05 00 00 42 01 58 04  %s......&...B.X.
>      03 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000560143a1>] __kmalloc_node_track_caller+0x4a/0x140
>      [<000000006af00822>] krealloc+0x8d/0xf0
>      [<00000000c309be6a>] trace_iter_expand_format+0x99/0x150
>      [<000000005a53bdb6>] trace_check_vprintf+0x1e0/0x11d0
>      [<0000000065629d9d>] trace_event_printf+0xb6/0xf0
>      [<000000009a690dc7>] trace_raw_output_bpf_trace_printk+0x89/0xc0
>      [<00000000d22db172>] print_trace_line+0x73c/0x1480
>      [<00000000cdba76ba>] tracing_read_pipe+0x45c/0x9f0
>      [<0000000015b58459>] vfs_read+0x17b/0x7c0
>      [<000000004aeee8ed>] ksys_read+0xed/0x1c0
>      [<0000000063d3d898>] do_syscall_64+0x3b/0x90
>      [<00000000a06dda7f>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> iter->fmt alloced in
>    tracing_read_pipe() -> .. ->trace_iter_expand_format(), but not
> freed, to fix, add free in tracing_release_pipe()
Fixes: efbbdaa22bb7 ("tracing: Show real address for trace event arguments")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
> v1 -> v2: del if (iter->fmt), free iter->fmt directly
>   kernel/trace/trace.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 47a44b0..f9d98e7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6657,6 +6657,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
>   	mutex_unlock(&trace_types_lock);
>   
>   	free_cpumask_var(iter->started);
> +	kfree(iter->fmt);
>   	mutex_destroy(&iter->mutex);
>   	kfree(iter);
>   
