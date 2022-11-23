Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E48634DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiKWCad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiKWCaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:30:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF2E06A8;
        Tue, 22 Nov 2022 18:30:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA752B81E51;
        Wed, 23 Nov 2022 02:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487A7C433D7;
        Wed, 23 Nov 2022 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669170627;
        bh=sZtUMJY2VcKD4NHYZpzaajhtKLwlIs9S6QbWT2Yalq8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EjRsGvx/RKFCMBVMR2xWS40YMCXJ0DDXZ5l3rziIQENzvkf0NPyERw95Ehtba0Pro
         gBPqJvTXE/xq/2s910KH20wQYntlX/SrGQGeC+GvZvkt52yFyImauGdfei9C3Q5Nn4
         EGJrYwM8DQWhZhipIZYPXSaofvx0/JBD7JwlVafFRXyj2+wTPLUSI06uK122RO88M3
         egntePmkmFwISiTxpuXA494V454dmuluDvincW18lYzqMYj+2uAZdSooXOIcUenKv9
         Nd9B3++SdlPkU/Qjzu7XC2n5cXmCNAIl3NUHimQksUA3Mk4A5K5vGrEjdBG4kdpdcu
         C9t5d7oWbq/sg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221116214655.1116467-1-robimarko@gmail.com>
References: <20221116214655.1116467-1-robimarko@gmail.com>
Subject: Re: [PATCH v2] clk: qcom: ipq8074: populate fw_name for all parents
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Tue, 22 Nov 2022 18:30:23 -0800
User-Agent: alot/0.10
Message-Id: <20221123023027.487A7C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Marko (2022-11-16 13:46:55)
> It appears that having only .name populated in parent_data for clocks
> which are only globally searchable currently will not work as the clk core
> won't copy that name if there is no .fw_name present as well.
>=20
> So, populate .fw_name for all parent clocks in parent_data.
>=20
> Fixes: ae55ad32e273 ("clk: qcom: ipq8074: convert to parent data")
>=20
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Add fw_name for PCIe PHY pipe clocks as well
> ---
>  drivers/clk/qcom/gcc-ipq8074.c | 52 +++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq807=
4.c
> index d231866804f6..8374cc40915a 100644
> --- a/drivers/clk/qcom/gcc-ipq8074.c
> +++ b/drivers/clk/qcom/gcc-ipq8074.c
> @@ -680,7 +680,7 @@ static struct clk_rcg2 pcie0_aux_clk_src =3D {
>  };
> =20
>  static const struct clk_parent_data gcc_pcie20_phy0_pipe_clk_xo[] =3D {
> -       { .name =3D "pcie20_phy0_pipe_clk" },
> +       { .fw_name =3D "pcie0_pipe", .name =3D "pcie20_phy0_pipe_clk" },

Is there a DT binding update for these firmware names?
