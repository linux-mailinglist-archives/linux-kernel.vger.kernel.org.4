Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA1B670FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjARB2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjARB2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:28:19 -0500
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659833E0B5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:28:16 -0800 (PST)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id NSU00113;
        Wed, 18 Jan 2023 09:28:13 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.16; Wed, 18 Jan 2023 09:28:13 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <stuyoder@gmail.com>, <laurentiu.tudor@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] bus: fsl-mc: dprc: use strscpy() to instead of strncpy()
Date:   Tue, 17 Jan 2023 20:28:06 -0500
Message-ID: <20230118012806.2315-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20231180928133e67377d6fa787e82e1b28e1310d25c4
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Bo Liu <liubo03@inspur.com>
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
2.27.0

