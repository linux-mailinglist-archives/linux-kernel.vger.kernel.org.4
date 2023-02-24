Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF96A16BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 07:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjBXGuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 01:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjBXGuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 01:50:03 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A912386B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:50:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DDC724206F;
        Fri, 24 Feb 2023 06:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677221398;
        bh=XEjX9AY/rxbyfPg1iE4VKDJGbOP+C/8aCuR0EDho4L0=;
        h=From:Date:Subject:To:Cc;
        b=RJNC2gX2MTkdFFrlC2XQ1+QOCIDwewtCU9rFAbNyqdbstuuKPcoGknHHgmWYl3JXT
         ffqH7j6PQz7v8fh0QNQS5odDEY+5+SfD71x5uba9eldJvea0aOhZPs9SwcktTGMOxh
         vM/wIgPK/23P4cGgWTS1wFSLG3/RHpvynTYQ3rK8kfS0EnbObYpKi0rOgqS3FDCzcB
         faLlt8QSxD+AZO+EfCkkjDNNYFU2UepDqpioFa1b563VtB5k3bLj1eMDGmtGqiKVUt
         laV1oK4GHQTxci+yRHsfsZwlVUyc67A2CNYb6Gx83CAv2zjRh2NwNKW08YBBQgjkVR
         nH/QMAotQYoGA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 15:49:44 +0900
Subject: [PATCH] soc: apple: rtkit: Fix buffer address field width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-gpu-up-rtkit-v1-1-671178cb2a5e@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAAde+GMC/x2NwQrCMBBEf6Xs2cU2Fgz+inhI4rZdhBh2k1II/
 XcTj29mHlNBSZgUHkMFoZ2Vv7HBdBkgbC6uhPxuDGY0t9GYGddUsCSU/OGMy+zDZOlug3XQFO+
 U0IuLYetS216laMae9z4JLXz8756v8/wBgXTYKH4AAAA=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677221396; l=994;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=XEjX9AY/rxbyfPg1iE4VKDJGbOP+C/8aCuR0EDho4L0=;
 b=2cGAkzXmm2kGa9fJLiypOR7qW7WO91eNDpFnITNoCLa72VF/iKWxb6QTZ6LDnRDpYw6LVm5hx
 +zxE9TPOBR0DEpl2fCyeB4hC+F6L8aBXAygukJSxy5swsiuQeGdX9qh
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer address field is missing two bits. This matters for the GPU,
which uses upper-half 64-bit addresses on the ASC and those get sign
extended from the mailbox message field, so the right number of high
bits need to be set.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/soc/apple/rtkit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 35ec35aa500d..a02a44a745f6 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -55,7 +55,7 @@ enum {
 
 #define APPLE_RTKIT_BUFFER_REQUEST	1
 #define APPLE_RTKIT_BUFFER_REQUEST_SIZE GENMASK_ULL(51, 44)
-#define APPLE_RTKIT_BUFFER_REQUEST_IOVA GENMASK_ULL(41, 0)
+#define APPLE_RTKIT_BUFFER_REQUEST_IOVA GENMASK_ULL(43, 0)
 
 #define APPLE_RTKIT_SYSLOG_TYPE GENMASK_ULL(59, 52)
 

---
base-commit: 83f978b63fa7ad474ca22d7e2772c5988101c9bd
change-id: 20230224-gpu-up-rtkit-f4bc18e78c8a

Thank you,
~~ Lina

