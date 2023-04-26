Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D906EF69C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241445AbjDZOlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241032AbjDZOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:41:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000B72A4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:41:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso5678096b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682520098; x=1685112098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1M0lqOJypapkRTksWKuR/Yypjimk5GbDOFmzpeSyi2M=;
        b=HzQkkQk8hd7x79X5FMJYsxWe4Uc5LQg76lPDWjFMHDfz/M2AuUtKuB2PWl7vqGBC1a
         EnvryORiKSS9n8pLC5iGanO24aiEY7ieJum1hDYybn7wJ3bQM4ODhu4Iqzjw9A6Idbgf
         y+pcpEcVDMR/iwAxWAEmYJLCBZzGFzl2ziRQqb5aXqQxcZLg1FJOLVAn7lHljr9KQKOi
         /AZ/o/abSZwANbB3zrS/n9GbCIMdmxKLTDBR9u6/mbIFAjBs3HUKzMSaGhRV1n6IBVe/
         Xb4904ex3bP6VcIQqmDcI/xJlu60pWYxjoi/PZ4RS9zEIApucaj0HludWn3HkG986F1v
         nenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520098; x=1685112098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M0lqOJypapkRTksWKuR/Yypjimk5GbDOFmzpeSyi2M=;
        b=TBKZBsJgoopCNPAbIYteoaJMG2gmE9UTRx9H6RyXeejslulaaP05UpTDDI6xtvtcCu
         iy+mtdhcxknwSkpC78o4Ec8GeRaXSf4L8tCxEUo/WlxVisgRTGulN6DyrgLJeEavcH4j
         gWeEKKd7wAU/78rKFMvP4fCBMFE73aty/2P/rbFUK1qtA8lazdC/R/Gww+2o9kMEXhql
         8fGM0tccweqOr4NWOlBhI1DmHh6nux3mwJjpvJ3SQqGZmJKD6daT99Z1zpBB9DqLhhW+
         e3g3+DRkaKV0sdCbN5P3Oyk/CMBj5bfcoBlmN5qQYZKNAYiK+WG7UBXGMXj0MVCkYZyi
         c+Kg==
X-Gm-Message-State: AC+VfDzBDp0Sk5JpAasLTfVqhn2QnndPlikm8WRkPQfd6H2hY6Sq3xYB
        Yru1A7qSwDI+D9600vHA5SM=
X-Google-Smtp-Source: ACHHUZ53DvMmHkkfBtWyTH2tlDxjCG9sRmmqtCQGa2PpJEG2YIH/qzQAo5KA/L6odVwNfFtgHvx7Tg==
X-Received: by 2002:a05:6a00:a2a:b0:641:d9b:a444 with SMTP id p42-20020a056a000a2a00b006410d9ba444mr1111492pfh.31.1682520098172;
        Wed, 26 Apr 2023 07:41:38 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.99])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b0063799398eb9sm11430532pfe.58.2023.04.26.07.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:41:37 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] amba: move to_amba_device() to use container_of_const
Date:   Wed, 26 Apr 2023 20:11:23 +0530
Message-Id: <20230426144124.19270-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to_amba_device() now properly keeps the const-ness of the dev pointer
passed into it, while as before it could be lost.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 include/linux/amba/bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 5001e14c5c06..c60a6a14638c 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -107,7 +107,7 @@ enum amba_vendor {
 
 extern struct bus_type amba_bustype;
 
-#define to_amba_device(d)	container_of(d, struct amba_device, dev)
+#define to_amba_device(d)	container_of_const(d, struct amba_device, dev)
 
 #define amba_get_drvdata(d)	dev_get_drvdata(&d->dev)
 #define amba_set_drvdata(d,p)	dev_set_drvdata(&d->dev, p)
-- 
2.25.1

