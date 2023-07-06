Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27207492E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjGFBH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjGFBHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:07:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB319B6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=iQqo5x5ASxaDOXphmezbHNaxmBUaEyFkfXvLc83mOGo=; b=zRDoN3qEUjHuy7RTXPwxyb0INc
        dD6LQK1IxCTYDbLUHuJhcaQJRKQt/y+50rm94fHw1qhEVprzVIROEAV8+EgcBdPMcakpRnLj5FhuQ
        nwINYIfskDdQaWhxLni7a+gh0N50kRR4ooq6yLTc4nVFPdSogY5Itdj2GHBgvNwpYJ8yuZtIuy3ER
        DLKadYAx5Mm0Ee0xbGFiHUljJH2f5yh10LPLQPcU5t0cfK2/X54MU2+jERJz7PVuqok6ULpt6PjTS
        TMTAjJ1Kf5B0L5MD1LW38FkWCOnsbA0emlxZars03ss4O3Ywf1Rrn8LDE7881EQEXzD9+KnSacJrZ
        +L2bJEAg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHDTF-00HX3a-26;
        Thu, 06 Jul 2023 01:07:45 +0000
Message-ID: <1a970ae7-73fd-71e4-770e-120295454753@infradead.org>
Date:   Wed, 5 Jul 2023 18:07:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Input: gameport - use IS_REACHABLE() instead of
 open-coding it
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
References: <ZKYLLmsdCH0Gp7TO@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZKYLLmsdCH0Gp7TO@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/23 17:30, Dmitry Torokhov wrote:
> Replace an open-coded preprocessor conditional with an equivalent helper.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/gameport.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/gameport.h b/include/linux/gameport.h
> index 0a221e768ea4..07e370113b2b 100644
> --- a/include/linux/gameport.h
> +++ b/include/linux/gameport.h
> @@ -63,7 +63,7 @@ struct gameport_driver {
>  int gameport_open(struct gameport *gameport, struct gameport_driver *drv, int mode);
>  void gameport_close(struct gameport *gameport);
>  
> -#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
> +#if IS_REACHABLE(CONFIG_GAMEPORT)
>  
>  void __gameport_register_port(struct gameport *gameport, struct module *owner);
>  /* use a define to avoid include chaining to get THIS_MODULE */

-- 
~Randy
