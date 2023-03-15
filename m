Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42296BABBC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjCOJKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjCOJJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:09:29 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D42739;
        Wed, 15 Mar 2023 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MP1L1kZAaysXUeL2NiJnvDJlsldUV5D8hJj4fTXBLAg=;
  b=qQQ5QxU+RKTbYCtFpC0w+eFvfiiZ1Pyh1M9Ae2gLl2Ok0pqCc4Ky/Inp
   dLr2R5L0fCkrKQNYqc+OhyQ22tvtp4oZDxypnnQTY9TK4d7dUuIgcYQvI
   7h0eKZjVeoGnAFotV9NqybWdyOdU4rbAIs4wJVNleOa9apZsxgsIHtywz
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,262,1673910000"; 
   d="scan'208";a="97303132"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 10:09:09 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp-mt9m114: adjust macro parameter name
Date:   Wed, 15 Mar 2023 10:09:04 +0100
Message-Id: <20230315090904.20092-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro parameter name, sd, captures the field name in the third
argument of container_of.  Fortunately, the argument at all uses is
actually sd.  But change the macro parameter name anyway, for a little
added safety.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

An alternative would be to make an inline function.

 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
index 0e5a981dd331..b47d0882041b 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
@@ -35,7 +35,7 @@
 
 #include "mt9m114.h"
 
-#define to_mt9m114_sensor(sd) container_of(sd, struct mt9m114_device, sd)
+#define to_mt9m114_sensor(s) container_of(s, struct mt9m114_device, sd)
 
 /*
  * TODO: use debug parameter to actually define when debug messages should

