Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C374F72B52E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 03:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjFLBqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 21:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLBp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:45:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE567F0;
        Sun, 11 Jun 2023 18:45:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7f6341bf9so38082605e9.1;
        Sun, 11 Jun 2023 18:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686534355; x=1689126355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERhjlW5Y7nSKYA99YG69XuklrOuLnBz2WHAZvzU2WSA=;
        b=q7uuUGigrvzJ22nk9TaB8M91ZXOrRIOHZeXXKyq5Z5v5t20LSp/IU3X85y3CKys0sH
         nbcPnZghWesXPKzvlsvZ9X/YhDxpM570BWgpZkM9hh91T60OyaR4jPRVQfPRnFpa1rOt
         lBfzhF46qRmQIXFz1IZ5pXXYmW6IIRWxjZJMKMRnzf8CnrdQeEmVmjMI7rkrQ6I4/kuf
         NYNruxGWWgJivbR2cJqUxjlc6fDkibOSrz1UJEvr6ddecM0l/8KCSc7BmcyKsUf5kMAi
         kcZWDsLVHntELxeffqfpRojHz8UMA+mUVOKNprXns4KYPX17QgI7xCOPISajBLNhl+OF
         cvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686534355; x=1689126355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERhjlW5Y7nSKYA99YG69XuklrOuLnBz2WHAZvzU2WSA=;
        b=jKg9scrrAB2v0eUc7c6ceFml1b1hcptKKA+wyo9l8p9U6FZHaIHw/snpXJRKuVMOAi
         gbkE760fvsLQMDubkRoYRsNYfrrsaQMrP5BIHbPtynJoIl6eHTWk2VeE9zMQ6L/GPSKD
         tMwJsKidgFuOXaJUBnjLToAyL4zdauRH/JT1dWdyG7Z0/IgyN5z/TdcT4QONRtkiUITp
         Nwf3rVGrQB/OpsvaXiykRBsldCEfBE+Yskserdi6mAt+CpW613ru3LgaQyCeHqZffoJ2
         Oj8ldYnz5aB7lvDmjCMB31Bnc32c3eKFvHJZCn5vqdykde8Zav7C/BqAMXn2iXWwmTaI
         UYUA==
X-Gm-Message-State: AC+VfDyxjCNadtlEX+Vh4lp7tMAyXyHhe5rBaqSsI/ZY+Xkp8+jysIK9
        Y4dkUAQwNL8+H6EJnXn+OGs=
X-Google-Smtp-Source: ACHHUZ6GvDD0NGNbjw8iF2TxKFeM/CleBCGE/EJoMUmOg9PV3FezRg2QIuZKvR1Nyn+/Ytp5B/nBzA==
X-Received: by 2002:a1c:ed15:0:b0:3f6:da2:bc86 with SMTP id l21-20020a1ced15000000b003f60da2bc86mr5902025wmh.7.1686534355268;
        Sun, 11 Jun 2023 18:45:55 -0700 (PDT)
Received: from localhost.localdomain (bba-2-50-150-163.alshamil.net.ae. [2.50.150.163])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bca47000000b003f80b96097esm7140919wml.31.2023.06.11.18.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 18:45:54 -0700 (PDT)
From:   Yongsheng Yang <iyysheng@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yongsheng Yang <iyysheng@gmail.com>
Subject: [PATCH v3] Documentation/hwmon: Fix description of devm_hwmon_device_unregister()
Date:   Mon, 12 Jun 2023 05:45:35 +0400
Message-ID: <20230612014535.1433-1-iyysheng@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
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

Use devm_hwmon_device_register_with_info() to replace
hwmon_device_register_with_info() in description of
devm_hwmon_device_unregister().

Signed-off-by: Yongsheng Yang <iyysheng@gmail.com>
---
 Documentation/hwmon/hwmon-kernel-api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index c2d1e0299d8d..6cacf7daf25c 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -66,7 +66,7 @@ hwmon_device_register_with_info.
 
 devm_hwmon_device_unregister does not normally have to be called. It is only
 needed for error handling, and only needed if the driver probe fails after
-the call to hwmon_device_register_with_info and if the automatic (device
+the call to devm_hwmon_device_register_with_info and if the automatic (device
 managed) removal would be too late.
 
 All supported hwmon device registration functions only accept valid device
-- 
2.37.1

