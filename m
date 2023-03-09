Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4B6B2ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCIQcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCIQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:31:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EF9E20FC;
        Thu,  9 Mar 2023 08:23:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9563661C31;
        Thu,  9 Mar 2023 16:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B060C433EF;
        Thu,  9 Mar 2023 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678378664;
        bh=q9RjBZs+ERaxIV0omkTJ1hSNgg0RjEI7/KoY1XKuSyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVhVYbvVqbdH2W69+wx8yTauEYWo0avO97NQe507F8tsK4F2Hte8WTtGIKAVkVf23
         dis1Kce8ox34FbnT/tTE/5/8ozmdX88XWnaNdteMxf4stuKuUWqaYHxQfm6E3eWspg
         anntKbMr0SzOEEfAU8A2wj3O+z2O90FDKm1SELV8=
Date:   Thu, 9 Mar 2023 17:17:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 21/24] kbuild, serial: remove MODULE_LICENSE in
 non-modules
Message-ID: <ZAoGpW+TnpRPMRdR@kroah.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
 <20230217141059.392471-22-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217141059.392471-22-nick.alcock@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:10:56PM +0000, Nick Alcock wrote:
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
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-unisoc@lists.infradead.org
> Cc: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/rda-uart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
> index be5c842b5ba9..c3b29d124759 100644
> --- a/drivers/tty/serial/rda-uart.c
> +++ b/drivers/tty/serial/rda-uart.c
> @@ -825,4 +825,3 @@ module_exit(rda_uart_exit);
>  
>  MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
>  MODULE_DESCRIPTION("RDA8810PL serial device driver");
> -MODULE_LICENSE("GPL");

No, this should be fine, either force remove all MODULE_* macros from
built-in code, or none.

thanks,

greg k-h
