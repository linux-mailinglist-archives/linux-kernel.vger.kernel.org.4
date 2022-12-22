Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CEE653D40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiLVJDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiLVJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:03:37 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1531FCF7;
        Thu, 22 Dec 2022 01:03:34 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B92DE000A;
        Thu, 22 Dec 2022 09:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1671699813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4gOPWGjEg88chOoWuaav23pjpL5Y5e5uaZVe/EqBqE=;
        b=QeGD5dLYPEuaEGCcki0adCUzRqSKZ/zV31K71rU2ze+Figq+pEPdRZgrSchKyv0X9dVVLd
        E4Zgew6xIafwewAasolBVx4tkU7epbCps3/37BBPtagS1o2eBEWyQ90dPbzFI7SmayUXpC
        /4irqMiMWzfHCCQpB45qqr1f03QVKbIlNhe7wzVxa8ZhbEsjSdhDOKmCu7oVyMzSDc/ko7
        LY/2AlLiBGZPqUD1hUAnJngvTe6kAqNaSI7PQQK/fmEopXzCbseH5gG118ncWstV8uhhyI
        oRv3L5QCAPiw/qPFMO7puyrSsxEEng2gkOHvWI5S2TDyya9Dy+mYxZI/dgNJ3Q==
Date:   Thu, 22 Dec 2022 10:03:28 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 00/21] Add Tegra20 parallel video input capture
Message-ID: <20221222100328.6e341874@booty>
In-Reply-To: <a99fa7e5-31bc-4286-17e5-6ba6e4932bcf@gmail.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
 <a99fa7e5-31bc-4286-17e5-6ba6e4932bcf@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

thanks for your review.

On Tue, 20 Dec 2022 23:21:49 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> 28.11.2022 18:23, Luca Ceresoli =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Tegra20 and other Tegra SoCs have a video input (VI) peripheral that can
> > receive from either MIPI CSI-2 or parallel video (called respectively "=
CSI"
> > and "VIP" in the documentation). The kernel currently has a staging dri=
ver
> > for Tegra210 CSI capture. This patch set adds support for Tegra20 VIP
> > capture.
> >=20
> > Unfortunately I had no real documentation available to base this work o=
n.
> > I only had a working downstream 3.1 kernel, so I started with the driver
> > found there and heavily reworked it to fit into the mainline tegra-video
> > driver structure. The existing code appears written with the intent of
> > being modular and allow adding new input mechanisms and new SoCs while
> > keeping a unique VI core module. However its modularity and extensibili=
ty
> > was not enough to add Tegra20 VIP support, so I added some hooks to turn
> > hard-coded behaviour into per-SoC or per-bus customizable code. There a=
re
> > also a fix, some generic cleanups and DT bindings.
> >=20
> > Quick tour of the patches:
> >=20
> >  * Device tree bindings and minor DTS improvements
> >=20
> >    01. dt-bindings: display: tegra: add Tegra20 VIP
> >    02. dt-bindings: display: tegra: vi: add 'vip' property and example =
=20
>=20
> This series adds the new DT node, but there are no board DTs in upstream
> that will use VIP? Will we see the board patches?

I'm afraid I have no such plan. I don't have any public hardware with
Tegra20, with or without a parallel sensor. I have a custom board.

> In any case, given that you're likely the only one here who has access
> to hardware with VIP,=20

Likely indeed.

> you should promote yourself to the tegra-video
> driver maintainers and confirm that you will be able to maintain and
> test this code for years to come.

I can definitely add myself as a maintainer of this driver and join the
maintenance effort, I'm adding that in v3. I also have a board that I
can permanently use for testing.

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
