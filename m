Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027F9708072
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjERLw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjERLwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:52:17 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F2FE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:52:05 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-561bd0d31c1so16416617b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684410725; x=1687002725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvfUXuQLdcRRFK6mLXbSp6TuokWZaIj2pmBfTn+gwLw=;
        b=NxDa+2Q4bWlEhVfVP+HUsVkISRhHFxaytK65rO1w+EzNppVqwLhxiPJ+hELw0myAX/
         dxDAZ5Gkox6VQmWtTDoJnI/DxxkYdL+aIvnfx9fv4iL8Fhd0utymtgXI63QTgzB02dCa
         gZ0GskpxYgJXJwBkfBV1ogWjD5NubeCuPQz8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684410725; x=1687002725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvfUXuQLdcRRFK6mLXbSp6TuokWZaIj2pmBfTn+gwLw=;
        b=i5uH2OnPAxLbSKT/ruOA23lKYO+xwcPDHF9VWPVhtrFEyMJCR++sVFsrh9AaQtK7NX
         jx8tbrXLc97c6auBUKUQHIKTQeNzwwDUCaLtmMXwrNPE1Wv/uSK71DaUwzRwd8fI54OL
         VhLRpTSInh7o/ZUhZfk5qbGac6Wydxc4MlRb6mVSQuUx34DQiqRaRA/T2TL4L6JEPk8o
         lQmotdi2hikGOkE+fXu8JDbzJhD07HVtD/fhG4JG0Wx8hMMZWdLNRIPBtZMaQxY5ebrQ
         ZkGyQbKDR9do69FgB8FxxleYIVx5byI1cARbk9jdzGTTyjcNoaHeUtgI68DU9X1LoEsI
         0uNA==
X-Gm-Message-State: AC+VfDy0jTpgOLTmfucisjfYkqPF3nioTIkWsN8P/WZn/hIaRqVUyEKH
        K7+FJfyYZM50JCDHn5jPV6SZJuSxVBZgK0SfHZQzAA==
X-Google-Smtp-Source: ACHHUZ77dNBKDAmEmByXJaKmA+9QpHEGry6uMH+jKnRdFQghZZSSaOQYgAqJHFxN0xVC7BXjZo4ohG+1pfqASYSuW1Q=
X-Received: by 2002:a81:a211:0:b0:556:ea38:eb07 with SMTP id
 w17-20020a81a211000000b00556ea38eb07mr1055451ywg.50.1684410724873; Thu, 18
 May 2023 04:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-2-aford173@gmail.com>
In-Reply-To: <20230515235713.232939-2-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 18 May 2023 17:21:52 +0530
Message-ID: <CAMty3ZCoJP=Mk20_O_Y0Vpuuayz3k3J_dA2zg1Ls0YmU6eL0Fw@mail.gmail.com>
Subject: Re: [PATCH V6 1/6] drm: bridge: samsung-dsim: fix blanking packet
 size calculation
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Lucas Stach <l.stach@pengutronix.de>,
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
        linux-kernel@vger.kernel.org
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
> From: Lucas Stach <l.stach@pengutronix.de>
>
> Scale the blanking packet sizes to match the ratio between HS clock
> and DPI interface clock. The controller seems to do internal scaling
> to the number of active lanes, so we don't take those into account.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
