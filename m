Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4077C6AD1B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCFWh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCFWh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:37:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B7740F4;
        Mon,  6 Mar 2023 14:37:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A226AB80EDE;
        Mon,  6 Mar 2023 22:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454FCC433D2;
        Mon,  6 Mar 2023 22:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678142244;
        bh=ikZNIXxA3bRlatWCfivxUT2xVL8WMgX6XJ1cfOvU6l0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QrFOsNUVyVo6dSpUl589Hl4QENjJvssunhxYJfuYFVzOADr4RMByRqGZOgzPAWm8R
         JEcGA8lgZ5ftUH+mlSyNNTkNzCocdevqsYgUOl1H2bpTYWgO2ZDJm6eyoFCHQiQ9TB
         56NUyq0oZt3wIokiRXN11sQGjAuY74qmO0/pw+i02n6clKu/SAv8G1k0owOY/MmS8d
         2RxAwqdUz3havCjVcrfZpOdCxV0KdnD51Om6hbtoYn9fUJeYg5g3X/3FaAc9d6DjMM
         xdYdtFHVL4FcCydFlEAQAdXT/YhdUep8LGWIcU/B/cH/R2BjwZxhnxTxytlodETJ82
         4/Qq4x8Dz+V0A==
Message-ID: <39d89928de4c52d10fd98bca61b549fa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <be589843-dfc1-47dc-a488-a4fad645c638@spud>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com> <20230301002657.352637-2-Mr.Bossman075@gmail.com> <3b0a1481873a2a7c26015fcedcc673b3.sboyd@kernel.org> <be589843-dfc1-47dc-a488-a4fad645c638@spud>
Subject: Re: [PATCH v3 1/3] clk: k210: remove an implicit 64-bit division
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
To:     Conor Dooley <conor@kernel.org>
Date:   Mon, 06 Mar 2023 14:37:22 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2023-03-06 14:35:01)
> On Mon, Mar 06, 2023 at 02:31:00PM -0800, Stephen Boyd wrote:
> > Quoting Jesse Taube (2023-02-28 16:26:55)
> > > diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
> > > index 67a7cb3503c3..4eed667eddaf 100644
> > > --- a/drivers/clk/clk-k210.c
> > > +++ b/drivers/clk/clk-k210.c
> > > @@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk=
_hw *hw,
> > >         f =3D FIELD_GET(K210_PLL_CLKF, reg) + 1;
> > >         od =3D FIELD_GET(K210_PLL_CLKOD, reg) + 1;
> > > =20
> > > -       return (u64)parent_rate * f / (r * od);
> > > +       return div_u64((u64)parent_rate * f, r * od);
> >=20
> > The equation 'r * od' can't overflow 32-bits, right?
>=20
> Yah, I checked that when writing the patch. They're 4-bit fields:

Awesome
