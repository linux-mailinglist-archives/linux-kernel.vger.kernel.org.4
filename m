Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DCE735D79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjFSS3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjFSS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:29:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470F01A8;
        Mon, 19 Jun 2023 11:29:50 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:c623::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A9846606F91;
        Mon, 19 Jun 2023 19:29:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687199388;
        bh=TQWW8juW2UtWzPnJZmxaz5aQLcUrScTrb1oeb43glSM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GBeLl4NYbN8fFu6f2fQAJUVogONfJePDNDID1lNWYFBNZ2Y7DA4uQ5qNtk4ZI9TYd
         XM/kHPbtUO1FFQzas4pVtL3N5tFBr6f0GZVNF+7d931FJtM45VYzieDk3UhLJqQG9w
         aSb7kmYAVGZPapk8hZqNjhRwG9bnJ4DGo8dFT4E7BRtLhBdBMe5SdsPkHvU3SotuxW
         gZwuQhhiERY99OEnxdMXt/jgTftdjbC1v23t27x20c2Mu2TuDkF6gbv7ts2UbOCiOF
         EWQw3e+zhWb6FAvyYL9PgpPSa/AEYM+pBM5KIuAu2Gn3KeHekzgPZTV30IrzfvUC2C
         OlYu6p/cbBrNg==
Message-ID: <d9f088d1d548c8735b393a15d5a16dbd914ddeca.camel@collabora.com>
Subject: Re: [PATCH 2/2] media: verisilicon: change confusingly named
 relaxed register access
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Jun 2023 14:29:38 -0400
In-Reply-To: <063a8886-fd31-425f-901c-fc830512eca3@app.fastmail.com>
References: <20230616144854.3818934-1-arnd@kernel.org>
         <20230616144854.3818934-2-arnd@kernel.org>
         <e264ac3a15e0f115aa7e941a77eb312429b8f65e.camel@collabora.com>
         <063a8886-fd31-425f-901c-fc830512eca3@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 19 juin 2023 =C3=A0 16:49 +0200, Arnd Bergmann a =C3=A9crit=C2=A0:
> On Mon, Jun 19, 2023, at 16:41, Nicolas Dufresne wrote:
> > Le vendredi 16 juin 2023 =C3=A0 16:48 +0200, Arnd Bergmann a =C3=A9crit=
=C2=A0:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > The register abstraction has wrappers around both the normal writel()
> > > and its writel_relaxed() counterpart, but this has led to a lot of us=
ers
> > > ending up with the relaxed version.
> > >=20
> > > There is sometimes a need to intentionally pick the relaxed accessor =
for
> > > performance critical functions, but I noticed that each hantro_reg_wr=
ite()
> > > call also contains a non-relaxed readl(), which is typically much mor=
e
> > > expensive than a writel, so there is little benefit here but an added
> > > risk of missing a serialization against DMA.
> > >=20
> > > To make this behave like other interfaces, use the normal accessor by
> > > default and only provide the relaxed version as an alternative for
> > > performance critical code. hantro_postproc.c is the only place that
> > > used both the relaxed and normal writel, but this does not seem
> > > cricital either, so change it all to the normal ones.
> >=20
> > In this text you spoke about potential performance side effects of exis=
ting code
> > and your changes, but its left all very vague and theoretical. Have you=
 done any
> > measurement ? Do you need help with the manner ?
>=20
> I don't have this hardware and have not done any measurements.
> Obviously the only point of using relaxed accessors is to
> improve performance in critical code paths, but from the way they
> are used here it seems that this was instead just an accident
> and nobody else did any comparisons either.
>=20
> My guess would be that if one wanted to speed up the register
> access, a better way would be to use a regmap cache to avoid
> reading registers when the contents are already known.

All I know is that for the majority of registers when programming stateless
codecs, each 32bit word of registers are fully written too, the read value =
is
not always meaningful (its a value from last time the HW has been triggered=
) and
should be ignored, so better to not do that. As for regmap, there is folks =
that
have reported regmap to be completely overkill for this type of hardware.

That discussion highlight my concern, which is that this specific patch sho=
uld
require a Tested-by before being merged. A clearer note to say that this pa=
tch
is not tested could have helped.

regards,
Nicolas

>=20
>      Arnd

