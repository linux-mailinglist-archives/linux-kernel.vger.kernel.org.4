Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299506B7A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCMOhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCMOht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:37:49 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FFC3A82
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:37:46 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s12so13262802qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678718265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9wviaciFaFNhJ1J1XpkBbRHYzGEiVtgdsNXSIrpY6o=;
        b=RUadHtB4q4XmlJP/jpGYauhtnbaAk96+dSVTznqUVLoJHGyvH0H/LxzuEM9m7LMWqf
         RV16aCBjH7tR1d47JjtjdQQZ/KyqRqyZCpUB3CHOy/3DH1nlnI/z+PZ4aZjja3JqzNuI
         jOcp6/LJ84Qo6wX3yuwePUjik8wAvxJ8eMlNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9wviaciFaFNhJ1J1XpkBbRHYzGEiVtgdsNXSIrpY6o=;
        b=n4rhnRcjFiGrC/2b7dADzdSDdFmyDvdNLwIUAjVbJz6DobzGzd51WNJb5o1v6mB6wQ
         7UWfdoww2brRYbMdgxlljpD2W7Yt/GTiRTpbojbMBvOgmOhk+FeM4GTK2mDu48MhcLz7
         Ovb9Y4pohNPARQtmqldvXBl5ygi80H+isVZ/m49VBZd/HdalgQSEGELeYMaAbX4oc3PJ
         JBFHbquPtASxZmrsfufq5NpxR4MVUrQhBygzqFiw1lI93Holn3CZlhfRCsbNW/51mzu1
         sOdmjoQYLDjdbWC+2y8i0Hn9n/2Uh/oayUZFGqNRKQ1TX3u6a/glt1yRxD5l5ailS15/
         0osw==
X-Gm-Message-State: AO0yUKXIgvUtDSXoCAsedJQKNOk4xlsZDHgHVJT7gQCo8kSI0JuCMoRX
        DzxP1gHpjej+VP/l3uUjhLyLOqPXWoYrD3a9abo=
X-Google-Smtp-Source: AK7set8sjZnrOJ9cx/DzBDtEw3QEYIK/M939sTUbYMf00KU8wyLrlFbdXOV9zJCTVy+PhrMFWZQ21w==
X-Received: by 2002:a05:622a:28b:b0:3bf:a87b:26ed with SMTP id z11-20020a05622a028b00b003bfa87b26edmr47972933qtw.1.1678718265117;
        Mon, 13 Mar 2023 07:37:45 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a0b5b00b0074230493ccfsm5420373qkg.73.2023.03.13.07.37.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 07:37:43 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5445009c26bso20293497b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:37:43 -0700 (PDT)
X-Received: by 2002:a81:af4f:0:b0:541:8ce6:b9ad with SMTP id
 x15-20020a81af4f000000b005418ce6b9admr3376649ywj.2.1678718263282; Mon, 13 Mar
 2023 07:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org> <20230312183622.460488-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312183622.460488-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Mar 2023 07:37:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Va7M=9LzPumUrk-U-XrN1va0Afnib5X-Bt8cfkU6SyNA@mail.gmail.com>
Message-ID: <CAD=FV=Va7M=9LzPumUrk-U-XrN1va0Afnib5X-Bt8cfkU6SyNA@mail.gmail.com>
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sc7280-herobrine-villager: correct
 trackpad supply
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Sun, Mar 12, 2023 at 11:36=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The hid-over-i2c takes VDD, not VCC supply.  Fix copy-pasta from other
> Herobrine boards which use elan,ekth3000 with valid VCC:
>
>   sc7280-herobrine-villager-r1-lte.dtb: trackpad@2c: 'vcc-supply' does no=
t match any of the regexes: 'pinctrl-[0-9]+'
>
> Fixes: ee2a62116015 ("arm64: dts: qcom: sc7280: Add device tree for herob=
rine villager")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Luckily it didn't matter since this regulator is always on, but good
to have things described properly.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
