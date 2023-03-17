Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490C36BEB0D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCQOW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCQOWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA70BB6D37
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9201E622D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D6BC43445;
        Fri, 17 Mar 2023 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679062970;
        bh=3ktVK6Z8SIxwNL0Mz7fVgn/MLXEkDRswjLHErgTAt3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFPhg1x7saXzyXl1qS+Aumi2krN61h+FRHC3BRzODf7E+qfK8qK0wmNUXn8lnMbKy
         O09xl0yRbj1yv2sgkc5O9XP4zHMUbtCqgz1SmMvpczn9H4EHc5y7o8BEMlISkn7AAf
         HX52lWQY/ApSyTyg//l1yGiADsjKbCMfT/930Ufw=
Date:   Fri, 17 Mar 2023 15:22:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     Alex Komrakov <alexander.komrakov@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] pps: Add elapsed realtime timestamping
Message-ID: <ZBR3t0D0JEl8feRt@kroah.com>
References: <20230317074739.193965-1-alexander.komrakov@broadcom.com>
 <ZBQdWRHzakFLzSkb@kroah.com>
 <CAMedr-_ssg-baCz94ExMVTeXr2Qivzop1kEpx0S4PWuQdAiGaw@mail.gmail.com>
 <2713f092-5d21-ad5e-c5f4-87c927b18a27@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2713f092-5d21-ad5e-c5f4-87c927b18a27@enneenne.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 03:04:31PM +0100, Rodolfo Giometti wrote:
> On 17/03/23 10:51, Alex Komrakov wrote:
> > > +     if (!(pps->info.mode & PPS_CAPTURECLEAR))
> > > +             return 0;   Why are you not returning an error?
> > [AK] I used the style in this file sysfs.c.
> >   assert_show() and clear_show()  have the same condition.
> > When '& PPS_CAPTURECLEAR' -- 0 means no interrupt asserted  and it is not error
> > Probably Rodolfo can get more info why return 0
> 
> It's just as Alex said, if the PPS source has no PPS_CAPTUREASSERT or
> PPS_CAPTURECLEAR mode it should not print ASSERT and CLEAR info.

But shouldn't you return an error instead of an empty string?

> > And why are these sysfs files even present if the mode is not set
> > properly?  Can the mode be set while the device is attached or is this
> > only defined at probe time?  If at probe time, just never create these
> > files.
> > [AK] we can understand mode is set when interrupts asserted and
> > file assert_elapsed will be updated.
> 
> PPS source's "mode bits" can be set at runtime via PPS_SETPARAMS.

Ok, that's good to know.  But I think the error return value is a better
indication that something went wrong here and this attribute does not
work for this device at this point in time.

thanks,

greg k-h
