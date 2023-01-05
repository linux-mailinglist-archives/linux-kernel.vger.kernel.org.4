Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C465EEE8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjAEOiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAEOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:38:43 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F35933D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:38:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r2so1508932wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 06:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVtkjpd1m5CHpqjkgjmo86bTVFs9jvutUQ4eD41Hm9g=;
        b=NzuwNKy8Ow+MANdie+j+x4B9s960DR90E2MnehzGKe3PurQC2DCydzdAIfUDqpGSs8
         ghkY3BWq8N1OxbwBNA0l5jg0cEfOf2IlVy/KNJ8Ymdmcjm4uM5AvP8Gv3Ad+TXbu+f9n
         xBDs16qMuOMcjOle134JGGRL6rO19cf8k4xXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVtkjpd1m5CHpqjkgjmo86bTVFs9jvutUQ4eD41Hm9g=;
        b=QdEMi/16FMSnkS/wY40j7VW9faGuxtqGKPkz1Yt2smzttGOO/93LeIkSPqdBBs8/lV
         2BgKvgtsaO0hr4fBXsu9EHCD91SMHtjkftDEH8I89wbI/7yDSpSsYPr6HoqxwezR1GR5
         2ClRy/x6GK/CYx9GNw/dLV6wC+qKP9B3i1xKXa6LNztqmn1EbKT5D0bJNkPIbkRAaSVp
         ztmhH8iG6TzKwmhR05OEpagqwUEPiX7CUFUHDG8Eev9vvGm+JS9ebQl4MDc+o0ANsLIc
         S07cvY6dzuVdNLZS/KgPW2HshWofMqLv/SvKzFlJqhg19Aj3Ae1SyqOtZHD3LWC62Hbn
         Yv/Q==
X-Gm-Message-State: AFqh2kqLdQW7/w6MHMyOBC0AlAUWOMAd9yKvQe/cLEvgv8tGhdV6VlJ9
        hP5wtZMZAabppe5SGUl8A8pTeQ==
X-Google-Smtp-Source: AMrXdXuSsMZhhd80+6OXhv75jCIyGLpgvyQQ+TVLgcPbSzqYqBhxo3s87MG+XFl/BzyUXYOexu5Z8Q==
X-Received: by 2002:a05:6000:5c9:b0:2b0:bc05:b463 with SMTP id bh9-20020a05600005c900b002b0bc05b463mr1943816wrb.7.1672929520678;
        Thu, 05 Jan 2023 06:38:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm2845649wmo.24.2023.01.05.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 06:38:39 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:38:37 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Patrick Thompson <ptf@google.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Add orientation quirk for Lenovo ideapad D330-10IGL
Message-ID: <Y7bg7WQs0OtMLmAW@phenom.ffwll.local>
Mail-Followup-To: Patrick Thompson <ptf@google.com>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221220205826.178008-1-ptf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220205826.178008-1-ptf@google.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:58:26PM -0500, Patrick Thompson wrote:
> Panel is 800x1280 but mounted on a detachable form factor sideways.
> 
> Signed-off-by: Patrick Thompson <ptf@google.com>

Applied to drm-misc-fixes, thanks for your patch.
-Daniel

> ---
> 
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 52d8800a8ab86..3659f0465a724 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad D330-10IGM"),
>  		},
>  		.driver_data = (void *)&lcd1200x1920_rightside_up,
> +	}, {	/* Lenovo Ideapad D330-10IGL (HD) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad D330-10IGL"),
> +		},
> +		.driver_data = (void *)&lcd800x1280_rightside_up,
>  	}, {	/* Lenovo Yoga Book X90F / X91F / X91L */
>  		.matches = {
>  		  /* Non exact match to match all versions */
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
