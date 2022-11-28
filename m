Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5800463AE38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiK1Q7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiK1Q7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:59:05 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BCF644F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:59:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id fy37so27374100ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=94UoTEtCwsgLlyoUn/8AD8mJDx89N1BdhDyij1YoW08=;
        b=IlUQuZmmyuB8CrLOu0CzKFgnfB8B45gFjR679OSaS9osustOlk2CsUFFYZUpzNrJve
         5E896+nqxPcsHVltqORYFOXec88/bY+s+Ywa4lpOk5uBkG6h6sQTFj7fbZjkKyDkp8Mg
         Z3UeL2Xl1rU5XLkPjJgquHnycGgEV2VdWc/Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94UoTEtCwsgLlyoUn/8AD8mJDx89N1BdhDyij1YoW08=;
        b=yW6ouQeONt2xjlRtwNmnm9WGRjTOF8aGgEYVH0vqJCR0KqTwwRD7XOoc2Q19fYK3Bm
         GI5Bv4zLd63V8PThTcn8QMIct7u6nbxoDFd2t0U3cD2W+67sPAifFygbNPIQ4/2SY4BR
         1XDEuiX9I+wwOsYA7oYzfYCwvHtdds92DklzYpSCIVx0dArwf29oURGv7RauIbxM3gi1
         0fsME3LcasD5jSWTqS39yoiI7Zn5PtdX9ZWY2hL2lIcPjtgzWrwz6duP+m9bZpL68/Q/
         czNSc5+gAuNVX8oi+BzC6XhjSEH1+N1+unWH41YWOqe8fGHYW5Ce6pYJq16ZS6utdfeV
         /qzg==
X-Gm-Message-State: ANoB5pn+rEGrRhkw5mZwXgERxQT1Tiz0m3uQ/ku2YcI2fJRN/Rz+78de
        uBCJLTEszsQ36iQItvIV/OKJh55arXR6Rd5j
X-Google-Smtp-Source: AA0mqf4eXP0RrAJWJkxnBfO4N1cawdgj+xspw10oN7kH0kM1ccU+vwedsEHm+fWBCxOxZLDT9NUlCA==
X-Received: by 2002:a17:906:8d86:b0:78d:4742:bb62 with SMTP id ry6-20020a1709068d8600b0078d4742bb62mr33003610ejc.43.1669654742090;
        Mon, 28 Nov 2022 08:59:02 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b0073dbaeb50f6sm5079561ejf.169.2022.11.28.08.59.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 08:59:01 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id x17so17887814wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:59:00 -0800 (PST)
X-Received: by 2002:a5d:6409:0:b0:241:f7ae:b1dd with SMTP id
 z9-20020a5d6409000000b00241f7aeb1ddmr15399753wru.138.1669654740625; Mon, 28
 Nov 2022 08:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20221125174415.v5.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
In-Reply-To: <20221125174415.v5.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Nov 2022 08:58:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VqXEONnSOyFLHcM4Z9+6+bVnqjbd_24M9LAoAsWy-L=A@mail.gmail.com>
Message-ID: <CAD=FV=VqXEONnSOyFLHcM4Z9+6+bVnqjbd_24M9LAoAsWy-L=A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: qcom: Add zombie
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Abner Yen <abner.yen@ecs.corp-partner.google.com>,
        Gavin Lee <gavin.lee@ecs.corp-partner.google.com>,
        Harvey <hunge@google.com>, Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 25, 2022 at 1:44 AM Owen Yang <ecs.taipeikernel@gmail.com> wrote:
>
> Add an entry in the device tree binding for sc7280-zombie.

Probably not worth spinning the patch for, but previously [0] Matthias
requested that you say "Add entries" instead of "Add an entry". Please
don't ignore reviewer feedback.


> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
>
> (no changes since v1)

Also not worth spinning the patch for, but your version history is
lacking for this patch.

The way patman works is that each patch should have its own version
history. Thus in patch #1 you could have had:

Series-changes: 2
- Adding "(newest rev)" for zombie entry description in qcom.yaml, as
requested by Douglas.
- Adding "dt-bindings: arm: qcom:" in bind patch ${SUBJECT}, as
requested by Douglas
- Changing Patch order, binding patch first and dt file second, as
requested by Douglas

Series-changes: 3
- Droping changing file path in description. v3. as requested by Matthias

Series-changes: 4
- Dropping the redundant 'DT binding for' as requested by Krzysztof

In patch #2 you would have done similar things but describe the things
that happened to _that_ patch. Make sense? Note that "Series-changes"
is different from some of the other tags in patman. Series-version
should only be listed in one patch. I believe Series-to and Series-cc
can be listed in multiple patches but they are all glommed together
into one list.

>  Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


[0] https://lore.kernel.org/r/Y3zZWWCJ8aYphD7f@google.com/
