Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884B36C72BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCWWJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjCWWJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:09:01 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC5C1F92D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:09:00 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-544b959a971so398787b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679609337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApAT3jYclJ6tuM4Ar5bjYfOiqAXLl2HW8ed0MpHOtvE=;
        b=m+DwhZDVXHVwX1qyHNU6dFSrO+1jD/zZCGm2dvuoW5IfwY9tr6P8LFAPbJ6Rxyt3Ok
         TMeMcfOV49NreKzQuP+//Bx0exsKnTczPf5DFinUDHfqyuLt57npsZT/GYgdtNGyqVSz
         t1ZQ7QUftT1/vUwsrJcIQ+zb7c/GXOwRAyfXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679609337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApAT3jYclJ6tuM4Ar5bjYfOiqAXLl2HW8ed0MpHOtvE=;
        b=HiEADdG29yESAhcpYpRM0993BWa5VytVT7qWC/GFDQrDe4PjZHmcjYph0n0nIoufAh
         43wAnZBF5byyWeEbk5fWceTxKRGkQhpyRPRd+J61S0slz6N6MbYyIvPaPZRuTH9pNx3t
         o1ulJvs/URGvKQ9YYXX6/pdLoVOKcW5wiUBqrFUU61sRnm8uJZ8FjkcPKb7dub3cF17l
         YpbLFFAZ/JmxGb8gEkwpBEgTIMGm0YC2TAXlV84u/kqDTOhoj8WtIrVfbu8Vl/0t9c2T
         mqShte/4TP962uHemvwEvoqtQ5tejIpzQo1Jko+wRiOG7r6FLwQhWE3oK9/HVrxNyVyp
         SAMA==
X-Gm-Message-State: AAQBX9esGL0NMQUDvN3R3g6hh4BuP0iq5rboudva/RGgpVEYzlzueVzK
        8aqLm42VbUNLpcurWFzyRznBk6ntt/n96P60F+Q=
X-Google-Smtp-Source: AKy350a+P09PsuqT4hTPGM7ChT9N85wBD50gwbkzYt/AzcCzwLKZM8lfpRElC8y/Q7ztazbsmiwB9w==
X-Received: by 2002:a81:6889:0:b0:544:69f5:fadc with SMTP id d131-20020a816889000000b0054469f5fadcmr143528ywc.6.1679609337321;
        Thu, 23 Mar 2023 15:08:57 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id p184-20020a81b1c1000000b00545a08184bbsm70299ywh.75.2023.03.23.15.08.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 15:08:56 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-541a05e4124so562297b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:08:56 -0700 (PDT)
X-Received: by 2002:a81:b387:0:b0:545:5f92:f7ee with SMTP id
 r129-20020a81b387000000b005455f92f7eemr53774ywh.2.1679609335803; Thu, 23 Mar
 2023 15:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce@eucas1p1.samsung.com>
 <20230323220518.3247530-1-m.szyprowski@samsung.com>
In-Reply-To: <20230323220518.3247530-1-m.szyprowski@samsung.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Mar 2023 15:08:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WfREMuL6Z-aseAWPKXqpkutPofrWGy4ySH-WgbTHC-fg@mail.gmail.com>
Message-ID: <CAD=FV=WfREMuL6Z-aseAWPKXqpkutPofrWGy4ySH-WgbTHC-fg@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
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

On Thu, Mar 23, 2023 at 3:05=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Restore synchronous probing for 'qcom,pm8150-rpmh-regulators' because
> otherwise the UFSHC device is not properly initialized on QRB5165-RB5
> board.
>
> Fixes: ed6962cc3e05 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for driver=
s between 4.14 and 4.19")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't object to this patch landing temporarily, but can you provide
any more details, please? On Qualcomm Chromebooks I'm not seeing any
issues with RPMH regulators probing asynchronously, so I can only
assume that there's a bug in the UFSHC driver that's being tickled.

-Doug
