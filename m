Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B943E709DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjESRV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjESRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:21:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D91BD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:20:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-253724f6765so1419773a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516855; x=1687108855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7nsegKilU8iY/CeHEQ2XMVIjaNVdBVM5JDOxat9ACo=;
        b=A4Ce0mbuBc+hTbiZP49wHojvRrnbiIA8FPLkaarvKJXT1bV5KlwOIUViar61CbX4qM
         xnKJrMF/2lsNyHtA607IBj6w8gOrCueK1n3T28DggYwgn3WWzNlnj/yUC1gqbWjZ/eif
         4QU9hrt72WwEMojhcB6YxiHPFG2/iARvBWVoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516855; x=1687108855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7nsegKilU8iY/CeHEQ2XMVIjaNVdBVM5JDOxat9ACo=;
        b=PwTqgkfCF4OTtYqFgYb/eO8IyyZO12nAAFUzCKavZMaiipl50z8dOd8imOHQ/0FE5e
         PN9pas9gol+Z2eWgiXyabDiqksDr1o2scg2celmSl5ekXyCxViH75rIXFldmxdAKFJEz
         mEEgSFjk+puXWPHWEyH6Ub3SasPnyeewAR0jyks+J35hmQQFZxAIEZeC+Kdb8IMQWg1V
         zyI8IlSRz3JUkoasQI/Jr/p+1nwfWp3Tm4PJyr44Pt+PuGO/RXX0GEvHLjbjZ/oAy6e2
         IeF6pzo7Yy3ps/Mf3irAolVNm1cU+5wdTzLXmv3ewGfTxvzX5O1UV0DgCXFJG9DiWD5z
         UjTw==
X-Gm-Message-State: AC+VfDwTIqnhySOcVRIZwtxdnuhsp+TKxL+U+XLbVhlr60lZVDpk+3b3
        cEjqBlkp0NjND/FPbobraWkrIQ==
X-Google-Smtp-Source: ACHHUZ78KuQvgskyCDTAlOMExtVERg2yOkymJq8jyThLWiYxqXpls34rasoUDDbhLlKOIhF5z6rP+Q==
X-Received: by 2002:a17:90a:8541:b0:250:d2d8:c179 with SMTP id a1-20020a17090a854100b00250d2d8c179mr2837454pjw.29.1684516854855;
        Fri, 19 May 2023 10:20:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:20:54 -0700 (PDT)
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
Subject: [PATCH v5 06/18] watchdog/hardlockup: Add comments to touch_nmi_watchdog()
Date:   Fri, 19 May 2023 10:18:30 -0700
Message-ID: <20230519101840.v5.6.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid>
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

In preparation for the buddy hardlockup detector, add comments to
touch_nmi_watchdog() to make it obvious that it touches the configured
hardlockup detector regardless of whether it's backed by an NMI. Also
note that arch_touch_nmi_watchdog() may not be architecture-specific.

Ideally, we'd like to rename these functions but that is a fairly
disruptive change touching a lot of drivers. After discussion [1] the
plan is to defer this until a good time.

[1] https://lore.kernel.org/r/ZFy0TX1tfhlH8gxj@alley

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- No longer rename touch_nmi_watchdog(), just add comments.

Changes in v4:
- ("Rename touch_nmi_watchdog() to ...") new for v4.

 include/linux/nmi.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 454fe99c4874..fafab128f37e 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -125,15 +125,30 @@ void watchdog_nmi_disable(unsigned int cpu);
 void lockup_detector_reconfigure(void);
 
 /**
- * touch_nmi_watchdog - restart NMI watchdog timeout.
+ * touch_nmi_watchdog - manually pet the hardlockup watchdog.
  *
- * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
- * may be used to reset the timeout - for code which intentionally
- * disables interrupts for a long time. This call is stateless.
+ * If we support detecting hardlockups, touch_nmi_watchdog() may be
+ * used to pet the watchdog (reset the timeout) - for code which
+ * intentionally disables interrupts for a long time. This call is stateless.
+ *
+ * Though this function has "nmi" in the name, the hardlockup watchdog might
+ * not be backed by NMIs. This function will likely be renamed to
+ * touch_hardlockup_watchdog() in the future.
  */
 static inline void touch_nmi_watchdog(void)
 {
+	/*
+	 * Pass on to the hardlockup detector selected via CONFIG_. Note that
+	 * the hardlockup detector may not be arch-specific nor using NMIs
+	 * and the arch_touch_nmi_watchdog() function will likely be renamed
+	 * in the future.
+	 */
 	arch_touch_nmi_watchdog();
+
+	/*
+	 * Touching the hardlock detector implcitily pets the
+	 * softlockup detector too
+	 */
 	touch_softlockup_watchdog();
 }
 
-- 
2.40.1.698.g37aff9b760-goog

