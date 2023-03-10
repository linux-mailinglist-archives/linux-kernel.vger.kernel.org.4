Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8706B4FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCJSHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCJSHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:07:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88221314C7;
        Fri, 10 Mar 2023 10:07:21 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso10713900pjb.2;
        Fri, 10 Mar 2023 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678471641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5jGJYm0wL4TU+GInA55FTV+ma7xO70le58dL4DX4ys=;
        b=MZvRpi166r8cPLxmI4Wj2nTjboTVgIlUSNoTZ0GEKuD172rYOKmAnVQb5/nQYacoWT
         TovuiPpr7y2PnF1VP2kZ97vtg8bSK8YZ5yMoTO3ZTmP+LC5nxfLhYxpr+8YWDljyQFfL
         RjZ890CYGCRocpbCh9ZVKMs1L/UYwiX/CWVse4HJiH4QPkbXtNCKqXJrGbZfojm/F7ca
         A6N/nkZOj0E4UOwL3L7xhVmh6f0Yjk6iHCr2diO27gnOWhQZvbAZ+a4x//nxwoljrlGP
         qBCms2xT0VDOFEs1YxgjFlhxSirsnvnkpg87zsMHfutd11qmxoYxyOf4ff8s1ugbZnm7
         ycVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678471641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5jGJYm0wL4TU+GInA55FTV+ma7xO70le58dL4DX4ys=;
        b=Fr44AdkZ1RJsXDIA0x4BnNW9HhtqmvKeIuzFo7Ah0u96wqR80Oy4uqBFjcDIm9W3YW
         mVWRFQ4zkHgximwuBlebKMKFfkeXjESJroaTxvwuv5bBB71ZLvn2vMZwxGe7kmesypW+
         MrMj8PQFv/sR83zb6D7Q9PFcp5vzmqSAeSR6TWgOcEpO1NVfExtvQmWhuXb+MIzRgzLk
         IfZLnboJaXswJmyWQieaoVr22Iq/i+35wf7aV5dDatqPLe0vqPAW8PVcof0mWAQvNGky
         oPEv6CeNCt5m9SRPPonMqG8ZbuxmGZFk2XITzZLPP69YQPbCvrjA3Mp5VFRf1gsBeW5U
         j+HA==
X-Gm-Message-State: AO0yUKUzGoUXdFYztDno0cp6g4hNEfO0auQrGVZ15kWidsuz9KGpLRu9
        nEkJiv+DMo6GACZBHq7CGjQzRlmEqt4=
X-Google-Smtp-Source: AK7set/6HkbBFXtz3z8XyA+x6G75td2z6mPUHNDgY11R3c9ADc80r5wuC4UgzbgQZmk2Zktp4juJyw==
X-Received: by 2002:a17:90a:18e:b0:232:fa13:4453 with SMTP id 14-20020a17090a018e00b00232fa134453mr26741085pjc.13.1678471641394;
        Fri, 10 Mar 2023 10:07:21 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id jx18-20020a17090b46d200b00233e860f69esm201403pjb.56.2023.03.10.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 10:07:20 -0800 (PST)
Date:   Sat, 11 Mar 2023 02:07:13 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] drm/panel: Add driver for Novatek NT36523
Message-ID: <ZAtx0c4U70DtMuyV@Gentoo>
References: <20230310132144.2241-1-lujianhua000@gmail.com>
 <20230310132144.2241-2-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310132144.2241-2-lujianhua000@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:21:44PM +0800, Jianhua Lu wrote:
> Add a driver for panels using the Novatek NT36523 display driver IC.
...
> +
> +static int nt36523_get_modes(struct drm_panel *panel,
> +			       struct drm_connector *connector)
> +{
> +	struct panel_info *pinfo = to_panel_info(panel);
> +	int i;
> +
> +	for (i =0; i < pinfo->desc->num_modes; i++) {
s/i =0/i = 0/, I forget to run checkpatch, sorry. I will fix it in v5 
> +		const struct drm_display_mode *m = &pinfo->desc->modes[i];
> +		struct drm_display_mode *mode;
> +		mode = drm_mode_duplicate(connector->dev, m);
> +		if (!mode) {
> +			dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> +				m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
> +			return -ENOMEM;
> +		}
> +		mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +		drm_mode_set_name(mode);
> +		drm_mode_probed_add(connector, mode);
> +	}
> +
> +	connector->display_info.width_mm = pinfo->desc->width_mm;
> +	connector->display_info.height_mm = pinfo->desc->height_mm;
> +	connector->display_info.bpc = pinfo->desc->bpc;
> +
> +	return pinfo->desc->num_modes;
> +}
> 
> 
