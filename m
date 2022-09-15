Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2F5BA1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIOUaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:29:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5D30F5A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:29:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id 13so15731325ejn.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=v1YzXJ4RvumAwk7bF6dhyR+VAPv7fcA5m5FBuJy0qIY=;
        b=qPH+EslmJox4jB/AYeCJVyO2sQGqb2P7YW0rUcwI0rqV6lVGQ0zsfxckTccO+35RwJ
         D54NAIXUhnx7L7+nGaVxxv/YcyCGx7zWRSQX/OQmQEcBb/zUyF/9gMZQnD1kvz9iOf/3
         QU7WSvojdZ4m9nGT/BwQC6Ccxci9CIg29PqKNyiwXxKVXkJOrYCS2ulm0PvBVxsqN+1c
         7cPXwm05Gr27KWuIEnv4VON0gniO/kzAXrAI3Q95bZyjILHTlvunb/22gFl3YPJ1mrfR
         uMV2GjSbArOlKqR2BEweVwf76cVk3ig9sQ1CH3tXZv4JnX8gTJMf7xlfdIaG6w7HJa9p
         lV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=v1YzXJ4RvumAwk7bF6dhyR+VAPv7fcA5m5FBuJy0qIY=;
        b=d5qPa+B9/3gKXXj+Rqs6WAiwHhCbmpHKmjvuOAkoo+ZdM+OOPcZDkehVanHtZ9EZgT
         bATS09DCkMahetIGisbWtEtuYNUL8ZhGVQEqCNth3FscX8ODSKsrrOfWvx0w6KBfnkFu
         AMyLbWlQ0AEkCD69FuXGgg7k46nTgq81q4snPXQI8H+y36XAK9OQEdLl/ONN5yiwZ+4Z
         eS3zpag67hUAAqQNJMYIPLtpRz3D1Zu2nqIcYIiX7+5LRKnuHZ0IIpcrhAMqtEhjx6SV
         qrACrte4Eq65LvYOjWZx7dBlxMF552JDOaVUl99neq6ZuWFbPNW1ldTxa1rROxMUfX6h
         c70w==
X-Gm-Message-State: ACrzQf3YC/fKXRqCoLuN/KtKRZiycX8Q+JnurVRQ0chEaKa000/FsVDr
        fdDMyC/eGyUdpYQd71zDamQ=
X-Google-Smtp-Source: AMsMyM7mkHT26n8JwF9D9Gn8feUc/Kvkri9ZB0b/ZgqMXdfMsg8jMzESijFS1oWsnlJuXB6RvCrfRA==
X-Received: by 2002:a17:906:ee86:b0:741:89bc:27a1 with SMTP id wt6-20020a170906ee8600b0074189bc27a1mr1133421ejb.725.1663273796925;
        Thu, 15 Sep 2022 13:29:56 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-43.ip.prioritytelecom.net. [217.105.46.43])
        by smtp.gmail.com with ESMTPSA id ci25-20020a170906c35900b0072b3406e9c2sm9607295ejb.95.2022.09.15.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 13:29:56 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH 1/5] staging: vt6655: remove redundant if condition
Date:   Thu, 15 Sep 2022 22:29:32 +0200
Message-Id: <1e26ece88d2fbf6dafff8694d70a8e52dfb3c077.1663273218.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663273218.git.namcaov@gmail.com>
References: <cover.1663273218.git.namcaov@gmail.com>
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

The function vnt_receive_frame always returns true, so checking its
return value is redundant. Remove it.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 04d737012cef..79325a693857 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -832,12 +832,12 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 		if (!rd->rd_info->skb)
 			break;
 
-		if (vnt_receive_frame(priv, rd)) {
-			if (!device_alloc_rx_buf(priv, rd)) {
-				dev_err(&priv->pcid->dev,
-					"can not allocate rx buf\n");
-				break;
-			}
+		vnt_receive_frame(priv, rd);
+
+		if (!device_alloc_rx_buf(priv, rd)) {
+			dev_err(&priv->pcid->dev,
+				"can not allocate rx buf\n");
+			break;
 		}
 		rd->rd0.owner = OWNED_BY_NIC;
 	}
-- 
2.25.1

