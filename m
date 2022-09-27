Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69E5EB6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiI0BTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiI0BTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:19:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D6DEF5;
        Mon, 26 Sep 2022 18:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12A8AB80D31;
        Tue, 27 Sep 2022 01:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C2DC433C1;
        Tue, 27 Sep 2022 01:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664241571;
        bh=XsqzGj/zWuZsitseB/D9my2WzhOclfA82mFT1se7Bik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCENPE6xAox7qXTh8VWWEZvvlBRGB76QvIe+cde8DgHNI55slk4LqtHgN/r5wKaoG
         lfn7i/EtyH4ITQ5AjeI05OUJsUCemvFKjF+QhocRcmHScijPhMsdKCWyYXP1lTmuyE
         zISZK787nRioUnirFCNJB/amFXd5GB+Sb938z8DaMLamsOFZeJNdxD52vHIA+GRBdB
         HOZRp8ly6CSGj4D95ubbcRQcQ/4LZ6QB4sSDGTYGOTlfrUGUc/rfSngzSUIw+VZ2Mq
         cPwaKL2E24298y/aQr/MnlbzHwLHimfG14BUGLVuss4+KWR5Y7NibQplFCmtcyTSQa
         m29NtP4drsP5g==
Date:   Mon, 26 Sep 2022 20:19:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] w1: Split memcpy() of struct cn_msg flexible array
Message-ID: <YzJPnsps2R1f+mxE@work>
References: <20220927003927.1942170-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927003927.1942170-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 05:39:27PM -0700, Kees Cook wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated.
> 
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/
> 
> Cc: Evgeniy Polyakov <zbr@ioremap.net>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  drivers/w1/w1_netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
> index fa490aa4407c..db110cc442b1 100644
> --- a/drivers/w1/w1_netlink.c
> +++ b/drivers/w1/w1_netlink.c
> @@ -611,7 +611,8 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
>  		}
>  		atomic_set(&block->refcnt, 1);
>  		block->portid = nsp->portid;
> -		memcpy(&block->request_cn, cn, sizeof(*cn) + cn->len);
> +		block->request_cn = *cn;
> +		memcpy(block->request_cn.data, cn->data, cn->len);
>  		node = (struct w1_cb_node *)(block->request_cn.data + cn->len);
>  
>  		/* Sneeky, when not bundling, reply_size is the allocated space
> -- 
> 2.34.1
> 
