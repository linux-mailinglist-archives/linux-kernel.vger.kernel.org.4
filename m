Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B5B6492BB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLKGRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiLKGRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:17:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A312D38
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u5so8834127pjy.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdm7tYomTKj891Ys/HhRedCU/CNrYZCFx2v0QChypKc=;
        b=Azw/xVT7JGfkD73hT/u+ma0UCfplbQtMXHlVq9logEtS1J8UmAvXJtz2nlJH96gle8
         ZAwf5GNOC8gsEGs0GalamXXQlRiSj/oqtn6+Tc0qgoU+AAQE5RknK4KgAYbeFFtyOQn3
         Ou5cGV6jwZcReNx6m8Ug7akf6+batbRIGBLuDFnRqbZ1FTqqIsaLdkuzx3yzK9sGHhDb
         +BuzC6SkkhhoCLBrP8eHAHVJDjxpsFkiz9GMeQCtP4oNXQqp38DIBnXP8/N2cR7mdVYU
         JTxTqTqNiA0gZCkcqV5LYfUH7SKvtO4NXWLbms9vvjLYgT7Lo/kgdiQ5LkvdJMs3fDiu
         0XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kdm7tYomTKj891Ys/HhRedCU/CNrYZCFx2v0QChypKc=;
        b=qkpLrLw+Is3aGtHYxHqc+GG0vgJHsaK7CKJMwEC3lsmRemqA897nmODCQ+7G1YlckE
         uOb5lVK1kWs9OJtyqAbNzwknfPdaby5Fyz7YEgvBZOgeIU3e7WbvdCwYQCNqI8MA1iT2
         vLiO3117tQDLbMHHCDMq+iokSg7lgeYcWKcVdCQyzmE8Ely6J+bPNPRjd6BSF30bruSA
         5KnOO9hPIbcY2QPP8bjNuf2GK87xPKBbYyQDx3EVRxpW84S9rNwoNAC3l6MUA1Yt0hOI
         e6sf/T4WPwIOcunKZ7Ywv3kZoSR2duUNaB+/8be8nnIzSOCBVk0MD6M4SV5JGAMsad3s
         lThw==
X-Gm-Message-State: ANoB5pkEgRVOubKKCe/4XeEesAcQ8o1KO/sFqDxn7DbIwM+uCTwdT/HU
        lVuUMM+vlvV7cOtVxgF02h0EfAX+snq8zyOg
X-Google-Smtp-Source: AA0mqf4ryjkBq4tIGbTve6wkkix0AwE/j+1A+2D6CGsNcgmok4JcYedsYsLNAnRnUPvqKba5I0ppgg==
X-Received: by 2002:a17:903:286:b0:189:c6ee:8000 with SMTP id j6-20020a170903028600b00189c6ee8000mr13335671plr.3.1670739451822;
        Sat, 10 Dec 2022 22:17:31 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001896522a23bsm3826390plf.39.2022.12.10.22.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:31 -0800 (PST)
Subject: [PATCH v2 02/24] arm: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:36 -0800
Message-Id: <20221211061358.28035-3-palmer@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/arm/include/asm/setup.h      | 1 +
 arch/arm/include/uapi/asm/setup.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index ba0872a8dcda..8a1e4f804d1b 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -13,6 +13,7 @@
 
 #include <uapi/asm/setup.h>
 
+#define COMMAND_LINE_SIZE 1024
 
 #define __tag __used __section(".taglist.init")
 #define __tagtable(tag, fn) \
diff --git a/arch/arm/include/uapi/asm/setup.h b/arch/arm/include/uapi/asm/setup.h
index 25ceda63b284..87a4f4af28e1 100644
--- a/arch/arm/include/uapi/asm/setup.h
+++ b/arch/arm/include/uapi/asm/setup.h
@@ -17,8 +17,6 @@
 
 #include <linux/types.h>
 
-#define COMMAND_LINE_SIZE 1024
-
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
 
-- 
2.38.1

