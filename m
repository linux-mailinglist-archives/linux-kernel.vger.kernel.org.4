Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421216B8609
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCMXXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCMXW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:22:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533B87B9BF;
        Mon, 13 Mar 2023 16:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D828A6152C;
        Mon, 13 Mar 2023 23:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD1CC433EF;
        Mon, 13 Mar 2023 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678749775;
        bh=e2T3EnCeToIbB1oGc6Q3Dvzk4LxSn3pFP8jTx088sJs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bR116asJKEglby1yrat+gFGDWWT5x1rh4z3Z2BeehrZWPc05TN4B/G8vaJXUllt+/
         w9KCV3Z3HkzdK8nnYL+jFZpQL3haeCSge+8rhfEOLxUGdLX7Xap9NjmYdXdNQxvjii
         zaXtb8vCenhjps1oGXxbtRMOqO+YnTXy6UlWOIKmCoW0u3K3fFB99/+TuzBik4cUtg
         vXtj57ybwUGw5XaVjX7P2HoeVHR+NZ5LEvNRXcZseTSQHM7/Pk8/W3sSO+Cp7YuShA
         UV+40FCJSQbqtet2ILUmUUq1dscMyxWwD8Afl5ovKK4fuMCaOhQBzxsFX+P1AP4ya5
         podxAbjicU2QA==
Message-ID: <6c52bcda08b62593c541d52e269d3982.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 00/54] MediaTek clocks: full module build and cleanups
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        wenst@chromium.org, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        daniel@makrotopia.org, fparent@baylibre.com, msp@baylibre.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhaojh329@gmail.com, sam.shih@mediatek.com,
        edward-jw.yang@mediatek.com, yangyingliang@huawei.com,
        granquet@baylibre.com, pablo.sun@mediatek.com,
        sean.wang@mediatek.com, chen.zhong@mediatek.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Mon, 13 Mar 2023 16:22:52 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2023-03-06 06:04:49)
>=20
> This huge series adds more cleanups on top, reducing size and adding more
> commonization for clock drivers probe/remove, which also includes a new
> common probe mechanism for multimedia clock drivers that are usually
> probed by mtk-mmsys instead of a dt clock node: thanks to this, it was
> finally possible to convert almost all clock drivers to the common probe
> mechanism, which *finally again* makes us able to build all these drivers
> as modules!
>=20
> Since this looked like being *the* way forward, I went on converting some
> more drivers away from OF_CLK_DECLARE_DRIVER to full platform_driver(s),
> allowing for more (actually, almost all!) drivers to be built as modules.
>=20
> While at it, I also added some more consistency in macros usage by
> removing all of the duplicated full macro declaration for MediaTek gate
> clocks and replacing all of those with using the GATE_MTK macro instead,
> producing a nice reduction in amount of lines per file but, more
> importantly, improving readability and eventual future batch changes.
>=20
> This amount of commonization will also, in my opinion, greatly improve
> the review process for new clock drivers, as they will be mostly just a
> list of clocks and won't contain much new code, as it's all going to be
> handled in the common places, which also reduces chances to see new clock
> driver related bugs emerging on one SoC or the other.
>=20
> Since I don't own devices with all of the supported MediaTek SoCs, I
> could not test some of the conversions on real hardware... but I am
> confident that this will work as the drivers are *very* similar on a
> per-generation basis.
>=20
> This series was build-tested for all (both module and built-in build)
> and was manually tested on MT6795, MT8173, MT8192, MT8195.
>=20

Applied the whole series to clk-next.
