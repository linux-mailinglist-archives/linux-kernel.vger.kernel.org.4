Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804FC742DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjF2Tu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjF2TuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:50:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230CE210E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:50:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b80512a7f2so7515885ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688068215; x=1690660215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSkn+f3VtgW8iSnk4GBxcuOfWg9o8pMcPa7iLptRigM=;
        b=N3TWLy9UHAFofIUARTltvFgjNeQgaQvAIEBNMAqc1xSyjJdiQgcwLXuWdFGd7wN4tp
         kGY7IMbjQYgNboxa6wD7E8gDVu7KhqN9Nt33ogvwIx4kMSZTNpJLfz94RIiT3ocZQ1Rh
         QrEsLxEXUZnMh5D+4+VabuihtkZhD+oJV+LZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068215; x=1690660215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSkn+f3VtgW8iSnk4GBxcuOfWg9o8pMcPa7iLptRigM=;
        b=E23lJizkU7Y+3jRxw6WRDT2hz/Sj3btNJOwAmBsMUrfBUHZkKI7FwDtsEM5Ndu21ln
         8LbEiR8UELaxn6xElA9QeDGX698foSuEFZUNb1QwC4BPdRZn5jfcAzdE2245v27uCwhX
         mG+gE0VlS3i1lYJ1L7wpwFycEGjLQPhbOmbeYT3DTPtSSVjBn9SQCly5B3NDC+PD6wW7
         UgEdIlKL26br5E+LJRdxs5aQAgpi9mjSNkMtaJ44cn+RieSgDu1Bngr9cVzEA9MuWSzo
         mEdny8YtZTc9+Lqe2hgpOXftST1jF9HdlvvlMtc7QsBaq+hkVxO45iWV/8GsDV/fEc3g
         TJKg==
X-Gm-Message-State: ABy/qLb9scngv4hHuNVd17nwSInRqY1+9v9DxK7NeE21gSeyQ+vqtmpq
        A5wnvuew61vRVIT61BAdAwiLiQ==
X-Google-Smtp-Source: APBJJlFSWmGAW+1tvAAziG9cxk1yhnOVZ9XXdrNb1iN8TJ+5MAEK2Utl/WqMd0L/kGZSeOMv40GaBg==
X-Received: by 2002:a17:903:2444:b0:1b8:64e1:7b05 with SMTP id l4-20020a170903244400b001b864e17b05mr145905pls.47.1688068215666;
        Thu, 29 Jun 2023 12:50:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:1f8f:4afe:ff0:9243])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b001b3fb2f0296sm9457505plh.120.2023.06.29.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:50:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haren Myneni <haren@linux.ibm.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Include asm/nmi.c in mobility.c for watchdog_hardlockup_set_timeout_pct()
Date:   Thu, 29 Jun 2023 12:45:06 -0700
Message-ID: <20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The powerpc/platforms/pseries/mobility.c calls
watchdog_hardlockup_set_timeout_pct(), which is declared in
<asm/nmi.h>. We used to automatically get <asm/nmi.h> included, but
that changed as of commit 7ca8fe94aa92 ("watchdog/hardlockup: define
HARDLOCKUP_DETECTOR_ARCH"). Let's add the explicit include.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/r/af19b76d-aa4b-6c88-9cac-eae4b2072497@infradead.org
Fixes: 7ca8fe94aa92 ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/powerpc/platforms/pseries/mobility.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index cd632ba9ebff..0161226d8fec 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -24,6 +24,7 @@
 #include <linux/stringify.h>
 
 #include <asm/machdep.h>
+#include <asm/nmi.h>
 #include <asm/rtas.h>
 #include "pseries.h"
 #include "vas.h"	/* vas_migration_handler() */
-- 
2.41.0.255.g8b1d071c50-goog

