Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13F6EE2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjDYNZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYNZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:25:53 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B3313C11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:25:49 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rIfzpNZfxLbpDrIfzphTyk; Tue, 25 Apr 2023 15:25:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682429148;
        bh=0CeXjHqICQk7DLJzz6VjSF2+bjOODLrldPjkrHUYBUc=;
        h=From:To:Cc:Subject:Date;
        b=j3P89YIITwZY8lXV2Qx7n2LRfrMAL9l2sK9ZcSA6ql20V09I4b1H2XyewoveyDvrS
         3Zig775onP4tYCUdbtNBw6ATUBqf4iVKHoWnbpgUHJLJBX1K8EVBTPt9XmbolmhDPz
         f+cC1Dbyq+BFRdhlsIvm0TYD9DcwmlvBXye5hKvpt12H28ZrvInjPs4ybPJGQdvPlr
         SXrLmijp4ZIKmriKBiQiysf4ythMRBchAW7IjbZ0EuWWwkBw/EeK1fc2Th4mikNNrN
         qy7OtkQfb9J/ysAzrFuq9MMa9UfiqfNb0BWz80/h1W5IuumK9W/xnkOCCOLbGGmS2v
         8MkpGYKCGpv0w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 Apr 2023 15:25:48 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: common: saa7146: Avoid a leak in vmalloc_to_sg()
Date:   Tue, 25 Apr 2023 15:25:46 +0200
Message-Id: <c9a526ef9600df82ffdea96413428bf34472b666.1682429093.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit in Fixes turned a BUG() into a "normal" memory allocation failure.
While at it, it introduced a memory leak.
So fix it.

Also update the comment on top of the function to reflect what has been
change by the commit in Fixes.

Fixes: 40e986c99624 ("media: common: saa7146: replace BUG_ON by WARN_ON")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/common/saa7146/saa7146_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/common/saa7146/saa7146_core.c b/drivers/media/common/saa7146/saa7146_core.c
index bcb957883044..27c53eed8fe3 100644
--- a/drivers/media/common/saa7146/saa7146_core.c
+++ b/drivers/media/common/saa7146/saa7146_core.c
@@ -133,8 +133,8 @@ int saa7146_wait_for_debi_done(struct saa7146_dev *dev, int nobusyloop)
  ****************************************************************************/
 
 /* this is videobuf_vmalloc_to_sg() from videobuf-dma-sg.c
-   make sure virt has been allocated with vmalloc_32(), otherwise the BUG()
-   may be triggered on highmem machines */
+   make sure virt has been allocated with vmalloc_32(), otherwise return NULL
+   on highmem machines */
 static struct scatterlist* vmalloc_to_sg(unsigned char *virt, int nr_pages)
 {
 	struct scatterlist *sglist;
@@ -150,7 +150,7 @@ static struct scatterlist* vmalloc_to_sg(unsigned char *virt, int nr_pages)
 		if (NULL == pg)
 			goto err;
 		if (WARN_ON(PageHighMem(pg)))
-			return NULL;
+			goto err;
 		sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
 	}
 	return sglist;
-- 
2.34.1

