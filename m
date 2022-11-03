Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09B6617DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiKCN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:26:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF513EAF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B53DB827CB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB275C433C1;
        Thu,  3 Nov 2022 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667481992;
        bh=97o4Fn/VearIoWyrFZioD/aKcRCOwlQ5khIdoWWXOuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zU4d210oOIhnfSQU2SJIOc10ojXs10gdqtpENdtuOVr9dZmNxxI0qM4luqXo6j44K
         4QQZrFkvI7TYzkFJmY6cbCsDjk39pqL3N1FrqJAj2ASdYUO9GZcmV+szfVtAHgMbNT
         e9Mq9myzGcezCC+D9V++pEwM3ZEgTeDKEfB7wbIo=
Date:   Thu, 3 Nov 2022 22:27:12 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: replace one element 2D array by 1D
 array
Message-ID: <Y2PBsBEyeO4tTYy0@kroah.com>
References: <Y2OsUYcBYe1fZR1W@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2OsUYcBYe1fZR1W@qemulion>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:26:01PM +0530, Deepak R Varma wrote:
> A single element two dimensional array is constrained to index 0 for
> that element. This constraint makes it similar to a one dimensional
> array.  Hence convert such array to a simplified one dimensional
> equivalent. Resultant code is simpler and easy to maintain.
> 
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 2 +-
>  drivers/staging/r8188eu/include/odm.h        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> index 622f95d3f2ed..c0706c5b3fd8 100644
> --- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> +++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> @@ -886,7 +886,7 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
>  /* by sherry 20120321 */
>  	if (final_candidate < 4) {
>  		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
> -			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][i] = result[final_candidate][i];
> +			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[i] = result[final_candidate][i];

Why is this field only being set and never used?

Is it even needed at all?  If not, why not just remove it entirely?

thanks,

greg k-h
