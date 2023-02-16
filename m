Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783EB699230
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjBPKtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjBPKtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:49:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCE0211B;
        Thu, 16 Feb 2023 02:49:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09214B826A7;
        Thu, 16 Feb 2023 10:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D06C43442;
        Thu, 16 Feb 2023 10:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676544516;
        bh=Hmmd1SnR+ZmiY8Y4I5E3O8alYAE+dMBJIVP9gOXU5sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjaoCWczeu6QcHwYeuLX8UWehD8DbBXJshGM/jiQMw5+8g5YqHIXv6ePG8dLSt1F/
         gdZZkxwl6bKpMdZHDN8uCLHnUDpbRATdGXeTkCAQs8WvawMEsgXp7eeE/VqD0qi9B3
         AxyzZrWeV9QSdEYRj480JDPajTBvgJGPp9uCcHVNdzvwvbKUmLvv4iMBH4WgDZWGYy
         aTJDzvuPxIrS3u6SENl0uEzgaZuq/E1zkQrw/2v27T+hDRdxAfJE9JARV7B7IkPLZW
         qGMegK3JWd4S3QThJhTIXYPYO6WR+vWVuGyd7o5Z/EWK3gfYA/0BfOv4AgtwC8Dg8b
         Qea3nHYSdZrCA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pSbpX-0002y5-F5; Thu, 16 Feb 2023 11:49:36 +0100
Date:   Thu, 16 Feb 2023 11:49:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 1/2] usb: serial: add support for CH348
Message-ID: <Y+4KP/WdObzJTwOj@hovoldconsulting.com>
References: <20230106135338.643951-1-clabbe@baylibre.com>
 <20230106135338.643951-2-clabbe@baylibre.com>
 <Y+30EYVTiAuhj1iK@hovoldconsulting.com>
 <Y+4Fpd0lcJkQrXef@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+4Fpd0lcJkQrXef@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:29:57AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 16, 2023 at 10:14:57AM +0100, Johan Hovold wrote:
> > > +	if (urb->actual_length < 2) {
> > > +		dev_dbg(&port->dev, "%s:%d empty rx buffer\n", __func__, __LINE__);
> > 
> > I'm sure I've asked you drop __LINE__. Please be more careful when
> > considering review comments.
> 
> FYI, __func__ and __LINE__ are included automatically in dev_dbg() calls
> so any addition in the string for them is redundant and should never be
> there (it's also a hint that no one used this debug statement as the
> redundancy would be kind of obvious...)

Not exactly automatically since you need to explicitly request that they
are included, but yes, they are redundant.

__func__ may sometimes be useful for compact debug messages, though. As
an example, "get_chars - 5" is self-contained, while simply printing "5"
doesn't make any sense unless you also enable function prefixes.

Johan
