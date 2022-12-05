Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67C6436EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiLEVeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiLEVeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:34:21 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0713C2C674
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:34:19 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id l8so15038868ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/AFtgz+lK9M2V4Cs5/9PoWBFJhdcyuHdw2Q3pWcGYM0=;
        b=YUevHO9XgqPvry6HSJ6/W2BJQQU25R4upN0Typd6FaqC5gRATvHgY7MXNV3I064Uit
         nFsS1oQIWZ3bcFOEW6RP4tJmb543mBunzrJK8QjQGHoK97Z2MLio0b4rznLjay2U+afj
         qFly6OL7t9m2GhCC4P35fJtgFIlVWHZNDMbCCDlzD7b9IbaX2rscEBxya/UMGCZaB/3w
         GInkZJ0435TBwAFZ8J1xMD60ZjO52UhcbdKENSnASGDa464v/GDfgTWMCd5VjEfcVZql
         W1Ky8ikqcdYSkWb8EGPrM+UV08V3XNFDa/1OWa93VsbsAn0buH6/OpKDGu3YNWUYmVfr
         tfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AFtgz+lK9M2V4Cs5/9PoWBFJhdcyuHdw2Q3pWcGYM0=;
        b=ArMsbQPxLQzeVW/TCwLJS4tqufiztML2zQFHwGLjofu1HwZdvGAzkgs/XxgRVaFMQk
         Fes4uiaNqsD4VLIK4KXH5EVSbeikgFVR9FmRp0dT/Uaumi5AOpEkrr+HsJs2Yi/zhgoz
         GB6VrD5ZhXZyJgFo5KTONwBXu1CCUe7elI49CqTrO4uojw/rStfWlzBWZAqPulBxvBT5
         jBx/2Etq186b+KzkL4/X/c+ZqoIVTqw6Q1sjuOVk++8QrpxTHxXwXVFV+Sr6y8EWjGzf
         zkN6KRBSjh3e4+kspM5qucF5ma1IOX+7e3v+yTt6B8VEPqGCw0fpf9A4ZXgxOyWMEXJt
         hzqQ==
X-Gm-Message-State: ANoB5pkIPulLBKmX02l7I3zviU8aOkkkLIfPge0H1LH5jXWAMHstB9vE
        e3UYi/LEBucCgVidIrudanO1rw==
X-Google-Smtp-Source: AA0mqf4BfnB/i1w1SRHpcZzPmtxt7+I3WAaF8JW8L4rYmlZYdEqUFnQ4Z7gOet/Ue5qWPSJ4tfTtbA==
X-Received: by 2002:a2e:b4a3:0:b0:279:edbf:118c with SMTP id q3-20020a2eb4a3000000b00279edbf118cmr3085208ljm.425.1670276058362;
        Mon, 05 Dec 2022 13:34:18 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id s8-20020a2eb628000000b002776eb5b1cesm1516828ljn.8.2022.12.05.13.34.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:34:18 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:34:10 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
CC:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_2/5=5D_dt-bindings=3A_msm/dp=3A_ad?= =?US-ASCII?Q?d_data-lanes_and_link-frequencies_property?=
User-Agent: K-9 Mail for Android
In-Reply-To: <1670267670-15832-3-git-send-email-quic_khsieh@quicinc.com>
References: <1670267670-15832-1-git-send-email-quic_khsieh@quicinc.com> <1670267670-15832-3-git-send-email-quic_khsieh@quicinc.com>
Message-ID: <5552E92A-2059-4D1E-AC88-3214D93D93E3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 December 2022 22:14:27 GMT+03:00, Kuogee Hsieh <quic_khsieh@quicinc=
=2Ecom> wrote:
>Add both data-lanes and link-frequencies property into endpoint
>
>Changes in v7:
>-- split yaml out of dtsi patch
>-- link-frequencies from link rate to symbol rate
>-- deprecation of old data-lanes property
>
>Changes in v8:
>-- correct Bjorn mail address to kernel=2Eorg
>
>Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc=2Ecom>
>---
> =2E=2E=2E/bindings/display/msm/dp-controller=2Eyaml        | 22 ++++++++=
++++++++------
> 1 file changed, 16 insertions(+), 6 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller=
=2Eyaml b/Documentation/devicetree/bindings/display/msm/dp-controller=2Eyam=
l
>index f2515af=2E=2E13d2c3c 100644
>--- a/Documentation/devicetree/bindings/display/msm/dp-controller=2Eyaml
>+++ b/Documentation/devicetree/bindings/display/msm/dp-controller=2Eyaml
>@@ -79,12 +79,6 @@ properties:
>   aux-bus:
>     $ref: /schemas/display/dp-aux-bus=2Eyaml#
>=20
>-  data-lanes:
>-    $ref: /schemas/types=2Eyaml#/definitions/uint32-array
>-    minItems: 1
>-    maxItems: 4
>-    items:
>-      maximum: 3

These properties can still be used, e=2Eg=2E Bjorn is submitting patches w=
ith the old property=2E I think this should be marked with deprecated: true=
 instead of removal=2E

>=20
>   "#sound-dai-cells":
>     const: 0
>@@ -105,6 +99,19 @@ properties:
>         $ref: /schemas/graph=2Eyaml#/properties/port
>         description: Output endpoint of the controller
>=20
>+        properties:
>+          endpoint:
>+            $ref: /schemas/media/video-interfaces=2Eyaml#
>+
>+          properties:
>+            data-lanes:
>+              $ref: /schemas/types=2Eyaml#/definitions/uint32-array
>+
>+            link-frequencies:
>+              $ref: /schemas/types=2Eyaml#/definitions/uint64-array
>+
>+          additionalProperties: false
>+
> required:
>   - compatible
>   - reg
>@@ -193,6 +200,9 @@ examples:
>                 reg =3D <1>;
>                 endpoint {
>                     remote-endpoint =3D <&typec>;
>+                    data-lanes =3D <1 2>;
>+                    link-frequencies =3D /bits/ 64 <1620000000 270000000=
0
>+                                                  5400000000 8100000000>=
;
>                 };
>             };
>         };

--=20
With best wishes
Dmitry
