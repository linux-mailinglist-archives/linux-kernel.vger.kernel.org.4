Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0D70809D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjERMCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjERMCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:02:03 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539FEE4
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:02:02 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9e2f227640so2657515276.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684411321; x=1687003321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvwHGI4vhsZwVAeRbD6Otm9nDrfWfKKFU1vesqzDCe8=;
        b=l3jykI8hIElPtKw7tk+/jISM833pBfdiJgdvWdMi6BcpEB7YmJAvUpaoSIu06aJK/H
         x1eH3hOwGrdDD4cQpkKxLTQdnW8zCvCqIeWnxWStndGnTvIpaSP5U3mYemI4e5+60SGn
         BJTBu/rhJNgpZmYfPlvBj7dwvraL/WwCUmc50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411321; x=1687003321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvwHGI4vhsZwVAeRbD6Otm9nDrfWfKKFU1vesqzDCe8=;
        b=dzZNns7lVOFkdCzpC9L8ePIJirYkPR3OeVEks/g6npwQpad+LyFUo8GUr//ZgFYo3F
         lHUMWnEFq4bMwYBb/ZX63DyEc/x/FDQaUmfnFfm/gWGYgZyl0oSMKtrxu3XPmJ3n7C/R
         q6UJ4q1yiwEJwHwre2oHxcqaYybcILDiE02OHCAdeW5w9e/Ka3NwLpAwYjYwHTmzt034
         /hL1w+irC5XUy9Nu5oNp4mOpFwSrkukW5VBDWvJe+ZHpTFu+oVFwlaRfk6Oxt/sCSfLd
         AKoeqSBspq8uXn7kERZBbmVLFSGAYqykbxzLS0wKFGbILf//9fQ85Jogjio9caOGdedC
         x2Hg==
X-Gm-Message-State: AC+VfDw67VzZg5lMQ+ft4n/9rSQZT8kqbZnpbVUX7zb5iVDLkVhCSiB4
        vE2h6iaKe+C0iLoqhBV9hKbzCVOJcE5lLo4EH//fRw==
X-Google-Smtp-Source: ACHHUZ7ndfxs4tXBRUlAk90tteKfdFHLiIuvOYQViHFQsuEDwiTZBHFIk3mdtYRJjGVluIGyAL23S0LSEy2xlp2DAJw=
X-Received: by 2002:a81:a116:0:b0:556:ceb2:c462 with SMTP id
 y22-20020a81a116000000b00556ceb2c462mr911480ywg.2.1684411321524; Thu, 18 May
 2023 05:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-4-aford173@gmail.com>
In-Reply-To: <20230515235713.232939-4-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 18 May 2023 17:31:50 +0530
Message-ID: <CAMty3ZBYEi9EUzM3RBk6Uj1wz5sACG41MPYjrMb1QrR3UPrc5g@mail.gmail.com>
Subject: Re: [PATCH V6 3/6] drm: bridge: samsung-dsim: Fetch
 pll-clock-frequency automatically
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> Make the pll-clock-frequency optional.  If it's present, use it
> to maintain backwards compatibility with existing hardware.  If it
> is absent, read clock rate of "sclk_mipi" to determine the rate.
> Since it can be optional, change the message from an error to
> dev_info.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
