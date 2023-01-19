Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187276742D9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjASTai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjASTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:30:30 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9224966C4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:30:28 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 203so3876208yby.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeirCJAnAvYHJRWOqOsfW1hYyWSjdT+Ia3hbkutfMMQ=;
        b=W/jc15KxUCWrRIvEx3elqDdDeiflQ65ZJhZp5RrASRAKLlj4zO58m84Vj+u2t+A+Ub
         LTjFrtDTgJJVd7gYUe/yqMbevOT6+SY5vxKbC7sV8tbxbtrGnJFNe0rIiMVMnvagfgub
         diSVQG+En5UIkmCkzbRWk08gMCztKdMlKAI9UvkF/hmAgrg0797beeT50QqEuEn0RS40
         tm/IcFVo5NUeEC9wdsBVfRhoMpB3tWv36YkrUuG5Gi2AIFAXdIW3wjzmrrB/pXM0V4k5
         Zs9zKCNClN4iHq0g6JAKrnC4ukKpMa1cm6cZSasj4Dk1GA4WDzFW5GPg+SYXEq7L2S4J
         P4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeirCJAnAvYHJRWOqOsfW1hYyWSjdT+Ia3hbkutfMMQ=;
        b=N4izJIaLbz9tkIoYshIa8xWplod3ocmXtPX22/4guZQbdWpmAZQ3ZvhflhQ26rjvlO
         sjre/7fORT90wm9OLQiZqRA+XfulYcboaxWILMo9BM2QBJ273lvIz/d3NZAp7RnFF8YF
         LhBx9yKCtIc4qnfDonkyNqPJyJiYnyzOSWu0fY4T3lBx2Y373U/KUQ3fhbcsPzn/pzRe
         4z1M7W6utASzT2MOjcqrhy0sUxgr9utv3iDk6qc98DiaC4JzdIecBXsfXR0iVCtukaMT
         T6k0HBXepPHOLisrEioGWe3wgxV98SkiTfgHmcwdGsYeBVUNvplhG3ks/UlyzWXcxU0n
         8Sig==
X-Gm-Message-State: AFqh2krcv4LPGD8IhawCrifqoMcRkSGq/ZMKICfdbt/xXIURu66B+BOr
        ZodDF3MWsrRdie4j/AiLEnYOTUUhPV3/wDuxb7X1ew==
X-Google-Smtp-Source: AMrXdXu2hI6GTxFM6roiARVxtIshJOJfKVdp6j55OgzYw67RgQhhNqIbaKmtFdYvzitjyQsXkdo2ssTrJkJ37MisEbw=
X-Received: by 2002:a25:9291:0:b0:7c0:563:c516 with SMTP id
 y17-20020a259291000000b007c00563c516mr1162358ybl.529.1674156627804; Thu, 19
 Jan 2023 11:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20230118-mt8365-spi-support-v2-0-be3ac97a28c6@baylibre.com>
 <20230118-mt8365-spi-support-v2-2-be3ac97a28c6@baylibre.com> <Y8l/mQjjgKJiE1/F@sirena.org.uk>
In-Reply-To: <Y8l/mQjjgKJiE1/F@sirena.org.uk>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 19 Jan 2023 20:30:15 +0100
Message-ID: <CAFGrd9pZ0Lso6LMKkN=ErujGgRi6t5_C3FvbMYHaV5V_DD0BnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: spidev: add new mediatek support
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 19 janv. 2023 =C3=A0 18:36, Mark Brown <broonie@kernel.org> a =C3=
=A9crit :
>
> On Thu, Jan 19, 2023 at 06:28:20PM +0100, Alexandre Mergnat wrote:
> > Add the "mediatek,genio" compatible string to support Mediatek
> > SPI controller on the genio boards.
>
> All my previous review comments stand, please don't ignore review
> feedback.

Hi Mark,

Yes sorry about that, I wasn't aware that I've some feedback when I
sent V2 for a quickfix.

I will take care about your comment:

> We need a matching update to the binding document.
>
> This does also seem like a terribly generic name - Google
> suggests that this is actually a series of numbered products (eg,
> Genio 700), perhaps we should be using the specific numbers here?
> I guess users would care which they're talking to.  It really
> parses as being "generic I/O" which would be an end run around
> describing the actual product though it's not actually that.

Is there a binding documentation for spidev ? I didn't find it.

My understanding is to have something more specific like:
compatible =3D "mediatek,genio350"
Or maybe use the SoC name, to be aligned with the DTS ?
compatible =3D "mediatek,spi-mt8365"

Regards,
Alex
