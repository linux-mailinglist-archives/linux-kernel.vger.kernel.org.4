Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41800748141
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjGEJnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjGEJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:43:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23CD1BE4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:43:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so1434777276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688550184; x=1691142184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7MA3dhvd5AQL536c1KKeikZR2ef4a702l13ckFaEQU=;
        b=L9AH5lj0kONmG34ZPW0ptGEiBwdlqQuyqM/IsSbc93Q5nr0T6/qlGWAa80g/d+6yAy
         2ul/m1wzuhzxVMvV4WbASw0NuZFyLOes66ES9RdZpR8c2oqH9+3wn1NraIlkwudWdyrJ
         y7herPZ0dA2jaNmIwaonrz2LV+/fU9NHJFwmU8S9IlyR69k7Uhdamd087eE6TvVIh+Lb
         Fz21pUZiM36QclWIQn8Egkg/nouVodeWZiB3DFmM6bx1ecSnxtCATq8QsN+/K86FLdyp
         OGeWVQ8iGGzbqGxFVatyJzCP3TcnJhUFIgqubk/I54LvgfXrJyINXYsBrlR10yIRnTmV
         pcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688550184; x=1691142184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7MA3dhvd5AQL536c1KKeikZR2ef4a702l13ckFaEQU=;
        b=g+OLM7QCPEE3yowKFSsMadAR0WcfaRkT1ZC22KyABEWh4QhiXpk/oDFwKqpTv+uuES
         wqFg6z3FrGPsNQEdeU9k8ARX31EoqVyCyj13c6z33XaAf8mCup56kVgT/P25BUdPEGVC
         yH3/e3JnNWaY/5zCdCwDclOEHaAzuMMcJtgtKLMlbzxL7uof/wMJf1wr3Xl2rTkJ4gEQ
         6iy90lRpGn4QxCf18G3ygD0glcMihSFGdkUea/glurp2oURvvYvlxCONAoWG6gwMzXKB
         Ypzn4FK1OalPRk8ad59V9aURtQ3ru8uxbmtBJ9LSegVD1K+l8LekAFBX2pxBT8l6c84L
         3hlA==
X-Gm-Message-State: ABy/qLZunjMExpbN3hQl+my1bM9qRU96HpI4oIwkZARDgqEHK9V3F5yb
        DTL7Vitdxb0uMPy62lqbw3xj4CtXTjO5MY9TYIM9QQ==
X-Google-Smtp-Source: APBJJlGsPWsHNOshbTpMsle8AZs1Y5nRfjdhbf4L3fxdfM8xWgQ1+olpaNfB03NugXn1ZHwq6FTapqx+BH5ktwKvzpk=
X-Received: by 2002:a25:e749:0:b0:bce:d4c:e6c9 with SMTP id
 e70-20020a25e749000000b00bce0d4ce6c9mr13110822ybh.45.1688550184751; Wed, 05
 Jul 2023 02:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230705053914.9759-1-quic_kbajaj@quicinc.com>
 <20230705053914.9759-2-quic_kbajaj@quicinc.com> <CAA8EJpo406gV-5H8+y4SJbbRqnWFRo5wrR6a9KJ2arbN61tS2Q@mail.gmail.com>
 <db283531-36a2-0535-4fe2-d1571b3fa8cb@quicinc.com>
In-Reply-To: <db283531-36a2-0535-4fe2-d1571b3fa8cb@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 5 Jul 2023 12:42:53 +0300
Message-ID: <CAA8EJpotQs_C_b+qvR1gXcasOtcw6SA8hCgJfuHFa7PnvPeobQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved memory region
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 at 10:06, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
>
>
> On 7/5/2023 11:19 AM, Dmitry Baryshkov wrote:
> > On Wed, 5 Jul 2023 at 08:40, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
> >> Add missing reserved regions as described in QDU1000 memory map.
> >>
> >> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 26 ++++++++++++++++++++++++
> >>   1 file changed, 26 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> >> index 1d22f87fd238..3f5512ec0a90 100644
> >> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> >> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> >> @@ -448,6 +448,32 @@ &qupv3_id_0 {
> >>          status = "okay";
> >>   };
> >>
> >> +&reserved_memory{
> >> +       #address-cells = <2>;
> >> +       #size-cells = <2>;
> >> +       ranges;
> >> +
> >> +       ecc_meta_data_reserved_mem:ecc_meta_data_reserved_region@e0000000{
> > no_underscores_in_node_names. Ever.
> >
> > Also, if you have checked other platforms, you'd have seen that other
> > platforms use a much more generic node name for 'memory' nodes (which
> > you should have used too).
>
> These memory nodes are new to QDU platform, so will it be okay if I keep
> these names without region suffix?

Just use 'memory@abcd'.

>
> Thanks
> Komal
>
> >
> >> +               no-map;
> >> +               reg = <0x0 0xe0000000 0x0 0x20000000>;
> >> +       };
> >> +
> >> +       harq_buffer_mem:harq_buffer_region@800000000{
> >> +               no-map;
> >> +               reg = <0x8 0x0 0x0 0x80000000>;
> >> +       };
> >> +
> >> +       tenx_sp_buffer_mem:tenx_sp_buffer_region@880000000{
> >> +               no-map;
> >> +               reg = <0x8 0x80000000 0x0 0x50000000>;
> >> +       };
> >> +
> >> +       fapi_buffer_mem:fapi_buffer_region@8d0000000{
> >> +               no-map;
> >> +               reg = <0x8 0xd0000000 0x0 0x20000000>;
> >> +       };
> >> +};
> >> +
> >>   &sdhc {
> >>          pinctrl-0 = <&sdc_on_state>;
> >>          pinctrl-1 = <&sdc_off_state>;
> >> --
> >> 2.40.1
> >>
> >
>


-- 
With best wishes
Dmitry
