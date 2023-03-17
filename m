Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2A26BEF2D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCQRHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCQRGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:06:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C804C6F2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B82BE60DF6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA672C433EF;
        Fri, 17 Mar 2023 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679072802;
        bh=jiDGsqRzlRcCtmQwsHMBFR0ipayvPpuWQ/T8IQ9YOGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtjTPo2OfHs1ld2M/QAPOBsUNmbHMxgUsveATgEhEebgcfQKdW0rgr9ijO40QqZmE
         eajD6pCLR3AdTUODKx8mHttgTJBRyGnJDeteBxDnZZSGM7wT1n+2GEg7zUIV8KU3YA
         BvuNWTMrEZqOwIQpZTReMJ4n+/wY+a/hUNT+F8UU=
Date:   Fri, 17 Mar 2023 18:06:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     Alex Komrakov <alexander.komrakov@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] pps: Add elapsed realtime timestamping
Message-ID: <ZBSeGjBEEzeBv35c@kroah.com>
References: <20230317074739.193965-1-alexander.komrakov@broadcom.com>
 <ZBQdWRHzakFLzSkb@kroah.com>
 <CAMedr-_ssg-baCz94ExMVTeXr2Qivzop1kEpx0S4PWuQdAiGaw@mail.gmail.com>
 <2713f092-5d21-ad5e-c5f4-87c927b18a27@enneenne.com>
 <ZBR3t0D0JEl8feRt@kroah.com>
 <f8ea9ab9-e1c1-7962-dab4-126beda74046@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8ea9ab9-e1c1-7962-dab4-126beda74046@enneenne.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 05:34:28PM +0100, Rodolfo Giometti wrote:
> On 17/03/23 15:22, Greg KH wrote:
> > On Fri, Mar 17, 2023 at 03:04:31PM +0100, Rodolfo Giometti wrote:
> > > On 17/03/23 10:51, Alex Komrakov wrote:
> > > > > +     if (!(pps->info.mode & PPS_CAPTURECLEAR))
> > > > > +             return 0;   Why are you not returning an error?
> > > > [AK] I used the style in this file sysfs.c.
> > > >    assert_show() and clear_show()  have the same condition.
> > > > When '& PPS_CAPTURECLEAR' -- 0 means no interrupt asserted  and it is not error
> > > > Probably Rodolfo can get more info why return 0
> > > 
> > > It's just as Alex said, if the PPS source has no PPS_CAPTUREASSERT or
> > > PPS_CAPTURECLEAR mode it should not print ASSERT and CLEAR info.
> > 
> > But shouldn't you return an error instead of an empty string?
> 
> This is not an error... it's just a disabled capability. :)

Then maybe return "0" or something like that?

> > > > And why are these sysfs files even present if the mode is not set
> > > > properly?  Can the mode be set while the device is attached or is this
> > > > only defined at probe time?  If at probe time, just never create these
> > > > files.
> > > > [AK] we can understand mode is set when interrupts asserted and
> > > > file assert_elapsed will be updated.
> > > 
> > > PPS source's "mode bits" can be set at runtime via PPS_SETPARAMS.
> > 
> > Ok, that's good to know.  But I think the error return value is a better
> > indication that something went wrong here and this attribute does not
> > work for this device at this point in time.
> 
> I see... however I suppose several code relays on this behavior.

If that's the case, then you are right, you can't change it, and I'll
stop complaining here :)

What tools use these sysfs files?  How did you test your changes?

thanks,

greg k-h
