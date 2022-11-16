Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FAF62C266
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiKPPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiKPPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:23:02 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E14FF92
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:23:01 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id q5so9274883ilt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixv3Fmx1mnew0WeMfI1+VxxOz2mqpaE/UA185d2bGDg=;
        b=Wgmy6ylQ7twJ7OvN1+vXvfWhy99X1ngOvzqefyA2DCYaaIKA6BBjvEYmD9H7qNLhCU
         m5lse8o672fAKzs5LjJzSE1O/zlon7XRT6St9bECgOhbBAeqhavtH/v5us4idJACpXO0
         kSuLQDPwt2n2VfOozwNXpcuIQi7VBuTYD1kQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ixv3Fmx1mnew0WeMfI1+VxxOz2mqpaE/UA185d2bGDg=;
        b=OO92UFCuxPwwWvA8aLUM9PNGiMTdgmLloyLPWuOlq+T7DeNbLTiNF/xmmWQ6N6fl3/
         C6HgHwL7vM3A9IXG7FU0XUvxwjO8ln48kZ2btAzzOrgsPPKy6eFAVmvALt1HiRrMq15F
         9DGyBuUcmPwJErrlXS+uuvCttdJNODMi5+gfjUhU4/LRfSjjyWMS1xH0KVMFacgn/6Er
         WbHd6KcLLHBIH5stCLNUF2C/Tovpq6AmgbdqTSm04UQ2RLkll/GSaSaXjZt4NXg1fZYd
         Od7GgByunNk+h6Llq8yLtrMJnG7FRQ7gi1gS9MzXWAamPRzhI9qQjF3zB2UJhv8axyno
         RwQA==
X-Gm-Message-State: ANoB5plBGfLderwutx9N9Xs4G/nEEpH6fiCDG30TJKs/a5DhGJGw+bYn
        c7k2qTBmr5hzbgoe1kXwo3+m8g==
X-Google-Smtp-Source: AA0mqf4kUYHmzbxFG5NK2C6XJVgFrboMfZeb8vbobAWQVXewEuvYjYC+DduuZAi40KT0Ay5mu312sA==
X-Received: by 2002:a92:c889:0:b0:2fd:1880:7f6e with SMTP id w9-20020a92c889000000b002fd18807f6emr10672589ilo.227.1668612180698;
        Wed, 16 Nov 2022 07:23:00 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r4-20020a92c5a4000000b002fc681a6ad8sm6323228ilt.78.2022.11.16.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:23:00 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: Fix sprintf() INT_MAX -Wformat-truncation= warn
Date:   Wed, 16 Nov 2022 08:22:58 -0700
Message-Id: <20221116152258.28772-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

utprint module is included in tools/acpidump and when acpidump is built,
the following warning occurs.

 CC       tools/acpidump/utprint.o
/usr/include/x86_64-linux-gnu/bits/stdio2.h: In function ‘sprintf’:
../../../../../drivers/acpi/acpica/utprint.c:602:18: warning: specified bound 4294901760 exceeds ‘INT_MAX’ [-Wformat-truncation=]
  602 |         length = vsnprintf(string, ACPI_UINT32_MAX-ACPI_UINT16_MAX,
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  603 |                         format, args);
      |                         ~~~~~~~~~~~~~

Fix sprintf() to use ACPI_UINT32_MAX/2 to get rid of the truncate problem.
This change is inline other sprintf() implementations.

If using ACPI_UINT32_MAX is necessary in the kernel, acpidump might require
special case to get rid of this truncate problem.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/acpica/utprint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index d5aa2109847f..02cff16c8f77 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -599,7 +599,7 @@ int sprintf(char *string, const char *format, ...)
 	int length;
 
 	va_start(args, format);
-	length = vsnprintf(string, ACPI_UINT32_MAX, format, args);
+	length = vsnprintf(string, ACPI_UINT32_MAX/2, format, args);
 	va_end(args);
 
 	return (length);
-- 
2.34.1

