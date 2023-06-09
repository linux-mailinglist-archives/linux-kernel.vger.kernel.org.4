Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFEC729967
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbjFIMRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbjFIMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:16:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BD2E50;
        Fri,  9 Jun 2023 05:16:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-65299178ac5so1793986b3a.1;
        Fri, 09 Jun 2023 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686313013; x=1688905013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QqQU8hBbMaX7r0MJDWINdS/Rh5+kzN+O80WlHx+3uhw=;
        b=Y4Z/Or/w7hgCrB3EhRZDTrmacoc0teToTfI+bk4o+uZKFxCkQW2fMUPVQMjB9mJJ8b
         5cMlOzHUMlYWyfgnZNWT8yMR48IYofi7aghSNAJMgB/8pGSGjjyqd56M4f1i+DYi6SuH
         a3ENz9n5Byo5V0NxxyAVu5ScaPAZpI0mwEoIAHONHPCQx18cTxOzIg7+3rOdNeV0WojD
         yYjyqRnQ6UuJHwcggjlDSS0K9BrJiHRfJzqyJBjr8ECRQvpEW3KFtBEgV0BcBwQaT43a
         s/pJp/0aNmI2Y61geRZj2wdLQcqI4ZC25lLq1qcJiQ+NTvkIwZhQBhSuBklKQDDmUczn
         EEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686313013; x=1688905013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqQU8hBbMaX7r0MJDWINdS/Rh5+kzN+O80WlHx+3uhw=;
        b=OjUkSD0ISiAAkqCU5CocuzZxzQkfOYBfeUvq6+wMP/RImjcMrF3AxpzsCLQohAo4Nf
         hBF5EvYztSiThj6NgGKBUkjRP9vFBnWiMvXerNHfOYmy02FtccEv92zQMAJ4gsjqR2vN
         qvEfZteXmhHk62VaArVSW97+rh+VuhQZWMR0kaFa537peEnG2SK6SaftmfTavVVGp9zf
         btPyp9TCPYfqXwW9lcark7O91mULZjbwJCoFAOaQU9vxF4EJZ/Gx3TgVhONuInJ7YEp4
         9kVLG43zkBYNzAWxaCyMSSJOsFGeluUzi63crx8vmXXqemvI+vo/d12n0+yKZNeC+67c
         mMLw==
X-Gm-Message-State: AC+VfDwgACcJ8P496Xy3hnAIaNF0CDoemzq/uqlxEsp09IFSIv/0xY04
        lcvTbo79aKzIF5PpGY3xAPc=
X-Google-Smtp-Source: ACHHUZ5cDH/KI9LeYoeHL6RuUBxbONTWXic0Qkf70J9dNLWJ2QbYwCxYS13d4/+ckYgcIUDqU4x0fg==
X-Received: by 2002:a05:6a21:680d:b0:100:3964:6cb with SMTP id wr13-20020a056a21680d00b00100396406cbmr1088135pzb.40.1686313013522;
        Fri, 09 Jun 2023 05:16:53 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-73-73.dynamic-ip.hinet.net. [36.228.73.73])
        by smtp.gmail.com with ESMTPSA id w15-20020aa7858f000000b0064ca1fa8442sm2640223pfn.178.2023.06.09.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 05:16:53 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: davinci: make davinci_gpio_dev_pm_ops static
Date:   Fri,  9 Jun 2023 20:16:48 +0800
Message-Id: <20230609121649.88147-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sprse warnings:

drivers/gpio/gpio-davinci.c:695:1: sparse: warning: symbol 'davinci_gpio_dev_pm_ops' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/gpio/gpio-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index aaaf61dc2632..1aed3ace0240 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -692,7 +692,7 @@ static int davinci_gpio_resume(struct device *dev)
 	return 0;
 }
 
-DEFINE_SIMPLE_DEV_PM_OPS(davinci_gpio_dev_pm_ops, davinci_gpio_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(davinci_gpio_dev_pm_ops, davinci_gpio_suspend,
 			 davinci_gpio_resume);
 
 static const struct of_device_id davinci_gpio_ids[] = {
-- 
2.34.1

