Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B727068A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjEQMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjEQMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:50:57 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68212C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:50:55 -0700 (PDT)
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0353344C1013;
        Wed, 17 May 2023 12:50:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0353344C1013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1684327853;
        bh=h7k7IjaeYzyFxPTC4mEC6bmcyhUzoxN00mMqNdxUGSg=;
        h=From:To:Cc:Subject:Date:From;
        b=g/OEql6tAg1SqO9kI1+t20szxBfxViphCwy3mz7i3B140ti2ATwHc2mWV0Yp1oGCZ
         za6d57Ot4FcIBxKvfX0EVJoMVNPMiAvFeuGXuma6N4jDhmZrm9kn/K6kFMVvCS+QD7
         jOwK74VugpXgOdKg0mk8PYvXCdojEDnQWh5RAiEE=
From:   Vladislav Efanov <VEfanov@ispras.ru>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rene Herman <rene.herman@keyaccess.nl>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] isa: Remove unnecessary checks
Date:   Wed, 17 May 2023 15:50:25 +0300
Message-Id: <20230517125025.434005-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isa_dev->dev.platform_data is initialized with incoming
parameter isa_driver. After it isa_dev->dev.platform_data is
checked for NULL, but incoming parameter isa_driver is not
NULL since it is dereferenced many times before this check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a5117ba7da37 ("[PATCH] Driver model: add ISA bus")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
---
 drivers/base/isa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/base/isa.c b/drivers/base/isa.c
index 55e3ee2da98f..675ad3139224 100644
--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -149,11 +149,8 @@ int isa_register_driver(struct isa_driver *isa_driver, unsigned int ndev)
 			break;
 		}
 
-		if (isa_dev->dev.platform_data) {
-			isa_dev->next = isa_driver->devices;
-			isa_driver->devices = &isa_dev->dev;
-		} else
-			device_unregister(&isa_dev->dev);
+		isa_dev->next = isa_driver->devices;
+		isa_driver->devices = &isa_dev->dev;
 	}
 
 	if (!error && !isa_driver->devices)
-- 
2.34.1

