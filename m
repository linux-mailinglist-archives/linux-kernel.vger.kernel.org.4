Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E106FB65A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjEHSex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjEHSeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:34:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C86189
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 11:34:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaff9c93a5so33218455ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683570882; x=1686162882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENrmHrZCa2KACgxhhiJXtsOjJ10wJCI2jUF2VRrMiic=;
        b=be5YN7QtcMkZ11hMLSFpfny3Z1+Vv4brKpdoEEOy+slNFww80COFQHL29pthNHIg/v
         87/GJaHpfH+QA0KMo1bjZ4rXO6U9tO3qNfsn1J4/Q8Fa5dVMA1z02yC6SnqwqucHUDzG
         5zjfPsahQfprVaQARLy1/sRWyHlOlxQAfQAhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683570882; x=1686162882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENrmHrZCa2KACgxhhiJXtsOjJ10wJCI2jUF2VRrMiic=;
        b=C9P16rEqfJWIdLQpUfW/U4wP+TXar9xuyF8h08UaLK6rl1EkkKeaHoMNis8fybFeZE
         8LDKIXh9CcjdpK7pC+W+B38xE3uIZ72trS/inpeLO6pcM8aY2PYBhdJWI3/AbKaYCF6v
         FnmbzaJIg63jzKRMQX8oMOrSbqs/1OasRJ5RLVcIDIPGRi4euaT6yMKeTNxkC7gDFAJF
         zv+9PGPyrObBx1HwNneLrw0LYYhq1xUiTcCxqqPqf6fmi0Gf0tnTzzcfstpdwrsIgNie
         CZZFaQa/ho0ZliA0sPsRFzTaT8YyZ56f/tMPs5DbP3QOIjxjH+XpYSlhQr8Jd8rS8ZAB
         1OEQ==
X-Gm-Message-State: AC+VfDyWT8DziKAaY+gzyF2eKkF9fumZJKNxqhZqWibScAxxjtnjcTVP
        7oEJsdHLfAIQbn+7Ru5KeYdaYqDj5WZfkP3eh3k=
X-Google-Smtp-Source: ACHHUZ50TZqve8vze0cKv1qkKDiZSg5fvQX7AhbVzO06obFIIehBk3Pk1OL4/s3leevqEpTFld9fIg==
X-Received: by 2002:a17:903:11c3:b0:1ab:160c:526d with SMTP id q3-20020a17090311c300b001ab160c526dmr12205554plh.22.1683570882577;
        Mon, 08 May 2023 11:34:42 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902c18700b001aadfdfcd06sm7617760pld.299.2023.05.08.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 11:34:42 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] platform/chrome: cros_typec_switch: Add Pin D support
Date:   Mon,  8 May 2023 18:34:27 +0000
Message-ID: <20230508183428.1893357-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ChromeOS EC's mux interface allows us to specify whether the port
should be configured for Pin Assignment D in DisplayPort alternate mode
(i.e 2 lanes USB + 2 lanes DP). Update the function that determines mux
state to account for Pin Assignment D and return the appropriate mux
setting.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_typec_switch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 752720483753..0eefdcf14d63 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -51,13 +51,18 @@ static int cros_typec_cmd_mux_set(struct cros_typec_switch_data *sdata, int port
 static int cros_typec_get_mux_state(unsigned long mode, struct typec_altmode *alt)
 {
 	int ret = -EOPNOTSUPP;
+	u8 pin_assign;
 
-	if (mode == TYPEC_STATE_SAFE)
+	if (mode == TYPEC_STATE_SAFE) {
 		ret = USB_PD_MUX_SAFE_MODE;
-	else if (mode == TYPEC_STATE_USB)
+	} else if (mode == TYPEC_STATE_USB) {
 		ret = USB_PD_MUX_USB_ENABLED;
-	else if (alt && alt->svid == USB_TYPEC_DP_SID)
+	} else if (alt && alt->svid == USB_TYPEC_DP_SID) {
 		ret = USB_PD_MUX_DP_ENABLED;
+		pin_assign = mode - TYPEC_STATE_MODAL;
+		if (pin_assign & DP_PIN_ASSIGN_D)
+			ret |= USB_PD_MUX_USB_ENABLED;
+	}
 
 	return ret;
 }
-- 
2.40.1.521.gf1e218fcd8-goog

