Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9B72D6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjFMBUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjFMBUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA21728;
        Mon, 12 Jun 2023 18:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20F8A62E74;
        Tue, 13 Jun 2023 01:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FA9C433D2;
        Tue, 13 Jun 2023 01:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686619237;
        bh=nMTjj6z1aJO7b2UchCOr1ylRwdXqGyT5I/GFrTW51Q8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nOnXZOmRkf9MNLKNySEhayFAHH2rHoxjPb86DdV9ltPb7lKLIk8d7FGOFfc/KaF2C
         2d0eHk7oelFeUWpq3nKquDWvEK4f+B+7Oo6O4ulsqTW+u3gQHlnZMg7zvdtnSPO+iW
         /ADiUs6uvJR7v7E2sq70y2WC5sBtd7ifMizL4cfNPZnSP5v2411FNnklcZYNU5REuq
         TNllPv7pAjNDkRipPwlm5Wf2JFHog0V24m/Lq7R2UksjlwZh5hmYG7JVG7/pzFbs1w
         8E8mExKmmyeod3AlK7UDqLgxirLDrNHBY0Rg8VstL0STBd30GNtCd03D8RDTMoUQX9
         QTOHQpnASS4JQ==
Message-ID: <e88bc99a407c1c12b22e20d7b29fbc5e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230516135205.372951-3-angelogioacchino.delregno@collabora.com>
References: <20230516135205.372951-1-angelogioacchino.delregno@collabora.com> <20230516135205.372951-3-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/2] clk: mediatek: Remove CLK_SET_PARENT from all MSDC core clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        wenst@chromium.org, chun-jie.chen@mediatek.com,
        mandyjh.liu@mediatek.com, miles.chen@mediatek.com,
        zhaojh329@gmail.com, daniel@makrotopia.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        Garmin.Chang@mediatek.com, msp@baylibre.com,
        yangyingliang@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Mon, 12 Jun 2023 18:20:35 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2023-05-16 06:52:05)
> Various MSDC core clocks, used for multiple MSDC controller instances,
> share the same parent(s): in order to add parents selection in the
> mtk-sd driver to achieve an accurate clock rate for all modes, remove
> the CLK_SET_RATE_PARENT flag from all MSDC clocks for all SoCs: this
> will make sure that a clk_set_rate() call performed for a clock on
> a secondary controller will not change the rate of a common parent,
> which would result in an overclock or underclock of one of the
> controllers.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

Applied to clk-next
