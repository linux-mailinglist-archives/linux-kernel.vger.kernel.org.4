Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A926B2AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCIQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCIQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:26:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FE2FCF38;
        Thu,  9 Mar 2023 08:17:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96D061BE2;
        Thu,  9 Mar 2023 16:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947C6C433D2;
        Thu,  9 Mar 2023 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678378545;
        bh=jEtyFn2FXZA3T9nw4E7CtwAet6YXrxhbrziBkJKEJ2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=in3yu6IUuw8WLAUv4tdD3nlUL9qgJpyamatBw0+Pf24w1iCEYkAlLF9Ko6xv53aUw
         COJQeaHYJ1SczIynlj4jcoO1BNWziEA2cPYJV6V9mJ6ZXDTVq87bLzNW15lB1CBAXb
         CF5MvdxpwbSdshwq2wRy7tlve+XGpbhCH+vsstLU=
Date:   Thu, 9 Mar 2023 17:15:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZAoGLhRpTr5f7AD/@kroah.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-11-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302211759.30135-11-nick.alcock@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 09:17:52PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> ---
>  drivers/tty/n_null.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
> index f913b665af725..c24f75942c49d 100644
> --- a/drivers/tty/n_null.c
> +++ b/drivers/tty/n_null.c
> @@ -63,7 +63,6 @@ static void __exit n_null_exit(void)
>  module_init(n_null_init);
>  module_exit(n_null_exit);
>  
> -MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Alan Cox");
>  MODULE_ALIAS_LDISC(N_NULL);
>  MODULE_DESCRIPTION("Null ldisc driver");
> -- 
> 2.39.1.268.g9de2f9a303
> 

Nope, sorry, this is not good to do, please fix kbuild instead of
forcing a tree-wide change like this.

thanks,

greg k-h
