Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0D650A81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiLSLAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLSLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:00:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652D7BAB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 03:00:28 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d20so12378246edn.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 03:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iuCRAFVT/WKlH/y5prSBpJD3SqynK7xQGXEcEcRTyec=;
        b=Bl+FBOtkl3TIJreEdb1w5tp9wF7vjZAEZN2mCn8qBr6bOR7eYJSh7G/1tL/e5C757l
         +By4uVqs9vRPMrTwxcKs6clHXPr4H53i4ILsMV2qdduSiJrp5gCN8V3cNTYQNOFaEsr0
         aA5oveWy4U2XBiqyEhtfUfGGOKm2lc4gWTVkk0FKWHxy7nKtsjFWb8on+rH/oxlGP6Uv
         nHei7CBOJKphzTStw2wi2vT+E/+11Sin7ItVJfjS1kA8ZR/1RGl2ilPeI8zZzmw+3aNR
         R3HYK6/iX9sYWHOYWElZLiy/m0HvAR9qPPQ8K7W1pus0ETAKy+Qsi14txsICXBMfuDMl
         ceXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuCRAFVT/WKlH/y5prSBpJD3SqynK7xQGXEcEcRTyec=;
        b=mDqfj9APxQQf2oK1ckx3T5wKmxSD/4GmMPOMO+PYq2JPPB4bn3bUOZFgkk0jqv40Ky
         mckZV4BtRqzEAti+yBhvzr7R7EK8G4pioMUqfr9qA+0IGBlWvqEeb17eNNWunrK5HL3D
         uCUGceSKKv6aOSlY1JExza4zNk8JE7ptZCJCu1Pm194yWofVoPI+hb0+wJAOXbB2z7Es
         pPT6pOFob0lnAh3Q3OPxCZHuauogSYGRxgmbDa5rwBWRBtF766v9+U7vHlRmJJkfEbjQ
         u8EQhUI0tDpedyYculFlnVhmuCF0ZZqHAHLIg/v/dMjPWHmQeZ3a/hu46ZuLmG1iFCD3
         ye/Q==
X-Gm-Message-State: ANoB5pmBEF6hO1S5TzpDoxnfynjFpIWbdlpLVWceLWCCLX1uyUvzyeJE
        yYk0zQV0YXu3xXDR1j+d49+MrHOXsXFfxyq3Dgo=
X-Google-Smtp-Source: AA0mqf4PgOFZhk8kk0KOvHCW2ZZP8Y019U4xA8Etf86NHLJZ6BISof2bR97ocHW80jvc1aiWRPU+HPdZW+4EhHZeqmY=
X-Received: by 2002:aa7:c38d:0:b0:46c:fa25:f03d with SMTP id
 k13-20020aa7c38d000000b0046cfa25f03dmr16124267edq.291.1671447626791; Mon, 19
 Dec 2022 03:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20221216-afbc_s905x-v1-0-033bebf780d9@baylibre.com>
In-Reply-To: <20221216-afbc_s905x-v1-0-033bebf780d9@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 19 Dec 2022 12:00:15 +0100
Message-ID: <CAFBinCAfF-=776E3k=NnhaG+rMCp3b=WbjkN=RKGG8vM3Cn-3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: Reduce the FIFO lines held when AFBC is not used
To:     Carlo Caione <ccaione@baylibre.com>
Cc:     David Airlie <airlied@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlo,

On Mon, Dec 19, 2022 at 9:43 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> Having a bigger number of FIFO lines held after vsync is only useful to
> SoCs using AFBC to give time to the AFBC decoder to be reset, configured
> and enabled again.
>
> For SoCs not using AFBC this, on the contrary, is causing on some
> displays issues and a few pixels vertical offset in the displayed image.
On the 32-bit SoCs (for which VPU support is not upstream yet) it has
caused screen tearing instead of shifting the image.

> Conditionally increase the number of lines held after vsync only for
> SoCs using AFBC, leaving the default value for all the others.
That was also my approach (for a not-yet-upstream patch).
Since it's affecting already supported SoCs I suggest adding
"Fixed-by: 24e0d4058eff ..." (maybe Neil can do so when he agrees and
is applying the patch).

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
