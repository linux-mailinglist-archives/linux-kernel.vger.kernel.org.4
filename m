Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EC8744DB7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGBNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE6EE55
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688304682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IhA8PQHFplolrCTEWNVaJX0ddk8c61/nnX2OVi4x/HY=;
        b=UABScuxgmirjOGvuuFsG142DfxKUAjyzu4XBAuBOHVRDq/NoruXfY0yCDBtCA1h/RETt4D
        U65Sz0qXs1BWQtei59rB8NvWNy27T5LeE6N0bC94pXGOIcntFbGDbuwC8YbNpz8Q+PpfwT
        mSjiIRw1+iK2poslvqwRQ7g1GocRIZU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-5yzpMcFgNt2xpQmlGx_PTw-1; Sun, 02 Jul 2023 09:31:21 -0400
X-MC-Unique: 5yzpMcFgNt2xpQmlGx_PTw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b885d53a09so3257668a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 06:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688304680; x=1690896680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhA8PQHFplolrCTEWNVaJX0ddk8c61/nnX2OVi4x/HY=;
        b=GAUcBBc5L4IE3iDHko2yey6kn0MMaJm/e7minwWC6gvo0MAZFVPCof1GfnBgrJhPmb
         yGUUXPBoz8XeNSTlVbRGnjxYieM4FkuwmLt02jVJ3/v2iNxW6nDtXJW4eQ5B2/7rORHa
         eYfN959RpsfseM8PDzt9csVORTosV737EgtyUMtK7MWHxHy8+alIVeyo2K/kmRVfNdyd
         7s+hfKoYS+hEnXhfCA3OkL/thE0vhOfJnZG374xHrk85yfHJJtbQSZ62N4E+6vNGeaG6
         xMWchIWoOkT/enZMyKadjSIYAbvKJ1NwNx50oRwkUcDksbf4PiZK1mLZDbCWP4U5f9lh
         GrLg==
X-Gm-Message-State: AC+VfDwQE8zqX2veZ/Pw/WgU2Tidmn9nBwI6MVgn7AkuTAxEBgb9rw1Z
        HvjzcxXk+Ul6UhUTNILY2EgQgC5O5a0JC3jroKWiqHYOXvnYZCHq8Csk4xCf9b1tqBwO8ntd2fL
        32e/Q6+OCeuiGqcJlfsb71flq
X-Received: by 2002:a05:6808:150f:b0:3a3:6f81:49e0 with SMTP id u15-20020a056808150f00b003a36f8149e0mr8282882oiw.6.1688304680428;
        Sun, 02 Jul 2023 06:31:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6jHs6x35k/Ksnct8fSfwL+ZA8Dffms9gAWwn/v+wOt1OUbuK6xkMVZcapNkzJw/IkWcnNogw==
X-Received: by 2002:a05:6808:150f:b0:3a3:6f81:49e0 with SMTP id u15-20020a056808150f00b003a36f8149e0mr8282873oiw.6.1688304680123;
        Sun, 02 Jul 2023 06:31:20 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id ev14-20020a0562140a8e00b00631fea4d5c2sm10206248qvb.98.2023.07.02.06.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 06:31:19 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     keguang.zhang@gmail.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] clocksource/drivers/loongson1: set variable ls1x_timer_lock storage-class-specifier to static
Date:   Sun,  2 Jul 2023 09:31:13 -0400
Message-Id: <20230702133113.3438049-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/clocksource/timer-loongson1-pwm.c:31:1: warning: symbol
  'ls1x_timer_lock' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clocksource/timer-loongson1-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-loongson1-pwm.c b/drivers/clocksource/timer-loongson1-pwm.c
index 6335fee03017..244d66835508 100644
--- a/drivers/clocksource/timer-loongson1-pwm.c
+++ b/drivers/clocksource/timer-loongson1-pwm.c
@@ -28,7 +28,7 @@
 
 #define CNTR_WIDTH		24
 
-DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
+static DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
 
 struct ls1x_clocksource {
 	void __iomem *reg_base;
-- 
2.27.0

