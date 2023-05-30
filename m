Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E617171EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjE3Xsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjE3Xsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D92AA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685490473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7FN5z/Bbo4F41FMSmQdaTAQtO0xV9HpjcxuBSMJEC24=;
        b=WcJ99nWZ4CtqgvejMqKqstWQgM4MTTrkYybYi38ESBS/QJQODn5xibJmj5yEyVknFIDhT2
        4ehdchbfBJsXAQTI/vjDES+6SHmRIWC9wHejxJ12//6FAfnHJ+BoGuEcogOSaViilMXUbV
        cU9/GIf0vN8ANPSBjwWqAPo/d1s5O/g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-NpH3Y845OZy_N6ytzrQcUg-1; Tue, 30 May 2023 19:47:52 -0400
X-MC-Unique: NpH3Y845OZy_N6ytzrQcUg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6261a0b2391so19512216d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685490471; x=1688082471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FN5z/Bbo4F41FMSmQdaTAQtO0xV9HpjcxuBSMJEC24=;
        b=JlEVZhevZbndOOocqeAEgod+jJ6rH9bZp0ObC7cc9fZDQTch+1YPN2/wOC5VugTYRR
         +oSLh1VO4lBeBlo34Y+9g/a7gX7ZdBYTDZzpimkY1VXPCMznrQGwlZm2Dn2qdfdYqK1d
         l+1oFi92i27bKHymZA1eUXbsjMenKKjOz7fM2VtdeJCf0prbdujGz3doHyuOBoOScjof
         rjfma6Iaofzk3rJ1BocJf0uy1YzH9bjqJyAsPnTyTrkVSN36+7Y2l3Mf36EY4Q8pmF14
         +z8BXClL4utVxU9pj6ml/B7ZyEFEAdLVxCEia/+SAosrCTQvcZjEZMmf3TmQRlsg1W11
         sl2Q==
X-Gm-Message-State: AC+VfDxJrykkw9FhjGMz8KHOh9R5YZwDwv2kAJqnhIjWKrePSz8hN0AQ
        D/b+h8p8E6weCgnnqyvHgyMe5UOEgKPbo1+r0g60DI+vpSamP44SeH5XQVdmNshtP5QkY4c0PUd
        SX33V3ktk1H4Wy95E/q9vAbT0ILSAAIB6
X-Received: by 2002:ad4:5ec7:0:b0:625:aa48:fb71 with SMTP id jm7-20020ad45ec7000000b00625aa48fb71mr5034835qvb.59.1685490471706;
        Tue, 30 May 2023 16:47:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60mXRe5Ihq4KWw1KK9rQ5jhVTVA8tPG2DdnzZJHcMocr84jJ8U/hMSce/y4Cl6rhAuwQUpNw==
X-Received: by 2002:ad4:5ec7:0:b0:625:aa48:fb71 with SMTP id jm7-20020ad45ec7000000b00625aa48fb71mr5034822qvb.59.1685490471480;
        Tue, 30 May 2023 16:47:51 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e7-20020ad450c7000000b00626234be222sm2320369qvq.57.2023.05.30.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:47:51 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     pavel@ucw.cz, lee@kernel.org
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] leds: cht-wcove: set function cht_wc_leds_brightness_get storage-class-specifier to static
Date:   Tue, 30 May 2023 19:47:48 -0400
Message-Id: <20230530234748.3641630-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/leds/leds-cht-wcove.c:144:21: warning: symbol
  'cht_wc_leds_brightness_get' was not declared. Should it be static?

This function is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/leds/leds-cht-wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-cht-wcove.c b/drivers/leds/leds-cht-wcove.c
index 0cfebee98910..0a5c30e5ed5d 100644
--- a/drivers/leds/leds-cht-wcove.c
+++ b/drivers/leds/leds-cht-wcove.c
@@ -141,7 +141,7 @@ static int cht_wc_leds_brightness_set(struct led_classdev *cdev,
 	return ret;
 }
 
-enum led_brightness cht_wc_leds_brightness_get(struct led_classdev *cdev)
+static enum led_brightness cht_wc_leds_brightness_get(struct led_classdev *cdev)
 {
 	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
 	unsigned int val;
-- 
2.27.0

