Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659F36BA40B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCOA03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCOA02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D86279B0;
        Tue, 14 Mar 2023 17:26:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A62961A85;
        Wed, 15 Mar 2023 00:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877FAC433D2;
        Wed, 15 Mar 2023 00:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678839983;
        bh=lobEGi0h71abQ+OUCFajCF1V21Qb2ZNrY1ahlNRzi/E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RvUKfhl4lZ0LRKM49iRT91oXmLfZowNPYgnLuQg0uheJx7lUGg7anCRq3QhGKcIH8
         LOWLa8LTzvvhE2xbKhMrSk17QXlRt9l/h9cS9tQB8iOjnZwPs+W9DDN97puQpyNBWg
         EjrkQZpkMaxsV7zGV+jYmRJNra1H+w/rICx0T7aFLQCaEq8w/+0E82nOmThQHovakA
         Zm2xh/Vx+FOqtiJl1twuJOSKqfj1u30jNYl1tJ/792ZMOJinHAaM8SN1yy3xUVU3Qq
         1faBtCXuZUakV2QASJDcMIaFYx/pjH1uuBYnGumdradVFaB87lfr0Z/Hh9/WXG9KIR
         1Rp/U/fcxYd1A==
Message-ID: <c9e0e9b838cc046637059e771755f995.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6ff60914-0c39-9916-2e3a-a906b4cdef0d@kernel.org>
References: <20230307115022.12846-2-zhuyinbo@loongson.cn> <202303082037.QPfBP64A-lkp@intel.com> <b94ee1d2-b224-f9d5-3f3c-0096634f4c93@loongson.cn> <ec1fb4d134181a1b1859bcb884dcd494.sboyd@kernel.org> <c03e47f7-bb26-0114-b300-357634b0e581@kernel.org> <61eee19400e9a45ce9543bfd92a27eaa.sboyd@kernel.org> <6ff60914-0c39-9916-2e3a-a906b4cdef0d@kernel.org>
Subject: Re: [PATCH v13 2/2] clk: clk-loongson2: add clock controller driver support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinbo <zhuyinbo@loongson.cn>
Date:   Tue, 14 Mar 2023 17:26:21 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-03-13 23:49:40)
> On 13/03/2023 19:20, Stephen Boyd wrote:
> >>>> The CONFIG_64BIT not enabled in your config file, I will add a depen=
d on=20
> >>>> "CONFIG_64BIT" in my clock driver to fix this compile error.
> >>>
> >>> Do you need to use readq() here? Can you read two 32-bit registers wi=
th
> >>> readl() and put them together for a 64-bit number?
> >>
> >> If the platform supports 64-bit reads and these are actually one
> >> register, then readq makes sense - code is more readable, smaller, more
> >> efficient.
> >>
> >=20
> > Please read the section in Documentation/driver-api/device-io.rst about
> > hi_lo_readq() and <linux/io-64-nonatomic-lo-hi.h>. We shouldn't need to
> > restrict the driver to CONFIG_64BIT. Instead, include one of these
> > header files to get the IO access primitives.
>=20
> These primitives are for 32bit access. Quoting: "on 32-bit
> architectures". What's the point of them if the code *will never* run on
> 32-bit?

They're there to make drivers portable.

> It will be a fake choice of linux/io-64-nonatomic-lo-hi.h or
> linux/io-64-nonatomic-hi-lo.h misleading users to think this was tested
> on 32-bit.
>=20

I don't think anyone is really going to care that it hasn't been tested.
It's not like the Linux kernel driver is the source of truth for
integrating IP blocks into different architectures. If it's wrong
someone will fix it when they try to use the hardware on 32-bit systems.

Can the register handle being read/written with two 32-bit accesses? I
still don't think we've had any answer to that question. If so, pick the
one that makes the most sense and move on.

In Linux, we try to write portable drivers. This way anyone can compile
the driver on any host architecture with whatever compiler they're
using. Otherwise, they have to download a cross compiler for the target
architecture to simply build test the code. Also, the Linux kernel is
fairly portable. We try to limit architecture specific code to arch/ and
so anything in drivers/ is ideally portable code.
