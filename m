Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E2D72D6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjFMBU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjFMBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D1A0;
        Mon, 12 Jun 2023 18:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 971CB63054;
        Tue, 13 Jun 2023 01:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5351C433EF;
        Tue, 13 Jun 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686619225;
        bh=YdskngeEcOIWgTt3CvN/zNedLuSr1xP/8qu9xlcJdQs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=s8TTefKuTfuaxV3ANtu5ilAPpnTaLrchERccUmCal8a7CLtJGmc4qldXrvJ0/gWUE
         MFv0n8P/yugPws72/Vd61669NorNoKdInBZ/kMkf8Ag/3c/wIGUplqU3+WHWlMgwC2
         srDwfKFMV1znbXU+OJLkr+LlArIZffe+iZp7Zadzxonc0beZoCTH7ZG43B2kAtbFsp
         9kGIIMSE7Fdgg9GhhBr5jU5qVZFQ0CIltwVa+/LHlsbTykZwFVpaoS9nVwfdmE/Mlu
         Wf/vszVTPhEofh50J2e5m5Cxex5Oi1ZYsTmdDN7vUSJv6P/zePHWekaU3v9uXnWU5X
         KJClyptzw6s6A==
Message-ID: <5292235a5581b68ba8cd1243020c8fa3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230516135205.372951-2-angelogioacchino.delregno@collabora.com>
References: <20230516135205.372951-1-angelogioacchino.delregno@collabora.com> <20230516135205.372951-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] clk: mediatek: mux: Stop forcing CLK_SET_RATE_PARENT flag
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
Date:   Mon, 12 Jun 2023 18:20:22 -0700
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

Quoting AngeloGioacchino Del Regno (2023-05-16 06:52:04)
> The clk-mux driver was forcing the CLK_SET_RATE_PARENT flag even for
> the GATE_CLK_SET_UPD_FLAGS() macro, as in mtk_clk_register_mux() the
> flag was unconditionally added.
>=20
> In preparation for a change on MSDC clock muxes, stop forcing this
> flag and, where necessary, update clock drivers to add it so that
> with this commit we introduce no functional changes for the currently
> supported SoCs.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

Applied to clk-next
