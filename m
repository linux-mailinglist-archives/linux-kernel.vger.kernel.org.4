Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE24A63A454
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiK1JKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiK1JKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:10:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FED183AC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:10:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vp12so22813552ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0C3tubLwb2GLSH1X3VvRqQXs2H60xiiDuvmjMSeKtSo=;
        b=Y7Z/PxFaD/VnaXhXyOGe1ep7kAm/dknEPXug0yeRdRkaUlQkVv9MCvcaYEiJvLRkry
         lrCXQY1WoeLSJF2Z7gMjS6IbqVD1pg69EtBDV99XqW42zef9KsDOYIqKUd+OeVB9qiVy
         +H1ykGL80zvjtHMdSMcV9/mXB6AqG1c8naFrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C3tubLwb2GLSH1X3VvRqQXs2H60xiiDuvmjMSeKtSo=;
        b=5ozAZqU8uckKaGCOLcncpFAyVeCUvsDlX41583sWOU4jL5tySk4rKIgO5u4B0nvnej
         CRGYnZygN/XCvDv+XhlOhctxlYUNND11AiodXgkshMIEMxiO3192FhzP7xTScqTwMps3
         2Ej8s04ZKVKVPPzm+IqCXdH48HOzHYmK1g+tRlaRuCWp9bWOlc19zxbzBc2HpOvrmgXw
         MRAPKtn3ElmkqteedkyEGZ6RoAZLV5Sc2MPr1cEnRFqK5s0vkJXqlxyPZqz/D0XMZdzM
         FY22SqaizA4fUjp0LsVD6WqeQB4J7iGwaUubW6vBoxRyik4H3ZSYcP3Zbcru0/oWXwwE
         ohPQ==
X-Gm-Message-State: ANoB5pn03oQJUq7BdI0WlUjVpYFRNV/lvgoKU03hKX4Wn5F6ysRzyXHR
        iysGXl5qCM78wOMiMb9hfrqYDA==
X-Google-Smtp-Source: AA0mqf568e9xybgGK/wRSf+mQyS6fCinnYqI4Pilk6TRGk3gvya6YcaAW/Z72IJuzNUxNiJTm7kIqw==
X-Received: by 2002:a17:906:f189:b0:7ae:3fa3:d7c6 with SMTP id gs9-20020a170906f18900b007ae3fa3d7c6mr40230014ejb.494.1669626637275;
        Mon, 28 Nov 2022 01:10:37 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p35-20020a056402502300b00463b9d47e1fsm4932346eda.71.2022.11.28.01.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 01:10:36 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 10:10:13 +0100
Subject: [PATCH v3 1/2] freezer: Add processes_frozen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221127-snd-freeze-v3-1-a2eda731ca14@chromium.org>
References: <20221127-snd-freeze-v3-0-a2eda731ca14@chromium.org>
In-Reply-To: <20221127-snd-freeze-v3-0-a2eda731ca14@chromium.org>
To:     Takashi Iwai <tiwai@suse.com>, Len Brown <len.brown@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=4IJsRzjRUBmI8ELm76XeH219TKYxoCY1FpvtAWp9NN8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjhHsGpUmHDy4LbKwnpR9Rk9CtwMEd0pQpdx1IE0fb
 6zgFBL2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4R7BgAKCRDRN9E+zzrEiO42EA
 CHpbt3xEX9Nc3qtOSj8Ch4ZuO/hdfkPBhyD4C5+ZvwkIovXOt2hSP+891sKUfkvG7jPbx1tB/SgbSI
 6sdu+55LjjUnH2dANbcNuS79O2FpFCYNPpE7Ay2qDBZZuDb+WP27IOBVfrv7L8+ACy2tqqjELzCwnT
 Q/cZViMSJcGnr5llb+IkzVUz3GVqKc3UKyglcwyP+e+McJFKPsxcUUXhniivY1uTPl4I/maBS/zhbq
 JqBbCuNwXr6Ef3ySgmBCEYGWwuNhbray7QfkYId1aJJa/JnGQ9jQyMM8cdB23ByMOtwVXsBCFUxTUa
 pV2JI//mgbwcjyFitY+33Alk8p+CsZw5/sWyW7TXQTH6t0nZyRLCz3zBvQPAi2HaL1w2E+++dpVUNz
 a86ZD49Njb4GiF19mePCzi3LfsNW07Bz/82Y8NAvyip9oOn4tHhyg2og9wav1n+LzgJj9Fem71kBlz
 75EWG3p/2TiX1aZEaHPCDEX6489tafeRTG1taPq/CgRlcPPxrOfQiOu60xgrq5jDxY7kknT/c0sR22
 bZgxjhGx1MwW6PyoDItmvdmEbbPpFnuWZm1THQuvBTpjP+8H6RUt8LvdpbByM41YDFFj/J0qmtyzGX
 eqihKxGfFODDE3f1r8ri8YaQZECqCn/S4KZvPmGqw+WYi2FVvZ9JYmvN0cPQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a way to let the drivers know if the processes are frozen.

This is needed by drivers that are waiting for processes to end on their
shutdown path.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/freezer.h |  2 ++
 kernel/freezer.c        | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index b303472255be..ca861ace0689 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -47,6 +47,7 @@ extern int freeze_processes(void);
 extern int freeze_kernel_threads(void);
 extern void thaw_processes(void);
 extern void thaw_kernel_threads(void);
+bool processes_frozen(void);
 
 static inline bool try_to_freeze(void)
 {
@@ -80,6 +81,7 @@ static inline int freeze_processes(void) { return -ENOSYS; }
 static inline int freeze_kernel_threads(void) { return -ENOSYS; }
 static inline void thaw_processes(void) {}
 static inline void thaw_kernel_threads(void) {}
+static inline bool processes_frozen(void) { return false; }
 
 static inline bool try_to_freeze(void) { return false; }
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 4fad0e6fca64..08828c4e12fd 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -233,3 +233,14 @@ bool set_freezable(void)
 	return try_to_freeze();
 }
 EXPORT_SYMBOL(set_freezable);
+
+/**
+ * processes_frozen - Check if the processes are frozen
+ *
+ * Let drivers know if they shall wait for processes.
+ */
+bool processes_frozen(void)
+{
+	return pm_freezing;
+}
+EXPORT_SYMBOL(processes_frozen);

-- 
2.38.1.584.g0f3c55d4c2-goog-b4-0.11.0-dev-696ae
