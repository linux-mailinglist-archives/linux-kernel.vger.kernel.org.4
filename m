Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F55713A75
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjE1QBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjE1QBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A71B2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 09:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7464360B6A
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 16:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800BBC433D2;
        Sun, 28 May 2023 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685289707;
        bh=ZSx3cN26RRXAFdFdF6AibUO0wV80iZxnw1MftFAxYoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWmKjD0ImUXOQOJZndc2nsL9yflp+kIBQScghbG00CjSP1sd+jis59pMnjl9ZfGxS
         ozkQeFLtPEz59OVAa75zMevyBb1Ghy/bRcnKEj9OeoOEstcZD6wFiuIoCb05I8cslc
         oqzTaEzgAKuWKU3h5wWRY+SgIdA41k8LLidlqPtw=
Date:   Sun, 28 May 2023 17:01:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: rtl8192e: Rename variable SetWirelessMode
Message-ID: <2023052837-half-pretended-e024@gregkh>
References: <cover.1685284727.git.yogi.kernel@gmail.com>
 <5a1ee0e9ef53ebe6085c14dba08c438862ec992e.1685284727.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a1ee0e9ef53ebe6085c14dba08c438862ec992e.1685284727.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 08:21:33PM +0530, Yogesh Hegde wrote:
> Rename variable SetWirelessMode to set_wireless_mode to avoid
> CamelCase which is not accepted by checkpatch.
> 
> Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
>  drivers/staging/rtl8192e/rtllib.h            |  2 +-
>  drivers/staging/rtl8192e/rtllib_softmac.c    | 12 ++++++------
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index 17b70dde7eeb..699c4accf2db 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -716,7 +716,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
>  	priv->rtllib->check_nic_enough_desc	= _rtl92e_check_nic_enough_desc;
>  	priv->rtllib->handle_assoc_response	= _rtl92e_handle_assoc_response;
>  	priv->rtllib->handle_beacon		= _rtl92e_handle_beacon;
> -	priv->rtllib->SetWirelessMode		= rtl92e_set_wireless_mode;
> +	priv->rtllib->set_wireless_mode		= rtl92e_set_wireless_mode;

As this is only set in one place, why is it needed at all?  Why not just
call the real function instead?

Same for the other patches in this series, why not turn this into a set
of cleanup patches removing the unnecessary indirection and removing the
CamelCase variables entirely?

thanks,

greg k-h
