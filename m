Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557006C026F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCSOhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCSOhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68019C7C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679236611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XWzHgiL2NSowgeGQA1tqAXRb6Sm60VFytFuHZjvfdfI=;
        b=h70IEDBi77PgyqbVVAJ8It/6ZIk1MxM/v3MDXEfYRNygqt89XrnNiBb8THjrHmyOH7xp3g
        x4f0aEzuqywrQRsbelkE/K95FW/aEEwL9rqQsTtfMbfd3O/1JvDy0brT3rqkfZ9Ml00O2x
        ev3kpN6IUyE7llwjfV9aaYaNhhw6IB4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-CykQgJy6N1aZsuA1i4ZTWQ-1; Sun, 19 Mar 2023 10:36:44 -0400
X-MC-Unique: CykQgJy6N1aZsuA1i4ZTWQ-1
Received: by mail-qt1-f199.google.com with SMTP id j5-20020ac85c45000000b003d81e3fe559so5281606qtj.16
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679236604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWzHgiL2NSowgeGQA1tqAXRb6Sm60VFytFuHZjvfdfI=;
        b=nX3AoA93Ng82yGkg+fFQnsz5cweUzCh0z/VoH7F/UEoDN3CUSD/mEszg6lastwDN06
         ItbuMsISqp1MJuN+78hmuOESDXJAwttex1ZvBXUlo0thWsDARwOcUR8h56gHBFzHPYui
         CMnX2YB5aY2Mv+8rnjmNL4Z1+jXkjNmVSKbNXybGwWXDbH2t4mNquZlw1VZ00u6dIHV7
         UK00wDXV8/YRKOxK00ve5+Im3wI0R0Qp/I097+Cbojf2HSlADlNisVTtFbBFNKITNEWG
         wIDQ4ztiZfqOswSqJsQcw4XmosnNT7FdRMFa2RXLwOs/37FXIUyMlG5iaktpz+OdWQJA
         jEDQ==
X-Gm-Message-State: AO0yUKXDzpvjaYbZCFSQfDf53dL7+JyTBkYQxVZXySELtoECn7A6Vid4
        Du62zCO2DPcy0fdMqWj412vww3AB+wD4fExwBAYtmlJIYrFfRCiMKTQNi5tRBEH5w51rb5scN/W
        P1kmQ0qzvUDi86xqd4oyTpc7E
X-Received: by 2002:a05:622a:1214:b0:3e0:98f3:6cec with SMTP id y20-20020a05622a121400b003e098f36cecmr1856194qtx.44.1679236603786;
        Sun, 19 Mar 2023 07:36:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set+97Dibvhqhg/Ulk6oZwTmlmWDnkiUm3S+2qMc0ntf5rUqQTbBuvGEsBgE3pdJyCZ+fZ2xf9g==
X-Received: by 2002:a05:622a:1214:b0:3e0:98f3:6cec with SMTP id y20-20020a05622a121400b003e098f36cecmr1856174qtx.44.1679236603549;
        Sun, 19 Mar 2023 07:36:43 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l16-20020ac84a90000000b003d4ee7879d0sm2756qtq.56.2023.03.19.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 07:36:43 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     robert.jarzmik@free.fr, linus.walleij@linaro.org, brgl@bgdev.pl,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] gpio: pxa: remove unused gpio_is_pxa_type function
Date:   Sun, 19 Mar 2023 10:36:40 -0400
Message-Id: <20230319143640.1704735-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/gpio/gpio-pxa.c:174:19: error: unused function
  'gpio_is_pxa_type' [-Werror,-Wunused-function]
static inline int gpio_is_pxa_type(int type)
                  ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpio/gpio-pxa.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 1198ab0305d0..a1630ed4b741 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -171,11 +171,6 @@ static inline struct pxa_gpio_bank *gpio_to_pxabank(struct gpio_chip *c,
 	return chip_to_pxachip(c)->banks + gpio / 32;
 }
 
-static inline int gpio_is_pxa_type(int type)
-{
-	return (type & MMP_GPIO) == 0;
-}
-
 static inline int gpio_is_mmp_type(int type)
 {
 	return (type & MMP_GPIO) != 0;
-- 
2.27.0

