Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1A070D5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjEWHrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjEWHqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E40F132;
        Tue, 23 May 2023 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lmSF0aSkuz0BgQn0wtrgXvYa0uJ2bg6SboCzbZE7KnY=; b=gRn1lS6gvtxboIY4eK7Mr32/3k
        TgTFYlXcPBW+fzs0MTOtQFME7M1i0INi3GhBR4btQmqVdEnj8tEN1Iq5MEaLnXwNipKVt1OjBaTxc
        8e0+L+EWc6USWJJ53yAIL5LvvhAlmu20ghCWtAM5CbBoM7yihbIH3kbF7tEYNgyK/FndqnJEm7dJw
        MPfxVdZhKfC36nM93bQplGIopsToeuFQ9ob1+ojPLg40CPhBnsLnLZK1kHLD7kTi+HFKvkdeXLJV5
        fN546HqbYQn+su3+wqs4TI1+KZRe1umVfun5/GHyU6/V62Q2A58uXMZViwvTCyUdFKwyXr2DqQTSn
        phk1iXqw==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Miy-009H91-2c;
        Tue, 23 May 2023 07:46:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 18/24] dm: open code dm_get_dev_t in dm_init_init
Date:   Tue, 23 May 2023 09:45:29 +0200
Message-Id: <20230523074535.249802-19-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523074535.249802-1-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm_init_init is called from early boot code, and thus lookup_bdev
will never succeed.  Just open code that call to early_lookup_bdev
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index d369457dbed0ed..2a71bcdba92d14 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -293,8 +293,10 @@ static int __init dm_init_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(waitfor); i++) {
 		if (waitfor[i]) {
+			dev_t dev;
+
 			DMINFO("waiting for device %s ...", waitfor[i]);
-			while (!dm_get_dev_t(waitfor[i]))
+			while (early_lookup_bdev(waitfor[i], &dev))
 				fsleep(5000);
 		}
 	}
-- 
2.39.2

