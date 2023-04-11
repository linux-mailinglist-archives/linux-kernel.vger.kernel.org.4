Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934226DDFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjDKP1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjDKP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:27:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4835FCA;
        Tue, 11 Apr 2023 08:27:10 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3D3066003B8;
        Tue, 11 Apr 2023 16:26:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681226820;
        bh=DuGkoAGiYs0V4ZuV34Ydk4VOg6z3ZZ5l0Q7CdUd2bKI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XBoAHczzPa75ed6PpuM3+BMpOoazAOVCW8vLIYv73ETeE/5LY5xci6Squ07wwLnO8
         VgqDJJJ1PTAKoNJl4/iXFzP0wwieYJQYxVvqhvm5TXKGVL3w70c52hyBOKr14tj3sK
         G4IRhu246t4jW6cI/wLfH2ou8r9lfn8HUzKecfendQb1oZCvJUzfbxjm+cVE12RZV5
         Te2w6ISnHohnnv4N6KzqHwRPbVbw8cyT7hCIqYri37dK/oECWq4M2jQIGKBtLrJRfo
         8IzjoQGtO0SPVtf26TF7JfvEgawOx1oqfqrveV6C8dfu1AhD9AWBziD4LkmsWbbLvY
         yNfVb8mqjwqdA==
Message-ID: <ef815d11d8514f1d53bcb55d4acbcbac518cd603.camel@collabora.com>
Subject: Re: [PATCH v5 13/13] media: AV1: Make sure that bit depth in
 correctly initialize
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Tue, 11 Apr 2023 11:26:50 -0400
In-Reply-To: <20230330154043.1250736-14-benjamin.gaignard@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
         <20230330154043.1250736-14-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 30 mars 2023 =C3=A0 17:40 +0200, Benjamin Gaignard a =C3=A9crit=C2=
=A0:
> Make sure that bit_depth field of V4L2_CTRL_TYPE_AV1_SEQUENCE
> is initialized correctly before using it.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>=20
In v6, can you move this patch earlier ? I'm having bisection in mind. With=
 that
being said:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>=20
> ---
>  drivers/media/v4l2-core/v4l2-ctrls-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4=
l2-core/v4l2-ctrls-core.c
> index 9fd37e94db17..a662fb60f73f 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> @@ -111,6 +111,7 @@ static void std_init_compound(const struct v4l2_ctrl =
*ctrl, u32 idx,
>  	struct v4l2_ctrl_vp9_frame *p_vp9_frame;
>  	struct v4l2_ctrl_fwht_params *p_fwht_params;
>  	struct v4l2_ctrl_h264_scaling_matrix *p_h264_scaling_matrix;
> +	struct v4l2_ctrl_av1_sequence *p_av1_sequence;
>  	void *p =3D ptr.p + idx * ctrl->elem_size;
> =20
>  	if (ctrl->p_def.p_const)
> @@ -157,6 +158,10 @@ static void std_init_compound(const struct v4l2_ctrl=
 *ctrl, u32 idx,
>  		p_vp9_frame->flags |=3D V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING |
>  			V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING;
>  		break;
> +	case V4L2_CTRL_TYPE_AV1_SEQUENCE:
> +		p_av1_sequence =3D p;
> +		p_av1_sequence->bit_depth =3D 8;
> +		break;
>  	case V4L2_CTRL_TYPE_FWHT_PARAMS:
>  		p_fwht_params =3D p;
>  		p_fwht_params->version =3D V4L2_FWHT_VERSION;

