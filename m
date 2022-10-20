Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9660648C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJTPbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiJTPax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:30:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491917D854;
        Thu, 20 Oct 2022 08:30:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so35109531wrb.13;
        Thu, 20 Oct 2022 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iPQjPFTjC0qMsvit10ait3Iowd1EofoGDFX3tHvmwvY=;
        b=dzVoNA4F/kQJT/mBsDBrzBYPMiGm5jeUOaJ6oxh9yO2QTxeBcnp2JL8uejgdmFbMWQ
         Fa6gQr2Txx8b55bW3DwWarAqg7isndU869zu6vvmUlJqVbG1au+88ecQN2lj4jZvCk1U
         OBiQ/bcGvhO3T5AucHxJ0TKqqqVZeDijHYkqdcQIhHbXXVi6rPf0CzcTCCJBDTfqjBFy
         EhY1m4PwKTaiDb2iZqmCyT5TD7lNug+gTUDbkHVEE2HzZIiGUkldxdvXK5zsSgtWqW5X
         4Z8j0JigS7BrkpkFq+GnjMnwl1beoYwx5lNfllD3Byxe6vl+ejtMdSQPNj6VAtqH0sND
         OuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPQjPFTjC0qMsvit10ait3Iowd1EofoGDFX3tHvmwvY=;
        b=qEwk+feve1Su1+NeqdKCQ16ISNfVq0+NFI3xLqjw0REAC3GHOVsiaNRnkQjM1X3+lX
         5ISIge440j5rJnKsx6NXTm9s3RDlvv7ZdPYk9z25G9ZpBeTpMpSLTkYxQHKpXFl3LiUT
         fbd049aYXzJMvXwemqDwvmuk7/w+DAxZp5TvvG5n3HUTSfc91txvRrl+9KsxMn71CBdd
         OqaOyoGiO4zVpz6+snklHezMP5HX0pN9ah2Z2eViQ/sd77+Rs/JwiU+ubIgqd3ddwsZu
         Jv7K8vydObjw1N4oWHG6PdsTf9DCOJii630zxfw4jMfghRiHJaPygwEfzwTNcm4xPDDI
         o/+g==
X-Gm-Message-State: ACrzQf0ge0mk5aimR0IxOpjrZPu6Vb68cfoi4sIA0zjVgsp4P9dDymN+
        OExXrKQj/si1l0cSk23qBou8tobzXduAog==
X-Google-Smtp-Source: AMsMyM76+pdj4NBSwtpYXzW1ZE7v0SXxKGHBL1oMQy0SspGtIzskwiTN6umZfBVPC09nX4mBn0jOxA==
X-Received: by 2002:adf:d842:0:b0:22e:33e2:f379 with SMTP id k2-20020adfd842000000b0022e33e2f379mr8913268wrl.23.1666279844608;
        Thu, 20 Oct 2022 08:30:44 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c1d1000b003c6cdbface4sm169886wms.11.2022.10.20.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:30:44 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Song Liu <song@kernel.org>
Subject: [PATCH] raid5-cache: use try_cmpxchg in r5l_wake_reclaim Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in r5l_wake_reclaim.  x86 CMPXCHG instruction returns success in ZF flag, so this change saves a compare after cmpxchg (and related move instruction in front of cmpxchg).
Date:   Thu, 20 Oct 2022 17:30:34 +0200
Message-Id: <20221020153034.7905-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 drivers/md/raid5-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 832d8566e165..a63023aae21e 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1565,11 +1565,12 @@ void r5l_wake_reclaim(struct r5l_log *log, sector_t space)
 
 	if (!log)
 		return;
+
+	target = READ_ONCE(log->reclaim_target);
 	do {
-		target = log->reclaim_target;
 		if (new < target)
 			return;
-	} while (cmpxchg(&log->reclaim_target, target, new) != target);
+	} while (!try_cmpxchg(&log->reclaim_target, &target, new));
 	md_wakeup_thread(log->reclaim_thread);
 }
 
-- 
2.37.3

