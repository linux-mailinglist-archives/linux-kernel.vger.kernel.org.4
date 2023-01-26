Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB3167D6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAZU4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjAZU4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:56:30 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3311E28D3A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:56:29 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d3so2966742plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6CBOqI5oDgyySu3dQCO+N4eLyzK+lB6jUuJvc7nfiE=;
        b=Kj11lwWxzTZ2rDlQBxesaEQfj6VLCP1z/6knxCOLQ66Tk7/WOu7vNWsTBWTq3k9buD
         m3RZ/rP39XJOktJV5zBNiusbvawtsXeeCucRof66E3oTgo95TQvWEKR7Y9UXbO85XhOl
         jnPDd19wnqS55s4nJ7ENDH6fiMDLMKVDKes6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6CBOqI5oDgyySu3dQCO+N4eLyzK+lB6jUuJvc7nfiE=;
        b=QD3lQCquW6p9wnKnFdQqEhO+KflGqaVYu3eyZY8fP+YD7g0XLv4/yYVrvJ9Sb1hD/O
         6tOJtY56C9MDzoR4ueaCv30I0Xv/4bL4+mSCZjBbgPl35RQQV8DwfSvzF9Evnm5QQG85
         AjS6nGkovUwjrQKwwrAp3qQG4JeRH3h9IV/lxXoS40155rTGbab3R0PgZNWrWlgc69jC
         DykGltqCyGwb7QazSWiMNolgWn9MB3KmLGHvWADNmc48ZUsqy14zzckKRYctT4vLHZ2L
         C5vmi9hTUlOEM9LITNDxbIZv1jKKusKehCd6KTLJMdinMz9wKswWUuv8OInrn7B7yIE9
         yOWA==
X-Gm-Message-State: AFqh2kp44jH9C6RFcTiTMLD8JhYVhZIZW1SX72REHRccFX1lu0Wf3qcT
        Gfbiv4QVKwb/YW++GxD7jDvsGH4dIKtoLU3x
X-Google-Smtp-Source: AMrXdXvS1yRk2f8IaN7syoV2tCqwXFFkwEE089yK9QnmE/TwycMz5AjGqsaxVt/Goc8uLOalOfFPpw==
X-Received: by 2002:a17:902:bf0c:b0:192:c36c:f115 with SMTP id bi12-20020a170902bf0c00b00192c36cf115mr34923104plb.66.1674766588568;
        Thu, 26 Jan 2023 12:56:28 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b00193132018ecsm1386669plh.170.2023.01.26.12.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 12:56:28 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec: Add VDM attention headers
Date:   Thu, 26 Jan 2023 20:55:45 +0000
Message-Id: <20230126205620.3714994-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorporate updates to the EC headers to support the retrieval of VDM
Attention messages from port partners. These headers are already present
in the ChromeOS EC codebase. [1]

[1] https://source.chromium.org/chromium/chromiumos/platform/ec/+/main:include/ec_commands.h

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 include/linux/platform_data/cros_ec_commands.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index b9c4a3964247..ec327638c6eb 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5862,6 +5862,7 @@ enum tcpc_cc_polarity {
 #define PD_STATUS_EVENT_MUX_1_SET_DONE		BIT(5)
 #define PD_STATUS_EVENT_VDM_REQ_REPLY		BIT(6)
 #define PD_STATUS_EVENT_VDM_REQ_FAILED		BIT(7)
+#define PD_STATUS_EVENT_VDM_ATTENTION			BIT(8)
 
 struct ec_params_typec_status {
 	uint8_t port;
@@ -5906,7 +5907,8 @@ struct ec_response_typec_status {
 } __ec_align1;
 
 /*
- * Gather the response to the most recent VDM REQ from the AP
+ * Gather the response to the most recent VDM REQ from the AP, as well
+ * as popping the oldest VDM:Attention from the DPM queue
  */
 #define EC_CMD_TYPEC_VDM_RESPONSE 0x013C
 
@@ -5919,10 +5921,18 @@ struct ec_response_typec_vdm_response {
 	uint8_t vdm_data_objects;
 	/* Partner to address - see enum typec_partner_type */
 	uint8_t partner_type;
-	/* Reserved */
-	uint16_t reserved;
+	/* enum ec_status describing VDM response */
+	uint16_t vdm_response_err;
 	/* VDM data, including VDM header */
 	uint32_t vdm_response[VDO_MAX_SIZE];
+	/* Number of 32-bit Attention fields filled in */
+	uint8_t vdm_attention_objects;
+	/* Number of remaining messages to consume */
+	uint8_t vdm_attention_left;
+	/* Reserved */
+	uint16_t reserved1;
+	/* VDM:Attention contents */
+	uint32_t vdm_attention[2];
 } __ec_align1;
 
 #undef VDO_MAX_SIZE
-- 
2.39.1.456.gfc5497dd1b-goog

