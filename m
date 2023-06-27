Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2273FA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjF0KZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjF0KZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:25:13 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8D3AA3;
        Tue, 27 Jun 2023 03:23:53 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id A7DB4186677E;
        Tue, 27 Jun 2023 13:23:51 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nhyyPPXG8I23; Tue, 27 Jun 2023 13:23:51 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 079BA1866712;
        Tue, 27 Jun 2023 13:23:51 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GJLLlds1rppm; Tue, 27 Jun 2023 13:23:50 +0300 (MSK)
Received: from anastasia-huawei.. (unknown [89.222.134.55])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 23BD41865B39;
        Tue, 27 Jun 2023 13:23:49 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.10 1/1] media: atomisp: fix "variable dereferenced before check 'asd'"
Date:   Tue, 27 Jun 2023 13:23:34 +0300
Message-Id: <20230627102334.18781-2-abelova@astralinux.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627102334.18781-1-abelova@astralinux.ru>
References: <20230627102334.18781-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tsuchiya Yuto <kitakar@gmail.com>

commit ac56760a8bbb4e654b2fd54e5de79dd5d72f937d upstream.

There are two occurrences where the variable 'asd' is dereferenced
before check. Fix this issue by using the variable after the check.

Link: https://lore.kernel.org/linux-media/20211122074122.GA6581@kili/

Link: https://lore.kernel.org/linux-media/20211201141904.47231-1-kitakar@=
gmail.com
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c   | 3 ++-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/st=
aging/media/atomisp/pci/atomisp_cmd.c
index 20c19e08968e..613bd9620224 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -5243,7 +5243,7 @@ static int atomisp_set_fmt_to_isp(struct video_devi=
ce *vdev,
 	int (*configure_pp_input)(struct atomisp_sub_device *asd,
 				  unsigned int width, unsigned int height) =3D
 				      configure_pp_input_nop;
-	u16 stream_index =3D atomisp_source_pad_to_stream_id(asd, source_pad);
+	u16 stream_index;
 	const struct atomisp_in_fmt_conv *fc;
 	int ret, i;
=20
@@ -5252,6 +5252,7 @@ static int atomisp_set_fmt_to_isp(struct video_devi=
ce *vdev,
 			__func__, vdev->name);
 		return -EINVAL;
 	}
+	stream_index =3D atomisp_source_pad_to_stream_id(asd, source_pad);
=20
 	v4l2_fh_init(&fh.vfh, vdev);
=20
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/=
staging/media/atomisp/pci/atomisp_ioctl.c
index 8a0648fd7c81..4615e4cae718 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1123,7 +1123,7 @@ int __atomisp_reqbufs(struct file *file, void *fh,
 	struct ia_css_frame *frame;
 	struct videobuf_vmalloc_memory *vm_mem;
 	u16 source_pad =3D atomisp_subdev_source_pad(vdev);
-	u16 stream_id =3D atomisp_source_pad_to_stream_id(asd, source_pad);
+	u16 stream_id;
 	int ret =3D 0, i =3D 0;
=20
 	if (!asd) {
@@ -1131,6 +1131,7 @@ int __atomisp_reqbufs(struct file *file, void *fh,
 			__func__, vdev->name);
 		return -EINVAL;
 	}
+	stream_id =3D atomisp_source_pad_to_stream_id(asd, source_pad);
=20
 	if (req->count =3D=3D 0) {
 		mutex_lock(&pipe->capq.vb_lock);
--=20
2.39.0

