Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DDA6E9067
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjDTKhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjDTKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:36:50 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0657699
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:33:55 -0700 (PDT)
Received: from kandell (unknown [172.20.6.87])
        by mail.nic.cz (Postfix) with ESMTPS id 2D2591C1824;
        Thu, 20 Apr 2023 12:33:51 +0200 (CEST)
Authentication-Results: mail.nic.cz;
        none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1681986832; bh=ygF+dVEaVaGGwTtV9K6yEQ6mivTLTGTWi1vN1UuuX3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Reply-To:
         Subject:To:Cc;
        b=K1KqBMaKDhpif6xfLQ7/SKwI22uLKNLwMckN7JLfBCrxOBxdzuO5VIT+s/bxSAfxV
         AgYYrY17mtGCU81oI0/4sZbab8u3fQqaysE5Zmrd8r7A2PFCq3KCd44TnPd9x7umJ4
         E13xA7nsPA4lyBz2jIkJLQpHvnn2/7pDx7DjpjV4=
Date:   Thu, 20 Apr 2023 12:33:51 +0200
From:   Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
To:     yunchuan <yunchuan@nfschina.com>
Cc:     kabel@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware:Remove unnecessary (void*) conversions
Message-ID: <20230420103351.cyzbtwjhojkeqak5@kandell>
References: <20230420073751.1031944-1-yunchuan@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420073751.1031944-1-yunchuan@nfschina.com>
X-Virus-Scanned: clamav-milter 0.103.7 at mail
X-Virus-Status: Clean
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 2D2591C1824
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.53 / 20.00];
        R_MIXED_CHARSET(0.63)[subject];
        MIME_GOOD(-0.10)[text/plain];
        FROM_HAS_DN(0.00)[];
        WHITELISTED_IP(0.00)[172.20.6.87];
        FROM_EQ_ENVFROM(0.00)[];
        MIME_TRACE(0.00)[0:+];
        ARC_NA(0.00)[]
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes sense, but the commit title should be
  firmware: turris-mox-rwtm: drop unnecessary (void *) conversion

On Thu, Apr 20, 2023 at 03:37:51PM +0800, yunchuan wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: yunchuan <yunchuan@nfschina.com>
> ---
>  drivers/firmware/turris-mox-rwtm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
> index 6ea5789a89e2..af2fa620e6bc 100644
> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -283,7 +283,7 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
>  
>  static int mox_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  {
> -	struct mox_rwtm *rwtm = (struct mox_rwtm *) rng->priv;
> +	struct mox_rwtm *rwtm = rng->priv;
>  	struct armada_37xx_rwtm_tx_msg msg;
>  	int ret;
>  
> -- 
> 2.30.2
> 
