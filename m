Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77A62D0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKQBum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiKQBuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:50:40 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422655BD75;
        Wed, 16 Nov 2022 17:50:39 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NCNCx38RmzvM0;
        Thu, 17 Nov 2022 09:50:37 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4NCNCg1rrQz64WfR;
        Thu, 17 Nov 2022 09:50:23 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4NCNCb5JGRzdmc16;
        Thu, 17 Nov 2022 09:50:19 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCNCX3t31z8R039;
        Thu, 17 Nov 2022 09:50:16 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH1o8FT092758;
        Thu, 17 Nov 2022 09:50:08 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Thu, 17 Nov 2022 09:50:09 +0800 (CST)
Date:   Thu, 17 Nov 2022 09:50:09 +0800 (CST)
X-Zmail-TransId: 2afb63759351fffffffff87339c3
X-Mailer: Zmail v1.0
Message-ID: <202211170950093878676@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <target-devel@vger.kernel.org>
Cc:     <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guo.ziliang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNjc2k6IHRhcmdldDogVXNlIHN5c2ZzX3N0cmVxIGluc3RlYWQgb2Ygc3RybmNtcA==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH1o8FT092758
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 6375936C.000 by FangMail milter!
X-FangMail-Envelope: 1668649837/4NCNCx38RmzvM0/6375936C.000/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375936C.000/4NCNCx38RmzvM0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>
There is a ready-to-use method to compare a retrieved from a sysfs node
string with another string. It treats both NUL and newline-then-NUL as
equivalent string terminations. So use it instead of manually truncating
the line length in the strncmp() method.

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
 drivers/target/target_core_configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index f4a220a..3b89d83 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -208,7 +208,7 @@ static struct config_group *target_core_register_fabric(
                 * mkdir(2) system calls with known TCM fabric modules.
                 */

-               if (!strncmp(name, "iscsi", 5)) {
+               if (sysfs_streq(name, "iscsi")) {
                        /*
                         * Automatically load the LIO Target fabric module when the
                         * following is called:
@@ -221,7 +221,7 @@ static struct config_group *target_core_register_fabric(
                                         " iscsi_target_mod.ko: %d\n", ret);
                                return ERR_PTR(-EINVAL);
                        }
-               } else if (!strncmp(name, "loopback", 8)) {
+               } else if (sysfs_streq(name, "loopback")) {
                        /*
                         * Automatically load the tcm_loop fabric module when the
                         * following is called:
--
1.8.3.1
