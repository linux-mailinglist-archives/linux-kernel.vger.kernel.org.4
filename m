Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125FE65CF83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjADJ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjADJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:27:13 -0500
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A906E67
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=2DXwEG/gDuXeSPpZjXIXMjYCJ0FeZAl+aZ5Y9/GpzH8=;
        b=xllPdRwcrFK+BPin+Gj0X+3YEWsU/EDmvljxuDSq3DynzcPzsJSSNzST6w7nmGAvHLfnHaS3pXqe8
         hrKj+ntU6q4rBpGKGZd+8Rwf0qXxAjLrTJQ6Kh56fLec7kr8K4QuYyPrf9pqWaZMhYovhh4/fWdZe3
         zRdMHW4uf2P49fGXPrfBhWXMD4ofT9biWcRWVfnAbcrNzGVQ7zWSvC3Qrkw+j1xmAWDXzyZg/fLbuA
         v+S/r+J5onMSnCVImCKZdb1uxBs4618ktCQmXfaxl7bvhs7IaimBp2EakGoLa6JOSmPNirapTq+CKk
         949a9gfsFG0GQApaOYK9oAG5IqttuAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=2DXwEG/gDuXeSPpZjXIXMjYCJ0FeZAl+aZ5Y9/GpzH8=;
        b=Q0fnIRs0JZ7uliqgZ6c1ks9IDhxdKRfY+mbj1zuOrZtyL0hIdAR4Wq3QL2wg/HzP2OhaWvEc23QSD
         OesI8hrDQ==
X-HalOne-ID: f5253b6e-8c11-11ed-9c1d-7703b0afff57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id f5253b6e-8c11-11ed-9c1d-7703b0afff57;
        Wed, 04 Jan 2023 09:27:09 +0000 (UTC)
Date:   Wed, 4 Jan 2023 10:27:08 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: add visionox vtdr6130 DSI panel driver
Message-ID: <Y7VGbPoNVYBwfnlc@ravnborg.org>
References: <20230103-topic-sm8550-upstream-vtdr6130-panel-v1-0-9b746b858378@linaro.org>
 <20230103-topic-sm8550-upstream-vtdr6130-panel-v1-2-9b746b858378@linaro.org>
 <Y7RwuZKh1XMMuB70@ravnborg.org>
 <e9f2befa-a433-c737-ce96-2f94556b290c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f2befa-a433-c737-ce96-2f94556b290c@linaro.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> 
> > 
> > > +
> > > +struct visionox_vtdr6130 {
> > > +	struct drm_panel panel;
> > > +	struct mipi_dsi_device *dsi;
> > > +	struct gpio_desc *reset_gpio;
> > > +	struct regulator_bulk_data supplies[3];
> > > +	bool prepared;
> > > +};
> > > +
> > > +static inline struct visionox_vtdr6130 *to_visionox_vtdr6130(struct drm_panel *panel)
> > > +{
> > > +	return container_of(panel, struct visionox_vtdr6130, panel);
> > > +}
> > > +
> > > +static inline int visionox_vtdr6130_dsi_write(struct mipi_dsi_device *dsi, const void *seq,
> > > +					      size_t len)
> > > +{
> > > +	return mipi_dsi_dcs_write_buffer(dsi, seq, len);
> > > +}
> > > +
> > > +#define dsi_dcs_write_seq(dsi, seq...)					\
> > > +	{								\
> > > +		const u8 d[] = { seq };					\
> > > +		visionox_vtdr6130_dsi_write(dsi, d, ARRAY_SIZE(d));	\
> > > +	}
> > Please use mipi_dsi_dcs_write_seq()
> > No need to add your own macros here.
> > 
> > This will also add a little bit of error reporting that is missing here.
> 
> OK, should I add a check and return in the macro in case of error ?
> Checkpatch emits some warning when this is done.

I expect you can use the macro as-is like this:
- dsi_dcs_write_seq(dsi, 0x51, 0x00, 0x00);
+ mipi_dsi_dcs_write_seq(dsi, 0x51, 0x00, 0x00);

So no need to create your own macro at all - just use the already
existing mipi_dsi_dcs_write_seq().

> 
> > 
> > 
> > > +
> > > +static void visionox_vtdr6130_reset(struct visionox_vtdr6130 *ctx)
> > > +{
> > > +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> > > +	usleep_range(10000, 11000);
> > > +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > > +	usleep_range(10000, 11000);
> > > +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> > > +	usleep_range(10000, 11000);
> > > +}
> > I have seen this pattern before - and I am still confused if the HW
> > really requires the 0 => 1 => 0 sequence.
> > I would expect writing 1 - wait and then writing 0 would do it.
> 
> It's what downstream code uses and recommend all over the place, if it's an issue
> I can try to remove the first set_value
This was a fly-by comment - do what you find best.

> > > +
> > > +	ret = mipi_dsi_dcs_set_display_brightness(dsi, cpu_to_le16(brightness));
> > mipi_dsi_dcs_set_display_brightness() take u16 as brightness - so this
> > will do an implicit conversion.
> 
> I know, but the panel needs an inversed value, so perhaps I should directly
> call mipi_dsi_dcs_write_buffer() here instead of needing a double
> inversion.
If the generic one cannot be used without tricks like this, then yes, it
is better to hand-roll your own with a suitable comment.

	Sam
