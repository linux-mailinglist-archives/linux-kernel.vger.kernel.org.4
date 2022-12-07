Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852A7645D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiLGPDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiLGPCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:02:42 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07D4326F9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:02:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk9so14670031ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 07:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rkW+R4a4Tse6+MACAktrvnQJHvMvBdaXyWKhbIEKa4Y=;
        b=fkHTwS2xda8lXWPwC/vh6Sh3dsVuHW6pI5EwaLzpeW2PTehU5ETuWBv7ToCAGRlohi
         8PA0gxeF/NHGRup1QG2jbLwskMNCfUY7Y/w2tc3n2CcTY0CgV6VOsnSRlehtDRv0l4ho
         6OmIIbqIKTUeZu0L5HPuVvlFENu1fsb4bC/UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkW+R4a4Tse6+MACAktrvnQJHvMvBdaXyWKhbIEKa4Y=;
        b=lEyWEfg/XfVrWSUwgEDiFMUZ8D3th8BD6wnFDY8elRQ8LzPNQijbt2j2h8quBgEfII
         /tMjat+Xrgr2NBkcTDJk72Gaf0eIoD0urJS2T6pqFgSjp7bFufNkIiie5JPlqUDoAIM2
         tPai79//FfBbLsPV2wTdLM6fxGtpDPXfnJaEAyyQsQ1nHOK2K2+2e9FIse1NEyoWt1Qt
         sfLcvIGKjR3O4I/bJkcUDrgTMvd80mStJhqwpkNFQY+TQFfivK1zFpXxQhvB9XdXae82
         CyGfK0VGDAxk4NEuCIcAkssjMo0HBsty1JqNrIcTbkkQX5jJpQQyTvBR/QYQy16ysbqH
         0xoA==
X-Gm-Message-State: ANoB5pmShVZZwTOxyTIZrHK+zA9UcJ/krLOw4cQRsQnwEqeIHFVaaanl
        pKjTShrDwDMcdJYUMmaf3NGL/ZFBHg4YMascQLs=
X-Google-Smtp-Source: AA0mqf4C1f026UiIRWPFzH9bGMsJgL5rwZ6szZqBwPW27rLxa9ImplNBTSOiwt0ZUueVjD3SnpNtUw==
X-Received: by 2002:a17:906:138d:b0:7c0:faff:ab43 with SMTP id f13-20020a170906138d00b007c0faffab43mr342574ejc.26.1670425334999;
        Wed, 07 Dec 2022 07:02:14 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm8600530ejc.210.2022.12.07.07.02.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:02:13 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1267791wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 07:02:12 -0800 (PST)
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id
 ay18-20020a05600c1e1200b003cf9ad3a20emr57361645wmb.151.1670425332189; Wed, 07
 Dec 2022 07:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20221207065922.2086368-1-linmq006@gmail.com>
In-Reply-To: <20221207065922.2086368-1-linmq006@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Dec 2022 07:01:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VDQZu_-kDOQVLoz1SNPda_78aQ+NMa163mXDmnmXrRSg@mail.gmail.com>
Message-ID: <CAD=FV=VDQZu_-kDOQVLoz1SNPda_78aQ+NMa163mXDmnmXrRSg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: Fix memory leak in msm_mdss_parse_data_bus_icc_path
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 6, 2022 at 10:59 PM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_icc_get() alloc resources for path1, we should release it when not
> need anymore. Early return when IS_ERR_OR_NULL(path0) may leak path1.
> Defer getting path1 to fix this.
>
> Fixes: b9364eed9232 ("drm/msm/dpu: Move min BW request and full BW disable back to mdss")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - move getting path1 after error check for path0.
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
