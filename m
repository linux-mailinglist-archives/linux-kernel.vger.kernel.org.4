Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F2B6117FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJ1QsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJ1QsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:48:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D052B20DB4C;
        Fri, 28 Oct 2022 09:48:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so8145826pjh.1;
        Fri, 28 Oct 2022 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RR8Z7rR+4Otjj8031JjWN5QhQw6XT4kLdd/JjgmxDRk=;
        b=ncYThJ/NG5TsocZtUBIBjVm0F3HNUnrYoQSM1kHBpJAL0vF0kOjmeGvSCJV62I25jF
         CKxf3l5zWKBpWo3qkQBxUGNy134Ka9fAhGRbF5Ay3hbcCLAu0Z0CCmfBI6Ez34Ie5hPA
         25sZwKZPb4PENOH5VYwORRQGcukXR+271JjY3jDDhyXGxNIauzDPfg+PLUJjgAvTKQwX
         JqQ0a031wUt3Bi0Fd1Lzhm9Gwj4m4dPmTc4vwb+18vmLpFkiTTTUIdXUzGPrvmeL+Jjj
         9R061vb94G65VGTUT7wUspurgTU1nKO0lg4Ddtrir2m4NpW1YLlxtsQ//qDEUgDbYDi2
         9fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RR8Z7rR+4Otjj8031JjWN5QhQw6XT4kLdd/JjgmxDRk=;
        b=KQsAh3UIgGwGUUkpQFSfZVzrDRaRwPHTcxj774bJfgiCiq2FCYis1ClG+XZOq5kjXw
         zfONRxSHRUdVsSuB1+gdGQzJ7LgO8tDELuPCCVabaQB+YxTaIDFkIx8uCLKluVnNs2Q9
         j1vsXliEK+95gDz/4DbS7gXzUesP0I3kqT6RrT18nfq5iQks7A0xrsUK4RCVVSSYs3eP
         HBlov9ylwbIUsVcnbq5DAWiTNCT4IWRZEKEafJjbS863+tI3KFmzFiXzdP7x2MN2i8A3
         QKvzeisfNHWQ3p39Mg9V7KwTEgiLHXQQX99US7T+sf7ywly5NWmTlCBtgVFHGFjn+vtF
         h2cw==
X-Gm-Message-State: ACrzQf1718qGzjHxj9PML86jyE3SQkbfXGNYZKowHN2JE8rjZZ1RLA9T
        vW6OYZLPMiwWPF6Ij/DHAps=
X-Google-Smtp-Source: AMsMyM4LWQE6fzSFM3fzwhSTTU4GcSOPv+pDOnJPTJoss0vV1+VRih1BdHkQDD7Lqr3DESmyjb+enw==
X-Received: by 2002:a17:902:a9c6:b0:178:b2d4:f8b2 with SMTP id b6-20020a170902a9c600b00178b2d4f8b2mr37647plr.79.1666975684133;
        Fri, 28 Oct 2022 09:48:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ea9a:801b:ed52:2db1])
        by smtp.gmail.com with ESMTPSA id u12-20020a63140c000000b0042b5095b7b4sm2945336pgl.5.2022.10.28.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:48:03 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:48:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: s3c64xx: include header defining input event codes
Message-ID: <Y1wHwEm15/K87tdq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board file for Wolfson Cragganmore 6410 uses various KEY_* defines,
but does not include the relevant header directly and instead relies on
other headers to include it indirectly. With the upcoming cleanup of
matrix_keypad.h this indirection is now broken and we should include the
relevant header directly.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

If possible I'd like to get this through input tree so I can take
another stab at landing matrix_keypad.h patch.

 arch/arm/mach-s3c/mach-crag6410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index 9a45474d1bf7..2ecb85856e24 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -14,6 +14,7 @@
 #include <linux/fb.h>
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/input-event-codes.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/leds.h>
-- 
2.38.1.273.g43a17bfeac-goog


-- 
Dmitry
