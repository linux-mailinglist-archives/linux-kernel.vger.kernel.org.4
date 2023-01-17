Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D60F66DF61
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjAQNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjAQNua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:50:30 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC0C3C287;
        Tue, 17 Jan 2023 05:50:19 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673963417;
        bh=D+WIpPKO1tzWEKcHNm5FaPvH2YY7yBdSjW/F8oRxpfE=;
        h=From:Date:Subject:To:Cc:From;
        b=UhqV2wpkBg7JIyTo4myy4ktRyYfR06Nz8R1uF6uM1CaJgfacgKHchk/nqC27AQE0k
         nyQKb7JOykW7uD0xfNezJavEkYnc0orf2yXqiE8+TKTHhEvulwCIy0n6LlbIFmEXBL
         AjfgXNJeSrX0veqdcIF+jzQePrwEU5qW7zFMWxCg=
Date:   Tue, 17 Jan 2023 13:50:05 +0000
Subject: [PATCH v2] kheaders: ignore and clean temporary kheaders_data
 directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230117-kernel-kheaders-gitignore-v2-1-1c29b3adf04a@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAI2nxmMC/42NQQ6CMBBFr0K6dkxbFBJX3sOwKO1AJ5BiZgA1h
 LtbOYHL95L/36YEmVDUrdgU40pCU8pgT4Xy0aUegUJmZbUttTE1DMgJRxgiuoAs0NNMfZoYodO
 hLi/XyrdVq/K+dYLQsks+5oe0jGOWT8aO3kfw0WSOJPPEn6O/mp/9J7UaMGBd6XStsQs63F9II
 uLjEs8JZ9Xs+/4FvleBjtwAAAA=
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nicolas Schier <n.schier@avm.de>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673963415; l=1408;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=D+WIpPKO1tzWEKcHNm5FaPvH2YY7yBdSjW/F8oRxpfE=;
 b=6UEwZKX3VGE0NwmWZA8xvqXK6JVPUgfrjVFjfJZftUB8zrOtwbUhgz2o1Z1ozyv3TTmP7lK8dvlj
 cmENqVniByK/lqKQGAIwu5WepMMJVngdqsdTfZM2WOY/Rho7lYxn
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

If the kheaders archive generation is interrupted then this directory
may be left.
Ignore it, it will be deleted by the next run of kernel/gen_kheaders.sh.
Also add it to clean-files so it can be cleaned up by make.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Also add the directory to clean-files
- Link to v1: https://lore.kernel.org/r/20230117-kernel-kheaders-gitignore-v1-1-2a3a070efd0d@weissschuh.net
---
 kernel/.gitignore | 1 +
 kernel/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/.gitignore b/kernel/.gitignore
index c6b299a6b786..57ab1d703763 100644
--- a/kernel/.gitignore
+++ b/kernel/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /config_data
 /kheaders.md5
+/kheaders_data.tar.xz.tmp/
diff --git a/kernel/Makefile b/kernel/Makefile
index 10ef068f598d..f3535944f635 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -156,4 +156,4 @@ quiet_cmd_genikh = CHK     $(obj)/kheaders_data.tar.xz
 $(obj)/kheaders_data.tar.xz: FORCE
 	$(call cmd,genikh)
 
-clean-files := kheaders_data.tar.xz kheaders.md5
+clean-files := kheaders_data.tar.xz kheaders.md5 kheaders_data.tar.xz.tmp

---
base-commit: d532dd102151cc69fcd00b13e5a9689b23c0c8d9
change-id: 20230117-kernel-kheaders-gitignore-f0d73456cb6b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

