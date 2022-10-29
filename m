Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E0E61201F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ2Eps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiJ2Epp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:45:45 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B35357CE0B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=l25OX
        4p/hAMYz0dk8GRFO4hLa90RHg3qZ20JBQUZdOI=; b=h9WyU5v+TUAdt1KbmNqGG
        0nf4nXfV8oaHqYbp+jQhyakNMf29UrUcI3vLnQoXvn0+pwosEaADdZRP8rkF0ZP6
        Y7q+43nyrmmlISFSHzkjOyA7ylOEIaToticpYzaLtbM3U8BIgRFE+oFCAFu9WWe6
        AJOkViKoL/MFrz/tgQ30eo=
Received: from ubuntu.localdomain (unknown [183.192.97.130])
        by smtp11 (Coremail) with SMTP id D8CowAB3uDq2r1xj0IjmCg--.29305S4;
        Sat, 29 Oct 2022 12:44:39 +0800 (CST)
From:   Chao Xu <xuchao066@163.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chao Xu <Chao.Xu9@zeekrlife.com>
Subject: [PATCH] mm/vmstat: correct some wrong comments based-on fls()
Date:   Sat, 29 Oct 2022 12:44:36 +0800
Message-Id: <20221029044436.198169-1-xuchao066@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAB3uDq2r1xj0IjmCg--.29305S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWxCF1xJryxKF1kAFyDGFg_yoWDGrg_Ca
        y0y3Wvvr45Aw1Yka4jv3Z0grWqqFWv9r15X3sYgFyYv34DtrsxAF97Ca1DWFyfWrWDtFZ0
        k3WDJrW3Ar45AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU066wJUUUUU==
X-Originating-IP: [183.192.97.130]
X-CM-SenderInfo: x0xfxtbrqwlqqrwthudrp/1tbiGRepRlyPfI2z4AAAsQ
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Xu <Chao.Xu9@zeekrlife.com>

The threshold should grow logarithmically, using fls() as
an easy approximation. But there are some errors in fls(mem)
and fls(Processors). It is missleading so lets correct it.

Signed-off-by: Chao Xu <Chao.Xu9@zeekrlife.com>
---
 mm/vmstat.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b2371d745e00..df44b6b9e447 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -241,17 +241,17 @@ int calculate_normal_threshold(struct zone *zone)
 	 * 28		2		2	4-8 GB		7
 	 * 32		2		2	8-16 GB		8
 	 * 4		2		2	<128M		1
-	 * 30		4		3	2-4 GB		5
+	 * 30		4		3	2-4 GB		6
 	 * 48		4		3	8-16 GB		8
-	 * 32		8		4	1-2 GB		4
+	 * 32		8		4	1-2 GB		5
 	 * 32		8		4	0.9-1GB		4
 	 * 10		16		5	<128M		1
 	 * 40		16		5	900M		4
-	 * 70		64		7	2-4 GB		5
-	 * 84		64		7	4-8 GB		6
-	 * 108		512		9	4-8 GB		6
-	 * 125		1024		10	8-16 GB		8
-	 * 125		1024		10	16-32 GB	9
+	 * 70		64		7	2-4 GB		6
+	 * 84		64		7	4-8 GB		7
+	 * 108		512		10	4-8 GB		7
+	 * 125		1024		11	8-16 GB		8
+	 * 125		1024		11	16-32 GB	9
 	 */
 
 	mem = zone_managed_pages(zone) >> (27 - PAGE_SHIFT);
-- 
2.25.1

