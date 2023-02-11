Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524F1692DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 04:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBKDee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 22:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBKDe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 22:34:26 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F705D1CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 19:34:00 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676086438;
        bh=hJUIVjIWcroVtvu4OXuhx/MmU7Sz2UPG988Be7bAuc8=;
        h=From:Date:Subject:To:Cc:From;
        b=Nlkhb7/w3HVQhOPusCBshsTE2RxwP3UhboUuSlVe4kmfAXzewm6FRxuBAPonAjtDu
         GuXKqyfoCfmWQ8zV44Uc/GBSAy3M9vMrGgentEpTfObRWH8Hj8RL2oa+XyIoqy+1Fg
         ZHCHXJvxdNr68pYPqgZi+/rhGbhQ8pljY2KA7wZg=
Date:   Sat, 11 Feb 2023 03:33:53 +0000
Subject: [PATCH] ALSA: hda: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230211-kobj_type-sound-v1-1-17107ceb25b7@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKAM52MC/x2N0QrCMAwAf2Xk2ULTPemviEizRhcd6WicOMb+f
 cHHOzhuA+MmbHDpNmj8FZOqDnjqYBizPjlIcYYUUx8TYnhXet0/68zB6qIlxB4LIjOdmcArysa
 BWtZh9E6XaXI5N37I77+53vb9ALFIMzl2AAAA
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676086434; l=970;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hJUIVjIWcroVtvu4OXuhx/MmU7Sz2UPG988Be7bAuc8=;
 b=hfQTL2SZmLdiFSwlG3dnRfYwVUsBxpeQYwTuSWZgxp/oi3Uw/HmSgB6yKiqlWzlQ+YOah2NzE
 59vxI90qCtBAQh4xuDlNWs8bIvhLqNfs7jGQPDwKIZhMB4zIu1HgMBK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 sound/hda/hdac_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index 62a9615dcf52..60b0a70428d5 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -148,7 +148,7 @@ static void widget_release(struct kobject *kobj)
 	kfree(kobj);
 }
 
-static struct kobj_type widget_ktype = {
+static const struct kobj_type widget_ktype = {
 	.release	= widget_release,
 	.sysfs_ops	= &widget_sysfs_ops,
 };

---
base-commit: 420b2d431d18a2572c8e86579e78105cb5ed45b0
change-id: 20230211-kobj_type-sound-031d11eeb9eb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

