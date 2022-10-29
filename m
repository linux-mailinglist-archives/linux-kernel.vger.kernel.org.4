Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818C061245B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJ2QFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJ2QFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:05:19 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9E0C2EF38
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=0B1FVaVV5evkwbVPgn
        9oHtnGGpcrFJzZgKclD7ch7cM=; b=at/uIxwMMvJmERcIQPH+8i0BGtOFHlbVBQ
        oA5JNeWERApikSAdA29Q2wAdDt4/vSjUhS54BJLcckq5VZ+I/dMxu4MrGD8bi72v
        KilErDXWyWpbFoZ9rARdKp5UwnscNfrhAlTyH7Z6du5r7Nj2Ut6CtT+C4llAQ4sW
        yDlWn7LfA=
Received: from localhost.localdomain (unknown [153.37.166.1])
        by smtp1 (Coremail) with SMTP id GdxpCgDn8IYbT11jsfL5oQ--.17034S4;
        Sun, 30 Oct 2022 00:05:06 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, lizhe <sensor1010@163.com>
Subject: [PATCH v1] drivers/dm-crypt.c : remove redundant state settings after waking up
Date:   Sat, 29 Oct 2022 09:04:41 -0700
Message-Id: <20221029160441.15310-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgDn8IYbT11jsfL5oQ--.17034S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRQTmhUUUUU
X-Originating-IP: [153.37.166.1]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBdBKpq1gi4TLiagAAsF
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	The task status has been set to TASK_RUNNING in schedule(),
	 no need to set again here

Signed-off-by: lizhe <sensor1010@163.com>
---
 drivers/md/dm-crypt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..dd82e5aad729 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1913,7 +1913,6 @@ static int dmcrypt_write(void *data)
 
 		schedule();
 
-		set_current_state(TASK_RUNNING);
 		spin_lock_irq(&cc->write_thread_lock);
 		goto continue_locked;
 
-- 
2.17.1

