Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D627058AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjEPUWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEPUWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5FE1725
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 770E061B89
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD2DC433EF;
        Tue, 16 May 2023 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268554;
        bh=Sh10PzN7ZGeNFJszxNxgJ0E4uvWBGu9WxbiTupf53mU=;
        h=From:To:Cc:Subject:Date:From;
        b=Zh/dgpPcEs+o9AL1H8lM5HSqjawjI5bMYxJrMPI42rxMnxJV4sI2x3sQ5XfW+oJAe
         Rubf1FaIIRWM0IgV1Y0nYU55mJ0inHPbfpOzo26n0okvA6b1rFfgleurYIQ0K8UH5H
         bEWWorUSeS/s4nB4GiQBwy9CuU7zkle/Two5mBCPj7/S6etptTCcHQa7u8i+OBa5HZ
         7Exq9SgkmzDAo5kBnQZ7W6gilABLIQIrfMuvLvhd6QZdVUfTOiaoR3eouRs6gSl5UU
         e6IUJSWf+gJmQ7B9WEbMQ7Q7dDVte9DSzMvNhidYbXr8uGCaULaBfWf+VzVwNy+qx/
         QHvzLE48u09mA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Carlos Chinea <carlos.chinea@nokia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jianglei Nie <niejianglei2021@163.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Wang Qing <wangqing@vivo.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yuan Can <yuancan@huawei.com>,
        Miaoqian Lin <linmq006@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] hsi: fix ssi_waketest() declaration
Date:   Tue, 16 May 2023 22:22:07 +0200
Message-Id: <20230516202226.559733-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The ssi_waketest() function definition causes a 'make W=1' warning
because the declaration is hidden away in ssi_protocol.c:

drivers/hsi/controllers/omap_ssi_core.c:147:6: error: no previous prototype for 'ssi_waketest'

Move it into a header file instead.

Fixes: dc7bf5d71868 ("HSI: Introduce driver for SSI Protocol")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hsi/clients/ssi_protocol.c      | 2 --
 drivers/hsi/controllers/omap_ssi_core.c | 1 +
 include/linux/hsi/ssi_protocol.h        | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 38e572faff43..da6a7abd584f 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -32,8 +32,6 @@
 #include <linux/hsi/hsi.h>
 #include <linux/hsi/ssi_protocol.h>
 
-void ssi_waketest(struct hsi_client *cl, unsigned int enable);
-
 #define SSIP_TXQUEUE_LEN	100
 #define SSIP_MAX_MTU		65535
 #define SSIP_DEFAULT_MTU	4000
diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 26f2c3c01297..84ba8b875199 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -17,6 +17,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/delay.h>
+#include <linux/hsi/ssi_protocol.h>
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 #include <linux/interrupt.h>
diff --git a/include/linux/hsi/ssi_protocol.h b/include/linux/hsi/ssi_protocol.h
index 2d6f3cfa7dea..972434daa000 100644
--- a/include/linux/hsi/ssi_protocol.h
+++ b/include/linux/hsi/ssi_protocol.h
@@ -24,6 +24,7 @@ int ssip_slave_stop_tx(struct hsi_client *master);
 void ssip_reset_event(struct hsi_client *master);
 
 int ssip_slave_running(struct hsi_client *master);
+void ssi_waketest(struct hsi_client *cl, unsigned int enable);
 
 #endif /* __LINUX_SSIP_SLAVE_H__ */
 
-- 
2.39.2

