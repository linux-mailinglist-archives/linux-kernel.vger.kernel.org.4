Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D227131A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbjE0Bmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243572AbjE0Bmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:42:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682FDE6D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso1214033b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151741; x=1687743741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pTZ8PdJlA6i+SWNusBTmTzOcCRT41PhrexiQIb/AKs=;
        b=dGhxmHD/CSkrIECymGSZJgjulMjULoIls2yt2guqhtavg8UVpzegqrUgkex1Az5eH9
         7o8tE1sfBCLwp5jGYATbBDjOwYfBLu2wLAWmL4Fu2votApVdW9ieYsPlWvXbTAoEZCRx
         IE9pmuxtKBeT5vr2dhEgDDxn0u6fSztfVGgQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151741; x=1687743741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pTZ8PdJlA6i+SWNusBTmTzOcCRT41PhrexiQIb/AKs=;
        b=bjzVAIhh3xKlXz00bCzfqR0qjqFaIXGsWpzqWWF2A6q6GRZXeWzfzvNsxtFK3X3eWz
         cMWh/NURr2dQ5NhrKNpIdbjpt/E94oDSoi7DwG2vBMCjtyyH3NLVqnu0dNGvDzc6mlX8
         HxncjsEWsbErSn2qDiOMg9jVd3jImrk0mMa+wViWafO8ZQ9Qu+VR+IeICYpJN7EOqSLQ
         e/mKijY1lvqN5WSsJQkqCmYyaMrBgog4UuQ95cyeZOQn+I28Che3nK2tAP7q+HOl0TDV
         6XdBjGwokJlUkv6ZaaEKwJENDp7B6Mxc2gKEiBEyTyb8yuac9uxhjNj2srq1RlOo3fpl
         W68Q==
X-Gm-Message-State: AC+VfDxQRo0Iscm3aMfl0+86gke4GNUcjtGkExNcbWgXfUQM5X7N9Lyk
        6Gwnk9Q62Kb9RhaDG+3h5+1pYw==
X-Google-Smtp-Source: ACHHUZ5UUsITWZmTwpdRkqyumpngtWqGIdFge6BCERd9qHLdsT3GhYY3Nylr4mH6Rilg/sSJVj2BfQ==
X-Received: by 2002:a05:6a00:139c:b0:64c:ae1c:33ac with SMTP id t28-20020a056a00139c00b0064cae1c33acmr7231420pfg.25.1685151741546;
        Fri, 26 May 2023 18:42:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 03/10] watchdog/hardlockup: Don't use raw_cpu_ptr() in watchdog_hardlockup_kick()
Date:   Fri, 26 May 2023 18:41:33 -0700
Message-ID: <20230526184139.3.I660e103077dcc23bb29aaf2be09cb234e0495b2d@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch ("watchdog/hardlockup: add a "cpu" param to
watchdog_hardlockup_check()") there was no reason to use
raw_cpu_ptr(). Using this_cpu_ptr() works fine.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 62230f5b8878..32dac8028753 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -133,7 +133,7 @@ static bool is_hardlockup(unsigned int cpu)
 
 static unsigned long watchdog_hardlockup_kick(void)
 {
-	return atomic_inc_return(raw_cpu_ptr(&hrtimer_interrupts));
+	return atomic_inc_return(this_cpu_ptr(&hrtimer_interrupts));
 }
 
 void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
-- 
2.41.0.rc0.172.g3f132b7071-goog

