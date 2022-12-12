Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C844864A214
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiLLNte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiLLNtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:49:08 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B5CCED
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:48:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x28so18650539lfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9vmGewvmVsvWtk1srXkMrLshZOZrKuuaXy+rLbJllEw=;
        b=yBjeeh7XC/Ycgky9+3q2gHGbPBTT6qv2pqXHUzTNH72IhcxBmKa4B5JFkgIrJaI4QA
         WPnTaVDH0EWzi7lffttu8k3q01jg1dZs/tHupWbXC5wU/w+ewo/cndZ/ksN/jBK66cJj
         WdpYY70z6FLWlUVz8GnP2ICC3nFFY87xOCiHbYr1fOgg5irQgfiKwabmYXutAiqJMXwv
         1mxQk/u7f8ZUNGpUi5JunGJNNRZhFfpz2xs+VJQvhkAbR58ZXfXq1aWm7q+sZ78Pecu1
         Xtk0P6NefyIzDHIC0EEFQ+NBc++q6b5h46Ab9AiA/49/BAzcmHcqoIDkl41EuF45fzp9
         rJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vmGewvmVsvWtk1srXkMrLshZOZrKuuaXy+rLbJllEw=;
        b=eI8X7JGmRLAfh8RVKx2WENjXDF2erX5BiXreBJ5CAH26W41j6ex67jupKNdqQWPRGB
         pti3xrhscSllZvtIFblILOSQiq0MXAvW31YK29IFQwi2N0/FDTRaYPIu1ns5zETMcdF5
         sR8htkKj8t9oaQt8okfJzIr+2Thh0gxIQYs0FiHqt7w6A4TQi5njLNyIKSV/sb++km0p
         gddpFhauxlMIMayYVUZBOBrpAWZfdD0ZNQ4q/NQ8Sv2bK95KYrPxvXcxwjvs9wxqLymV
         VxhNqP2XXjNIUfNsJbbFNt9hf3WLEok5SDS01T4ahzEjhKCRn2j+lJefhUJYX3JzDNP9
         9OVg==
X-Gm-Message-State: ANoB5pmznI8Q3Puq9iwJxhYu2pf1eI6Q5N+zIFpjwWmLk1CZIv0cDLgy
        rSWr6UZHLXMlBDvTaaVjjiHlBg==
X-Google-Smtp-Source: AA0mqf49hsKO0sMaynnXt9t1lmDJ9PR8VaNZT0wO2lkRe2WB/lD/jYPLsjMyH03WAnI57kfvM+/TzQ==
X-Received: by 2002:a05:6512:3691:b0:4a4:68b9:60a0 with SMTP id d17-20020a056512369100b004a468b960a0mr3844469lfs.43.1670852910543;
        Mon, 12 Dec 2022 05:48:30 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id c8-20020ac25308000000b004b55075f813sm1625707lfh.227.2022.12.12.05.48.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:48:30 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:48:26 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_5/6=5D_arm64=3A_dts=3A_qcom?= =?US-ASCII?Q?=3A_sdm845=3A_move_sound_node_out_of_soc?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212100232.138519-5-krzysztof.kozlowski@linaro.org>
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org> <20221212100232.138519-5-krzysztof.kozlowski@linaro.org>
Message-ID: <7B64882E-CBFE-487A-83D5-BE267FD0B120@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 December 2022 13:02:31 GMT+03:00, Krzysztof Kozlowski <krzysztof=2Ek=
ozlowski@linaro=2Eorg> wrote:
>The sound node is not property of the soc, but rather board as it
>describes the sound configuration=2E  It also does not have unit address:
>
>  sdm845-shift-axolotl=2Edtb: soc@0: sound: {} should not be valid under =
{'type': 'object'}
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg>
>Reviewed-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>

Reviewed-by: Dmitry Baryshkov<dmitry=2Ebaryshkov@linaro=2Eorg>

>
>---
>
>Changes since v1:
>1=2E Add Rb tag=2E
>---
> arch/arm64/boot/dts/qcom/sdm845=2Edtsi | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845=2Edtsi b/arch/arm64/boot/dts=
/qcom/sdm845=2Edtsi
>index 8eeb3aa261d5=2E=2E5f1f7cb52c90 100644
>--- a/arch/arm64/boot/dts/qcom/sdm845=2Edtsi
>+++ b/arch/arm64/boot/dts/qcom/sdm845=2Edtsi
>@@ -3964,9 +3964,6 @@ lmh_cluster0: lmh@17d78800 {
> 			#interrupt-cells =3D <1>;
> 		};
>=20
>-		sound: sound {
>-		};
>-
> 		usb_1_hsphy: phy@88e2000 {
> 			compatible =3D "qcom,sdm845-qusb2-phy", "qcom,qusb2-v2-phy";
> 			reg =3D <0 0x088e2000 0 0x400>;
>@@ -5341,6 +5338,9 @@ wifi: wifi@18800000 {
> 		};
> 	};
>=20
>+	sound: sound {
>+	};
>+
> 	thermal-zones {
> 		cpu0-thermal {
> 			polling-delay-passive =3D <250>;

--=20
With best wishes
Dmitry
