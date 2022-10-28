Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6761120B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJ1M6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ1M6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:58:31 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF3F1CC3C1;
        Fri, 28 Oct 2022 05:58:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 6266A186458D;
        Fri, 28 Oct 2022 15:58:24 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7BSvSK3WxBlH; Fri, 28 Oct 2022 15:58:24 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id ED4DA186458E;
        Fri, 28 Oct 2022 15:58:23 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ud5wkNZ1Usua; Fri, 28 Oct 2022 15:58:23 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.20])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 27F931863FEA;
        Fri, 28 Oct 2022 15:58:23 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lvc-project@linuxtesting.org
Subject: [PATCH] vcodec: mediatek: add check for NULL for  vsi->frm_bufs[vsi->new_fb_idx].buf.fb in vp9_swap_frm_bufs
Date:   Fri, 28 Oct 2022 15:58:11 +0300
Message-Id: <20221028125811.11340-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vsi->frm_bufs[vsi->new_fb_idx].buf.fb =3D=3D NULL while cleaning
fb_free_list NULL-pointer is dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f77e89854b3e ("[media] vcodec: mediatek: Add Mediatek VP9 Video De=
coder Driver")

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
index 70b8383f7c8e..b0679aaf6192 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
@@ -512,7 +512,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *i=
nst)
 	 * clean fb_free_list
 	 */
 	if (vsi->frm_bufs[vsi->new_fb_idx].ref_cnt =3D=3D 0) {
-		if (!vp9_is_sf_ref_fb(
+		if (vsi->frm_bufs[vsi->new_fb_idx].buf.fb !=3D NULL && !vp9_is_sf_ref_=
fb(
 			inst, vsi->frm_bufs[vsi->new_fb_idx].buf.fb)) {
 			struct vdec_fb *fb;
=20
--=20
2.30.2

