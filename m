Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F382692A65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjBJWoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjBJWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:44:08 -0500
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDB175359
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676069029; bh=QK0Io72eZJ66J+02kMiKHYwnQlKba5/GeUdWMRli1RI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=zCIgN9dD+uwMmfP7fS4n5i4txVl0XKsINt3JEeHz2Uazee/6QFLttPfa3lWppF18A
         t1FW3Jk/4EDz/BkyFMu9+Q+1GYOUhMJv23nErlP0qKfMUIxIlAXByIOLGJxFdOterK
         m0Np1HftVKoLfH1KjD+wvaTW6wzFBy0beXc5KzjK6Of6EONJiqQ1siBWFQ+jrleli0
         Q067yuQaHnvdPy+OW5bBB3ZYrbmxf1QUzRqbF7pweJqNI6I7z2PUmUWs3xb+aXc2Az
         3w0SMrs2Pwsyfdua7N/0rAd4RkDiEAdFOVchPG3axASwVGL/e/OiQAmCHgaDuXbEez
         8Zmy+MR2M9ktQ==
Received: from localhost (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id EF069800AC;
        Fri, 10 Feb 2023 22:43:47 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] reset: sti: rely on regmap_field_read_poll_timeout for ack wait
Date:   Fri, 10 Feb 2023 23:43:31 +0100
Message-Id: <20230210224332.98482-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: olJztAjsOxrn0yEeB-9ncMCf4c3kGzxd
X-Proofpoint-GUID: olJztAjsOxrn0yEeB-9ncMCf4c3kGzxd
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=862
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302100195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap_field_read_poll_timeout function when waiting for the
ack bit upon performing the reset control.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/reset/sti/reset-syscfg.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/reset/sti/reset-syscfg.c b/drivers/reset/sti/reset-syscfg.c
index b4b46e0f207e..c1ba04f6f155 100644
--- a/drivers/reset/sti/reset-syscfg.c
+++ b/drivers/reset/sti/reset-syscfg.c
@@ -64,22 +64,12 @@ static int syscfg_reset_program_hw(struct reset_controller_dev *rcdev,
 		return err;
 
 	if (ch->ack) {
-		unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 		u32 ack_val;
 
-		while (true) {
-			err = regmap_field_read(ch->ack, &ack_val);
-			if (err)
-				return err;
-
-			if (ack_val == ctrl_val)
-				break;
-
-			if (time_after(jiffies, timeout))
-				return -ETIME;
-
-			cpu_relax();
-		}
+		err = regmap_field_read_poll_timeout(ch->ack, ack_val, (ack_val == ctrl_val),
+						     100, USEC_PER_SEC);
+		if (err)
+			return err;
 	}
 
 	return 0;
-- 
2.34.1

