Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0012674BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjATFPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjATFOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:14:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B97931E0E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:03:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B8B9B824FE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1B9C433EF;
        Thu, 19 Jan 2023 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674140126;
        bh=eNI8ATuiVLz0j4xw08ULycnEcBS+objl6ZWW2vjlFkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxK7yX6v+MmninascLb03Fcg9bBndrHaihzlVguUNKfn9hely4oLDH3l+IiaFaMhc
         d8BZq7TqxjZ8W8ivnN4/ixHQtunt/nQihe17BpdtFs8hmjvLm8t+hywpsOavGh90CD
         XweNf9+AX7CIp4EfAtUM8TUUkbaCKxdUKyxJqOqU=
Date:   Thu, 19 Jan 2023 15:55:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbd] [patchv2 3/3] VT: Bump font size limitation to 64x128
 pixels
Message-ID: <Y8lZ3INJby+kwZ8S@kroah.com>
References: <20221218003209.503539532@ens-lyon.org>
 <20221218003237.503424466@ens-lyon.org>
 <Y58mKmE9Km+NujDa@example.org>
 <20221218145532.syqzu76q23rz4tx6@begin>
 <Y58wzU081UB1IsxB@example.org>
 <20221218152857.qle75c6lhexkdoym@begin>
 <Y58z+e7DF+YpJYbR@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y58z+e7DF+YpJYbR@example.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 04:38:33PM +0100, Alexey Gladkov wrote:
> On Sun, Dec 18, 2022 at 04:28:57PM +0100, Samuel Thibault wrote:
> > Alexey Gladkov, le dim. 18 déc. 2022 16:25:01 +0100, a ecrit:
> > > On Sun, Dec 18, 2022 at 03:55:32PM +0100, Samuel Thibault wrote:
> > > > Alexey Gladkov, le dim. 18 déc. 2022 15:39:38 +0100, a ecrit:
> > > > > On Sun, Dec 18, 2022 at 01:32:12AM +0100, Samuel Thibault wrote:
> > > > > > -#define max_font_size 65536
> > > > > > +#define max_font_width	64
> > > > > > +#define max_font_height	128
> > > > > > +#define max_font_glyphs	512
> > > > > > +#define max_font_size	(max_font_glyphs*max_font_width*max_font_height)
> > > > > 
> > > > > As a suggestion that you can safely ignore. Maybe make max_font_glyphs a
> > > > > sysctl parameter to be able to use larger fonts ?
> > > > > 
> > > > > I get requests from time to time in kbd that it is not possible to load a
> > > > > larger font.
> > > > 
> > > > 64KiB was really low, while the theoretically possible max was
> > > > 32*32*512 = 512KB, so I understand there used to be such requests :)
> > > > 
> > > > Here, by setting the max to 64x128*512, I don't think we'll need more.
> > > 
> > > I was not talking about the size of one glyph, but about the number of
> > > glyphs in the font. Right now the font cannot have more than 512 glyphs.
> > 
> > That one is unfortunately *very* hardcoded in the VT code, since it's
> > the very representation of the console text in vc_screenbuf which is set
> > to the VGA-based 16bits per glyph, with a 8+8 or 9+7 separation between
> > glyph number and color number. Lifting that would be way more involved.
> 
> Yeah, but I thought that since someone decided to touch this old code,
> then this someone will improve this old limit :)

That's fine, but it would be a separate change, not this one.

thanks,

greg k-h

