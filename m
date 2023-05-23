Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB10070E586
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbjEWTbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbjEWTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:31:44 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04F4E7C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c30fa5271so7465a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684870278; x=1687462278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwhjQZCvvhy/Fhe2cqOT5ULwyvfB9FhkM1yVz/dZTsc=;
        b=ZGVLMSlqBZzADdesr0F46WBsI6jocekqCveWms8L17Hg3V4+Iy0jhIMir6AN/GMZEa
         DHCurLabujU9TMOtIhSTwTIfHiEeQmSjTfhRl46KfNaPW8Wf5beMWP6+yimlnoOdk499
         rNp2X4A9iIdKI1mpk6mxx74zmAa+dhz0UT9Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870278; x=1687462278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwhjQZCvvhy/Fhe2cqOT5ULwyvfB9FhkM1yVz/dZTsc=;
        b=HEtIqia8YucCAJH4TsV1dPnBLIlreaH93AQOFMnRtjGXOuiZnfEGf7dYqP9ZBRoxW6
         DVdZ98h/XbhlWd9AbqKFpeuZTjH18FYYfMdEegK0R+5QwUrRSIh6CvfvfEE16v82xQ4e
         mbH/kVemIRx/548YyFvis5Du6wR/lVZ/OSZdn9wFXBs7LPGTOLMCnYZ8RpIL8r0Grve0
         +xHEUt67HzkloZh9VHGBOSMJtkXH6rkB76y4ay+nCVcF5hsddVScrc3FHVbgNwJJd9QC
         yPzaWLJsokpnIjUSBjgmpfySy6aqrwm9+4gwYjb/Thh2E747tbR6UYQrGoxoLyF5Rkhe
         hI1w==
X-Gm-Message-State: AC+VfDwVrc9wQUtld7wF2ipYJZdQ7TOFk+7i+5b1qlHVbBxo7c4RTQFs
        BHn9Q42sAi0XkXwMar1yR+EYjw==
X-Google-Smtp-Source: ACHHUZ5H3AXhDwPU6wHfhEkRIiYBkTVn1VvEuEpa+4Uf48lxfP80EXQc0E9CeDOQop0j/jx/UAsT1w==
X-Received: by 2002:a17:90b:1056:b0:252:94b5:36f1 with SMTP id gq22-20020a17090b105600b0025294b536f1mr12968558pjb.27.1684870278159;
        Tue, 23 May 2023 12:31:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:af98:af9d:ed15:f8b3])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001aaef9d0102sm7109947plr.197.2023.05.23.12.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:31:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, hsinyi@google.com,
        devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 4/9] HID: i2c-hid: Switch to SYSTEM_SLEEP_PM_OPS()
Date:   Tue, 23 May 2023 12:27:58 -0700
Message-ID: <20230523122802.4.Ib2a2865bd3c0b068432259dfc7d76cebcbb512be@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230523193017.4109557-1-dianders@chromium.org>
References: <20230523193017.4109557-1-dianders@chromium.org>
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

The SYSTEM_SLEEP_PM_OPS() allows us to get rid of '#ifdef
CONFIG_PM_SLEEP', as talked about in commit 1a3c7bb08826 ("PM: core:
Add new *_PM_OPS macros, deprecate old ones").

This change is expected to have no functional effect.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/hid/i2c-hid/i2c-hid-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index efbba0465eef..19d985c20a5c 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1085,7 +1085,6 @@ void i2c_hid_core_shutdown(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(i2c_hid_core_shutdown);
 
-#ifdef CONFIG_PM_SLEEP
 static int i2c_hid_core_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1138,10 +1137,9 @@ static int i2c_hid_core_resume(struct device *dev)
 
 	return hid_driver_reset_resume(hid);
 }
-#endif
 
 const struct dev_pm_ops i2c_hid_core_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(i2c_hid_core_suspend, i2c_hid_core_resume)
+	SYSTEM_SLEEP_PM_OPS(i2c_hid_core_suspend, i2c_hid_core_resume)
 };
 EXPORT_SYMBOL_GPL(i2c_hid_core_pm);
 
-- 
2.40.1.698.g37aff9b760-goog

