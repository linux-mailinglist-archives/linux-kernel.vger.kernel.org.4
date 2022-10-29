Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453246122A7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJ2L74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJ2L7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CA7140D4;
        Sat, 29 Oct 2022 04:59:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 951EB60EBC;
        Sat, 29 Oct 2022 11:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4B5C433D6;
        Sat, 29 Oct 2022 11:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667044786;
        bh=U7Y0LfekRUqevIEdJzCxwKVxVXiVTJMwJyYoSfKxd6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hIS7oSEfkBImSJSVDYOn5IMiAPOR04y0RK1YH9CEzK80IKmCWXJezMCYr8AHWCypS
         e+F2r8b6gT3Zmp7cMQbPdDgCEGWR2CqzzKC6QWpuvxBMk7hx7sgotqOgYSXBcd1AbJ
         mJZpTmnwBXD6yt07sRPxWmtGjJwVGccfs9HP59/EkOH8nMh/46+y05lswgh+vwvcTK
         Mrhs3u4Q1MMWaRrTWKUESYO7VUUFHPWLODfL8/8qIQ+fS1OC6ukhKW9RJzV2ulYxoE
         aa6DWUDyN9hpTEv5yo0NeUzhnYv7+LE96t4VVPbC4hqHTC7tXYI2XvJvoj47wBf4/y
         aq80/834kXEfA==
Date:   Sat, 29 Oct 2022 13:11:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Deepak R Varma <drv@mailo.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: frequency: ad9832: Use div64_ul instead
 of do_div
Message-ID: <20221029131139.016c89ce@jic23-huawei>
In-Reply-To: <SJ0PR03MB6778033906F79121A66C32DD99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <Y1r+EHqpVz/HYrIm@ubunlion>
        <SJ0PR03MB6778033906F79121A66C32DD99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 10:11:56 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Deepak R Varma <drv@mailo.com>
> > Sent: Thursday, October 27, 2022 11:54 PM
> > To: outreachy@lists.linux.dev; Lars-Peter Clausen <lars@metafoo.de>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan Cameron
> > <jic23@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > linux-iio@vger.kernel.org; linux-staging@lists.linux.dev; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH] staging: iio: frequency: ad9832: Use div64_ul instead =
of
> > do_div
> >=20
> > [External]
> >=20
> > do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> > which on some platforms is 64 bit wide. So use div64_ul instead of do_d=
iv
> > to avoid a possible truncation. Issue identified using the
> > coccicheck tool.
> >=20
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

As per the email Greg linked to, please take a close look at the surround c=
ode
and include analysis of whether the value can actually be greater than 32 b=
its.
Note that in most cases that would actually mean the code was broken on 32 =
bit
platforms.
