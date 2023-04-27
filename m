Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA29B6F0BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244500AbjD0SFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbjD0SFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:05:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7E43A91
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:05:48 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id s601pK3Rr0J4ws601pkhoW; Thu, 27 Apr 2023 20:05:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682618747;
        bh=05s457roHVtlfYNypW2X8/+0EwbbmCegZeHOrtx9DR8=;
        h=From:To:Cc:Subject:Date;
        b=LkiPyXmL2zlMA/UwRMeBbsLQ+zg60jEPXuq+invSzYxMIqjcsOMYHSqLEZg/HQz5s
         orqf91Xnu06X72a3b8udo8vj3bvVArLWjlWnR+W2FLzZICQlXsqlXb9EbzTgkmncZE
         jiiDqb50dW2vVlp2rZmnOWaSE+N5zCdaKQ0G6xE5Sl23NAvANSDtt055JNTNg9D/5e
         +2jRcQ0dtVjgeW0HkqoeASQyhnpXOewv2PalEz3AIvXVeWkRorFkd1ukqRkEP1Zvyj
         ymDqhXVTR7pycsucL/Ka2nzBSGeOPixooayHLgwYSR5AgBVC+Wa0O81PcSQgnVJEIF
         T1SxDLhPlWIJw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 27 Apr 2023 20:05:46 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: Reorder fields in 'struct ceph_snapid_map'
Date:   Thu, 27 Apr 2023 20:05:42 +0200
Message-Id: <559c9a70419846e0cfc319505d3d5fffd45b3358.1682618727.git.christophe.jaillet@wanadoo.fr>
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

Group some variables based on their sizes to reduce holes.
On x86_64, this shrinks the size of 'struct ceph_snapid_map' from 72 to 64
bytes.

When such a structure is allocated, because of the way memory allocation
works, when 72 bytes were requested, 96 bytes were allocated.

So, on x86_64, this change saves 32 bytes per allocation and has the
structure fit in a single cacheline.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct ceph_snapid_map {
	struct rb_node             node __attribute__((__aligned__(8))); /*     0    24 */
	struct list_head           lru;                  /*    24    16 */
	atomic_t                   ref;                  /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        snap;                 /*    48     8 */
	dev_t                      dev;                  /*    56     4 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 1 boundary (64 bytes) --- */
	long unsigned int          last_used;            /*    64     8 */

	/* size: 72, cachelines: 2, members: 6 */
	/* sum members: 64, holes: 2, sum holes: 8 */
	/* forced alignments: 1 */
	/* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));
---
 fs/ceph/mds_client.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0598faa50e2e..2328dbda5ab6 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -355,8 +355,8 @@ struct ceph_snapid_map {
 	struct rb_node node;
 	struct list_head lru;
 	atomic_t ref;
-	u64 snap;
 	dev_t dev;
+	u64 snap;
 	unsigned long last_used;
 };
 
-- 
2.34.1

