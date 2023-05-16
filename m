Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AEF704451
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjEPEZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjEPEZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7189468E;
        Mon, 15 May 2023 21:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C183625E2;
        Tue, 16 May 2023 04:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8036CC433D2;
        Tue, 16 May 2023 04:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684211120;
        bh=PY/RoOzkUy2hM6zBTkR44gqIGTp4DWfEnEc7SqX2Ea0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CyFJjn/IUHl2FfBle4tevPAFdK50g8q94ecGv8r5F/56N2qnXWP1VnrFQdZl+uJWG
         uNQzg/b23zTfejXabX3Fvz8TYB1bsWxz+afGK6a9oXkkIOOy6XSa/B6NhOiCGSNnzR
         8/TS2vea6ybEkEy+A4WIG6FbW2AoaxhU7sD2+BXIKx41n2aVnSWYZbvOOa/nA/iuxR
         /kHphWmksO9OBrPbfnNCooVJ9lGbSbjlEGD3VhPHEYRVh3BoAY7Nh2J/AV3HbjfBsl
         wfcchnh/fIbT3v2vo9su/S7G5CV8zU2WwywofAKxxxuGibPqHxvfLyGjP3I7pHpu6M
         Mf0BUPRCNt/PA==
Date:   Tue, 16 May 2023 13:25:16 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Ze Gao <zegao@tencent.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] fprobe: add recursion detection in
 fprobe_exit_handler
Message-Id: <20230516132516.c902edcf21028874a74fb868@kernel.org>
In-Reply-To: <5f8081030f6f5d5af56c93fff95f0a7fadde04ad.1684120990.git.zegao@tencent.com>
References: <cover.1684120990.git.zegao@tencent.com>
        <5f8081030f6f5d5af56c93fff95f0a7fadde04ad.1684120990.git.zegao@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 11:26:40 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> fprobe_hander and fprobe_kprobe_handler has guarded ftrace recusion
> detection but fprobe_exit_handler has not, which possibly introduce
> recurive calls if the fprobe exit callback calls any traceable
> functions. Checking in fprobe_hander or fprobe_kprobe_handler
> is not enough and misses this case.

Good catch! Yes, this can fix such recursive call case because if
we put a fprobe to the exit of the "func()", recursive call happens
as below;

func() {
} => rethook 
  => fprobe_exit_handler()
  => fp->exit_handler() {
     func() {
     } => rethook
       => fprobe_exit_handler()
       => fp->exit_handler() {
          func() {
          } => rethook ...

Note that this should not happen with fprobe-based events because
all the code (except for tests) under kernel/trace/ are marked
notrace automatically.

kretprobe avoids this by setting itself to current_kprobe, thus the
other kprobes recursively called from the rethook will be skipped.

> 
> So add recusion free guard the same way as fprobe_hander and also
> mark fprobe_exit_handler notrace. Since ftrace recursion check does
> not employ ips, so here use entry_ip and entry_parent_ip the same as
> fprobe_handler.

Looks good to me.

Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  kernel/trace/fprobe.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index ad9a36c87ad9..cf982d4ab142 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -17,6 +17,7 @@
>  struct fprobe_rethook_node {
>  	struct rethook_node node;
>  	unsigned long entry_ip;
> +	unsigned long entry_parent_ip;
>  	char data[];
>  };
>  
> @@ -39,6 +40,7 @@ static inline notrace void __fprobe_handler(unsigned long ip, unsigned long
>  		}
>  		fpr = container_of(rh, struct fprobe_rethook_node, node);
>  		fpr->entry_ip = ip;
> +		fpr->entry_parent_ip = parent_ip;
>  		if (fp->entry_data_size)
>  			entry_data = fpr->data;
>  	}
> @@ -109,19 +111,30 @@ static void notrace fprobe_kprobe_handler(unsigned long ip, unsigned long parent
>  	ftrace_test_recursion_unlock(bit);
>  }
>  
> -static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> +static void notrace fprobe_exit_handler(struct rethook_node *rh, void *data,
>  				struct pt_regs *regs)
>  {
>  	struct fprobe *fp = (struct fprobe *)data;
>  	struct fprobe_rethook_node *fpr;
> +	int bit;
>  
>  	if (!fp || fprobe_disabled(fp))
>  		return;
>  
>  	fpr = container_of(rh, struct fprobe_rethook_node, node);
>  
> +	/* we need to assure no calls to traceable functions in-between the
> +	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
> +	 */
> +	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
> +	if (bit < 0) {
> +		fp->nmissed++;
> +		return;
> +	}
> +
>  	fp->exit_handler(fp, fpr->entry_ip, regs,
>  			 fp->entry_data_size ? (void *)fpr->data : NULL);
> +	ftrace_test_recursion_unlock(bit);
>  }
>  NOKPROBE_SYMBOL(fprobe_exit_handler);
>  
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
