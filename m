Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17B56AAC32
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCDTqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCDTqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:46:45 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B71BAD7;
        Sat,  4 Mar 2023 11:46:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p26so3459030wmc.4;
        Sat, 04 Mar 2023 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677959197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkOm0qwQXCVzzMhrNBH6xGLIxHx41xnkE2b0iNhuE7w=;
        b=XN4ZDlaq4u/DkhBSXPCY48RoUgIy8SEZyQPaqcK2jJEXzZB5lkMmoSZ7jPQpnd1xZ9
         pXPoxkBqGkfiGgIceqR1b7O3ixA2uc5pWTLg4agneI15QPCKEpyWt9s5oBUlNXjx8Q8M
         f/foP4QGc7LQKfQGWB2waZeaPpPBppcdndxVjl5Kk7fLtNiLDOCtA0RTBCmSDTfODP7A
         mB5o3IA+FxUMZiWmuQCmY4Vd1Fa2hOMCbdpzf35G5ZITooyj+4SrbHlolF0hrfAlsjZw
         kBT0H51ywEnu71hcFwnrIGJvUbn9efmnqbvQi0a1E0wc7rN3tQogQx4KI48yr4rE80wv
         LI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677959197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkOm0qwQXCVzzMhrNBH6xGLIxHx41xnkE2b0iNhuE7w=;
        b=LVipJ2IRckTixSM9XAIXPxkaIydxuLuc8k1jg8+RltDagV6r5sOj2zm7039wpQZjlC
         Ag3OiWz50KqFd7lv60H4XQrRFfNu55Ruj01JeVc7Dq1FC+NIFkYzriw+lXAhGz8zqLJE
         GmgVp/5+w/JrYCWLj79DeLeEjwRF1Kj+VN1zWbMfJgjXJSkoIX4oewnrwtAPzhMIcctT
         WoP+BpC3EBnfzVoiB3QdMQncFTocHxCAP1ezwRlHc/J14ggZtDkg3OvPLMIzIZVIWgyP
         XAWP7FIsQxKwclPVo/t/942n8F3b7APg9lftOFsFxX1CWCkUpjYpm0mo02zOq/+eSd9b
         wQNA==
X-Gm-Message-State: AO0yUKVLmVm7/w7z1SgvJHL6X+9cgP9kWLenCsut+lvKIPmP4x02h21v
        D+Bp3kGaSgGSWCw2lt2me4Q85D63Wy776A==
X-Google-Smtp-Source: AK7set+VDYNTmvddCVGHjTOL2uWFFB0E0gBf9TtyUupCda6IInH3KAc9vWKfuemWFxNzSB1w0cisCQ==
X-Received: by 2002:a05:600c:a48:b0:3da:acb1:2f09 with SMTP id c8-20020a05600c0a4800b003daacb12f09mr5326362wmq.19.1677959196849;
        Sat, 04 Mar 2023 11:46:36 -0800 (PST)
Received: from xws.localdomain ([217.138.207.232])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003e2052bad94sm10696067wms.33.2023.03.04.11.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 11:46:35 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/3] platform/surface: aggregator_tabletsw: Add support for Type-Cover posture source
Date:   Sat,  4 Mar 2023 20:46:10 +0100
Message-Id: <20230304194611.87770-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304194611.87770-1-luzmaximilian@gmail.com>
References: <20230304194611.87770-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for the Type-Cover posture source (ID 0x00), found on
the Surface Pro 9.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_tabletsw.c     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index e8682f52558f..8f52b62d1c19 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -325,9 +325,18 @@ MODULE_PARM_DESC(tablet_mode_in_slate_state, "Enable tablet mode in slate device
 #define SSAM_POS_MAX_SOURCES			4
 
 enum ssam_pos_source_id {
+	SSAM_POS_SOURCE_COVER = 0x00,
 	SSAM_POS_SOURCE_SLS   = 0x03,
 };
 
+enum ssam_pos_state_cover {
+	SSAM_POS_COVER_DISCONNECTED  = 0x01,
+	SSAM_POS_COVER_CLOSED        = 0x02,
+	SSAM_POS_COVER_LAPTOP        = 0x03,
+	SSAM_POS_COVER_FOLDED_CANVAS = 0x04,
+	SSAM_POS_COVER_FOLDED_BACK   = 0x05,
+};
+
 enum ssam_pos_state_sls {
 	SSAM_POS_SLS_LID_CLOSED = 0x00,
 	SSAM_POS_SLS_LAPTOP     = 0x01,
@@ -340,6 +349,30 @@ struct ssam_sources_list {
 	__le32 id[SSAM_POS_MAX_SOURCES];
 } __packed;
 
+static const char *ssam_pos_state_name_cover(struct ssam_tablet_sw *sw, u32 state)
+{
+	switch (state) {
+	case SSAM_POS_COVER_DISCONNECTED:
+		return "disconnected";
+
+	case SSAM_POS_COVER_CLOSED:
+		return "closed";
+
+	case SSAM_POS_COVER_LAPTOP:
+		return "laptop";
+
+	case SSAM_POS_COVER_FOLDED_CANVAS:
+		return "folded-canvas";
+
+	case SSAM_POS_COVER_FOLDED_BACK:
+		return "folded-back";
+
+	default:
+		dev_warn(&sw->sdev->dev, "unknown device posture for type-cover: %u\n", state);
+		return "<unknown>";
+	}
+}
+
 static const char *ssam_pos_state_name_sls(struct ssam_tablet_sw *sw, u32 state)
 {
 	switch (state) {
@@ -365,6 +398,9 @@ static const char *ssam_pos_state_name(struct ssam_tablet_sw *sw,
 				       const struct ssam_tablet_sw_state *state)
 {
 	switch (state->source) {
+	case SSAM_POS_SOURCE_COVER:
+		return ssam_pos_state_name_cover(sw, state->state);
+
 	case SSAM_POS_SOURCE_SLS:
 		return ssam_pos_state_name_sls(sw, state->state);
 
@@ -374,6 +410,24 @@ static const char *ssam_pos_state_name(struct ssam_tablet_sw *sw,
 	}
 }
 
+static bool ssam_pos_state_is_tablet_mode_cover(struct ssam_tablet_sw *sw, u32 state)
+{
+	switch (state) {
+	case SSAM_POS_COVER_DISCONNECTED:
+	case SSAM_POS_COVER_FOLDED_CANVAS:
+	case SSAM_POS_COVER_FOLDED_BACK:
+		return true;
+
+	case SSAM_POS_COVER_CLOSED:
+	case SSAM_POS_COVER_LAPTOP:
+		return false;
+
+	default:
+		dev_warn(&sw->sdev->dev, "unknown device posture for type-cover: %u\n", state);
+		return true;
+	}
+}
+
 static bool ssam_pos_state_is_tablet_mode_sls(struct ssam_tablet_sw *sw, u32 state)
 {
 	switch (state) {
@@ -397,6 +451,9 @@ static bool ssam_pos_state_is_tablet_mode(struct ssam_tablet_sw *sw,
 					  const struct ssam_tablet_sw_state *state)
 {
 	switch (state->source) {
+	case SSAM_POS_SOURCE_COVER:
+		return ssam_pos_state_is_tablet_mode_cover(sw, state->state);
+
 	case SSAM_POS_SOURCE_SLS:
 		return ssam_pos_state_is_tablet_mode_sls(sw, state->state);
 
-- 
2.39.2

