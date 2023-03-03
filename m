Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D822A6A9A96
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCCP0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCCP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:26:34 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0E2917F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:26:34 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t22so2021492oiw.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677857192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEa5f5NbUQ9Kfmnp5btTdhemZ/7E/FPRRcXInOiUGEY=;
        b=R178QZSgljLqAoKE9diLz27SuOjHRHaqnUVuigk6hXtWcHOUa29Uzkvnbem2imCsKF
         V9nQTCpSScNtJe/ojpHvkGFURCn87QZPkGv7lZMrP10iTVCV0VcvlDyjYW2QXVbb2ZtM
         yGy9Ynfjm3ggEUZVz8fcTmBAbV81IvGByaYZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677857192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEa5f5NbUQ9Kfmnp5btTdhemZ/7E/FPRRcXInOiUGEY=;
        b=uQ6Mq91ZvH+Mx+A8e16ZhtwShoCyVlGejqj+yH5DhPFoRH5FfLlunab6/7/OWcH/rP
         g2b+7PandmMNP9NsRbBs5/WMwG1zUpiWPkLDT4zy7hl7CwpuN6MwMS5MS0wBOTpusSte
         fGuEn8jbvwMBLmVdzXvhUMe78ET8cBz7CTQcPLBov1OaAmBRc5ZrninGbVxfr5aYhHzZ
         PHdu3+pMvewPmSsxJbCzoxstKJMOjIM8Rkxo2qD1iDZtCfsqbXhqieW0eUKAKqSDM57p
         NYXhruVTtMsJMo3AO8vX6OMIAXXo4jeGB5bEFVGHvluPYXl67Z5KW2xBSThSEZIYIgi0
         Xbcg==
X-Gm-Message-State: AO0yUKV80VAMQ4eVEWDP8P2jk9EjfATygb9vcnRgAKhG20JVAWkmFYQu
        f66DSEIHD3S8OUXdBWN7DCzEG1FgYYQoHmsqE9/NpQ==
X-Google-Smtp-Source: AK7set+v1XbLGu0Af838tFwLLnH7TU3D50cVydeEOiqWBWrFk+9bROuPkSnJ5LccQoNZI/cKxWX93w==
X-Received: by 2002:a05:6808:8e4:b0:383:b2bb:1212 with SMTP id d4-20020a05680808e400b00383b2bb1212mr864942oic.4.1677857192501;
        Fri, 03 Mar 2023 07:26:32 -0800 (PST)
Received: from jdenose34.roam.corp.google.com (99-137-158-190.lightspeed.cicril.sbcglobal.net. [99.137.158.190])
        by smtp.gmail.com with ESMTPSA id i66-20020aca3b45000000b00383e9fa1eaasm980129oia.43.2023.03.03.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:26:31 -0800 (PST)
From:   Jonathan Denose <jdenose@chromium.org>
X-Google-Original-From: Jonathan Denose <jdenose@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Denose <jdenose@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Takashi Iwai <tiwai@suse.de>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: i8042 - Add quirk for Fujitsu Lifebook A574/H
Date:   Fri,  3 Mar 2023 09:26:23 -0600
Message-Id: <20230303152623.45859-1-jdenose@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fujitsu Lifebook A574/H requires the nomux option to properly
probe the touchpad, especially when waking from sleep.

Signed-off-by: Jonathan Denose <jdenose@google.com>
---

 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index efc61736099b..fe7ffe30997c 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -610,6 +610,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
+	{
+		/* Fujitsu Lifebook A574/H */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMVA0501PZ"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
 	{
 		/* Gigabyte M912 */
 		.matches = {
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

