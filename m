Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D463A36B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiK1ItJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiK1ItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:49:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB60417E1E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:48:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0365B80C81
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3257C433D6;
        Mon, 28 Nov 2022 08:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669625326;
        bh=XRb735qlEpxeM/vWLXgV++AEzVzzKTenZnbr4YQUY4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qGEiYayTE42pOd+GlHtIiWhKh12yYBkmanbwLXYPKKLr/6JnJbJk3XN6tdM4aztrH
         Gvt95lu8Tli3yHPyQWSoRGRXM8iLH3p1UigCQFzw/jD1a0uq0uUEEX1E8wAwtca+fv
         tu8sJOLlwqF341C4jgmso+V5k0KOekJcBWcDHxef7t8efZ9s1IwPVGMroswKQhninM
         mgWlGp7s9VY+fA/BOpgAVElR6LbK1MZa7E0VecsHggXXhjuauvZe4HwrhuXCfmls7B
         NdsxWm7lRPnfE50AmyuIoRHtsN5fuxyoKtqZrzD1iZutWn8VhOEi0ma7htgXcepbYk
         eyw/IOHD/4ZLg==
Date:   Mon, 28 Nov 2022 17:48:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobes: Fix check for probe enabled in kill_kprobe()
Message-Id: <20221128174843.244d5485156daf53b6406482@kernel.org>
In-Reply-To: <20221126114316.201857-1-lihuafei1@huawei.com>
References: <20221126114316.201857-1-lihuafei1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2022 19:43:16 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> In kill_kprobe(), the check whether disarm_kprobe_ftrace() needs to be
> called always fails. This is because before that we set the
> KPROBE_FLAG_GONE flag for kprobe so that "!kprobe_disabled(p)" is always
> false.

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> The disarm_kprobe_ftrace() call introduced by commit:
> 
>   0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler")
> 
> to fix the NULL pointer reference problem. When the probe is enabled, if
> we do not disarm it, this problem still exists.
> 
> Fix it by putting the probe enabled check before setting the
> KPROBE_FLAG_GONE flag.
> 
> Fixes: 3031313eb3d54 ("kprobes: Fix to check probe enabled before disarm_kprobe_ftrace()")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  kernel/kprobes.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 3050631e528d..a35074f0daa1 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2364,6 +2364,14 @@ static void kill_kprobe(struct kprobe *p)
>  
>  	lockdep_assert_held(&kprobe_mutex);
>  
> +	/*
> +	 * The module is going away. We should disarm the kprobe which
> +	 * is using ftrace, because ftrace framework is still available at
> +	 * 'MODULE_STATE_GOING' notification.
> +	 */
> +	if (kprobe_ftrace(p) && !kprobe_disabled(p) && !kprobes_all_disarmed)
> +		disarm_kprobe_ftrace(p);
> +
>  	p->flags |= KPROBE_FLAG_GONE;
>  	if (kprobe_aggrprobe(p)) {
>  		/*
> @@ -2380,14 +2388,6 @@ static void kill_kprobe(struct kprobe *p)
>  	 * the original probed function (which will be freed soon) any more.
>  	 */
>  	arch_remove_kprobe(p);
> -
> -	/*
> -	 * The module is going away. We should disarm the kprobe which
> -	 * is using ftrace, because ftrace framework is still available at
> -	 * 'MODULE_STATE_GOING' notification.
> -	 */
> -	if (kprobe_ftrace(p) && !kprobe_disabled(p) && !kprobes_all_disarmed)
> -		disarm_kprobe_ftrace(p);
>  }
>  
>  /* Disable one kprobe */
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
