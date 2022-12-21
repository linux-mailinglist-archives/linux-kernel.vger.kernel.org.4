Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F09652C57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiLUFTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiLUFTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:19:05 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B8F201A1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:19:04 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id a72-20020a63904b000000b00489753edf13so5443072pge.21
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=py+R3oSyjPwz5eQilf1rTiN3HR85HLknTooDMiJeYUo=;
        b=IrYUl6bDDomJGNiKTFCeXlabzxYoOo/81h0RLSm5yHtGWxbT3nVREIEJWaaBtfS2aZ
         pfSuv8XnGzNutDsqoMZsGkXGSg8c+O3cNs0D2GozQUueznDf/meh3ysOkk4SjxZEUdU6
         9SWb5FrI0dMtSBPox9xM8Zz933uEm9aDHzlWt/X6b92Q4c9wBQAZy4v2TAi7uWSFtbLp
         ux7Tl69sSgzoyWlv+LQWZLjaEr7es5gH3IwfjswYStg3eP07L7jD6991snc/RUCfm1Nz
         YtrVPmoh+Gbhs++LAl71qkHd0y5X2ZcJbmQMXWkquzDTp0MCsC9fBQzEE5o7KTp7MP81
         jMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=py+R3oSyjPwz5eQilf1rTiN3HR85HLknTooDMiJeYUo=;
        b=vc3fqxRBxp8thcYYulkmEMujmTS2X7Ch63MT4ZzyyHVPF4KHbe73TH38wiAiAeZT+W
         FZ1R1wxJ08G5wzG/y7jmgfcr2IFizMcjXrGGV42+szdJAuXOiyn53NPALpirk+9GRal5
         WRqmNY3GBd5lksNvwhdJKFIrD28SyKZfZkJGrcZVIvQrUXiRO096OvB7+V8U9gT+nlwR
         gdwqSHvfm87ezE1uAZA2cEXazEcWrcXgW4GW1nXgUZXNEk84RkzPDbpi8v9t1mYA3Ky+
         0tXFVSvT5NvMyJpRozLsgJdJRpsPec1YE++gZQhl5MDoMwAGik/Y0OAz09tQ1yTDTAeA
         3s2w==
X-Gm-Message-State: AFqh2krbIGIg+RhjqAuOFSzW6MASyvdVkyBLRgTyHaDquFYeVZT3F+KL
        94gx917gqa12zjzKF0+gvDhGDWC9mGbs8YMJ93M8/GusVWgiMpmYIa7ExpxqnzdT6pW4fS1wd1L
        XNG29/9OrNP8kQopsdPsj2/e4QmPggO/B3IQ8KkM+z2JONynCaEMhAJu3Ay2JzjiDc3sNnrs=
X-Google-Smtp-Source: AMrXdXv+hnNUWsEz7b/4dhs+ha2LInDp5mmR1pwI+t63dcwKAUw0Rp0nUSTdYwxb3hJhCK5XNRvktv4pbLEC
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:3404:b0:577:4103:8da with SMTP id
 cn4-20020a056a00340400b00577410308damr55063pfb.1.1671599943904; Tue, 20 Dec
 2022 21:19:03 -0800 (PST)
Date:   Wed, 21 Dec 2022 05:18:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221221051855.15761-1-jstultz@google.com>
Subject: [PATCH] pstore: Make sure CONFIG_PSTORE_PMSG selects CONFIG_RT_MUTEXES
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        kernel test robot <lkp@intel.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 76d62f24db07 ("pstore: Switch pmsg_lock to an rt_mutex
to avoid priority inversion") I changed a lock to an rt_mutex.

However, its possible that CONFIG_RT_MUTEXES is not enabled,
which then results in a build failure, as the 0day bot detected:
  https://lore.kernel.org/linux-mm/202212211244.TwzWZD3H-lkp@intel.com/

Thus this patch changes CONFIG_PSTORE_PMSG to select
CONFIG_RT_MUTEXES, which ensures the build will not fail.

Cc: Wei Wang <wvw@google.com>
Cc: Midas Chien<midaschieh@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: kernel test robot <lkp@intel.com>
Cc: kernel-team@android.com
Fixes: 76d62f24db07 ("pstore: Switch pmsg_lock to an rt_mutex to avoid priority inversion")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 fs/pstore/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 8adabde685f1..c49d554cc9ae 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -126,6 +126,7 @@ config PSTORE_CONSOLE
 config PSTORE_PMSG
 	bool "Log user space messages"
 	depends on PSTORE
+	select RT_MUTEXES
 	help
 	  When the option is enabled, pstore will export a character
 	  interface /dev/pmsg0 to log user space messages. On reboot
-- 
2.39.0.314.g84b9a713c41-goog

