Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA5E7302AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245670AbjFNPCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245708AbjFNPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:01:49 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0E1F1FD2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=XfL1UX+No9Wu0g07WmgLH0+W8NRs8577m+8m8P/vCFs=; b=W
        sEX5+61PH2TUJGtij4yL185d5JFwvkgRHhgDzwz5TubVbcqOVpGhLWOiaHrwdLVw
        vC0MtuT6dCVyxM1fRIrDOvM3E36W9Qo788iAs9QJxNUJolCnP5lyNKBtXBTom18B
        nd5OQu4Ph4PJUA2Y4yP84Pn3Ma59pd49O1cEhAt1rY=
Received: from ubuntu.localdomain (unknown [10.230.35.76])
        by app1 (Coremail) with SMTP id XAUFCgAHqzw_1olkAQnsAA--.39132S2;
        Wed, 14 Jun 2023 23:01:20 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
To:     acme@redhat.com
Cc:     irogers@google.com, namhyung@kernel.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, Chenyuan Mi <cymi20@fudan.edu.cn>
Subject: [PATCH] perf subcmd: Fix missing check for return value of malloc() in add_cmdname()
Date:   Wed, 14 Jun 2023 08:01:18 -0700
Message-Id: <20230614150118.115208-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgAHqzw_1olkAQnsAA--.39132S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWkuw1kKF1kWFyrXF48Xrb_yoWxKwc_CF
        Z7Zr1kJFyfAryvvrs0k39Ig34Sya1rXFnYvw4YyFy3ua45CF1kXryDAFn3JFy3KFyv9Fyx
        Ca9Yyr1DJr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUOXo2UUUUU
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
which may cause null pointer deference in add_cmdname(),
add Null check for return value of malloc().

Found by our static analysis tool.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
---
 tools/lib/subcmd/help.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index bf02d62a3b2b..510a3eccb60f 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -16,6 +16,8 @@
 void add_cmdname(struct cmdnames *cmds, const char *name, size_t len)
 {
 	struct cmdname *ent = malloc(sizeof(*ent) + len + 1);
+	if (!ent)
+		return;
 
 	ent->len = len;
 	memcpy(ent->name, name, len);
-- 
2.17.1

