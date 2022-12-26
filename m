Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DFB65604E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLZGRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLZGRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:17:21 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB48BD44;
        Sun, 25 Dec 2022 22:17:17 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E97D21A0091E;
        Mon, 26 Dec 2022 14:17:20 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfs.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i3XE_Magtkvy; Mon, 26 Dec 2022 14:17:20 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D9AFF1A00912;
        Mon, 26 Dec 2022 14:17:19 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, sebastian.fricke@collabora.com,
        ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH] drivers/media/v4l2-core/v4l2-h264.c : add detection of null pointers
Date:   Mon, 26 Dec 2022 14:17:11 +0800
Message-Id: <20221226061711.3988-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue the program when the pointer assignment is successful.

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 72bd64f65198..1163cd48ff33 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -343,18 +343,19 @@ static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *bui
 	int n = 0, i;
 
 	*out_str = kmalloc(tmp_str_size, GFP_KERNEL);
-
-	n += snprintf(*out_str + n, tmp_str_size - n, "|");
-
-	for (i = 0; i < builder->num_valid; i++) {
-		int frame_num = builder->refs[reflist[i].index].frame_num;
-		u32 poc = v4l2_h264_get_poc(builder, reflist + i);
-		bool longterm = builder->refs[reflist[i].index].longterm;
-
-		n += scnprintf(*out_str + n, tmp_str_size - n, "%i%c%c|",
-			       longterm ? frame_num : poc,
-			       longterm ? 'l' : 's',
-			       ref_type_to_char(reflist[i].fields));
+	if (*out_str != NULL) {
+		n += snprintf(*out_str + n, tmp_str_size - n, "|");
+
+		for (i = 0; i < builder->num_valid; i++) {
+			int frame_num = builder->refs[reflist[i].index].frame_num;
+			u32 poc = v4l2_h264_get_poc(builder, reflist + i);
+			bool longterm = builder->refs[reflist[i].index].longterm;
+
+			n += scnprintf(*out_str + n, tmp_str_size - n, "%i%c%c|",
+				       longterm ? frame_num : poc,
+				       longterm ? 'l' : 's',
+				       ref_type_to_char(reflist[i].fields));
+		}
 	}
 
 	return *out_str;
-- 
2.18.2

