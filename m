Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB893624EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiKKAa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiKKAa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:30:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92BD5F85F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:30:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 680FB61B72
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDD1C433D6;
        Fri, 11 Nov 2022 00:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668126653;
        bh=E8OWUAKrryfJud/jmliD20nEzOX2ekYdwxQz9rVIpE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c6H+BxopOYinNbwbpKq24DZ0ACUed3MYmJYa6Tj4zKS38VGBcXvT18qDbHrmZI2Up
         5Wy2+6QEiKzx6BUQ+lsh1ESakQgClwihuSdY3oHu+S8Y/+xJISSZag5H5aocMtL4yk
         zzTI7vbQiR0GfH+4tNo8jMkJFnzIu8Hzp2UyKVvw2YhfPCtM79NzEj0M9w+hGfxnDM
         UXKUQ2ea7jhnWPIybOJCByD/UJUIKQDadv/h+9GoR1boBNLAKuK/YtOHJshRgOOPgs
         HiCg7rwmbCbyBZjr9u5ntSfykkkdH+s2g1C7NqSXbO2WquxxunuAZ+VuBufV/m6HNI
         zSbk6pGRqQPsg==
Date:   Fri, 11 Nov 2022 09:30:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yi Yang <yiyang13@huawei.com>
Cc:     <rostedt@goodmis.org>, <ast@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix a potential memleak in rethook_alloc()
Message-Id: <20221111093050.554a3403256c429d33915ebd@kernel.org>
In-Reply-To: <20221110104438.88099-1-yiyang13@huawei.com>
References: <20221110104438.88099-1-yiyang13@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 18:44:38 +0800
Yi Yang <yiyang13@huawei.com> wrote:

> In rethook_alloc(), the variable rh is not freed or passed out
> if handler is NULL, which could lead to a memleak, fix it.
> 

Oops, good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  kernel/trace/rethook.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 01df98db2fbe..f50aebc7698e 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -91,8 +91,10 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler, gfp_t gfp,
>  {
>  	struct rethook *rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
>  
> -	if (!rh || !handler)
> +	if (!rh || !handler) {
> +		kfree(rh);
>  		return NULL;
> +	}
>  
>  	rh->data = data;
>  	rh->handler = handler;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
