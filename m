Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E726E64B4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiLMMEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiLMMEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:04:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517DF95B4;
        Tue, 13 Dec 2022 04:04:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 021C5B8118F;
        Tue, 13 Dec 2022 12:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA37C433D2;
        Tue, 13 Dec 2022 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670933043;
        bh=2x5Rdsw1M8e0Qb/YdxOUP82YSl/lHC9ENmG7g7vL4Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJF9gQ/CVJbCPRBsniDEQ7uo5qx582Uf1XMdG9R6uV1icLDGLZ+X1mHVmXRAIk6A0
         MeiCykyD3phyVc24DLpVzdLZ+lbxClr6vd82sUI+hjZTkk/t4LeL9MIEUjwDklMNwu
         dwQm4WRYmycnUEz9IgP/79AR+8DFAMn75v1cyG/Q=
Date:   Tue, 13 Dec 2022 13:04:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, quic_kamalw@quicinc.com,
        quic_jestar@quicinc.com, sboyd@kernel.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] spmi: Add check for remove callback in spmi_drv_remove
 API
Message-ID: <Y5hqMFw0xl6lmJYL@kroah.com>
References: <1670145780-13111-1-git-send-email-quic_jprakash@quicinc.com>
 <1670145780-13111-2-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670145780-13111-2-git-send-email-quic_jprakash@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 02:53:00PM +0530, Jishnu Prakash wrote:
> Add a check for remove callback presence before calling it for a
> spmi driver, to avoid NULL pointer dereference error if remove callback
> has not been specified for that SPMI driver.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  drivers/spmi/spmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
> index a456ce5..6b34356 100644
> --- a/drivers/spmi/spmi.c
> +++ b/drivers/spmi/spmi.c
> @@ -350,7 +350,8 @@ static void spmi_drv_remove(struct device *dev)
>  	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
>  
>  	pm_runtime_get_sync(dev);
> -	sdrv->remove(to_spmi_device(dev));
> +	if (sdrv->remove)
> +		sdrv->remove(to_spmi_device(dev));
>  	pm_runtime_put_noidle(dev);
>  
>  	pm_runtime_disable(dev);

What in-kernel spmi driver does not have a remove function set that
requires this change?

thanks,

greg k-h
