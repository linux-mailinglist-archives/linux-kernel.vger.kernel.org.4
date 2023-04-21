Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7370C6EAEE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjDUQQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjDUQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:16:05 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D98A63
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:16:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3edb31d16efso10545131cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682093762; x=1684685762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef3idQ4zPSY5kI7SCQAQVACM6knAQnMe+8If0IdDnhE=;
        b=fB0CXt3Np6S1T+n7imYcRS4KqtdV2haVKTj64OdXAirSZSAuLb/m7f4KU25XCSwYJb
         0ojNSnn+6l67mZKhjnhqt0SzT1+3MQx/DLja8OrLzsa08Vk3y/K6JO37m/59lG0H5Yg8
         jTKGamhdFAcJZIJxaZo9+3rNHA3pt2fqusUx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682093762; x=1684685762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef3idQ4zPSY5kI7SCQAQVACM6knAQnMe+8If0IdDnhE=;
        b=QliYK9D1HL2BjdsZjI1R9+87cUQUIMxbKR/UWAsr1ljp4fAh4EvF7lPUREANs99CSQ
         AQu5d7v4Wn0/uBmjE9UZTcgpii3O6j5IBdKISuAmp0TGM0xYZUhpj0TKWAH+USHVI0qk
         haqESZUdlG3lO3eqP8zzVbLKpZCcV4fYEE8dMmi2MT5SJhSBoInxbb/qZm9Ep5/oSb2q
         mkcH4LvDpQOXBrNYv52w8vCJBKTU2o+TB4gEkRIeEVCyUiUbZuVKnAg82D8rvo7IdU/q
         KYWz6GyX5kfyFZtRc/YZS6pw+bSpYYnI9KWVvXG0mRaZnwmCUal4FGPyPUBPP+KLhZxG
         iI3A==
X-Gm-Message-State: AAQBX9eNOCQ0UNBOlHFrtHvf1guVftiJKCo0nBGRirGnIYZpOnGII4mD
        tx1YVQ6KClRlQmUI6TNiHWydaaz4j1YhjGs3bzE=
X-Google-Smtp-Source: AKy350ZJHJlKxO4ScQQ9qhPGBB7io73g/8pywd/ZaAyzXYqWQwy0Hew/ann5/JwPlwS0HVmMWQ95HQ==
X-Received: by 2002:a05:622a:1041:b0:3ef:3349:99cc with SMTP id f1-20020a05622a104100b003ef334999ccmr8806197qte.5.1682093762587;
        Fri, 21 Apr 2023 09:16:02 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id a13-20020a05622a064d00b003e4dab0776esm1417946qtb.40.2023.04.21.09.16.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:16:00 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3ef36d814a5so1177941cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:16:00 -0700 (PDT)
X-Received: by 2002:a05:622a:d5:b0:3e0:c2dd:fd29 with SMTP id
 p21-20020a05622a00d500b003e0c2ddfd29mr502316qtw.4.1682093759564; Fri, 21 Apr
 2023 09:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230201-innolux-g070ace-v2-0-2371e251dd40@skidata.com> <20230201-innolux-g070ace-v2-2-2371e251dd40@skidata.com>
In-Reply-To: <20230201-innolux-g070ace-v2-2-2371e251dd40@skidata.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Apr 2023 09:15:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQOGCCrNDCMXP_=qurPNQqN68n4khJNEgxSRT-xi87aQ@mail.gmail.com>
Message-ID: <CAD=FV=UQOGCCrNDCMXP_=qurPNQqN68n4khJNEgxSRT-xi87aQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] drm/panel: simple: Add InnoLux G070ACE-L01
To:     richard.leitner@linux.dev
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Richard Leitner <richard.leitner@skidata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 13, 2023 at 12:51=E2=80=AFAM <richard.leitner@linux.dev> wrote:
>
> From: Richard Leitner <richard.leitner@skidata.com>
>
> Add InnoLux G070ACE-L01 7" 800x480 TFT LCD with WLED backlight panel
> support. Timing data was extracted from datasheet and vendor provided
> EDID file.
>
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 35 insertions(+)

I think panel-simple currently has no active maintainers. Given that
I've touched all these files in the past and this is trivial, I don't
mind applying. I also did a review and this looks reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

1993f598998d drm/panel: simple: Add InnoLux G070ACE-L01
