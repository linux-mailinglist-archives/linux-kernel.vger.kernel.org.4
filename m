Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0904967F221
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjA0XRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA0XRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:17:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D18B7BF;
        Fri, 27 Jan 2023 15:17:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B9AB61DDA;
        Fri, 27 Jan 2023 23:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CC0C4339B;
        Fri, 27 Jan 2023 23:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674861433;
        bh=yAH3FEaklexlVeMM/F+Mq5G7RmdCgW4ngE83Zd5lWmo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nN9FbRLtgFL6cOBuWQftB7zqy0UzNOFywDIxyJqttRn6JaQB9JHDONJ0OCXtk2zq0
         Dofi6oiyheH6xDyyr/WppyRsIW/v2i2JqLsPWiGrxe/FiQUWFUPsD9ujfLW58k5odw
         RtFttHz2vAnLgCX1E/OUfoLhDJ91xgOJMYwh8cNg4RU3GcL2h2qOTL5lW5KPI3j90v
         IjTCAFy0jE6lqKO0lHx8JaXScjnQe91DeeO6C1DuHLGUXTqPGJyaBMsbHQLIficHde
         sAnZ2UlyaQQ21YaTaoKsGE7Hy5FyLCWk9gZGcnmsio1UH1T5j2dqTHe6zxglhPil5N
         l5hyBXbH2Vm2w==
Message-ID: <47323f5043bc32140cbdbf6d08b8a0fd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8136eb5b2049177bc2f6d3e0f2aefecc342d626f.1674703830.git.daniel@makrotopia.org>
References: <cover.1674703830.git.daniel@makrotopia.org> <8136eb5b2049177bc2f6d3e0f2aefecc342d626f.1674703830.git.daniel@makrotopia.org>
Subject: Re: [PATCH v5 3/3] clk: mediatek: add MT7981 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jianhui Zhao <zhaojh329@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
To:     Daniel Golle <daniel@makrotopia.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Fri, 27 Jan 2023 15:17:11 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Golle (2023-01-25 19:34:24)
> Add MT7981 clock support, include topckgen, apmixedsys, infracfg and
> ethernet subsystem clocks.
>=20
> The drivers are based on clk-mt7981.c which can be found in MediaTek's
> SDK sources. To be fit for upstream inclusion the driver has been split
> into clock domains and the infracfg part has been significantly
> de-bloated by removing all the 1:1 factors (aliases).
>=20
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied to clk-next
