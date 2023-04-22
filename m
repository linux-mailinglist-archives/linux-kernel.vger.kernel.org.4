Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B31D6EB9D2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 17:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDVPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 11:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 11:04:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191B819BD;
        Sat, 22 Apr 2023 08:04:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a526aa3dd5so34363415ad.3;
        Sat, 22 Apr 2023 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682175839; x=1684767839;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfAo/dxreW/uigF9ipHrmiuIgnfgix7IRNyvfV3apuQ=;
        b=kplYe/cTNPWzdBDRIgkzD26gPlImuWavD9OmX9VrLT29miTb1ufHqQ8QbB7VP1Vq+D
         lo0TTohsHVN/bZaZO8800FE8/Bd4GDZ8/7PMaS6sJVnkv7OXuTbUm4nO1uQzYsUuUZfO
         GXL1S6QPNnvjuCZNyk6UaKckTxnojK3GD4G6gQs2ATmh6ScmDebfD20PW8/fzDGf8S1E
         3pjvc8UBq3YML0YLuWHVkuH4Qh1T2Al8jUw326nz1oijGwuJNqNpcwXU5FDBrOf1sGZc
         fRa/zMiw2MdhyioWYfyzsskWsK6Aio85SMsQa/RB8ArweR8Wa62b8U4unh+mF1XB5LKH
         WbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682175839; x=1684767839;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfAo/dxreW/uigF9ipHrmiuIgnfgix7IRNyvfV3apuQ=;
        b=gSh6B5GApGSTkGNyZ4YOOwZDZ11f8RCzoZfTqnZpJOaus5fpsOd6gC0wuPYw7YtEwd
         S5Zzm05p8W/CPQwG+/jLoUskURAS697bMi7r621LzfSWFRslt+oYbxznDlrf8fuZQLLY
         5tRqlHvhBzCGYXFqxI9bhmZjsbEYOetpqqNysm3UTvvOE3ga5zicD6KijHbI08PIKpDq
         qPCSypog54uvvNTLu+4+sq3oW4+v2gEWC1EgAN0UkAnMMu0CwHz8IPvnNHqEymMqtef2
         iS4PuyPvdMgcRhvkMIburi02JcQHNisiO1jOjk2Ny9AVyrZQTGpu7MJbKLf7Ha40cpcS
         Z/hg==
X-Gm-Message-State: AAQBX9dUp8AZkNqZ4bJorBhcpeXxE7OgqgVRkB1fTHKdBsq+3Oox+rPX
        uPDUHMGbdqlomL/NRik4eiQ=
X-Google-Smtp-Source: AKy350Z7G1Y/sgwTVvFKh+wH/R8tXE0+c/A/R974D7kOo4c0Z/Hhx+30zhWyEBqI8bPHDIhpGi+oWQ==
X-Received: by 2002:a17:903:32cc:b0:1a1:f5dd:2dce with SMTP id i12-20020a17090332cc00b001a1f5dd2dcemr10828357plr.6.1682175839453;
        Sat, 22 Apr 2023 08:03:59 -0700 (PDT)
Received: from localhost.localdomain ([117.172.46.191])
        by smtp.gmail.com with ESMTPSA id jh21-20020a170903329500b001a52abb3be3sm4163497plb.201.2023.04.22.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 08:03:59 -0700 (PDT)
From:   "logic.yu" <hymmsx.yu@gmail.com>
To:     robh+dt@kernel.org
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of:Use remote_parent instead of remote
Date:   Sat, 22 Apr 2023 08:03:43 -0700
Message-Id: <20230422150343.43569-1-hymmsx.yu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the parent node of the remote node is obtained here,
it is more reasonable to change it to the remote_parent

Signed-off-by: logic.yu <hymmsx.yu@gmail.com>
---
 drivers/of/property.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index ddc75cd50825..ee5f0c008b40 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -835,7 +835,7 @@ EXPORT_SYMBOL(of_graph_get_endpoint_count);
 struct device_node *of_graph_get_remote_node(const struct device_node *node,
 					     u32 port, u32 endpoint)
 {
-	struct device_node *endpoint_node, *remote;
+	struct device_node *endpoint_node, *remote_parent;
 
 	endpoint_node = of_graph_get_endpoint_by_regs(node, port, endpoint);
 	if (!endpoint_node) {
@@ -844,20 +844,20 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 		return NULL;
 	}
 
-	remote = of_graph_get_remote_port_parent(endpoint_node);
+	remote_parent = of_graph_get_remote_port_parent(endpoint_node);
 	of_node_put(endpoint_node);
-	if (!remote) {
-		pr_debug("no valid remote node\n");
+	if (!remote_parent) {
+		pr_debug("no valid remote_parent node\n");
 		return NULL;
 	}
 
-	if (!of_device_is_available(remote)) {
-		pr_debug("not available for remote node\n");
-		of_node_put(remote);
+	if (!of_device_is_available(remote_parent)) {
+		pr_debug("not available for remote_parent node\n");
+		of_node_put(remote_parent);
 		return NULL;
 	}
 
-	return remote;
+	return remote_parent;
 }
 EXPORT_SYMBOL(of_graph_get_remote_node);
 
-- 
2.17.1

