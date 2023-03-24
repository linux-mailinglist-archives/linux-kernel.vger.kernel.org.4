Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678E06C82D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCXRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjCXRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:05:05 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AC720040
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:04:56 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-544f7c176easo43984817b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679677492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55jXLirChjS+BkN9O/QVlhBVJ6/URXMG6y24YCNnkYA=;
        b=guU1oU5G7/yHf2+DsUxV9XQtKtafHnGW8LxGkAehMw/sR3e3gnFng83w07+icz93Rm
         wv1+oDHt4AqUvxv5Ez4tT7OSaju8El1XZWyDrKBDbs2wAf4Tf9JvEbXXA9t3Jw2cduB9
         nhn53QKaK9vezYM1B9jSf/mJ9S5JwvQoPNgd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679677492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55jXLirChjS+BkN9O/QVlhBVJ6/URXMG6y24YCNnkYA=;
        b=OeCf4Tq81FxjOisubO6TdFPPL+x1otg/k7B9Vw44Paog/De2rPJoShX1lNBqhpPOgL
         r/njxD9mlJFNwgrKw2I0Z92zTKKCYhWtc3i7OaWx9S2/cusTiXsC/KV/jaO2Eljavtmn
         tzGqGHpa6AdJApFKgYgDZvIpikVaGEWSHMjqd6CpOz1+hE9eOVQ+7AGliULdblx2pazF
         UBSlj42Xn09+WTTRcw8wte1p3FeYjfruOQmGKm54G+j5Pe9ONcJwmJeSO7FsB326t9jC
         leQcFiMtftoNv4Yyqcc6SBXCTPWd47/7BMMS7+LOCSANywXnhRIO7hK+Md/8iIJliO4u
         PVlA==
X-Gm-Message-State: AAQBX9ech5U6ytu5WdHA3aF85L2hfWxHYdZQwV4Pf0gQPzz2YMN3WQkz
        p1gVrPKw6sUVG9Du5rokVDh89hfbEAHsRZDXgfE=
X-Google-Smtp-Source: AKy350ZPajQ9cuvyiIHHKrHblXwa+ejuqVdfMupk2qq+b8LNamc+v/urJxOrm2nFuYqV6h8tqMT8qg==
X-Received: by 2002:a0d:cb8f:0:b0:538:77e9:3e7b with SMTP id n137-20020a0dcb8f000000b0053877e93e7bmr2751374ywd.1.1679677492711;
        Fri, 24 Mar 2023 10:04:52 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 80-20020a810853000000b00545a0818497sm512471ywi.39.2023.03.24.10.04.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 10:04:52 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id j7so3019234ybg.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:04:51 -0700 (PDT)
X-Received: by 2002:a05:6902:18cd:b0:b74:6c88:7bff with SMTP id
 ck13-20020a05690218cd00b00b746c887bffmr1571883ybb.0.1679677491319; Fri, 24
 Mar 2023 10:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230324165909.131831-1-vkoul@kernel.org>
In-Reply-To: <20230324165909.131831-1-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Mar 2023 10:04:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJepzmKczemVGB8NacjyvLDqXiRoc81s1tJ=u5+HAeqg@mail.gmail.com>
Message-ID: <CAD=FV=UJepzmKczemVGB8NacjyvLDqXiRoc81s1tJ=u5+HAeqg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add B133UAN01.0 edp panel entry
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 24, 2023 at 9:59=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> This panel is found in Lenovo Flex 5G laptop, so add the entry for it
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...assuming nothing distracts me, I'll plan to land this Monday to
drm-misc-next.
