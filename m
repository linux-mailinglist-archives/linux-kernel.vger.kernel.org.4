Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D77A65505F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiLWMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLWMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:30:56 -0500
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B015F63;
        Fri, 23 Dec 2022 04:30:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 653E1514336F;
        Fri, 23 Dec 2022 15:29:22 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zHmHr3oxIjyB; Fri, 23 Dec 2022 15:29:22 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 29CBB5143372;
        Fri, 23 Dec 2022 15:29:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 29CBB5143372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1671798562;
        bh=yXHtvnOMY5eVIVGTxUflX7Ih3TxR3ASy2jfItVNcKx0=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=mENv6OhVuLIQrPrw/2HLDk2wzdDiC/04ajhR7J2pze+AgmfpM4WGB84ugvQZBrhlC
         tI9v9wczKUxpQuzfAM45pHf6VEIZVP6QtQQmBwNRCIryS505WiziHpgw5vUjPq6DoJ
         cIm1cgYLDy4w9ljwaVV3YVx9S+hu8ba+pbU+6P//mO6qQel5tfJYK0eH2ZmxgQoWOe
         8H5sUaNQsKA5/W1qHe5IK9pYn98i+E3vge4G1Had/m0/VdvG661d4znd9dqhajOHno
         wlOaX3RiNO3aXfJSExySeYt64W0U9JvLn6hJWk/GWP7VWkx+4OCojyw3miErZRn9c7
         cOvHbHin7s5nA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LenJMnkku1Ky; Fri, 23 Dec 2022 15:29:22 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id B6378514336F;
        Fri, 23 Dec 2022 15:29:21 +0300 (MSK)
From:   Aleksandr Burakov <a.burakov@rosalinux.ru>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Cc:     Aleksandr Burakov <a.burakov@rosalinux.ru>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] staging: media: ipu3: buffer overflow fix in imgu_map_node
Date:   Fri, 23 Dec 2022 15:30:25 +0300
Message-Id: <20221223123025.5948-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If imgu_node_map[i].css_queue is not equal to css_queue
then "i" after the loop could be equal to IMGU_NODE_NUM
that is more than the border value (IMGU_NODE_NUM - 1).
So imgu_map_node() call may return IMGU_NODE_NUM that is more
than expected value.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7fc7af649ca7 ("media: staging/intel-ipu3: Add imgu top level pci d=
evice driver")
Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
---
 drivers/staging/media/ipu3/ipu3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ip=
u3/ipu3.c
index 0c453b37f8c4..cb09eb3cc227 100644
--- a/drivers/staging/media/ipu3/ipu3.c
+++ b/drivers/staging/media/ipu3/ipu3.c
@@ -60,8 +60,10 @@ unsigned int imgu_map_node(struct imgu_device *imgu, u=
nsigned int css_queue)
 	for (i =3D 0; i < IMGU_NODE_NUM; i++)
 		if (imgu_node_map[i].css_queue =3D=3D css_queue)
 			break;
-
-	return i;
+	if (i < IMGU_NODE_NUM)
+		return i;
+	else
+		return (IMGU_NODE_NUM - 1);
 }
=20
 /**************** Dummy buffers ****************/
--=20
2.25.1

