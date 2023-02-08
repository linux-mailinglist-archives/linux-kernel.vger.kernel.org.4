Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09AD68F06D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjBHONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjBHONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:13:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F164617B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:12:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27DAEB81C76
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8AEC433D2;
        Wed,  8 Feb 2023 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675865560;
        bh=F3zZlNf5kXbKMWpgXrzQW6DGmA4bi8DUoSB2yopbhx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QosyLxcPoq9hTssY+9afykwNt80UKmkh5DQvvey5c7cL7Sc9raGCbhvvk26VicMOF
         mmS+AQqEkieNOAQ8wYaPAu4Ijts2IpCbk8S6Y/HBFl7D/E8kCiQHSwRZdyijx7ETl2
         q48+OiWp26ZMWS2GGWnqjOnP2orwbcND03JorTCs=
Date:   Wed, 8 Feb 2023 15:12:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, stable <stable@kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
Message-ID: <Y+Ot0FXLgrSoLy7Q@kroah.com>
References: <20230208125758.1515806-1-gregkh@linuxfoundation.org>
 <69fbf8b55dcb9c5c0a1a5d59b2248670@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69fbf8b55dcb9c5c0a1a5d59b2248670@walle.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 02:36:23PM +0100, Michael Walle wrote:
> Am 2023-02-08 13:57, schrieb Greg Kroah-Hartman:
> > When calling debugfs_lookup() the result must have dput() called on it,
> > otherwise the memory will leak over time.
> > 
> > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> > Cc: Pratyush Yadav <pratyush@kernel.org>
> > Cc: Michael Walle <michael@walle.cc>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: linux-mtd@lists.infradead.org
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: fix up to work when module is removed and added, making the fix
> >     much simpler.
> > 
> >  drivers/mtd/spi-nor/debugfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/debugfs.c
> > b/drivers/mtd/spi-nor/debugfs.c
> > index ff895f6758ea..af41fbc09a97 100644
> > --- a/drivers/mtd/spi-nor/debugfs.c
> > +++ b/drivers/mtd/spi-nor/debugfs.c
> > @@ -242,6 +242,7 @@ void spi_nor_debugfs_register(struct spi_nor *nor)
> > 
> >  	d = debugfs_create_dir(dev_name(nor->dev), rootdir);
> >  	nor->debugfs_root = d;
> > +	dput(rootdir);
> 
> rootdir might either be the return value of debugfs_lookup() or
> debugfs_create_dir(). dput() is probably wrong for the latter,
> right? Also there is an early return, where the dput() is missing,
> too.

{sigh}

Yeah, this is all wrong, sorry.  Let me fix this up again, properly.
And to do it properly, let's have the module remove the directory if it
is unloaded, like a good module should :)

greg k-h
