Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218AD646A26
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLHILX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLHILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:11:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B07F55A97;
        Thu,  8 Dec 2022 00:11:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E9AF61DDC;
        Thu,  8 Dec 2022 08:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8C0C433D6;
        Thu,  8 Dec 2022 08:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670487080;
        bh=NdFVTBJpV5FMMzSdVcQDTqogNFQJNtLtSeWiycnqC6E=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=RtrLgqSzZLoWB69bmDOS3Y7k4ID1eB5oGbP+XEwrI1eiBIxQ1wBbk7VMf9VrVerlK
         I4wa6hWCiREHloeUryFLhcSvLUE6bOloEypzb93wIcq11AJReAGYj+V06L1hHo1b1B
         S7cpuC2AQv4EleioeAoVJ2XAyIlXc3pL014wddaexDi2PEpfI4BLCpsf0w677cRY0D
         pSZB8f8pNIeWxAotXGpBMrG5Gx/8N7Tqu6RSNGdGyg3PMA/yhfiarE+IivfTXjm1YN
         X1Q4/dTX5jwk3ECOrjpw8KMMj0ZW23dIV1dQerNtYvvLXY3h9MFsqPuNda5OmoZgYo
         XolFDFK5GwU2Q==
Date:   Thu, 08 Dec 2022 09:11:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, mturquette@baylibre.com,
        sboyd@kernel.org, claudiu.beznea@microchip.com,
        conor.dooley@microchip.com
CC:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: microchip: Add check for devm_kzalloc
User-Agent: K-9 Mail for Android
In-Reply-To: <20221208074025.29015-1-jiasheng@iscas.ac.cn>
References: <20221208074025.29015-1-jiasheng@iscas.ac.cn>
Message-ID: <F2FCAF36-B78B-4233-B0DE-A5AAE73EBCC5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 December 2022 08:40:25 GMT+01:00, Jiasheng Jiang <jiasheng@iscas=2Eac=
=2Ecn> wrote:
>As devm_kzalloc may return NULL pointer, the return value should
>be checked and return error if it fails since NULL is a invalid
>value of "name" =2E
>
>Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock supp=
ort")
>Signed-off-by: Jiasheng Jiang <jiasheng@iscas=2Eac=2Ecn>

Someone already sent this patch, but thanks=2E

>---
> drivers/clk/microchip/clk-mpfs-ccc=2Ec | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/clk/microchip/clk-mpfs-ccc=2Ec b/drivers/clk/microch=
ip/clk-mpfs-ccc=2Ec
>index 7be028dced63=2E=2E32aae880a14f 100644
>--- a/drivers/clk/microchip/clk-mpfs-ccc=2Ec
>+++ b/drivers/clk/microchip/clk-mpfs-ccc=2Ec
>@@ -166,6 +166,9 @@ static int mpfs_ccc_register_outputs(struct device *d=
ev, struct mpfs_ccc_out_hw_
> 		struct mpfs_ccc_out_hw_clock *out_hw =3D &out_hws[i];
> 		char *name =3D devm_kzalloc(dev, 23, GFP_KERNEL);
>=20
>+		if (!name)
>+			return -ENOMEM;
>+
> 		snprintf(name, 23, "%s_out%u", parent->name, i);
> 		out_hw->divider=2Ehw=2Einit =3D CLK_HW_INIT_HW(name, &parent->hw, &clk=
_divider_ops, 0);
> 		out_hw->divider=2Ereg =3D data->pll_base[i / MPFS_CCC_OUTPUTS_PER_PLL]=
 +
>@@ -200,6 +203,9 @@ static int mpfs_ccc_register_plls(struct device *dev,=
 struct mpfs_ccc_pll_hw_clo
> 		struct mpfs_ccc_pll_hw_clock *pll_hw =3D &pll_hws[i];
> 		char *name =3D devm_kzalloc(dev, 18, GFP_KERNEL);
>=20
>+		if (!name)
>+			return -ENOMEM;
>+
> 		pll_hw->base =3D data->pll_base[i];
> 		snprintf(name, 18, "ccc%s_pll%u", strchrnul(dev->of_node->full_name, '=
@'), i);
> 		pll_hw->name =3D (const char *)name;
