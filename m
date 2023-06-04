Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8283A7218D6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjFDRbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 13:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 13:31:17 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2B3D3;
        Sun,  4 Jun 2023 10:31:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-256e1d87998so3404055a91.3;
        Sun, 04 Jun 2023 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685899875; x=1688491875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuZXC8GCsPypNwiYsJHvBO2PQoUqa9X0C4ZuKWfxTxU=;
        b=JCgHtLJz1SCGhb5dDTA6M86IYU28+EguiJYKI73ckeaV30cZ1uV1eu/K4l8LCso2LB
         Ds6RH8M4uMvIInsDBJKbejwOyKfu1eRdoJxrfQl61mfWNWr7Akz8VCpI8KEQccSoo6Xv
         HwRNwlLAeS3GKthC/AqXCtW4A7IGHdr7J11CF0Bb59ezFs557oQ6E3EtJaFUtEYs6dl6
         Nn8snvk/NdcF0m71hPBQZWjixiWai7SRe1kJQWEK/lZaOTZboaZ45gQwA7qK7JQu2IaF
         TKSx3rtTfUtGNPxkV2Q41sWmqFjLBV1clriOFSq0S9/Lu9hD4SHR6qc1OwmD/d9im21n
         ddyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685899875; x=1688491875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuZXC8GCsPypNwiYsJHvBO2PQoUqa9X0C4ZuKWfxTxU=;
        b=ecsLQ6D+rW3FVPknTq+MUbCxMlZf1xKJeYgqNdxDatgMTYrKqy0C92Cn8ES+6Vk/Yz
         sDNfuxabVp0gBYx9EJryMJ5N7nC6I2YGhoZy+8NsQoPsR/JV5g53o0JI6gEbDsXZ/QJh
         b4Qhx+oE1BG8Y7378n1OUgAlCe3yfUHX1Gusssi/vBXa1T23f4bY4/sjCI1GIgn/q4xe
         WIG5JHExfJDoUJD8CqhAHYM5+6coP0/ZJqQBggLdB+BhArV2vjKObkXaSZ90aE0rQjVO
         Z25etQgCgHy1makYSwjz6Fla/rzd3HjuIzgj3d16MPUXlEjnw9+ZbOhyityqQQyijje5
         Rn3A==
X-Gm-Message-State: AC+VfDwhHlyuU4XW7v8BBwostnHvBAzd1kMQwOXPA7lmSeL/L9c0VOVF
        74px60j2fcT3QoLB3ogO/OE=
X-Google-Smtp-Source: ACHHUZ7SXjPhfonWsM71FEMQKgIfD1Mxv3Fna9qH142Ah0mN/dtvSy0yF6K29g+syKXMcrvDPk/6Tw==
X-Received: by 2002:a17:90a:6903:b0:256:544a:74c9 with SMTP id r3-20020a17090a690300b00256544a74c9mr5362200pjj.25.1685899874890;
        Sun, 04 Jun 2023 10:31:14 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id a14-20020a17090abe0e00b0023a84911df2sm4316741pjs.7.2023.06.04.10.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 10:31:14 -0700 (PDT)
From:   SungHwan Jung <onenowy@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     SungHwan Jung <onenowy@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: hp-wmi: Add thermal profile for Victus 16-d1xxx
Date:   Mon,  5 Jun 2023 02:30:23 +0900
Message-ID: <20230604173023.4675-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes Platform Profile support (performance, balanced, quiet)
for Victus 16-d1xxx (8A25).

Signed-off-by: SungHwan Jung <onenowy@gmail.com>

---
changes in v2 : clean up code
---
 drivers/platform/x86/hp/hp-wmi.c | 96 +++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 6364ae262..04c05c6b0 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -66,6 +66,11 @@ static const char *const omen_thermal_profile_force_v0_boards[] = {
 	"8607", "8746", "8747", "8749", "874A", "8748"
 };
 
+/* DMI Board names of Victus laptops */
+static const char * const victus_thermal_profile_boards[] = {
+	"8A25"
+};
+
 enum hp_wmi_radio {
 	HPWMI_WIFI	= 0x0,
 	HPWMI_BLUETOOTH	= 0x1,
@@ -176,6 +181,12 @@ enum hp_thermal_profile_omen_v1 {
 	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
 };
 
+enum hp_thermal_profile_victus {
+	HP_VICTUS_THERMAL_PROFILE_DEFAULT		= 0x00,
+	HP_VICTUS_THERMAL_PROFILE_PERFORMANCE		= 0x01,
+	HP_VICTUS_THERMAL_PROFILE_QUIET			= 0x03,
+};
+
 enum hp_thermal_profile {
 	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
 	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
@@ -1246,6 +1257,70 @@ static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static bool is_victus_thermal_profile(void)
+{
+	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
+
+	if (!board_name)
+		return false;
+
+	return match_string(victus_thermal_profile_boards,
+			    ARRAY_SIZE(victus_thermal_profile_boards),
+			    board_name) >= 0;
+}
+
+static int platform_profile_victus_get(struct platform_profile_handler *pprof,
+				     enum platform_profile_option *profile)
+{
+	int tp;
+
+	tp = omen_thermal_profile_get();
+	if (tp < 0)
+		return tp;
+
+	switch (tp) {
+	case HP_VICTUS_THERMAL_PROFILE_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case HP_VICTUS_THERMAL_PROFILE_DEFAULT:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case HP_VICTUS_THERMAL_PROFILE_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int platform_profile_victus_set(struct platform_profile_handler *pprof,
+				     enum platform_profile_option profile)
+{
+	int err, tp;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		tp = HP_VICTUS_THERMAL_PROFILE_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		tp = HP_VICTUS_THERMAL_PROFILE_DEFAULT;
+		break;
+	case PLATFORM_PROFILE_QUIET:
+		tp = HP_VICTUS_THERMAL_PROFILE_QUIET;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	err = omen_thermal_profile_set(tp);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static int thermal_profile_setup(void)
 {
 	int err, tp;
@@ -1266,6 +1341,25 @@ static int thermal_profile_setup(void)
 
 		platform_profile_handler.profile_get = platform_profile_omen_get;
 		platform_profile_handler.profile_set = platform_profile_omen_set;
+
+		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
+	} else if (is_victus_thermal_profile()) {
+		tp = omen_thermal_profile_get();
+		if (tp < 0)
+			return tp;
+
+		/*
+		 * call thermal profile write command to ensure that the
+		 * firmware correctly sets the OEM variables
+		 */
+		err = omen_thermal_profile_set(tp);
+		if (err < 0)
+			return err;
+
+		platform_profile_handler.profile_get = platform_profile_victus_get;
+		platform_profile_handler.profile_set = platform_profile_victus_set;
+
+		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
 	} else {
 		tp = thermal_profile_get();
 
@@ -1284,9 +1378,9 @@ static int thermal_profile_setup(void)
 		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
 
 		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
+		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	}
 
-	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
-- 
2.41.0

