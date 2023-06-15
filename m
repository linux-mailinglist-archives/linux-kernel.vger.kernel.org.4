Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E87313DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbjFOJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbjFOJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA48D1BF3;
        Thu, 15 Jun 2023 02:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479C360D2F;
        Thu, 15 Jun 2023 09:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532BEC433C0;
        Thu, 15 Jun 2023 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686821405;
        bh=g9oxqboktwufCn9rbuF3dwcHMwFSybfjfe3JJJTEHdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHspmm6gtUwaHB9p3xbCe2mMhaVN8TR2HfBkcKxtTPediSvExBFACNgZjMxcwOkaQ
         hqegNfJsILRT6OfNqFBYP9ieN8Wzb8i/k6SOWduZU6DwTWibTXZZXQdDF8G1uhXsHD
         WDF3C0aT4ucg4Dq2wKoe8wEHNeB4X//elxs2Xfr0=
Date:   Thu, 15 Jun 2023 11:30:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashanth K <quic_prashk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <2023061547-staleness-camper-ae8a@gregkh>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
 <ZImE4L3YgABnCIsP@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZImE4L3YgABnCIsP@kuha.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:14:08PM +0300, Heikki Krogerus wrote:
> On Wed, May 31, 2023 at 08:11:14PM +0530, Prashanth K wrote:
> > Currently if we bootup a device without cable connected, then
> > usb-conn-gpio won't call set_role() since last_role is same as
> > current role. This happens because during probe last_role gets
> > initialised to zero.
> > 
> > To avoid this, added a new constant in enum usb_role, last_role
> > is set to USB_ROLE_UNKNOWN before performing initial detection.
> > 
> > While at it, also handle default case for the usb_role switch
> > in cdns3, intel-xhci-usb-role-switch & musb/jz4740 to avoid
> > build warnings.
> > 
> > Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> > Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> > v7: Added default case in musb/jz4740.c & intel-xhci-usb-role-switch.c to
> >     avoid build warnings.
> > v6: Moved USB_ROLE_UNKNOWN towards the end of enum usb_role.
> > v5: Update commit text to mention the changes made in cdns3 driver.
> > v4: Added Reviewed-by tag.
> > v3: Added a default case in drivers/usb/cdns3/core.c as pointed out by
> >     the test robot.
> > v2: Added USB_ROLE_UNKNWON to enum usb_role.
> > 
> >  drivers/usb/cdns3/core.c                       | 2 ++
> >  drivers/usb/common/usb-conn-gpio.c             | 3 +++
> >  drivers/usb/musb/jz4740.c                      | 2 ++
> >  drivers/usb/roles/intel-xhci-usb-role-switch.c | 2 ++
> >  include/linux/usb/role.h                       | 1 +
> >  5 files changed, 10 insertions(+)
> 
> Just to be clear to everybody, that USB_ROLE_UNKNOWN is not handled in
> drivers/usb/roles/class.c, so this patch is broken.
> 
> But the whole approach is wrong. That USB_ROLE_UNKNOWN is clearly a
> flag where the other values in enum usb_role are actual switch states.
> So it does not belong there.
> 
> In general, adding globals states like that just in order to work
> around issues in single drivers is never a good idea IMO.

Ok, let me go revert this from my tree, thanks for the review.

greg k-h
