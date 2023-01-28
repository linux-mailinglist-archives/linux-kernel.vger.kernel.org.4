Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10E67F783
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjA1LXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjA1LXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:23:17 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C320D21
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:23:10 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id d66so7842426vsd.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOS2C+Pc5lRvy5tY8Ds1g0+sULUy/XgMmx38xtTIc5o=;
        b=ar2/Wb2oJ4e+gcNKm2vX3Ibo1Y0AwZXg/eyJ/KCKuGZjn9ISSK+9XG5OsGJKyu0RiG
         dWQcpPX3kpURUWFoZCLFAK84d2HtbyR5J4VMMma/BGVRdec+sLzvgYy2gZrp/0/L6GbM
         REFj+G8uBZrIy4cC2ArTm1QZZMtox/+uWl+gi0Fc7Nvr8CCavhkGz4JD7WQ8jxfEdfHJ
         MceYSaEZRLjtBYF424R3JgN4uOq/VL4x0EHwswXUJ8DxqYQRUWnXYzPNorp5Q1Yrp/Ie
         nUqJPv7CdKdIkNnmUrqY9RXPHLDr8gQ1P12gb0Xbk/XeeTDAf/96iefjDuHoe0Sl+oaG
         vBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOS2C+Pc5lRvy5tY8Ds1g0+sULUy/XgMmx38xtTIc5o=;
        b=CLKwtFO6qc15m9tdlBy/Aqji+Om8XagaRtuQ2oYBho1mmkG3NFU4GoRkYt+k+d5jZN
         xipDBG9hHtrMW3g4LXNNzRCXsvkTTPPW3FLv8VkKhHSa4xPRPsyNrPJwJA4CzXpRwzBm
         HDQkaHgyS3f4NexmEQHBE7ssh8feImCvX3bmExKto/AcZmwtHOaSTHs3JNvc3ZO3Z6YM
         nfcLE4/RIpsH2AmYpdzru9qvKnPw3U2zKCXqa38LNry/hQ91c64e23cHP2p20bVhZNUd
         fJNxasfWX6sM9Tq4lCcO4vydfMir0gEu++HfzFchmD9rDhxd8yM0QxZtYVHVsyTUrXCa
         zOUA==
X-Gm-Message-State: AO0yUKVKTmEtM5QkRcYgSCSI7cepJ9Y05gluYpwdQvWmV6iQQEz4yg5u
        BogXCLRtBuYjFI2ofu8HASbBYkeBDp36Z6DExMx1ZghgvRF3Nv5x
X-Google-Smtp-Source: AK7set9f2AlafEu+pnq1cQhww1WTz5nq7+zC/t0fzyBmIXjie2SP0/mWF4QJFiXIJTjPKBK5iXV3ACjUtWEY0FdTXZ4=
X-Received: by 2002:a05:6102:10c1:b0:3f2:58c2:5358 with SMTP id
 t1-20020a05610210c100b003f258c25358mr111725vsr.62.1674904989255; Sat, 28 Jan
 2023 03:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20230127192139.299228-1-brgl@bgdev.pl> <52508584-47c5-2497-68c8-2c0044911aca@linaro.org>
 <CACMJSevqcaqjLQJ6_5Xn=hMbrsjdxGVM=9RYwYQ8hW_Uy-tRzA@mail.gmail.com> <8dba267b-62b4-1085-c307-3d2608ae5857@linaro.org>
In-Reply-To: <8dba267b-62b4-1085-c307-3d2608ae5857@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 28 Jan 2023 12:22:58 +0100
Message-ID: <CAMRc=MeL_sGhbEagdqriPecxLXs_ecXSgo5_0zAEr226PG2J5Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: firmware: qcom,scm: add qcom,scm-sa8775p compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 11:13 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/01/2023 22:22, Bartosz Golaszewski wrote:
> > On Fri, 27 Jan 2023 at 20:56, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 27/01/2023 20:21, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> Add a compatible for the sa8775p platform's Secure Channel Manager
> >>> firmware interface.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>
> >> If you send bindings separately from DTS (which is fine), please provi=
de
> >> the link to the user - either DTS or driver for this compatible. Drive=
r
> >> does not use it, thus to the DTS.
> >>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >
> > Can you specify what kind of link you're expecting? I'm looking at
> > previous commits for this file and not seeing anything. There's no
> > upstream user of this compatible in any DTS yet.
>
>
> I expect lore link to the patchset you sent using this binding, so we
> can verify whether you used it correctly or not. If people were testing
> their DTS against bindings they write, this would not be needed.
> Unfortunately people do not do that...
>

Touch=C3=A9. I am making sure v2 passes dtbs_check though. :)

v1 didn't have this compatible and used the fallback directly, hence
this patch being sent before v2. There's no link yet, as I'm still
polishing the dts for sa8775p-ride. Will remember to add one in the
future.

Bart
