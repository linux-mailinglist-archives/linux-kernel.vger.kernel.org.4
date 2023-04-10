Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD56DC82D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDJPFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJPFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:05:51 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619584ED3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:05:50 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1841c57c221so8539309fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681139149; x=1683731149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NxINTjG4eAelnyELv4KdYqprnU8b+Chr2EDl9vfWGU=;
        b=Bgxp5I18PRReGhf6EIFU2+PJWneDDVYtcFVXVF8Mah2/eEmsrRFtSK2TlMTYDzjUZj
         p4747P8dJNZ6l6TIz5n/t4mkvs/QK2CGkUqqWXMrjLqUvc+ZK1R+93N2lFXhz+sKL0uM
         puyfBRcdWUMJbCmja9oss4D4nw9JTw/BkTDWn2FWHhmDTjNOa/HUS7BX5XcojGxWLgXk
         UE0wa7gw1DJ/826k6RD+uIaNU5ETbth4oatUHA31NovjQaixOdHlEoLZwwy33Kx3xAwM
         v/osPgM0G8lYAWEJ+qy8lv32/80byvJaf8Z4Q7XOtt8snxFLFZLxbNVCyRnUM58mKQyz
         8Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681139149; x=1683731149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NxINTjG4eAelnyELv4KdYqprnU8b+Chr2EDl9vfWGU=;
        b=ck4aSvuUomX/pgKSVhOhWhz5WNa0V8KAwRmVIMSfyDxZ2qg5aJwX5tLAkgrd85WcsZ
         dx3mNA/kL5TYHQnfOEbz+OFUJSrAEHunduq1WkkI6eT57fuuuFUrqrWvZPT9ybAOU2ST
         Wtd6T0ZFVGrLg78kt8f16BUh5lMaOVdqff3sgm9LdkFOut4QpnIqFUahyJN50f1PGSvD
         iWxBDEM2L45fMnXhwrTk3ET8tIRFi/fP4MT/GmQY9b25qpdnNZhV5FgQNa5V75kCC5sW
         PAvHCAFWaCXtuwglaRkWGJHkVxKlKtYlvnxz3k3ByxIRYCnfA+qffBLHDPnZ2bxKHIR7
         pzkg==
X-Gm-Message-State: AAQBX9eawMhPVKiDzJ5r0aJJkWPLSf+07L6FsGSG2w8DuOY2uhU+qebB
        ovAqXtRDWcmCsYqoUkBf1KZ98Q==
X-Google-Smtp-Source: AKy350b1unAkeeH9ErSsSz/xbM0DzqDvJIK/1HueoJpik9mXu36H92gDbcCG5qfi2O/m8RGeqHzfDg==
X-Received: by 2002:a05:6870:c590:b0:17f:7dca:8926 with SMTP id ba16-20020a056870c59000b0017f7dca8926mr5848824oab.20.1681139149669;
        Mon, 10 Apr 2023 08:05:49 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id vj12-20020a0568710e0c00b0017ae1aede32sm4064536oab.46.2023.04.10.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 08:05:49 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fred Eckert <Frede@cmslaser.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] watchdog: ebc-c384_wdt: Mark status as orphaned
Date:   Mon, 10 Apr 2023 11:05:36 -0400
Message-Id: <20230410150536.3168-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current maintainer no longer has access to the device for testing,
the original user of this driver indicates that they have moved on to
another device, and the manufacturer WINSYSTEMS does not appear
interested in taking over support for this code.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..8ef060ef48d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22514,7 +22514,7 @@ F:	drivers/media/rc/winbond-cir.c
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
 M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-watchdog@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/watchdog/ebc-c384_wdt.c
 
 WINSYSTEMS WS16C48 GPIO DRIVER

base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.39.2

