Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561536632C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbjAIVYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbjAIVYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:24:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F7120B8;
        Mon,  9 Jan 2023 13:22:45 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 790DE6602D68;
        Mon,  9 Jan 2023 21:22:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673299364;
        bh=ruDrM/DvJP4nnGR4ZDtqvKWlRdT0B6gOft+fqB0NEOA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UxhOU5xBu5ijuzxFAl8iFSnPR5KyT/eR2y858SCbbUAVp3yWP/c1M6SbVJi+7++X8
         hHc76Lh+ZAdS9IGcx5lpfX4UEl2dQ5ckMc5K/qhnOtf9P/PopUAQTPBX1OiqTYXt7a
         dCuSQSAPcQ7lbiqHSQWs1+5UJZu+yNTILBV0fXKeZljsehEAb96Jm0hH94+CY82dhd
         HmrzNWJlM6g8Kik9XQQi8HUWoFiMHNHkXJzQa4OLe6U3LmftodaT5RGy8gmiGtKTgE
         bcPd9KEkB1rBNMKe4SchN4nPGp6L2ej7EdJ8jUhBX+m3PbAJtm7vb6lPHWaTvXUAv/
         MbR7inZ8DDfTA==
Message-ID: <31940cd3086bc6e40f3eb9c7b923dd38131d37dd.camel@collabora.com>
Subject: Re: [PATCH] drivers/media/v4l2-core/v4l2-h264.c : add detection of
 null pointers
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Dong Chuanjian <chuanjian@nfschina.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sebastian.fricke@collabora.com,
        ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Jan 2023 16:22:33 -0500
In-Reply-To: <20221226061711.3988-1-chuanjian@nfschina.com>
References: <20221226061711.3988-1-chuanjian@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lundi 26 d=C3=A9cembre 2022 =C3=A0 14:17 +0800, Dong Chuanjian a =C3=A9c=
rit=C2=A0:
> Continue the program when the pointer assignment is successful.
>=20
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-cor=
e/v4l2-h264.c
> index 72bd64f65198..1163cd48ff33 100644
> --- a/drivers/media/v4l2-core/v4l2-h264.c
> +++ b/drivers/media/v4l2-core/v4l2-h264.c
> @@ -343,18 +343,19 @@ static const char *format_ref_list_b(const struct v=
4l2_h264_reflist_builder *bui
>  	int n =3D 0, i;
> =20
>  	*out_str =3D kmalloc(tmp_str_size, GFP_KERNEL);

Can't this patch be reduced to this ?

+	if (!*out_str)
+		return NULL;

>=20
>=20
> -
> -	n +=3D snprintf(*out_str + n, tmp_str_size - n, "|");
> -
> -	for (i =3D 0; i < builder->num_valid; i++) {
> -		int frame_num =3D builder->refs[reflist[i].index].frame_num;
> -		u32 poc =3D v4l2_h264_get_poc(builder, reflist + i);
> -		bool longterm =3D builder->refs[reflist[i].index].longterm;
> -
> -		n +=3D scnprintf(*out_str + n, tmp_str_size - n, "%i%c%c|",
> -			       longterm ? frame_num : poc,
> -			       longterm ? 'l' : 's',
> -			       ref_type_to_char(reflist[i].fields));
> +	if (*out_str !=3D NULL) {
> +		n +=3D snprintf(*out_str + n, tmp_str_size - n, "|");
> +
> +		for (i =3D 0; i < builder->num_valid; i++) {
> +			int frame_num =3D builder->refs[reflist[i].index].frame_num;
> +			u32 poc =3D v4l2_h264_get_poc(builder, reflist + i);
> +			bool longterm =3D builder->refs[reflist[i].index].longterm;
> +
> +			n +=3D scnprintf(*out_str + n, tmp_str_size - n, "%i%c%c|",
> +				       longterm ? frame_num : poc,
> +				       longterm ? 'l' : 's',
> +				       ref_type_to_char(reflist[i].fields));
> +		}
>  	}
> =20
>  	return *out_str;

