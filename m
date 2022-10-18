Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA806028F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJRKCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJRKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:02:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD69AF1A1;
        Tue, 18 Oct 2022 03:02:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 10so13395886pli.0;
        Tue, 18 Oct 2022 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HX99tVSM1rmC3ukGV0/miTpRAU7UnBmNE0xTCI/AilE=;
        b=J+sVV1Q8SY94v/FKhxfx3Ht4gnkVutppPRp8MWhmOijVClpynT+gjac4FLQZb/Kjda
         e8kvZvQjU+WAX0L5xgylWUdOmNui3vDLLL1+/prTadG/W1nu6T74dAfzBI9duA/hq/lu
         1eJIge/GVrtkNnJmGwzGiAmMPzWXeQidVpvmp9U+t9thW/sMg4rgG2FASPvJ3PLYQIlA
         KY+c9Zh3JChyF9NQRCKPNkFcRfg3k+Im0NIpVbpyOJdr3aY2QzZw/WznpfCNO3fQuZfM
         5eyaGDhKIN+q6oGnM2dzrujcG9TfiTeEnMBNwWgDj1Flgf4LHyaNu2pFvZpNmEO/MwOf
         jXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX99tVSM1rmC3ukGV0/miTpRAU7UnBmNE0xTCI/AilE=;
        b=Ne7myBVGnV1MA+r/FYnWd2gdF/UwM1ZFNMgiCeK/BMPocGWgZ9C6zf0Tu0MC2qUCkq
         Hd2OvbzMBw5fw5sIEtVyEGWq1NyMyIwbBjbeR8dl7AI+8R5/XwPKrpn8qClLqGohM/QE
         gG5EqAntAie998uLRJrPZCWLaL3anmMxTfAxosG7kxvrlfyTEoqU6pVrORbVccsNoe4Y
         WB8rJhs7v9e+ZlooBIs9olZgB5HXZ9S+3GTC/L5TbOe6GlBnA/2B8LT/vls8rdmSsCe6
         ViX+1qePNMgdvozGNlb9dAZAL2eujVqCIA0IUEMra5d8aCkMLX22CWYOtZwP5yoccQqF
         B2Gg==
X-Gm-Message-State: ACrzQf3xmTHqJWoKSQh7vu9sAekn3tTCOA2loM1ecLEAnDHAgf7lISrZ
        vGduwYgmWqkMB/QGigwKWPDsOpKaJ7binnsa
X-Google-Smtp-Source: AMsMyM4sAHo43edi+BR6O/wF8FJzJoUf4uFT6a3Mw1gooyy1iaOm6MWBDNN6LcZLaLFZnRxzvJWV9A==
X-Received: by 2002:a17:903:2144:b0:182:42ce:5778 with SMTP id s4-20020a170903214400b0018242ce5778mr2173798ple.46.1666087312246;
        Tue, 18 Oct 2022 03:01:52 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id j10-20020a637a4a000000b004405c6eb962sm7640355pgn.4.2022.10.18.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:01:51 -0700 (PDT)
From:   zys.zljxml@gmail.com
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] ublk_drv: use flexible-array member instead of zero-length array
Date:   Tue, 18 Oct 2022 18:01:32 +0800
Message-Id: <20221018100132.355393-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

Eliminate the following coccicheck warning:
./drivers/block/ublk_drv.c:127:16-19: WARNING use flexible-array member instead

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2651bf41dde3..5afce6ffaadf 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -124,7 +124,7 @@ struct ublk_queue {
 	bool force_abort;
 	unsigned short nr_io_ready;	/* how many ios setup */
 	struct ublk_device *dev;
-	struct ublk_io ios[0];
+	struct ublk_io ios[];
 };
 
 #define UBLK_DAEMON_MONITOR_PERIOD	(5 * HZ)
-- 
2.27.0

