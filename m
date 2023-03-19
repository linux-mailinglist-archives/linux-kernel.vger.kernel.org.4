Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1046B6C0219
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCSNi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCSNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC9213D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679233058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4ElBMEAOxAifaU/g2MZDiubtm18mJfcsN/DjXe1709c=;
        b=aAmaQvMsKsE1vYXlUg/KEWNkMq4KDauGrD77KGhhkN656L9aWk57tX4xYkD91wbj+0u+UM
        KY3ZbdeBrp8nro6SF44UQEngDzQcFQiYg2cblis5lbactKOdm5dHSJsUTZuf2G94AYNEjW
        +EGHeedNs0b1vaZ4Jymr/wuy5WroDFI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-QeYXp4JnPmqm72aLl2yVqQ-1; Sun, 19 Mar 2023 09:37:36 -0400
X-MC-Unique: QeYXp4JnPmqm72aLl2yVqQ-1
Received: by mail-qk1-f197.google.com with SMTP id l27-20020a05620a211b00b00745b3e62004so4404178qkl.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679233056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ElBMEAOxAifaU/g2MZDiubtm18mJfcsN/DjXe1709c=;
        b=BECimHrvQBrH0wWTQdC7RKbZnbWti0hBI/HU0E2UA3UxNVPP/ENR3PeOnlsQk+j+nz
         sGU1IqcE3B+LyJQcfvDSQ87NTP4HiD3CzHbAbVtNaPTTHvJBAjIqWYNj/tZuHpvGYW2u
         sR6GDueXg1zTDN9nRTSOA9ja8xGkuALVfAimyqtdq84qPdDPGUjAaFVOTuJp3iHLuUCT
         hZSqq1rqRBhXLod8V2h/I7EzpFLoK4WsRZCsd+ImVx9ff4QV9MW7UAsbOaUC4KIu19yH
         P83AZaqVyrS69rWDxpQOFAvA2W/YAsJN6QW3ksN/I5pFLf7ayURS0iqGw29Wy+VaTCo9
         PVSg==
X-Gm-Message-State: AO0yUKXJcjBER0a8EVHSHLZ9drT0NP3Ih8JRUMHx7FMJMVFwjfoSEHyQ
        iycrKnKCET8k0/wRyNP0+KyhwynX7TNy/Dl2OwZWZJFvLMU6HDr/i/EcyfVojMZQ5t5RsuKmCg7
        Rhrnvfyfpb5x1HoKtnA0QU+FR
X-Received: by 2002:ac8:7d8d:0:b0:3b8:5bc6:deab with SMTP id c13-20020ac87d8d000000b003b85bc6deabmr23562505qtd.8.1679233056183;
        Sun, 19 Mar 2023 06:37:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set8IdYHA1YnUBVuZoPyzEs2rGkOGdaTNCx3yzfNl2lCRczCgZAgZJ1vDCIHW7RUBIRurqasktA==
X-Received: by 2002:ac8:7d8d:0:b0:3b8:5bc6:deab with SMTP id c13-20020ac87d8d000000b003b85bc6deabmr23562486qtd.8.1679233055937;
        Sun, 19 Mar 2023 06:37:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h12-20020ac8568c000000b003d75bb8e652sm4551676qta.65.2023.03.19.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:37:35 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        nathan@kernel.org, ndesaulniers@google.com, sven@svenpeter.dev,
        agx@sigxcpu.org, Jonathan.Cameron@huawei.com, jun.nie@linaro.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: typec: tipd: remove unused tps6598x_write16,32 functions
Date:   Sun, 19 Mar 2023 09:37:32 -0400
Message-Id: <20230319133732.1702841-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/usb/typec/tipd/core.c:180:19: error: unused function
  'tps6598x_write16' [-Werror,-Wunused-function]
static inline int tps6598x_write16(struct tps6598x *tps, u8 reg, u16 val)
                  ^
drivers/usb/typec/tipd/core.c:185:19: error: unused function
  'tps6598x_write32' [-Werror,-Wunused-function]
static inline int tps6598x_write32(struct tps6598x *tps, u8 reg, u32 val)
                  ^
These static functions are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/typec/tipd/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 485b90c13078..af6ecb54b52c 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -177,16 +177,6 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
 	return tps6598x_block_read(tps, reg, val, sizeof(u64));
 }
 
-static inline int tps6598x_write16(struct tps6598x *tps, u8 reg, u16 val)
-{
-	return tps6598x_block_write(tps, reg, &val, sizeof(u16));
-}
-
-static inline int tps6598x_write32(struct tps6598x *tps, u8 reg, u32 val)
-{
-	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
-}
-
 static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
 {
 	return tps6598x_block_write(tps, reg, &val, sizeof(u64));
-- 
2.27.0

