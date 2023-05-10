Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5566FE614
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjEJVUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjEJVUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773FC2D46;
        Wed, 10 May 2023 14:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FF5363441;
        Wed, 10 May 2023 21:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F40AC433EF;
        Wed, 10 May 2023 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683753632;
        bh=6PCycjhSBuykel0Qz6uiSXaWOAyhbmYe/UM3kSHOyqw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PJgUUjcyrB10GRVmq0OFFRyugnYOVPkCQ1dowRynzI69QTyJYsb4nUojnTfmKR3JJ
         zqe4E8bf1i0Qy7iu4y4FEmnp/2NSWOZSCCo7a5/WbGdSUIVTlPh7fYNhFau313+jFs
         0fRwpikC53dpqkhXUCrUaOWJ46sqPhEdj1C+axUNovRKmxJYq/5omxqFEOuD7hR1oh
         YVqMpbzLhLp13Pr9uXQ6cUuz6bYbb1OKFJoF6ldESfI8zByzZIuPFNzc8X1wU4tU/M
         RVFWurDzSoTWRJwuk4a2q5UThFYDZXhxzRvoLBBBDw6Y9NN1G4cGpuQjZNK7sMzdTi
         NwJ4c5eZwFTXA==
Message-ID: <ca1e1df877652808ef76851d7f2ed781.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230505131308.27190-3-runyang.chen@mediatek.com>
References: <20230505131308.27190-1-runyang.chen@mediatek.com> <20230505131308.27190-3-runyang.chen@mediatek.com>
Subject: Re: [PATCH v2 2/2] clk: mediatek: reset: add infra_ao reset support for MT8188
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Runyang Chen <runyang.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Date:   Wed, 10 May 2023 14:20:28 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Runyang Chen (2023-05-05 06:13:08)
> @@ -176,9 +177,32 @@ static const struct mtk_gate infra_ao_clks[] =3D {
>                        "infra_ao_aes_msdcfde_0p", "top_aes_msdcfde", 18),
>  };
> =20
> +static u16 infra_ao_rst_ofs[] =3D {

const?

> +       INFRA_RST0_SET_OFFSET,
> +       INFRA_RST1_SET_OFFSET,
> +       INFRA_RST2_SET_OFFSET,
> +       INFRA_RST3_SET_OFFSET,
> +       INFRA_RST4_SET_OFFSET,
> +};
> +
> +static u16 infra_ao_idx_map[] =3D {

const?

> +       [MT8188_INFRA_RST1_THERMAL_MCU_RST] =3D 1 * RST_NR_PER_BANK + 2,
> +       [MT8188_INFRA_RST1_THERMAL_CTRL_RST] =3D 1 * RST_NR_PER_BANK + 4,
> +       [MT8188_INFRA_RST3_PTP_CTRL_RST] =3D 3 * RST_NR_PER_BANK + 5,
> +};
> +
> +static struct mtk_clk_rst_desc infra_ao_rst_desc =3D {
> +       .version =3D MTK_RST_SET_CLR,
> +       .rst_bank_ofs =3D infra_ao_rst_ofs,
> +       .rst_bank_nr =3D ARRAY_SIZE(infra_ao_rst_ofs),
> +       .rst_idx_map =3D infra_ao_idx_map,
> +       .rst_idx_map_nr =3D ARRAY_SIZE(infra_ao_idx_map),
> +};
> +
>  static const struct mtk_clk_desc infra_ao_desc =3D {
>         .clks =3D infra_ao_clks,
>         .num_clks =3D ARRAY_SIZE(infra_ao_clks),
> +       .rst_desc =3D &infra_ao_rst_desc,
>  };
