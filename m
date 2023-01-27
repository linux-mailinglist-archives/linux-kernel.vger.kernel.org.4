Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C629267EA18
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjA0P6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjA0P6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:58:19 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF9B7643F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:58:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p26so3669070ejx.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mlg45T4/VC+7LmAsgOWK4bw3SsjPwjm5InA1atd5cbM=;
        b=Lb5onOMPT75+MY3z7ZObqs5E6eGtXjhmibCMQ+TiXHxDJcjGv3MQCb44+itMUg6MrT
         YkmJGmVNLkEfIjjTp+Z7Ew5Xbg0s9VQTl3COKoI/4tuXyHHg+xK9/Cq/FI6iV6nvM7PV
         yPsNLyT0miE6du9DKnP5DnHU+uEJOfYt76j9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlg45T4/VC+7LmAsgOWK4bw3SsjPwjm5InA1atd5cbM=;
        b=DhBR5qLYeZfeR3k3uomQMkcyw1TUAu7ogxadC9BC69xLpNSTw9XOz2p3U58xG5CYSG
         qEyEjwcKpW2B9/BH4wDfLEwCsEZ47LsEJvEpSy86pOXrJtNRVcPxDgdNUt76Vehwdh3k
         KpnpsH7GslonkS8p/OVr7Gru8eu/1ch0phme+Wsp5doZnKKqQIEfTwoe0T2M+PjOzLjE
         bJg82wJ0xag4YPmNB4/VaU6ha6VggBMrjZ6/dpmvHra7F7zxjKYu9cwEX8RUQSZCUN+2
         4Kl4HC8WNZQQAN5h8zWIrPXqbYHdGDpX7IWHTdZ7rq7e1Zt5F4DYZkdnJVqncm9caurm
         kpzw==
X-Gm-Message-State: AFqh2kpqxuCvF4/ExIV5lmBrCzZRqyl/Zi+RUrpJJHgHtIidGfBzHKb8
        m0G7LIZijmaG3qYi2pf/bG+CxTA/2a7DbiZwavQ=
X-Google-Smtp-Source: AMrXdXt9+7rEBjaft3TYYfboyapwXwtO82k8RVPysFSnYA/aRvvE3uauu/Fo+nP1x5NbawW6g7nlyg==
X-Received: by 2002:a17:906:4ad5:b0:7ad:e67d:f15c with SMTP id u21-20020a1709064ad500b007ade67df15cmr52639571ejt.48.1674835097164;
        Fri, 27 Jan 2023 07:58:17 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id o25-20020a170906861900b008675df83251sm2425636ejx.34.2023.01.27.07.58.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 07:58:16 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id bk16so5352683wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:58:15 -0800 (PST)
X-Received: by 2002:adf:f10b:0:b0:2bd:ef96:3889 with SMTP id
 r11-20020adff10b000000b002bdef963889mr1582683wro.138.1674835095329; Fri, 27
 Jan 2023 07:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20230119224052.2879106-1-robdclark@gmail.com>
In-Reply-To: <20230119224052.2879106-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 27 Jan 2023 07:58:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XqWzrgss7HAsYJASuJjNr3gBgtM7b3rNU=NtGuVgJ+ew@mail.gmail.com>
Message-ID: <CAD=FV=XqWzrgss7HAsYJASuJjNr3gBgtM7b3rNU=NtGuVgJ+ew@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Remove dependency on GEM DMA helper
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:DRM DRIVERS FOR MEDIATEK" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 19, 2023 at 2:40 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> It appears that the dependency on the DMA helpers was only for
> drm_gem_dma_vm_ops.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/Kconfig       | 1 -
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 7 ++++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Drive-by comment: can you post a follow-up patch that also removes the
"#include <drm/drm_gem_dma_helper.h>" from "mtk_drm_gem.c", assuming
that still compiles? If it doesn't compile, that might be a bad sign
that we missed something. ;-)

-Doug
