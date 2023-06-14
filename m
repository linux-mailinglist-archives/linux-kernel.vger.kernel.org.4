Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8F73025D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbjFNOxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245110AbjFNOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:52:57 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 829301FF7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=ucBZnlh5ajBHqYFvexGp+qmzADaMW6+N4E0CS/XzLkE=; b=i
        G2MH56mjTbvUTkBH/zx6h3P7huRwLhDMwDpqWj27Z3R70ekEFOreK+bg9Syc9UYp
        3aZhIIkivTnWT1IJ88csiY7KjFKfnATLaSHfEPIrwF/9blA6+FfOj1GnroVAnFPV
        PEFPX3yubkMXjzTu35QHB1/jtwjhqrIddxxa9fRG7k=
Received: from ubuntu.localdomain (unknown [10.230.35.76])
        by app1 (Coremail) with SMTP id XAUFCgBXxT1B1IlkOe3rAA--.37009S2;
        Wed, 14 Jun 2023 22:52:49 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
To:     leo.yan@linaro.org
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        Chenyuan Mi <cymi20@fudan.edu.cn>
Subject: [PATCH] perf subcmd: Fix missing check for return value of malloc()
Date:   Wed, 14 Jun 2023 07:52:47 -0700
Message-Id: <20230614145247.114100-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgBXxT1B1IlkOe3rAA--.37009S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWkuw1UZrykXw17Xr4Dtwb_yoW3trc_Ga
        s5Z34DJrZYkFZrAw4jy392yr18t3W5Zr9Yqr4ayr13CF1jgr15ury8Cws3AFy5CrZIyF45
        JFZYvw43Ar13GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
        IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
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
which may cause null pointer deference in prepare_exec_cmd(),
add Null check for return value of malloc().

Found by our static analysis tool.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
---
 tools/lib/subcmd/exec-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/subcmd/exec-cmd.c b/tools/lib/subcmd/exec-cmd.c
index 5dbea456973e..2e45c0cd4b68 100644
--- a/tools/lib/subcmd/exec-cmd.c
+++ b/tools/lib/subcmd/exec-cmd.c
@@ -168,6 +168,8 @@ static const char **prepare_exec_cmd(const char **argv)
 	for (argc = 0; argv[argc]; argc++)
 		; /* just counting */
 	nargv = malloc(sizeof(*nargv) * (argc + 2));
+	if (!nargv)
+		return NULL;
 
 	nargv[0] = subcmd_config.exec_name;
 	for (argc = 0; argv[argc]; argc++)
-- 
2.17.1

