Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91C865CE1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjADIPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjADIO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:14:57 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F54EDEAC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:14:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jn22so35133801plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w/04hUj4xs2kUGhGVqnYdX4sziWnoObx5V1B9hl5JqQ=;
        b=k8HeThodh9qWBuxngqyacfo4g5+HB73+0h0H85Qmckf/9uMZvGJL9gngLx3ZIff0dM
         r03BcCuQi6K9FFuixjlzx+WJbZxyI3lexAq5fyBABaPPpvke8UYXKmjJGAGvwGYbfAQN
         LUxtzEgxVofHfiChEV/lGguxf/xdMXymcBsx0vB68i6JagguiWdsOuIaKiNXrU04TFY0
         Ot3ozNrBGw1aEqfVZbFHDIXrdZfs5nz3ct+8NhrcF4wgofXPj8meUKZTOY64I6ArPIAm
         mGPQ5fG2sg+YdNrGF0D+CkkKKhrtOP6M4u2J9kiaT882Oo2rRoRitFgRzpCDdY3Jnwf9
         rByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/04hUj4xs2kUGhGVqnYdX4sziWnoObx5V1B9hl5JqQ=;
        b=W9TCdp/V/Ocj7rDLhJC3ib1JTQ3qIGty3hpRQaPvr36u0SyqMXKVIyy5wcVp4gwB7s
         4ASx5U8Sdy8W2yCEI0Z6EKv4EJzNr3ihWmqmewN3cTw9tqtoswjuOSqc/VfuCqCwYEud
         FlsdXMx6k/uYxl0droehPByqWGS6kPyhocCtYZmau5ovFfhSvEynfA+MwJjY4UZ5++FW
         wGz1fosjreglCbXK7qqQVc5eM9m+rXor2lHoxqoGgrL6po1gjeKSqTcoeosV9+XyPJB7
         AY/2xrVW4b2MI5Sr4//HgQFi+EexEIXlmnLpKvSpbuhkFQXv6wN7ijwwMNuIHrbyYopO
         ngww==
X-Gm-Message-State: AFqh2koBs80goJ+DvxRENMSrxVVAvrQuKuw9bUSgHYIIGHCnaF8AYIBY
        GrsqZnXjDbd95Bp8ITHEW/FcO+sgFFh5tQs6
X-Google-Smtp-Source: AMrXdXuDFLOCGLvqEhuVA1P7tjZlJqfU64nI5+pYdqKdUcbHTBl2EGtG14HtgdicEweAx+q8+TYc6A==
X-Received: by 2002:a17:903:110d:b0:192:8b0e:98e1 with SMTP id n13-20020a170903110d00b001928b0e98e1mr37809520plh.54.1672820095871;
        Wed, 04 Jan 2023 00:14:55 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id g12-20020a1709026b4c00b00186a2dd3ffdsm23420819plt.15.2023.01.04.00.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 00:14:55 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] um: vector: Fix memory leak in vector_config
Date:   Wed,  4 Jan 2023 12:14:05 +0400
Message-Id: <20230104081408.4074275-1-linmq006@gmail.com>
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

kstrdup() return newly allocated copy of the string.
Call kfree() to release the memory when uml_parse_vector_ifspec() fails.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- only call kfree() when uml_parse_vector_ifspec() fails.
---
 arch/um/drivers/vector_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index ded7c47d2fbe..131b7cb29576 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -767,6 +767,7 @@ static int vector_config(char *str, char **error_out)
 
 	if (parsed == NULL) {
 		*error_out = "vector_config failed to parse parameters";
+		kfree(params);
 		return -EINVAL;
 	}
 
-- 
2.25.1

