Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C857339C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbjFPTXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbjFPTXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109D46BB;
        Fri, 16 Jun 2023 12:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE0BE60B66;
        Fri, 16 Jun 2023 19:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BCEC433C0;
        Fri, 16 Jun 2023 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686943264;
        bh=jxqqA8hKbX1P+MGFD6r0FL7uvDc4IVAgHOvqUjiaLD4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cmCJnDxvweAkTJuxcJHrETAjNXl0iPu4lQukowFXXRonO4we27DpflLjuC0O7oQd0
         k3DE+oKEc/ln302jaTTsSQHo20oI3NjhbdrLdcYxQj8I4uLlASaFdrgcajXByKMrKO
         x1a8O9Sj+QO+bDD9bx8NUiXMC50HkbW1IidRNnlKFBP7+HV2WD3XIEM05FyLnJfsOe
         o/OjRzdsiNjoSPX2gUpDMqHo1kBSAhPahLFz2LE9Gww4Y0F0Ow6mkR0zG1Ksqul99U
         VRkaxj6j0japH1Ea7FTS2Ydu/aMaIHHXVj/VrFFah6KuThb1oSxv1E7MpZ3+J3DvWz
         Kl4BAYOzzI3NA==
Message-ID: <c38a32fce0d3642b6be85efd46d8c358.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230615122051.546985-2-angelogioacchino.delregno@collabora.com>
References: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com> <20230615122051.546985-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/3] clk: mediatek: clk-mtk: Grab iomem pointer for divider clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, msp@baylibre.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Fri, 16 Jun 2023 12:21:01 -0700
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

Quoting AngeloGioacchino Del Regno (2023-06-15 05:20:49)
> In the rare case in which one of the clock drivers has divider clocks
> but not composite clocks, mtk_clk_simple_probe() would not io(re)map,
> hence passing a NULL pointer to mtk_clk_register_dividers().
>=20
> To fix this issue, extend the `if` conditional to also check if any
> divider clocks are present. While at it, also make sure the iomem
> pointer is NULL if no composite/divider clocks are declared, as we
> are checking for that when iounmapping it in the error path.
>=20
> This hasn't been seen on any MediaTek clock driver as the current ones
> always declare composite clocks along with divider clocks, but this is
> still an important fix for a future potential KP.
>=20
> Fixes: 1fe074b1f112 ("clk: mediatek: Add divider clocks to mtk_clk_simple=
_{probe,remove}()")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
