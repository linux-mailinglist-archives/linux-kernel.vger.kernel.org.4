Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024DE65F3BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjAESdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjAESdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:33:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E7564CE;
        Thu,  5 Jan 2023 10:33:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z16so20509599wrw.1;
        Thu, 05 Jan 2023 10:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eUPwa7KxD0+pG9NyQ6Wyn6qhlGS+n6AKwqwRVnYWk0Y=;
        b=KvVT9tPDVsA9kdQufrBybdgLUcJV9JBGQ2sh5Ji3kWzMT6O24oSJb5bJpNnkkR/kou
         HRcWREqSE+zfoM28vgUH+ZrCjfvrRXaprPpOU7qVZWcKRmTywkNipIqjUQaJSWlse2oJ
         l/roJlFRC5AW8fraHY5vuSkYHc+FDAqQY5jwU2SqkNzLx4iKm4KnUklBtmuHu/xemLSl
         KL6D9T1IIE2oLPXxz6ZyxB3brQUrWSqo+opkiLRSSvvXpzzGhivxtYIZnXqUD+YHViaf
         J66jXfAjrq/ZWQ7+ft2k+lxbGxaBL5TOOQE+HdE//KoMSL9jVuj3Ip+r7CTR//nMRyIP
         do2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUPwa7KxD0+pG9NyQ6Wyn6qhlGS+n6AKwqwRVnYWk0Y=;
        b=lyUnyV3xEIkFM0M9ahyP8urXOquD7Yl3rCU5vR4v9XIk9SLYh+Kh/jKysWZ1xSaU2t
         ML54N8cSSRoMXJsjd7QZAjpOf7Sd6dLWs7oSuxdyOX+YCJ1D8W6f75QExr/jTfmQ7F4d
         A1RJNEW9kCgPMiJw6qAOYsrPzi6QopXBICKAtPxYzIaxl3JBry9rmBACEaien413aXze
         5N9cwquh4RbkgXf3NBJjXRTgMS2IrNOWtNF7fzFLw2ClC4zeiWvidpyYpZbRjHrs+Vog
         SL/UHWSrY/qBrmJv5mJUZlgwfMi/k/109w8IYU1nHanEiR3sgwNQtLQEGV7KMtEDYWs7
         Hx4w==
X-Gm-Message-State: AFqh2krDsAvXnTw3BW1v3uIFzs2vD4P5aNt/7CJfGtt3KdMpIfiwuUfZ
        Jxp2+fxh4ZmOthyCDo0Z+zdT71vYhBsd8yzy
X-Google-Smtp-Source: AMrXdXtZIqBiAhbDcFGq0bT49zrMcD7N+SAhYjRhbse+8LWS/ce9Rc9rg6YxXIbYWh99v0rgNeRlIw==
X-Received: by 2002:a5d:4005:0:b0:242:5877:1ebc with SMTP id n5-20020a5d4005000000b0024258771ebcmr32457681wrp.33.1672943595922;
        Thu, 05 Jan 2023 10:33:15 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d410f000000b002683695bf97sm37377687wrp.58.2023.01.05.10.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:33:15 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: vidtv: make const array DURATION static
Date:   Thu,  5 Jan 2023 18:33:14 +0000
Message-Id: <20230105183314.62820-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only const array DURATION on the stack but
instead make it static. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index a5875380ef40..ce0b7a6e92dc 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -1940,7 +1940,7 @@ u32 vidtv_psi_eit_write_into(struct vidtv_psi_eit_write_args *args)
 struct vidtv_psi_table_eit_event
 *vidtv_psi_eit_event_init(struct vidtv_psi_table_eit_event *head, u16 event_id)
 {
-	const u8 DURATION[] = {0x23, 0x59, 0x59}; /* BCD encoded */
+	static const u8 DURATION[] = {0x23, 0x59, 0x59}; /* BCD encoded */
 	struct vidtv_psi_table_eit_event *e;
 	struct timespec64 ts;
 	struct tm time;
-- 
2.30.2

