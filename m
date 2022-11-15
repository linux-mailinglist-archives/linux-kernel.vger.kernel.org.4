Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39AC629C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiKOO3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKOO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:29:34 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB453BCE;
        Tue, 15 Nov 2022 06:29:33 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id p27-20020a056830319b00b0066d7a348e20so4607565ots.8;
        Tue, 15 Nov 2022 06:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YtBjd5U7Z4dTCeEF5mRs9dqAb2tBqOFIzxlotygUWsI=;
        b=UbDmeL2Egx+Mh0V06TI5gyHyoopyFExt4xM+IivRUp8/PPz6WnNm1L0/uujCqzwEKl
         6ZbA3pRjszKvVUXCNLcq9KYtUHVC3DgwzKJY0c5cAQ9Ec3xYzLBRI4z4fcw1Sgx92A9T
         VHAewMwEzH7onmwHNXu+2NpyXeBGVL51i7M8zHkfI+knvg85jgHoOMFioxO8GjKTnuoy
         7mAvE0aDMThpyyxpmurxQHnVsfeSDdbsujA8RlVy2AmvcYvqtqk1+zk7zaawjI0m54HV
         O7uNpKRRyDUgg4Ks1erMvJ18as2WI/yj1QhzuMb/9tCP2UNaf7uPsqSgoDAsh1t/E/NB
         ntRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtBjd5U7Z4dTCeEF5mRs9dqAb2tBqOFIzxlotygUWsI=;
        b=cr3YMMWbNvlENHecYJuDUF629Xr3aLcIIXgiGqq2r0fIh6xJFZM9oo/eTMRJfdF25r
         6Xco344R+bcwy3E+ziS5YtU3vXcKYN63ebHmUmA5tnogb8efzOiSeqj8PHkQai7oMrRJ
         MaihZUG78OzTXxsKqElfEV7TpZu/BB3Nic5ua7/RDDlZw0XRez9SVjWPQQuDaggAFNcB
         roNM6HXr0ESMkWFEKRXIor/EE0mdEmR6tjzTPbNOWcJ2vzD0DS+J2xswT8dfHD87GByT
         H3Nfu7DeW26tAgVvW+Ia+JfpyGxBzckgUpt7PCLg7JRZVzMQlqvxOxxBCDrZl8lMwgkL
         9Ivw==
X-Gm-Message-State: ANoB5pkqMT9lEdIYvWBuPcXux5Do4VgRlYJpqHdS4gC2UioHNVKPCFOp
        jiP6cRHFEuX3CLdHLsjSMoy4PTWzJaG1ztgR0NI=
X-Google-Smtp-Source: AA0mqf4oytRI4UtYdcHoBBqKQMpel6k+O4QaJylBxHl9qdx+9fAzQwD/KWuhlyO4SRWrNTanEsR3rFV6UbvC5l13RJ0=
X-Received: by 2002:a05:6830:40af:b0:66c:6afa:5006 with SMTP id
 x47-20020a05683040af00b0066c6afa5006mr8974706ott.233.1668522573087; Tue, 15
 Nov 2022 06:29:33 -0800 (PST)
MIME-Version: 1.0
References: <Y3CgReK3e519a7bs@mail.google.com>
In-Reply-To: <Y3CgReK3e519a7bs@mail.google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Nov 2022 09:29:21 -0500
Message-ID: <CADnq5_PhL5DgHRrKbcniKuk064kJerT_Nau7kD2dGKCv3Mc3fQ@mail.gmail.com>
Subject: Re: [PATCH] [next] drm/amdgpu: Replace one-elements array with
 flex-array members
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Slark Xiao <slark_xiao@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks.

Alex

On Sun, Nov 13, 2022 at 2:44 AM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in structs ATOM_I2C_VOLTAGE_OBJECT_V3,
> ATOM_ASIC_INTERNAL_SS_INFO_V2, ATOM_ASIC_INTERNAL_SS_INFO_V3,
> and refactor the rest of the code accordingly.
>
> Important to mention is that doing a build before/after this patch
> results in no functional binary output differences.
>
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/238
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
>
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Binary difference findings:
>
>         Some changes took more than a single line which changed the line
>         number parameter passed to the drm_dbg function (which leverages
>         kernel's dynamic debugging). Functionally-wise, nothing changed
>         after doing a before/after patch build.
>
> ---
>  .../gpu/drm/amd/display/dc/bios/bios_parser.c | 22 ++++++++++++-------
>  drivers/gpu/drm/amd/include/atombios.h        |  6 ++---
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> index 6b9e64cd4379..a1a00f432168 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -665,8 +665,9 @@ static enum bp_result get_ss_info_v3_1(
>         if (!DATA_TABLES(ASIC_InternalSS_Info))
>                 return BP_RESULT_UNSUPPORTED;
>
> -       ss_table_header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
> -               DATA_TABLES(ASIC_InternalSS_Info));
> +       ss_table_header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
> +                               DATA_TABLES(ASIC_InternalSS_Info),
> +                               struct_size(ss_table_header_include, asSpreadSpectrum, 1)));
>         table_size =
>                 (le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
>                                 - sizeof(ATOM_COMMON_TABLE_HEADER))
> @@ -1032,8 +1033,10 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
>         if (!DATA_TABLES(ASIC_InternalSS_Info))
>                 return result;
>
> -       header = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
> -               DATA_TABLES(ASIC_InternalSS_Info));
> +       header = ((ATOM_ASIC_INTERNAL_SS_INFO_V2 *) bios_get_image(
> +                               &bp->base,
> +                               DATA_TABLES(ASIC_InternalSS_Info),
> +                               struct_size(header, asSpreadSpectrum, 1)));
>
>         memset(info, 0, sizeof(struct spread_spectrum_info));
>
> @@ -1712,8 +1715,10 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
>         if (!DATA_TABLES(ASIC_InternalSS_Info))
>                 return 0;
>
> -       header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
> -                       DATA_TABLES(ASIC_InternalSS_Info));
> +       header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V2 *) bios_get_image(
> +                               &bp->base,
> +                               DATA_TABLES(ASIC_InternalSS_Info),
> +                               struct_size(header_include, asSpreadSpectrum, 1)));
>
>         size = (le16_to_cpu(header_include->sHeader.usStructureSize)
>                         - sizeof(ATOM_COMMON_TABLE_HEADER))
> @@ -1749,8 +1754,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
>         if (!DATA_TABLES(ASIC_InternalSS_Info))
>                 return number;
>
> -       header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
> -                       DATA_TABLES(ASIC_InternalSS_Info));
> +       header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
> +                               DATA_TABLES(ASIC_InternalSS_Info),
> +                               struct_size(header_include, asSpreadSpectrum, 1)));
>         size = (le16_to_cpu(header_include->sHeader.usStructureSize) -
>                         sizeof(ATOM_COMMON_TABLE_HEADER)) /
>                                         sizeof(ATOM_ASIC_SS_ASSIGNMENT_V3);
> diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
> index 60c44a8a067f..4dc738c51771 100644
> --- a/drivers/gpu/drm/amd/include/atombios.h
> +++ b/drivers/gpu/drm/amd/include/atombios.h
> @@ -5146,7 +5146,7 @@ typedef struct  _ATOM_I2C_VOLTAGE_OBJECT_V3
>     UCHAR  ucVoltageControlOffset;
>     UCHAR  ucVoltageControlFlag;              // Bit0: 0 - One byte data; 1 - Two byte data
>     UCHAR  ulReserved[3];
> -   VOLTAGE_LUT_ENTRY asVolI2cLut[1];         // end with 0xff
> +   VOLTAGE_LUT_ENTRY asVolI2cLut[];         // end with 0xff
>  }ATOM_I2C_VOLTAGE_OBJECT_V3;
>
>  // ATOM_I2C_VOLTAGE_OBJECT_V3.ucVoltageControlFlag
> @@ -6679,7 +6679,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO
>  typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V2
>  {
>    ATOM_COMMON_TABLE_HEADER         sHeader;
> -  ATOM_ASIC_SS_ASSIGNMENT_V2        asSpreadSpectrum[1];      //this is point only.
> +  ATOM_ASIC_SS_ASSIGNMENT_V2        asSpreadSpectrum[];      //this is point only.
>  }ATOM_ASIC_INTERNAL_SS_INFO_V2;
>
>  typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V3
> @@ -6701,7 +6701,7 @@ typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V3
>  typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
>  {
>    ATOM_COMMON_TABLE_HEADER         sHeader;
> -  ATOM_ASIC_SS_ASSIGNMENT_V3        asSpreadSpectrum[1];      //this is pointer only.
> +  ATOM_ASIC_SS_ASSIGNMENT_V3        asSpreadSpectrum[];      //this is pointer only.
>  }ATOM_ASIC_INTERNAL_SS_INFO_V3;
>
>
> --
> 2.37.3
>
