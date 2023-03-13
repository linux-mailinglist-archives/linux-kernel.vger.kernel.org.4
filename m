Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3F6B72BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjCMJhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCMJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:36:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0BD5A6F7;
        Mon, 13 Mar 2023 02:34:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id o67so544200pfg.10;
        Mon, 13 Mar 2023 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678700073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OI7Db7BHeqVEz8L9hVGNwbJcVk46KjMrg/IvivHmeU0=;
        b=dzdnfahlvokvl0+fMpuS0JMeiuX8ty68pK/cITnN9rlO/l+0tuE3mlmAnwfWV/osI7
         3vSLfYBH9PGTECDWFyJLy81VDQcFqr1g6CbC+v68gwSHpwvCncMMBmCsjO0wheaBsNkr
         6rDXggn69h3mOlqzYGfxX0rk0o17xEw9ATjr8R76Ci0Sqs/b7aHn/9Nr/Fg/YqRpMAM6
         x9G8L0R5GjWv4LAuF32BeFZd/FEyNXdTXri9T0uAgc6NzdLdWlQOl15yieRK7POcmql3
         VJ/xQDYWet6E2GFgBHyoW4tH0zna+QyrqmvwuM/DwD4Cszm2SzvfQewP4QPaHnrcO3+T
         LwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI7Db7BHeqVEz8L9hVGNwbJcVk46KjMrg/IvivHmeU0=;
        b=ujCMO0B3ORxGUgaGYQXWxu3GnsaCX2MKKE44nMDyUfsNuweXvTuHFTykmhcO5OVfUA
         xdrnSM5mkCP5BCAEwdr2Rxi7MXrIVKCeIr6v1uV8Mo9238Q6EKDDWTF/iRY38Zy2jVL6
         bFkEXTm6QnD9Cd7TgpVBm4NlEoDjZBjZeFzxCSz8mpF1L6Gni5zYI95vNZB/dwOHS/I8
         PHh3uMA4MaT7QWhYQNBJRrQbESHBgEZoqYFDkgjCdOCBY9myackOJF+TgKfPNO5r0yDB
         u5OPHa3Kv5PkCHSok7/l+YfrxMARPAZaOiN1SuwioYF1UkkZsi2dOy7BPOUs8WSNpEV+
         wraQ==
X-Gm-Message-State: AO0yUKVwtnyl00bRaA4yLPYU974xviq+/I/qBIHIARhRkjtx6Slnr9zC
        F94QBCKCYkRJ4DxD6qZaL5U=
X-Google-Smtp-Source: AK7set+YvKu0xE5cKX91dxboKMZosjDQqSF8ZN05inC82xLe1eG6h0f6ThJti9wYHTG+A0zZT5FLTA==
X-Received: by 2002:a62:1a4c:0:b0:623:79d9:a8e6 with SMTP id a73-20020a621a4c000000b0062379d9a8e6mr3154233pfa.19.1678700072883;
        Mon, 13 Mar 2023 02:34:32 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id j11-20020aa7800b000000b005b0853a1a3esm4006367pfi.159.2023.03.13.02.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:34:32 -0700 (PDT)
Date:   Mon, 13 Mar 2023 17:34:23 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] drm/panel: Add driver for Novatek NT36523
Message-ID: <ZA7uH173ZmbGWzv8@Gentoo>
References: <20230311123231.20771-1-lujianhua000@gmail.com>
 <20230311123231.20771-2-lujianhua000@gmail.com>
 <904bc493-7160-32fd-9709-1dcb978ddbab@linaro.org>
 <ZAx4KqXw+an555d4@Gentoo>
 <6c02557d-372d-05b1-2998-7c2cde99fac7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c02557d-372d-05b1-2998-7c2cde99fac7@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 09:06:50AM +0100, Neil Armstrong wrote:
> On 11/03/2023 13:46, Jianhua Lu wrote:
> > On Sat, Mar 11, 2023 at 01:38:52PM +0100, Konrad Dybcio wrote:
> >>
> >>
> >> On 11.03.2023 13:32, Jianhua Lu wrote:
> >>> Add a driver for panels using the Novatek NT36523 display driver IC.
> >>>
> >>> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> >>> ---
> >> [...]
> >>
> >>> +
> >>> +static int nt36523_get_modes(struct drm_panel *panel,
> >>> +			       struct drm_connector *connector)
> >>> +{
> >>> +	struct panel_info *pinfo = to_panel_info(panel);
> >>> +	int i;
> >>> +
> >>> +	for (i = 0; i < pinfo->desc->num_modes; i++) {
> >>> +		const struct drm_display_mode *m = &pinfo->desc->modes[i];
> >>> +		struct drm_display_mode *mode;
> >>> +
> >>> +		mode = drm_mode_duplicate(connector->dev, m);
> >>> +		if (!mode) {
> >>> +			dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> >>> +				m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
> >>> +			return -ENOMEM;
> >>> +		}
> >>> +
> >>> +		mode->type = DRM_MODE_TYPE_DRIVER;
> >>> +		if (pinfo->desc->num_modes == 1)
> >>> +			mode->type |= DRM_MODE_TYPE_PREFERRED;
> >> That's not quite correct, as that means "if you have more than one
> >> defined panel mode (say 60Hz and 120 Hz), there will be no preferred one".
> > This piece of code I see in the other panels, so I'm not sure if it is
> > correct. Should
> > if (pinfo->desc->num_modes > 1)
> > 			mode->type |= DRM_MODE_TYPE_PREFERRED;
> > is correct?
> 
> I think only a single mode with DRM_MODE_TYPE_PREFERRED is preferred,
> so:
> if (i == 0)
> 	mode->type |= DRM_MODE_TYPE_PREFERRED;		
> 
> would be the right thing to do.
Thanks for your explanation.
> 
> 
> Neil
> >>
> >> Konrad
> >>>
> 
