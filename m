Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1916A076C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjBWL3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjBWL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:29:12 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 482532D14B;
        Thu, 23 Feb 2023 03:29:10 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id B938C20B9C3F;
        Thu, 23 Feb 2023 03:29:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B938C20B9C3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677151749;
        bh=4PRW0VI+oZvbTmFAcVbsrAFK92yD8Gwq6n0ZpwB9zPo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s8OnudsOJgjLLHQc7+9s9rS+iUgsnf+HIUQupHJvC3pn4OqMwLHWxqxyHjOZWqvwf
         eWQp59Lx2IcfCgek0C2Giy0zhsWRoRsjxF8m0XUXERiRC4AgdWBmkOWEwFQSZ9XRar
         vVhF7stowDsjS3JW0Ug0bN/N1aFS2KUQriNVzwiY=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v7 2/5] ACPI: bus: Add stub acpi_sleep_state_supported() in non-ACPI cases
Date:   Thu, 23 Feb 2023 03:29:02 -0800
Message-Id: <1677151745-16521-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_sleep_state_supported() is defined only when CONFIG_ACPI=y. The
function is in acpi_bus.h, and acpi_bus.h can only be used in
CONFIG_ACPI=y cases. Add the stub function to linux/acpi.h to make
compilation successful for !CONFIG_ACPI cases.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index efff750f326d..d331f76b0c19 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1075,6 +1075,11 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
 	return 0;
 }
 
+static inline bool acpi_sleep_state_supported(u8 sleep_state)
+{
+	return false;
+}
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
-- 
2.34.1

