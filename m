Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDB16DB121
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDGRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDGRGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:06:53 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA8BBB9A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:06:50 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54c0c86a436so105915627b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680887209; x=1683479209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PknBLQO8vOON8ZMbgv3ZPHDYv/9jVJsUcCHNnbarICw=;
        b=mhZ41LYuSKatBbr8SfXNoj8r0a12y7d3dnPoFeiq0J/fssIcJ/Ib1G1VlCfnZu6gbI
         wNedNKIAXDp+0m19pKbwDXAUm3ieSMHqc1S4HzSyj71Q+dJErLS671pxskk8IAnf50q6
         kfXvlHw9waP9AJdJwLf/9ABY3oydGh8DUH+iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887209; x=1683479209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PknBLQO8vOON8ZMbgv3ZPHDYv/9jVJsUcCHNnbarICw=;
        b=A/AWD986In3QbYYdguRMu5hb3EUhFJoFG7FMVL71Ry1epfa/NzdKpcCPxOo+wMERWU
         PMN25ft9hyjOgR98JbfTxz+ztdcj3mK7cwA4pmDzWiZqsAoLe6c7gIBR/rIE/vpLNxFz
         KUQvB1kDk72Or11dYziD6dtBnCyOgRc1gSTjUWDJZ3T7Mwu/gMq6Z2PZlOjCsORPFHNL
         RkzOjuQ/85RABoFw23CJBtU7j4sLoGiq1Zdktkk1kP95MOc5zgQiTrNGBb7VbC01nKAc
         Ox6ymw2yKUgtQL86FgUC8N0m1KTcq6nOg7l3Pt139HeMyc/ZPvwoqq5OrrZjOqV2nTuJ
         Cn2Q==
X-Gm-Message-State: AAQBX9cfqw/+hbyl90r7X7qrRCV0V7guRHvEa3embo6LyfxKJM2JjsmK
        LqVYDB++evLgGdzdMHWYBkzvzQeisoFguRezAuQ=
X-Google-Smtp-Source: AKy350az6FkgJZhYD/Cs4J++Bzc1Ip+lQwTvQtEkKCdarpnCpun75awbFuxS+rAw/+Zy1kR+dZoMhQ==
X-Received: by 2002:a81:53d6:0:b0:543:6327:8d63 with SMTP id h205-20020a8153d6000000b0054363278d63mr2348595ywb.2.1680887209450;
        Fri, 07 Apr 2023 10:06:49 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id x206-20020a0dd5d7000000b00545a08184d6sm1116636ywd.102.2023.04.07.10.06.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 10:06:45 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id h198so5832107ybg.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:06:45 -0700 (PDT)
X-Received: by 2002:a25:7416:0:b0:a67:c976:c910 with SMTP id
 p22-20020a257416000000b00a67c976c910mr1789187ybc.7.1680887204825; Fri, 07 Apr
 2023 10:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230407151423.59993-1-nikita@trvn.ru> <20230407151423.59993-5-nikita@trvn.ru>
 <CAD=FV=UCJoz1E4wErJawQjpBRiXw0C0-J4TTWO1+uRiDsdzSUg@mail.gmail.com> <499bbd8cb7783b86108f3e6d9cc07a8a@trvn.ru>
In-Reply-To: <499bbd8cb7783b86108f3e6d9cc07a8a@trvn.ru>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Apr 2023 10:06:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VR7sKsquE25eF7joc7gPApu-vqwduZzjE=wFCoXjMYnQ@mail.gmail.com>
Message-ID: <CAD=FV=VR7sKsquE25eF7joc7gPApu-vqwduZzjE=wFCoXjMYnQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: Add Acer Aspire 1
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
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

On Fri, Apr 7, 2023 at 9:46=E2=80=AFAM Nikita Travkin <nikita@trvn.ru> wrot=
e:
>
> > HPD might very well be hooked up on your board, but the current Linux
> > ti-sn65dsi86 driver does not look at its own HPD line because it's
> > actually slower than just pretending that HPD isn't there. On trogdor
> > boards we ended up routing HPD to a GPIO.
> >
>
> Oh, this makes so much sense then! The line is hooked up on
> the board indeed and I remember being confused why trogdor boards
> don't use it.
>
> I will try to add the suggestions (annotating the reason)
> and verify that it works, would prefer the panel power to be
> gated when possible. I hope this would also fix the initial
> EDID reading issues I occasionally have and carry a hack for
> as of now...
>
> Thank you a lot for this insight!
>
> Nikita
>
> > I guess your other option would be to implement HPD support in
> > ti-sn65dsi86. That would probably be an overall slower boot for you,
> > but is technically more correct. In the past people have posted up
> > patches to get ti-sn65dsi86 working as a full DP port and they added
> > HPD support for that, but none of those patch series ever go to the
> > point of landing...

Yeah, see the big comment in ti_sn65dsi86_enable_comms().

Actually, looking at how the code has evolved in the meantime, you
could probably get away with:

1. Making sure you have an "hpd-absent-delay-ms" in the device tree
for the panel.

2. Implement "wait_hpd_asserted" in ti-sn65dsi86 to simply be a msleep
with the passed in delay.

Then I think you don't need "no-hpd" anywhere which keeps the device
tree pretty.


-Doug
