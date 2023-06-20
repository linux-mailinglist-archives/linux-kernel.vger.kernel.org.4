Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75D1737595
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFTUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjFTUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520D21716
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-988883b0d8fso453052466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291417; x=1689883417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l13haq03wlXgATRrsgZ5ZfRpocQcq44XJv0jdOrYlg=;
        b=YGrQI43m4E54uNmB8Zafq03ZrTAyz1sh8TPap01+PcwlC+PBtufuWyGXxDQVAl0R9m
         dh8CNt76w0EfHjNLZUkwd646fMYpsJHpxsh8Af5V5Qul1Dsaw0sPM2zX9rAZ1JFm/y80
         THL3iVO5trpVtfFw6yqoFxUu2aKvfMmU4LeggwCDi0clvCSA8PwZAJKXtIx+8CndXiAY
         RGM4dvWJwu8vtd9Ih2n40ZSbcW+K4BtJNubRBBX/jJSiz0AhtHycuaZlU53VguQs1Y54
         ejYV9q98A3Gs0VKcmIoWVnOa1aUNj40/a6cTNva90u4xEk/YUXMRVXgLGCIrJyfkufyk
         g5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291417; x=1689883417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9l13haq03wlXgATRrsgZ5ZfRpocQcq44XJv0jdOrYlg=;
        b=Anb5n0/qM9LEXhyg9Joo4dRDRCrWQOIEJ4Br/KlcbPJmAAVRHkjJ+QkTR7aWAl1QZd
         Ax7vqY3/7utkA7Fjz3hBXlmhI4hKc1UAn9tz8F19BdFca2Y3WwQI/ShkE50PUeLNOcCi
         amyI+gGYssYvU4Rynbuu/7PmPWvVeGOb4Echinhz9BcuX9D6Xs4wWbMUZuWEc8uwcvjv
         xE/r2m61YkyDKzYzSxCS/uJd08rNa3on+AAREOayJQrCWq3DgKsZuRfUT5SPWXthkDAl
         tS+ndGMuqwi/dqShEBHvEsn6ilfblNcxVE3sO80esTvYvZIxG0PoYjzM+yHS+nOClmR3
         paqQ==
X-Gm-Message-State: AC+VfDwVWbCctPOwLuymbqO6wmDkqwCMzcPNEwIVjmJCpx9/PpVaxhI7
        9znRAb4/AjXqv5UmvXKzrwU=
X-Google-Smtp-Source: ACHHUZ66/hxFe9ul2BHHokE+Qbhy1oveqY7SRuCqKme0IObB0TxNSnmpoaKNKYxXT4i67m6qpPEgOA==
X-Received: by 2002:a17:907:969f:b0:947:335f:5a0d with SMTP id hd31-20020a170907969f00b00947335f5a0dmr12159426ejc.62.1687291416778;
        Tue, 20 Jun 2023 13:03:36 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:36 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:02:58 +0200
Subject: [PATCH RFC v4 05/13] regulator: introduce properties for
 monitoring workarounds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-5-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

These are useful when the state of the regulator might change during
runtime, but the monitors state (in hardware) are not implicitly changed
with the change of the regulator state or mode (in hardware). Also, when
the monitors should be disabled while ramping after a set_value() or
when the regulator can enter a certain mode in which the monitoring does
not result in a valid state.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 include/linux/regulator/driver.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 9a9163cae769..ce204ecd20e1 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -367,6 +367,19 @@ enum regulator_type {
  *                     the regulator was actually enabled. Max upto enable_time.
  *
  * @of_map_mode: Maps a hardware mode defined in a DeviceTree to a standard mode
+ *
+ * @mon_disable_reg_disabled: Disables the regulator's monitors while it is
+ *                            disabled. Affected REGULATOR_MONITOR_* are OR'ed.
+ * @mon_disable_reg_set_higher: Disables regulator's monitors while it is
+ *                              changing its value to a higher one. Affected
+ *                              REGULATOR_MONITOR_* are OR'ed.
+ * @mon_disable_reg_set_lower: Disables regulator's monitors while it is
+ *                             changing its value to a lower one. Affected
+ *                             REGULATOR_MONITOR_* are OR'ed.
+ * @mon_unsupported_reg_modes: Disables regulator's monitors before an
+ *                             unsupported mode is entered. REGULATOR_MODE_* are
+ *                             OR'ed. REGULATOR_MODE_INVALID means all modes can
+ *                             be monitored.
  */
 struct regulator_desc {
 	const char *name;
@@ -441,6 +454,11 @@ struct regulator_desc {
 	unsigned int poll_enabled_time;
 
 	unsigned int (*of_map_mode)(unsigned int mode);
+
+	unsigned int mon_disable_reg_disabled;
+	unsigned int mon_disable_reg_set_higher;
+	unsigned int mon_disable_reg_set_lower;
+	unsigned int mon_unsupported_reg_modes;
 };
 
 /**

-- 
2.34.1

