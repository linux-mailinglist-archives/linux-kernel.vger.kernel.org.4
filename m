Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8615D67D1F4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjAZQl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjAZQlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:41:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B455C0E8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:41:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2181BB81E86
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535ADC433D2;
        Thu, 26 Jan 2023 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674751307;
        bh=b9mQgsprn6SnJYI/NGJEDkTIYdr2LcFif1cwH7jqO/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDFYOns/CrOeMDPKDliK6h8Dv8bj+Aapiub5ryIRnwde2OtOLerCsdNC9X4mPE9ju
         SGMimr2r4lzgWfRlIf6TBV/a1iJmbLNVYWSCB/VAzRbubZR7t5/0gctw762paDiD9O
         Xr7WgbA7HjmmT+t2FFTlSFf9s0OMWyot/UqHwl/nPhavxDIPs+GaRXl+nC0zQ8ppzd
         2xaZkNbsw+jMqfJwNIR/5odoNHKrtJgd+qwkcCZzSBaDRK7f9xLVke1xMoWrK2+OSc
         xzAkC2DIEm9Y9ufZu7wp8RNcdP4oE6HzQnJ6bxVIsT65xYGzwlJcaIPor3y+/AUhwE
         FoUETc/dGWU+A==
Date:   Thu, 26 Jan 2023 16:41:42 +0000
From:   Lee Jones <lee@kernel.org>
To:     Neill Kapron <nkapron@google.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Zhong <zyw@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] phy: rockchip-typec: fix tcphy_get_mode error case
Message-ID: <Y9KtRpsioQNTc4oc@google.com>
References: <20230126001013.3707873-1-nkapron@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230126001013.3707873-1-nkapron@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023, Neill Kapron wrote:

> The existing logic in tcphy_get_mode() can cause the phy to be
> incorrectly configured to USB UFP or DisplayPort mode when
> extcon_get_state returns an error code.
> 
> extcon_get_state() can return 0, 1, or a negative error code.
> 
> It is possible to get into the failing state with an extcon driver
> which does not support the extcon connector id specified as the
> second argument to extcon_get_state().
> 
> tcphy_get_mode()
> ->extcon_get_state()
> -->find_cable_index_by_id()
> --->return -EINVAL;
> 
> Fixes: e96be45cb84e ("phy: Add USB Type-C PHY driver for rk3399")
> Signed-off-by: Neill Kapron <nkapron@google.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-typec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Good catch.

Reviewed-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index d76440ae10ff..6aea512e5d4e 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -821,10 +821,10 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
>  	mode = MODE_DFP_USB;
>  	id = EXTCON_USB_HOST;
>  
> -	if (ufp) {
> +	if (ufp > 0) {
>  		mode = MODE_UFP_USB;
>  		id = EXTCON_USB;
> -	} else if (dp) {
> +	} else if (dp > 0) {
>  		mode = MODE_DFP_DP;
>  		id = EXTCON_DISP_DP;
>  
> -- 
> 2.39.1.456.gfc5497dd1b-goog

-- 
Lee Jones [李琼斯]
