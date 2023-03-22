Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880676C57C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCVUg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCVUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:36:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE9044B5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:27:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id t14so20268725ljd.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679516876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO+RxVHj93oqiOjN3tvlrX0xqusRwNw2CRPttJ0nsbE=;
        b=ABLAaBlml2CVEbKVXZ6gb2MwAz/+zu5By/LFaNE559Prxj8vk60R4XXSfSdRKCD5nF
         NN0CBT4LtsdxHmDyPRsdxk9lndq3nVljDC4UHT6vGLPVPNsu1LHMY3Ih5Z72QREpepHH
         r2NXYsms2/gHfFN9hL3O4ISCteI4itgoPeJvxpGXnHJ53EAF/OsGdq4D183hH5dvHDLk
         Inf0oXdOw9WEh80ykgiS3SBsSUO/6rzbUM/6Tb8ooM5u+Oqu/mA8IZs6DjtoxMt23pOQ
         caHO4OI0YnENkFJiGC9Bcwklb7Rk+DUZv8f9UwP4p4drvdMIiQ8ZC2u4qFljy0t+s1wj
         dC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679516876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KO+RxVHj93oqiOjN3tvlrX0xqusRwNw2CRPttJ0nsbE=;
        b=OKflfdV3pf9F7ZUFU46z1DyEVyC+QJuPS9F9cDHNPF4lETBFW06qQKjhjYuQlSFX/G
         En5rWWmoKEh3OLb62eAhSzOgnvRpDp0nNj1FQWCmIiWWb7IKsMokBw5z3I+2ZNilrF1Z
         gQ9nviiwzOPhmxx/jSigMC6hAPk6Z4Igr09ofYdKc5v9STfuTFLCZHjl6N5OJ7kWHSWo
         5oGOxy2prRNW/od36LCMuq5P+BHNDwKyKVVnpoCWSUmKhQE2YwBKQcKR58DLz5jO/2GB
         4zrowmc+gYPMWcjRryHAu4jDqQCGeYqBVVz45709ZjqAc+/bWMIcs/mHFiMeMjX8ccAF
         CBEQ==
X-Gm-Message-State: AO0yUKXC4cwucRye1HJfVgHtoyN2zcYHLhnNwq5VOcUQb8+kSZL22kPb
        XBWi4zQFOOS1Pr9WI1mQg8/yZuO6DcUPoWwYLZb3slO0Ey0=
X-Google-Smtp-Source: AK7set/0TeN0zr8cVu1eyLlBoDyP0EfiM6Qqt0rJeFiCyF/NYwC7cB4mSBs7WoqIFgnDZFFXTgGzjTITMMXf7hXth5w=
X-Received: by 2002:a17:907:788e:b0:932:4577:6705 with SMTP id
 ku14-20020a170907788e00b0093245776705mr4082690ejc.6.1679515823192; Wed, 22
 Mar 2023 13:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <d4338bd5-125c-a9e7-cb46-6f5e1da05cfa@sberdevices.ru>
In-Reply-To: <d4338bd5-125c-a9e7-cb46-6f5e1da05cfa@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 22 Mar 2023 21:10:12 +0100
Message-ID: <CAFBinCB3yuyNJD=7UJ7jzf45Masms_PD4sm42YNjO8M4cr+4wg@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in command word
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arseniy,

thank you for submitting this fix!

On Wed, Mar 22, 2023 at 7:45=E2=80=AFPM Arseniy Krasnov
<avkrasnov@sberdevices.ru> wrote:
>
> Valid mask is 0x3FFF, without this patch the following problems were
> found:
>
> 1) [    0.938914] Could not find a valid ONFI parameter page, trying
>                   bit-wise majority to recover it
>    [    0.947384] ONFI parameter recovery failed, aborting
>
> 2) Read with disabled ECC mode was broken.
>
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND f=
lash controller")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
This matches what I can see in the old vendor driver, so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> -               cmd =3D (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
> +               cmd =3D (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir)=
;
My understanding of the vendor driver is that this "len" is only used
for "raw" access (my own words: any access that doesn't use the HW ECC
engine).
As a future improvement (no need to update re-send this patch) it
would be great to have a #define with a meaningful name for
"GENMASK(13, 0)" (maybe something like NFC_CMD_RAW_LENGTH) as it's
used in multiple places now


Best regards,
Martin
