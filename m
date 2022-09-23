Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4756F5E7CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiIWOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiIWOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:24:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085BE62D6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:24:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay36so363383wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+gg8BqSr/XzLdS7L9X25eMkIxvQJQPxB4iU34G/4vAc=;
        b=0o5HIGq6dar3v4a3HY80WpxudV3MLVv9VYOMg/P9uNfQmm3yLUc0AhyOSBPJMmhEhM
         2pHPFQQTN5N662SIjzzucJaswE9h5Q34kfKGwHwt8VVCTG0NYzGnFvjot21Vk6McZRKw
         vzs/gSWml2QOH3t+49f5hmMWetF9kc0ZfJNqdfq8y3sWR4+mcEOqWDhh4pxff4BK+EL7
         wu7l3vzEaBKiuFNwXHrcN/OCNQQYlTFNpsZND/Om8a7KWNq0Z45pbn5C5DSyy1fc4+0T
         Blq5XGU9UrSTxZ27ad8DbTEp7qxW8Qjc5knrqZlOprF6O8KXUZzlJvQlEV5dJnMqTCFb
         PGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+gg8BqSr/XzLdS7L9X25eMkIxvQJQPxB4iU34G/4vAc=;
        b=D4TNxAbzCzacxYYbxnUDj59JRbkLi97KpTChmXKspLX2H4XpaiPj+QTexLRL6K3vT/
         W4vPgff2PgK+flzJ1PAG1cNaL275wAthneos2Yde5Br2s98JNGK23t75XkTdWPNlSCYM
         uBneXu7POuzczeffytKhu8Qo99tKtT9CVAhS8JFXZNxtUAhODtFxNWYyTBu1eVw55ofB
         pHTT+4K95A41ZZtfnam1TmLRGiZwyFeVZ0IF0TMlw/KLfxFDF238W5xFeYw4+FjYkMJk
         Khuuu/oJpFWmI9mDpzUUSuieulMtUv2gzhj/Q2tA/t/1f313cvLAS9yUgK3sOsHJIpPN
         tHwA==
X-Gm-Message-State: ACrzQf2d84cdDZz+A2QQTTt4eLmTwNpQ7udCVh78jX4QlnO78pPSKI0J
        b5OCeUE+vrX6mUZgQkOlSrOVgw==
X-Google-Smtp-Source: AMsMyM6fAayT1ZsV+SMonrVdKJ53U4/hjl7+ExfMxROz0nMYBnnFSyl3/Mqnz4L8GUMlT0dr0Kl0UA==
X-Received: by 2002:a05:600c:3c8e:b0:3b4:d224:addf with SMTP id bg14-20020a05600c3c8e00b003b4d224addfmr13261549wmb.132.1663943083373;
        Fri, 23 Sep 2022 07:24:43 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b0022878c0cc5esm7444627wrw.69.2022.09.23.07.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:24:43 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v9 4/4] MAINTAINERS: add TI ECAP driver info
Date:   Fri, 23 Sep 2022 16:24:37 +0200
Message-Id: <20220923142437.271328-5-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923142437.271328-1-jpanis@baylibre.com>
References: <20220923142437.271328-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds driver info for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4999f68bda8..c189117f58eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20322,6 +20322,15 @@ T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
 F:	drivers/media/platform/ti/davinci/
 F:	include/media/davinci/
 
+TI ENHANCED CAPTURE (eCAP) DRIVER
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+R:	Julien Panis <jpanis@baylibre.com>
+L:	linux-iio@vger.kernel.org
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
+F:	drivers/counter/ti-ecap-capture.c
+
 TI ENHANCED QUADRATURE ENCODER PULSE (eQEP) DRIVER
 R:	David Lechner <david@lechnology.com>
 L:	linux-iio@vger.kernel.org
-- 
2.37.3

