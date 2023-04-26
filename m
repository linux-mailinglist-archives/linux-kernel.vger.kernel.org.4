Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254D46EF878
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjDZQbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDZQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF0576A5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CC7161121
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 16:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603BEC433EF;
        Wed, 26 Apr 2023 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682526680;
        bh=LsQFJnxGfjStsxu61/64S4NIq//Zy3OsmBBferjPxOk=;
        h=From:Date:Subject:To:Cc:From;
        b=tgPB9KRzc+dlkWvvv4GpVng/VuOueuOe3eiOktEzHMBWZ64LNKyEILKnI0wcsCBDD
         v22T7aspz8jReXiYx0T+Vht65vG6DlZuvCMRV5mkyoK2ivS5qj4VTmUUA5/9DoAL9Q
         n84IC7dhv4DXERvPvT1SBCFVcf5nqrooJlRjpob8wFyR1sy7Wsw6wrHkpy4VoDXMOO
         67+IGngac/+oVj1RP/dIUFiArRwKVRrHKtcvB+ZMwlkpQdPMe2MCXRemFAckJsw5b3
         e8ZthkHahmbisvS2/LCGNCle5tprATuQ/+dcgbzzCP40+FeCswZUzk20spu5OjRVPf
         EiRBGt2XtIKsQ==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Wed, 26 Apr 2023 16:30:35 +0000
Subject: [PATCH] fs/9p: Fix bit operation logic error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-fix-bitops-v1-1-ab11e8f4f23a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKpRSWQC/x2NQQqDMBBFryKz7tB0WiT2KsVFEsdmNonMiAji3
 Ru7fPDf+wcYq7DBuztAeROTWho8bh2kHMqXUabGQI6e7kU9zrJjlLUuhsn35IYh+Yk8NCEGY4w
 aSsqX0sJpy/e5Khbe12uxKDf/f/cZz/MHqlA10H4AAAA=
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=LsQFJnxGfjStsxu61/64S4NIq//Zy3OsmBBferjPxOk=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkSVHWHtYyqX4pP4R4aeyw6Pv1ElRXf5x9d/rTj
 j5xcPM9kFiJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZElR1gAKCRCI/9X7Sl//
 mEHMD/9os90TNiC7CpEujU063unUwCPBB0wMrn1OB8TlFZ9NrB2QeTq9Ki+UCmUgb5fd0MEeLaJ
 Z5InGevGQhazA5TltCFuWUPT1YtkeY8Z82flW64zSXfYBmJBf80wwAncQUnFX8IxVChRfEVXWlC
 yudnoqgzGM+k26XrJ2/R0n91f7+sgE1IGMti+SIhww25qh7fergMhIXMos9XKG2t86hyU8F6F1X
 p6vl+EnZlRyGpNT9otBQaud9sLopTHKAdPu/3dP1lQgUlcbRmGKXOWIdnGDbIOmomYqafjYEp69
 xRnHm0LU9NDwlxpDY3bP5S/TWlFEE8pUyicVhhMy0JGql3RAiHsOBPTP0nzDLrb0Uqc9ZH17R08
 YGq7Ix0KGME0f1lbnQV0WhOu7ZcdmVbz7m81RJ/VX2Q0QPrXbrKSXwKCW8isEeeBBgPINafcWwd
 hsvz8SjoC6xj3cVNDfdPtoXINRyOAeO7MozW/nrNCOUExFUG6CuOKowrsUnswOtMKzfW1jLtZ45
 dgNbISfl8jK0DSpX2xQ5LcMRaDRBM4qUrDo7Bomws+6CND+cFZRToBvl0cSbIkKm7cFo+tfzmCP
 jtaKihrCkhzXUBJL9B7+Remq8s7HU9i54alHaMexFwNOl4wVznzSGNM57VmIlACj3bbe4e5hPWH
 rkown5fAySn5bxQ==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This re-introduces a fix that somehow got dropped during rebase of the
current series in for-next.  When writeback is enabled, opens
are forced to support both read and write operations but with the
logic error other flags may be dropped unintentionaly.

Reported-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode.c      | 2 +-
 fs/9p/vfs_inode_dotl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 54dfe4f10f43..3791f642c502 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -823,7 +823,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	p9_omode = v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
 
 	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
-		p9_omode = (p9_omode & !P9_OWRITE) | P9_ORDWR;
+		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
 	}
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index f9371b5b70ea..3acf2bcb69cc 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -288,7 +288,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	}
 
 	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
-		p9_omode = (p9_omode & !P9_OWRITE) | P9_ORDWR;
+		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
 	}

---
base-commit: 4eb3117888a923f6b9b1ad2dd093641c49a63ae5
change-id: 20230426-fix-bitops-c862099c8d28

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

