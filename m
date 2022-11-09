Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7E622C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKINfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKINfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:35:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2642B605
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:35:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a67so27223788edf.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 05:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMFIifcDEWp2tuYJ6xczHhtO2meaPJaEEnuy7NTfdVA=;
        b=6kEX59yOiWAA2z//lcDmb/ZWXfyTfEGiA7WYWTIEjzQJKuUX13VM+dNzv/hxsTZ+pC
         lk5yde0+fVgTDH8fbD8AG0mPOG1iA74UPHFMuiDIIQ8a4bEJf+KCTobE5zSuxlPUaHtH
         DzK3gsDExUAAzzRyDvN7BNwaKspgSNvPVAoS8WUyzp2EtiWV09ftAj5IrcYi1GfqtdF4
         XRVOYeOanOl5krqDGBZN0dmyNKJCCgMLrO4qBWb6KZzLNhD71qyMlvugp4RrYKqDidUU
         fUNkIuJomMJo0c685105vF+bt1yqwNgAb+eUH/KBZGvWC5mbHB7APfBYiXC6H6eg5WbX
         vesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMFIifcDEWp2tuYJ6xczHhtO2meaPJaEEnuy7NTfdVA=;
        b=ccnwleUCXUCcFQO38h2OM5go/x4NBJXxM+ySirT8UZqfHXLto/D1SjDbz2jKTfKWwR
         DIYLD2/EZNexkLBtkWLKd2niP31EBfstGPTjOJoP+VjSSRcmovH27wGDMH1pZ/9s+epu
         qlfT7ELsTHlgqrVY9sRTTHta0LWUGaoFRugkf2fuYFAGpHxvoN9+2FS61EiEHAhUiZjs
         qQ1XAv8vHKlVmkoP8aqfa9tDxLp4WwumwMW45lV80LDTWwW92G7UoECdfEoV3IRvjUPb
         FV7ux1Ra4DZZaJ/4jwAHN4WTwdRsWKkAXCpgoDI2m5DFg9ailGxCapLGGk18NPyshWQF
         JmVg==
X-Gm-Message-State: ACrzQf1t+YtoANKvRH1+ruQkJ+bMpvjaRArIwbC3f+vuhEge0vA2JE5Q
        SkfzzaI9HgiS0/OcJYnrqSkn5w==
X-Google-Smtp-Source: AMsMyM4SlPW4+oqdJEYdjbWdRDoVC4KbD45S3pxdQMR+ts52lYTo8PnHU6bdCZ3XM7Xb/vD8+hRlHA==
X-Received: by 2002:aa7:d744:0:b0:45c:e353:e891 with SMTP id a4-20020aa7d744000000b0045ce353e891mr61337607eds.36.1668000908425;
        Wed, 09 Nov 2022 05:35:08 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id lx8-20020a170906af0800b00782fbb7f5f7sm5867463ejb.113.2022.11.09.05.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 05:35:08 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 1/3] drbd: use blk_queue_max_discard_sectors helper
Date:   Wed,  9 Nov 2022 14:34:51 +0100
Message-Id: <20221109133453.51652-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
References: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
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

We currently only set q->limits.max_discard_sectors, but that is not
enough. Another field, max_hw_discard_sectors, was introduced in
commit 0034af036554 ("block: make /sys/block/<dev>/queue/discard_max_bytes
writeable").

The difference is that max_discard_sectors can be changed from user
space via sysfs, while max_hw_discard_sectors is the "hardware" upper
limit.

So use this helper, which sets both.

This is also a fixup for commit 998e9cbcd615 ("drbd: cleanup
decide_on_discard_support"): if discards are not supported, that does
not necessarily mean we also want to disable write_zeroes.

Fixes: 998e9cbcd615 ("drbd: cleanup decide_on_discard_support")
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 864c98e74875..249eba7d21c2 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1210,6 +1210,7 @@ static void decide_on_discard_support(struct drbd_device *device,
 	struct drbd_connection *connection =
 		first_peer_device(device)->connection;
 	struct request_queue *q = device->rq_queue;
+	unsigned int max_discard_sectors;
 
 	if (bdev && !bdev_max_discard_sectors(bdev->backing_bdev))
 		goto not_supported;
@@ -1230,15 +1231,14 @@ static void decide_on_discard_support(struct drbd_device *device,
 	 * topology on all peers.
 	 */
 	blk_queue_discard_granularity(q, 512);
-	q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
-	q->limits.max_write_zeroes_sectors =
-		drbd_max_discard_sectors(connection);
+	max_discard_sectors = drbd_max_discard_sectors(connection);
+	blk_queue_max_discard_sectors(q, max_discard_sectors);
+	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
 	return;
 
 not_supported:
 	blk_queue_discard_granularity(q, 0);
-	q->limits.max_discard_sectors = 0;
-	q->limits.max_write_zeroes_sectors = 0;
+	blk_queue_max_discard_sectors(q, 0);
 }
 
 static void fixup_write_zeroes(struct drbd_device *device, struct request_queue *q)
-- 
2.38.1

