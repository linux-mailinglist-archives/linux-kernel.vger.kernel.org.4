Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82427057C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjEPTqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEPTqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA22A9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2CF6395C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BAFC433D2;
        Tue, 16 May 2023 19:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266391;
        bh=DxI/UVhN0q2eJvXWiZ5VpavVr0sLMAGgJy7XONqqNTI=;
        h=From:To:Cc:Subject:Date:From;
        b=lZKVR+LO8BsQXXksU3lzecsMdCysi6jhPwGOc/TVemZ2b3rPKPWtZ/LYnR4Nckjpl
         Ltr84WhXcxbefIYu5DutkFEHN5YgnipvtkphFCMBevbtzxvAj6/d8VlrVRU+s/chK2
         xwxeW0A0uzQ7kJSQdiLXmares8h3DSqArOdgms4YDMB4zoMQ/tpasN7CuBK/fzJ0cd
         Ath6e7Sy7v6g8EYYsRTcF3oeMG1U90krJbg4cQABH3TTjOq20j4o0vCicD9ph/YeA9
         BovZrigvhzuPVkcmRYWSBo0OXgcwSB8J4682xDU1S4pf6VBAmuHWx5N3wAsj/UiOW3
         qjMyFtY+tYKkQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] net: isa: include net/Space.h
Date:   Tue, 16 May 2023 21:45:33 +0200
Message-Id: <20230516194625.549249-1-arnd@kernel.org>
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

The legacy drivers that still get called from net/Space.c have prototypes
in net/Space, but this header is not included in most of the files that
define those functions:

drivers/net/ethernet/cirrus/cs89x0.c:1649:28: error: no previous prototype for 'cs89x0_probe' [-Werror=missing-prototypes]
drivers/net/ethernet/8390/ne.c:947:28: error: no previous prototype for 'ne_probe' [-Werror=missing-prototypes]
drivers/net/ethernet/8390/smc-ultra.c:167:28: error: no previous prototype for 'ultra_probe' [-Werror=missing-prototypes]
drivers/net/ethernet/amd/lance.c:438:28: error: no previous prototype for 'lance_probe' [-Werror=missing-prototypes]
drivers/net/ethernet/3com/3c515.c:422:20: error: no previous prototype for 'tc515_probe' [-Werror=missing-prototypes]

Add the inclusion to avoids the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/3com/3c515.c     | 4 +++-
 drivers/net/ethernet/8390/ne.c        | 1 +
 drivers/net/ethernet/8390/smc-ultra.c | 1 +
 drivers/net/ethernet/8390/wd.c        | 1 +
 drivers/net/ethernet/amd/lance.c      | 1 +
 drivers/net/ethernet/cirrus/cs89x0.c  | 2 ++
 6 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c515.c b/drivers/net/ethernet/3com/3c515.c
index d2f4358cc550..ba3e7aa1a28f 100644
--- a/drivers/net/ethernet/3com/3c515.c
+++ b/drivers/net/ethernet/3com/3c515.c
@@ -66,8 +66,10 @@ static int max_interrupt_work = 20;
 #include <linux/timer.h>
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
-
 #include <linux/uaccess.h>
+
+#include <net/Space.h>
+
 #include <asm/io.h>
 #include <asm/dma.h>
 
diff --git a/drivers/net/ethernet/8390/ne.c b/drivers/net/ethernet/8390/ne.c
index 0a9118b8be0c..bc9c81dc00fd 100644
--- a/drivers/net/ethernet/8390/ne.c
+++ b/drivers/net/ethernet/8390/ne.c
@@ -52,6 +52,7 @@ static const char version2[] =
 #include <linux/etherdevice.h>
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
+#include <net/Space.h>
 
 #include <asm/io.h>
 
diff --git a/drivers/net/ethernet/8390/smc-ultra.c b/drivers/net/ethernet/8390/smc-ultra.c
index 6e62c37c9400..7465650c8078 100644
--- a/drivers/net/ethernet/8390/smc-ultra.c
+++ b/drivers/net/ethernet/8390/smc-ultra.c
@@ -66,6 +66,7 @@ static const char version[] =
 #include <linux/isapnp.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <net/Space.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
diff --git a/drivers/net/ethernet/8390/wd.c b/drivers/net/ethernet/8390/wd.c
index 5b00c452bede..119021d41451 100644
--- a/drivers/net/ethernet/8390/wd.c
+++ b/drivers/net/ethernet/8390/wd.c
@@ -37,6 +37,7 @@ static const char version[] =
 #include <linux/delay.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <net/Space.h>
 
 #include <asm/io.h>
 
diff --git a/drivers/net/ethernet/amd/lance.c b/drivers/net/ethernet/amd/lance.c
index 8971665a4b2a..6cf38180cc01 100644
--- a/drivers/net/ethernet/amd/lance.c
+++ b/drivers/net/ethernet/amd/lance.c
@@ -59,6 +59,7 @@ static const char version[] = "lance.c:v1.16 2006/11/09 dplatt@3do.com, becker@c
 #include <linux/skbuff.h>
 #include <linux/mm.h>
 #include <linux/bitops.h>
+#include <net/Space.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
index 06a0c00af99c..276c32c3926a 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -72,6 +72,8 @@
 #include <linux/gfp.h>
 #include <linux/io.h>
 
+#include <net/Space.h>
+
 #include <asm/irq.h>
 #include <linux/atomic.h>
 #if ALLOW_DMA
-- 
2.39.2

