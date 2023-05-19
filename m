Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EAD709DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjESRWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjESRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:21:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289AE42
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae54b623c2so31826265ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516884; x=1687108884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TL6x11AHUdbqwPOBex8MH92mOu6poqhjfJN8Bz63N4s=;
        b=Pht+hrXlamhoKc3Sfk+JnwTbwmcG4p0AC6wXT9KK+YLT5G/A8PMg/Kgierf2mtzawr
         ClBv70BUaPRNqYHKjGkk7QBTOalxnZ8r6RtmZDQddTP1/P2XptlY4Z2wVzZmyx2mgkUl
         BcimCZ+ntm13VOGd+9TV47CPKcYCQWDP2CsA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516884; x=1687108884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL6x11AHUdbqwPOBex8MH92mOu6poqhjfJN8Bz63N4s=;
        b=HiQQ7F0gKaY00EDpxBg0S183qgv9rpnku0KfJEZdF6yhMCob6MAI12NVveYmXiMZOs
         1U52+VXkKIBMBiCD/wyKhRzPkswV5YHHhIqV9xNttVM0Y/YEsaA7zZht+aQzLVuL2YiX
         E6sRKeQCldxLIfcy0b7S+4BMGJaIIhERSomaWbIpTd4v/XwZWpUgmnZ/PaA4Vw6L2M5O
         yO/tlYoX0VjCAvGHzHXuiq2OXmIl8SYx1FbKozAuZqs71NnRGuPupxE9wnmrRBM7CDEq
         gZB3DUHLl3rJuJT5eO8Zl2eq4nhcTQyDZcskLfh6rK7xdHtYUqNlQh6jGzy/rhxusYeT
         C2ZQ==
X-Gm-Message-State: AC+VfDwnfQfB+/K5hwRVqNN05bgyPQ5ThL7iux3qNj6ghRHGpqEc/dKT
        dHuXKDOHJeAf9ViE9I9eET1hxA==
X-Google-Smtp-Source: ACHHUZ42iEc62iH4hoBzId667tClAxoJ0OHdYYIBvBIVMKi1bhk7AD73MYNJ7aE36NwledCLjmXG2w==
X-Received: by 2002:a17:902:e80b:b0:1a1:f5dd:2dce with SMTP id u11-20020a170902e80b00b001a1f5dd2dcemr3490112plg.6.1684516883784;
        Fri, 19 May 2023 10:21:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:21:23 -0700 (PDT)
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
Subject: [PATCH v5 15/18] watchdog/perf: Add a weak function for an arch to detect if perf can use NMIs
Date:   Fri, 19 May 2023 10:18:39 -0700
Message-ID: <20230519101840.v5.15.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, NMI support needs to be detected at runtime. Add a weak
function to the perf hardlockup detector so that an architecture can
implement it to detect whether NMIs are available.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
While I won't object to this patch landing, I consider it part of the
arm64 perf hardlockup effort. I would be OK with the earlier patches
in the series landing and then not landing ${SUBJECT} patch nor
anything else later.

I'll also note that, as an alternative to this, it would be nice if we
could figure out how to make perf_event_create_kernel_counter() fail
on arm64 if NMIs aren't available. Maybe we could add a "must_use_nmi"
element to "struct perf_event_attr"?

(no changes since v4)

Changes in v4:
- ("Add a weak function for an arch to detect ...") new for v4.

 include/linux/nmi.h    |  1 +
 kernel/watchdog_perf.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 47db14e7da52..eb616fc07c85 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -210,6 +210,7 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
+bool arch_perf_nmi_is_available(void);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 349fcd4d2abc..8ea00c4a24b2 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -234,12 +234,22 @@ void __init hardlockup_detector_perf_restart(void)
 	}
 }
 
+bool __weak __init arch_perf_nmi_is_available(void)
+{
+	return true;
+}
+
 /**
  * watchdog_hardlockup_probe - Probe whether NMI event is available at all
  */
 int __init watchdog_hardlockup_probe(void)
 {
-	int ret = hardlockup_detector_event_create();
+	int ret;
+
+	if (!arch_perf_nmi_is_available())
+		return -ENODEV;
+
+	ret = hardlockup_detector_event_create();
 
 	if (ret) {
 		pr_info("Perf NMI watchdog permanently disabled\n");
-- 
2.40.1.698.g37aff9b760-goog

