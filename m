Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45140666CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbjALIkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjALIjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:39:11 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A91611C0E;
        Thu, 12 Jan 2023 00:38:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id cf18so36610441ejb.5;
        Thu, 12 Jan 2023 00:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJ7M69IJgQ7eq0zD8HH26eB4H+AGbBbySaGYUjUcQBw=;
        b=IcffrHRIMHhghWPt20VxeyDygLFkboChRBG/bHkHzOgAPbmD8qI3CUXhm006ygSAQd
         vfER8FQsfoNwqEfr1YnaWgqClEmGR+61TLjck5jMsWnv2H+cIVfk+Bj/gp/qAGBIDLMY
         4sTUwczJD0nYz//zvSJ53Zj+2z7HavLgxwy5XrQiD5zEN7CAC7Usxudx1dhlmreI4Atc
         oA+f6kuUcmafuWCf34KVnG31EhDA2ozm0oKbdrmn8AE8WK/noYA4lxOr0vYYb1PJzbt9
         9emHsUULpyp69hbWxu8xx77+JofW4GUTNcdyOAGMI0DIWGhWMzoyKUJFcGkHZQeS5CZP
         B7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ7M69IJgQ7eq0zD8HH26eB4H+AGbBbySaGYUjUcQBw=;
        b=y7TS8aT9bX6IlBJ3/B/3w+7V1xL6rtSZOEueZdLYc4V0sRUihD2jgpeWKjSIZo8N53
         nPiXaR0tkDKHrWIrioS1TCGJeMSZJNHLNFwRRZD8hpiQ6eJz1cR3OSKaQFeMmrPhYoL0
         QicNKEymyzAZASYSxZ7InDm7a3o/JSDnIgWx7rc6Sb+UDgEHyPm5VkvtwPKhkrurJ3vg
         W0MluPwFIpn+FzRENLXo0Em7dRwxgCMHznfKCAcPZYBPF0vEMi8mFdW48mgY3w1xMGKI
         WNO2fAkPXWDqvLJ5JPyifBMTwdLKLS/iwW4pUHeLDaESaffaOTPGd4wkzudPYyFXuy+U
         9lzw==
X-Gm-Message-State: AFqh2kp3Mckv/bJLJ5JFwvXXEarelvdVpiDbxwg0JEJYHEw+M6m98NiR
        AHBaccolPpJyoA+LiCbhGso=
X-Google-Smtp-Source: AMrXdXsYu8QtQWfGBFPSra3S5dDttoNV50EyPKju+nuF3gxzfemx0e2nNkKLjbP/YgmzEOnjG3Lllg==
X-Received: by 2002:a17:906:4f88:b0:7cd:5a34:8932 with SMTP id o8-20020a1709064f8800b007cd5a348932mr62731256eju.21.1673512691700;
        Thu, 12 Jan 2023 00:38:11 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b0084d3acda5fasm5670410ejv.189.2023.01.12.00.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 00:38:11 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/4] ARM: pxa: remove further dead code after pxa93 support removal
Date:   Thu, 12 Jan 2023 09:37:44 +0100
Message-Id: <20230112083746.9551-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 150ccb6f9a89 ("ARM: pxa: remove pxa93x support") removes configs
CPU_PXA930 and CPU_PXA935 and uses of cpu_is_pxa93x() and cpu_is_pxa935().

Remove some further dead code in ./include/linux/soc/pxa/cpu.h on top of
that commit above.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/soc/pxa/cpu.h | 47 -------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/include/linux/soc/pxa/cpu.h b/include/linux/soc/pxa/cpu.h
index 5782450ee45c..c151a9a14cce 100644
--- a/include/linux/soc/pxa/cpu.h
+++ b/include/linux/soc/pxa/cpu.h
@@ -126,26 +126,6 @@
 #define __cpu_is_pxa320(id)	(0)
 #endif
 
-#ifdef CONFIG_CPU_PXA930
-#define __cpu_is_pxa930(id)				\
-	({						\
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x683;				\
-	 })
-#else
-#define __cpu_is_pxa930(id)	(0)
-#endif
-
-#ifdef CONFIG_CPU_PXA935
-#define __cpu_is_pxa935(id)				\
-	({						\
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x693;				\
-	 })
-#else
-#define __cpu_is_pxa935(id)	(0)
-#endif
-
 #define cpu_is_pxa210()					\
 	({						\
 		__cpu_is_pxa210(read_cpuid_id());	\
@@ -186,18 +166,6 @@
 		__cpu_is_pxa320(read_cpuid_id());	\
 	 })
 
-#define cpu_is_pxa930()					\
-	({						\
-		__cpu_is_pxa930(read_cpuid_id());	\
-	 })
-
-#define cpu_is_pxa935()					\
-	({						\
-		__cpu_is_pxa935(read_cpuid_id());	\
-	 })
-
-
-
 /*
  * CPUID Core Generation Bit
  * <= 0x2 for pxa21x/pxa25x/pxa26x/pxa27x
@@ -224,16 +192,6 @@
 #define __cpu_is_pxa3xx(id)	(0)
 #endif
 
-#if defined(CONFIG_CPU_PXA930) || defined(CONFIG_CPU_PXA935)
-#define __cpu_is_pxa93x(id)				\
-	({						\
-		__cpu_is_pxa930(id)			\
-			|| __cpu_is_pxa935(id);		\
-	 })
-#else
-#define __cpu_is_pxa93x(id)	(0)
-#endif
-
 #define cpu_is_pxa2xx()					\
 	({						\
 		__cpu_is_pxa2xx(read_cpuid_id());	\
@@ -244,9 +202,4 @@
 		__cpu_is_pxa3xx(read_cpuid_id());	\
 	 })
 
-#define cpu_is_pxa93x()					\
-	({						\
-		__cpu_is_pxa93x(read_cpuid_id());	\
-	 })
-
 #endif
-- 
2.17.1

