Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733F85E61CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIVLzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIVLzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:55:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744999DFB9;
        Thu, 22 Sep 2022 04:55:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c11so15092195wrp.11;
        Thu, 22 Sep 2022 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eHfdo9NG5mSV1GqT+TMNYoa5pHvJV47fW+UKuY3so9U=;
        b=gE26CUnH3Ul7RGU8Zulze1t66K8Zbd2cd8DSIqKFLocCNI6KCY+kI6dVEXp0RP1dvs
         OWpmHj7K9ICYb2UmZ2hISu7Xbpb0YVLDorQfUCvK8YPFXB3Z9Ko3eNq//RFhKtrj0sl0
         mqn0zBE+BxFRHGUton7f3bqaiESLh2D9NxRyCMlaWi+h9mU7SUC8qndaKXiJDdDwk7kg
         YmvyzURbZ501/H7TWxMijtYR1hBvnEXxZtvOuf2PjjjGHg45CDcPEDjJzGD3SRnSEfCI
         adv5SltE6NMjfZjiAwoHT1tgJhcG+5SMBoYv75SHYs3dixvHj8OZcG9YpPYnzBqk3xbE
         72+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eHfdo9NG5mSV1GqT+TMNYoa5pHvJV47fW+UKuY3so9U=;
        b=kspDYvLZc75EkqsmTBgAaRw2aJjxIDj8go1Ycu+0cX0iMXggG4KGyHLUrxQOsv7cXI
         RJ5epr4d8ev1Yyj1qdCSRXjYEvdchnj2LFktq83Fc++r5BNJWlGzJdgS74hIpmq2GON6
         Bzj754KpODdMeH8YjTgHc637WGLiLaavWibmadG5r1Hk3mPdTMpDFyCt7Hgwr7aJe3zk
         FYwOZsCJAlhuP0w37AKpe+y0D8whByj5IMiwEKIqVLEwPni/OYsN2Od1Ly/JFA6dycar
         vN85IwfC6ctehQ4nz8j4/qi1Th27BMJAQQerFsdVjX25JrZ3ef43ek98cMCoS2NqJjl3
         CrvA==
X-Gm-Message-State: ACrzQf1grdydKCem1uNKakzGXn/iJO8WRhZ0u9m1NJ0Yq/zh/pAhsyo5
        eZfLIG85kIeSAImyLrDJ0LM=
X-Google-Smtp-Source: AMsMyM4uLjeg4MhZfLsr4JYsb7tqTAFZ5TVmruuhsvzLK9efCbkwHJFeD+rcg2G11v8cntMW0nDO/w==
X-Received: by 2002:a5d:64e5:0:b0:22a:3cae:93bf with SMTP id g5-20020a5d64e5000000b0022a3cae93bfmr1819455wri.323.1663847739847;
        Thu, 22 Sep 2022 04:55:39 -0700 (PDT)
Received: from daptop.. (host86-140-33-108.range86-140.btcentralplus.com. [86.140.33.108])
        by smtp.gmail.com with ESMTPSA id g16-20020adfe410000000b0022ac13aa98fsm4754984wrm.97.2022.09.22.04.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:55:39 -0700 (PDT)
From:   Daniel Houldsworth <dhould3@gmail.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     dhould3@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Support touchpad on/off
Date:   Thu, 22 Sep 2022 12:54:59 +0100
Message-Id: <20220922115459.6511-1-dhould3@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scancodes reported by the touchpad on/off button. The actual disabling
and enabling is done in hardware, and this just reports that change to
userspace.

Signed-off-by: Daniel Houldsworth <dhould3@gmail.com>
---
 drivers/platform/x86/hp-wmi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index bc7020e9d..496c137d3 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -206,15 +206,17 @@ struct bios_rfkill2_state {
 };
 
 static const struct key_entry hp_wmi_keymap[] = {
-	{ KE_KEY, 0x02,   { KEY_BRIGHTNESSUP } },
-	{ KE_KEY, 0x03,   { KEY_BRIGHTNESSDOWN } },
-	{ KE_KEY, 0x20e6, { KEY_PROG1 } },
-	{ KE_KEY, 0x20e8, { KEY_MEDIA } },
-	{ KE_KEY, 0x2142, { KEY_MEDIA } },
-	{ KE_KEY, 0x213b, { KEY_INFO } },
-	{ KE_KEY, 0x2169, { KEY_ROTATE_DISPLAY } },
-	{ KE_KEY, 0x216a, { KEY_SETUP } },
-	{ KE_KEY, 0x231b, { KEY_HELP } },
+	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
+	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
+	{ KE_KEY, 0x2142,  { KEY_MEDIA } },
+	{ KE_KEY, 0x213b,  { KEY_INFO } },
+	{ KE_KEY, 0x2169,  { KEY_ROTATE_DISPLAY } },
+	{ KE_KEY, 0x216a,  { KEY_SETUP } },
+	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
+	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
+	{ KE_KEY, 0x231b,  { KEY_HELP } },
 	{ KE_END, 0 }
 };
 
-- 
2.37.3

