Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181C863CA87
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbiK2VhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiK2VhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:37:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A215E3E1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:37:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so36975107ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWF9gOd/OY/hKO0R1X+AR0OfRDJ2mDFKtPhWMv/Y0Hg=;
        b=C3cqCKNZvB+oxs2Z7PiDFvl3m4uH+qKJOwduAl71kmF3MfYto97m5S60Fz47UIGVVE
         kTnLFuPBp8XqzvmLdO2DhSNSd+/QRot4t0KXV7WJ9AAzeTkf/suAR3qs6xkayDF5L3T2
         b8ycGwfFGvOZxsfqaidTxUR3UbGtV59MiZFj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWF9gOd/OY/hKO0R1X+AR0OfRDJ2mDFKtPhWMv/Y0Hg=;
        b=jcJcayZMkv1TfUB1z+QVUKbGA0vnaFx5CE2qbMy5qg4lVjDuN/FrOA9Uqf0qTwUbrV
         B5MNYr61GItZkursPrAt0Vc74ukC8TzYN+nNTlgaTTB3GCCuaQ9jX7aC/eNYTwids3x0
         RNNwQo8G+xr5ybcV1yVRUHjF5/z/YF+wMZthYUVyjBCMnjjUsFf0rulwJAilsWquvI6f
         wIt+Q6EUZEL7qHuon4JbCl1nrs/YDuPXP2PW8GYtc9Ae17jf4V35JiZG+oiOmvyDMFG9
         g/XcORb7+Sv8xkJ+oKHz6OCA26XJV3gkqxijYhVPFiwk9uVYCqhK85YfQP0IooKRMARE
         wqVw==
X-Gm-Message-State: ANoB5plgJyUY2eNPczy2PcbH9PFn8M4jEfVTU+GvRBxUBD7WorBYS1Bd
        IDG1g99yq4YS0Q3E4JbRy6M3nIEmenjy9lx8
X-Google-Smtp-Source: AA0mqf6eiHgj4bRq8ifZgcdTJwtRG7zwCmAUdjqZ4vKzxFHpb6GGXkRPbho7yvEuGPF9D3kyOly/Kg==
X-Received: by 2002:a17:906:a113:b0:7b2:7c9a:1849 with SMTP id t19-20020a170906a11300b007b27c9a1849mr48973978ejy.733.1669757825406;
        Tue, 29 Nov 2022 13:37:05 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090676c800b0078db18d7972sm6551458ejn.117.2022.11.29.13.37.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 13:37:03 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id x17so24165661wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:37:02 -0800 (PST)
X-Received: by 2002:adf:fd89:0:b0:242:1f81:7034 with SMTP id
 d9-20020adffd89000000b002421f817034mr4218482wrr.617.1669757822248; Tue, 29
 Nov 2022 13:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20221118224540.619276-1-uwe@kleine-koenig.org> <20221118224540.619276-37-uwe@kleine-koenig.org>
In-Reply-To: <20221118224540.619276-37-uwe@kleine-koenig.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Nov 2022 13:36:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VFuDRpkGPazE+xqwAj=0J8GO4EDU_fu+W72E+HQchLsQ@mail.gmail.com>
Message-ID: <CAD=FV=VFuDRpkGPazE+xqwAj=0J8GO4EDU_fu+W72E+HQchLsQ@mail.gmail.com>
Subject: Re: [PATCH 036/606] drm/bridge: ti-sn65dsi86: Convert to i2c's .probe_new()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-i2c@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 18, 2022 at 2:46 PM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
>
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> The probe function doesn't make use of the i2c_device_id * parameter so i=
t
> can be trivially converted.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

As per request in the cover letter (and no countermands in the replies
to the cover), I'm landing this myself. Pushed to
drm-misc/drm-misc-next with my review and Laurent's.

de86815b3730 drm/bridge: ti-sn65dsi86: Convert to i2c's .probe_new()
