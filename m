Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE564278A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiLELd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLELd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:33:56 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070EE6367
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:33:56 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NQhJf5HRvz5BNRf;
        Mon,  5 Dec 2022 19:33:54 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl2.zte.com.cn with SMTP id 2B5BXmkP074067;
        Mon, 5 Dec 2022 19:33:48 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 5 Dec 2022 19:33:50 +0800 (CST)
Date:   Mon, 5 Dec 2022 19:33:50 +0800 (CST)
X-Zmail-TransId: 2b04638dd71e1939a789
X-Mailer: Zmail v1.0
Message-ID: <202212051933509509270@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <stuyoder@gmail.com>
Cc:     <laurentiu.tudor@nxp.com>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGJ1czogZnNsLW1jOiB1c2Ugc3Ryc2NweSgpIHRvIGluc3RlYWQgb2Ygc3RybmNweSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B5BXmkP074067
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638DD722.000 by FangMail milter!
X-FangMail-Envelope: 1670240034/4NQhJf5HRvz5BNRf/638DD722.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DD722.000/4NQhJf5HRvz5BNRf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/bus/fsl-mc/dprc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index d129338b8bc0..d095d1e044e7 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -450,10 +450,8 @@ int dprc_get_obj(struct fsl_mc_io *mc_io,
 	obj_desc->ver_major = le16_to_cpu(rsp_params->version_major);
 	obj_desc->ver_minor = le16_to_cpu(rsp_params->version_minor);
 	obj_desc->flags = le16_to_cpu(rsp_params->flags);
-	strncpy(obj_desc->type, rsp_params->type, 16);
-	obj_desc->type[15] = '\0';
-	strncpy(obj_desc->label, rsp_params->label, 16);
-	obj_desc->label[15] = '\0';
+	strscpy(obj_desc->type, rsp_params->type, 16);
+	strscpy(obj_desc->label, rsp_params->label, 16);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dprc_get_obj);
@@ -491,8 +489,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
 	cmd_params->irq_addr = cpu_to_le64(irq_cfg->paddr);
 	cmd_params->irq_num = cpu_to_le32(irq_cfg->irq_num);
 	cmd_params->obj_id = cpu_to_le32(obj_id);
-	strncpy(cmd_params->obj_type, obj_type, 16);
-	cmd_params->obj_type[15] = '\0';
+	strscpy(cmd_params->obj_type, obj_type, 16);

 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
@@ -564,8 +561,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	cmd_params = (struct dprc_cmd_get_obj_region *)cmd.params;
 	cmd_params->obj_id = cpu_to_le32(obj_id);
 	cmd_params->region_index = region_index;
-	strncpy(cmd_params->obj_type, obj_type, 16);
-	cmd_params->obj_type[15] = '\0';
+	strscpy(cmd_params->obj_type, obj_type, 16);

 	/* send command to mc*/
 	err = mc_send_command(mc_io, &cmd);
-- 
2.15.2
