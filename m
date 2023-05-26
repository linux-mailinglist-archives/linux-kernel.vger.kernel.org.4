Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3117127F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243805AbjEZOEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZOEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:04:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58EDF;
        Fri, 26 May 2023 07:04:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53404873a19so515116a12.3;
        Fri, 26 May 2023 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685109879; x=1687701879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ1GBpFPKkVus04ytAyYhOxqpYZOS871By14mi/ge4I=;
        b=aQR1tt4i9mC0Ya2dkchyQA9VflVNaVEEnmXBHYfqxJT3cGO5Qd7bERpmQcznp1U4/p
         carDDvrW+T79d4EbqTx/pLfz/3Ek/5yMhKvXB4DJ7zZL1K9qKW3cdOLlnikL7KeYt9+K
         +ucrPR51Dbrzb1rk4hIGQyKLX4L1j4CHlHLyrkLcgGgLrcwriE9KVHXiON92KYtXJB4e
         EBzcJjvDTgX5lsfPy4u+KhqnZn0pUEfWcQqfHTo17yymG8MITSA4IgSg/gnex6fXZtZn
         /g1gQ1Ce0k6c1o9pxtX6TIbuRlPD4fzFDKv9jHbVRVbeLQ7LPye4Qvpm0YDpJ83e3dob
         ExsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685109879; x=1687701879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ1GBpFPKkVus04ytAyYhOxqpYZOS871By14mi/ge4I=;
        b=XjyfbGj5aNdOrU5OpK7Gs10+QQgAT03uzCuc4np7yHk1eEZzOTf/hSYxqrJefDZeRb
         cbtLy/kTMWYlsKB8GkN52Itiw6L09eL018kpy6OZQb1qf+P/IqiwG0onRVoc3wNnLK9K
         V4ddXR0Oa26pSuEwvXs1IHk+/aeoOiLv32cVWm1JSoZQCLw9l4TqOiPGgwGWZDFmXN0r
         HeXinC3M8sCO368h056ofIiTj2QmEt1tZpB51q63pjTyurJeTFD7BSuItTsZrtBPPqTX
         Vb4f+NR9J/Uoz76RtFdbI0kyHRkzyDGxM6v2VpAycsfrvCNXHrR2zBUToqjmff825pBw
         dt7Q==
X-Gm-Message-State: AC+VfDy6TQW5mgBM7liC4U5abMEoNQaTtKbH/GRiYWHcJ13A+MmlA4Z7
        B6bBctQawhKtS5fWu6lt+2XOac7lyVFVdazkCx0=
X-Google-Smtp-Source: ACHHUZ6TgRtY4VAkH0g60ljfaQNEW/JqtHJQQXwOoQllfJ5iX9eh5VuX6gWCx3CoVX77BXXVrAKOdJmDKix3rGAqLQU=
X-Received: by 2002:a17:902:dace:b0:1ae:8e58:eb25 with SMTP id
 q14-20020a170902dace00b001ae8e58eb25mr3029784plx.28.1685109878706; Fri, 26
 May 2023 07:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230526030559.326566-1-aford173@gmail.com> <168508573345.1449766.11809947722851001124.b4-ty@linaro.org>
 <cd3c7cca-9edd-ca16-8376-e3ba924eaa30@linaro.org>
In-Reply-To: <cd3c7cca-9edd-ca16-8376-e3ba924eaa30@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 26 May 2023 09:04:27 -0500
Message-ID: <CAHCN7xK8R72eTTenp4UeuOKT7NojKDC9_ReWa0HLexzqo9E6UQ@mail.gmail.com>
Subject: Re: [PATCH V8 0/7] drm: bridge: samsung-dsim: Support variable clocking
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 2:24=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 26/05/2023 09:22, Neil Armstrong wrote:
> > Hi,
> >
> > On Thu, 25 May 2023 22:05:52 -0500, Adam Ford wrote:
> >> This series fixes the blanking pack size and the PMS calculation.  It =
then
> >> adds support to allows the DSIM to dynamically DPHY clocks, and suppor=
t
> >> non-burst mode while allowing the removal of the hard-coded clock valu=
es
> >> for the PLL for imx8m mini/nano/plus, and it allows the removal of the
> >> burst-clock device tree entry when burst-mode isn't supported by conne=
cted
> >> devices like an HDMI brige.  In that event, the HS clock is set to the
> >> value requested by the bridge chip.
> >>
> >> [...]
> >
> > Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git=
 (drm-misc-next)
> >
> > [1/7] drm: bridge: samsung-dsim: fix blanking packet size calculation
> >        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Da617b33f7=
e513f25becf843bc97f8f1658c16337
> > [2/7] drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
> >        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D54f1a83c7=
2250b182fa7722b0c5f6eb5e769598d
> > [3/7] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automaticall=
y
> >        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D33d8d14c8=
3bf67aa0d262961a6fda9c40f3c1052
> > [4/7] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
> >        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D171b3b1e0=
f8b8c894f2388e1cf765a56f831ee5e
> > [5/7] drm: bridge: samsung-dsim: Dynamically configure DPHY timing
> >        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D89691775f=
5735fca9dc40e119edcbb52a25b9612
> > [6/7] drm: bridge: samsung-dsim: Support non-burst mode
> >        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Dbb0e13b9e=
223b218c9f242f8d340a332b4381042
> > [7/7] dt-bindings: bridge: samsung-dsim: Make some flags optional
> >        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Dcfaf76d34=
9837f695c8aa6d7077847fec4231fe5
> >
>
> OK I made a bad manipulation, I applied patch 7 without review... I'll se=
nd a revert patch.

Sorry, I didn't mean to complicate things by adding the binding patch.
I added a note in the cover letter to indicate it, but I also
recognize that it contradicted my earlier email.

adam
>
> Neil
