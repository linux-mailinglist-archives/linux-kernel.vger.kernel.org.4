Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6737261D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbjFGN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbjFGN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:57:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71BB1BD9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NSaEYLWq1uop5RvYK0pIoKPvJvXi1yt9B2Xcy8b2PnQ=; b=bfc0guQdVCpaub5btItUyB3uI3
        xgelyRxUKOw2TeFVvNZOkgsJNND59ze3QI73FCFr51UFR2xXiUSIxKWtpzJMenyATgfwQsNNhKqH5
        E3YqYVoJIICB19Zye9X1RVzfQCoURGwUXwMJl3S+N8dYg3mlBBgys1/RRKD+yWMve1WijtSQ4f+MU
        ta7nlxDBA3XH/FvU+nqQlGe5YgwOTU7sTjBUEHmy/KT+dgwkmEfSi4CVcQ7/xE1tfayC0ZPznhqlt
        kAP3TBnf1Mpbj9rx7EzoLe7oMuMqi1FfYhygPYa5JhGppMgcgvBl2raqdnJ2O0YuxePcRBwbd2AJK
        ztBUhePQ==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6tfY-006AW8-0c;
        Wed, 07 Jun 2023 13:57:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] block: fix rootwait=
Date:   Wed,  7 Jun 2023 15:57:46 +0200
Message-Id: <20230607135746.92995-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

Failures to look up the gendisk must return -ENODEV so that rootwait
retries the lookup instead of -EINVAL which exits early.

Fixes: cf056a431215 ("init: improve the name_to_dev_t interface")
Reported-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Fabio Estevam <festevam@gmail.com>
---

[Jens, if you need to rebase for any reason it might make sense to fold
 this into the offending patch]

 block/early-lookup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 3ff0d2e4dcbfb8..48ea3e982419cc 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -181,7 +181,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	*p = '\0';
 	*devt = blk_lookup_devt(s, part);
 	if (*devt)
-		return 0;
+		return -ENODEV;
 
 	/* try disk name without p<part number> */
 	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
@@ -190,7 +190,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	*devt = blk_lookup_devt(s, part);
 	if (*devt)
 		return 0;
-	return -EINVAL;
+	return -ENODEV;
 }
 
 static int __init devt_from_devnum(const char *name, dev_t *devt)
-- 
2.39.2

