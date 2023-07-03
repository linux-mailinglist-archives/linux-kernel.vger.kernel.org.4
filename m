Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392CD745991
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGCKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjGCKDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:03:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6763E1997;
        Mon,  3 Jul 2023 03:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F125160EA8;
        Mon,  3 Jul 2023 10:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10676C433C7;
        Mon,  3 Jul 2023 10:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688378514;
        bh=lBNCeBSaDVPbahPrODhFzB0mv9GW3qx5Y2qThueabmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XdgLcRzE0839ClMwDo2BfuZiHpg0hGkfYm72QUXNB67Fndw0qZ8DElRfdzKnLDBSq
         x2qgT1GRJbxQ5sNcTPO+XgYZw624/QwMIPGKZJyUJ142AaZikmPUri44fTjYPoslQA
         jD/4EsLqQtxDMRnuEe2Rcx/Ze9ghtmAERW63are3KozWcZTAaOOG7vmQi24WzEnNxn
         v9GgFoHf+xaodyqsU61h3maEP7C/3Qc1+a/UrK0/2eneRdq1SkyF5vkEmSgTy498c4
         yekJomhAgHJOA5Lcnx/cX9oVAGLKnVNp8lWlmp7Yc1Gwkj3rLD2VbI93mh2uFnZssC
         jVy3GVv/53Tww==
Date:   Mon, 3 Jul 2023 19:01:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>,
        Yafang <laoar.shao@gmail.com>
Subject: Re: [PATCH v2] fprobe: add unlock to match a succeeded
 ftrace_test_recursion_trylock
Message-Id: <20230703190150.1451de6be0388b64d51c8530@kernel.org>
In-Reply-To: <20230703092336.268371-1-zegao@tencent.com>
References: <20230703092336.268371-1-zegao@tencent.com>
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

On Mon,  3 Jul 2023 17:23:36 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Unlock ftrace recursion lock when fprobe_kprobe_handler() is failed
> because of some running kprobe.
> 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

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
