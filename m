Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44B5B3ECA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiIIS0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIIS0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:26:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FEF1174A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CF81B8261B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 18:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3265C433C1;
        Fri,  9 Sep 2022 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662747963;
        bh=7uMFA5fW4cQA0reX2+I4RyDi85tOyh5cfa1uzphWztg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPjXkfXZimDFz1OpxfgxKeYhQ6WuPO2jjqT8O27BE/g0LDJVFmtKyxJ5r/HMBJeRA
         ubeBt7fPOlslBiu3TG42L0nJgg75sEbMUdrbpY5tWrJoT2mvWHYJhbeEZkDLPEK9Ok
         sjX058jZwHD7EUxzhuDaGxhBiYRF6DLPW0ShI1/k=
Date:   Fri, 9 Sep 2022 20:25:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     D Scott Phillips <scott@os.amperecomputing.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: misc: Allow minors values up to MINORMASK
Message-ID: <YxuFMymoZHoW3si+@kroah.com>
References: <20220906195213.2370775-1-scott@os.amperecomputing.com>
 <Yxr8d3eCoPPldZU5@kroah.com>
 <86k06cza0h.fsf@scott-ph-mail.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86k06cza0h.fsf@scott-ph-mail.amperecomputing.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:18:54AM -0700, D Scott Phillips wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Sep 06, 2022 at 12:52:13PM -0700, D Scott Phillips wrote:
> >> For per-cpu coresight_tmc devices, we can end up with hundreds of devices
> >> on large systems that all want a dynamic minor number.  Switch the dynamic
> >> minors allocator to an ida and add logic to allocate in the ranges [0..127]
> >> and [256..MINORMASK]. Allocations start from 127 growing downwards and then
> >> increasing from 256, so device numbering for the first 128 devices should
> >> be the same as before.
> >> 
> >> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> >> ---
> >>  drivers/char/misc.c | 41 ++++++++++++++++++++++++++++-------------
> >>  1 file changed, 28 insertions(+), 13 deletions(-)
> >
> > So you are adding more logic to the kernel for no change at all?
> >
> > Why is this needed?  What changed here except the underlying data
> > structure being used?
> 
> Hi Greg, the goal of the change I'm proposing here is to increase the
> maximum number of dynamic misc devices from 128 to 1048448.

You never said that anywhere in the changelog text :(

What would you like to see if you had to review such a change?  Please
fix up the changelog text to make sense when having to describe it to
someone who has no prior knowledge of what you were trying to do.

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/SubmittingPatches for what is needed in order
to properly describe the change when you resend this.

thanks,

greg k-h
