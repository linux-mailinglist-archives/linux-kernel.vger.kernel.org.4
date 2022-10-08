Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DFE5F8421
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJHHqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJHHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:46:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866E159246
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:46:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r18so6419536pgr.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yy1hrG2GpPBkvn2HfQINffR+3hxzGXt2IgtYJPN1P7E=;
        b=auD42bYp121ROiFoAixlBntsidbY1hawD9jksLlHUfCGs+g1S33boZlc8IG52tq3LN
         DX3zkFHJMskR9WbEfqaIU3wWP2PYec++sWTNaxJ+jm/6Sc/mlQCL57/xC3g6z8bdDGzp
         EqRUliodvHvnOoW98Z6z+P8C9u0UOxm965lxZO0jk3o0DBucSnhvgc/Noh0foIWdCPo1
         IpDQTDjQ1Xb46qq47hdQJsExw1k6iJAlOma49I3UhOIkTQqVIW3vnwh2GfMB+HZKRAC9
         YNZ+9lFYEDDf82yOzWn7uDWc+lc0U/2O7VNLesgUBHl+ixcvrRL2tAfsnNKxAG71wtVg
         J12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yy1hrG2GpPBkvn2HfQINffR+3hxzGXt2IgtYJPN1P7E=;
        b=Z2nPZ034H9TlITr7Be9SHs9DbWFeNLfX/Hexk7zNpLWu9OZlGfj/JGCZ1WCj3M6NaP
         6C38e5wYcwiM2ec2v10P8Md7AIziI0Xs6B823ZeOnhc0MjEtNsw9CuRCKwvSni6fJ2Hh
         T8Lx7rGpE3kCYKswyojQN6qrSLMqI8FbwKFbtkqb0Vx5428C+rkvaYCSY11ZIa3lA+VY
         bD7H+ZALPFSv4izpnT2IfBKSdx5NSZzvF9lSuuiuvM5oZhdF9M/GZ4qC7faBfdoTP59l
         IOtjAY3rW5c3uEhppwSsdHHR0jvTcNdqErnzwXrYW9NJ81P51Swc8C+hewpcX0LRbOdA
         Ia1w==
X-Gm-Message-State: ACrzQf3GND6otX0YPR+aFPVfQ02dUQnSqIIb6cHaAlE8NQFPOYSaQyWC
        CAIflQoQ2F9IT06CTt5QWHk=
X-Google-Smtp-Source: AMsMyM5rC5UzbfGyUKVwo477N415VnISLNMlKqnEO7xakBGPSl2Z3+N74oa8uaYCPuiv4SH83PF1mw==
X-Received: by 2002:a63:581e:0:b0:43c:29a0:6390 with SMTP id m30-20020a63581e000000b0043c29a06390mr8029983pgb.552.1665215209070;
        Sat, 08 Oct 2022 00:46:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b005365aee486bsm2852880pfj.192.2022.10.08.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:46:48 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, wsa+renesas@sang-engineering.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] mtd: replace strcmp with sysfs_streq
Date:   Sat,  8 Oct 2022 07:46:43 +0000
Message-Id: <20221008074643.308969-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_streq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mtd/parsers/cmdlinepart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/cmdlinepart.c
b/drivers/mtd/parsers/cmdlinepart.c
index b34856def816..6a401e0b1b95 100644
--- a/drivers/mtd/parsers/cmdlinepart.c
+++ b/drivers/mtd/parsers/cmdlinepart.c
@@ -154,7 +154,7 @@ static struct mtd_partition * newpart(char *s,
 	}
 
 	/* if slc is found use emulated SLC mode on this partition*/
-	if (!strncmp(s, "slc", 3)) {
+	if (sysfs_streq(s, "slc")) {
 		add_flags |= MTD_SLC_ON_MLC_EMULATION;
 		s += 3;
 	}
-- 
2.25.1

