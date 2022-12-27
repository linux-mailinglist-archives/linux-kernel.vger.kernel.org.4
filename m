Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545FB6566E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiL0Cgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiL0Cgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:36:36 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B2CCC0;
        Mon, 26 Dec 2022 18:36:30 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 8660C1A009CD;
        Tue, 27 Dec 2022 10:36:35 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OfFLHNWMXRyK; Tue, 27 Dec 2022 10:36:34 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 8F0B51A00934;
        Tue, 27 Dec 2022 10:36:34 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, sebastian.fricke@collabora.com,
        ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH] drivers/media/v4l2-core/v4l2-h264 : add detection of null pointers
Date:   Tue, 27 Dec 2022 10:36:25 +0800
Message-Id: <20221227023625.7261-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the pointer variable is judged to be null, null is returned
directly.

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
---
v2: Directly return when pointer allocation fails.
v3: problems in synchronous repair format_ref_list_p

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 72bd64f65198..f6684c1d7319 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -305,6 +305,8 @@ static const char *format_ref_list_p(const struct v4l2_h264_reflist_builder *bui
 	int n = 0, i;
 
 	*out_str = kmalloc(tmp_str_size, GFP_KERNEL);
+	if (*out_str == NULL)
+		return NULL;
 
 	n += snprintf(*out_str + n, tmp_str_size - n, "|");
 
@@ -343,6 +345,8 @@ static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *bui
 	int n = 0, i;
 
 	*out_str = kmalloc(tmp_str_size, GFP_KERNEL);
+	if (*out_str == NULL)
+		return NULL;
 
 	n += snprintf(*out_str + n, tmp_str_size - n, "|");
 
-- 
2.18.2

