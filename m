Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BBA6ECC67
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjDXMy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjDXMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A9DB;
        Mon, 24 Apr 2023 05:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C2A561F45;
        Mon, 24 Apr 2023 12:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C11AC433D2;
        Mon, 24 Apr 2023 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682340880;
        bh=kjIOJqt6fDyIyHZ3y0G83AnvzhtK3rSWAYbassPvJf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbwXbXHiYRuiBQRy0DWoQMrt5zHCF37csuY/HY2uIaWlnzCG3lMHEGJ4uy6cruSUq
         XIbEO55bMzI47Cg2YkI5jDpXz2DC2GSxoTJlnEankQ77n3lLzLDVARznEwVUQXp0h/
         8v7ELqUGWXvzv6aFoc9KS3edrIFEXZvditIfQ5kY=
Date:   Mon, 24 Apr 2023 14:54:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] tty: n_gsm: add restart parameter to DLC specific
 ioctl config
Message-ID: <2023042459-humbly-confusing-9721@gregkh>
References: <20230424075251.5216-1-daniel.starke@siemens.com>
 <2023042438-whole-cannot-1945@gregkh>
 <DB9PR10MB588138A96EE5E7CE96E28221E0679@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB588138A96EE5E7CE96E28221E0679@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 11:03:26AM +0000, Starke, Daniel wrote:
> > > --- a/include/uapi/linux/gsmmux.h
> > > +++ b/include/uapi/linux/gsmmux.h
> > > @@ -58,7 +58,8 @@ struct gsm_dlci_config {
> > >  	__u32 priority;		/* Priority (0 for default value) */
> > >  	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
> > >  	__u32 k;		/* Window size (0 for default value) */
> > > -	__u32 reserved[8];	/* For future use, must be initialized to zero */
> > > +	__u32 restart;		/* Force DLCI channel reset? */
> > 
> > Why are you using a full 32 bits for just 1 bit of data here?  Why not
> > use a bitfield?
> 
> The ioctrl guide states:
>   Bitfields and enums generally work as one would expect them to,
>   but some properties of them are implementation-defined, so it is better
>   to avoid them completely in ioctl interfaces.
> 
> Therefore, I tried to avoid them here.

Then use a u8?

> > And what happened to the request to turn the documentation for this
> > structure into proper kerneldoc format?
> 
> That applied to patch 2/8 and is unrelated to this patch. Another patch
> will need to fix this.
> 
> Link: https://lore.kernel.org/all/20230424075251.5216-2-daniel.starke@siemens.com/

It's kind of related in that the format is not right :)

As it's a few weeks before I am allowed to even apply this, please
rework the series a bit.

thanks,

greg k-h
