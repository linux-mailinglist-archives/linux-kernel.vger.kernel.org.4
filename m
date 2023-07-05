Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA074846D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGEMwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGEMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:52:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BEFDA;
        Wed,  5 Jul 2023 05:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F89261512;
        Wed,  5 Jul 2023 12:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815CDC433C7;
        Wed,  5 Jul 2023 12:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688561554;
        bh=I3mgC95jaUMPNBZSpRVdhaB4W5ZRw3imLS94cfTIN9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pM+mAx14x75F4hkkJXR6PkXiVnUWsGQC8FbnRxNGNykH2r9VOM3ZvgtyKiSM5NJJe
         Q344nEKdB6H0KVtlyK2kjrObK2dedKZnRUoThVnRrHN303hr4aWxrsA7Xe5pOmNZ/+
         rFht9StA4UYUF5TcuJM8l2AV09e1DNcVYuogmKaMxROJFi372o2XogJP8Pz9TLGsYL
         3XiODM7vHVwGS7h815M9qFNW4nGTVfzG7sikJS1WY5vCPLPlgm7pQyYV7x+/u4+iBe
         xUtL/KVl4xQt8ySYDtN8eJIELTv3YZQdmB23tT5hEtneSOslXja1NqJS9yPEf08Uss
         Qy1yay7xQIrZQ==
Date:   Wed, 5 Jul 2023 21:52:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     m.stachyra@samsung.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>
Subject: Re: [PATCH v2] trace: fix null pointer dereference in
 tracing_err_log_open()
Message-Id: <20230705215230.9aafc44d8bd764b6416cf655@kernel.org>
In-Reply-To: <20230704102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f@eucms1p3>
References: <CGME20230704102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f@eucms1p3>
        <20230704102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f@eucms1p3>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2023 12:27:06 +0200
Mateusz Stachyra <m.stachyra@samsung.com> wrote:

> Fix an issue in function 'tracing_err_log_open'.
> The function doesn't call 'seq_open' if file is opened only with
> write permissions, which results in 'file->private_data' being left at null.
> If we then use 'lseek' on that opened file, 'seq_lseek' dereferences
> 'file->private_data' in 'mutex_lock(&m->lock)', resulting in a Kernel panic.
> Writing to this node requires root privilages, therefore this bug
> has very little security impact.
> 
> Tracefs node: /sys/kernel/tracing/error_log
> 
> Example Kernel panic:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
> Call trace:
>  mutex_lock+0x30/0x110
>  seq_lseek+0x34/0xb8
>  __arm64_sys_lseek+0x6c/0xb8
>  invoke_syscall+0x58/0x13c
>  el0_svc_common+0xc4/0x10c
>  do_el0_svc+0x24/0x98
>  el0_svc+0x24/0x88
>  el0t_64_sync_handler+0x84/0xe4
>  el0t_64_sync+0x1b4/0x1b8
> Code: d503201f aa0803e0 aa1f03e1 aa0103e9 (c8e97d02)
> ---[ end trace 561d1b49c12cf8a5 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> 

Good catch! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Mateusz Stachyra <m.stachyra@samsung.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b04f52e7c..4529e264c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8146,7 +8146,7 @@ static const struct file_operations tracing_err_log_fops = {
>  	.open           = tracing_err_log_open,
>  	.write		= tracing_err_log_write,
>  	.read           = seq_read,
> -	.llseek         = seq_lseek,
> +	.llseek         = tracing_lseek,
>  	.release        = tracing_err_log_release,
>  };
>  
> -- 
> 2.25.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
