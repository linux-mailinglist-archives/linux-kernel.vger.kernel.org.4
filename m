Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D32718D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjEaVpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEaVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:45:28 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F38A3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:45:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-76c64da0e46so13500539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685569527; x=1688161527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T92knqTOJA3pNeL2xlDEkRB2bYKP1xzPES6uIiXRZts=;
        b=UYXuRfY6rtazLlTP14+hDXhNsSIyKSoa9k1F/8LKz9ezojRBq4OxYzCeCsibZ3ue8q
         mVcg1PjgKy/I28xHjOw/OladVNrV0PCinDuokoEzE4cmECfqP+N5PchWjh+5QCrrOtR7
         iSXD2axu1/aE8+qn9qygFU7x/TrN3OrtFMEes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685569527; x=1688161527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T92knqTOJA3pNeL2xlDEkRB2bYKP1xzPES6uIiXRZts=;
        b=JO1SEk3DgjbR6hv+QD7wClF9biuQDMEPOdlgYQ+OinJ1odKkFYN2byneaD4tlAw8M6
         2sZQLQggKLQ8f7LWGCkA7giSYQuVY5FnDIkazON8bIxVkr5EqNIQMiDJhoIGYtP2yqsi
         zimvLq/ZZAfFXe+jWJ9TCM9fqb8GI/a1nz6ka/hAy5ZNjcTRhEmp0vHLJtgb6gJM3mrh
         x3XZjZWmbDtP0CZQkU/Rlz/1dZZTQD6PgO/T9WpfWnV0UwLGrx9Dg59A9GJBzLWeLRNx
         z+zStf/hk1yY8HgQ0TKK+lMd6lrWEdh044fmye3G7UfVTLF65WY5Gmi4qogXYli5Tm+0
         LoTQ==
X-Gm-Message-State: AC+VfDyH3I43dLBN7INs7b48CwOtMzxOjNuMSdQtbe3OgGVaPzLqGGzd
        LrxV5mcI0ouU/xB72pk4MMlioO0u5zEaP6jL2Nc=
X-Google-Smtp-Source: ACHHUZ4D9dsAKQbbBsOaBv9sVdxJng8lqwirOBjsMilP14S8+FUXV33RwIBxEcBtIAkoET+uP7zlEA==
X-Received: by 2002:a5e:9416:0:b0:772:af3a:76b1 with SMTP id q22-20020a5e9416000000b00772af3a76b1mr4905832ioj.21.1685569526790;
        Wed, 31 May 2023 14:45:26 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id el26-20020a0566384d9a00b0040fa075e5e6sm1774967jab.102.2023.05.31.14.45.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 14:45:23 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-33baee0235cso18265ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:45:21 -0700 (PDT)
X-Received: by 2002:a05:6e02:188f:b0:33b:cea:ce70 with SMTP id
 o15-20020a056e02188f00b0033b0ceace70mr8358ilu.25.1685569520353; Wed, 31 May
 2023 14:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org> <f5875c10-21c1-43b6-4ce6-25b968588412@linaro.org>
In-Reply-To: <f5875c10-21c1-43b6-4ce6-25b968588412@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 May 2023 14:45:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Um8U2MQsrv+ngQg_h-aQMi5_yy6Lrj3ovr7eV1PC+Wnw@mail.gmail.com>
Message-ID: <CAD=FV=Um8U2MQsrv+ngQg_h-aQMi5_yy6Lrj3ovr7eV1PC+Wnw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Flush RSC votes properly on more RPMh platforms
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 31, 2023 at 7:26=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 31.05.2023 15:22, Konrad Dybcio wrote:
> > As pointed out in [1], the Linux implementation of RSC basically requir=
es
> > (even if not explicitly) that we point it to a power domain which
> > represents the power state of the CPUs. In an effort to fulfill that
> > requirement, make it required in bindings and hook it up on all platfor=
ms
> > where I was able to do. This means all RPMh platforms, except
> >
> > - SC7180
> > - SC7280
> > - SA8775
> >
> > As there wasn't an idle-states setup (which may be on purpose for CrOS
> > devices, certainly not for Windows SC7[12]80s) that I could validate.
> > (Doug, Bartosz, could you guys look into your respective platforms of
> > interest here?)
> >
> > This series also adds support for idle states on SM6350, as I was able
> > to add and test that.
> I noticed that 7280 is WIP:
>
> https://lore.kernel.org/lkml/20230424110933.3908-4-quic_mkshah@quicinc.co=
m/

Right. For sc7180 Chromebooks we don't use OSI (OS Initiated) mode but
instead use PC (Platform Coordinated) mode. As I understand it, that
means we take a different path through all this stuff.

That being said, in the sc7280 thread you pointed at, Bjorn and Ulf
said that we could use the new device tree snippets for sc7280 even
before the ATF update. If I'm reading the thread correctly and the
same applies to sc7180:

1. New DT plus firmware that doesn't support OSI - OK
2. New DT plus firmware that supports OSI - OK after code changes
3. Old DT plus firmware that doesn't support OSI - OK
4. Old DT plus firmware that supports OSI - Not OK

For sc7180 Chromebooks we'll never have firmware that supports OSI.
That means that, assuming I'm understanding correctly, we actually
could move the DT to represent things the new way. Presumably this
would be important for sc7180 devices that originally shipped with
Windows (I think support for one of these is underway).

-Doug
