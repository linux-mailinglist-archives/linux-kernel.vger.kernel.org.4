Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972A060C606
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiJYIDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiJYIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:03:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310CF1217CA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:03:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C482C6179F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ACFC433C1;
        Tue, 25 Oct 2022 08:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666685030;
        bh=iKZ9L6XQYTjbomYIALBIoJz7OhjhMBgsFWK7m/jg9WM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TmLpmgX6orVa+JF/rfSX3T9dN0pwy/i2TLN4oO0yFD+j8wcoU7Loef9QYd9bYGjeq
         5Hdh8bI0W4qZFvVMYUWdk6dahiHcFHPf5QncQEVqPXLr8l7bBXJ3oKMSg9970z0e+J
         HiSGNPPrFRjas1AW8+CUrmpslZvaQ4fsTCN/30OyV7ifEGfZhNPkpoK1/daiKLpOl/
         qBRLOBanmdZ+zWq67kztX59WtpsdMzJOmoPB8ySmpV2ZqOY0Vch1CsZQzJp7GWH2pr
         0DO8Z6aX9ngO4Mq/FPUbV9soLTFpxDU8Raookc7q7dwXTHWyPPMKwQtI4qOUoNLXO+
         We9JrOygh90aw==
Date:   Tue, 25 Oct 2022 17:03:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobe: Check rethook_alloc() return in rethook
 initialization
Message-Id: <20221025170346.2fbd0158e98882dd09812431@kernel.org>
In-Reply-To: <20221025031209.954836-1-rafaelmendsr@gmail.com>
References: <20221025031209.954836-1-rafaelmendsr@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 00:12:08 -0300
Rafael Mendonca <rafaelmendsr@gmail.com> wrote:

> Check if fp->rethook succeeded to be allocated. Otherwise, if
> rethook_alloc() fails, then we end up dereferencing a NULL pointer in
> rethook_add_node().

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  kernel/trace/fprobe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index aac63ca9c3d1..71614b2a67ff 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -141,6 +141,8 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
>  		return -E2BIG;
>  
>  	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
> +	if (!fp->rethook)
> +		return -ENOMEM;
>  	for (i = 0; i < size; i++) {
>  		struct fprobe_rethook_node *node;
>  
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
