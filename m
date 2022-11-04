Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6061A03D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiKDSsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKDSsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:48:20 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B759864;
        Fri,  4 Nov 2022 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667587667; bh=qE5ym1opJyH1PNJ1hV7aXZmTv5qh7+ufkF7+tQ0SLhk=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=G6Tjjeri/M4V+ersaBajryieEc2mRd3uMTpRrqFQaLAOOGJdLbJ8ecm8rPEAOJQ8P
         4wCEj8oZp9Tgth6bwS3I34f5Bd0BJxPfvmx97xqjCkGoAtN+oy6fTcKir89BCSUZhW
         eKcatSn1vCWf+aV9Q5sAqVxikI+wSwueFjPXucKo=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri,  4 Nov 2022 19:47:47 +0100 (CET)
X-EA-Auth: pMehuuPrIcJnoivIYphP0EkQOW37Pfr1TslTm/dWkmny4O42PS+BcrVQ/qfnAAaTtT0GQf2c5ZwF5h7AAUC9g2wFcFQvL+zl
Date:   Sat, 5 Nov 2022 00:17:39 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Sa, Nuno'" <Nuno.Sa@analog.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad5933: Use div64_ul instead of do_div
Message-ID: <Y2VeS8NgPhrr8pYR@qemulion>
References: <Y1r4EaDvEipzhaaf@ubunlion>
 <SJ0PR03MB6778EAAB4132374270E96FFB99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
 <5740bcb3490d4c17bd9bc731e79b174b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5740bcb3490d4c17bd9bc731e79b174b@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 11:23:06AM +0000, David Laight wrote:
> > > -----Original Message-----
> > > From: Deepak R Varma <drv@mailo.com>
> > >
> > > [External]
> > >
> > > do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> > > which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> > > to avoid a possible truncation. Issue was identified using the
> > > coccicheck tool.
>
> These changes should all get nacked unless the domain of the values
> can be shown to be out of range.

Hello David,
I looked through the data sheets for these hardware [ad983*] and believe the
divisor max can attain 75MHz which fits well in a 32 bit size. Hence the
proposed changes for these drivers to switch to div64_ul may actually slowdown
the division. Please correct if I said something incorrect.

Requesting to kindly ignore my proposed changes.

>
> The entire point of do_div() is that because division is expensive
> using a limited range division is significantly faster.
>
> Even on Intel 64 bit cpu the 64 by 32 divide is significantly
> faster then a full 64 bit divide for the same input values.
>
> One might also question why the divisor is actually 'unsigned long'
> at all. The code is almost certainly expected to compile for 32bit
> so the domain of the value should fit in 32 bits.
> So either the type could be unsigned int, or it really doesn't matter
> that the value is truncated to 32bit because it can never be larger.

Thank you for the detailed explanation. This is very helpful.



Thank you for the detailed explanation. This is very helpful.

./drv

>
> 	David
>
>
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> >
> > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


