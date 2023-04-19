Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862906E856A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjDSW5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjDSW5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BAD618C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52091c58109so277064a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945039; x=1684537039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J3L1PRmmJQLOwITbbf3gVcO1wn/5q5E8+agGJxBWhk=;
        b=E5o6owHAi94AUxWQV23+WIE/5pp1O4WuHDRcksc7HsdzkCojeZYEW4oz7qxqAY/nkq
         9DI77u+isSPjvbt53VfxixNIV899AQ0S/99LKwj3MnpI1L8BLugiY+qmlKl1Vf1HKX2L
         cXmTN/MLMsxxiL4antF9TsJfg3q474IVB82yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945039; x=1684537039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J3L1PRmmJQLOwITbbf3gVcO1wn/5q5E8+agGJxBWhk=;
        b=B3qLt5BsagvAQyp9/LZzHgbJEzfgYUhS+ki9mnuwcUOyugVkvYHjxjQyZPSbS0e3Cj
         saCoDcnAu9uCytUjtt3YHdgCA6+IrFctLhRjAlozwBcY28UJmogD4M8gBOyy3sC5x8pK
         Yc8Ys+GnQqvuVjoFuhQ/GRWSSm4LIran1SXsYsSAxT0Ou8sXBZfa1FTbVncVuu1pIhIB
         NukI/iPJwDMeOjx3jxz5h8bgpGHhrVOam4A8rMI9B/c8aRo6/8uTJztYlB0xMWEPStzk
         4wYlMcMysLUgNhDA5CA/TdqS77yQddB6xDeJdEhCklhAh1lfiVJfvpLpRF4acI4BcLvT
         7xKw==
X-Gm-Message-State: AAQBX9ffnFhRxgbWENOauQFXhjSX/OVjY1w2+xhtTmU1VDEf5X6iqfwm
        /CFdEU7NgNi5C2Jsl+FS7DFq1g==
X-Google-Smtp-Source: AKy350aTf9h91DYGrz7a7xsj4nRmoGOHDhj7cVzB4J++cRvnc6ZJ8BMzmOpWvBoOUwZC9tzPMbxlhA==
X-Received: by 2002:a17:90a:69e6:b0:247:2680:4090 with SMTP id s93-20020a17090a69e600b0024726804090mr4649880pjj.11.1681945039604;
        Wed, 19 Apr 2023 15:57:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/10] kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
Date:   Wed, 19 Apr 2023 15:56:02 -0700
Message-ID: <20230419155341.v8.8.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
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

To save architectures from needing to wrap the call in #ifdefs, add a
stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
handle anything.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v8:
- "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8

 include/linux/kgdb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 87713bd390f3..9ce628ee47cc 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -377,5 +377,6 @@ extern void kgdb_free_init_mem(void);
 #define dbg_late_init()
 static inline void kgdb_panic(const char *msg) {}
 static inline void kgdb_free_init_mem(void) { }
+static int kgdb_nmicallback(int cpu, void *regs) { return 1; }
 #endif /* ! CONFIG_KGDB */
 #endif /* _KGDB_H_ */
-- 
2.40.0.634.g4ca3ef3211-goog

