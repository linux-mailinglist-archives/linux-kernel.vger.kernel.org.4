Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0690C6C90BC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 21:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCYUfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 16:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYUfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 16:35:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D8DF;
        Sat, 25 Mar 2023 13:35:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn12so21031674edb.4;
        Sat, 25 Mar 2023 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679776506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1ARdn1PQDKxucq06/tFLuIDSeh/ZkFUkEYqpy9v+YI=;
        b=pH8AJSa2OZdjUECVUw7QIahO0jCHHDPB/6B7XWY9Rk7I5ODhbjpOsLdNsC10g8TRn/
         7zhSm0eaTrLBmu4u/sTCXWMMqCFDGafwWrtKFXc93T0BGc0FPVEi7HpHpGUQ1IGq1TG2
         pZVMFpZFgjYT/COoHwcNvSx8H9Z2HPZf81qDyS24jF2zqiBphLpJ7wGkfgHzZOKb4o2F
         jQlEbalNZKJped9i4Oh9BwKW7yHt1u42odViX5zeZOWNPBc6zWKSqTVq1aZavSFGSxtJ
         Ho2gIYf/Ba+qoPD1TqZI+tBRiduHR5ya3CB/ZCsewNd6r4+O20+OhufgOfAxjnhZvAkX
         0fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679776506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1ARdn1PQDKxucq06/tFLuIDSeh/ZkFUkEYqpy9v+YI=;
        b=bmltE/ZAIpOp1SL43aEFij8VXTRTBgyd3HQv+ujeV4R01WQrLcpjgRMo0hr80tZM13
         p2HM1ZxJG5xgNUMCV+K8pXUc6jORcZcfUwD6FXwk+4+2F1dsCvcW1Iq3YdXAlFwxTwfP
         uEAIBwGJ6Vu3diiPPJ4g1oVE3nZMDGpW17hIvdgxPiK0R9jL00VtBvP5fPO8IONGYufv
         X5/9y9ZFRvYAuteHjN9XbdGnuQ9RggpeIHTrUlM6JF+MWl0i6DJJ7xlGCLXXKdUfXyM/
         i9lvtjWTccmmFt165zbmjJouZp6qdhil7CqXDFr0D9esezvCKiVaajwk4ZQedp7PnF7S
         R9uw==
X-Gm-Message-State: AAQBX9fXjfjvbAHx6oSdW4M5wmmxm/rNcarRffYDP1mXZM78a7J0fvZj
        yQfft0uLEKcor+B316edyoHyjUoQwENCQ0lLbK8=
X-Google-Smtp-Source: AKy350bYbpD7c2ADb4vQaKPIrSV+zp0QcmQXRPw8bGyWYE7vqIOhP36g4ZLROnxjRchNnfxAz3HVFeGxziYjGJkNjRE=
X-Received: by 2002:a17:907:a46:b0:920:3bf5:7347 with SMTP id
 be6-20020a1709070a4600b009203bf57347mr4301292ejc.0.1679776505699; Sat, 25 Mar
 2023 13:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230324145557.27797-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20230324145557.27797-1-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 25 Mar 2023 21:34:54 +0100
Message-ID: <CAFBinCDgMazKVC0psk9DLL2=XTV-GgYEocp9VuKiTnN2hxer2A@mail.gmail.com>
Subject: Re: [PATCH v3] firmware: meson_sm: populate platform devices from sm
 device tree data
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, jianxin.pan@amlogic.com,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        rockosov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 3:56=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> In some meson boards, secure monitor device has children, for example,
> power secure controller. By default, secure monitor isn't the bus in term=
s
> of device tree subsystem, so the of_platform initialization code doesn't
> populate its device tree data. As a result, secure monitor's children
> aren't probed at all.
>
> Run the 'of_platform_populate()' routine manually to resolve such issues.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
