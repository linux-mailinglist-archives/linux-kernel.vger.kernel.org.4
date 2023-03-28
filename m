Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FE36CB879
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC1HqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjC1HqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:46:14 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91064183;
        Tue, 28 Mar 2023 00:46:12 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6BAB31C000A;
        Tue, 28 Mar 2023 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679989571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gnINcze37S33vHMBmE2XZI97D/oQO140BrPywcEV24k=;
        b=BkCbJ6RjXwa+a5i7lfZaMQmFRtc8bs+T98Pf/4Q+M8gjSSQbFjDiVoqLswSPfLqAUyUT0T
        KHlwzE49zoniebxXsGLDqnOQaSfZG/RKvRkmZvMJ5s7/3RcWpMXVLiHI/kMawrA9SL4wCF
        K+SiY95jWsEWf7CFRp2bWfGNema90M5Aq3/dX2EqokDIuIiRrF2UkjcLxDFcy43fh9BJvI
        /ia4+IhA7wmw03NxI+rl5P/SaBZ2NV1ddNv3RHoSf3PAnVkKVQo4ZRZhfFYpSEmw6kr4EZ
        LNTkVBBjLUSYtQvj2CRc/z9PFM9Fs3lhywdIPALKRnUQZvfnbLWzry7caINNoQ==
Date:   Tue, 28 Mar 2023 09:46:48 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: add missing of_node_put() in "assigned-clocks"
 property parsing
Message-ID: <20230328094648.51928f2f@fixe.home>
In-Reply-To: <9832bfd49eb83257a6a62620023773c1.sboyd@kernel.org>
References: <20230131083227.10990-1-clement.leger@bootlin.com>
        <9832bfd49eb83257a6a62620023773c1.sboyd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 14 Mar 2023 17:44:35 -0700,
Stephen Boyd <sboyd@kernel.org> a =C3=A9crit :

> Quoting Cl=C3=A9ment L=C3=A9ger (2023-01-31 00:32:27)
> > When returning from of_parse_phandle_with_args(), the np member of the
> > of_phandle_args structure should be put after usage. Add missing
> > of_node_put() calls in both __set_clk_parents() and __set_clk_rates().
> >=20
> > Fixes: 86be408bfbd8 ("clk: Support for clock parents and rates assigned=
 from device tree")
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > --- =20
>=20
> Does this series from a year ago help[1]?
>=20
> [1] https://lore.kernel.org/all/20220623121857.886-1-nuno.sa@analog.com/
>=20
> Nobody reviewed it, but if you can then I can probably apply it.

I'm only be able to review the first patch of the serie which
is equivalent to what I did but it mixes refactoring and fixes.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
