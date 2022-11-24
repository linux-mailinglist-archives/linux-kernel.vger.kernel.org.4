Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20D9637221
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKXGA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXGAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:00:25 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE1C6963;
        Wed, 23 Nov 2022 22:00:25 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v28so736365pfi.12;
        Wed, 23 Nov 2022 22:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAHp5qCPTZ8K1yZRoCUQaJtAs4jsVFjCKksyNhA51CU=;
        b=g+AmRf/lnRgQbwl2mXxjZelx0mevNmKoLXYDXm4DLHEHwTdK2VjQYmh90w77WStM6D
         6xcEKEuI6rliXnztGajuG4b4756LNtAtJpsCJYxf5gtmbaEBlU6ThWiIuvkth6ncVadC
         8GAMlW5s2XXAb8SE7YqI2Lpvh9jNHkYIvBfU/DjHWw1zu8qEEYYqidUiGaP1btF8tRBn
         XVkUqyobn8A8/aAXVm7rXmktTm7l22vFagTjppLSUD11jPVD7RXQBGZzV4L13CUJxEQL
         5/DttRVtS9KfruyPufbeT8ouWGG5pC6HgnHfSkMBFYrZOkq0Zop9JTWmZ8FcrECstfRt
         X/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAHp5qCPTZ8K1yZRoCUQaJtAs4jsVFjCKksyNhA51CU=;
        b=Pece9TJxJtyBmLSZ3yJ/HZ2nFFLzKDkVt3ILsn65l2Lg4OdwcHLsdTH0Fr6DNOixsc
         zLtcQYoBN/gAIB6owYpdsqVjqTNQedCz/nA9loe+VQpYmVAQRMFSiKjwL8LWBIPagSbV
         E3nYetOv6twF428kwLEEzXu7JUVogYuUDciFARvfvFDNN9tkrKRGBisIZqQ+oEKoCsC7
         m11LfVxlhr95uRb8mDYLwG+Lavf6rpzkKXmD1ZMXxR9dMCklVJe+yOeRJOSJOMGXriT3
         L/cbCdi4exIYwjznch0tYtwb+D3DYU/fxv20O3k5v48YAylbGXuphHjEC0jNRZO1Uw1g
         xPIw==
X-Gm-Message-State: ANoB5pkLbq5LrwPj4GBAUYPaPuY7ndzwLMf6d5OZ+q4oOvRIhb3qGN+d
        0a2Kzrhqw2RH8XCDFwE7v7GVuff6v/XJkw==
X-Google-Smtp-Source: AA0mqf4IJFTQoMphoJhmGYaDWWkEvp/q+FhM6VEh56udXD/CrkmE8PrZoDcgrkX9eOhL43hRuhRLvg==
X-Received: by 2002:a05:6a00:1515:b0:56b:abf4:f77c with SMTP id q21-20020a056a00151500b0056babf4f77cmr15234736pfu.37.1669269624383;
        Wed, 23 Nov 2022 22:00:24 -0800 (PST)
Received: from localhost.localdomain ([50.7.59.154])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001886ff82680sm248554plh.127.2022.11.23.22.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 22:00:23 -0800 (PST)
From:   Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanggenjian123@gmail.com, Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] MIPS: Restore symbol versions for copy_page_cpu and clear_page_cpu
Date:   Thu, 24 Nov 2022 13:58:16 +0800
Message-Id: <20221124055816.1803770-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Genjian Zhang <zhanggenjian@kylinos.cn>

The mips build generates two warnings:

WARNING: modpost: EXPORT symbol "clear_page_cpu" [vmlinux] version generation failed, symbol will not be versioned.
WARNING: modpost: EXPORT symbol "copy_page_cpu" [vmlinux] version generation failed, symbol will not be versioned.

Add their prototypes to be defined in asm-prototypes.h, so that
genksyms knows the types of these symbols and can generate CRCs for
them.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 arch/mips/include/asm/asm-prototypes.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/asm-prototypes.h b/arch/mips/include/asm/asm-prototypes.h
index f901ed043c71..8e8fc38b0941 100644
--- a/arch/mips/include/asm/asm-prototypes.h
+++ b/arch/mips/include/asm/asm-prototypes.h
@@ -6,3 +6,6 @@
 #include <linux/uaccess.h>
 #include <asm/ftrace.h>
 #include <asm/mmu_context.h>
+
+extern void clear_page_cpu(void *page);
+extern void copy_page_cpu(void *to, void *from);
-- 
2.25.1

