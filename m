Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A49B73E74B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjFZSN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFZSNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:13:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681F10DA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:13:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98d25cbbb43so553186766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687803209; x=1690395209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTiTRQi1M2AFId64VgyQ6ZUHQ6ZBF0h7dNfO8Kih6Zk=;
        b=cNQQOPSM3ls0DItIOxwNrtQljXKrd75oIdtILuBSM7gnnhIDVuIVlwHKuwVKVdhqbH
         p1Tc2O9kYTzYw92s6eYyANHt8+xqDMH/FYJCemF8+sHozTZKpxTxGR4pedmjRixrDADR
         4lQt2m9KaD18Bm+QUMhkKD2KreWmnXvvKbIko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803209; x=1690395209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTiTRQi1M2AFId64VgyQ6ZUHQ6ZBF0h7dNfO8Kih6Zk=;
        b=cn9EAUhU7khrUv53Io1Ut3ZWxs5j3cwIUcMzb4RULj2TWaeAP+DWbAuSbha5vT+iBx
         NsiZs8LQEzKseGcsexV2neT5v/x31TALdhBXOgETVXUE05iSnn/nno2XsKGQfKxLQ3by
         yW1aJ4WW4SFGq5/KghfJ78tzYcWli0ksNcHUYsQV4LTo+0n709fsj6eosvO1hX3xz/NU
         liW3ChkEdRE8XD0C0V89wLGPIwjWko2pfKGtwmQ+r+ScI/UR8DNtBhrTWgNL/5HW/TxW
         FaCliEZufEty2IEPdhXIW0rI69Eg1jcI5sm52ZqCp7rZWUh5G7olnm+aBAasHHy4cOn+
         2X+w==
X-Gm-Message-State: AC+VfDy9qHM9JpyT1x3jXhLoW4ryRT5MBE/bLhWyS8df5O78r5JmDCTE
        czj+YGi5hvXMqjACG7itHVvPVup56MaWAlQHWQHplg==
X-Google-Smtp-Source: ACHHUZ4gfJGXFAg5zQzuY4j947YdBjMgqgsNHqv+eEhqxP8fp6HR2qK6lvoUahes1/iANe+nE3isbQ==
X-Received: by 2002:a17:907:74c:b0:968:236:eb17 with SMTP id xc12-20020a170907074c00b009680236eb17mr26625765ejb.24.1687803208972;
        Mon, 26 Jun 2023 11:13:28 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b009883a3edcfcsm3618457ejb.171.2023.06.26.11.13.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 11:13:26 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fa5295fcc8so12885e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:13:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba7:b0:3f7:7bd4:3b9d with SMTP id
 n39-20020a05600c3ba700b003f77bd43b9dmr145911wms.6.1687803205627; Mon, 26 Jun
 2023 11:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230613065812.v2.1.I24b838a5b4151fb32bccd6f36397998ea2df9fbb@changeid>
 <CAE-0n51fbLvobz-R_3LWPZBRg7SNOxgFQ_DYqMo820W_4UOhDA@mail.gmail.com>
In-Reply-To: <CAE-0n51fbLvobz-R_3LWPZBRg7SNOxgFQ_DYqMo820W_4UOhDA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Jun 2023 11:13:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDmHnCEJ7-557XhFfyKKHNnT4sUOrwjSQz3J-bXRmnNw@mail.gmail.com>
Message-ID: <CAD=FV=XDmHnCEJ7-557XhFfyKKHNnT4sUOrwjSQz3J-bXRmnNw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 13, 2023 at 11:41=E2=80=AFAM Stephen Boyd <swboyd@chromium.org>=
 wrote:
>
> Quoting Douglas Anderson (2023-06-13 06:58:13)
> > Memory for the "struct device" for any given device isn't supposed to
> > be released until the device's release() is called. This is important
> > because someone might be holding a kobject reference to the "struct
> > device" and might try to access one of its members even after any
> > other cleanup/uninitialization has happened.
> >
> > Code analysis of ti-sn65dsi86 shows that this isn't quite right. When
> > the code was written, it was believed that we could rely on the fact
> > that the child devices would all be freed before the parent devices
> > and thus we didn't need to worry about a release() function. While I
> > still believe that the parent's "struct device" is guaranteed to
> > outlive the child's "struct device" (because the child holds a kobject
> > reference to the parent), the parent's "devm" allocated memory is a
> > different story. That appears to be freed much earlier.
> >
> > Let's make this better for ti-sn65dsi86 by allocating each auxiliary
> > with kzalloc and then free that memory in the release().
> >
> > Fixes: bf73537f411b ("drm/bridge: ti-sn65dsi86: Break GPIO and MIPI-to-=
eDP bridge into sub-drivers")
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Pushed to drm-misc-fixes:

7aa83fbd712a drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime
