Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40279745725
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGCITV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjGCITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:19:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2751BC;
        Mon,  3 Jul 2023 01:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4154C60E03;
        Mon,  3 Jul 2023 08:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753B2C433C7;
        Mon,  3 Jul 2023 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688372348;
        bh=S6K5lbYba39Qtr6yqajXnkhBq5MftnwZTHANEwn50OU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YxwKUOyiwj2JWrtI4HkQ8chRNGbJZYVqAQLc170isvJdA41at3zf8JLdHNDCeTSF4
         SG84RUYvLC1foPz7IHr+CPyUhHLQSQ9x4/J5BCNK+JvgnCr69/0BwrFfLNoIDrVQWd
         lx2+4USKiENJ3DKmrb971MZ7TFvj9zT0Hix0XhLF8hAUcORaLwsDIV2GBS/e8HOFJH
         oXIxdyApz2cGITzJCk7IX+6+E0T5YAxPadke81wJy78GCLpNvsK9QqK2Z7jZE2hRru
         wTvmnW3tWJ816231stuf6uc4nXLmpbR1xi3F1n3FrrJOkasrpAjLIcmMA7Gf22vFSp
         VRvlid3jrNxfQ==
Date:   Mon, 3 Jul 2023 17:19:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>,
        Yafang <laoar.shao@gmail.com>
Subject: Re: [PATCH] fprobe: add unlock to match a succeeded
 ftrace_test_recursion_trylock
Message-Id: <20230703171905.ef83b1a7f4db82012db471fc@kernel.org>
In-Reply-To: <20230703071640.106204-1-zegao@tencent.com>
References: <20230703071640.106204-1-zegao@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jul 2023 15:16:40 +0800
Ze Gao <zegao2021@gmail.com> wrote:

Good catch! but please add description here, something like;

----
Unlock ftrace recursion lock when fprobe_kprobe_handler() is failed
because another kprobe is running.
----

The code itself is OK to me.


> Fixes: 3cc4e2c5fbae ("fprobe: make fprobe_kprobe_handler recursion free")
> Reported-by: Yafang <laoar.shao@gmail.com>
> Closes: https://lore.kernel.org/linux-trace-kernel/CALOAHbC6UpfFOOibdDiC7xFc5YFUgZnk3MZ=3Ny6we=AcrNbew@mail.gmail.com/
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  kernel/trace/fprobe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 18d36842faf5..93b3e361bb97 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -102,12 +102,14 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
>  
>  	if (unlikely(kprobe_running())) {
>  		fp->nmissed++;
> -		return;
> +		goto recursion_unlock;
>  	}
>  
>  	kprobe_busy_begin();
>  	__fprobe_handler(ip, parent_ip, ops, fregs);
>  	kprobe_busy_end();
> +
> +recursion_unlock:
>  	ftrace_test_recursion_unlock(bit);
>  }
>  
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
