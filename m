Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7AA5FC342
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJLJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJLJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:47:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1892CA8CD7;
        Wed, 12 Oct 2022 02:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8A6CB818EC;
        Wed, 12 Oct 2022 09:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09273C433C1;
        Wed, 12 Oct 2022 09:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665568071;
        bh=FxBd+f43Y2xSPHSbipTe/aE7ezjt9m0oe1aNqaLXixY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgkfUmYDJEU84TtQlB8n8jpsdOyrp5Xox4ly3yhbqdB3lNQ9cYPPxK0pFZ/U9qvti
         fFkcVNu9X9u48dJY/LrcbNzGdvQbwXzO9LL6MA3yH/GD0/dNp2Dz4Lx6H5GzBP1nXZ
         gbwUG74T8cItIIh4m1HfWmaeJItPo9QKmEwuWi5U=
Date:   Wed, 12 Oct 2022 11:48:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xhci: tegra: USB2 pad power controls
Message-ID: <Y0aNc5KFqOmdIw/H@kroah.com>
References: <20221012094020.2442-1-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012094020.2442-1-jilin@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 05:40:20PM +0800, Jim Lin wrote:
> Program USB2 pad PD controls during port connect/disconnect, port
> suspend/resume, and test mode, to reduce power consumption on
> disconnect or suspend.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
> 
> 
>  drivers/usb/host/xhci-tegra.c | 141 +++++++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index c8af2cd2216d..316585068ab5 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -2,7 +2,7 @@
>  /*
>   * NVIDIA Tegra xHCI host controller driver
>   *
> - * Copyright (c) 2014-2020, NVIDIA CORPORATION. All rights reserved.
> + * Copyright (c) 2014-2022, NVIDIA CORPORATION. All rights reserved.

I do not think you changed this properly.  Please work with your
corporate lawyers to understand how to mark copyright changes correctly.
Then resubmit just this portion of the change with a signed-off-by: by
the lawyer so that everyone understands and agrees that it has been done
properly.

Take this portion of the diff out when you resend a v3 if you wish to
get the code changes merge sooner if your lawyers take longer than you
want :)

thanks,

greg k-h
