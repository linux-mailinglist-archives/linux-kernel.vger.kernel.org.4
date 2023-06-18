Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BF87345B7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjFRJeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 05:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFRJeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 05:34:05 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F71710E9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 02:34:04 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AonGq59X5yzHXAonGqVxjA; Sun, 18 Jun 2023 11:34:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687080842;
        bh=aVg/k7ynCstaMz721k7lr6Az8vrDxOwyA02xIprHpec=;
        h=From:To:Cc:Subject:Date;
        b=keWNbqPt6AoeSWh7bs0Pxc+aVdWPLZihbxi3uZ+XUbPzMsUNtqINXjqOgyJ8qdvuM
         pcK9hR088E5/XTA3d6vgBqU5slH+OcbJb8az1qqaXr3Lt5xpMn0ef9OdIypuGicH+F
         rlFL5ugkrNZFqMAesArycjeaquu1kN4m6GgaRagFZNsnaUnbvXPSFvlB6NU3p4/BL/
         00/Zu77MKIj3V4YBLlg3RZi/JFf9Gq8SVWHxP7cP0ruyC38+Nn8s+EfyAUTFSLBfJF
         Aj/ic/1BOodkREUsim9RHfshFBPD6RBfZElx8JX1hU9eCDVCJEIwFYPORCIZmnEI1X
         wyty99C5Ebpqw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Jun 2023 11:34:02 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH net-next] mctp: Reorder fields in 'struct mctp_route'
Date:   Sun, 18 Jun 2023 11:33:55 +0200
Message-Id: <393ad1a5aef0aa28d839eeb3d7477da0e0eeb0b0.1687080803.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct mctp_route'
from 72 to 64 bytes.

It saves a few bytes of memory and is more cache-line friendly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct mctp_route {
	mctp_eid_t                 min;                  /*     0     1 */
	mctp_eid_t                 max;                  /*     1     1 */

	/* XXX 6 bytes hole, try to pack */

	struct mctp_dev *          dev;                  /*     8     8 */
	unsigned int               mtu;                  /*    16     4 */
	unsigned char              type;                 /*    20     1 */

	/* XXX 3 bytes hole, try to pack */

	int                        (*output)(struct mctp_route *, struct sk_buff *); /*    24     8 */
	struct list_head           list;                 /*    32    16 */
	refcount_t                 refs;                 /*    48     4 */

	/* XXX 4 bytes hole, try to pack */

	struct callback_head       rcu __attribute__((__aligned__(8))); /*    56    16 */

	/* size: 72, cachelines: 2, members: 9 */
	/* sum members: 59, holes: 3, sum holes: 13 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
	/* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));


After:
=====
struct mctp_route {
	mctp_eid_t                 min;                  /*     0     1 */
	mctp_eid_t                 max;                  /*     1     1 */
	unsigned char              type;                 /*     2     1 */

	/* XXX 1 byte hole, try to pack */

	unsigned int               mtu;                  /*     4     4 */
	struct mctp_dev *          dev;                  /*     8     8 */
	int                        (*output)(struct mctp_route *, struct sk_buff *); /*    16     8 */
	struct list_head           list;                 /*    24    16 */
	refcount_t                 refs;                 /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	struct callback_head       rcu __attribute__((__aligned__(8))); /*    48    16 */

	/* size: 64, cachelines: 1, members: 9 */
	/* sum members: 59, holes: 2, sum holes: 5 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
} __attribute__((__aligned__(8)));
---
 include/net/mctp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index 82800d521c3d..da86e106c91d 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -234,9 +234,9 @@ struct mctp_flow {
 struct mctp_route {
 	mctp_eid_t		min, max;
 
-	struct mctp_dev		*dev;
-	unsigned int		mtu;
 	unsigned char		type;
+	unsigned int		mtu;
+	struct mctp_dev		*dev;
 	int			(*output)(struct mctp_route *route,
 					  struct sk_buff *skb);
 
-- 
2.34.1

