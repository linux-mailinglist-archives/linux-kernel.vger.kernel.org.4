Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB006064B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJTPgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJTPf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:35:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE98A1805BF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:35:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so2493192wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz6rkNFT+N3+z5GHliBzDaeRK81yOrfk7eIGZzmG81Q=;
        b=LrPvFB8gDO64B7UiPcOEb4r4czILVjpCtcxZINcfAFDa3JVnVixw8m/oGT/SX21zP/
         Gr0oby3J6kWKup8VmdmabJ/RmMiUTF41qbixfM8VEDJItjOUfbI+i4eL5pPeXKNAC14E
         dFkAG4sTNCeJGTXP9FerhSiUuerkXXeqxmrzw4EjmqkkUs0TqQd5EofrRaek32k73Lrv
         hovubnAzUZ9PQje3IfBFZK8uo/EOI95RVgx3leGIGBT81cFNKVXmL2Sc4MI9FZ2Jo2o3
         E4+/DFmy8GAK+x+xJAmWJ9xFNcSRq7lHXKBFpaqNZHYOCvETpZaQ5vW86279Aqavyawn
         TvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz6rkNFT+N3+z5GHliBzDaeRK81yOrfk7eIGZzmG81Q=;
        b=HjTlqOl27t/sUXkJ9zTRd79JGMFY7fObKki/jhbBgB0kKN1vxOZ9ur/Z/104wOgPm+
         w7JN186DP6ul6+u1Sm8cIcBezs5MQiYiMuNaLPyZqBMq6FKcOfM/Xc9lMBMuyznYhwlA
         dff3E0T8vmG0u0g/T34CuCyE+xyAXbU+H/ZmuWSDrnByaTulEWdVEPZimR+NamFRA/oF
         HqmCmHSspaQlrDXm/tNbv4H25TgK7r48wPZYOr7A6S9CJr+LeplmFW/CkSXQg2tN84Df
         jJC7J34lCpcbMzDmjdwKQOpXn6fOIOujijVyAgQVz6LUPhGD72SWPn7CRWlthPX2iCC0
         4Xag==
X-Gm-Message-State: ACrzQf1q2Aa6vjFOiHFvhuOrpi+oACZ94NE3TwgUqEvK5Ao8BdhY2DOO
        ottUlc5n1QM8hGNKas+oZr4=
X-Google-Smtp-Source: AMsMyM4pV8NHWIEwjJS69o/OmV0HUECe6P8KknLlVHAsYIYC4Dfxg1lkV2Mfvx/hOkcIzm80PmhVSQ==
X-Received: by 2002:a05:600c:4f46:b0:3c6:fb4f:3e1b with SMTP id m6-20020a05600c4f4600b003c6fb4f3e1bmr9922108wmq.159.1666280151918;
        Thu, 20 Oct 2022 08:35:51 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id u11-20020adff88b000000b0022e2eaa2bdcsm16486515wrp.98.2022.10.20.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:35:51 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvmet: use try_cmpxchg in nvmet_update_sq_head
Date:   Thu, 20 Oct 2022 17:35:40 +0200
Message-Id: <20221020153540.8226-1-ubizjak@gmail.com>
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
nvmet_update_sq_head.  x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg (and related move instruction in
front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 drivers/nvme/target/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 14677145bbba..a384a0927aed 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -695,11 +695,10 @@ static void nvmet_update_sq_head(struct nvmet_req *req)
 	if (req->sq->size) {
 		u32 old_sqhd, new_sqhd;
 
+		old_sqhd = READ_ONCE(req->sq->sqhd);
 		do {
-			old_sqhd = req->sq->sqhd;
 			new_sqhd = (old_sqhd + 1) % req->sq->size;
-		} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) !=
-					old_sqhd);
+		} while (!try_cmpxchg(&req->sq->sqhd, &old_sqhd, new_sqhd));
 	}
 	req->cqe->sq_head = cpu_to_le16(req->sq->sqhd & 0x0000FFFF);
 }
-- 
2.37.3

