Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929C968665A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBANEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBANEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:04:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACCF2D4C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:04:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45C35B82169
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B540C433EF;
        Wed,  1 Feb 2023 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675256683;
        bh=egp+vy8zGy5Wkq76d+uDukeqmJJcPUunh3Iv5Ex08JA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CiX9oHa6DzEIA9EzmoYFbemqKaeVZnOPRTUHWeUM5OV8j0GBeULeiK9oQFUyNcUZN
         tyRjxsYUj3u/A8FNjS2H0VF1EJhlNWsA3GD2b3YRzoAQMa3aORL9NINZtnK6h9TDiS
         4EpYzaMNx+DemhyGtCetfDwt/S9s9CEocN1VnJqY=
Date:   Wed, 1 Feb 2023 14:04:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ioana.ciornei@nxp.com
Subject: Re: [PATCH] bus: fsl-mc: don't assume child devices are all fsl-mc
 devices
Message-ID: <Y9pjaQVOda8tY/Qt@kroah.com>
References: <20230127131636.20889-1-laurentiu.tudor@nxp.com>
 <Y9kB8F3Nls8d1Koi@kroah.com>
 <d6297aae-7f9e-1b4e-d2f3-da5664804ab0@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6297aae-7f9e-1b4e-d2f3-da5664804ab0@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:50:11PM +0200, Laurentiu Tudor wrote:
> Hi Greg,
> 
> On 1/31/2023 1:56 PM, Greg KH wrote:
> > On Fri, Jan 27, 2023 at 03:16:36PM +0200, laurentiu.tudor@nxp.com wrote:
> > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > 
> > > Changes in VFIO caused a pseudo-device to be created as child of
> > > fsl-mc devices causing a crash [1] when trying to bind a fsl-mc
> > > device to VFIO. Fix this by checking the device type when enumerating
> > > fsl-mc child devices.
> > 
> > What changes?  What commit id does this fix?  Does it need to be
> > backported?
> 
> There were a lot of changes in the VFIO area but I'd point at this commit
> [1].
> 
> I'll resend the patch with a "Fixes:" tag pointing at this commit if that's
> ok with you.

Please do.

> > And what type of "pseudo device" is being created? Why would it be
> > passed to this driver if it's the wrong type?
> 
> It's not passed to the driver per-se. The problem shows up when the
> implementation of the driver does a device_for_each_child() [2] and the
> callback blindly assumes that all enumerated children devices are fsl-mc
> devices. The patch just adds a check for this case.

Ah, that makes more sense, sorry for the noise.

greg k-h
