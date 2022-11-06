Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE561E37A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKFQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKFQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:40:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A7AE6D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 08:40:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B975360C3F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 16:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B5CC433C1;
        Sun,  6 Nov 2022 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667752808;
        bh=LyOp62cjZP3dNAd8XRe1V09GUeAtpY0II7lncWg3Kdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+ThkAotMh+uLMdFtM7keufX4DtxdhyPE6kOOXKXCCSSKKsPLCoqhKAMOZYEDb1eQ
         SBUkqZT/aeHufSnkSzWgFXlucq07Jxgj24ZEHkz66qsLBMOmQ3nBktL6K9UXqGfug0
         Ty6mBAVODaViqlwgUcbOvbIJ60lA67iiuBnQc4hs=
Date:   Sun, 6 Nov 2022 17:40:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     philipp.g.hortmann@gmail.com, dragan.m.cvetic@gmail.com,
        wjsota@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Rename variables TM_Trigger and
 TxPowerCheckCnt to avoid CamelCase
Message-ID: <Y2fjZbZdoZE86u50@kroah.com>
References: <20221106131811.GA50668@zephyrus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106131811.GA50668@zephyrus>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 06:48:11PM +0530, Yogesh Hegde wrote:
> Rename variables
> * TM_trigger to tm_trigger
> * TxPowerCheckCnt to txpower_check_count
> to avoid CamelCase which is not accepted by checkpatch.pl .
> 
> Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 767c746fc73d..0652940eecc5 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -919,32 +919,32 @@ static void _rtl92e_dm_check_tx_power_tracking_tssi(struct net_device *dev)
>  static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = rtllib_priv(dev);
> -	static u8	TM_Trigger;
> -	u8		TxPowerCheckCnt = 0;
> +	static u8 tm_trigger;
> +	u8 txpower_check_count = 0;

While this is nice overall, I think you just found a bug in the driver.

Why is this a static variable?  That means this affects all devices that
this driver touches, which seems very wrong, right?

So shouldn't tm_trigger be a per-device attribute?

>  	if (IS_HARDWARE_TYPE_8192SE(dev))
> -		TxPowerCheckCnt = 5;
> +		txpower_check_count = 5;
>  	else
> -		TxPowerCheckCnt = 2;
> +		txpower_check_count = 2;
>  	if (!priv->btxpower_tracking)
>  		return;
>  
> -	if (priv->txpower_count  <= TxPowerCheckCnt) {
> +	if (priv->txpower_count  <= txpower_check_count) {
>  		priv->txpower_count++;
>  		return;
>  	}
>  
> -	if (!TM_Trigger) {
> +	if (!tm_trigger) {
>  		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4d);
>  		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4f);
>  		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4d);
>  		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4f);
> -		TM_Trigger = 1;
> +		tm_trigger = 1;

It also should be a boolean, right?

Can you fix this up to be a per-device attribute instead?

thanks,

greg k-h
