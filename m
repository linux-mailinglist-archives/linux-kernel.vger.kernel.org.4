Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C853A70CA99
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjEVUPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjEVUPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:15:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048DDB9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:15:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae40dcdc18so46131375ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786517; x=1687378517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kJUhMwhu8pmB0S/reI91bCPURToQamQOJVM6YT2PQk=;
        b=K0i7JwPBVmGMOLMWLK/3kPh9tQi1cz1mf6ZiGbF/qmCvezU63ySpE7rp+c4R65Zjs9
         zimyPm3Odf3qhFjVr9OwQ7BCcY6Pec/gRL3wCPUSN4Gd+jk/oC+PnZ/s3udoM5zUnE5p
         20QdzjUctLVil0kxmBOGLAgfuZC2jtKYOjFz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786517; x=1687378517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kJUhMwhu8pmB0S/reI91bCPURToQamQOJVM6YT2PQk=;
        b=MBByBzjgeaUMq8vW6uBKJZNYJ9N7CvXwRm6xLBfu9+CA8WCgAogMla5JSYf5OmioTP
         yWe3/jfI57kYjO+TfLLC6a0+zy3R6PK1WNjagizC/6FFBASehI8o/0YcJo1vwrOusDmc
         CcFlMB5pGm4+q5yugOxmQBnfR1z0qrxis+4d3wK3ZNeYAlgAyHLp9VgSLKFR4FpPak9Q
         ow1fXVtI+UP8isnvCk+ipjetGrLQIRHFeftt1wdHMEMAGHtihnFAxMLrlBwn9r6HdhGX
         NC4R2jWCGZhAVRx6rVsxq13FvbCKi1gt6/IlNHYpC4Q8IdY2UEjF2TqrIM+TjHhQJFNE
         YIhg==
X-Gm-Message-State: AC+VfDzfP0Gj0VoTZSCftNKYKtjUyJTAQGR4NaiEa7Wifa2c0t1YHmXP
        YOnnILVDiouaLqQPxgqyr94K7w==
X-Google-Smtp-Source: ACHHUZ5QSapbcHFKbYzfAO0Hf2n6h4/H3FAnhE+dze/4InLVr1Uc7D3qUfrMrjPffZ+EQHaD+UWsGQ==
X-Received: by 2002:a17:902:934a:b0:1af:c1af:8d83 with SMTP id g10-20020a170902934a00b001afc1af8d83mr1319174plp.45.1684786517491;
        Mon, 22 May 2023 13:15:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001ab2b415bdbsm5247305plg.45.2023.05.22.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:15:16 -0700 (PDT)
Date:   Mon, 22 May 2023 13:15:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Sam Ravnborg <sam@ravnborg.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
        Lyude Paul <lyude@redhat.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Imre Deak <imre.deak@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/display/dp_mst: Replace all non-returning strlcpy
 with strscpy
Message-ID: <202305221315.9CD6F67@keescook>
References: <20230522155124.2336545-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155124.2336545-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:51:24PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
