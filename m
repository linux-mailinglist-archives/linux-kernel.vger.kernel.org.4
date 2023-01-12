Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225E6667F08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbjALT0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbjALTZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:25:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547261087;
        Thu, 12 Jan 2023 11:18:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECEDB62168;
        Thu, 12 Jan 2023 19:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E3FC433D2;
        Thu, 12 Jan 2023 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673551093;
        bh=exAI5jxTDcYsnJh04WDwQlQnjnxZ4VDRUEZsnjm/Mbg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kPMFfhEzMtpBSOXKw4uhoYyWiX4FPW41nPcAnhIqSz9ADflBEozCbjQwaX55wJRLU
         tyuzDx32GEIhF/vW6wWlBAixKiempGw8azg5JeDZqGTJLQWqxGWezawXLGDVQjsI0V
         DMrOFzMix+JE/j2vn/g0nQU/RH3Cu7HzekXub5Kij5r/JiBtXaWy6gQHplibvCX/TP
         OlxFfiGwXd85pkwcQ1WpTGrtq1tE01EhlMMK/JuZNav3OC9jzpXNPyVXqp8mvDOMqu
         zsrrdGk2Z9zp2D79hWD9bNvtcb+D8hy5WyDPP29yGorCOZ+lH67d+GZ1jOgCz3bH4r
         Ml080Aqw2PpNQ==
Message-ID: <0c19d8dedda3e308c75a6c97358d2af3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <185a3f0a326.b623e6bd1243489.6765528573167668508@linux.beauty>
References: <20230110114540.2975540-1-me@linux.beauty> <57d1f58c4c6cca793d629d5776b477d0.sboyd@kernel.org> <185a3f0a326.b623e6bd1243489.6765528573167668508@linux.beauty>
Subject: Re: [PATCH] clk: create write_enable file to control clk rate write and other dangerous ops permission
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     michael turquette <mturquette@baylibre.com>,
        li chen <lchen@ambarella.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
To:     Li Chen <me@linux.beauty>
Date:   Thu, 12 Jan 2023 11:18:11 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Li Chen (2023-01-11 19:05:34)
> Hi Stephen,
>  ---- On Thu, 12 Jan 2023 02:37:29 +0800  Stephen Boyd  wrote ---=20
>  > Quoting Li Chen (2023-01-10 03:45:39)
>  > > From: Li Chen lchen@ambarella.com>
>  > >=20
>  > > It's common requirement for bsp debug/test to change clk rate from u=
serspace.
>  > >=20
>  > > Currently, we must define CLKOCK_ALLOW_WRITE_DEBUGFS then re-compile=
 kernel
>  > > to allow this feature. Let's replace it with a "write_enable" file to
>  > > allow enable it at runtime.
>  >=20
>  > Nak. This design is intentional.
> =20
> Thanks for your reply. Got it. But sometimes re-compile is somewhat low e=
fficient. Is it acceptable to provide=20
> a write_enable to clk_core(not enable by default), and allow clk driver t=
o enable it inside clk_ops->init
> via clk_hw->core->write_enable =3D 1?
>=20

No
