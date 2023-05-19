Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826D2709DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjESRVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESRUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:20:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC913D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:20:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2536e522e47so1581070a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516842; x=1687108842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNeu6vyPdP07ZkKg14nXq7JlkRTws6KPwBPqf0mDzVI=;
        b=F0UdKqH+AjU+/c5u/w0OpSe1apBaDBocMcnx/dT+OQZGwKzm4Yh/f+L4AQY/pQxCaa
         b+2PUGSmX7OvnUkRsGY3c3qq61HcX6prh0T2an3zd+tZObtm8iEG4jSEsuXIyWo6kI/0
         FGrouN3ev1v5DhmMiK3SUkA3/1lt8QFGvZam4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516842; x=1687108842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNeu6vyPdP07ZkKg14nXq7JlkRTws6KPwBPqf0mDzVI=;
        b=ZNen69YvkkYzGVyWo03LNlOUftdBjf7ZSdDdVkL9QEerKwEkYo+B6gZfQau9Iyini5
         c0A6wdVGr3H4b72j0eEWYOCsynEkMnLa4FIDMa6EeyZc0ie96Ip1IKrqLusye0d2wfL3
         bzTXFaw5GCC0CyKnAqnJz1R84MEaR28AtdfDelh0wNUvJJ3njkQha9dC3rba8E2fzwYY
         XgBaQRIeIBAO5jvo+hUPlDzQCyGp69fiLeEnKnzoIoSBAHtsS2c99/KhOAu91kFchTIA
         4ovXSyvnUcSZbPloeX7bz0lfwOq1BXnf9x10gMhkvztLFwP5Wl3VM7WvtNmffEMHBQRM
         LTYQ==
X-Gm-Message-State: AC+VfDyW4jO6SaKl1pd5Lwmtq0Ju6JdSmyJ7adCejWVYnGzR3rjzzeQR
        dEVRiFIeltXnNrD3NUHkDbuqvA==
X-Google-Smtp-Source: ACHHUZ56xIwu+OAsmj4ap7FEJYDEFDc65SEAcDRmxfPUsg25AN6kC4stY0LeDhYT4ZvsYWBDy+bC2g==
X-Received: by 2002:a17:90b:1e49:b0:250:9aee:563c with SMTP id pi9-20020a17090b1e4900b002509aee563cmr2506737pjb.41.1684516842239;
        Fri, 19 May 2023 10:20:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:20:41 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v5 02/18] watchdog/perf: More properly prevent false positives with turbo modes
Date:   Fri, 19 May 2023 10:18:26 -0700
Message-ID: <20230519101840.v5.2.I843b0d1de3e096ba111a179f3adb16d576bef5c7@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in the watchdog_overflow_callback() we first check to see
if the watchdog had been touched and _then_ we handle the workaround
for turbo mode. This order should be reversed.

Specifically, "touching" the hardlockup detector's watchdog should
avoid lockups being detected for one period that should be roughly the
same regardless of whether we're running turbo or not. That means that
we should do the extra accounting for turbo _before_ we look at (and
clear) the global indicating that we've been touched.

NOTE: this fix is made based on code inspection. I am not aware of any
reports where the old code would have generated false positives. That
being said, this order seems more correct and also makes it easier
down the line to share code with the "buddy" hardlockup detector.

Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo modes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- ("More properly prevent false ...") promoted to its own patch for v5.

 kernel/watchdog_hld.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..1e8a49dc956e 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -114,14 +114,14 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	/* Ensure the watchdog never gets throttled */
 	event->hw.interrupts = 0;
 
+	if (!watchdog_check_timestamp())
+		return;
+
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
 		__this_cpu_write(watchdog_nmi_touch, false);
 		return;
 	}
 
-	if (!watchdog_check_timestamp())
-		return;
-
 	/* check for a hardlockup
 	 * This is done by making sure our timer interrupt
 	 * is incrementing.  The timer interrupt should have
-- 
2.40.1.698.g37aff9b760-goog

