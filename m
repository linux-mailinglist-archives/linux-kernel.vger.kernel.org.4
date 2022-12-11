Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8965D6492C1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiLKGST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiLKGRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:17:51 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8A4CF1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d7so8946178pll.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oCv9XoaVNYo+jL/v5xfJUE2DYPkG1RC+xndRSMwe0Q=;
        b=cIZ9SqzDNQCPr3UJZFEXATImDHAB7fMNW1VvAH6jmO6ZOC5l1XnWV4sUmFJJkMw6B6
         AB62H7DErl1yzvCeLYz9rerSJoe6GQtfYGIS4+hXTTx8oLxVHJAixBjRnM7bGUmoWjCy
         sfkJZ9IYuJ3VLh1yTwGqtCiFiHFDryoP7/v106V7FWxOAhnAzxJpfd8EmQ/ycX39Oxq7
         59gQyRAbAvUr2QVQYP8gB8/KPfgVHyleDlRw4fWvxF4PbFDrUOncIepihH2ydRsARKzn
         bpn/ybaOUkQS6GxCrP2vMXr3njG1DbXrXqxw7vv4j51hndzAE9fd6E+4RqS+XJwxvN6u
         Vt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oCv9XoaVNYo+jL/v5xfJUE2DYPkG1RC+xndRSMwe0Q=;
        b=1hlt2+SN0ZExKBGGTWeZEEOiCtszQisS8KfCUOixBoAEjwfuGcts0Oj4I79Hg5J+41
         edGLEZYpfFMihPmmnJsvv9QrmG3Zl7JugHBFJJAeFD8rLKIsJc+P26W14xoIiQEmQU46
         xRsBlxqNrFUIWPOV9sIbao0AP6ThtuRdm9OeacbHPEeBGxTcyJimdRWVa3AJ3OEi1MsX
         yPiW9uRu8E9qPcKrynwj9hZtA9YYUCaJa3hBRw+07p1qZ/5ScP1SRAiC8QQHY50rrb+v
         Zf7NB29Z3RbHjaPh0h/1hU8ci+FeReVME5/JLRlDJRteeerSqPCaWxu0yN08wEOTNyTE
         makA==
X-Gm-Message-State: ANoB5plEoMo1vIrrVmDFZDWZnWFX/vxmD7PF3pNzubr15MRmvGv6VpZs
        LI/5NgubGpcQfVpDwjKGzhwi/HeWii7MCyhL
X-Google-Smtp-Source: AA0mqf4HTgVHRO7hmDLAGWd3ZyZYpV/4BdjLiF3anPOviNm3GIvwadjdXE4fX6g02HJ+lgegtp8SxQ==
X-Received: by 2002:a17:90a:2ec2:b0:219:a698:8c5e with SMTP id h2-20020a17090a2ec200b00219a6988c5emr11371478pjs.35.1670739457616;
        Sat, 10 Dec 2022 22:17:37 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090a1b8200b00219b04cf66asm3308333pjc.36.2022.12.10.22.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:37 -0800 (PST)
Subject: [PATCH v2 07/24] mips: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:41 -0800
Message-Id: <20221211061358.28035-8-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211061358.28035-1-palmer@rivosinc.com>
References: <20221211061358.28035-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
This leaves an empty <uapi/asm/setup.h>, which will soon be cleaned up.
---
 arch/mips/include/asm/setup.h      | 3 ++-
 arch/mips/include/uapi/asm/setup.h | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index 8c56b862fd9c..a13b9259b476 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -3,7 +3,8 @@
 #define _MIPS_SETUP_H
 
 #include <linux/types.h>
-#include <uapi/asm/setup.h>
+
+#define COMMAND_LINE_SIZE	4096
 
 extern void prom_putchar(char);
 extern void setup_early_printk(void);
diff --git a/arch/mips/include/uapi/asm/setup.h b/arch/mips/include/uapi/asm/setup.h
index 7d48c433b0c2..157c3c392fb4 100644
--- a/arch/mips/include/uapi/asm/setup.h
+++ b/arch/mips/include/uapi/asm/setup.h
@@ -2,7 +2,4 @@
 #ifndef _UAPI_MIPS_SETUP_H
 #define _UAPI_MIPS_SETUP_H
 
-#define COMMAND_LINE_SIZE	4096
-
-
 #endif /* _UAPI_MIPS_SETUP_H */
-- 
2.38.1

