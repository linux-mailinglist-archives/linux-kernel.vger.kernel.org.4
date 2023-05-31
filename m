Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD5718B75
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjEaUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEaUy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:54:29 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7FD12F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:54:27 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33be5dbb90cso215075ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685566466; x=1688158466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYHmPPdm4Dau+d947lCnpQiMGTh8x8NsQoxsSBGTC/s=;
        b=mdYzJbIV6Mtnb8aQ1f0qNHPdUKESB98kLk/H7BrrpULO4560BE/wpVTBPVwT6Vk8eB
         y4dFlO/OGMnaTuwYdNeoRKvb8/V0/4DS7hxmOtxOts/u0tBOBMsKYCc2YzYoauTozf5o
         CMiM+RLK1IOwy3dKUZvszmVEon1+19zDWNKYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685566466; x=1688158466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYHmPPdm4Dau+d947lCnpQiMGTh8x8NsQoxsSBGTC/s=;
        b=BaJl/fpqMkUr/aYitfBCJ1OiX4kW/XNOYqCjaS3Jdnk7oQneLDlQNSNl4WfwSyW6cg
         m8h1ezeOzpJIJDT9kP4rzA8UPGfvCUATfXuylLsBz3kxLK6knMH8aAZdOtsYiOFdKzZh
         JwLaPNdJRC2NRkVzbCZ3tSq1lUfMruMU6DyNDTBeWhz1qQH/GjDfHFBhLr+mQ6QcTtOo
         ICyNBjey01L2gUaDkU56KiuwJBppm5wm+jJ62FgZyoxUaYIZYcfxZW3X87J9OOn/HU6L
         e4oykPtLde2OxjrPTBH9Ex5pAK9jYLc4F/onhFQhDHz430SMvz/9zJITfShhE73C3Nfx
         Z1uA==
X-Gm-Message-State: AC+VfDxgx0rurmaSLw2G+3BsGtpbUoShzzI+jGV1J4IHGXX85Bzzr00X
        4nf5sNbI6RjFm9EzALSh1V0oYuNO5o1RF6mCkPk=
X-Google-Smtp-Source: ACHHUZ4EXoOyQMBm48JiEaPqcz5i6HCsnzGE2hdZC0KbfM65rFOuXto5O06B7Yin+IrOoE1mC/2f/A==
X-Received: by 2002:a92:cb05:0:b0:331:7c4f:54ec with SMTP id s5-20020a92cb05000000b003317c4f54ecmr2622340ilo.30.1685566466408;
        Wed, 31 May 2023 13:54:26 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id l18-20020a922812000000b0033b2a123254sm3054167ilf.61.2023.05.31.13.54.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 13:54:26 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so10405ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:54:25 -0700 (PDT)
X-Received: by 2002:a05:6e02:b42:b0:33a:e716:a76d with SMTP id
 f2-20020a056e020b4200b0033ae716a76dmr37485ilu.27.1685566153516; Wed, 31 May
 2023 13:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org> <20230531-topic-rsc-v1-6-b4a985f57b8b@linaro.org>
In-Reply-To: <20230531-topic-rsc-v1-6-b4a985f57b8b@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 May 2023 13:49:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vx9txUs4=b_enDMTBXuNsTGXO2v3KyauuD8k_J++vbfA@mail.gmail.com>
Message-ID: <CAD=FV=Vx9txUs4=b_enDMTBXuNsTGXO2v3KyauuD8k_J++vbfA@mail.gmail.com>
Subject: Re: [PATCH 6/8] arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes
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
        Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 31, 2023 at 6:22=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> The rpmh driver will cache sleep and wake votes until the cluster
> power-domain is about to enter idle, to avoid unnecessary writes. So
> associate the apps_rsc with the cluster pd, so that it can be notified
> about this event.
>
> Without this, only AMC votes are being commited.
>
> Fixes: c83545d95376 ("arm64: dts: sdm845: Add rpmh-rsc node")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index 950305aad44d..707550ef4990 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -5138,6 +5138,7 @@ apps_rsc: rsc@179c0000 {
>                                           <SLEEP_TCS   3>,
>                                           <WAKE_TCS    3>,
>                                           <CONTROL_TCS 1>;
> +                       power-domains =3D <&CLUSTER_PD>;

It would be good to confirm that this doesn't throw sdm845-cheza for a
loop. No sdm845 Chromebooks ever officially shipped, but some people
like Rob Clark still use the old boards in their CI farms. Adding him
here in case he wants to check. Worst case we could just delete the
property from the cheza device tree.

-Doug
