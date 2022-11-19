Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F2E630FAC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 18:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiKSRTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 12:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKSRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 12:19:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF911C27;
        Sat, 19 Nov 2022 09:19:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8CFC5749;
        Sat, 19 Nov 2022 18:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668878352;
        bh=VrJTKizOe2YunSUmQn/OwL6ElVv/m3nvCVjBO+OezFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v2XqIaTDLORxdfkirAQmgwNu3eFhcy073+DUCHQCbo6hPH64HpNewH4QuhDOEzDcS
         kkLEehQF6NYqwWmf3wowryQ1sW/mUMXCPmOakwieLXzn7xzxyIz7HlsuKR3WcxVsG/
         5bgczrpafW8shlOMOLxa5AK/nVNHoMUl3GiH6R/Y=
Date:   Sat, 19 Nov 2022 19:18:56 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dafna Hirschfeld <dafna@fastmail.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v3 03/14] media: rkisp1: Add and use rkisp1_has_feature()
 macro
Message-ID: <Y3kQAC0g+9Tz/2tc@pendragon.ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-4-paul.elder@ideasonboard.com>
 <20221119110322.4drj7qqtp46vjcnn@guri>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221119110322.4drj7qqtp46vjcnn@guri>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On Sat, Nov 19, 2022 at 01:03:22PM +0200, Dafna Hirschfeld wrote:
> On 18.11.2022 18:39, Paul Elder wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Simplify feature tests with a macro that shortens lines.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
> > Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > ---
> >  .../media/platform/rockchip/rkisp1/rkisp1-common.h |  3 +++
> >  .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 14 +++++++-------
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > index a1293c45aae1..fc33c185b99f 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > @@ -111,6 +111,9 @@ enum rkisp1_feature {
> >  	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
> >  };
> > 
> > +#define rkisp1_has_feature(rkisp1, feature) \
> > +	((rkisp1)->info->features & RKISP1_FEATURE_##feature)
> 
> maybe instead of that string concatination you can remove the
> 'RKISP1_FEATURE' prefix from the enum

We could, but I'm worried this would create short names subject to
namespace clashes (such as "MIPI_CSI2" for instance).

> > +
> >  /*
> >   * struct rkisp1_info - Model-specific ISP Information
> >   *
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> > index f2475c6235ea..e348d8c86861 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> > @@ -206,7 +206,7 @@ static int rkisp1_subdev_notifier_register(struct rkisp1_device *rkisp1)
> >  		switch (reg) {
> >  		case 0:
> >  			/* MIPI CSI-2 port */
> > -			if (!(rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)) {
> > +			if (!rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
> >  				dev_err(rkisp1->dev,
> >  					"internal CSI must be available for port 0\n");
> >  				ret = -EINVAL;
> > @@ -338,7 +338,7 @@ static int rkisp1_create_links(struct rkisp1_device *rkisp1)
> >  	unsigned int i;
> >  	int ret;
> > 
> > -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2) {
> > +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
> >  		/* Link the CSI receiver to the ISP. */
> >  		ret = media_create_pad_link(&rkisp1->csi.sd.entity,
> >  					    RKISP1_CSI_PAD_SRC,
> > @@ -390,7 +390,7 @@ static int rkisp1_create_links(struct rkisp1_device *rkisp1)
> > 
> >  static void rkisp1_entities_unregister(struct rkisp1_device *rkisp1)
> >  {
> > -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)
> > +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
> >  		rkisp1_csi_unregister(rkisp1);
> >  	rkisp1_params_unregister(rkisp1);
> >  	rkisp1_stats_unregister(rkisp1);
> > @@ -423,7 +423,7 @@ static int rkisp1_entities_register(struct rkisp1_device *rkisp1)
> >  	if (ret)
> >  		goto error;
> > 
> > -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2) {
> > +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
> >  		ret = rkisp1_csi_register(rkisp1);
> >  		if (ret)
> >  			goto error;
> > @@ -590,7 +590,7 @@ static int rkisp1_probe(struct platform_device *pdev)
> >  		goto err_unreg_v4l2_dev;
> >  	}
> > 
> > -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2) {
> > +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
> >  		ret = rkisp1_csi_init(rkisp1);
> >  		if (ret)
> >  			goto err_unreg_media_dev;
> > @@ -611,7 +611,7 @@ static int rkisp1_probe(struct platform_device *pdev)
> >  err_unreg_entities:
> >  	rkisp1_entities_unregister(rkisp1);
> >  err_cleanup_csi:
> > -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)
> > +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
> >  		rkisp1_csi_cleanup(rkisp1);
> >  err_unreg_media_dev:
> >  	media_device_unregister(&rkisp1->media_dev);
> > @@ -630,7 +630,7 @@ static int rkisp1_remove(struct platform_device *pdev)
> >  	v4l2_async_nf_cleanup(&rkisp1->notifier);
> > 
> >  	rkisp1_entities_unregister(rkisp1);
> > -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)
> > +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
> >  		rkisp1_csi_cleanup(rkisp1);
> >  	rkisp1_debug_cleanup(rkisp1);
> > 

-- 
Regards,

Laurent Pinchart
