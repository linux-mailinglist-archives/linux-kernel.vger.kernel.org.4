Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6801C68F493
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBHRbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBHRbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:31:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C56A56
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:30:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9154261746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FD8C4339B;
        Wed,  8 Feb 2023 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675877459;
        bh=m4LGLQRhAU4B3yaYdvrvkLt+fmM4L3nYicIMpXCMVeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+mYO5Bp4GkXoD5hHKtk/yK+fLsXYhaxdrXN3PGxqvmtdoJLn+IffzQHySZ+PDNTs
         dgVFyIM8gDACZl2J+T8N9LuhebXwDCSzWZnKbbliSvuaigZAE66Jk9JG3HT1XOU55E
         1GHy2l4cWDM5ZvzV+8mlQvmLsYUoVlWErXpe88/U=
Date:   Wed, 8 Feb 2023 18:30:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
Message-ID: <Y+PcUN2DQx+J4MPJ@kroah.com>
References: <20230208160230.2179905-1-gregkh@linuxfoundation.org>
 <f60870dee13900252e0b13fb2f5f05b5@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60870dee13900252e0b13fb2f5f05b5@walle.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:15:41PM +0100, Michael Walle wrote:
> Am 2023-02-08 17:02, schrieb Greg Kroah-Hartman:
> > When calling debugfs_lookup() the result must have dput() called on it,
> > otherwise the memory will leak over time.  To solve this, remove the
> > lookup and create the directory on the first device found, and then
> > remove it when the module is unloaded.
> > 
> > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> > Cc: Pratyush Yadav <pratyush@kernel.org>
> > Cc: Michael Walle <michael@walle.cc>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: linux-mtd@lists.infradead.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Michael Walle <michael@walle.cc>
> 
> one nit below I didn't notice earlier, no need to send a new
> patch version just for that.
> 
> ..
> 
> > +void spi_nor_debugfs_shutdown(void)
> > +{
> > +	if (rootdir)
> > +		debugfs_remove(rootdir);
> 
> debugfs_remove() already has a check for NULL.
> 

Argh, I knew that, for some reason I went back and added that check as I
was thinking this would have been an issue if rootdir was never created.
You are right, it isn't a problem, oh well.

The simplest patches sometimes take the longest time to get right, I'll
stop now :)

thanks so much for the reviews,

greg k-h
