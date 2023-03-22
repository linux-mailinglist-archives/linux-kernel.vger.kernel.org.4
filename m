Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7D6C4F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjCVPQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCVPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:16:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E961333;
        Wed, 22 Mar 2023 08:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04269B81D24;
        Wed, 22 Mar 2023 15:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A205C433EF;
        Wed, 22 Mar 2023 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679498175;
        bh=pXRwvFBDd8R3dAnBvX8mqqspelbFAFqbO5AlulXm+z4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QJe272Z4HSu8RERaZjMtkARad991ROAJ3MHUGdw6nqgRu3zEnqpxddVHxxOYIBKBe
         +lxnID72s2bL7QbC4FQp5YR9NvqGOqo908Uvxz5n5uk2VYbhuHQ+hdaYTsCpqAFzHO
         wSBAwY4pEYD0eYEWSZMt6EdObRiq+ZxiHrk8qVE9b8OCW4AF4iiHOS9NBGBY5XQJz8
         nI0/ay1uveVuiLJ6cwrn5b7XbsdS1j7sHXFeYDT5PM2/mcUgGX5pWVmXOvN1WK4Wab
         0NyCp10OWdWH50jJ7R0OpYqFpSP+iVCvNaGlZLNp+XTr8tQxxo7b+GcGf2Tqgufd4L
         ElZ1usrG2SMjQ==
Message-ID: <55bea6244a6d41e3d7d38d6cb6d379e9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <79ceb9c5-2657-ca9b-e017-5ec14acfcda1@loongson.cn>
References: <20230321130710.20236-1-zhuyinbo@loongson.cn> <20230321130710.20236-2-zhuyinbo@loongson.cn> <26c4712672de6c4f70f88c6846bc892f.sboyd@kernel.org> <79ceb9c5-2657-ca9b-e017-5ec14acfcda1@loongson.cn>
Subject: Re: [PATCH v15 2/2] clk: clk-loongson2: add clock controller driver support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuyinbo <zhuyinbo@loongson.cn>
Date:   Wed, 22 Mar 2023 08:16:13 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting zhuyinbo (2023-03-21 19:07:26)
>=20
> =E5=9C=A8 2023/3/22 =E4=B8=8A=E5=8D=887:42, Stephen Boyd =E5=86=99=E9=81=
=93:
> > Quoting Yinbo Zhu (2023-03-21 06:07:10)
> >> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> >> new file mode 100644
> >> index 000000000000..090810655511
> >> --- /dev/null
> >> +++ b/drivers/clk/clk-loongson2.c
> >> @@ -0,0 +1,344 @@
[....]
> >> +
> >> +static void __iomem *loongson2_pll_base;
> > Why is this a global?
>=20
> Normally, this should be an element in the structure, but since there is =

> only one
>=20
> element, It is directly defined as a global variable for use by other=20
> function.
>=20

Ok. Globals are frowned upon but it's just a single pointers so I guess
it's Ok.

> >
> >> +               return PTR_ERR(loongson2_pll_base);
> >> +
> >> +       loongson2_clocks_init(dev);
> > Please inline this function here.
>=20
> The loongson2_clocks_init had inline in this version, or do you mean some=
thing else ? Need to inline the probe?

I mean get rid of the function loongson2_clocks_init() and move the code
in that function into this probe function. With this patch the probe is
split to two functions when it should be one function.
