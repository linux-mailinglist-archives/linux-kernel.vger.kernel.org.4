Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499AC6923B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjBJQyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBJQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:54:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA21167C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:54:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA6761E45
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD3DC433D2;
        Fri, 10 Feb 2023 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676048075;
        bh=mPNSF25Vw08jHwqhi+oGjDm1ZxRGMszvGZ4dzpicqCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwFIkxe2ldbNfCCbXHnm2i5Xr7ilZ6OEknoqdv9p7h2bClXdP7K3xk7CVQAxC6bWJ
         XFPct7vzN5a2A8PlkCJs5xHspNvAUYVjxE8qOMV5CETjO9BU+fONHHdcFkPneV/KAi
         qXzL9vnALcs+ptjo704r5Ipa38Cf5K6FuoZYt992ufpGdOBT0Rz1Ep/RjfdD0pm97/
         Xil84IML6FT205fPfwIli8b6AcDXWBH65dnVxwegCc1Bjw8Zs8Kb4RuuZM5pUHFW3C
         OZ/JwQvJ3sWo1ZYdk15jNCeMs8eZfn8RPDxHbFj1PPPgj9LNBDOPwUb172RtXxj/l3
         J2/Puo/XGPfGQ==
Date:   Fri, 10 Feb 2023 22:24:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kishon@kernel.org, heiko@sntech.de, p.zabel@pengutronix.de,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] phy: rockchip-typec: Fix unsigned comparison with less
 than zero
Message-ID: <Y+Z2xs8gu8eV5rS1@matsya>
References: <20230207052606.29506-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207052606.29506-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-23, 13:26, Jiapeng Chong wrote:
> The dp is defined as bool type, the return value type of function
> extcon_get_state should be int, at the same time,if(dp>0) is used as the
> conditional statement, so the type of dp is modified to int.
> 
> ./drivers/phy/rockchip/phy-rockchip-typec.c:827:12-14: WARNING: Unsigned expression compared with zero: dp > 0.

You should see same error for ufp as well, that also stores return of
extcon_get_state()

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3962
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-typec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 6aea512e5d4e..85ed7d510cbf 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -808,9 +808,9 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
>  	struct extcon_dev *edev = tcphy->extcon;
>  	union extcon_property_value property;
>  	unsigned int id;
> -	bool ufp, dp;
> +	bool ufp;
>  	u8 mode;
> -	int ret;
> +	int ret, dp;
>  
>  	if (!edev)
>  		return MODE_DFP_USB;
> -- 
> 2.20.1.7.g153144c

-- 
~Vinod
