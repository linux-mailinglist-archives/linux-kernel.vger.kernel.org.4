Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A85F1C5D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJANgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJANgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:36:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3F97B1D0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:35:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b6so7459959ljr.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=CG8R/L4pPWym3ANx8yZmnov0YG/TUNdQM5EA24rS0E4=;
        b=AiqSXPtKbR4lSYpT8z/2+mby/RDCrwNw4LeuUaGBfhWKs4/FVypZkt/KC+/dlceUD1
         xdbaKkYeFJ/KVJwYMcSO5rWs4sLoD2IrrBMk4Hl+lte7fIRf9ciLCyrKe0Is4Em3bxeq
         i1kzXY6Fe30DJgrU4FhZNY91hyMJEOCwf6rw4NcbAuTZoHxNxmTnlv9/DsmjWkSe9PIC
         gDCbeNaWtazlOjim66oEyqQJD4bLpVU4sgYFTU4cdWMAcJ4ZW6yidoM3o6t5pEWs9k+v
         6iN85ji8JQe40GK4dG2oaZRsZNZY/RhJOkD41YaAHDaj7FH3bgg1PFRk1jEsTRMWom5r
         Y5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=CG8R/L4pPWym3ANx8yZmnov0YG/TUNdQM5EA24rS0E4=;
        b=INh4lJvcMoR2XUKXpQ0zGvpQJgsgR1Da9xapecvOB1p386/+jlXEAOzv4h5JoPxPLX
         WVILBfDGix8hBRDZgg0U472ItLZbdfpt5l5FSsMpzz/eft14r3MCvcY5dXCY7JjpFzQ1
         QmKFuAuDPr4JBSDVbug5ZIVh/7tqrfv9LALb3VTCt+AY+gwTvmUsCt1bxUPCKQz1SLG+
         wivWliuj9EFLyCfCxvS6cNy9c9oNZI3t0Qm/Jd2GalLYNwF+BaZ2UA95ql9hYrr5rUe3
         LWinje59d2L4EO6Lvv9IMsiiU6Z/UmI0Hpsv2dmnAsOHyw61ssIl3cUCT2RAK6ulr2Xm
         zB6g==
X-Gm-Message-State: ACrzQf0p/zyMFM3XfHsWs3fKwtVeAHaRRS2AsnyO9Vdu8gRBrgpfAdvx
        dtIYzYRXsryNUIUgx5dAYj9T34pk1WuCZQ==
X-Google-Smtp-Source: AMsMyM6UkHvBbcIhpUjgV6+jAN/oKUp5wj4L3+JZ4/qDnhRKerjqCD22VB4X7hYo6GNQ4bXmGscdYA==
X-Received: by 2002:a2e:a9a9:0:b0:26c:6ec5:290 with SMTP id x41-20020a2ea9a9000000b0026c6ec50290mr3891735ljq.186.1664631357680;
        Sat, 01 Oct 2022 06:35:57 -0700 (PDT)
Received: from [127.0.0.1] ([188.162.64.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512220400b0049473593f2csm762095lfu.182.2022.10.01.06.35.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Oct 2022 06:35:57 -0700 (PDT)
Date:   Fri, 30 Sep 2022 11:29:03 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Doug Anderson <dianders@chromium.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>
CC:     y@qualcomm.com, dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>
Subject: =?US-ASCII?Q?Re=3A_=5Bv5=5D_drm/msm/disp/dpu1=3A_add_suppo?= =?US-ASCII?Q?rt_for_dspp_sub_block_flush_in_sc7280?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAD=FV=UT-GmAOYrCBRU0bhGeXU=pOGDbk=Jq7JEk40tyEH0zLA@mail.gmail.com>
References: <1663157784-22232-1-git-send-email-quic_kalyant@quicinc.com> <CAD=FV=UT-GmAOYrCBRU0bhGeXU=pOGDbk=Jq7JEk40tyEH0zLA@mail.gmail.com>
Message-ID: <A446B5C0-1EAA-4A24-8E7B-3C0EB2024026@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 September 2022 19:13:20 GMT+03:00, Doug Anderson <dianders@chromium=
=2Eorg> wrote:
>Hi,
>
>On Wed, Sep 14, 2022 at 5:16 AM Kalyan Thota <quic_kalyant@quicinc=2Ecom>=
 wrote:
>>
>> Flush mechanism for DSPP blocks has changed in sc7280 family, it
>> allows individual sub blocks to be flushed in coordination with
>> master flush control=2E
>>
>> Representation: master_flush && (PCC_flush | IGC_flush =2E=2E etc )
>>
>> This change adds necessary support for the above design=2E
>>
>> Changes in v1:
>> - Few nits (Doug, Dmitry)
>> - Restrict sub-block flush programming to dpu_hw_ctl file (Dmitry)
>>
>> Changes in v2:
>> - Move the address offset to flush macro (Dmitry)
>> - Seperate ops for the sub block flush (Dmitry)
>>
>> Changes in v3:
>> - Reuse the DPU_DSPP_xx enum instead of a new one (Dmitry)
>>
>> Changes in v4:
>> - Use shorter version for unsigned int (Stephen)
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>> ---
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc=2Ec       |  2 +-
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog=2Ec |  5 +++-
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog=2Eh |  4 +++
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl=2Ec     | 35 ++++++++++++++++=
++++++++--
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl=2Eh     | 10 ++++++--
>>  5 files changed, 50 insertions(+), 6 deletions(-)
>
>Breadcrumbs: though this is tagged in the subject as v5 I think the
>newest version is actually "resend v4" [1] which just fixes the
>Signed-off-by=2E

Not to mention that v5 misses the S-o-B tag=2E

>
>[1] https://lore=2Ekernel=2Eorg/r/1663825463-6715-1-git-send-email-quic_k=
alyant@quicinc=2Ecom

--=20
With best wishes
Dmitry
