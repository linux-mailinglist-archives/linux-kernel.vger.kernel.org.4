Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B276CB1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjC0WcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjC0WcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:32:02 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650FF2D46
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:31:58 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id cu36so8851701vsb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679956316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9Wt+WsnnVD5DSCi0zCQh6BBH6TNLjKpNQABAtkF2NM=;
        b=XViq32MCfeuoYt/kORhaQH954D+kYwpE7Trx2N7ZQP6PwLfoJc7jCBKuDZbZjlA7op
         RJEzRb2Yk98TYS6dGirAvCD2XnalPGltItYZSJgKV7tga6m5+DF4cA+SPsv7ef+JDcYv
         2SoXdGGjKCKEIX78CkQwBCzE9OSsTXgKLP0yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679956316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9Wt+WsnnVD5DSCi0zCQh6BBH6TNLjKpNQABAtkF2NM=;
        b=Sql11HpKFtu8bNeGaJGoZ1TW17GB7R/8I271DdwDaC3icGLS1K4ZeTSGXZeaYBU30D
         N+xnyoym846Egs13WMVbxzuIiwi7cuvuPUfF/OZfHUUfY9NGT6Dm/k40Zc42nkbpvNX3
         VZSpX69lloMKN9vYRC2NjhTzd65lQfp3R5mBQglpIEJ+ExjTjf+6Ucn6W7c5kjU28uyi
         fHkIaIaJAukTN+IVCYDP6+0RqlqFBubofz8xInv8jwq5JeU+lxTs8reieEKxSXS8mqpw
         i7Obh2GRdGXxBA+Nl1HSn6Gmz3SZ+7u7543PP3z3aW1N0Vyuvy4nDMnha2KK0YLqzKr1
         5NBA==
X-Gm-Message-State: AAQBX9dsrsGxGurPPfbWjA8clHX451NnxBmWAjuPBpYHy5fqpXAv5n6w
        3mx6yMNHp+zWG+nwbLv9waEYLvZNwdTa5a36fno=
X-Google-Smtp-Source: AKy350ZnqwjwZ3E3/xY+/wMH9AzsgfOz/ikjTyP6ltiIEs710y+S2n6qaD8xgLq4ZQVXSsJDjDaCSg==
X-Received: by 2002:a67:d095:0:b0:426:57e2:e292 with SMTP id s21-20020a67d095000000b0042657e2e292mr4652358vsi.29.1679956315793;
        Mon, 27 Mar 2023 15:31:55 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id h10-20020a056102208a00b00425d788d935sm3165419vsr.18.2023.03.27.15.31.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 15:31:53 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id s23so7530115uae.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:31:53 -0700 (PDT)
X-Received: by 2002:ab0:6082:0:b0:765:8f29:d679 with SMTP id
 i2-20020ab06082000000b007658f29d679mr329648ual.1.1679956313217; Mon, 27 Mar
 2023 15:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230324165909.131831-1-vkoul@kernel.org> <CAD=FV=UJepzmKczemVGB8NacjyvLDqXiRoc81s1tJ=u5+HAeqg@mail.gmail.com>
 <fb2d333e-c459-f394-a299-533083b83596@linaro.org>
In-Reply-To: <fb2d333e-c459-f394-a299-533083b83596@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Mar 2023 15:31:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WTz=FVPP+pB8VMA8qWtD9hH00yBhFvs5rkfynranyr4w@mail.gmail.com>
Message-ID: <CAD=FV=WTz=FVPP+pB8VMA8qWtD9hH00yBhFvs5rkfynranyr4w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add B133UAN01.0 edp panel entry
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
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

On Fri, Mar 24, 2023 at 12:13=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Le 24/03/2023 =C3=A0 18:04, Doug Anderson a =C3=A9crit :
> > Hi,
> >
> > On Fri, Mar 24, 2023 at 9:59=E2=80=AFAM Vinod Koul <vkoul@kernel.org> w=
rote:
> >>
> >> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>
> >> This panel is found in Lenovo Flex 5G laptop, so add the entry for it
> >>
> >> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >> ---
> >>   drivers/gpu/drm/panel/panel-edp.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > ...assuming nothing distracts me, I'll plan to land this Monday to
> > drm-misc-next.
>
> If you get distracted, I'll apply it!
>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Pushed to drm-misc-next:

981f8866754d drm/panel-edp: Add B133UAN01.0 edp panel entry
