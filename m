Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1335E7B24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiIWMtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiIWMtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:49:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD586139BDD;
        Fri, 23 Sep 2022 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663937340; x=1695473340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pvzCMoIi3TgxvSEcGftMGOHmGc70uludjLAuawOIvMQ=;
  b=RVmo6DNe/woh1qVQIrSLLUZMg1oCRP9Dav1lI5oaG8NDK8SfpnyKeRKH
   OKrPVxi9xmWFBVLU3aAddGr8Tw3Bo+oM9LGMNg+iiWAqTkCAVfHQoJvF2
   qZIYAfXc+uId24LAaCXvf+aWIfimUbyXAiJ2nunD7tbKWZnxyO6FGVRBl
   IEmiax7FFTY0VGZyuYjZrkEBzcgTVRwFCX2oi3WbNg2HNPbT1+xAWuVQC
   8j72OxDbszNz73Og/J0M0shulOcND6eqlX/7IjnbHtNBdcejngbmFwWYC
   8QFiXnUC+Rg+UPlSssa+8jGZsJ2N81jMQ8Pzza4wxsSk4mOea/QeWX3Pz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="364599710"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="364599710"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:49:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="724115965"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:48:56 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 856FB20124;
        Fri, 23 Sep 2022 15:48:54 +0300 (EEST)
Date:   Fri, 23 Sep 2022 12:48:54 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        laurent.pinchart@ideasonboard.com, jacopo@jmondi.org,
        hverkuil@xs4all.nl, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <Yy2rNit+rRGkcFdL@paasikivi.fi.intel.com>
References: <20220922134843.3108267-1-m.felsch@pengutronix.de>
 <20220922134843.3108267-5-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922134843.3108267-5-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Thanks for the update. A few small things below.

On Thu, Sep 22, 2022 at 03:48:43PM +0200, Marco Felsch wrote:
...
> +static int tc358746_apply_misc_config(struct tc358746 *tc358746)
> +{
> +	const struct v4l2_mbus_framefmt *mbusfmt;
> +	struct v4l2_subdev *sd = &tc358746->sd;
> +	struct v4l2_subdev_state *sink_state;
> +	const struct tc358746_format *fmt;
> +	struct device *dev = sd->dev;
> +	u32 val;
> +	int err;
> +
> +	sink_state = v4l2_subdev_lock_and_get_active_state(sd);
> +	mbusfmt = v4l2_subdev_get_pad_format(sd, sink_state, TC358746_SINK);
> +	v4l2_subdev_unlock_state(sink_state);
> +
> +	fmt = tc358746_get_format_by_code(TC358746_SINK, mbusfmt->code);

You can no longer access mbusfmt here as you've already unlocked subdev
state.

> +
> +	/* Self defined CSI user data type id's are not supported yet */
> +	val = PDFMT(fmt->pdformat);
> +	dev_dbg(dev, "DATAFMT: 0x%x\n", val);
> +	err = tc358746_write(tc358746, DATAFMT_REG, val);
> +	if (err)
> +		return err;
> +
> +	val = PDATAF(fmt->pdataf);
> +	dev_dbg(dev, "CONFCTL[PDATAF]: 0x%x\n", fmt->pdataf);
> +	err = tc358746_update_bits(tc358746, CONFCTL_REG, PDATAF_MASK, val);
> +	if (err)
> +		return err;
> +
> +	val = tc358746->vb_size / 32;
> +	dev_dbg(dev, "FIFOCTL: %u (0x%x)\n", val, val);
> +	err = tc358746_write(tc358746, FIFOCTL_REG, val);
> +	if (err)
> +		return err;
> +
> +	/* Total number of bytes for each line/width */
> +	val = mbusfmt->width * fmt->bpp / 8;
> +	dev_dbg(dev, "WORDCNT: %u (0x%x)\n", val, val);
> +	return tc358746_write(tc358746, WORDCNT_REG, val);
> +}

...

> +static int tc358746_s_stream(struct v4l2_subdev *sd, int enable)
> +{
> +	struct tc358746 *tc358746 = to_tc358746(sd);
> +	struct v4l2_subdev *src;
> +	int err;
> +
> +	dev_dbg(sd->dev, "%sable\n", enable ? "en" : "dis");
> +
> +	src = tc358746_get_remote_sd(&tc358746->pads[TC358746_SINK]);
> +	if (!src)
> +		return -EPIPE;
> +
> +	if (enable) {
> +		err = pm_runtime_resume_and_get(sd->dev);
> +		if (err)
> +			return err;
> +
> +		err = tc358746_apply_dphy_config(tc358746);
> +		if (err)
> +			goto err_out;
> +
> +		err = tc358746_apply_misc_config(tc358746);
> +		if (err)
> +			goto err_out;
> +
> +		err = tc358746_enable_csi_lanes(tc358746, 1);
> +		if (err)
> +			goto err_out;
> +
> +		err = tc358746_enable_csi_module(tc358746, 1);
> +		if (err)
> +			goto err_out;
> +
> +		err = tc358746_enable_parallel_port(tc358746, 1);
> +		if (err)
> +			goto err_out;
> +
> +		err = v4l2_subdev_call(src, video, s_stream, 1);
> +		if (err)
> +			goto err_out;
> +
> +		return err;

This can be return 0.

> +
> +err_out:
> +		pm_runtime_mark_last_busy(sd->dev);
> +		pm_runtime_put_sync_autosuspend(sd->dev);
> +
> +		return err;
> +	}

-- 
Kind regards,

Sakari Ailus
