Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0666767BB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjAURf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAURf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:35:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D523DB9;
        Sat, 21 Jan 2023 09:35:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2979C60B51;
        Sat, 21 Jan 2023 17:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AEFC433D2;
        Sat, 21 Jan 2023 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674322540;
        bh=rLsDtPBbQwyLec4mRiPgAtx/E1zunZKAdQhlBj3e8W8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vvcnqc++0irIVJLBT6TOyKViJMlAIe6hcWY37XumWWAyCPBaLEcmm6tPmfHPCV4+S
         /yX+kdwUTVqS+CkCsSNCdw1Ahud0CKFgvC8UYREPgtCc6h5+1lfW2LJxccL9OCaMOM
         5gIYwEI5KhuKFqf9ADhZ3Q0x4nC70sTjgM+mmN0XiRDi0tX3a4D0pQW2S/1o02bGRA
         OFg0pLirVZMCkIaqDeM7v+TAmBRkek+aPXBpai++TXeT8PUaSnL0Nspn7/AiwyOmXy
         XRHNOu5OW2Ms9C0g0TDz/GbC+yvblXTmZQTO/W4qGCDEocSk++X9eHq3ukhfvbGdl5
         bDSsPiTL+aNSQ==
Date:   Sat, 21 Jan 2023 17:49:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v1 1/2] iio: core: Replace
 iio_sysfs_match_string_with_gaps() by __sysfs_match_string()
Message-ID: <20230121174925.41beef31@jic23-huawei>
In-Reply-To: <93c5f822dd332c188e05da2d7e7eb1ac72cc6067.camel@gmail.com>
References: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
        <5f9b713b-9c71-7da6-e674-b6ebd28dc5d5@metafoo.de>
        <Y8gVDs0UoiHqCRsM@smile.fi.intel.com>
        <64406c4f-c9da-b434-360b-1050ff685d2d@metafoo.de>
        <bb2e8b7b4ca894ed53d70bf04e2d52bed2553105.camel@gmail.com>
        <Y8koLwGVjyrDb66P@smile.fi.intel.com>
        <93c5f822dd332c188e05da2d7e7eb1ac72cc6067.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 14:24:07 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-01-19 at 13:23 +0200, Andy Shevchenko wrote:
> > On Thu, Jan 19, 2023 at 09:00:45AM +0100, Nuno S=C3=A1 wrote: =20
> > > On Wed, 2023-01-18 at 08:37 -0800, Lars-Peter Clausen wrote: =20
> > > > On 1/18/23 07:49, Andy Shevchenko wrote: =20
> > > > > On Wed, Jan 18, 2023 at 07:22:30AM -0800, Lars-Peter Clausen
> > > > > wrote: =20
> > > > > > On 1/17/23 23:48, Andy Shevchenko wrote: =20
> > > > > > > None of the current users is using gaps in the list of the
> > > > > > > items.
> > > > > > > No need to have a specific function for that, just replace
> > > > > > > it
> > > > > > > by
> > > > > > > library available __sysfs_match_string(). =20
> > > > > > Hm, I specifically remember adding this for a driver where
> > > > > > there
> > > > > > were gaps.
> > > > > > One of the DACs. But it might be that the driver itself never
> > > > > > made it
> > > > > > upstream. =20
> > > > > I have checked all modules that have struct iio_enum and/or
> > > > > ("or"
> > > > > probably may
> > > > > not happen) IIO_ENUM() in them.
> > > > >=20
> > > > > It might be that I missed something. =20
> > > > I checked too, I can't find it either. The driver probably never
> > > > made
> > > > it=20
> > > > upstream. =20
> > >=20
> > > Yeah, I also did a quick check and I could find it in one adc (most
> > > likely we have more downstream users of this) that did not make it
> > > upstream. Eventually, we want to have it upstream but the ABI using
> > > the
> > > gaps can arguably be dropped...
> > >=20
> > > Anyways, from my side I'm fine with this change. We can revert it
> > > if we
> > > ever have a real user for this. I'll just have to be careful when
> > > updating ADI tree (but that is our problem :)).

You could always upstream the problematic drivers :)

> >=20
> > We usually do not keep a dead code in the kernel, and handling gaps
> > is a dead code. =20
>=20
> Yes, I know... That is why I cannot really complain about this
> change :)

I joined in because I was really really sure we had a user of this
at somepoint. However, despite there having been a bunch of users
in the counter stuff before that spun out as a separate subsystem
looks like they were contiguous as well. Ah well the reasoning behind
this dance may remain lost to history :)

Series applied,

Jonathan

>=20
> - Nuno S=C3=A1
>=20

