Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB8260F61A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiJ0LU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiJ0LU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:20:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876EB72FD8;
        Thu, 27 Oct 2022 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666869655; x=1698405655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n+6l6M6A5lyLOnRfDL5yPnQAsnHZqojf7vW9iC3diEI=;
  b=WAyglAx5a0eAhOsxGJacsiJjMtZ7+vjIdLepGY8gdAxFFSe1diIvOKTu
   oNT/WfwpPoHEsTc/8ofSxsDPI6/FLYryY1DN8oCab1SqwWzmfdju7PG88
   tIZMFQb+MviH92+SsiDImRGtugkymjlsuXxJaYfGerrerSYwVuDPY/li+
   y50tigVZ/uUKhVoJpltIjIQx6MGAQP3rAr/qW9amms2Xye4BLX/Utc63q
   A/24Ji9SW4ueeVIBW5uhAGDVRbTzmFrME3/oWdgevYRjDC9yVIz7HCp6L
   KGHNC0sZEbf0TzcvnyFvdH9OK4PYIrK0t8TCgVnr+QJEHPDaFzEayxmx/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309287701"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="309287701"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 04:20:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="634865973"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="634865973"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 04:20:42 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id E87862021B;
        Thu, 27 Oct 2022 14:20:37 +0300 (EEST)
Date:   Thu, 27 Oct 2022 11:20:37 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 2/5] media: i2c: ov5645: Use runtime PM
Message-ID: <Y1pphVPw0J97AmW4@paasikivi.fi.intel.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

One more comment.

On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
>  
>  	dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
>  
> +	pm_runtime_set_active(dev);
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);

You won't gain anything by eanbling runtime PM here. Just move it to the
end of the function before the rest of the calls. Error handling becomes
more simple.

> +
>  	ret = ov5645_read_reg(ov5645, OV5645_AEC_PK_MANUAL,
>  			      &ov5645->aec_pk_manual);
>  	if (ret < 0) {
>  		dev_err(dev, "could not read AEC/AGC mode\n");
>  		ret = -ENODEV;
> -		goto power_down;
> +		goto err_pm_runtime;
>  	}
>  
>  	ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG20,
> @@ -1222,7 +1207,7 @@ static int ov5645_probe(struct i2c_client *client)
>  	if (ret < 0) {
>  		dev_err(dev, "could not read vflip value\n");
>  		ret = -ENODEV;
> -		goto power_down;
> +		goto err_pm_runtime;
>  	}
>  
>  	ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG21,
> @@ -1230,23 +1215,30 @@ static int ov5645_probe(struct i2c_client *client)
>  	if (ret < 0) {
>  		dev_err(dev, "could not read hflip value\n");
>  		ret = -ENODEV;
> -		goto power_down;
> +		goto err_pm_runtime;
>  	}
>  
> -	ov5645_s_power(&ov5645->sd, false);
> -
>  	ret = v4l2_async_register_subdev(&ov5645->sd);
>  	if (ret < 0) {
>  		dev_err(dev, "could not register v4l2 device\n");
> +		pm_runtime_disable(dev);
> +		pm_runtime_set_suspended(dev);
>  		goto free_entity;
>  	}
>  
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
>  	ov5645_entity_init_cfg(&ov5645->sd, NULL);
>  
>  	return 0;
>  
> +err_pm_runtime:
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
>  power_down:
> -	ov5645_s_power(&ov5645->sd, false);
> +	ov5645_set_power_off(dev);
>  free_entity:
>  	media_entity_cleanup(&ov5645->sd.entity);
>  free_ctrl:

-- 
Kind regards,

Sakari Ailus
