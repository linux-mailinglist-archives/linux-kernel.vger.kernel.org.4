Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9796C9060
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCYTLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCYTLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00B9E050;
        Sat, 25 Mar 2023 12:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3967C60C95;
        Sat, 25 Mar 2023 19:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48324C433EF;
        Sat, 25 Mar 2023 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679771470;
        bh=Sr64iYwMmramkuXW283DFJe6tl6JGpQNQCfz+yCLHNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pb5D9leq9LNy7YwchEndf1oiHONuZCSi5f5AZ6U2h4syr9r6dv2n0AAmIDpsmBO3m
         9TMsqBmCQkZrv96JKeaaHSk8/3yzYnIUyG9gvTuhGYS9F+koiH/n7Hrf7Ce9pRDKeW
         oblb/Rox2Ce6YV/JNZ5/9+P3DqbKHWCyg1TeQrSHhV1XFW4SmuV9RvDs5C3gPgeSwr
         okG//XxruFTD7STSVn93gBd6Hwhdfimjtw41ecPCAe6fihRmJwRXYjc0jKKIKLqzO/
         85y4cm7AlFohxJa1r1fHR58QbJu4tF1qq2tIMGwVTYUpSbo8Kk5p4KHkofunxLmFID
         p9Zip7+HmQh5Q==
Date:   Sat, 25 Mar 2023 19:26:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: max597x: Add support for max597x
Message-ID: <20230325192612.6181b07e@jic23-huawei>
In-Reply-To: <34756312-8a25-5a10-4ea5-59aeeb9e199b@9elements.com>
References: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
        <826f5de9-3aeb-6f7a-59e6-0504f8e92180@metafoo.de>
        <34756312-8a25-5a10-4ea5-59aeeb9e199b@9elements.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 17:31:18 +0530
Naresh Solanki <naresh.solanki@9elements.com> wrote:

> Hi,
>=20
> On 22-03-2023 09:28 pm, Lars-Peter Clausen wrote:
> > Hi,
> >=20
> > This looks really good. A few minor comments inline.
> >=20
> > On 3/22/23 05:43, Naresh Solanki wrote: =20
> >> [...]
> >> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long info)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> +=C2=A0=C2=A0=C2=A0 struct max597x_iio *data =3D iio_priv(iio_dev);
> >> +=C2=A0=C2=A0=C2=A0 unsigned int reg_l, reg_h;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 switch (info) {
> >> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_RAW:
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(data->=
regmap, chan->address, &reg_l);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(data->=
regmap, chan->address - 1, &reg_h);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret; =20
> > Is there any chance of a race condition of getting inconsistent data=20
> > when splitting this over two reads? I.e. registers being updated with=20
> > new values in between the two reads. =20
> yes, reg_l holds lower 2 bits. due to latency in reads, value may differ.

Normally there is a way to avoid the tearing via a bulk read of some type.
Is that not possible here?  If not, there are various tricks such as
repeated reads until stable that can be used.


Looks like the device has a block read format that might work.

