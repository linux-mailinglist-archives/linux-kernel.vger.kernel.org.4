Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BC65EDE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiI1Npx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiI1Npt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:45:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B936843;
        Wed, 28 Sep 2022 06:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34ED9B820D3;
        Wed, 28 Sep 2022 13:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70008C433D6;
        Wed, 28 Sep 2022 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664372742;
        bh=2kibBR7rJ5YXYGVM0U2w3frRacYCZDTp7HUULPPogRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SnIyFxCuMJlsaOMMrEAecc6fAY50ozfpX6FhZwBAa5ckuGTOneJxwXvOVGVDnFym/
         2e7vCMcF4/vhKngkcRPZH3Y1mFcRml2QtzukEWmpZw7Xp3nRDCghMmOcqKN6/NEitC
         qCNIPKk9SD5ZcKByvGHS4ni/PKJH8+xrRCT22hLE=
Date:   Wed, 28 Sep 2022 15:45:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     heikki.krogerus@linux.intel.com, Sanket.Goswami@amd.com,
        singhanc@nvidia.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: typec: ucsi_ccg: Disable UCSI ALT support on
 Tegra
Message-ID: <YzRQBEeLorfC8KAL@kroah.com>
References: <20220928131615.3286936-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928131615.3286936-1-waynec@nvidia.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 09:16:15PM +0800, Wayne Chang wrote:
> From: Sing-Han Chen <singhanc@nvidia.com>
> 
> Firmware built for Tegra doesn't support UCSI ALT
> command and has known issue of reporting wrong
> capability info.
> 
> This commit disables UCSI ALT support when reading
> the capability on Tegra.

You have a full 72 columns to use, no need to make it shorter :)

> 
> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 5c0bf48be766..fde3da0605f5 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -122,9 +122,14 @@ struct version_format {
>   * Firmware version 3.1.10 or earlier, built for NVIDIA has known issue
>   * of missing interrupt when a device is connected for runtime resume
>   */
> -#define CCG_FW_BUILD_NVIDIA	(('n' << 8) | 'v')
> +#define CCG_FW_BUILD_NVIDIA_RTX	(('n' << 8) | 'v')

Why change this here?  It's not needed, just add the new command
instead.

And what commit id does this fix?  Is it needed for stable kernels?  If
so, how far back?

thanks,

greg k-h
