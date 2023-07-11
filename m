Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2274F8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGKUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGKUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:06:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1778C11D;
        Tue, 11 Jul 2023 13:05:59 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E981866015A0;
        Tue, 11 Jul 2023 21:05:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689105957;
        bh=dmJHQE21OJkYlm5RrWuAsMnx+LYphDxaC5h9NrucmaY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nbAXQEpSyr6TpxPgRQ4CRoYH+S3gOahvQDxRL1XQ3ccK5rpbWKM77r1LpOCI7bmKs
         +iEZx2PGRv6vnST8DCKduQP7OHymUyLvdz5W72eV/b2dJMUDvS8LC/yY2THm0LZDAT
         bejbi6hO00D71FYUuar7OnI3sfZ9QNI08V3QpC8wAJBqnI/Vgc0jAXhM7s2/a5t4pI
         +xTmiGtnxLUUSislQLDDdIBKCUQlfor00PCgeNn7LG8MWiQ07hLurwiT/gB3Iin9nl
         Fc0hcV3nACeBnZWbYWFHPl3WwJqMnE9ZQwR3f1wn6rlwApb3Tqwj7SnJQSxCnhY9bM
         1e774RBjZYmuQ==
Message-ID: <b002d092e38481dfad1766348032c2290c271fb0.camel@collabora.com>
Subject: Re: [PATCH 0/3] media: mediatek: vcodec: Add driver to support 10bit
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Tue, 11 Jul 2023 16:05:47 -0400
In-Reply-To: <20230711125749.15555-1-yunfei.dong@mediatek.com>
References: <20230711125749.15555-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 11 juillet 2023 =C3=A0 20:57 +0800, Yunfei Dong a =C3=A9crit=C2=A0=
:
> Define two capture formats V4L2_PIX_FMT_MT2110R and
> V4L2_PIX_FMT_MT2110T to support 10bit in mt8195, mt8199 and more.
> Getting the size of each plane again when userspace set 10bit
> syntax to driver.
>=20
> V4L2_PIX_FMT_MT2110R is used for H264, and V4L2_PIX_FMT_MT2110T
> is used for AV1/VP9/HEVC.
>=20
> patch 1 Add driver to support 10bit
> patch 2 Add capture format V4L2_PIX_FMT_MT2110T to support 10bit tile mod=
e
> patch 3 Add capture format V4L2_PIX_FMT_MT2110R to support 10bit raster m=
ode
> ---
> - send the first version v1:
> - Run 10bit VP9/AV1 fluster test pass.
> - Will return error when the 10bit parameter no correctly in function mtk=
_vdec_s_ctrl.

Just ran AV1 and VP8 tests locally. VP8 completely fails (0/61) as the upda=
te
rejects the VP8 controls in mtk_vdec_s_ctrl. As for AV1, it completely regr=
essed
(0 success, there is "invalid tge_size" kind of errors). I've been testing =
with
the upstream firmware since you didn't mention any firmware update (md5 is
52d11ed015d4e2f6d4e9ce9a8fcf20e3).

You can retrace my step using this kernel and normal Debian OS:

https://gitlab.collabora.com/nicolas/linux/-/commits/mt8195-10bit-2

regards,
Nicolas

> ---
>=20
> Reference series:
> [1]: this series depends on v6 which is send by Yunfei Dong.
>      message-id: 20230704131349.8354-1-yunfei.dong@mediatek.com
>=20
> Mingjia Zhang (3):
>   media: mediatek: vcodec: Add capture format to support 10bit tile mode
>   media: mediatek: vcodec: Add capture format to support 10bit raster
>     mode
>   media: mediatek: vcodec: Add driver to support 10bit
>=20
>  .../media/v4l/pixfmt-reserved.rst             |  15 ++
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  |  22 ++-
>  .../vcodec/decoder/mtk_vcodec_dec_drv.h       |   5 +
>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 140 +++++++++++++++++-
>  drivers/media/v4l2-core/v4l2-common.c         |   4 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
>  include/uapi/linux/videodev2.h                |   2 +
>  7 files changed, 186 insertions(+), 4 deletions(-)
>=20

