Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6CA6ACF42
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCFUfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFUfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:35:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEA93E611;
        Mon,  6 Mar 2023 12:35:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76102B81107;
        Mon,  6 Mar 2023 20:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006BBC433EF;
        Mon,  6 Mar 2023 20:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678134906;
        bh=1G3N5PVmkon6vfUF7PxpALoL8dBrGQ2f+oMsV2VCin0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pzoFEX3TnEDvOID9sxcxyBWmQb/GMaRmWOwVkdA9429maq9xj87XoGIeYpbSuJi9N
         ceT8VEVQA+f3gb6AWv7I4M5eq/d5QKnO9jRiV/LMvMs8CXoKIC1IAPT6tzwNjz4Pg6
         Ad2dcoo0q1PUpXo9C7Xb0kKz2y0EYNNbTNMWuj1lASoxRjougCPKQ8lDVXDQHDT2F9
         ncrn0i7nkeAx56qFbO1o9U39dwORW9SmvDGw5RvmR9lDfsMLqa836s23O/pNfj2rTd
         KA4fkljCU7PUwh8y5nk60PY3j/QY+eHckG9x4W48ckPGGQiA5pZPU4M2ncJ8+Vd7Br
         FQZheSm/YqCJg==
Message-ID: <b772f0075322b7bec01881e478c8dc4e.sboyd@kernel.org>
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
Date:   Mon, 06 Mar 2023 12:35:02 -0800
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
> NOTE: Applies on top of [1] and [2].
>=20
>=20
> Full blurb:
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
> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D7=
19067
> [2]: https://patchwork.kernel.org/project/linux-mediatek/patch/2023020701=
4800.7619-2-moudy.ho@mediatek.com/
>=20

Please use lore links (https://lore.kernel.org/r/<message-id>). [2] has
been applied in an alternative form. [1] doesn't have any review besides
DT review. Please get it reviewed.
