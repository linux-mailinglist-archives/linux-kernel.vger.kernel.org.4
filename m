Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1870E971
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbjEWXW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjEWXW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:22:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539BDDA;
        Tue, 23 May 2023 16:22:24 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:17:6c0::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 771E1660298C;
        Wed, 24 May 2023 00:22:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684884142;
        bh=GKh6EOIgX3e36fz9KVxKeOlDpcpRzh+0I4D+rqUNQ9U=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=JrRS2H/bRjZDMJLLJsJpM1cZlk0WBLtKG77OgOvgmEVJkra0DGvOcDw6QpFbl2zx0
         S9zqksYQEFj02mRm7o9862FbQmYM/fwk7nPCGNdi9V9WmdOWilSPpe/MUzz+YlDjAx
         yjn8zmBpg29OArF22qQqQ9Z6ffRywFLNDiPRqjdT3FTFfklsQ/JkOWhueDXEjX07Ol
         yfM1hcsmS9Gm49qbunvWDx/3lwjUyT44g3IVffpQhlJrRLrAnJn/eVH4g/Lo2iHul1
         fvaUbEVPm+nS/zqZNVy5v5txnRC3INIW26cePScnetaGqDFq1TGArkdaGbe0OMFqVB
         QD+kAXVgQAXaA==
Message-ID: <e6b11230654e9b217c007eb3bfe73a3c6e7a13c2.camel@collabora.com>
Subject: Re: [PATCH] media: verisilicon: Additional fix for the crash when
 opening the driver
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, didi.debian@cknow.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        regressions@lists.linux.dev
Date:   Tue, 23 May 2023 19:22:13 -0400
In-Reply-To: <CAAEAJfAG_Z_tW8_LzgL7D+tGFYRhyJz3n0uy0gZiOkMnz6FOGA@mail.gmail.com>
References: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
         <c034db29-b664-793d-35e0-406fdfe2b145@collabora.com>
         <20230523170637.GE9943@pengutronix.de>
         <CAAEAJfAG_Z_tW8_LzgL7D+tGFYRhyJz3n0uy0gZiOkMnz6FOGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
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

Le mardi 23 mai 2023 =C3=A0 14:36 -0300, Ezequiel Garcia a =C3=A9crit=C2=A0=
:
> Hi guys,
>=20
> After reviewing the format logic (hantro_reset_encoded_fmt and
> hantro_reset_raw_fmt).
> It seems to me trying to support Decoders, Encoders and so many
> different SoC Variants, is getting increasingly fragile.
> This driver is becoming a big fat monolith. Regressions like this will
> be increasingly frequent.
>=20
> The only codec that supports encoding right now is JPEG, so I think
> it's a good idea to remove it for good,
> and split it to its own driver.
>=20
> Anyone volunteering? :-)

We won't have that luxury with VP8 and H.264, as the decoder and encoder sh=
ares
the same cache memory. They must be time sliced. Note that this driver is o=
nly
missing VP8/H.264 encoding before it becomes maintenance only (there won't =
be
any interesting feature left, so I would not start on big refactoring, as t=
his
may cause more trouble then good. Anything newer like VC8000 or VC9000 shou=
ld be
a new driver, and with encoder/decoder split.

regards,
Nicolas

p.s. this is my personal opinion, in general, we should improve the helpers=
 if
there is too much boilerplate, rather then creating monolithic drivers, and=
 on
that, I believe I agree, but the H1/G1 combo have hardware dependencies whi=
ch
has been solve that way, and changing that now is a big amount of work for =
a
relative quite driver. Feel free to split G2 away from that driver, that wo=
uld
make sense, its not sharing anything.

>=20
> Thanks,
> Ezequiel
>=20
> On Tue, May 23, 2023 at 2:06=E2=80=AFPM Michael Tretter
> <m.tretter@pengutronix.de> wrote:
> >=20
> > On Tue, 23 May 2023 18:36:09 +0200, Benjamin Gaignard wrote:
> > >=20
> > > Le 23/05/2023 =C3=A0 18:25, Benjamin Gaignard a =C3=A9crit :
> > > > This fixes the following issue observed on Odroid-M1 board:
> > > >=20
> > > >   Unable to handle kernel NULL pointer dereference at virtual addre=
ss 0000000000000008
> > > >   Mem abort info:
> > > >   ...
> > > >   Modules linked in: crct10dif_ce hantro_vpu snd_soc_simple_card sn=
d_soc_simple_card_utils v4l2_vp9 v4l2_h264 rockchip_saradc v4l2_mem2mem vid=
eobuf2_dma_contig videobuf2_memops rtc_rk808 videobuf2_v4l2 industrialio_tr=
iggered_buffer rockchip_thermal dwmac_rk stmmac_platform stmmac videodev kf=
ifo_buf display_connector videobuf2_common pcs_xpcs mc rockchipdrm analogix=
_dp dw_mipi_dsi dw_hdmi drm_display_helper panfrost drm_shmem_helper gpu_sc=
hed ip_tables x_tables ipv6
> > > >   CPU: 3 PID: 176 Comm: v4l_id Not tainted 6.3.0-rc7-next-20230420 =
#13481
> > > >   Hardware name: Hardkernel ODROID-M1 (DT)
> > > >   pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > > >   pc : hantro_try_fmt+0xa0/0x278 [hantro_vpu]
> > > >   lr : hantro_try_fmt+0x94/0x278 [hantro_vpu]
> > > >   ...
> > > >   Call trace:
> > > >    hantro_try_fmt+0xa0/0x278 [hantro_vpu]
> > > >    hantro_set_fmt_out+0x3c/0x298 [hantro_vpu]
> > > >    hantro_reset_raw_fmt+0x98/0x128 [hantro_vpu]
> > > >    hantro_set_fmt_cap+0x240/0x254 [hantro_vpu]
> > > >    hantro_reset_encoded_fmt+0x94/0xcc [hantro_vpu]
> > > >    hantro_reset_fmts+0x18/0x38 [hantro_vpu]
> > > >    hantro_open+0xd4/0x20c [hantro_vpu]
> > > >    v4l2_open+0x80/0x120 [videodev]
> > > >    chrdev_open+0xc0/0x22c
> > > >    do_dentry_open+0x13c/0x48c
> > > >    vfs_open+0x2c/0x38
> > > >    path_openat+0x550/0x934
> > > >    do_filp_open+0x80/0x12c
> > > >    do_sys_openat2+0xb4/0x168
> > > >    __arm64_sys_openat+0x64/0xac
> > > >    invoke_syscall+0x48/0x114
> > > >    el0_svc_common+0x100/0x120
> > > >    do_el0_svc+0x3c/0xa8
> > > >    el0_svc+0x40/0xa8
> > > >    el0t_64_sync_handler+0xb8/0xbc
> > > >    el0t_64_sync+0x190/0x194
> > > >   Code: 97fc8a7f f940aa80 52864a61 72a686c1 (b9400800)
> > > >   ---[ end trace 0000000000000000 ]---
> > > >=20
> > > > Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/ds=
t formats in reset functions")
> >=20
> > This patch partially reverts the previous commit. I wonder whether the =
reason
> > for resetting the context format only if the targeted queue is not busy=
 still
> > stands.
> >=20
> > > >=20
> > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >=20
> > Tested-by: Michael Tretter <m.tretter@pengutronix.de>
> >=20
> > > > ---
> > >=20
> > > Diederick, Marek, Michael,
> > > I have tested this patch on my boards and I see no regressions on
> > > decoder part and no more crash when probing the encoder.
> > > Could you test it on your side to confirm it is ok ?
> > >=20
> > > Thorsten, I try/test regzbot commands, please tell me if it is correc=
t.
> > >=20
> > > #regzbot ^introduced db6f68b51e5c
> > > #regzbot title media: verisilicon: null pointer dereference in try_fm=
t
> > > #regzbot ignore-activity
> > >=20
> > >=20
> > > >   drivers/media/platform/verisilicon/hantro_v4l2.c | 6 ++++--
> > > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/dri=
vers/media/platform/verisilicon/hantro_v4l2.c
> > > > index 835518534e3b..61cfaaf4e927 100644
> > > > --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > > +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > > @@ -397,10 +397,12 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, =
int bit_depth)
> > > >     if (!raw_vpu_fmt)
> > > >             return -EINVAL;
> > > > -   if (ctx->is_encoder)
> > > > +   if (ctx->is_encoder) {
> > > >             encoded_fmt =3D &ctx->dst_fmt;
> > > > -   else
> > > > +           ctx->vpu_src_fmt =3D raw_vpu_fmt;
> > > > +   } else {
> > > >             encoded_fmt =3D &ctx->src_fmt;
> > > > +   }
> > > >     hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
> > > >     raw_fmt.width =3D encoded_fmt->width;
> > >=20

