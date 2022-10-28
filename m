Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF064611226
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJ1NCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJ1NCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:02:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC81757A6;
        Fri, 28 Oct 2022 06:02:48 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 151C1660291B;
        Fri, 28 Oct 2022 14:02:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666962166;
        bh=RrGA38kF9uCwoRURHrbUbA5rP3minRYBauW06GkVdAU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NFoyMEsUhXGvmBVAW3ALjq2HZ8/Biw0fHKo/MDNE9ElPw/7r2GTINx78pugexMRUx
         nFH3TFfpwnvS1Uvu9ZnYJwvHAun5T/lTDokvKsDrZ1gJlPlXfipVda2AIGTUkKgOH+
         dyJ3fHj7Vb8xQcx1SGdYX36IDysFKj+BbtVTbzyNQVoVQ0kN5BJ36NNdRRpmR0uUoe
         krI6GGix+CcI2O1JD7zTznOUdhswx12G2ZuQ+ElKjGJ7gNqY736hIsoYzIiqK8Yj6u
         KNpaO3WUAZGM51+1Yxk07l7MnByK6xj+8YFrZIeyEfp9XPFpExrZaoneZ3gKa/S/dz
         LgI7QMwL0KpiQ==
Message-ID: <664bd195bdde7fd740572c4981c60b32de1465aa.camel@collabora.com>
Subject: Re: [PATCH] vcodec: mediatek: add check for NULL for 
 vsi->frm_bufs[vsi->new_fb_idx].buf.fb in vp9_swap_frm_bufs
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Anastasia Belova <abelova@astralinux.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lvc-project@linuxtesting.org
Date:   Fri, 28 Oct 2022 09:02:35 -0400
In-Reply-To: <20221028125811.11340-1-abelova@astralinux.ru>
References: <20221028125811.11340-1-abelova@astralinux.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

Le vendredi 28 octobre 2022 =C3=A0 15:58 +0300, Anastasia Belova a =C3=A9cr=
it=C2=A0:
> If vsi->frm_bufs[vsi->new_fb_idx].buf.fb =3D=3D NULL while cleaning
> fb_free_list NULL-pointer is dereferenced.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: f77e89854b3e ("[media] vcodec: mediatek: Add Mediatek VP9 Video De=
coder Driver")
>=20
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> index 70b8383f7c8e..b0679aaf6192 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> @@ -512,7 +512,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *i=
nst)
>  	 * clean fb_free_list
>  	 */
>  	if (vsi->frm_bufs[vsi->new_fb_idx].ref_cnt =3D=3D 0) {
> -		if (!vp9_is_sf_ref_fb(
> +		if (vsi->frm_bufs[vsi->new_fb_idx].buf.fb !=3D NULL && !vp9_is_sf_ref_=
fb(
>  			inst, vsi->frm_bufs[vsi->new_fb_idx].buf.fb)) {
>  			struct vdec_fb *fb;

Perhaps we could try and maintain some readability ? I'd suggest to move th=
e
check into vp9_is_sf_ref_fb() as an early return.

Nicolas


