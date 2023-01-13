Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1BD66A52C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjAMVes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAMVep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:34:45 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5027CDC0;
        Fri, 13 Jan 2023 13:34:43 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 18so32932374edw.7;
        Fri, 13 Jan 2023 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qCdwGMTA5hWt76IHvq9wLJvkL5pfwxgtHI4xlA6p9uY=;
        b=M/CqyQc4pXY7XmIPKjddQNB23Ymnykff6YJlPCRgig2FzZM2dUhOT1CWaHLuYaUTwx
         NKAZqAA0PEKHwbQ8FhG3TJuf8MbBfZ7jnc9aJsPVkKpB2D1wXWV4QjWMQIgrr4M7w5PP
         r03W4E1NUUYlH6zPWCW064jmZ0834b8SU/2ayefFvHRDtxFNDtMciJhzOpCK2SVl25/p
         a55mdYypiJROG9aVTIhMI4ZdsHVa2Z9IfljMZOc0rAbdzvJQcHOKT04Vm94NbxjzrfUH
         4KulVZQ+3NvzyYqKLCeyOk/LfbgZKUGFbXVzkhMg2LszuRs28psYQB1RiHK4oc/Vq1z3
         rCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCdwGMTA5hWt76IHvq9wLJvkL5pfwxgtHI4xlA6p9uY=;
        b=kgVlZcUIsoDLSNNrAScdDRD/QEmz5xDRW4igfCUNIR8YkDOXuym5ymGn5qXKC00SiJ
         WM6k+gBrVIWGxGD1pZ8zIvLfdiB8UjE3Ezjb5StOsxN3p0Ky+8sWV0LSd+++yRAuypSc
         lMrdHzhrCt8hx7rs9r7iuYTHpaEjaNoxxyadZ/2d0L4mMBC82tTYTsQ2TNW9G1+FFVUO
         nFvde28N7i/Z5IjK5izpogo5YjgWSDoecQZKL/7vH5xtBhm8BV6Up5BG+bd+p5yOOuRM
         1+F0UzOevHBCzzIIr3jYFmZqQF85qZVywMYMeiTBmriAlS16gjQgnR0YwGObDxqdA9Ot
         sOiQ==
X-Gm-Message-State: AFqh2krxckhQfbqsshrxmtuELvSWzFW0GLjMaW8xDm2IaHRU/LsDjaeb
        bCxFvuFvA5agVCC2yi1ufDGXk79BCYfvsJmbFas=
X-Google-Smtp-Source: AMrXdXvlZd2FOTLqxdMOBBVqfPcrN6niWajfnCu7ycA77luyrMnV5VLOW4sU0WRUEdX1UkvnN5FEhTGNMEaQ3Y7gC80=
X-Received: by 2002:aa7:c985:0:b0:498:dec8:f426 with SMTP id
 c5-20020aa7c985000000b00498dec8f426mr1911545edt.392.1673645681926; Fri, 13
 Jan 2023 13:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20230110231447.1939101-1-robdclark@gmail.com>
In-Reply-To: <20230110231447.1939101-1-robdclark@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 13 Jan 2023 13:34:30 -0800
Message-ID: <CAPaKu7Sqr7dpub3d-XhO4NkfZ3U6h332s==rF9AzbCmtMGq0NQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/msm/gpu: Devfreq fixes+tuning
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series is

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>


On Tue, Jan 10, 2023 at 3:14 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Rob Clark (3):
>   drm/msm/gpu: Add devfreq tuning debugfs
>   drm/msm/gpu: Bypass PM QoS constraint for idle clamp
>   drm/msm/gpu: Add default devfreq thresholds
>
>  drivers/gpu/drm/msm/Kconfig           |   1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c |   2 +-
>  drivers/gpu/drm/msm/msm_debugfs.c     |  12 +++
>  drivers/gpu/drm/msm/msm_drv.h         |   9 ++
>  drivers/gpu/drm/msm/msm_gpu.h         |  15 ++-
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 148 ++++++++++++--------------
>  6 files changed, 100 insertions(+), 87 deletions(-)
>
> --
> 2.38.1
>
