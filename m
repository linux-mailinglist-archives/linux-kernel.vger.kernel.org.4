Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960860F393
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiJ0JWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJ0JWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:22:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF92837428;
        Thu, 27 Oct 2022 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666862553; x=1698398553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B2DWWDfUsiKyktfanKjjzgcDXjdREy8+Y3UB+FVi+Io=;
  b=DFk7hH2vmc9bjjhe7MczHF/HO92fFQ3BJ6Kv7Q/aN146MvQpU7aSPziL
   TRuGEfW4teJ0/VkdFt0kSqv4F3+iu0oP/2b6RbRYTaFJ+OWOZ1rFHUgbh
   tQeo9lqfPhZtswU1TN27KPDDP4a5Ge7ZluRSqDXKZouS1FHId63mkO4tM
   rPSiUYihK7G2P3IEYFmxTz95NI1h0yUJ//g5+wPxbFw+9GD14zgQZ3A4j
   M9yZGk8zCOYX5Zi6wg/VrrXkn2e2HAuG85CdF+TXiDxPZwCAMf1Gx2kH7
   l8FbCUgTfOj5RSh6e50dkUgUgVozjemSv0rUsja2PCJfAnpYKF5luDXTA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="308168707"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="308168707"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:22:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="737607691"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="737607691"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:22:28 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 5C07D2026C;
        Thu, 27 Oct 2022 12:22:26 +0300 (EEST)
Date:   Thu, 27 Oct 2022 09:22:26 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 6/9] media: i2c: ov5645: Use runtime PM
Message-ID: <Y1pN0oksKeauTpBA@paasikivi.fi.intel.com>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026130658.45601-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026130658.45601-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for the update.

On Wed, Oct 26, 2022 at 02:06:55PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Switch to using runtime PM for power management.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v2->v3
> * Jumped to err_pm_runtime label in case of sd register failure
> * Now calling pm_runtime_mark_last_busy() before pm_runtime_put_autosuspend()
>   call
> * Now calling pm_runtime_put_sync() in case s_stream(1) fails
> * In s_stream(0) no calling pm_runtime_mark_last_busy() and
>   pm_runtime_put_autosuspend()
> * Included RB tag from Laurent.
> 
> v1->v2
> * Moved pm_runtime_*_autosuspend() calls after registering the subdev.
> ---
>  drivers/media/i2c/Kconfig  |   2 +-
>  drivers/media/i2c/ov5645.c | 141 +++++++++++++++++++------------------
>  2 files changed, 73 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 7806d4b81716..c0edd1017fe8 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -459,7 +459,7 @@ config VIDEO_OV5640
>  config VIDEO_OV5645
>  	tristate "OmniVision OV5645 sensor support"
>  	depends on OF
> -	depends on I2C && VIDEO_DEV
> +	depends on I2C && PM && VIDEO_DEV

I think you can drop the PM dependency --- the driver will work fine
without CONFIG_PM.

Although one could question why do we have CONFIG_PM. Some systems won't
boot without it and who would want to consume more power than necessary?

Could this be removed altogether? Or perhaps we could add CONFIG_PM
dependency to V4L2 and DVB? :-)

Certainly out of scope of this set though.

-- 
Kind regards,

Sakari Ailus
