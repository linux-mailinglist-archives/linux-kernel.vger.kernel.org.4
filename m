Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0157D62767F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiKNHjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:39:39 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33524113;
        Sun, 13 Nov 2022 23:39:37 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B68194237F;
        Mon, 14 Nov 2022 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668411572;
        bh=d7HYXsrjbhkYPHejCgZK/7KqFi0JzRgbIXzSOTLTu7A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=PfmGUmwB+Z5H5Ap4lwk7IwLS8YrjlfxN4lqauV9bTe4DYVBr4moz3nzKOdv51C9ho
         aUS23Jpjk+5D7SSART5XV4vjSCjsOnoB9t1uj+jWsibmI+KdesdS7cTyAbs1VCSwMB
         CWOeoXlAEUukZOkpslQgnkjdjHFXolgYnodjKKsVjft3aePiXrwMlkEcqddMv9/nJk
         OyVls4dQcsHqwmBgqD6LvF81MU+dGiHb07lazosCO3V1WzjP8aH+mBaVp+iomgF8dO
         +RRytVX6K7QHwr0mjsi3b2xNk4o3XQaeTJxUymgYfGgVBO1/+DG8e5uwreaqe1p/N6
         43UWOYsUTtMvg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Ignore Smart Experience App event
Date:   Mon, 14 Nov 2022 15:38:41 +0800
Message-Id: <20221114073842.205392-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes hp-wmi driver complains on system resume:
[ 483.116451] hp_wmi: Unknown event_id - 33 - 0x0

According to HP it's a feature called "HP Smart Experience App" and it's
safe to be ignored.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/platform/x86/hp-wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 12449038bed12..0a99058be8130 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -90,6 +90,7 @@ enum hp_wmi_event_ids {
 	HPWMI_PEAKSHIFT_PERIOD		= 0x0F,
 	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
 	HPWMI_SANITIZATION_MODE		= 0x17,
+	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
 };
 
 /*
@@ -859,6 +860,8 @@ static void hp_wmi_notify(u32 value, void *context)
 		break;
 	case HPWMI_SANITIZATION_MODE:
 		break;
+	case HPWMI_SMART_EXPERIENCE_APP:
+		break;
 	default:
 		pr_info("Unknown event_id - %d - 0x%x\n", event_id, event_data);
 		break;
-- 
2.34.1

