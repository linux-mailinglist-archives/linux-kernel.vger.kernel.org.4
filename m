Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB05EE2F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiI1RXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiI1RX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:23:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5FA7EFF6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x92so5018566ede.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=eetEjuSkhalPLHiWeGxus8bROhu0lZ19os/TvMTlIMk=;
        b=ICUhpvuZDb1P0hySZ0jMjdsGrelSzCxJz6y7FWYeAw3HkgJRjYOrdoWYTwfYpsBVdU
         CbTu59RWHtYEtAwdbxNRvAJxymLYM/h/1qUuuRuIqy9jPYwPb7jyP23mwSUspqHpJTH5
         KCkD7IwOJ4bYZmQzxuAa8ZXCgM8R9/dAL/KoKxu+576xrB6lEM2gpMvEJym2jZH8ABD1
         WftJv3Vm0H4ezxR7ov49EJrkpAVKa8In4JyJXwaym7DNBeoK9MG+mqZdgs64ljRDXssy
         EFhxleX5U40/JoufCLmO33rqIIXZQzTgAbQOUM/ac0qSCrb+2CJ3vYNUiNZLDEbiljxm
         6TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eetEjuSkhalPLHiWeGxus8bROhu0lZ19os/TvMTlIMk=;
        b=jHNsuWWsgKuVFZ41aZrgjrRgvXkLt5XvJWuW0TdIYIMDfMWpNudRwNC2TMjyM4T4qo
         TNtNKf7BVSyn5SG6yHvlyXQpakE9tTvcJxYr0xCPI/0Mw3Mw1BUa3lrBQGJ//BgewNlP
         QDoRdrHJa/9rvR38/RUoNBdP2uf1rb/hEhO+vDM2n0pvZb+FFLIOnw5S8ubljJeZoUzR
         V+sq8dOVh6Vr8rzr0bTBIUhOSH936CFPLgpW17IQo8Bo7bR3O/0OEoUXtSvwVsuswtkc
         RDoQTqGlU+jfUR7ZuikwK+476Uz4skGP/pMnYpsh4ECyXzHZqpUQ9Iwat0pnb+XzPeZ9
         W3sw==
X-Gm-Message-State: ACrzQf14MxFGapGS1R9tKbL1a157gJsHPSSp6YtE0h1hTVsklf3obCWj
        vKEfdNyUUS+GvdIxzSqGWbI=
X-Google-Smtp-Source: AMsMyM4wxvJ3D8J5tE4tZn09em8hcwFLdyJED6h2K7abaMEOO7BP9RQwxEq78YUqvIeY1fgC3s7vIw==
X-Received: by 2002:a05:6402:559:b0:457:d9fc:6870 with SMTP id i25-20020a056402055900b00457d9fc6870mr6149450edx.183.1664385805041;
        Wed, 28 Sep 2022 10:23:25 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170907784600b007306a4ecc9dsm2725063ejc.18.2022.09.28.10.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:23:24 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH v2 2/4] staging: vt6655: change vnt_receive_frame return type to void
Date:   Wed, 28 Sep 2022 19:21:48 +0200
Message-Id: <ab73e7575e2ddd07e71051c6af0ef255bd7cfea4.1664384503.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664384503.git.namcaov@gmail.com>
References: <cover.1664384503.git.namcaov@gmail.com>
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

The function vnt_receive_frame's returned value is not used anywhere.
Furthermore, it always return true. Change its return type to void.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/dpc.c | 8 +++-----
 drivers/staging/vt6655/dpc.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/dpc.c b/drivers/staging/vt6655/dpc.c
index c6ed3537f439..3bf60039fa9a 100644
--- a/drivers/staging/vt6655/dpc.c
+++ b/drivers/staging/vt6655/dpc.c
@@ -115,7 +115,7 @@ static bool vnt_rx_data(struct vnt_private *priv, struct sk_buff *skb,
 	return true;
 }
 
-bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
+void vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
 {
 	struct vnt_rd_info *rd_info = curr_rd->rd_info;
 	struct sk_buff *skb;
@@ -133,13 +133,11 @@ bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
 		/* Frame Size error drop this packet.*/
 		dev_dbg(&priv->pcid->dev, "Wrong frame size %d\n", frame_size);
 		dev_kfree_skb_irq(skb);
-		return true;
+		return;
 	}
 
 	if (vnt_rx_data(priv, skb, frame_size))
-		return true;
+		return;
 
 	dev_kfree_skb_irq(skb);
-
-	return true;
 }
diff --git a/drivers/staging/vt6655/dpc.h b/drivers/staging/vt6655/dpc.h
index 40364c0ab7f6..f67c1ef23171 100644
--- a/drivers/staging/vt6655/dpc.h
+++ b/drivers/staging/vt6655/dpc.h
@@ -16,6 +16,6 @@
 
 #include "device.h"
 
-bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd);
+void vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd);
 
 #endif /* __RXTX_H__ */
-- 
2.25.1

