Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0236C28A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 04:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCUDiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 23:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCUDiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 23:38:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE67AB9;
        Mon, 20 Mar 2023 20:38:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so54639709ede.8;
        Mon, 20 Mar 2023 20:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679369892;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4reHO6m1QrpLcgDFWTCpHMyCc1+fqEZ3eH5LXVHOdU=;
        b=He+Vpp6rzyqI5SGxD/bHXjf60Dgtj9rwsuwB2bcJ4AtceS9KDgbpLsF6H1jYPgxYuG
         fj5SaN3Cd6uX+U2+a3xrNdOqt7U9jQoRvaFE5ZzE+tgBYn6MOLWfSUhHzi7GbplNuJRC
         VxH1lXGWs0Ai7bl9nSUg9DqxfvhYHO5IUkPUofd/xmVVGd3EZFIG5WAHHWP0nJ1SPIpq
         miEomaX2BFFyjEKltK+Mqab/ORjR5+leiHFQ6YrbVTN2uyvbSbYd1UGObUctxu6T8XSt
         SO/pAReFppScBNXSGJF1uGFwOoXTlSBxVlZ8wtmkTFLLGF5NEfN4YvRKXDsugZBMMfYi
         kKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679369892;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4reHO6m1QrpLcgDFWTCpHMyCc1+fqEZ3eH5LXVHOdU=;
        b=pFwPJbf4+/ZxGa+2s3+ebDbZzETzXK+PD8keo5UoF7JoEfRefP13G+w6TyE9aDcyt7
         NnHNERUF49Yy1hDkWD0/jUOcY5tVAvgF1nZEihCOicReTo4nhrI9koI4oDVKt8GniI9Q
         zUnaBLii4hVa3oIUqfUQVJBSVj5AxbvZQkeZcFuziVB0QrjT4CY+0Pabb0snmKQHurHL
         aePFhaB6/ln8smkfavAnVfV4p+XTlFbkSGk/PY0WSkgkVGjRXah+eZKIU3jfO66K9Vcr
         E/tFCY43VuWx5HmVfX2ySB9mk7/QahRkfPtcOn+7hcjaWSVi26P3MjkwFyd6u+Dbu0Jf
         TG/A==
X-Gm-Message-State: AO0yUKUxEBjhpFs5kD/iplmEgh8YSEQtWZ24GgKC9D3cJ6trKzPJiMJQ
        1B/kmlU91Qu5cXClIUAOcluGlBwCpHWZUg==
X-Google-Smtp-Source: AK7set9i+KRlF5m1WFQ8OYQm5OEPDMoPwdjE/UJygioKJjSR3dYouu5FbnrEbcgt/Qd5COHT4kqmIw==
X-Received: by 2002:a17:907:1def:b0:8b2:d30:e722 with SMTP id og47-20020a1709071def00b008b20d30e722mr1268754ejc.3.1679369892532;
        Mon, 20 Mar 2023 20:38:12 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:6c2c:25d2:96b3:40e6])
        by smtp.gmail.com with ESMTPSA id g25-20020a50d0d9000000b00501c2a9e16dsm2671755edf.74.2023.03.20.20.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 20:38:12 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ARM: mstar: remove unused config MACH_MERCURY
Date:   Tue, 21 Mar 2023 04:38:10 +0100
Message-Id: <20230321033810.22017-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 312b62b6610c ("ARM: mstar: Add machine for MStar/Sigmastar Armv7
SoCs") adds the config MACH_INFINITY and MACH_MERCURY. The MACH_INFINITY
config is used in the gpio-msc313 driver, but the MACH_MERCURY config is
never used to configure anything in the kernel tree.

Remove the unused config MACH_MERCURY.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-mstar/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
index 5dbea7b485af..fa9709f30b46 100644
--- a/arch/arm/mach-mstar/Kconfig
+++ b/arch/arm/mach-mstar/Kconfig
@@ -20,11 +20,4 @@ config MACH_INFINITY
 	help
 	  Support for MStar/Sigmastar infinity IP camera SoCs.
 
-config MACH_MERCURY
-	bool "MStar/Sigmastar mercury SoC support"
-	default ARCH_MSTARV7
-	help
-	  Support for MStar/Sigmastar mercury dash camera SoCs.
-	  Note that older Mercury2 SoCs are ARM9 based and not supported.
-
 endif
-- 
2.17.1

