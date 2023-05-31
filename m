Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BBA7184CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbjEaOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjEaOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:23:36 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C788172E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:23:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77700e9aae3so28369139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685542982; x=1688134982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEeMcGwsmQcWXT4vssRRefgYUtAVUNcH/IZjc9KyPZo=;
        b=nl6ZncCyLlb0//swZpa/cW1OOoof1YurlLrT0As3THnOC5paCGiiezrAe6ZP3mFMyL
         lfeBOvC/VUPhAOWMUQv7M1tmzulReiXgR0kmhKXkRmc8r6Nh8x3t9H6V1okoxEoO1vyX
         hci3H0ASHYLYkRFxcFeaPkTkVVan8Zfp4oNCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542982; x=1688134982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEeMcGwsmQcWXT4vssRRefgYUtAVUNcH/IZjc9KyPZo=;
        b=ku1Fje8MhfQW0T02OY7jZV3O6y2WFUdGr8xFj/Y9L6W+kM9YIWJ2p2t7YqK9VylrZE
         At4klADrJBlCWuuhgt3tX+lmBFR5vgGLOoTXXA0KJCC+e4i0kzjOUMC98KE2fELlfQbA
         FXe3u5v2OScjc5wfjPYml3hr4wHDjNVDd/yE58Rzg98uQuH4o9LCkppsvsUbus0c2cxd
         wF/EVgNxxQCcnCI9BLVyd2e+jjXVfKlnsIZCiQFXlunB9b9/X3dRwHHHW0WEyabXawus
         etqdH/gifEpGA7HUPuGHBuKYx5yOte8T3KlExbeVuiCfedaMxBak9HAzWRJ6zZW9U7T2
         x5Jg==
X-Gm-Message-State: AC+VfDx8SXW7Njpa9cKTyNfLOjOmSXvKX1x2fbziMr+qCxeVpMzF2jqT
        2EzMNSTUAP/r9D5y3FxlZmpG5BCaZGVjn5u6Dmc=
X-Google-Smtp-Source: ACHHUZ6yBnFjbQcc1SR3hAWk3HKi8cUzzPKGOLBkPeS6SYzHiQUYeY1tc11mnhcaYbLU3HIqipDhig==
X-Received: by 2002:a5e:d509:0:b0:763:8746:a966 with SMTP id e9-20020a5ed509000000b007638746a966mr3537576iom.0.1685542982219;
        Wed, 31 May 2023 07:23:02 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id ct11-20020a056638488b00b00408b3bc8061sm1515488jab.43.2023.05.31.07.23.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 07:23:01 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33baee0235cso141805ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:23:00 -0700 (PDT)
X-Received: by 2002:a05:6e02:2196:b0:331:4d3c:db55 with SMTP id
 j22-20020a056e02219600b003314d3cdb55mr209123ila.4.1685542980288; Wed, 31 May
 2023 07:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230531075854.703-1-johan+linaro@kernel.org>
In-Reply-To: <20230531075854.703-1-johan+linaro@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 May 2023 07:22:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UtyMSekPYfamMkswC=mSRnBpQUygMxZ+Wgf6Y2dB2Qhw@mail.gmail.com>
Message-ID: <CAD=FV=UtyMSekPYfamMkswC=mSRnBpQUygMxZ+Wgf6Y2dB2Qhw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: fix uninitialised lock in init error path
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 31, 2023 at 1:00=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> A recent commit started taking the GMU lock in the GPU destroy path,
> which on GPU initialisation failure is called before the GMU and its
> lock have been initialised.
>
> Make sure that the GMU has been initialised before taking the lock in
> a6xx_destroy() and drop the now redundant check from a6xx_gmu_remove().
>
> Fixes: 4cd15a3e8b36 ("drm/msm/a6xx: Make GPU destroy a bit safer")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 3 ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 ++++++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

I think Dmitry already posted a patch 1.5 months ago to fix this.

https://lore.kernel.org/r/20230410165908.3094626-1-dmitry.baryshkov@linaro.=
org

Can you confirm that works for you?

-Doug
