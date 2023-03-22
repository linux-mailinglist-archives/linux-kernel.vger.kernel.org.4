Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6F6C5364
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCVSPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:14:58 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF862325
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:14:57 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id q88so6456758qvq.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679508895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv/fhOOQ5K5aUx1ATfnJVpvBsiQzQ1dAgrwhuKG15KE=;
        b=X750o3TG2P6bRJvoLUsYaz/wgzugkLKT9Ub/G6cwB9K0e03AA1YuGeaPlx8ah3rbY+
         W7LMTJFyYreapw39B5H+82+Wm5N8F8Ds9Vd6po1Wl4YNEefGJS3BXDCQ44mNOJ6NYhrx
         7jfhL26Xt+K2nbaxIpcZekE1sVDV4ufb/ol8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679508895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv/fhOOQ5K5aUx1ATfnJVpvBsiQzQ1dAgrwhuKG15KE=;
        b=dvjQv+Q7maqXe8PyvLjBIBYbCDkjblrYTy+8d0e8Y+ayr1R9LPAtvhxvfZZFyPPRo/
         oAWCen1Xw4b8jvTyyl9Ef+rkHJH5k5l1+IoVPpWQQLj6ejh/ex3zg/RauH9v6gDLT9tO
         vgo1tbl3ZhGej/Ixo84m2avJLL9N4J1dtkMsS8M2q7UBJmZd8f8vkMw6zVqEeEozrzpx
         QMENF8HAHxwNJgaAPVqoz287AYcZDPOGjOIwYshNWpYykv0kOpLGJobZhkoR7SRcEb92
         wQir0X/muafcM8t8FDSP9OUAwHtf/8C09xZOyBvVBZDrHTJjUAo6m5vwkmpYzpCDad8e
         hDPg==
X-Gm-Message-State: AO0yUKUtmRVupnTe/cLjEoH/8a/aSapxh5uvBXHuuy1A+9GfCBbD9V8k
        zaRkgyuAbEGZP0ZtbYufGQcnVubZLNPveyFiDTA=
X-Google-Smtp-Source: AK7set/n0ho2nVrK12Uqa4Ske+9lN0BCwR/YigcnuEMRz8PjZ3cwdHrImLb1fauuTtbEZTZv2u1C1g==
X-Received: by 2002:a05:6214:f2d:b0:56f:8a99:1a64 with SMTP id iw13-20020a0562140f2d00b0056f8a991a64mr9582033qvb.4.1679508895712;
        Wed, 22 Mar 2023 11:14:55 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id b126-20020ae9eb84000000b007468b183a65sm6066648qkg.30.2023.03.22.11.14.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 11:14:53 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id k17so11326030ybm.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:14:52 -0700 (PDT)
X-Received: by 2002:a05:6902:1083:b0:b69:ca6f:452c with SMTP id
 v3-20020a056902108300b00b69ca6f452cmr531063ybu.0.1679508892480; Wed, 22 Mar
 2023 11:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230217155838.848403-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217155838.848403-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Mar 2023 11:14:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTJsrnPszQ6GHMqYm0hUedA+N126jDSm2uVyVZ+L1e1Q@mail.gmail.com>
Message-ID: <CAD=FV=XTJsrnPszQ6GHMqYm0hUedA+N126jDSm2uVyVZ+L1e1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc7180-trogdor-pazquel360: drop
 incorrect RT5682S VBAT-supply
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 17, 2023 at 7:58=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> It seems that the RT5682S codec does not use VBAT-supply:
>
>   sc7180-trogdor-pazquel360-lte.dtb: codec@1a: Unevaluated properties are=
 not allowed ('VBAT-supply' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> I don't have access to datasheet. Driver still requests VBAT-supply but
> other boards simply remove this property for RT5682S.

I checked and I don't see the driver requesting VBAT. Specifically
note that this is the "s" variant which seems to share no code with
the old variants (the "i" variant and the SDW variant).

> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi | 1 +
>  1 file changed, 1 insertion(+)

This seems right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
