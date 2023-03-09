Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9276B321E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCIXjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCIXjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:39:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41251F366A;
        Thu,  9 Mar 2023 15:39:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBC07B820C6;
        Thu,  9 Mar 2023 23:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBEEC433D2;
        Thu,  9 Mar 2023 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678405148;
        bh=1wMFil0QP+T2/FyaFVOMtx1T7V81zvH2ISpPAOZJtZs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ApV8KN2IAaVyh9vF8VBhdlRtM3ypNj2RvkhKeSjrFeluHMO6HitLTk4jb8ArSIKeX
         onrFzS9nlvqyX9bdh1/EvZISE/WlcU1/AZzXSuDNrzUVlLoir4uLRtcFKncf1wEEZM
         JTAUgMuSdTs6xNGZI2mvCJs+KoWWonjDuyctOQ7W+d3bjs4paoS5wTEahYlYIVxe1K
         YcCAiA+V2xgByOKBfTuLDJroM3Ws9t2OA7DDjU6sLxTrWk29kCvSCXkQ33vp3DlsuT
         fPB1OmX3XErwQa+O+u7tQltlJnLUrN0eKp5JVOebrQrT5uJstD4J6OvGRxaeUohd9r
         qItCT7yvY/HOw==
Message-ID: <6b9cbb2be5ec087773290af9538f8488.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230308-clk_of_declare-fix-v1-1-317b741e2532@kernel.org>
References: <20230308-clk_of_declare-fix-v1-1-317b741e2532@kernel.org>
Subject: Re: [PATCH] clk: Avoid invalid function names in CLK_OF_DECLARE()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linus.walleij@linaro.org, saravanak@google.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>, mturquette@baylibre.com
Date:   Thu, 09 Mar 2023 15:39:04 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2023-03-08 12:47:11)
> After commit c28cd1f3433c ("clk: Mark a fwnode as initialized when using
> CLK_OF_DECLARE() macro"), drivers/clk/mvebu/kirkwood.c fails to build:
>=20
>  drivers/clk/mvebu/kirkwood.c:358:1: error: expected identifier or '('
>  CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
>  ^
>  include/linux/clk-provider.h:1367:21: note: expanded from macro 'CLK_OF_=
DECLARE'
>          static void __init name##_of_clk_init_declare(struct device_node=
 *np) \
>                             ^
>  <scratch space>:124:1: note: expanded from here
>  98dx1135_clk_of_clk_init_declare
>  ^
>  drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal =
constant
>  include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_=
DECLARE'
>          OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>                                          ^
>  <scratch space>:125:3: note: expanded from here
>  98dx1135_clk_of_clk_init_declare
>    ^
>  drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal =
constant
>  include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_=
DECLARE'
>          OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>                                          ^
>  <scratch space>:125:3: note: expanded from here
>  98dx1135_clk_of_clk_init_declare
>    ^
>  drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal =
constant
>  include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_=
DECLARE'
>          OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>                                          ^
>  <scratch space>:125:3: note: expanded from here
>  98dx1135_clk_of_clk_init_declare
>    ^
>=20
> C function names must start with either an alphabetic letter or an
> underscore. To avoid generating invalid function names from clock names,
> add two underscores to the beginning of the identifier.
>=20
> Fixes: c28cd1f3433c ("clk: Mark a fwnode as initialized when using CLK_OF=
_DECLARE() macro")
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Applied to clk-fixes
