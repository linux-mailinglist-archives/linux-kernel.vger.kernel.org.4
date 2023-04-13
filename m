Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4216C6E1570
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDMTxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDMTxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:53:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1661BD;
        Thu, 13 Apr 2023 12:53:02 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2DFFD660321C;
        Thu, 13 Apr 2023 20:53:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681415581;
        bh=Xmjp5lWuMHq/SjSflHdTaP3qxA46dZ+RFJK8UHWvH58=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HQbr5eICiL/ndoU2UKiaY/BniNEDRXy4AizvQ2xXFsCew0NfNJ7iRiuYOjGlc92do
         EAZ8z8hpvkcor6lzLCkUx4eAR7YQEIFZ8UUJdENB6eUxARg55Qe/fLOW7z0cEvwvqW
         SX065YHK7xhaWsYvn3M2/jS2XrUb2nP/KHSDiwjPA3YigmEROpJEJYQPRbLTQ+d2A1
         FWg2nC3PuINjARYPk4czzj4OgB49X8zpoziVLGyftyiKQ1U5MFrTVF1XBlXCXwMKDS
         2CHwxPM5dLod/JR1xRbiYZGETi4B78jLKv+lZbJQOg3S+jtnDoWVbnICUUWYXR0PVJ
         j+4FneiRrCMrQ==
Message-ID: <403ea30e55a9667684cd1f8d2d3a641efda9976f.camel@collabora.com>
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Date:   Thu, 13 Apr 2023 15:52:50 -0400
In-Reply-To: <CAAEAJfBHOMpWT2E4w+Zu=f8QCg+YiDU_9gY4bpJSGBLMnC8B9A@mail.gmail.com>
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
         <CAAEAJfBHOMpWT2E4w+Zu=f8QCg+YiDU_9gY4bpJSGBLMnC8B9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 13 avril 2023 =C3=A0 10:10 -0300, Ezequiel Garcia a =C3=A9crit=C2=
=A0:
> Benjamin,
>=20
> Please include the crash stracktrace in the commit.
>=20
>=20
Careful with HTML message, they don't always make it in these ML and toolin=
g
might not play well with the tooling. Perhaps it can be edited while pullin=
g ?
Here's the info from Marek's bug report:

hantro-vpu fdea0000.video-codec: Adding to iommu group 0
hantro-vpu fdea0000.video-codec: registered rockchip,rk3568-vpu-dec as=20
/dev/video0
hantro-vpu fdee0000.video-codec: Adding to iommu group 1
hantro-vpu fdee0000.video-codec: registered rockchip,rk3568-vepu-enc as=20
/dev/video1
Unable to handle kernel NULL pointer dereference at virtual address=20
0000000000000008
Mem abort info:
   ESR =3D 0x0000000096000004
   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
   SET =3D 0, FnV =3D 0
   EA =3D 0, S1PTW =3D 0
   FSC =3D 0x04: level 0 translation fault
Data abort info:
   ISV =3D 0, ISS =3D 0x00000004
   CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000001f446f000
[0000000000000008] pgd=3D0000000000000000, p4d=3D0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in: hantro_vpu v4l2_vp9 v4l2_h264 v4l2_mem2mem=20
videobuf2_dma_contig snd_soc_simple_card display_connector=20
snd_soc_simple_card_utils videobuf2_memops crct10dif_ce dwmac_rk=20
rockchip_thermal videobuf2_v4l2 stmmac_platform rockchip_saradc=20
industrialio_triggered_buffer kfifo_buf stmmac videodev pcs_xpcs=20
rtc_rk808 videobuf2_common rockchipdrm panfrost mc drm_shmem_helper=20
analogix_dp gpu_sched dw_mipi_dsi dw_hdmi drm_display_helper ip_tables=20
x_tables ipv6
CPU: 3 PID: 171 Comm: v4l_id Not tainted 6.3.0-rc2+ #13478
Hardware name: Hardkernel ODROID-M1 (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : hantro_try_fmt+0xb4/0x280 [hantro_vpu]
lr : hantro_try_fmt+0xa8/0x280 [hantro_vpu]
...
Call trace:
  hantro_try_fmt+0xb4/0x280 [hantro_vpu]
  hantro_set_fmt_out+0x3c/0x278 [hantro_vpu]
  hantro_reset_raw_fmt+0x94/0xb4 [hantro_vpu]
  hantro_set_fmt_cap+0x23c/0x250 [hantro_vpu]
  hantro_reset_fmts+0x94/0xcc [hantro_vpu]
  hantro_open+0xd4/0x20c [hantro_vpu]
  v4l2_open+0x80/0x120 [videodev]
  chrdev_open+0xc0/0x22c
  do_dentry_open+0x13c/0x490
  vfs_open+0x2c/0x38
  path_openat+0x550/0x938
  do_filp_open+0x80/0x12c
  do_sys_openat2+0xb4/0x16c
  __arm64_sys_openat+0x64/0xac
  invoke_syscall+0x48/0x114
  el0_svc_common.constprop.0+0xfc/0x11c
  do_el0_svc+0x38/0xa4
  el0_svc+0x48/0xb8
  el0t_64_sync_handler+0xb8/0xbc
  el0t_64_sync+0x190/0x194
Code: 97fe726c f940aa80 52864a61 72a686c1 (b9400800)
---[ end trace 0000000000000000 ]---


>=20
> Thanks,
> Ezequiel
>=20
>=20
> On Thu, Apr 13, 2023 at 7:48=E2=80=AFAM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
> > ctx->vpu_dst_fmt is no more initialized before calling hantro_try_fmt()
> > so assigne it to vpu_fmt led to crash the kernel.
> > Like for decoder case use 'fmt' as format for encoder and clean up
> > the code.
> >=20
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst fo=
rmats
> > in reset functions")
> > ---
> > version 2:
> > - Remove useless vpu_fmt.
> >=20
> > =C2=A0drivers/media/platform/verisilicon/hantro_v4l2.c | 10 +++-------
> > =C2=A01 file changed, 3 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > index 8f1414085f47..d71f79471396 100644
> > --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > @@ -275,7 +275,7 @@ static int hantro_try_fmt(const struct hantro_ctx *=
ctx,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct v4l2_pix_format_mplane *pix_mp,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 enum v4l2_buf_type type)
> > =C2=A0{
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct hantro_fmt *fmt, *vpu_fmt;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct hantro_fmt *fmt;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool capture =3D V4L2_TYPE_IS_CAPTURE(type)=
;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool coded;
> >=20
> > @@ -295,11 +295,7 @@ static int hantro_try_fmt(const struct hantro_ctx =
*ctx,
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (coded) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pix_mp->num_pla=
nes =3D 1;
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vpu_fmt =3D fmt=
;
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (ctx->is_encoder) {
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vpu_fmt =3D ctx=
->vpu_dst_fmt;
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vpu_fmt =3D fmt=
;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!ctx->is_encoder) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Width/h=
eight on the CAPTURE end of a decoder are ignored
> > and
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* replace=
d by the OUTPUT ones.
> > @@ -311,7 +307,7 @@ static int hantro_try_fmt(const struct hantro_ctx *=
ctx,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 pix_mp->field =3D V4L2_FIELD_NONE;
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 v4l2_apply_frmsize_constraints(&pix_mp->wid=
th, &pix_mp->height,
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &vpu_fmt->fr=
msize);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &fmt->frmsiz=
e);
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!coded) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fill remaini=
ng fields */

