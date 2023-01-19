Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163B0674C22
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjATFYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjATFXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:23:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7F60C81
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:14:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C86ABB82765
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBBEC433D2;
        Thu, 19 Jan 2023 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674168554;
        bh=mBN/CU96RiOPQ5ULurpXP5crKGOGzo0h80wqyemm7QQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PjjWKl0x6mxV6BNughICjS6f8CFVbMBIc+tbx4ma0I+YUnaA4K8ZqIUNiLWaH8T4h
         k+1Nf1NzxL4dSnoX2O8K1hXdeYKqYZeAZ5oGbmMr1gJ2V1sRRDhnBYWPS9LyIUjr2y
         chABfUjVghTpHD4HnJczxS3GDuH56PadgcFIEM0nW5jMQATBUqGXrYbNH4W/LyuyDL
         LdIVX+7hoLy7uwiDnogSfvKMSAdeKtxlvA13KU4NVZTEj/xY5CtJGKms0Mu3Tl9bqt
         QwcVqCwfNgjIgXUWLcSwnZkHHyEZSz9fdp5oxtQRzpYhleOHDmirC4sGtjqLOmsbtA
         RABKmsre4yNgQ==
Date:   Fri, 20 Jan 2023 07:49:10 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: fix single & used for logical
 condition
Message-Id: <20230120074910.966fdeea1fe670c25be7670d@kernel.org>
In-Reply-To: <20230112114215.17103-1-antonio.feijoo@suse.com>
References: <20230112114215.17103-1-antonio.feijoo@suse.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 12:42:15 +0100
Antonio Alvarez Feijoo <antonio.feijoo@suse.com> wrote:

> A single & will create a background process and return true, so the grep
> command will run even if the file checked in the first condition does not
> exist.
> 

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
> ---
>  tools/bootconfig/scripts/ftrace2bconf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
> index 6183b36c6846..1603801cf126 100755
> --- a/tools/bootconfig/scripts/ftrace2bconf.sh
> +++ b/tools/bootconfig/scripts/ftrace2bconf.sh
> @@ -93,7 +93,7 @@ referred_vars() {
>  }
>  
>  event_is_enabled() { # enable-file
> -	test -f $1 & grep -q "1" $1
> +	test -f $1 && grep -q "1" $1
>  }
>  
>  per_event_options() { # event-dir
> -- 
> 2.35.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
