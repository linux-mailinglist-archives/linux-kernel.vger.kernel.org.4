Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2466D0127
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjC3K2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjC3K16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:27:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981658A47
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so18545001wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1680172072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tFot2qeZ2g5bJSVqE02JTKqWWEEsYCP5AgrPPpbM1g=;
        b=Kr79JUVmumwV3+sEie0htPM48raEk+XVN3Uigb4cPgz/Cwmmf2oedq9OELQ6vyXtK8
         Dm9nnTEzKOh0DsIg7z6KNN7AmuRWpDYSyJEKipM0uIJXOJTyxPTHftT9AH93utfGowMI
         6h+iHcfpohSBCDRVGzhWGQuNspw9LqCqebu19K9R6pxGDipKf5Nzir9Beq20sXWa0JqN
         xhuOQQVKRMX0leG+Trmm1hKWS/udYwoVtsuW/Ktl1lOHJnBKqXFv+y+vynPabLSsMar1
         bVMA8Z4oIwh9uLBzrCN+7RlswnX5LYLW59Kbl14Nh56ZvwcQsBkVMI32l4JwDsQz1jwY
         Qcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tFot2qeZ2g5bJSVqE02JTKqWWEEsYCP5AgrPPpbM1g=;
        b=T876V9vOz8zLKCMohiZA0bZzgX53hov5shDXNsC45EOOXmgEjJzlcAwC82bSqvMXxr
         6oU30ZciFuaM57tDN0JJ+1JuOate9OjBMusAv8d6w5Z+X6x930vhT7pZtOzaAgi+XEGA
         xmVw01DOun2xcbNhT4n7pNV25yaKtUYvjVNlV/g7L9K3CIEDJcBfwXPLF5fGQdLXxbx4
         2qQEGa0JfzlaIvMf0d1TPM7vZpCb5eTy+ggdAyLnQlGHfSlFfit0jqCkvDNRR25RLyQJ
         MUPpKp5mgmeeTSo2KM03kW7eMl2nW6euJf1Fxt1MARt4EZWaJ8NfqbNhd/9KqMh5xs4n
         AIyg==
X-Gm-Message-State: AAQBX9c1SGeuRLo/3TvbuotkFNanpY64KhFeUkOYwIxDM362PAJuUbQe
        fMattd1Nhn7VW/0OOLfKB5BrVw==
X-Google-Smtp-Source: AKy350b6LQoA5rGQpqDLFBlNL2/hnQq/IHj6AGMX6wydVEoKh/bfJ+60nOh+uj6nzNDIzsJxF6z8kw==
X-Received: by 2002:a5d:4dca:0:b0:2ce:9fb8:b560 with SMTP id f10-20020a5d4dca000000b002ce9fb8b560mr18901769wru.8.1680172072026;
        Thu, 30 Mar 2023 03:27:52 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm26352514wrp.42.2023.03.30.03.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:27:51 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 5/7] drbd: drbd_uuid_compare: pass a peer_device
Date:   Thu, 30 Mar 2023 12:27:42 +0200
Message-Id: <20230330102744.2128122-6-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
References: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c6f93a9087b1..e352880c70b5 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3226,10 +3226,11 @@ static void drbd_uuid_dump(struct drbd_device *device, char *text, u64 *uuid,
 -1096   requires proto 96
  */
 
-static int drbd_uuid_compare(struct drbd_device *const device, enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
+static int drbd_uuid_compare(struct drbd_peer_device *const peer_device,
+		enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
 {
-	struct drbd_peer_device *const peer_device = first_peer_device(device);
-	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
+	struct drbd_connection *const connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
 	u64 self, peer;
 	int i, j;
 
@@ -3465,7 +3466,7 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 	drbd_uuid_dump(device, "peer", device->p_uuid,
 		       device->p_uuid[UI_SIZE], device->p_uuid[UI_FLAGS]);
 
-	hg = drbd_uuid_compare(device, peer_role, &rule_nr);
+	hg = drbd_uuid_compare(peer_device, peer_role, &rule_nr);
 	spin_unlock_irq(&device->ldev->md.uuid_lock);
 
 	drbd_info(device, "uuid_compare()=%d by rule %d\n", hg, rule_nr);
-- 
2.39.2

