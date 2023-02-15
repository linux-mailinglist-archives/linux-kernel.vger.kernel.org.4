Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298056983DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBOSzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBOSzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:55:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8043A86B;
        Wed, 15 Feb 2023 10:55:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E6C2B8232F;
        Wed, 15 Feb 2023 18:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F94C433D2;
        Wed, 15 Feb 2023 18:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676487298;
        bh=jQbNDDlSx6p44MzHHctv9rHrovl0hePDBD8SVdK4Ll0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YUmfA6TGGBVOv5tUrQwshoz/HvFcJ6o8Tff/wt1fKK314sq5qiSizn9lczejbNcRw
         5v+yOUvoxUqIZwMjYaa5xK9vxAI1nNAX2lj8uV4BGHRrcZNW2F0aaECpEz2aOoyJcN
         i4LK+HMoC2wewLexCZyJ3rWg7UjPKsm5PrTIu3uu69Bi0q+Mn2IA32hTIzsJKSeK5m
         odzI9apehib5gbVBoFkgyzZgZVTzb9exQ18WQ77jDAFTipdmry9Izjd/h98xTsAsGA
         YSGMgJB03c6Ojj7B3vbsNIxHjU1e+48lxEuerfjyRV9GjHNYi5y4RMXkEGM00HtAl6
         4JvScuR6DrXKw==
Message-ID: <96040456fd5c127497de93980eb7db83.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <63e6e809.050a0220.af3df.d908@mx.google.com>
References: <20230131160829.23369-1-ansuelsmth@gmail.com> <e5b71c243022d341022b4f172060268b.sboyd@kernel.org> <63e6e809.050a0220.af3df.d908@mx.google.com>
Subject: Re: [PATCH v2 1/2] clk: Warn and add workaround on misuse of .parent_data with .name only
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Christian Marangi <ansuelsmth@gmail.com>
Date:   Wed, 15 Feb 2023 10:54:56 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Marangi (2023-02-10 10:34:11)
> On Fri, Feb 10, 2023 at 04:40:29PM -0800, Stephen Boyd wrote:
> > Quoting Christian Marangi (2023-01-31 08:08:28)
> > > By a simple mistake in a .parent_names to .parent_data conversion it =
was
> > > found that clk core assume fw_name is always provided with a parent_d=
ata
> > > struct for each parent and never fallback to .name to get parent name=
 even
> > > if declared.
> >=20
> > It sounds like you have clk_parent_data and the .index member is 0? Can
> > you show an example structure? I'm guessing it is like this:
> >=20
> >       struct clk_parent_data pdata =3D { .name =3D "global_name" };
> >
>=20
> An example of this problem and the relative fix is here
> 35dc8e101a8e08f69f4725839b98ec0f11a8e2d3
>=20
> You example is also ok and this patch wants to handle just a case like
> that.

Ok, so you have a firmware .index of 0. The .name is a fallback. I
suppose you want the .name to be a fallback if there isn't a clocks
property in the registering device node? I thought that should already
work but maybe there is a bug somewhere. Presumably you have a gcc node
that doesn't have a clocks property

                gcc: gcc@1800000 {
                        compatible =3D "qcom,gcc-ipq8074";
                        reg =3D <0x01800000 0x80000>;
                        #clock-cells =3D <0x1>;
                        #power-domain-cells =3D <1>;
                        #reset-cells =3D <0x1>;
                };=09

Looking at clk_core_get() we'll call of_parse_clkspec() and that should fail

	struct clk_hw *hw =3D ERR_PTR(-ENOENT);

	...

        if (np && (name || index >=3D 0) &&
            !of_parse_clkspec(np, index, name, &clkspec)) {
		...
	} else if (name) {
		...
	}

        if (IS_ERR(hw))
                return ERR_CAST(hw);

so we should have a -ENOENT clk_hw pointer in
clk_core_fill_parent_index(). That should land in this if condition in
clk_core_fill_parent_index()

                parent =3D clk_core_get(core, index);
                if (PTR_ERR(parent) =3D=3D -ENOENT && entry->name)
                        parent =3D clk_core_lookup(entry->name);

and then entry->name should be used.=20

>=20
> > >=20
> > > This is caused by clk_core_get that only checks for parent .fw_name a=
nd
> > > doesn't handle .name.
> >=20
> > clk_core_get() is not supposed to operate on the .name member. It is a
> > firmware based lookup with clkdev as a fallback because clkdev is a
> > psudeo-firmware interface to assign a name to a clk when some device
> > pointer is used in conjunction with it.
> >=20
>=20
> And the problem is just that. We currently permit to have a
> configuration with .name but no .fw_name. In a case like that a dev may
> think that this configuration is valid but in reality the clk is
> silently ignored/not found and cause clk problem with selecting a
> parent.

It is valid though.

>=20
> Took some good hours to discover this and to me it seems an error that
> everybody can do since nowhere is specificed that the following
> parent_data configuration is illegal.=20
>=20

I'll look at adding a test. Seems to be the best way to solve this.
