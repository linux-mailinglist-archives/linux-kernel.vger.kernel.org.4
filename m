Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6077C6C4B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCVMvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjCVMvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:51:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D55F21C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:51:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so72452243ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679489495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7uInAiqpQblW1FuguJKCYpcZGazuZcNpStJm/HJYwE=;
        b=eQ+8m1BOPPny9D5aNyxbHYGTiCf8Na3k/SMUqrCxaa1Yd6GYecb6qZPcSNejvrGTLh
         K2tNopHoQ+IXxsJ3Z/xQnfFtL0q0ndPimIrANSMeWDBSrX/roRZA7g4cDspQdSjlTqYO
         ST0FoVApsvyQx4KLgzGClpGOdlW5k0tRafn6Bi6bY5+mz0yLtL72We2GmJAb5QQ+kYYe
         IesM6YsnG3KC2VBYu5t3XjhDCr80TdEgGVarrxOWZTFYXfXlzOXXqgB+SxHxbjNmxrcf
         xvFNepmdn5r+oAq6AWo8ad7eTxr6LF1M25wuqgQgFPKvVkQ0UoqGT+da4ojmX6Z/EwHv
         B85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7uInAiqpQblW1FuguJKCYpcZGazuZcNpStJm/HJYwE=;
        b=7YDEQRsuYJ6xdUYmhj5WbOBCTSSCiOiMWxVIDXU6VCf0+AW7AdsaRYk0Q9v7xXlWqd
         uZ12pvE4esuNnrzsG+VJzjHgRovMMnSxx/BzUAvWN6SsSrVr4xSUi3ID9gNmWTvYD6ht
         4PGpCAmaZCsENMgncowxpduhJcmYl2CtsFap6avIS+JRspU+2mwkUISuD8JnR9DWZZJo
         2eJGkYg3JwEohz6Alf1wrAMegz3GV7EeKZ6VFRgV/35yQ1IPIlrtHBkD7FBf63UxfqHN
         c1+uKfFibWab5lioGHx3muuFTDgKMVeyYHIgDnQ4NYd988TJM4Jb2WK9Mt7tFcOBevBe
         /Yng==
X-Gm-Message-State: AO0yUKV/+FjLBQFEJT4rUTIusAAxGZlNkKu+xPSIe33aJnOT4MJa/K8Y
        WA3OAnprirRQ45wD6bnJTS68bEhug8FBPcexKZyZ7g==
X-Google-Smtp-Source: AK7set+H54h9AIkF40JfLtjJco8DQSGdF2j7ywDCKthKg0qqriwpU2mABmcujmqJNtXCow1utP9NeQroR4FDuRCo+94=
X-Received: by 2002:a05:6402:3496:b0:4ad:739c:b38e with SMTP id
 v22-20020a056402349600b004ad739cb38emr1580205edc.1.1679489494871; Wed, 22 Mar
 2023 05:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230307154524.118541-1-bchihi@baylibre.com> <CAGXv+5F6yFk+VMUe50YfV11Bx3qnQ=FHymeAM=dgfrqwLGrG7Q@mail.gmail.com>
In-Reply-To: <CAGXv+5F6yFk+VMUe50YfV11Bx3qnQ=FHymeAM=dgfrqwLGrG7Q@mail.gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 22 Mar 2023 13:50:58 +0100
Message-ID: <CAGuA+oqLi-b7YuUVYzCDQWbztPy7WOVEch6dbrbWzdPkRBOwcg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS's AP thermal domain support for mt8195
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 4:22=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Tue, Mar 7, 2023 at 11:45=E2=80=AFPM <bchihi@baylibre.com> wrote:
> >
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add AP thermal domain support to LVTS Driver for MediaTek MT8195 SoC.
> >
> > This series is a continuation of the original series "Add LVTS Thermal =
Architecture" v14 :
> >     https://patchwork.kernel.org/project/linux-pm/cover/20230209105628.=
50294-1-bchihi@baylibre.com/
> >
> > Based on top of thermal/linux-next :
> >     base-commit: 6828e402d06f7c574430b61c05db784cd847b19f
> >
> > Depends on these patches as they are not yet applyied to thermal/linux-=
next branch :
> >     [v14,3/6] arm64: dts: mt8195: Add efuse node to mt8195 (already inc=
luded in linux master branch)
> >     https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.=
50294-4-bchihi@baylibre.com/
> >     [v14,5/6] arm64: dts: mediatek: mt8195: Add thermal zones and therm=
al nodes
> >     https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.=
50294-6-bchihi@baylibre.com/
> >     [v14,6/6] arm64: dts: mediatek: mt8195: Add temperature mitigation =
threshold
> >     https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.=
50294-7-bchihi@baylibre.com/
> >
> > Balsam CHIHI (4):
> >   dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal
> >     controllers for mt8195
> >   thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195
> >   arm64: dts: mediatek: mt8195: Add AP domain thermal zones
> >   arm64: dts: mediatek: mt8195: Add AP domain temperature thresholds
>
> Whole series is
>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
> on MT8195 Tomato Chromebook.

Hi Chen-Yu Tsai,

Thank you very much for testing it!

Best regards,
Balsam
