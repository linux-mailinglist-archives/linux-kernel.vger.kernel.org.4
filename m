Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B8708321
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjERNrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjERNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:47:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9376E5C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:47:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so1770465a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684417629; x=1687009629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfolQL6YCb78M1yeMejeCI7ByQeu0iifzUDn8fLNDEE=;
        b=dB77aoUGZ0gMdyWUrumjq0769yrq0zOQwx8sC4JZiAWqJ30cRMQgIrykQFRXWxajKo
         AArm7aVlub4I4fJHrpQ/hmgfqCpaJROipgN6xsg8PxW46EfRCHwDb/yIHlpugCaoxfaM
         0XW5buMNxdGfJdiQ57s+bv2s4s46z2Zc/WkIKXPskg2MMvwd8nJkthB+Wp9ulrkRTEv8
         hKo4gEgGSy2yfkWzNX4BekZ/2ZF1Z5lBp9/b0QRzbvfpGY7t1cfdxcTz6ruGL/lliG7o
         ulk5G56PfaHHQtw544NEZXoUVwfrdKmBm01yburz7NIokoH35VJ+G9X496HL7mW8Ax14
         6zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684417629; x=1687009629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfolQL6YCb78M1yeMejeCI7ByQeu0iifzUDn8fLNDEE=;
        b=SnZgLjRpXTykazNgpkDbMRIKNG5Vv1+K+GRULlO0UA77LzSVSQvJnXuagM4qmwqfeF
         AZ7XV6sOAEFrEGonh5jv2iggsAe7ESuZn9UUk4apgL86g5mhSn0TuOL6b5eu/j11XYfR
         peCJn+Q/LF4EqARreOHAuskiPOQtP5ggy4DItkLkNauQXaUyqPTuUrppEhqW8Pnv2W/G
         XYd8QKoIdrjoSi0P430ntpuLoKI3aBYWqarSwcpRE5GQY7Q3fgIgfsK6gf3XhX1mNjGd
         YyJQrML2ioumwyP3ql1oyUw0ADaynIM/95YYdei1jJ3PtqVIakywDUhFnm2AXwfMZ3yg
         b0OA==
X-Gm-Message-State: AC+VfDxONX2tucMNqlDAvqhBmjrcsifMkcTjoWtBEyRf5rmHHvcuvZNl
        uwWOlXc+jtlmoUg62FAuZK4=
X-Google-Smtp-Source: ACHHUZ44gxsZNnbzY84gGzQZjtVdvLW07+zIUGdJv5r9xRge/jkDCogmJDBD5F+ZGOtu08UppOixiA==
X-Received: by 2002:a17:902:a387:b0:1ac:b363:83b3 with SMTP id x7-20020a170902a38700b001acb36383b3mr1905284pla.41.1684417629222;
        Thu, 18 May 2023 06:47:09 -0700 (PDT)
Received: from redkillpc.. ([49.207.202.99])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170903131100b001ae12510db5sm1442248plb.179.2023.05.18.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:47:08 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Prathu Baronia <prathubaronia2011@gmail.com>
Subject: [PATCH RESEND] amba: move to_amba_device() to use container_of_const
Date:   Thu, 18 May 2023 19:16:56 +0530
Message-Id: <20230518134656.9559-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
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
2.34.1

