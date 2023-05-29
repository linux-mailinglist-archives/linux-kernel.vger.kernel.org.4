Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D97149DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjE2NGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjE2NFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:05:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADCDE5
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EDB46140F
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635BFC433EF;
        Mon, 29 May 2023 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685365533;
        bh=gzfcZTY1ZD6t6oXUKO7P9e/T07rqchdUbms2CIDVQtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNMvgTEI12WmAoA7aTRX/XJf6PBQX/7SLDvs2eykGAfdsjuzrZAh2tYPM56jJ4INh
         DhDUHapca/CZw2zGTLl8b0e8x2GCYmALECF5Ls3BzbHsaKzBMijPAQLzYjs1F/9ugL
         Vu5QIuR9RBzMrC6aMtm0nI2uHm5LWpLHFNY+POPM=
Date:   Mon, 29 May 2023 14:05:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <2023052953-average-fade-8b07@gregkh>
References: <20230523100239.307574-1-miquel.raynal@bootlin.com>
 <20230523100239.307574-3-miquel.raynal@bootlin.com>
 <2023052351-doze-purist-9780@gregkh>
 <20230523191402.0728443a@xps-13>
 <20230529121226.4a74a3bb@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529121226.4a74a3bb@xps-13>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 12:12:26PM +0200, Miquel Raynal wrote:
> Hi Greg,
> 
> miquel.raynal@bootlin.com wrote on Tue, 23 May 2023 19:14:02 +0200:
> 
> > Hi Greg,
> > 
> > gregkh@linuxfoundation.org wrote on Tue, 23 May 2023 17:58:51 +0100:
> > 
> > > On Tue, May 23, 2023 at 12:02:39PM +0200, Miquel Raynal wrote:  
> > > > +/* Cell attributes will be dynamically allocated */
> > > > +static struct attribute_group nvmem_cells_group = {
> > > > +	.name		= "cells",
> > > > +};
> > > > +
> > > >  static const struct attribute_group *nvmem_dev_groups[] = {
> > > >  	&nvmem_bin_group,
> > > > +	NULL, /* Reserved for exposing cells, if any */    
> > > 
> > > Please don't do this, but rather use the is_visible callback to
> > > determine if it should be shown or not.  
> > 
> > Ah, excellent point. Don't know why I overlooked that member.
> 
> Actually, the .is_visible callback only acts on the files and
> not the directories (created based on the group name).

That is true, I have a non-working patch somewhere around here that will
not create the directory if no files are in that directory, and need to
get that working someday...

> This
> means whether they are visible or not, the attributes must be
> valid, the nvmem core cannot just toggle a boolean value with
> .is_visible because the sysfs core makes a number of checks
> regarding the content of the attributes, without checking if
> they are visible at all.

You can't toggle a value, that's not how is_visible works.  It's a
callback at the creation time, you do know if you should, or should not,
show the files at creation time, right?

If so, all should be fine, just ignore the empty directory, it's fine.
And hopefully one day, it will not be created if there are no files in
it.  If I can ever get that patch working...

> I can however expose the "cells" bin group by default by having
> it listed in the static bin_attribute list and discard it by
> overwriting the list member with NULL (ie. the opposite of the current
> solution).

Ick, no, please don't do that.  attribute lists should be able to be put
into read-only memory, and are not set up to be dynamically messed with
like this at all.

thanks,

greg k-h
