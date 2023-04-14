Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A079E6E2B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDNUgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDNUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:36:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0A66A6F;
        Fri, 14 Apr 2023 13:36:05 -0700 (PDT)
Date:   Fri, 14 Apr 2023 22:36:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1681504563; bh=ZwA/9DtV5sIdb/Fn2apGAZQqdnsdth6XO2NjZS/VdUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAfj7+pqLPl5wCg0IhA63T1O2rpeqdI9b7C0u7uh+R9orZekqA1etB4cHayTvGNzk
         fub1lMpxqlSAN+VeJ1/Vi2qc30gG1tzARxhCqu/qKmFCBVbcw648sQm9YGxp47ZIf+
         SIu/+qr79FGzlZ+cym+ftArann/rMz9WyXtZRpWM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] HP BIOSCFG driver - Documentation
Message-ID: <0b92276d-09e5-4308-b4c1-4519ac2ac65d@t-8ch.de>
References: <20230412144821.5716-1-jorge.lopez2@hp.com>
 <f91ee2ff-3a24-4e2b-bf68-f1c5400b7462@t-8ch.de>
 <CAOOmCE-pfQa8_yn7zOkt9dBR9VpnnJF=dsvByZqLM=qcvoEx+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE-pfQa8_yn7zOkt9dBR9VpnnJF=dsvByZqLM=qcvoEx+Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-14 15:00:02-0500, Jorge Lopez wrote:
> On Fri, Apr 14, 2023 at 10:27 AM <thomas@t-8ch.de> wrote:
> > On 2023-04-12 09:48:21-0500, Jorge Lopez wrote:
> > > [..]
> > >
> > > +What:                /sys/class/firmware-attributes/*/authentication/SPM/statusbin
> > > +Date:                March 29
> > > +KernelVersion:       5.18
> > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > +Description: 'statusbin' is a read-only file that returns 'status' information
> > > +             in binary format. This file provides a mechanism for components
> > > +             downstream (e.g. Recovery Agent) can read the status and public
> > > +             key modulus.
> >
> > This is still missing docs about how to interpret the contents of the
> > "statusbin" file.
> >
> > "components downstream" -> userspace.
> >
> 
> I will provide the details in Version 10.   Additionally, I am working
> with the architect to understand the need for 'statusbin' in their
> upcoming features.

If the userspace component is not ready maybe this can be delayed for a
future patchset?
The basic features should already be useful with a generic client like
fwupd.
Doing it in steps should be faster both in development and wall time.

> > I think we can start with the code review.
> >
> 
> I will send all files with Version 10.   To aid in the review process,
> I will keep all ..c in separate reviews.  It is less confusing that
> way since there is commonality between them
> 
> > Could you also provide a sample of the attribute files?
> > I'm especially curious about the different instances of the sure-start
> > attributes, including current_value, possible_values and the auditlog
> > properties.
> >
> 
> What type of sample are you looking for.?   I can provide you with a
> tree display of all attributes and some output samples for different
> attribute types.

That sounds great.

> I will include sure-start  attributes, including current_value,
> possible_values and the audit log properties.  Please let me know if
> there is anything else you want to see.

I want to get a feeling for the exposed bios settings and how the
sure-start stuff works.

> > Also is the userspace component for this published somewhere?
> > If so it would be useful to refer to it from the commit message.
> 
> Linux components are under development and not published yet.  The
> only linux component at this time is the driver (hp bioscfg).
> The only published components are under Windows ONLY.

Maybe mention this in the commit message.

Also it would be useful to test the new driver with fwupd which is the
existing userspace user of this ABI.
Just to make sure that nothing is obviously broken there.
(And mention this in the commit message)

Thomas
