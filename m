Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE761519F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiKASfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKASfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:35:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761BB1C93D;
        Tue,  1 Nov 2022 11:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CCAEB81EB7;
        Tue,  1 Nov 2022 18:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63E4C433C1;
        Tue,  1 Nov 2022 18:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667327713;
        bh=tP9v1fJaDtSk4ggL7MfdFf2595PWE1zeGgz3m0lWxww=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I28UVGphwA58whsoZYhoyBnIgNW8RRUJXjw27JWh04PkOCXwK6mf812iENfpja8zQ
         S25YivMSryWjlZBhUJhUF34zYQXf+pbxA1omOrite234ioSgm6be0n7noCz/DlilFE
         L0M7XFDWlttv+O4t+UzoRNI+aTGOk50hSuwAS0pDrN0IXUdGZIKLkARB0+QeNY0VKh
         1xBmtj0NvU88rkBe34FPlCBNNtDYF05FhjHjFGJEAKCgaP1BmzkdHwAO6RSQF8zhyh
         /6HWrZn4c1/FkAglvUhe5c0OtFuzvgbZbsuDiBrjCSoghR3X/Jr/O1VWtXQfbrSFQz
         b9nx8JGWcOjKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABGWkvp1iMN-4XDN_ifg6uyvQbpRzNyat_eDziWY75Cf_hCpQw@mail.gmail.com>
References: <20221018160352.1591428-1-dario.binacchi@amarulasolutions.com> <20221028002710.89A81C43470@smtp.kernel.org> <CABGWkvp1iMN-4XDN_ifg6uyvQbpRzNyat_eDziWY75Cf_hCpQw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: ti: dra7-atl: don't allocate `parent_names' variable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com, kernel test robot <lkp@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Tue, 01 Nov 2022 11:35:11 -0700
User-Agent: alot/0.10
Message-Id: <20221101183513.C63E4C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2022-10-30 06:00:46)
>=20
> I tried to test your suggestions on another platform (I don't have the
> hw to test the driver change) but if I
> don't add pdata.name =3D of_clk_get_parent_name () the board boot up fail=
s.
>=20
> As far I can see from the clk_core_populate_parent_map()
>=20
> ....
> /* Copy everything over because it might be __initdata */
> for (i =3D 0, parent =3D parents; i < num_parents; i++, parent++) {
>     parent->index =3D -1;
>     if (parent_names) {
>         /* throw a WARN if any entries are NULL */
>        WARN(!parent_names[i],
>             "%s: invalid NULL in %s's .parent_names\n",
>             __func__, core->name);
>         ret =3D clk_cpy_name(&parent->name, parent_names[i],
>                                         true);
>     } else if (parent_data) {
>         parent->hw =3D parent_data[i].hw;
>         parent->index =3D parent_data[i].index;
>         ret =3D clk_cpy_name(&parent->fw_name,
>                                          parent_data[i].fw_name, false);
>         if (!ret)
>             ret =3D clk_cpy_name(&parent->name,
>                                             parent_data[i].name,
>                                             false);
> ...
>=20
>=20
> The function clk_cpy_name() is called with the parameter "mus_exist"
> to true in the path "parent_names" and false
> in the path "parent_data". Therefore, in the path "parent_data" it is
> allowed that parent-> name is not set.
> In doing so, therefore, the change would not even be backward compatible.
>=20
> So, IMHO, there are 2 possible options:
>  1 okay to use parent_data, but we keep using of_clk_get_parent_name
> () to set parent_data::name.
>  2 okay to use the version v2 of the patch.
>=20
> What do you think?

I am confused.

The struct clk_parent_data::name being used is whatever string is
returned by of_clk_get_parent_name(node, 0). That is the same as setting
struct clk_parent_data::index to 0, and not assigning the 'name' or
'fw_name' field of the parent data structure. This is a compatible
change because of_clk_get_parent_name() is getting the name of the clk
in 'clocks' for 'node' at index 0. Using the index 0 in clk_parent_data
tells clk framework that the parent of the clk being registered is the
clk in 'clocks' for the 'dev->node' that is passed in during
clk_register(). If you don't have a device pointer, use
of_clk_hw_register() to pass 'node' directly. It looks like you will
have to do that in this case to get the node pointer registered with
this clk.
