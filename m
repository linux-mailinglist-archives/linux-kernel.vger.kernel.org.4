Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B86AB96A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCFJNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCFJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:13:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8692C175
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:13:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C721B80D23
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAEBC433EF;
        Mon,  6 Mar 2023 09:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678094016;
        bh=md9GsAhD/crhfHfoprueAwoMTeTZuqf04A2dnFJvqLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yrD6jI7ykXwFH2wPsY67rDDDuT69YC4D+f57rPAVI+3wzR/v9iypOEtEp2mEj/rUO
         f+Ai2JZsrJF4Q80HeImEEDzP8wiszasG2cuN6iVifeZn5wFFJZSBtdx3vh0XN0Er4k
         s28lSlzJ+aeOcTBF2xe8bhKGONFJVwHIN/BpM0Q0=
Date:   Mon, 6 Mar 2023 10:13:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
Message-ID: <ZAWuvRHVVV3hTm0e@kroah.com>
References: <20230208160230.2179905-1-gregkh@linuxfoundation.org>
 <f60870dee13900252e0b13fb2f5f05b5@walle.cc>
 <ZAWNtv0g6vmADGnb@kroah.com>
 <20230306093336.523832b0@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306093336.523832b0@xps-13>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 09:33:36AM +0100, Miquel Raynal wrote:
> Hi Greg,
> 
> gregkh@linuxfoundation.org wrote on Mon, 6 Mar 2023 07:52:38 +0100:
> 
> > On Wed, Feb 08, 2023 at 05:15:41PM +0100, Michael Walle wrote:
> > > Am 2023-02-08 17:02, schrieb Greg Kroah-Hartman:  
> > > > When calling debugfs_lookup() the result must have dput() called on it,
> > > > otherwise the memory will leak over time.  To solve this, remove the
> > > > lookup and create the directory on the first device found, and then
> > > > remove it when the module is unloaded.
> > > > 
> > > > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> > > > Cc: Pratyush Yadav <pratyush@kernel.org>
> > > > Cc: Michael Walle <michael@walle.cc>
> > > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Cc: Richard Weinberger <richard@nod.at>
> > > > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > > > Cc: linux-mtd@lists.infradead.org
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>  
> > > 
> > > Reviewed-by: Michael Walle <michael@walle.cc>
> > > 
> > > one nit below I didn't notice earlier, no need to send a new
> > > patch version just for that.
> > > 
> > > ..
> > >   
> > > > +void spi_nor_debugfs_shutdown(void)
> > > > +{
> > > > +	if (rootdir)
> > > > +		debugfs_remove(rootdir);  
> > > 
> > > debugfs_remove() already has a check for NULL.
> > >   
> > 
> > Ah, good catch, I merged this in when I applied it to my tree, thanks!
> 
> Any reasons why you did apply this patch to your tree? It is a spi-nor
> fix, I would have expected it to go through mtd.

It's been sitting around for a month, I assumed it was lost, so I picked
it up.  I can revert it if you don't want me to take it for 6.3-final
through my driver core tree.

thanks,

greg k-h
