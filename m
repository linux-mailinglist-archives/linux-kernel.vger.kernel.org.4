Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4726122A5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJ2L7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJ2L7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:59:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC7D1F5;
        Sat, 29 Oct 2022 04:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6FA7B80B8C;
        Sat, 29 Oct 2022 11:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA47C433C1;
        Sat, 29 Oct 2022 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667044764;
        bh=Ap5s75s7ijrFAwTqA7tudLOZWue/4KVuAcaVQy36hgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nM6bYNlsiYigLSzaUv73E7fYpiHLuaCLaAbWt0qY3RCkZ5kYnHHkx/VOGI2sdwZeY
         5TpBkB4tqt4PnENvj1UKHmF/6hYZu/AoN70xwVcdWIBe0WGmUVNU5NOo5R+vApuqNQ
         QDjbJ9GnvsXWfJmuw2KFjBugsrxT/8ziq1zXK7ulgkexb+nqm1pxybTPpp8zO6b320
         pnuLej+/DBXnrRljKQV3TTZezWBtAg03eavfXQ6XWMvsWA8EBl69IxvGZTcSFqkQxY
         HbJsNtXBuupjnvCY1WcvM+B3tNYhg7Wmz9jHJtSAuVlH4Y4ahu2jFQCfE/RYz6ZvCy
         d8/WRHlhzf7/Q==
Date:   Sat, 29 Oct 2022 13:11:19 +0100
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
Subject: Re: [PATCH v2] staging: iio: frequency: ad9834: Use div64_ul
 instead of do_div
Message-ID: <20221029131119.2f000985@jic23-huawei>
In-Reply-To: <SJ0PR03MB677828AF20AAF0FC1A167C3C99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <Y1r/RAk83Csk2L3E@ubunlion>
        <SJ0PR03MB677828AF20AAF0FC1A167C3C99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
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

On Fri, 28 Oct 2022 10:14:48 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Deepak R Varma <drv@mailo.com>
> > Sent: Friday, October 28, 2022 12:00 AM
> > To: outreachy@lists.linux.dev; Lars-Peter Clausen <lars@metafoo.de>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan Cameron
> > <jic23@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > linux-iio@vger.kernel.org; linux-staging@lists.linux.dev; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH v2] staging: iio: frequency: ad9834: Use div64_ul inste=
ad of
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
> Clearly, I should have looked better and only reply to this one:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

As per the email Greg linked to, please take a close look at the surround c=
ode
and include analysis of whether the value can actually be greater than 32 b=
its.
Note that in most cases that would actually mean the code was broken on 32 =
bit
platforms.
