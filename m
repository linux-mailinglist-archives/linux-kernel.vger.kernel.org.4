Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFAB64087B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiLBOdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiLBOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:33:02 -0500
X-Greylist: delayed 909 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 06:32:56 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8050CBA4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hvSPr
        d8e1jZNisych/qs2alwu9oiP/IbUd6p6D4TfuQ=; b=ldylrim+FuGDvRYRKF7FH
        o0DBfyK0jSm0EI9165nFFpxnfolRTb1c7B/XU9/hapv51bC91/k9HhZjn19QqhHS
        DSEBff9YReE9iqxJ26tQUtMpncVtSACc7e+GGqtT6CHP6w0hCtyOIFNVHBB4uCLU
        KZXbWqx8MDYe8gseH1oZWI=
Received: from localhost.localdomain (unknown [123.52.25.162])
        by zwqz-smtp-mta-g2-3 (Coremail) with SMTP id _____wBn9rLlCIpjEUxkAA--.43988S4;
        Fri, 02 Dec 2022 22:17:10 +0800 (CST)
From:   tzm <tcm1030@163.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tzm <tcm1030@163.com>
Subject: [PATCH] mm/mempolicy: failed to disable numa balancing
Date:   Fri,  2 Dec 2022 22:16:30 +0800
Message-Id: <20221202141630.41220-1-tcm1030@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBn9rLlCIpjEUxkAA--.43988S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1fCr43CFy8ZF1fZFW7twb_yoWDKFb_Wr
        n7tryIqrsxJrWruw42yF1xAF1rWw1j93W7Wr40g3yayryxu348XrWrtF4xursFqw17Ka9r
        KF9xWr1rAr47AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUc4S7UUUUU==
X-Originating-IP: [123.52.25.162]
X-CM-SenderInfo: pwfpiiitq6il2tof0z/1tbiGAfLyFv2jwJ-UwAAsQ
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be failed to  disable numa balancing policy permanently by passing
<numa_balancing=disable> to boot cmdline parameters.
The numabalancing_override variable is int and 1 for enable -1 for disable.
So, !enumabalancing_override will always be true, which cause this bug.

Signed-off-by: tzm <tcm1030@163.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..2789c0920293 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2865,7 +2865,7 @@ static void __init check_numabalancing_enable(void)
 	if (numabalancing_override)
 		set_numabalancing_state(numabalancing_override == 1);
 
-	if (num_online_nodes() > 1 && !numabalancing_override) {
+	if (num_online_nodes() > 1 && (numabalancing_override == 1)) {
 		pr_info("%s automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl\n",
 			numabalancing_default ? "Enabling" : "Disabling");
 		set_numabalancing_state(numabalancing_default);
-- 
2.27.0

