Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0AE6D0DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjC3SgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjC3SgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:36:12 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8751CCDCF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:36:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5445009c26bso370789747b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680201363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1mfsAVkmxLwhRt7IlI3jhuOesEA4D6U7D/dfayN2QA=;
        b=eP039oXzf7CB3ggm2J6rpiMJY+5vKxJHkiBGixvZs5XFnmGqB9lc8kJ9qb4kYReDyv
         wIJoOuWoSJRpdHz6RtDy5hZkD7debhi8PF08TmTnLM/ODbvb7DJHEy7qsxQBsKSV0xwd
         b4pL+J9Xwv0UMbktA6t8SEhNGNNHAJK+KApxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1mfsAVkmxLwhRt7IlI3jhuOesEA4D6U7D/dfayN2QA=;
        b=Vr9tX1bFiAQfFXpbo9B5Xn7IWDugzQ57zTifipzNqmWdoqL8QQ6axFZIkuergXqwvA
         h00zRLwmH2j97Xj7GXiGq7WZGjzeVDc+1Pc+h871ep9a6zmNmiQ62lGnLQ8zTscGftUs
         B7ooB0J3I1bkEZxFBK7iM/w1PcVNon3AGRG1G/VjDrwA5YMMDgXEQ/522JFjB1thLI+y
         EPE0VzW+DuqCR4ga4AIbFsLarHdZMursW/7MSDmedUCH540hA3MjGYH/ar2T/dwo3paD
         WxjjEASIvR/3vIkupla88HAMgPbT36v9hIpEN4dLnZ3ISus7BX3mw0x6fidtaZFKvghu
         2FVQ==
X-Gm-Message-State: AAQBX9e+fwu9UGFtQ2fAGoUX2hePdeIvo+cj2n+wpSn+gZGztvf0Y9GU
        sGfvBbTE7dCklkswUTLHgxxnA6yZhiRhLeW+QO0=
X-Google-Smtp-Source: AKy350YiIwXOmqWRQpsURygfTEv0G2rRUmLOCX0pf3+zttl9Cb94PlCHycekoz04rQQ+Lwh8YiVjeA==
X-Received: by 2002:a0d:da02:0:b0:546:22b7:f248 with SMTP id c2-20020a0dda02000000b0054622b7f248mr6325210ywe.25.1680201363321;
        Thu, 30 Mar 2023 11:36:03 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id d195-20020a811dcc000000b00545a08184d8sm11847ywd.104.2023.03.30.11.36.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 11:36:03 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-545cb3c9898so295811867b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:36:03 -0700 (PDT)
X-Received: by 2002:a67:d493:0:b0:426:a319:a226 with SMTP id
 g19-20020a67d493000000b00426a319a226mr9101769vsj.7.1680200976855; Thu, 30 Mar
 2023 11:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230324195555.3921170-1-markyacoub@google.com> <20230324195555.3921170-9-markyacoub@google.com>
In-Reply-To: <20230324195555.3921170-9-markyacoub@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Mar 2023 11:29:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wq8Z+rf++08fyYvsBUqdWX23qoUSOBBR5nP=hBUk2mzA@mail.gmail.com>
Message-ID: <CAD=FV=Wq8Z+rf++08fyYvsBUqdWX23qoUSOBBR5nP=hBUk2mzA@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] dt-bindings: msm/dp: Add bindings for HDCP registers
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, seanpaul@chromium.org,
        suraj.kandpal@intel.com, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 24, 2023 at 12:56=E2=80=AFPM Mark Yacoub <markyacoub@chromium.o=
rg> wrote:
>
> From: Sean Paul <seanpaul@chromium.org>
>
> Add the bindings for the MSM DisplayPort HDCP registers
> which are required to write the HDCP key into the display controller as
> well as the registers to enable HDCP authentication/key
> exchange/encryption.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
>
> ---
> Changes in v2:
> -Drop register range names (Stephen)
> -Fix yaml errors (Rob)
> Changes in v3:
> -Add new compatible string for dp-hdcp
> -Add descriptions to reg
> -Add minItems/maxItems to reg
> -Make reg depend on the new hdcp compatible string
> Changes in v4:
> -Rebase on Bjorn's multi-dp patchset
> Changes in v4.5:
> -Remove maxItems from reg (Rob)
> -Remove leading zeros in example (Rob)
> Changes in v5:
> -None
> Changes in v6:
> -Rebased: modify minItems instead of adding it as new line.
> Changes in v7:
> -Revert the change to minItems
> -Added the maxItems to Reg
>
>  .../devicetree/bindings/display/msm/dp-controller.yaml     | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
