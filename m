Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D30B6031FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJRSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJRSHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:07:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121695C97E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7EA7B820E6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA30C433C1;
        Tue, 18 Oct 2022 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666116440;
        bh=w+fQbjU9zgPkXn50Lx/9I+Hk07Z6bEGihhobfKnfWB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/2fBJtOMdCWu/3mQEm8TEytOtXNJgJ+ct1/Ega3z/+TCXyVwQXPQfBl5NVVdwE7T
         YdZXBKQFhvqUoR5zeng0489LrvSMzkObHun6CSsbKH6xFQJJWv6xG0Vc3aRyUa1QTX
         AYY+OgwPMEgqA2urmSSaIaPjXLQILXOOSsX9d/bc=
Date:   Tue, 18 Oct 2022 20:07:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: most: dim2: read done_buffers count locally
 from HDM channel
Message-ID: <Y07rVTVAbtE4r3MH@kroah.com>
References: <cover.1666105876.git.drv@mailo.com>
 <83fd237d2ac157d234e9c7cce1206904c2d8773d.1666105876.git.drv@mailo.com>
 <Y07ejaO8vrtPU5JX@kroah.com>
 <Y07lEqq+UaA3xTkk@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07lEqq+UaA3xTkk@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:10:34PM +0530, Deepak R Varma wrote:
> On Tue, Oct 18, 2022 at 07:12:45PM +0200, Greg KH wrote:
> > On Tue, Oct 18, 2022 at 10:19:21PM +0530, Deepak R Varma wrote:
> > > The function dim_get_channel_state only serves to initialize the ready and
> > > done_buffers fields of the structure passed as its second argument. In
> > > service_done_flag, this structure is never used again and the only purpose
> > > of the call is to get the value that is put in the done_buffers field.
> > > But that value is just the done_sw_buffers_number field of the call's
> > > first argument.  So the whole call is useless, and we can just replace it
> > > with an access to this field.
> > >
> > > This change implies that the variable st is no longer used, so drop it as
> > > well.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >
> > > PLEASE NOTE:
> > >    1. I have only built the module on my machine, but have not tested it.
> > >       I am not sure how to test this change. I am willing to test it with
> > >       appropriate guidance provided I have the necessary hardware.
> > >    2. This was a standalone patch earlier. It is now combined into a patch set
> > >       with another patch for the same driver. Hence I am carry forwarding the
> > >       change log for this patch here:
> > >
> > > Changes in v3:
> > >    1. The patch log message is further improved. This revised verbiage is as
> > >       thankfully provided by julia.lawall@inria.fr
> > >
> > > Changes in v2:
> > >    1. Update patch log message to be more descriptive about the reason for change.
> > >       Feedback provided by julia.lawall@inria.fr
> > >
> >
> > You need to say this is a v3 in the subject line as documented :(
> >
> Hi Greg,
> This was a standalone patch earlier and first time included in the patch set. I
> was not aware I am allowed to version a patch individually, different from the
> cover letter. I have posted a query to Outreachy mailing list for additional
> clarification. I will send in a v4 once I have clarity.

The cover letter will have v4 and so will each individual patch.
Turning 1 patch into a series or adding new patches to a series does not
mean you start over with the numbering.  Otherwise that would be
impossible for us to track, right?

thanks,

greg k-h
