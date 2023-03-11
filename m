Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC73D6B5BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCKMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCKMqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:46:46 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F711C8EA;
        Sat, 11 Mar 2023 04:46:44 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h8so8301951plf.10;
        Sat, 11 Mar 2023 04:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678538804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiDlhCUlmtsAUlNB/6Hdf1VqUL1kVXdoYe/ZcJRmo8g=;
        b=L29b30GM+PAIArnzy8MiBHUAhLLMIwJ6FaLT2B40jsyiZd6YQpgMIk6RbKIRodiLS0
         DI74H/tldWjA1VL1LebhtTSL+VSPM1n20fzdtCXmZTuB/rg9PkxZuF3rjolw/Nwe1X+4
         QoXLLkmbG6gFXkr7kOQf5h4vMo4KXhmLv/0aK/2igbhHmUPshaV0v7dm7ntmaHV6RwMf
         fyUx0TcFBKUWZH7Pw8KzmZX27qdaFgxswsNGfWuJv6QOb9tnXtLpKIxgB2nCs+JLbCF3
         mIJFXAOrhXzg4FVaGysAsyRmmFxPv7f1E6RzWh4o5Dol/cIebPPa0bSyunUGu9j5+o34
         gVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678538804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiDlhCUlmtsAUlNB/6Hdf1VqUL1kVXdoYe/ZcJRmo8g=;
        b=LX5UgIq/o1mnbmmy/VOPJ/VM9F7apR6Mz6KugrM+9JHe5Con8mpaBNsAmQzejrImMu
         A/ZJYwR1zewNpBTMf9PGSaf23RCU5X/89WQNOGuKy1PrUK6f5Vt1bupDj6CRUZ9s2tx8
         cXsyJakVdXoBOmpj833dCZYJ5rPsHAfbygXJAumaCPRtpY/WQfjm2r6nsY43erF97/QN
         4HXivL3gVmSCQWEX0ZVfMBgLtOilZYmXnVaJ/Yb/nL6dRuITi0E1AFOxS4+aktlVlIdS
         Yb0hNfgK9VAyPw3JHGB17SkJ1f7ph+M231oIyam05GRoB7ytrXTefWVXXU6pynjeXT6d
         CMnQ==
X-Gm-Message-State: AO0yUKU12ABqSYBNqWrCN8h1tGr8fj1bOb8ZXpsKL6uR+3HR05QkdjFC
        7Uc3w2TBM1iwE7NhnTSlQuY=
X-Google-Smtp-Source: AK7set+ji+ZQM1Aev0DE5omV9PnlNe+xd7MwKZKFp/q3X5YjO6ktRlb56PKrc6iC5jTqwI4bioWJTw==
X-Received: by 2002:a17:903:2290:b0:19e:25b4:7740 with SMTP id b16-20020a170903229000b0019e25b47740mr35095390plh.28.1678538804128;
        Sat, 11 Mar 2023 04:46:44 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id kr13-20020a170903080d00b0019e9eb439d6sm1510200plb.164.2023.03.11.04.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 04:46:43 -0800 (PST)
Date:   Sat, 11 Mar 2023 20:46:34 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] drm/panel: Add driver for Novatek NT36523
Message-ID: <ZAx4KqXw+an555d4@Gentoo>
References: <20230311123231.20771-1-lujianhua000@gmail.com>
 <20230311123231.20771-2-lujianhua000@gmail.com>
 <904bc493-7160-32fd-9709-1dcb978ddbab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <904bc493-7160-32fd-9709-1dcb978ddbab@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 01:38:52PM +0100, Konrad Dybcio wrote:
> 
> 
> On 11.03.2023 13:32, Jianhua Lu wrote:
> > Add a driver for panels using the Novatek NT36523 display driver IC.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> [...]
> 
> > +
> > +static int nt36523_get_modes(struct drm_panel *panel,
> > +			       struct drm_connector *connector)
> > +{
> > +	struct panel_info *pinfo = to_panel_info(panel);
> > +	int i;
> > +
> > +	for (i = 0; i < pinfo->desc->num_modes; i++) {
> > +		const struct drm_display_mode *m = &pinfo->desc->modes[i];
> > +		struct drm_display_mode *mode;
> > +
> > +		mode = drm_mode_duplicate(connector->dev, m);
> > +		if (!mode) {
> > +			dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> > +				m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
> > +			return -ENOMEM;
> > +		}
> > +
> > +		mode->type = DRM_MODE_TYPE_DRIVER;
> > +		if (pinfo->desc->num_modes == 1)
> > +			mode->type |= DRM_MODE_TYPE_PREFERRED;
> That's not quite correct, as that means "if you have more than one
> defined panel mode (say 60Hz and 120 Hz), there will be no preferred one".
This piece of code I see in the other panels, so I'm not sure if it is
correct. Should
if (pinfo->desc->num_modes > 1)
			mode->type |= DRM_MODE_TYPE_PREFERRED;
is correct?
> 
> Konrad
> > 
