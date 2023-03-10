Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512646B51D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjCJU3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCJU3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:29:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343ECE4C51
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678480134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zmi6jixM9CxhmwfdtelqmeFeZBz+8q+k2mGp4ctKzmQ=;
        b=a7s1WpENWFwg21MLHam58bYIowtl7ecBSlBHmcZEKztUI+3k6M4TUwrCc9km/JAkQaJD0X
        NYTYL9UOcgmD8iAEQx5V/Y9dLuTs+fld0rpe7ji9ZZB+XZq8/7lH5lHg+QFrPEVUYslQJo
        lwjTZo5wMF+kO0Ft8CGTkq8ws+drcsc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-ToKe3GXuMGaiTEvKgz73ig-1; Fri, 10 Mar 2023 15:28:52 -0500
X-MC-Unique: ToKe3GXuMGaiTEvKgz73ig-1
Received: by mail-qk1-f197.google.com with SMTP id eb13-20020a05620a480d00b00742be8a1a17so3718670qkb.18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678480132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zmi6jixM9CxhmwfdtelqmeFeZBz+8q+k2mGp4ctKzmQ=;
        b=N+tRJ7LQWbU2KqF6Iu+aI2RLyWXivgWtIt4LfWT/8rMJunAxMtk44fIuiqCeilrj0m
         B5c1hyOzM0o0rjrSsA6lxXgUPw6yB35EOGQKD79yPNcii3MYihheuUaI4DihFO2vKP5s
         YNtvwWjQbDRVkG3B6mATnJKo5zbxGG8+RXg/Uy+2kaGSpjPoCYXQ42mANAWFwK9fW4Jg
         bZP+dFErOCf4j65r8nZDCEqrLnlf4t1LNN4Pzn3sw416APEFMqYMUXtdTlfFo2ILXiMC
         wXv3VEJv3eMhQmtYR85/FdSaSzhCQjrGoRSEfuEPtkMbFTvqt3VPN3IPWdJyfkR5wO5C
         mi7A==
X-Gm-Message-State: AO0yUKXdKMwYiyB6PAAlmLcOqwqnfDp3/pKrsWrB92y5rer63Bh99Ab6
        /xUbdniAvUqz0KyWzT1PXX2E3t903rCkVGmbU9XKHAMwB7n2ixL9ER3paoc8Y5CUKM82q1rYqku
        2RRSp0tY+YRyG1CW4Y0H0O5uIDz0TzSD5
X-Received: by 2002:a05:622a:13c6:b0:3bf:bee1:1a67 with SMTP id p6-20020a05622a13c600b003bfbee11a67mr44705061qtk.17.1678480132160;
        Fri, 10 Mar 2023 12:28:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+QUlPA7XGJX2VyHl6RmpSZZ0/QpX6sxs3VnYs5R8X8zJsBRulPSYwo83oa4P+rKa9y4x0y7w==
X-Received: by 2002:a05:622a:13c6:b0:3bf:bee1:1a67 with SMTP id p6-20020a05622a13c600b003bfbee11a67mr44705043qtk.17.1678480131940;
        Fri, 10 Mar 2023 12:28:51 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q19-20020a37f713000000b00743838d9f49sm178470qkj.12.2023.03.10.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:28:51 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] Revert "spi: fsi: Make available for build test"
Date:   Fri, 10 Mar 2023 15:28:48 -0500
Message-Id: <20230310202848.437655-1-trix@redhat.com>
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

This reverts commit f916c7080d28831493518364492e33fc6a437907.

A rand config causes this link error
drivers/spi/spi-fsi.o: In function `fsi_spi_probe':
spi-fsi.c:(.text+0x2c): undefined reference to `fsi_slave_read'

The rand config has
CONFIG_SPI_FSI=y
CONFIG_COMPILE_TEST=y
CONFIG_OF=n
CONFIG_FSI=n

Building fails unless FSI is enabled, so using || COMPILE_TEST is a mistake.

Fixes: f916c7080d28 ("spi: fsi: Make available for build test")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 36a18c215163..80f3cade6006 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -357,7 +357,7 @@ config SPI_FALCON
 
 config SPI_FSI
 	tristate "FSI SPI driver"
-	depends on FSI || COMPILE_TEST
+	depends on FSI
 	help
 	  This enables support for the driver for FSI bus attached SPI
 	  controllers.
-- 
2.27.0

