Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2874E637
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGKFIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGKFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:07:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A5FE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 526086130E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDABC433C7;
        Tue, 11 Jul 2023 05:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689052073;
        bh=wjkMoyAhJGd6T02GJdgC2lALppVBAQc+npo6LEKPwXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoIrIlsiTv94suh1qMxzAazKBYXheLGtW+XdRvV07wGkjYJV67Asp7y6AHPR7Wqff
         gPounYHIHTpsA16DkGo6pwtnX1v6JbMYO3Af9Wbm0qSwF5rX94chE6hkGEt2k76eCn
         PWM5WYRcBZLOmmCgdZ2M6fO+qTDMc8jyDPlk1UnTekVkHcQI3zwmAMEUkL24X4KI8i
         CJoI4hkYguxZBa7gcnXV2Z3GJ4F4A2nlOrp6v1tGDQhMH9wp3GDGTpFF0O9qHFQVjY
         Hii5lDUt8sel6W/e7TqaVHgJfu51dBSRwZtzAopSkmoCVG1IlC7Ggh0wd6sWKK2822
         Cz1Z4upEVXvRQ==
Date:   Tue, 11 Jul 2023 10:37:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] phy: mediatek: tphy: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKzjpebqy+J2b1hH@matsya>
References: <20230705090126.26854-1-frank.li@vivo.com>
 <20230705090126.26854-4-frank.li@vivo.com>
 <ddc05f70-7075-97ab-1c94-cb3d5839ef2b@collabora.com>
 <6a1bde36-fbf9-9ddd-e47f-f3c21a3528f7@vivo.com>
 <be88f6db-8b07-1767-f48c-24a215006a4f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be88f6db-8b07-1767-f48c-24a215006a4f@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-23, 12:00, AngeloGioacchino Del Regno wrote:
> Il 05/07/23 11:30, Yangtao Li ha scritto:
> > HI AngeloGioacchino,
> > 
> > On 2023/7/5 17:22, AngeloGioacchino Del Regno wrote:
> > > Il 05/07/23 11:01, Yangtao Li ha scritto:
> > > > Use devm_platform_ioremap_resource() to simplify code.
> > > > 
> > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > ---
> > > >   drivers/phy/mediatek/phy-mtk-tphy.c | 10 +++-------
> > > >   1 file changed, 3 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > index 0d110e50bbfd..cb7a4e6ea017 100644
> > > > --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > @@ -1554,7 +1554,6 @@ static int mtk_tphy_probe(struct platform_device *pdev)
> > > >       struct device_node *np = dev->of_node;
> > > >       struct device_node *child_np;
> > > >       struct phy_provider *provider;
> > > > -    struct resource *sif_res;
> > > >       struct mtk_tphy *tphy;
> > > >       struct resource res;
> > > >       int port, retval;
> > > > @@ -1576,15 +1575,12 @@ static int mtk_tphy_probe(struct platform_device *pdev)
> > > >       tphy->dev = dev;
> > > >       platform_set_drvdata(pdev, tphy);
> > > >   -    sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >       /* SATA phy of V1 needn't it if not shared with PCIe or USB */
> > > > -    if (sif_res && tphy->pdata->version == MTK_PHY_V1) {
> > > > +    if (tphy->pdata->version == MTK_PHY_V1) {
> > > >           /* get banks shared by multiple phys */
> > > > -        tphy->sif_base = devm_ioremap_resource(dev, sif_res);
> > > > -        if (IS_ERR(tphy->sif_base)) {
> > > > -            dev_err(dev, "failed to remap sif regs\n");
> > > > +        tphy->sif_base = devm_platform_ioremap_resource(pdev, 0);
> > > > +        if (IS_ERR(tphy->sif_base) && PTR_ERR(tphy->sif_base) != -EINVAL)
> > > 
> > > That's wrong. You want to return any error unconditionally, as the V1 PHY *needs*
> > > the sif iospace and there's nothing afterwards retrying this.
> > 
> > 
> > When sif_res is not configured, an IOMEM_ERR_PTR(-EINVAL) error will be
> > returned in __devm_ioremap_resource.
> > 
> > This kind of error is ignored in the newly added code, and the driving
> > probe process will not be interrupted at this time.
> > 
> > What did I miss?
> > 
> 
> As I said, MTK_PHY_V1 *needs* sif; devm_platform_ioremap_resource() returns a
> handle to that iospace, or error.
> 
> tphy->sif_base = devm_platform_ioremap_resource(pdev, 0);
> if (IS_ERR(tphy->sif_base))
> 	return PTR_ERR(tphy->sif_base);

That does sound right to me

-- 
~Vinod
