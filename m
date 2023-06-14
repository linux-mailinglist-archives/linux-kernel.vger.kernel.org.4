Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F362D730818
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbjFNTXC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjFNTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:23:00 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A7D26AB;
        Wed, 14 Jun 2023 12:22:37 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q9W4f-002h8x-3E; Wed, 14 Jun 2023 21:22:33 +0200
Received: from p57bd9486.dip0.t-ipconnect.de ([87.189.148.134] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q9W4e-0012Wx-KO; Wed, 14 Jun 2023 21:22:33 +0200
Message-ID: <63d247d3de5a0ca289c39dff930f83d7bbc7c4a5.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Replace all non-returning strlcpy with strscpy
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-hardening@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Date:   Wed, 14 Jun 2023 21:22:31 +0200
In-Reply-To: <20230530163041.985456-1-azeemshaikh38@gmail.com>
References: <20230530163041.985456-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.134
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 16:30 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  arch/sh/drivers/dma/dma-api.c |    2 +-
>  arch/sh/kernel/setup.c        |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
> index ab9170494dcc..89cd4a3b4cca 100644
> --- a/arch/sh/drivers/dma/dma-api.c
> +++ b/arch/sh/drivers/dma/dma-api.c
> @@ -198,7 +198,7 @@ int request_dma(unsigned int chan, const char *dev_id)
>  	if (atomic_xchg(&channel->busy, 1))
>  		return -EBUSY;
>  
> -	strlcpy(channel->dev_id, dev_id, sizeof(channel->dev_id));
> +	strscpy(channel->dev_id, dev_id, sizeof(channel->dev_id));
>  
>  	if (info->ops->request) {
>  		result = info->ops->request(channel);
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index af977ec4ca5e..e4f0f9a1d355 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -304,9 +304,9 @@ void __init setup_arch(char **cmdline_p)
>  	bss_resource.end = virt_to_phys(__bss_stop)-1;
>  
>  #ifdef CONFIG_CMDLINE_OVERWRITE
> -	strlcpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
> +	strscpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
>  #else
> -	strlcpy(command_line, COMMAND_LINE, sizeof(command_line));
> +	strscpy(command_line, COMMAND_LINE, sizeof(command_line));
>  #ifdef CONFIG_CMDLINE_EXTEND
>  	strlcat(command_line, " ", sizeof(command_line));
>  	strlcat(command_line, CONFIG_CMDLINE, sizeof(command_line));

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
