Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3FA69E9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBUWAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBUWAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:00:04 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565C52BF18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:00:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e9so1607010plh.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sr9bbir4c+FtVdRMqb2SZ1l2G4bDAGe/qMmo3iUnKD0=;
        b=KzlBWiAZUCPMG3BIsahjaV8dM7lx4VXm6b72HPvdc7VBU3c9MTLAyI8bTOugCESZ6E
         6Wxk5zRSEGkIw6nxHHIhgoLmUSHUS3J97tYHw+dHVKftiE+JW0RJnsfgjejoAMG6ImXk
         /cVT+s0fKQQsnzSJ4RgSJaa3RDHfmZhnDDWOtuHM/rIz/xO5DClWclx68tX+MFbx+oW+
         jAcdvLEaoBAgw5ikh9QDCLkQYBtE7qM6eGmuidZckGL4Wv3E7ip7yr/W7yTu3I9wJddv
         ZPlZTUuHGnj52US4JTIAlAvI06+09xUheD500MmKFRy3smroKT5MrHQ+NktaMlF313OI
         QTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr9bbir4c+FtVdRMqb2SZ1l2G4bDAGe/qMmo3iUnKD0=;
        b=vit4NUxuISAqukgWYRoftbY/fehVanrPSBEzu7+PTiW+SEGwmPiTyit2KKm4bJbnYB
         khBWdKqrhJ9Lg/kepJgDlr657IEcysVRbYuyiKu0OGAGrKGcbX+ExYzTDn/n/3clLrMM
         FUJchkjVOiJjpt8PhKFhB48ZdVdII5K2SGiNDV4dyk2nk/ZOqHguz3FV/28+cpSHqhhn
         7/git+47Tyz7ImGbSggpWKGW4t+V2LvfQgNaIS7wIsUyrYkQMq67eMSHXcBDWhHa5tCg
         telwMGtgLKQ9MF7a04Wn9CTr4uTAD9UuC9ZtEVh4h4TjlFCDorizjAVagUb9So+kXXvG
         4o8Q==
X-Gm-Message-State: AO0yUKWPQzBV6+gAh6AYSIrtdbNuIMy0Rnkg//Bo2xF3FXZX0D3KWN4r
        Eq6wbb3tn0+aQn3UHXV134A=
X-Google-Smtp-Source: AK7set+3CnbSvzP1g/u927IYI5y7ifMT1wGQCHu/zbd0la4IMTGN/AgPTB7OO/rIdtdSxQfn5DzzFA==
X-Received: by 2002:a17:903:230f:b0:19a:96f9:f55b with SMTP id d15-20020a170903230f00b0019a96f9f55bmr10193738plh.27.1677016800597;
        Tue, 21 Feb 2023 14:00:00 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:30ba:90e9:a2f2:4b50])
        by smtp.gmail.com with ESMTPSA id g19-20020a170902869300b0019c91d7532asm1990625plo.94.2023.02.21.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 13:59:59 -0800 (PST)
Date:   Tue, 21 Feb 2023 13:59:56 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: spitz: include header defining input event codes
Message-ID: <Y/U+3PZsbLw++SnG@google.com>
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

The board file for Sharp SL-Cxx00 Series of PDAs uses various KEY_*
defines, but does not include the relevant header directly and instead
relies on other headers to include it indirectly. With the upcoming
cleanup of matrix_keypad.h this indirection is now broken and we should
include the relevant header directly.

Reported: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

If there are no objections to this patch I would like to get it through
my tree. Thanks!

 arch/arm/mach-pxa/spitz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 9964729cd428..75634ef6688d 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -25,6 +25,7 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/mtd/physmap.h>
+#include <linux/input-event-codes.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
-- 
2.39.2.637.g21b0678d19-goog


-- 
Dmitry
