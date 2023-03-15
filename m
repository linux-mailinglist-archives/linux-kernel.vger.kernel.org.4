Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB466BADEE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjCOKlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjCOKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:41:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221595A91E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:41:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay8so6969471wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678876891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQc3aK0PHt9rmJAAmXdXsneRAxNxZg6X2oIcvnsB4ag=;
        b=CEi/i7aP31CARW73WsTU9g1Xtnix658fs2k9k87+qR+zWeZXb9vKZgrkmpeJ2QTtne
         UED/7PXdiW9I1RJnQFe0lBrhhJZcJ+uczfXgwFupZItDyiZHG/PinC+GNmuHEKFNdShu
         VGfr4y19XEdtWGs1NhdNbeqtHfVHlRWCZdZgsdcu+JKLt0+COXqHJDyOgTjDKLRPsoHI
         VeTT3T6F2UzusxWjhAU9crsJPUwrTijggv/lA5yNaZDfqev+nCAT/uRolpw4SG4SlXuY
         9P0dmdl6rrZPPjKf4KtwWahuzbejKoYeuu01g8KYkNTKmkOl0DCVpmnnKKvPEfM4P7A8
         MWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678876891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQc3aK0PHt9rmJAAmXdXsneRAxNxZg6X2oIcvnsB4ag=;
        b=DWUfDZWw6P7WIKdnDLDIFqh6dX8ae6VTglq+oLWR4TqD7pg2RlqWXjhXw0AzSP9kJU
         JYlt+1uryW3ZURfga33i5t+75qGOIMPn3GL48kdp1ngGPLMtyPkkMd1uZc8MaLb1dyPM
         W3jq7sd91NaPnsslM8omRHUZF6p9vdQZNrxVS2/Db1eG/IEk1AjuVIHa64+cdUh96qgH
         H4IQ58IQZM7ckOt2I4+974jeqVd+OrtfwKFVqnN5hF9mSIixDn3RpozKvNutGmzeuS3F
         5MH5lK1yX7lCOC7IBu90vnr5QCOccay0mqH2l7TnGY8WSPFgVL/AdIaiXdo0jNumi1pz
         PENQ==
X-Gm-Message-State: AO0yUKUt+9V0MwW3oC7VkzvSgHkU8QClurrTjyRuKXHdNOXKzS4PVihL
        BmdfEtmop66Ah/3gF2zuPwQK6g==
X-Google-Smtp-Source: AK7set8Mtk0LwWhyWB9/FpteoEVjLr4r+ag7RPu/JlMVnxgB+wBS0IqCE+l9iUpMhT1JTniLvkKJwg==
X-Received: by 2002:a7b:ca41:0:b0:3ea:f75d:4626 with SMTP id m1-20020a7bca41000000b003eaf75d4626mr17114460wml.38.1678876891602;
        Wed, 15 Mar 2023 03:41:31 -0700 (PDT)
Received: from blmsp ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c021600b003ecc64edf7esm1382047wmi.39.2023.03.15.03.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 03:41:31 -0700 (PDT)
Date:   Wed, 15 Mar 2023 11:41:30 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] can: tcan4x5x: Add support for tcan4552/4553
Message-ID: <20230315104130.qadwmybimn2rhkmx@blmsp>
References: <20230314151201.2317134-1-msp@baylibre.com>
 <20230314151201.2317134-6-msp@baylibre.com>
 <ZBCfKhPZrIMqvmbO@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBCfKhPZrIMqvmbO@corigine.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Tue, Mar 14, 2023 at 05:22:02PM +0100, Simon Horman wrote:
> On Tue, Mar 14, 2023 at 04:12:01PM +0100, Markus Schneider-Pargmann wrote:
> > tcan4552 and tcan4553 do not have wake or state pins, so they are
> > currently not compatible with the generic driver. The generic driver
> > uses tcan4x5x_disable_state() and tcan4x5x_disable_wake() if the gpios
> > are not defined. These functions use register bits that are not
> > available in tcan4552/4553.
> > 
> > This patch adds support by introducing version information to reflect if
> > the chip has wake and state pins. Also the version is now checked.
> > 
> > Signed-off-by: Markus Schneider-Pargmann
> 
> Hi Markus,
> 
> you forgot your email address in the signed-off-by line.

Thank you, I am wondering how I managed to do that :D.

> 
> > ---
> >  drivers/net/can/m_can/tcan4x5x-core.c | 113 ++++++++++++++++++++------
> >  1 file changed, 89 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> > index fb9375fa20ec..e7fa509dacc9 100644
> > --- a/drivers/net/can/m_can/tcan4x5x-core.c
> > +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> 
> ...
> 
> > @@ -254,18 +262,53 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
> >  				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
> >  }
> >  
> > -static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
> > +static int tcan4x5x_verify_version(
> > +		struct tcan4x5x_priv *priv,
> > +		const struct tcan4x5x_version_info *version_info)
> 
> nit:
> 
> static int
> tcan4x5x_verify_version(struct tcan4x5x_priv *priv,                                                     const struct tcan4x5x_version_info *version_info)
> 
> or:
> 
> static int tcan4x5x_verify_version(struct tcan4x5x_priv *priv,                                                     const struct tcan4x5x_version_info *version_info)
> 
> Your could make the line shorter by renaming the 'version_info' parameter,
> say to 'info'.

Thanks, fixed. I would like to keep version_info as it is used like that
everywhere else. I think/hope breaking the 80c here is fine.

> 
> ...
> 
> > @@ -394,21 +448,32 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
> >  	m_can_class_free_dev(priv->cdev.net);
> >  }
> >  
> > +static const struct tcan4x5x_version_info tcan4x5x_generic = {
> > +	.has_state_pin = true,
> > +	.has_wake_pin = true,
> > +};
> > +
> > +static const struct tcan4x5x_version_info tcan4x5x_tcan4552 = {
> > +	.id2_register = 0x32353534, /* ASCII = 4552 */
> > +};
> > +
> > +static const struct tcan4x5x_version_info tcan4x5x_tcan4553 = {
> > +	.id2_register = 0x33353534, /* ASCII = 4553 */
> > +};
> > +
> >  static const struct of_device_id tcan4x5x_of_match[] = {
> > -	{
> > -		.compatible = "ti,tcan4x5x",
> > -	}, {
> > -		/* sentinel */
> > -	},
> > +	{ .compatible = "ti,tcan4x5x", .data = &tcan4x5x_generic },
> > +	{ .compatible = "ti,tcan4552", .data = &tcan4x5x_tcan4552 },
> > +	{ .compatible = "ti,tcan4553", .data = &tcan4x5x_tcan4553 },
> > +	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, tcan4x5x_of_match);
> >  
> >  static const struct spi_device_id tcan4x5x_id_table[] = {
> > -	{
> > -		.name = "tcan4x5x",
> > -	}, {
> > -		/* sentinel */
> > -	},
> > +	{ .name = "tcan4x5x", .driver_data = (unsigned long) &tcan4x5x_generic, },
> > +	{ .name = "tcan4552", .driver_data = (unsigned long) &tcan4x5x_tcan4552, },
> > +	{ .name = "tcan4553", .driver_data = (unsigned long) &tcan4x5x_tcan4553, },
> 
> nit: checkpatch tells me that no space is necessary after a cast.

Fixed as well.

Thanks for reviewing.

Best,
Markus
