Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957E2745C14
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjGCMTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGCMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:19:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C41AD;
        Mon,  3 Jul 2023 05:18:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-160-45-219.reb.o2.cz [85.160.45.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A02C2512;
        Mon,  3 Jul 2023 14:18:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688386689;
        bh=fHLoFwnP7N99CrLDMZJdiDw1fOyEzuyRgMPQdQXI1bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BeL/PXXMRb5rPrT9rJQ8tmN4prPUpakUuz4df5PMhJs27sLZ7P4kNDeafB1Icx4tX
         eBuib0hIyGK/MxkYdkwj1F13VU5uOxsYcdn7PeldXy1lTut1BVoJhmuxSBwR7H6oFO
         QMPMnGdAJiZKAczkIOUqB8QKQVApL8w3eoNFfLV0=
Date:   Mon, 3 Jul 2023 15:18:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Julien Stephan <jstephan@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Message-ID: <20230703121853.GA16531@pendragon.ideasonboard.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-3-jstephan@baylibre.com>
 <CAAOTY_-qu2RWr496wXxc1Cp14eZfzKt4QgEH8fJns2LOjpwi8Q@mail.gmail.com>
 <CAAOTY_9SFRMb7d3c62SVDnZY00hRAZ=9wBi9QCcv1UKuc8iBtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAOTY_9SFRMb7d3c62SVDnZY00hRAZ=9wBi9QCcv1UKuc8iBtQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 05:20:25PM +0800, Chun-Kuang Hu wrote:
> Chun-Kuang Hu <chunkuang.hu@kernel.org> 於 2023年7月2日 週日 上午7:35寫道：
> > Julien Stephan <jstephan@baylibre.com> 於 2023年6月30日 週五 下午6:05寫道：
> > >
> > > From: Louis Kuo <louis.kuo@mediatek.com>
> > >
> > > This will add the mediatek ISP3.0 seninf (sensor interface) driver found
> > > on several Mediatek SoCs such as the mt8365.
> > >
> > > Then seninf module has 4 physical CSI-2 inputs. Depending on the soc they
> > > may not be all connected.
> > >
> > > Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> > > Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> > > Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > >
> >
> > [snip]
> >
> > > +
> > > +static const struct mtk_seninf_conf seninf_8365_conf = {
> > > +       .model = "mtk-camsys-3.0",
> > > +       .nb_inputs = 4,
> > > +       .nb_muxes = 6,
> > > +       .nb_outputs = 4,
> > > +};
> > > +
> > > +static const struct of_device_id mtk_seninf_of_match[] = {
> > > +       {
> > > +               .compatible = "mediatek,mt8365-seninf",
> > > +               .data = &seninf_8365_conf,
> >
> > Now only support one SoC, so it's necessary to select the SoC data and
> > you could directly place the data in the code. After support other
> 
> Typo.
> 
> Now only support one SoC, so it's not necessary to select the SoC data
> and you could directly place the data in the code.

I think Julien has visibility on other SoCs that could use the same
driver, and has designed the mtk_seninf_conf structure accordingly. I'll
let Julien confirm (or tell I'm wrong).

> > SoC, so we could know what should be placed in struct mtg_seninf_conf
> > (Now we have no any information).
> >
> > > +       },
> > > +       {
> > > +       },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mtk_seninf_of_match);

-- 
Regards,

Laurent Pinchart
