Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594C624171
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKJLak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKJLai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:30:38 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13870550
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:30:37 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id k2so4251512ejr.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqQcFjVolIZhRIqqT6FRkGcpN9S51uF9ZG8nqQDDN4w=;
        b=gSE0onCCVs/efmk5i6B/oSpPSArKcVgC0mm9sfVoxuzHePi8SgA2CbssgdhiFAHylU
         mDtigGxJ5sDuiwb7V8sjbqeDbtksbtKZQh/22cpuZ2uLpEbqFefHZv9QSn2/0u1SDV7x
         PaCk/yt4mqmgw1ljTyDm3iP1bvEpk0GU0CFKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqQcFjVolIZhRIqqT6FRkGcpN9S51uF9ZG8nqQDDN4w=;
        b=7c7cr2j2Ws8c1hAOqql1pwNgLfIbOpp6dg36riZEjhgXftnK3EfEYRj5t5RnB+2dQw
         zIlgBWNBFEH4iTcw77nrGQXJj4ugHUJbVtilgZtozb2o5M1d9vZzp2IG7HSr7DZ9tKn3
         5fXOKKNRMZXmCIYfrW5WL3cZ01y8HOrI21W98cZZc76VcT2ODVWDGaIsOoZXyRDNBZxd
         r8nQRuEjI4bTts3cSrUTiPMQkm1IHZdTMckCHzi+smtJQyyNQ/sLgBZLuYtzD+X1KlrK
         AD3xtUPXunMavZfXdqc+gZykgMReGc85iKf15tyaJGFUTsO2HHB5nqH8rxu5RBDhm+RD
         emLA==
X-Gm-Message-State: ACrzQf1nzIgTt5LbtwqnYR+yCH38kNDgMi6UHlGfjHBT2Ev8sIMtQiQK
        8/YNwO3jZoN8YSVPoeyAqjDlVSIOKQI+eA==
X-Google-Smtp-Source: AMsMyM78YwoGgxA4H5q9zl8rxbtghP4Aw+UmtQ4M8mwDL2tMWkcKvSrj2C1NBL6gsNgL0na2frI2FA==
X-Received: by 2002:a17:907:1c01:b0:79d:637c:7848 with SMTP id nc1-20020a1709071c0100b0079d637c7848mr60053174ejc.513.1668079835821;
        Thu, 10 Nov 2022 03:30:35 -0800 (PST)
Received: from cloudflare.com (79.184.204.15.ipv4.supernova.orange.pl. [79.184.204.15])
        by smtp.gmail.com with ESMTPSA id ky26-20020a170907779a00b0073cd7cc2c81sm7042899ejc.181.2022.11.10.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:30:35 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, linux-kbuild@vger.kernel.org,
        x86@kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] fault-inject: Enable stacktrace filter for x86-64
Date:   Thu, 10 Nov 2022 12:30:34 +0100
Message-Id: <20221110113034.17563-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stacktrace filtering for fault injection has been disabled on x86-64 since
2007 due to the lack of a DWARF unwinder. See commit 6d690dcac92a ("fault
injection: disable stacktrace filter for x86-64").

In 2017, the ORC unwider, an alternative to DWARF unwinder has been added
in commit ee9f8fce9964 ("x86/unwind: Add the ORC unwinder").

We can now re-enable the stacktrace filter for x86-64.

Cc: linux-kbuild@vger.kernel.org
Cc: x86@kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 lib/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3fc7abffc7aa..32c5329b0dd9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1963,7 +1963,6 @@ config FAIL_SUNRPC
 config FAULT_INJECTION_STACKTRACE_FILTER
 	bool "stacktrace filter for fault-injection capabilities"
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
-	depends on !X86_64
 	select STACKTRACE
 	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	help
-- 
2.38.1

