Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610126B3F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCJMUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCJMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:20:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0384110522;
        Fri, 10 Mar 2023 04:20:15 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i10so5317596plr.9;
        Fri, 10 Mar 2023 04:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678450815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asTNFVHYBUFSk4GRlqWZV4x4IVPoPxPEyap0sAN5uo0=;
        b=TTjFr9R1KsSh9rAJfVF8DAclSK8JnmgWe6xfLOscVmUDIgjal25Y4E8PqQ1psDZHzN
         Q/D4dqpggx1RSnZPn+1ZV59/MKNC0NH20Qcd3tZ8NrFy2QbQQh+3eYOdezwKgmnS4VaW
         mIp3ZY+icrOd3gYT26edt20K31VKeN6jOH2tDnO8hC19e6RgZYburtH6OewoOK/nONTO
         aFEhfgX1XU29/PAWAFHNWor54qOtesM3CQVKSez1vY2YUr43ALL4DKHMyRkC3x/dVjhe
         LoZwK3Q9wTZCDZCJqeG7nGThLPXXiNk+DtEahK3QdUPbHqBiiNUmghN0qHbHB/usTCn1
         OHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asTNFVHYBUFSk4GRlqWZV4x4IVPoPxPEyap0sAN5uo0=;
        b=ly8dhMcYmlq3laLFJEnvpEa/wopQJs9HhqKwCSTr047VNpIbeQz2aRWC1HjzOKMXP9
         XNw22Kg0jhzAp/zsN2glLdHH2u9JQ009hDworRFLFa0DWiIVPDz7bnZDD4v0jVw0e8oj
         UDzMtuQGOdVaV1BGVTLGsJ/6y+W8DuQ6N4gtymYu3xOx/UF/kDzH2uGcZr6bjkPCHCMT
         +66S11Li7IoPc+aG6Y3WJN7VGXEEUEhPk/PljTkS9pVi5i9fCPmd4T8cnwnQoVvRt46z
         3SlsVLf5VZl1mECS48WECoh9gjOZduu1KUbotfSnoUNi9qBsHv87s7q79QPzEl05W58E
         aiuA==
X-Gm-Message-State: AO0yUKWH2svfRQC6vOKt2b/EIiCvlkS+1W49y8Hxtz4L4ZW5hhp0tl5N
        V5kzHjeVRq40ZA8qvfIKlczjLOvhu9U=
X-Google-Smtp-Source: AK7set/6w9Q7LNt7cBPWqygAgpU6M+EF0xKmpp5LjpvMUnv8kXk2kOyu9IBEi3J5RXqYJVNoQ+mUSA==
X-Received: by 2002:a17:903:2603:b0:19d:16ed:3e34 with SMTP id jd3-20020a170903260300b0019d16ed3e34mr22466860plb.26.1678450815375;
        Fri, 10 Mar 2023 04:20:15 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709026f0200b0019aa6bf4450sm1307414plk.188.2023.03.10.04.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:20:14 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:20:07 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] drm/mipi-dsi: Add a mipi_dual_dsi_dcs_write_seq() macro
Message-ID: <ZAsgd4zsgbvWT0U0@Gentoo>
References: <20230310110542.6649-1-lujianhua000@gmail.com>
 <87mt4k95zp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt4k95zp.fsf@intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 01:54:18PM +0200, Jani Nikula wrote:
> On Fri, 10 Mar 2023, Jianhua Lu <lujianhua000@gmail.com> wrote:
> > The panels with two dsi connected (sync dual dsi mode) need to transmit
> > dcs command to the two dsi host simultaneously, let's add
> > mipi_dual_dsi_dcs_write_seq() macro for this kind of panels.
> 
> If we were to add a helper for this case, it should be a proper function
> and not a macro like this.
> 
> We'd also need to see a user for this upstream.
> 
> >
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> >  include/drm/drm_mipi_dsi.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> > index c9df0407980c..d0f0f75d4d83 100644
> > --- a/include/drm/drm_mipi_dsi.h
> > +++ b/include/drm/drm_mipi_dsi.h
> > @@ -336,6 +336,21 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
> >  		}                                                          \
> >  	} while (0)
> >  
> > +/**
> > + * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
> > + * @dsi: array of 2 DSI peripheral devices
> 
> This makes the assumption the devices are stored in an array. What if
> drivers want to store them differently, for whatever reason? Maybe they
> have an array of some container structs that have the devices? Maybe
> they just have two struct mipi_dsi_device pointers?
This array just store two struct mipi_dsi_device pointers
> 
> > + * @cmd: Command
> > + * @seq: buffer containing data to be transmitted
> > + */
> > +#define mipi_dual_dsi_dcs_write_seq(dsi, cmd, seq...)                   \
> > +	do {                                                             \
> > +		if (ARRAY_SIZE(dsi) > 2)                                 \
> > +			return -EINVAL;                                  \
> > +		int i;                                                   \
> 
> I believe this should lead to a warning for mixing code and
> declarations.
> 
> > +		for (i = 0; i < ARRAY_SIZE(dsi); i++)                    \
> > +			mipi_dsi_dcs_write_seq(dsi[i], cmd, seq);        \
> 
> This ignores errors.
mipi_dsi_dcs_write_seq is also a macro, contains error checks in the body block.
> 
> > +	} while (0)
> > +
> 
> Without an example user, I'm not yet convinced about the usefulness of
> the helper, but I'd imagine something like this would be a more generic
> approach, not enforcing the array, and handling errors properly:
> 
> ssize_t mipi_dsi_dual_dcs_write(struct mipi_dsi_device *dsi0,
>                                 struct mipi_dsi_device *dsi1,
>                                 u8 cmd, const void *data, size_t len)
> {
> 	ssize_t err = 0;
> 
> 	if (dsi0)
>         	err = mipi_dsi_dcs_write(dsi0, cmd, data, len);
> 
> 	if (dsi1 && !err)
>         	err = mipi_dsi_dcs_write(dsi1, cmd, data, len);
> 
> 	return err;
> }
Thanks for your explanation and this looks more reasonable.
> 
> But even that begs the question where does it end? There are a lot of
> mipi_dsi_dcs_*() functions as well as mipi_dsi_generic_write(). Dual
> wrappers for all of them? :o
It's definitly useless to wrap all of them. Please ignore this patch.
> 
> 
> BR,
> Jani.
> 
> 
> >  /**
> >   * struct mipi_dsi_driver - DSI driver
> >   * @driver: device driver model driver
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
