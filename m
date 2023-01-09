Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39A36632D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjAIV1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjAIV1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:27:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5AFF55;
        Mon,  9 Jan 2023 13:27:40 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D21446602D68;
        Mon,  9 Jan 2023 21:27:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673299659;
        bh=o3DMSt1Ot2XXOL0bLV4Le+gFHG5Qw9UAoA+XB/anXbE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z2/2APEpGTaq+zXXShUb9nDM4nYcStKcnqYguBnfDgZbaFtXwo8oOBw4EWhFUgIc6
         QiP5F7TYoUyWK6bvkqnAJYLnj70+NJuvmLfld4i/8t7IygKvVktK6U9JrCeLXPBjTs
         n9UOELkStOaZpjHm5hIOhLMnBIpiMvoLTenYVNsRVuzpXV3Ahk330G+uJhuEXF4KI3
         MweGdNwQaLtJfBNls6wnTyaGLZIXKMAUaPLjslHpQgnj5XTHj3hUD7ThzGdebviVx8
         t1TrSZTeK9IwhU/dH/+SOD/nDehXUbAA4XvRmTmLstcfLVq8wHnWOH4pKUADLj35mg
         sZHFpl7oL0K3g==
Message-ID: <8b408632218fd0f06ec862a51822cf08e0f50a57.camel@collabora.com>
Subject: Re: [PATCH] drivers/media/v4l2-core/v4l2-h264 : add detection of
 null pointers
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Dong Chuanjian <chuanjian@nfschina.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sebastian.fricke@collabora.com,
        ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Jan 2023 16:27:29 -0500
In-Reply-To: <20221227023625.7261-1-chuanjian@nfschina.com>
References: <20221227023625.7261-1-chuanjian@nfschina.com>
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

Le mardi 27 d=C3=A9cembre 2022 =C3=A0 10:36 +0800, Dong Chuanjian a =C3=A9c=
rit=C2=A0:
> When the pointer variable is judged to be null, null is returned
> directly.
>=20
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Please add the missing Fixes tag.

Fixes: d3f756ad629b39 ("media: v4l2: Trace calculated p/b0/b1 initial refli=
st")

If someone have time, the pr_debug should be ported to v4l2_debug according=
 to
some other reviews.

> ---
> v2: Directly return when pointer allocation fails.
> v3: problems in synchronous repair format_ref_list_p
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-cor=
e/v4l2-h264.c
> index 72bd64f65198..f6684c1d7319 100644
> --- a/drivers/media/v4l2-core/v4l2-h264.c
> +++ b/drivers/media/v4l2-core/v4l2-h264.c
> @@ -305,6 +305,8 @@ static const char *format_ref_list_p(const struct v4l=
2_h264_reflist_builder *bui
>  	int n =3D 0, i;
> =20
>  	*out_str =3D kmalloc(tmp_str_size, GFP_KERNEL);
> +	if (*out_str =3D=3D NULL)
> +		return NULL;
> =20
>  	n +=3D snprintf(*out_str + n, tmp_str_size - n, "|");
> =20
> @@ -343,6 +345,8 @@ static const char *format_ref_list_b(const struct v4l=
2_h264_reflist_builder *bui
>  	int n =3D 0, i;
> =20
>  	*out_str =3D kmalloc(tmp_str_size, GFP_KERNEL);
> +	if (*out_str =3D=3D NULL)
> +		return NULL;
> =20
>  	n +=3D snprintf(*out_str + n, tmp_str_size - n, "|");
> =20

