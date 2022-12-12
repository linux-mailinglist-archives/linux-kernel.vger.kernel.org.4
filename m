Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570C264A60B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiLLRim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiLLRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:38:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A80F2BF3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:38:34 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id b2so29950645eja.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcdNmWKMi71LBRaud9q/o/bZWLEKyYYBvqlc/diEFNs=;
        b=CFlU48dw67kqOQTeufUnYzKtSTB0H74QSn0TYjFPvHQVl4YJBsmHkGRQDAI6zNDv3I
         RkR1Si17/0r1sQHqTjAuYm9dOh0FkzO7LQE5tXeobUm4RhK0JdIr3Yh+2BpYVZnnrU9Q
         XIbzDz137Uy8GfxHi1dsX1QHnAVLVkzc/W4qI7lxezAjS18kTGGev5sKS5vwMn/ot6nE
         8py8DVjAIigXtc8KfPwB/CP19pK9tsMiBglXwRHD3C3fxipXt4dqy19OFC7swfO2wR0Z
         Rv/zgggDDoBPnfHrKL4a+xVsVh1QqERro4wl5Bq420Nthk/gEFjFITDQPTUnXJ4qoOAZ
         PXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcdNmWKMi71LBRaud9q/o/bZWLEKyYYBvqlc/diEFNs=;
        b=nOwXfbmJcqxYeZCBomYFMIckPn0Jo5px1yfS56VunSIk6pyKoMuMSmYQFO8fG2C4Px
         0/1MZV7vpxYdqcZi/cbWovcPQH2rSmHjpwekIx3teXO7VUSbBd3qLSVwutALV6x3m6q4
         APdx5ze5e114jaq7GSBIwb7klmOiRY325bdvXHaMricwyWNsYhuFQyPtBYSsUwbCUz69
         RNIn44Dpy22D2wy8lSGVAv1JX3l4HD2kmEkUISRW9ij2vka3vz0BDlSj/NEqzdwa03XL
         u5KErTIXy7sZiLfAMsntJF1HN9RRhpcWwtRONFJhK2IyBFz2qyDpGLJswNydfM4JP31D
         uJmw==
X-Gm-Message-State: ANoB5pltrNp8vdUUfxC/JyNb/fZ+Q7HT3ujLNKIIvOk8FIt+lgYay8K5
        BWRq1yF2DT8R6aLNs0VR9O3pRQ==
X-Google-Smtp-Source: AA0mqf7eAYOzNNtDyIH9U+8RhtYLWZLE8SG1Uk7kpSZvPrlPGb103MUPjA97hA1AnXbiT+fG+kvpZw==
X-Received: by 2002:a17:906:7243:b0:78d:f455:b609 with SMTP id n3-20020a170906724300b0078df455b609mr13453972ejk.73.1670866712662;
        Mon, 12 Dec 2022 09:38:32 -0800 (PST)
Received: from prec5560.. ([2001:bf7:830:a7a8:ff97:7d8d:1f2e:ffaa])
        by smtp.gmail.com with ESMTPSA id s10-20020a05640217ca00b0045c47b2a800sm4031103edy.67.2022.12.12.09.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:38:31 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@gmail.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, hsinyi@chromium.org,
        bliang@analogixsemi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: anx7625: keep last configure timing
Date:   Mon, 12 Dec 2022 18:38:26 +0100
Message-Id: <167086668975.3073151.13627360175077600685.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209030418.713935-1-xji@analogixsemi.com>
References: <20221209030418.713935-1-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 11:04:18 +0800, Xin Ji wrote:
> Sometimes kernel may resume back quickly after suspend,
> and DRM not call .mode_set() to re-config
> display timing before calling .atomic_enable(), bridge
> driver with this patch to keep last configure timing.
> 
> 

Applied, thanks!

Repo: https://cgit.freedesktop.org/drm/drm-misc/


[1/1] drm/bridge: anx7625: keep last configure timing
      commit: 38c8389011e06f16b365799f2cd958536befc2e9



rob

