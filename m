Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573CA629E56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiKOQBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKOQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:01:30 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB26BCA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:01:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s12so22497735edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YCH6PtmHj3XKQVwXY2Gm1n1n5KTgNrZ2aoxjacIPkLA=;
        b=XSZ1UsKd72WGVsU13AkxPx13kvV7eBMN2rk9mYv5/1BlvJuWdPfmvCjHqGY1YHuX1S
         ZKcO4QYOE4Wc2+/sm0oCJqKm0mbgDpEta1QZXmLqmoik9/WEh1cA5d8rjRXkfeZwUrS2
         t1agO5hRMm5K5WuuenC90gkUkRgs3BSOw1BPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCH6PtmHj3XKQVwXY2Gm1n1n5KTgNrZ2aoxjacIPkLA=;
        b=k7ngeFk2BI9kyXsBpzIArXFJoot47nnL/s2GutYe9lpX8oTT6zaxS+3YPl8irXCGc/
         YzdAO8eBTzP+mknnmsEaBVQ28wR+irr/WIbPEWUn7S976usvFbBvwdG4FDBNlScpGzO3
         rZdT4Ydq1AZsCLQTwwcDlf8/Oz+mswMLwQl1TuGUDkvaRlO3oZdZuvPy7zsAk/AxwIUZ
         tIa8yWML6prwZ8yd/HLKd14hUS5/8sVVYOzCDAhPcWN3z57YpUzxj42/bhx3soIEr7i8
         wucHuOxJGfrADv8P5nhP2bt6Y33JGAzReisGozmoxTp01P7QhkH6K+aWOu/b805AkYJe
         mr0g==
X-Gm-Message-State: ANoB5pmR0CR4PsUpCcxXhuYZw7WwNSBUCReIJ9HJoVcbupiP2PXy8XNC
        gpRLHBDCmTYTap9wEnUAofBKDrzgpW8suKhL
X-Google-Smtp-Source: AA0mqf6gdSQ6Q81BieDh95B6/ETWcZlXDYgkVSRIHCpMcAmvoxi7Qdu5VkxOTNe4ntwIb9PeRR8XxA==
X-Received: by 2002:a05:6402:3814:b0:461:7d1f:1a7b with SMTP id es20-20020a056402381400b004617d1f1a7bmr15074549edb.400.1668528088035;
        Tue, 15 Nov 2022 08:01:28 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id c12-20020a0564021f8c00b0045b910b0542sm6310905edc.15.2022.11.15.08.01.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:01:25 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id cl5so25043653wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:01:25 -0800 (PST)
X-Received: by 2002:adf:f145:0:b0:236:5270:735e with SMTP id
 y5-20020adff145000000b002365270735emr10938918wro.659.1668528084437; Tue, 15
 Nov 2022 08:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20221115155535.1615278-1-robdclark@gmail.com>
In-Reply-To: <20221115155535.1615278-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Nov 2022 08:01:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VJKTHf7qLZkygfnMRSjXEdQ09opCpFM2brUc=uiTGyTw@mail.gmail.com>
Message-ID: <CAD=FV=VJKTHf7qLZkygfnMRSjXEdQ09opCpFM2brUc=uiTGyTw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Enable clamp_to_idle for 7c3
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, Nov 15, 2022 at 7:55 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> This was overlooked.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
