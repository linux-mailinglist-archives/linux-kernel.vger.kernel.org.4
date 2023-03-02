Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC916A82E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCBM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCBMzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:55:39 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33634E5C3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:55:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o12so67112735edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 04:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1677761730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kxDLEHqeSUzC07bB1oJ0MhsEczzoLXd9EtZFkAmxP8=;
        b=VsQz9FhdRKRUmHZD9G4GNRJ454L7tKxaTS345k7aLCTJeR+OHIfOvpLCuA5wndRXlC
         82gkRGUj4ue7MyzthafS9UNIdwK67PDkzgOzVxHEt61mqB/o3NQ1iMVBL/WO8TtYDNQ3
         H3a0UNzaJB/wFAVc8oZ9YrdQyclihBoBAHrG84vDbmO/Lren53oZB6ry6cnosf4kuluN
         eGhi2ThiEJmCiClCbNyyUUM+1HyoPiWEO9ZkTzA/AA+xkDEtsW+h0OO4vXiCP8OWvl9b
         SSfN3UwdSzg6qL1af6CzPCgx1C0GUe9Z9J2jGME76Thl9G8izfhtspgH2aUN3tg0uCuB
         7mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677761730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kxDLEHqeSUzC07bB1oJ0MhsEczzoLXd9EtZFkAmxP8=;
        b=hNfDN31lyDuvB0TQd6eFefVMSypEsJA62lFdlLV8r4bVxr2hLUvHG+0ACh0jTsTVBH
         USA72TFSKRoriOFUQZeJTIH4U/ltZs44QGPU2SUaQ3jn3o8DRWToJ0mr9DqebX9LBWhp
         NWEbY/KzsHhTK26nK3P2+AkYrAH3V79B2Gv/bRlL0p9tyX20wWl+ZyDFUF1cEBj1Ugpp
         HObsXJBnfXCC84i4Zr6LlHtI6dAFgIf/T4olCVQ3oI7mMbw5VeJcJk6Unp9bdSiBbElD
         Vfv5tL2Tm2ndE7RLcqtql/lJqjJJd5DssIYAFwHocKvfhSERJLvzO9ksGaFkgMwbw1zZ
         qM8w==
X-Gm-Message-State: AO0yUKVg/rpkaIuCaGLvKUsEvc8gZX7eccjYLkIzEwZd8GT+X3m+RvXs
        +CjtNwy+UIMTOubVJ4tHBhHB7ZuPeW2KcZra9Etsjw==
X-Google-Smtp-Source: AK7set+pHZNmbblwwxa6IeoJky8Rxxwh3CnNVwCpC5M7ssBOdrx2CR7rlC0zNSJRJ81lbS2YCpJs/A==
X-Received: by 2002:aa7:c91a:0:b0:4af:5aa1:6e58 with SMTP id b26-20020aa7c91a000000b004af5aa16e58mr11277992edt.21.1677761730423;
        Thu, 02 Mar 2023 04:55:30 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id a98-20020a509eeb000000b004ad601533a3sm6955034edf.55.2023.03.02.04.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:55:30 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 5/7] drbd: drbd_uuid_compare: pass a peer_device
Date:   Thu,  2 Mar 2023 13:54:43 +0100
Message-Id: <20230302125445.2653493-6-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
References: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.39.1

