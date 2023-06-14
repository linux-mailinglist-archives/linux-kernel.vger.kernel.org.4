Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0BA730224
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjFNOpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjFNOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:45:00 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F23601BEC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=/6vr3mF6hslOrXdDeLhDz83QfJ6Uc+Wb6aSu5wFUVyc=; b=E
        3hVm/SvG6I9dq78O+xec4RwNhDCzz7IghLm2I7a0OCSpOtFNdsLDEvy/Uh5YVBO5
        3gDTQhZAAAa1s+rmcKgVXV087fUvnR+vqjS/4VD4YpPtElPSJiJ4Y6jPkTY3hZCb
        1Z9zwfDZr/odI4YnF4KMQxIbKqUahzbrI0/NYkoFCE=
Received: from ubuntu.localdomain (unknown [10.230.35.76])
        by app1 (Coremail) with SMTP id XAUFCgC3vv5Z0olkitLrAA--.37155S2;
        Wed, 14 Jun 2023 22:44:42 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
To:     andrii@kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, acme@redhat.com,
        irogers@google.com, linux-kernel@vger.kernel.org,
        Chenyuan Mi <cymi20@fudan.edu.cn>
Subject: [PATCH] tools: Fix missing check for return value of malloc()
Date:   Wed, 14 Jun 2023 07:44:40 -0700
Message-Id: <20230614144440.113375-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgC3vv5Z0olkitLrAA--.37155S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWkuw1kZw48ZFyxXr4rAFb_yoWxurc_GF
        4xXwn7Gry3ArZFka13KrWqqryFka15uw4F9ay3tr13JFyjkF4rJ34qyFs5ZFW3CrW09ry3
        C398Krn8Jr4akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: isqsiiisuqikmt6i3vldqovvfxof0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The malloc() function may return NULL when it fails,
which may cause null pointer deference in kmalloc(),
add Null check for return value of malloc().

Found by our static analysis tool.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
---
 tools/lib/slab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/slab.c b/tools/lib/slab.c
index 959997fb0652..cee98eb0a6d6 100644
--- a/tools/lib/slab.c
+++ b/tools/lib/slab.c
@@ -19,6 +19,8 @@ void *kmalloc(size_t size, gfp_t gfp)
 		return NULL;
 
 	ret = malloc(size);
+	if (!ret)
+		return NULL;
 	uatomic_inc(&kmalloc_nr_allocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from malloc\n", ret);
-- 
2.17.1

