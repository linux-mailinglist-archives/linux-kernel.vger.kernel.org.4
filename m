Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F46E30C3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDOKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDOKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99547DAF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94e53ef6815so230058866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555403; x=1684147403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MjSoC4TCDNhW7OuBd0aJYjoOlcx2Rf2xm/2TifHqkY=;
        b=r5n0teVtYfgLHJ9wzgJf36fggiHajrPhV/1oicQB5mindesT092j8KTlCn7LyH2mEs
         WgoDF6KkjqBEUHazPhB9mv4CS/ITzw4m/vUtQzaLxgJJERgkLDO5lXr5opoKYyg1w+yj
         amr5Gi2NoJ6mAY9/ImrkB1UNslGEwrdYoJrz5IYX46Gm0Wt3JklNeWrXg0ie8PU/i6ut
         o+VPu82oVbRRLiCAMkrqHexsp1wbFfL1KSuJdYYiq2taL8UAS8zZaFuBpY7DlPxh617l
         vZADQU4ytdiF4fpYPijHzxO2SCcsdJFgd4zLqJ9qk7DI206XS63S9hy/YMq5GNi3YJ+a
         j7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555403; x=1684147403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MjSoC4TCDNhW7OuBd0aJYjoOlcx2Rf2xm/2TifHqkY=;
        b=mAhjgjI37AqaUK0a4C4jOWjcmvcAnrO5Oxp9YjlXQgPK0FlUsotmLb72W65YQ99+po
         7VSrKRpydxLqAfwrultcWJxzDMRy+OzWD4/GMZUCqrZa7Y2hS58ZNlbTLdBTeSFy1ouD
         XCFzYY0XyXqGczp5Om1HZlLTyfIpgkA7eqC/VwYaMGjLa+eLfa669Pb6BOLfycp9H6JO
         ILz11gtxc49uWyxdnIibgYhaYfdaZboqI1KnklRKiIKHAaSpKxML51qUQawLfWxhkLg3
         +zlAtmvcn1AZNl4W65BOvzGsaYVWqdMkqQjb0X001kT+74h1SQ41KjYf0y9sqWnIuYQR
         mbIQ==
X-Gm-Message-State: AAQBX9c0U9JBcpONKxx6qSPZWV4IBNu1wBk20fdq7tppAw5KK/iy6V+Z
        uUmB2GlV7VBuc+Y7nm7EbR4TeA==
X-Google-Smtp-Source: AKy350Yrv9okA+dGhbqDF/SEess+c9iNTOKwIXP3omv9uneJhrdzxrKiFw0whbsWdpmvHHdnSmQOQw==
X-Received: by 2002:aa7:dcd4:0:b0:4fa:ee01:a0cb with SMTP id w20-20020aa7dcd4000000b004faee01a0cbmr9434833edu.32.1681555403256;
        Sat, 15 Apr 2023 03:43:23 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/15] w1: ds2433: do not use assignment in if condition
Date:   Sat, 15 Apr 2023 12:42:55 +0200
Message-Id: <20230415104304.104134-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assignments in if condition are less readable and error-prone.  Fixes
also checkpatch warning:

  ERROR: do not use assignment in if condition

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/slaves/w1_ds2433.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 23cd099d032b..9f21fd98f799 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -98,7 +98,8 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	u8 wrbuf[3];
 #endif
 
-	if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
+	count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE);
+	if (!count)
 		return 0;
 
 	mutex_lock(&sl->master->bus_mutex);
@@ -208,7 +209,8 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	int addr, len, idx;
 
-	if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
+	count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE);
+	if (!count)
 		return 0;
 
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-- 
2.34.1

