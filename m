Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C86E8266
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjDSUKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjDSUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:10:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D14C33;
        Wed, 19 Apr 2023 13:10:49 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7137B6603247;
        Wed, 19 Apr 2023 21:10:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681935048;
        bh=p6Bh6e7Qjn7BRm0mOG9dNdfJlWO9r4yzoXFJ/eJ0NLA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=StBvdoqAOlrplsSJyWzXdLylHd8PoDk0WZX0t7NOZfSaPPlvSygbXsF/lg2S+aCUl
         EjZRlkrCSC5KYrsaH/StH7w0yFe1Ixcjrpq62C52CQ5VeJtlJT/Pa28mv4Idy45jt1
         ySjCHuTDKukocIt+tMOF+6QYcGeVRpihONrUFnLGbVVQGM0d7dnsUFPFXfnzypCGKz
         cHD40EKWsTuDuNqLRKq3zjobxJh3Gu6Qr6zmJwMFcmviN+rYmCiAIHgpt9e87AGahn
         a9EPRJ+4vQZdzBysAvWRYmm3ByeJefq+O2NwlXX8q+m6F1bZY687sIlULnvti/645f
         ifTx9G6gq8BBw==
Message-ID: <511c900070050a5cac317279ee4208cdc1d8d1af.camel@collabora.com>
Subject: Re: [PATCH] media: uapi: HEVC: Add num_delta_pocs_of_ref_rps_idx
 field
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Date:   Wed, 19 Apr 2023 16:10:38 -0400
In-Reply-To: <20230418160717.743517-1-benjamin.gaignard@collabora.com>
References: <20230418160717.743517-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 18 avril 2023 =C3=A0 18:07 +0200, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> Some drivers firmwares parse by themselves slice header and need
> num_delta_pocs_of_ref_rps_idx value to parse slice header
> short_term_ref_pic_set().
> Use one of the 4 reserved bytes to store this value without
> changing the v4l2_ctrl_hevc_decode_params structure size and padding.
>=20
> This value also exist in DXVA API.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>=20

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

For the info, this is in preparation for MTK VCODEC HEVC driver. It makes o=
ur
API (hopefully) on par with DXVA, which has always been the goal, we simply
missed it during review.

regards,
Nicolas

> ---
>  .../userspace-api/media/v4l/ext-ctrls-codec-stateless.rst  | 7 +++++++
>  include/uapi/linux/v4l2-controls.h                         | 6 +++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-statel=
ess.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.r=
st
> index 3d8411acd5b8..92ce3e126929 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> @@ -2923,6 +2923,13 @@ This structure contains all loop filter related pa=
rameters. See sections
>        - ``poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
>        - PocLtCurr as described in section 8.3.2 "Decoding process for re=
ference
>          picture set": provides the index of the long term references in =
DPB array.
> +    * - __u8
> +      - ``num_delta_pocs_of_ref_rps_idx``
> +      - When the short_term_ref_pic_set_sps_flag in the slice header is =
equal to 0,
> +        it is the same than derived value NumDeltaPocs[RefRpsIdx]. It ca=
n be used to parse
> +        the RPS data in slice headers instead of skipping it with @short=
_term_ref_pic_set_size.
> +        When the value of short_term_ref_pic_set_sps_flag in the slice h=
eader is
> +        equal to 1, num_delta_pocs_of_ref_rps_idx shall be set to 0.
>      * - struct :c:type:`v4l2_hevc_dpb_entry`
>        - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
>        - The decoded picture buffer, for meta-data about reference frames=
.
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2=
-controls.h
> index 5e80daa4ffe0..7bf59a87a1bf 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -2385,6 +2385,9 @@ struct v4l2_ctrl_hevc_slice_params {
>   * @poc_st_curr_after: provides the index of the short term after refere=
nces
>   *		       in DPB array
>   * @poc_lt_curr: provides the index of the long term references in DPB a=
rray
> + * @num_delta_pocs_of_ref_rps_idx: same as the derived value NumDeltaPoc=
s[RefRpsIdx],
> + *				   can be used to parse the RPS data in slice headers
> + *				   instead of skipping it with @short_term_ref_pic_set_size.
>   * @reserved: padding field. Should be zeroed by applications.
>   * @dpb: the decoded picture buffer, for meta-data about reference frame=
s
>   * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
> @@ -2400,7 +2403,8 @@ struct v4l2_ctrl_hevc_decode_params {
>  	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
> -	__u8	reserved[4];
> +	__u8	num_delta_pocs_of_ref_rps_idx;
> +	__u8	reserved[3];
>  	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u64	flags;
>  };

