Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB52768C656
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBFTA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBFTA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:00:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 21144206AC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:00:25 -0800 (PST)
Received: (qmail 666421 invoked by uid 1000); 6 Feb 2023 14:00:24 -0500
Date:   Mon, 6 Feb 2023 14:00:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] USB: ene_usb6250: Allocate enough memory for full object
Message-ID: <Y+FOSNyVKJdkwRy0@rowland.harvard.edu>
References: <20230204183546.never.849-kees@kernel.org>
 <Y961c1/JIkDUqMbC@rowland.harvard.edu>
 <63e14809.170a0220.7fcb2.150b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e14809.170a0220.7fcb2.150b@mx.google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:33:44AM -0800, Kees Cook wrote:
> On Sat, Feb 04, 2023 at 02:43:47PM -0500, Alan Stern wrote:
> > On Sat, Feb 04, 2023 at 10:35:46AM -0800, Kees Cook wrote:
> > > The allocation of PageBuffer is 512 bytes in size, but the dereferencing
> > > of struct ms_bootblock_idi (also size 512) happens at a calculated offset
> > > within the allocation, which means the object could potentially extend
> > > beyond the end of the allocation. Avoid this case by just allocating
> > > enough space to catch any accesses beyond the end. Seen with GCC 13:
> > 
> > In principle, it would be better to add a runtime check for overflow.  
> > Doing it this way means that the code could read an invalid value.
> > 
> > In fact, I get the impression that this code tries to load a data 
> > structure which might straddle a page boundary by reading in just the 
> > first page.  Either that, or else EntryOffset is always a multiple of 
> > 512 so the error cannot arise.
> 
> Yeah, I couldn't figure it out. It seems like it might move in
> non-512-byte steps too sometimes? Doubling the allocation (and zero-fill
> it) seemed the safest way to cover it.

It hardly seems to matter at this point.  I doubt that any significant 
number of laptops still in operation use the ENE UB6250 reader.  The 
driver was originally written in 2010, and official support for the 
hardware under Windows apparently ended with Windows 7.

Alan Stern
