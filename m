Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B176A1D30
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBXOEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBXOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:04:44 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F6F54A0A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:04:41 -0800 (PST)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id AD3B0161B3F;
        Fri, 24 Feb 2023 15:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1677247478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7ekmKaUSZUGiHSnrych0SWOvyNHZbcMRwNgs+xaEqa4=;
        b=ZuRq0uM/XBq6A2d+SgT8jCJ7QsedUvJ1miiPmzYmEl+vURbGtHwBe8/Hdom1ZgnCDYFlCD
        q2a7LpnYmq9MEzwpDFC1NOMxjPdC8k6cVOE0XEBbI3GT0Y6n+0e3z6jjQn0P4waCZ+69NL
        SmaoaA8zlzg30apMVncY2n/pRdh48F0=
From:   David Heidelberg <david@ixit.cz>
Cc:     dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] init/do_mounts.c: add virtiofs root fs support
Date:   Fri, 24 Feb 2023 15:04:21 +0100
Message-Id: <20230224140421.29774-1-david@ixit.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Make it possible to boot directly from a virtiofs file system with tag
'myfs' using the following kernel parameters:

  rootfstype=virtiofs root=myfs rw

Booting directly from virtiofs makes it possible to use a directory on
the host as the root file system.  This is convenient for testing and
situations where manipulating disk image files is cumbersome.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
We have used this option in Mesa3D CI for testing crosvm for
more than one years and it's proven to work reliably.

We are working on effort to removing custom patches to be able to do 
automated apply and test of patches from any tree.                              

https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/crosvm-runner.sh#L85

 init/do_mounts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 811e94daf0a8..11c11abe23d7 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -578,6 +578,16 @@ void __init mount_root(void)
 			printk(KERN_ERR "VFS: Unable to mount root fs via SMB.\n");
 		return;
 	}
+#endif
+#ifdef CONFIG_VIRTIO_FS
+	if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
+		if (!do_mount_root(root_device_name, "virtiofs",
+				   root_mountflags, root_mount_data))
+			return;
+
+		panic("VFS: Unable to mount root fs \"%s\" from virtiofs",
+		      root_device_name);
+	}
 #endif
 	if (ROOT_DEV == 0 && root_device_name && root_fs_names) {
 		if (mount_nodev_root() == 0)
-- 
2.39.1

