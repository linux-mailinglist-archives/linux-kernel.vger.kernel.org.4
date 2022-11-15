Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09332629CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiKOO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiKOO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:59:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9504D2409E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:59:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E0AB617F4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F38C433C1;
        Tue, 15 Nov 2022 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668524350;
        bh=cQEKlhaTpr3de6nu/bCmEemaU+10ceJ+IuAPhxAOfFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8cHDK24Zv5LHOVOH6zsIfvNt61NRX717bIO4tE73+I2MiGjjSXAkPRjxEc3YwW0A
         tkPoWc32gf9R0Krj4A2dyBQKa/J7m5P5pY5zBh8fPzv22jc9vX4rrCr9nX6iHxsSFg
         VWtFmPRVhnB8DxH24BJQJLpjBJaUBGgUiPQf92ho=
Date:   Tue, 15 Nov 2022 15:59:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mei: add timeout to send
Message-ID: <Y3OpO6Ys5L6CvOLC@kroah.com>
References: <20221115111438.1639527-1-alexander.usyskin@intel.com>
 <Y3OX+uQ7PN5thWSU@kroah.com>
 <CY5PR11MB6366ED268D5D4EE194C6469EED049@CY5PR11MB6366.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366ED268D5D4EE194C6469EED049@CY5PR11MB6366.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:27:02PM +0000, Usyskin, Alexander wrote:
> > > -		else
> > > +		} else {
> > >  			dev_dbg(&cldev->dev, "memory ready command
> > sent\n");
> > > +			cldev->bus->pxp_mode = MEI_DEV_PXP_SETUP;
> > 
> > What does the mode change have to do with a timeout?
> With timeout the mei_gfx_memory_ready may now fail gracefully
> and we should not move state if message is not sent.
> 
> Should I split this fix into another patch or document in this one?

Split it into a different patch please.


> > > +/**
> > > + * __mei_cl_send_timeout - internal client send (write)
> > > + *
> > > + * @cl: host client
> > > + * @buf: buffer to send
> > > + * @length: buffer length
> > > + * @vtag: virtual tag
> > > + * @mode: sending mode
> > > + * @timeout: send timeout in milliseconds for blocking writes
> > 
> > What do you mean "for blocking writes"?
> 
> The timeout has no effect for non-blocking writes (bit in mode parameter),
> as they are returning immediately and are not waiting at all.

That's not obvious, please say that the timeout is affected by the mode
and how it is affected.

thanks,

greg k-h
