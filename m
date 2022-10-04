Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8613F5F487A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiJDR2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJDR1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:27:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FFE659CC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:27:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j7so17021989wrr.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3dYKf0qeHKGAU0Mki69uVmAl8R+LfwbHqZ8xsk7ums=;
        b=dII8QRZ6zhyQT9a2/PchBDxFaBAr8L5XyqNrbjTTidqs+PrVbzughtWLokmMb0b8ME
         CIgnXABDQqiBBkaLVbIRJiuvM5cNqSmVQz38ATAgqE3rLScurH7PajORNFe3zKp6PB0c
         UJ2LxGHu1a+T2ddxIcUTu6LfOsg4gnXCywMRwFFKaj3OZhoHEY2YROsghbybs3vTH7bl
         Af13qD2gR48X2LQIgMvDKLe7AfetnewxOIk7dRRa0TLoHncAuIdUSXCsQRgtX/PyG2Zq
         HMfSUI1a2k6T2gvYryRRTTPkXDv4UYh+KQj1TYxm0lZJb9zeadypDIY1my424slmLCex
         QbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3dYKf0qeHKGAU0Mki69uVmAl8R+LfwbHqZ8xsk7ums=;
        b=a4rvny1kioE393zprAIjXOUTgSM+qQDXcAwNB2r0TG8FTrxfePx/SvkA38G5erRsjf
         J4WyU+dHKpp3ShGwMoqwo804RhxJzh0/79ZeZD28/sAHIeDtUHY3N8WGbpYr3G2/kdWQ
         Z/RIKuippkKiECIacuDI9mQ29KCJ6JukMgvLUjgS7K1Kg22atb9WX776lNy59TSvuTkc
         dYHL1HPHz0X7Agm19zTD2gWiS859PptK1Do8CcCUjp4iTXYKkqMqlp9Fn4tRGzYLqouu
         URoI2wvW14wkw9ibzCI+xR2Ibk3Lu3rjdmGpHoI3927TEvcT/n+VC3WM9G1jK2ku+c9H
         8LqA==
X-Gm-Message-State: ACrzQf22y/wqCLuhUiOc1tx1fRE67O4NmcZnmza+kv4o66D3kixtVJgY
        6LnWGu9LqjF4UGLxKFjZAjWZ+Q==
X-Google-Smtp-Source: AMsMyM4LXI8R1HuZNW+5VD6dycQqURSOfLBrLzAoKRh7h9K6VcQasQv31GKtfIo9sQgarr/piJKXsg==
X-Received: by 2002:a5d:4209:0:b0:22c:d5fd:1a06 with SMTP id n9-20020a5d4209000000b0022cd5fd1a06mr15858552wrq.508.1664904437688;
        Tue, 04 Oct 2022 10:27:17 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 8/9] thermal/acpi: Remove active and enabled flags
Date:   Tue,  4 Oct 2022 19:26:57 +0200
Message-Id: <20221004172658.2302511-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004172658.2302511-1-daniel.lezcano@linaro.org>
References: <12068304.O9o76ZdvQC@kreacher>
 <20221004172658.2302511-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'active' field in the struct acpi_thermal_state is never used.

The 'enabled' field of the structure acpi_thermal_state_flags is
assigned but never used.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 116e5cf19c5d..f530dbfa80db 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -117,14 +117,12 @@ struct acpi_thermal_state {
 	u8 critical:1;
 	u8 hot:1;
 	u8 passive:1;
-	u8 active:1;
 	u8 reserved:4;
 	int active_index;
 };
 
 struct acpi_thermal_state_flags {
 	u8 valid:1;
-	u8 enabled:1;
 	u8 reserved:6;
 };
 
@@ -1139,17 +1137,14 @@ static int acpi_thermal_resume(struct device *dev)
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (!tz->trips[i].flags.valid)
 			break;
-		tz->trips[i].flags.enabled = 1;
+
 		for (j = 0; j < tz->trips[i].devices.count; j++) {
 			result = acpi_bus_update_power(
 					tz->trips[i].devices.handles[j],
 					&power_state);
-			if (result || (power_state != ACPI_STATE_D0)) {
-				tz->trips[i].flags.enabled = 0;
+			if (result || (power_state != ACPI_STATE_D0))
 				break;
-			}
 		}
-		tz->state.active |= tz->trips[i].flags.enabled;
 	}
 
 	acpi_queue_thermal_check(tz);
-- 
2.34.1

