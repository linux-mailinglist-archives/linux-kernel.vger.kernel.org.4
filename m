Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A30746BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGDISY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjGDISU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:18:20 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89314E76;
        Tue,  4 Jul 2023 01:18:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A11B93FDAB;
        Tue,  4 Jul 2023 08:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688458696;
        bh=yrFpnLmW5SCE801zkgLbNLwEeYgM8w4TAiD7q1vlzYY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kPwZVwKjbPBcuSNskJOYFk4UuTZ8pe6x8WLocwcOVr+LKAhJTl39pQ/mDsChJifB7
         7Ru4wlq1TTy/u0kK3HySZzUAz670l+wAvU9deMcz74YJD3tLlELnZOmkYbeSY7fhIx
         LXi/2gQlQOTGiXQ/ywD7dbnKnKEHb5y0105WtB20ChWsjlAvFoGaVSXGOJo2jctcpI
         Fh7BAyoINv0oc1jklxBV8ay+BubzHxDA5huyeQZ2tSn7Ffm7J8AR8yHB64PnEzEtaz
         Od1d+aSCf8ZodGc05k/D0dLRi3432/j184TukIreCKo56BNWS6hpw7/uZhu+24Qq+G
         s+7a0z/Xzc3Cg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     basavaraj.natikar@amd.com
Cc:     mario.limonciello@amd.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: amd_sfh: Increase bitwidth to avoid shift-out-of-bounds
Date:   Tue,  4 Jul 2023 16:17:21 +0800
Message-Id: <20230704081724.2308195-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN complains shift-out-of-bounds on amd_sfh:
[    7.593412] input: SYNA3105:00 06CB:CEA3 Mouse as /devices/platform/AMDI0010:00/i2c-0/i2c-SYNA3105:00/0018:06CB:CEA3.0001/input/input11
[    7.593541] input: SYNA3105:00 06CB:CEA3 Touchpad as /devices/platform/AMDI0010:00/i2c-0/i2c-SYNA3105:00/0018:06CB:CEA3.0001/input/input12
[    7.593625] hid-multitouch 0018:06CB:CEA3.0001: input,hidraw0: I2C HID v1.00 Mouse [SYNA3105:00 06CB:CEA3] on i2c-SYNA3105:00
[    7.664537] ================================================================================
[    7.664540] UBSAN: shift-out-of-bounds in drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c:149:50
[    7.664544] shift exponent 103 is too large for 64-bit type 'long unsigned int'
[    7.664547] CPU: 5 PID: 124 Comm: kworker/5:1 Tainted: G        W          6.4.0-next-20230703 #1
[    7.664549] Hardware name: HP HP EliteBook 835 13 inch G10 Notebook PC/8C10, BIOS V83 Ver. 01.01.09 06/05/2023
[    7.664551] Workqueue: events amd_sfh_work_buffer [amd_sfh]
[    7.664562] Call Trace:
[    7.664564]  <TASK>
[    7.664567]  dump_stack_lvl+0x48/0x70
[    7.664576]  dump_stack+0x10/0x20
[    7.664578]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
[    7.664584]  ? sched_clock_noinstr+0x9/0x10
[    7.664589]  ? sched_clock_cpu+0x12/0x1d0
[    7.664594]  ? raw_spin_rq_lock_nested+0x1e/0xa0
[    7.664597]  ? psi_group_change+0x237/0x520
[    7.664600]  float_to_int.cold+0x18/0xcf [amd_sfh]
[    7.664606]  ? __pfx_get_input_rep+0x10/0x10 [amd_sfh]
[    7.664611]  get_input_rep+0x241/0x340 [amd_sfh]
[    7.664617]  amd_sfh_work_buffer+0x91/0x190 [amd_sfh]
[    7.664622]  process_one_work+0x229/0x450
[    7.664627]  worker_thread+0x50/0x3f0
[    7.664629]  ? __pfx_worker_thread+0x10/0x10
[    7.664632]  kthread+0xf4/0x130
[    7.664635]  ? __pfx_kthread+0x10/0x10
[    7.664638]  ret_from_fork+0x29/0x50
[    7.664644]  </TASK>
[    7.664652] ================================================================================

So increase the variable bitwidth to solve the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index 6f0d332ccf51..550639ef8bfe 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -134,7 +134,8 @@ static void get_common_inputs(struct common_input_property *common, int report_i
 
 static int float_to_int(u32 float32)
 {
-	int fraction, shift, mantissa, sign, exp, zeropre;
+	int fraction, shift, sign, exp, zeropre;
+	s128 mantissa;
 
 	mantissa = float32 & GENMASK(22, 0);
 	sign = (float32 & BIT(31)) ? -1 : 1;
-- 
2.34.1

