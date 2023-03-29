Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747946CDAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjC2Ng5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC2Ng4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:36:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26C349F6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:36:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bi9so20225717lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680097012;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9t0Oxs5o529jLZnGAk7kSGCT9H5QuX2QCpk9jCjT158=;
        b=rv53BqeDOYXL7QYjJYKIRjaH0bQg0DOtF/1I57jYuJG/Ca7GKv6aAEc2CpLgBKDoHe
         FpZ66fx/5eM8XjTukY7b5gg3+mwxNq6NKxZ1cveygQhNLw/aQL/FmqADoy/nXQiYX5Kj
         abX2ZxB9qySnRzLNqDNPUFfXfQNVqHT7Mu2JBgns07RHXOXs/X/g0Yss0ru66IUYKlUo
         xIqjl5VHGJRYxVW2sLvAU2V90/RV0vYxakbXC/HzbEq9RmuvP+vWOLVJppC8v2Dg7r61
         kIWK5BE3ZeLX2v2GWqvXrSflFxVRnAgct+XD3zIuIAV76vEUIQF0BVhJiHIML6SK2Fmj
         eDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680097012;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9t0Oxs5o529jLZnGAk7kSGCT9H5QuX2QCpk9jCjT158=;
        b=eMLVsW+RC0UPBbB0+NQqsj/y9WXs2Uoprx6D2TddIvcvlcPYxeMYDU5grLTvMUvyCC
         vYuTzKsvqDXb2dpU/v5Spu+P7RZpphY5+ifzRXZQhMUrvBBfvMYBxHg6AcJPO8vt+pG8
         HUzUD4S2xnmNZC95Top5XglciIWQELe2w3xv7dSlInet8D5nq2AnnQoCB+rdn3d3RKK9
         PYeZ7UdHkOmFAhc6OIir7nYyT7x/tRtBnnWeYVWMR4kELRdO48pRLYIUUxqZm1U/EzKr
         XA8NIV9lh6BgMcY/lJcOpIkVvOBimLkQs3uLfqM23dywB/pn1QliYAlcDu8MR18OHJGH
         gT+g==
X-Gm-Message-State: AAQBX9e2QNogm3Q6aCopth6M49sRZ/HPXc9eWXLKH/jvgHyeKijnpH6T
        62/Pz0beqhIm2LMeXVpDXoB2gQ==
X-Google-Smtp-Source: AKy350aSNBnWsSycc2KOVvgOy7wVZZLhaPHIPkPzHRi2UrpSTxgIJtY+yHTb2NgmVQCqFs6+D1Miow==
X-Received: by 2002:a19:c50c:0:b0:4dd:840d:462 with SMTP id w12-20020a19c50c000000b004dd840d0462mr765030lfe.21.1680097012016;
        Wed, 29 Mar 2023 06:36:52 -0700 (PDT)
Received: from [127.0.0.1] (85-76-160-246-nat.elisa-mobile.fi. [85.76.160.246])
        by smtp.gmail.com with ESMTPSA id f24-20020ac251b8000000b004eb15952669sm737164lfk.141.2023.03.29.06.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 06:36:51 -0700 (PDT)
Date:   Wed, 29 Mar 2023 16:36:45 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        andersson@kernel.org, konrad.dybcio@linaro.org
CC:     quic_dikshita@quicinc.com, Viswanath Boma <quic_vboma@quicinc.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_venus=3A_Enable?= =?US-ASCII?Q?_sufficient_sequence_change_s?= =?US-ASCII?Q?upport_for_sc7180_and_fix_for_Decoder_STOP_command_issue=2E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9f5bce7e-2b8a-0b71-3a80-0b4f86d9f908@quicinc.com>
References: <20230323130153.8229-1-quic_vboma@quicinc.com> <c611c390-2cf3-2abe-82aa-67538b823d62@linaro.org> <9f5bce7e-2b8a-0b71-3a80-0b4f86d9f908@quicinc.com>
Message-ID: <E98548DB-5085-4036-9F6C-DC22A604A0C2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2023 =D0=B3=2E 10:48:23 GMT+03:00, Vikash=
 Garodia <quic_vgarodia@quicinc=2Ecom> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>On 3/29/2023 3:49 AM, Dmitry Baryshkov wrote:
>> On 23/03/2023 15:01, Viswanath Boma wrote:
>>> For VP9 bitstreams, there could be a change in resolution at interfram=
e,
>>> for driver to get notified of such resolution change,
>>> enable the property in video firmware=2E
>>> Also, EOS handling is now made same in video firmware across all V6 SO=
Cs,
>>> hence above a certain firmware version, the driver handling is
>>> made generic for all V6s
>>=20
>> Having "Do abc=2E Also do defgh=2E" is a clear sign that this patch sho=
uld be split into two=2E
>
>I agree, it could have split into patches=2E The patch introduces way to =
store venus firmware
>
>version and take some decision for various version=2E For ex=2E here STOP=
 handling and enabling
>
>DRC event for specific firmware revision and onwards=2E Since both the ha=
ndling was primarily
>
>dependent of firmware version, and since the handlings were smaller, it w=
as combined as single
>
>patch=2E Let me know, if you have any further review comments, else, will=
 raise a new version with
>
>2 patches probably=2E

Thanks!

>
>>>=20
>>> Signed-off-by: Vikash Garodia <vgarodia@qti=2Equalcomm=2Ecom>
>>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc=2Ecom>
>>> Tested-by: Nathan Hebert <nhebert@chromium=2Eorg>
>>> ---
>>> Since v3 : Addressed comments to rectify email address=2E
>>>=20
>>> =C2=A0 drivers/media/platform/qcom/venus/core=2Eh=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 18 ++++++++++++++++++
>>> =C2=A0 drivers/media/platform/qcom/venus/hfi_cmds=2Ec=C2=A0=C2=A0 |=C2=
=A0 1 +
>>> =C2=A0 drivers/media/platform/qcom/venus/hfi_helper=2Eh |=C2=A0 2 ++
>>> =C2=A0 drivers/media/platform/qcom/venus/hfi_msgs=2Ec=C2=A0=C2=A0 | 11=
 +++++++++--
>>> =C2=A0 drivers/media/platform/qcom/venus/vdec=2Ec=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 12 +++++++++++-
>>> =C2=A0 5 files changed, 41 insertions(+), 3 deletions(-)
>>>=20

(Skipped)



>>> @@ -671,6 +671,16 @@ static int vdec_set_properties(struct venus_inst =
*inst)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* Enabling sufficient sequence change supp=
ort for VP9 */
>>> +=C2=A0=C2=A0=C2=A0 if (of_device_is_compatible(inst->core->dev->of_no=
de, "qcom,sc7180-venus")) {
>>=20
>> Let me repeat my question from v3:
>>=20
>> Is it really specific just to sc7180 or will it be applicable to any
>> other platform using venus-5=2E4 firmware?
>
>The HFI "HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT" is im=
plemented
>
>only for sc7180=2E Calling this for any other venus-5=2E4 would error out=
 the session with error as
>
>unsupported property from firmware=2E


How can we be sure that other platforms do not end up using sc7180 firmwar=
e? Or that sc7180 didn't end up using some other firmware?

I see generic  qcom/venus-5=2E4/venus=2Embn in Linux firmware=2E It's vers=
ion is VIDEO=2EVE=2E5=2E4-00053-PROD-1=2E It can be used with any unfused d=
evice which uses firmware 5=2E4

>
>>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_fw_rev_or_newer(ins=
t->core, 5, 4, 51)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pt=
ype =3D HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D hfi_session_set_property(inst, ptype, &en);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (ret)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptype =3D HFI_PROPERTY_PARAM_VDEC_CONCE=
AL_COLOR;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conceal =3D ctr->conceal_color & 0xffff=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conceal |=3D ((ctr->conceal_color >> 16=
) & 0xffff) << 10;
>>=20

