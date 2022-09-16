Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2026F5BAED6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiIPOEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiIPOEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:04:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F701AED9A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:04:08 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTbLD2hmgzlVvJ;
        Fri, 16 Sep 2022 22:00:04 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 22:04:05 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 16 Sep
 2022 22:04:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>
Subject: [PATCH -next] ALSA: ppc: Switch to use for_each_child_of_node() macro
Date:   Fri, 16 Sep 2022 22:11:08 +0800
Message-ID: <20220916141108.683080-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use for_each_child_of_node() macro instead of open coding it.
No functional change.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/ppc/tumbler.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index c65e74d7cd0a..f3f8ad7c3df8 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1060,8 +1060,7 @@ static struct device_node *find_audio_device(const char *name)
 	if (! gpiop)
 		return NULL;
   
-	for (np = of_get_next_child(gpiop, NULL); np;
-			np = of_get_next_child(gpiop, np)) {
+	for_each_child_of_node(gpiop, np) {
 		const char *property = of_get_property(np, "audio-gpio", NULL);
 		if (property && strcmp(property, name) == 0)
 			break;
@@ -1080,8 +1079,7 @@ static struct device_node *find_compatible_audio_device(const char *name)
 	if (!gpiop)
 		return NULL;
   
-	for (np = of_get_next_child(gpiop, NULL); np;
-			np = of_get_next_child(gpiop, np)) {
+	for_each_child_of_node(gpiop, np) {
 		if (of_device_is_compatible(np, name))
 			break;
 	}  
-- 
2.25.1

