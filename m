Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75565EDECA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiI1O33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiI1O3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6F1ABD43;
        Wed, 28 Sep 2022 07:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 557CD61EC2;
        Wed, 28 Sep 2022 14:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E62EC433D6;
        Wed, 28 Sep 2022 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664375362;
        bh=8N85sFev7YCgQPdLgjEeuGjBZWjdzfA72EK7EuloGKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=12Muq1MrTtMNT6hg5zb6EYGWNtXsDKCGA32rk4Gi4kKpk8pEbbzcEpt3zzo8jl8jp
         1oza4YrKqOrUAET2u6L3OcPn8ibjhcf+DKKx0CayeI6bZgiZzQNpQPtJf4vNXHcn7k
         r6bTAQD+1tancR9FZsEYomD1PriI7eUoPkdBoSN8=
Date:   Wed, 28 Sep 2022 16:29:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Sanket.Goswami@amd.com" <Sanket.Goswami@amd.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: typec: ucsi_ccg: Disable UCSI ALT support on
 Tegra
Message-ID: <YzRaQEyByzqwt2y+@kroah.com>
References: <20220928131615.3286936-1-waynec@nvidia.com>
 <YzRQBEeLorfC8KAL@kroah.com>
 <PH0PR12MB55004C29C12FA17B9767CE98AF549@PH0PR12MB5500.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB55004C29C12FA17B9767CE98AF549@PH0PR12MB5500.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:11:36PM +0000, Wayne Chang wrote:
> Hi Greg,
> 
> Thanks for the review.
> 
> On 9/28/22 21:45, Greg KH wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Sep 28, 2022 at 09:16:15PM +0800, Wayne Chang wrote:
> >> From: Sing-Han Chen <singhanc@nvidia.com>
> >>
> >> Firmware built for Tegra doesn't support UCSI ALT
> >> command and has known issue of reporting wrong
> >> capability info.
> >>
> >> This commit disables UCSI ALT support when reading
> >> the capability on Tegra.
> > 
> > You have a full 72 columns to use, no need to make it shorter :)
> Thanks. I'll update in the next patchset.
> 
> > 
> >>
> >> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> >> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> >> ---
> >>   drivers/usb/typec/ucsi/ucsi_ccg.c | 16 ++++++++++++++--
> >>   1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> index 5c0bf48be766..fde3da0605f5 100644
> >> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> @@ -122,9 +122,14 @@ struct version_format {
> >>    * Firmware version 3.1.10 or earlier, built for NVIDIA has known issue
> >>    * of missing interrupt when a device is connected for runtime resume
> >>    */
> >> -#define CCG_FW_BUILD_NVIDIA  (('n' << 8) | 'v')
> >> +#define CCG_FW_BUILD_NVIDIA_RTX      (('n' << 8) | 'v')
> > 
> > Why change this here?  It's not needed, just add the new command
> > instead.
> 
> The change here is to distinguish the FW built for NVIDIA RTX products 
> and NVIDIA Tegra products.
> 
> #define CCG_FW_BUILD_NVIDIA_RTX      (('n' << 8) | 'v')
> #define CCG_FW_BUILD_NVIDIA_TEGRA	(('g' << 8) | 'n')
> 
> I'll update the change if it is not needed to do so.

No need to make this change here, right?  Do so in a later commit if you
really need to.

> > And what commit id does this fix?  Is it needed for stable kernels?  If
> > so, how far back?
> We are now enabling the NVIDIA Tegra products on upstream kernel.
> The change is to add the Cypress cypd 4226 support for NVIDA Tegra 
> products including Xavier AGX, Xavier Orin and the upcoming products.
> The Cypress cypd4226 is not enabled in current kernel codebase.
> And thus, we shall not need it for stable kernels and backporting, do we?

Ok, that's fine, it was not obvious so you might want to say that in the
changelog text.

thanks,

greg k-h
