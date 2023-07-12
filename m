Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C143750A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjGLOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGLOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:12:21 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AEACE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:12:20 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-55b8f1c930eso4645024eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689171139; x=1691763139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOmR3HPgZpwdiDoiCGjn6gQvqgkwXK8sFvjSjK57joo=;
        b=TSuX5Sj+piw3KU/86M0LOVL3oL6ObS26vu7JjbzF0gTd7zMLTWCQMiSdw+NfiiOj0t
         bJo8SEgYVAwdqKylNPpnT10Zb1OaVlGWg35wU7KmU9abnb5GPnzdv+yTJeZ7fSzKvMlE
         2Ol9w+DkJ2tQTYcHMaY48zZffkaNdoomskIJfJbJjHsAsFEUXdSuOnQiT2RCDzbP8dT6
         oPtPRqzOCpBH0f6Rnt4oSCRkuyrvrjWY9JLlIzzgfQwQZET1xDIuL20ZqSb7V+vDmG8X
         v4DH4K3Q8tvDPkqZDuPMloUb3cBkfLAWQwsOFVvQIQZ1StU+u1OK0NMeQQ91JXQmljK5
         kPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689171139; x=1691763139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOmR3HPgZpwdiDoiCGjn6gQvqgkwXK8sFvjSjK57joo=;
        b=RP1NSfgL3h/lXNLnXRUypvPlYTrm4bFOdKojNNP8PRJn3r3Y54BFZFepltej1l9RHx
         c+u5l/A8GsfaGzWa4jfQUgRXwDiXPDPWfdoFRM3S4pYw8Ag4DdziaKGbpuRCGkOfqCf3
         ScgmRsotB7Fxbo7hxlI1klitBaLItTZUVVQ4DwrkXhcn60Js6LCVP72TRlQlz0c9LADJ
         oFr05aj9kIZaMuiVMgOGP2M2WxDbn3J8iQwI4oh15E9+CmtAJd7HV8AJaJ44jmRRPV5z
         Rf8MDyvEFZXEzLFmfymnzyfpMHx1NDwSqdfRSG89swufRw2t/MA1vJ3PRpPGOewS83wZ
         pGaA==
X-Gm-Message-State: ABy/qLYBjVNephJYKLC6WuBWN2yRtlTqscOA0KFAfJPzIG3JLkPvYgoQ
        htDdOAEU93GnZmVGjG1K+yxTvM5kvsydIPdyB9/ayR0T
X-Google-Smtp-Source: APBJJlHnLqnDSnZ0yDdCq3DzEM/4arfXfZZS94ZJRzju+br5XnWi2BlOzHdMNCUYmtxW+gT67gSMTtyEn/LyS6z7kfY=
X-Received: by 2002:a4a:3518:0:b0:566:97a9:b73b with SMTP id
 l24-20020a4a3518000000b0056697a9b73bmr8119908ooa.2.1689171139105; Wed, 12 Jul
 2023 07:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230712083137.1080883-1-ricardo.canuelo@collabora.com>
In-Reply-To: <20230712083137.1080883-1-ricardo.canuelo@collabora.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 12 Jul 2023 10:12:08 -0400
Message-ID: <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: replace 1-element arrays with flexible arrays
To:     =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     alexander.deucher@amd.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 8:04=E2=80=AFAM Ricardo Ca=C3=B1uelo
<ricardo.canuelo@collabora.com> wrote:
>
> UBSAN complains about out-of-bounds array indexes on all 1-element
> arrays defined on this driver:
>
> UBSAN: array-index-out-of-bounds in /home/rcn/work/repos/kernelci/kernelc=
i-core/linux_kernel_mainline/drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwm=
gr/processpptables.c:1249:61
>
> Substitute them with proper flexible arrays.

+ Gustavo, Paulo

I haven't kept up with the flexible arrays stuff.  Is this equivalent
to a zero sized array?  We've been bitten by these kind of changes in
the past.  These structures define the layout of data in a rom image
on the board.  If the struct size changes, that could lead to errors
in the code that deals with these structures.

Alex

>
> Tested on an Acer R721T (grunt) Chromebook.
>
> Signed-off-by: Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>
> ---
>  drivers/gpu/drm/amd/include/pptable.h | 36 +++++++++++++++------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/=
include/pptable.h
> index 0b6a057e0a4c..a65e2807dc06 100644
> --- a/drivers/gpu/drm/amd/include/pptable.h
> +++ b/drivers/gpu/drm/amd/include/pptable.h
> @@ -473,14 +473,14 @@ typedef struct _ATOM_PPLIB_STATE_V2
>        /**
>        * Driver will read the first ucNumDPMLevels in this array
>        */
> -      UCHAR clockInfoIndex[1];
> +      __DECLARE_FLEX_ARRAY(UCHAR, clockInfoIndex);
>  } ATOM_PPLIB_STATE_V2;
>
>  typedef struct _StateArray{
>      //how many states we have
>      UCHAR ucNumEntries;
>
> -    ATOM_PPLIB_STATE_V2 states[1];
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_STATE_V2, states);
>  }StateArray;
>
>
> @@ -491,7 +491,7 @@ typedef struct _ClockInfoArray{
>      //sizeof(ATOM_PPLIB_CLOCK_INFO)
>      UCHAR ucEntrySize;
>
> -    UCHAR clockInfo[1];
> +    __DECLARE_FLEX_ARRAY(UCHAR, clockInfo);
>  }ClockInfoArray;
>
>  typedef struct _NonClockInfoArray{
> @@ -501,7 +501,7 @@ typedef struct _NonClockInfoArray{
>      //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
>      UCHAR ucEntrySize;
>
> -    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[1];
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_NONCLOCK_INFO, nonClockInfo);
>  }NonClockInfoArray;
>
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
> @@ -514,7 +514,8 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_R=
ecord
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Table
>  {
>      UCHAR ucNumEntries;                                                /=
/ Number of entries.
> -    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[1];             /=
/ Dynamically allocate entries.
> +    /* Dynamically allocate entries. */
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_Clock_Voltage_Dependency_Record, ent=
ries);
>  }ATOM_PPLIB_Clock_Voltage_Dependency_Table;
>
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
> @@ -530,7 +531,8 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Table
>  {
>      UCHAR ucNumEntries;                                                /=
/ Number of entries.
> -    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[1];                  /=
/ Dynamically allocate entries.
> +    /* Dynamically allocate entries. */
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_Clock_Voltage_Limit_Record, entries)=
;
>  }ATOM_PPLIB_Clock_Voltage_Limit_Table;
>
>  union _ATOM_PPLIB_CAC_Leakage_Record
> @@ -554,7 +556,8 @@ typedef union _ATOM_PPLIB_CAC_Leakage_Record ATOM_PPL=
IB_CAC_Leakage_Record;
>  typedef struct _ATOM_PPLIB_CAC_Leakage_Table
>  {
>      UCHAR ucNumEntries;                                                 =
// Number of entries.
> -    ATOM_PPLIB_CAC_Leakage_Record entries[1];                           =
// Dynamically allocate entries.
> +    /* Dynamically allocate entries. */
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_CAC_Leakage_Record, entries);
>  }ATOM_PPLIB_CAC_Leakage_Table;
>
>  typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
> @@ -569,7 +572,8 @@ typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
>  typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Table
>  {
>      UCHAR ucNumEntries;                                                 =
// Number of entries.
> -    ATOM_PPLIB_PhaseSheddingLimits_Record entries[1];                   =
// Dynamically allocate entries.
> +    /* Dynamically allocate entries. */
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_PhaseSheddingLimits_Record, entries)=
;
>  }ATOM_PPLIB_PhaseSheddingLimits_Table;
>
>  typedef struct _VCEClockInfo{
> @@ -581,7 +585,7 @@ typedef struct _VCEClockInfo{
>
>  typedef struct _VCEClockInfoArray{
>      UCHAR ucNumEntries;
> -    VCEClockInfo entries[1];
> +    __DECLARE_FLEX_ARRAY(VCEClockInfo, entries);
>  }VCEClockInfoArray;
>
>  typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
> @@ -593,7 +597,7 @@ typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Re=
cord
>  typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
>  {
>      UCHAR numEntries;
> -    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[1];
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record, entr=
ies);
>  }ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_VCE_State_Record
> @@ -605,7 +609,7 @@ typedef struct _ATOM_PPLIB_VCE_State_Record
>  typedef struct _ATOM_PPLIB_VCE_State_Table
>  {
>      UCHAR numEntries;
> -    ATOM_PPLIB_VCE_State_Record entries[1];
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_VCE_State_Record, entries);
>  }ATOM_PPLIB_VCE_State_Table;
>
>
> @@ -627,7 +631,7 @@ typedef struct _UVDClockInfo{
>
>  typedef struct _UVDClockInfoArray{
>      UCHAR ucNumEntries;
> -    UVDClockInfo entries[1];
> +    __DECLARE_FLEX_ARRAY(UVDClockInfo, entries);
>  }UVDClockInfoArray;
>
>  typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
> @@ -639,7 +643,7 @@ typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Re=
cord
>  typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table
>  {
>      UCHAR numEntries;
> -    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[1];
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record, entr=
ies);
>  }ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_UVD_Table
> @@ -658,7 +662,7 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Recor=
d
>
>  typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
>      UCHAR numEntries;
> -    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[1];
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_SAMClk_Voltage_Limit_Record, entries=
);
>  }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_SAMU_Table
> @@ -676,7 +680,7 @@ typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Recor=
d
>
>  typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Table{
>      UCHAR numEntries;
> -    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[1];
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_ACPClk_Voltage_Limit_Record, entries=
);
>  }ATOM_PPLIB_ACPClk_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_ACP_Table
> @@ -745,7 +749,7 @@ typedef struct ATOM_PPLIB_VQ_Budgeting_Record{
>  typedef struct ATOM_PPLIB_VQ_Budgeting_Table {
>      UCHAR revid;
>      UCHAR numEntries;
> -    ATOM_PPLIB_VQ_Budgeting_Record         entries[1];
> +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_VQ_Budgeting_Record, entries);
>  } ATOM_PPLIB_VQ_Budgeting_Table;
>
>  #pragma pack()
> --
> 2.25.1
>
