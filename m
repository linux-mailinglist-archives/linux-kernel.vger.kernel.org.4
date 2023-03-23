Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748E96C5B28
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCWAKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCWAKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:10:31 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD3A31BD1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:10:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VeRymBJ_1679530189;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VeRymBJ_1679530189)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 08:09:49 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] erofs: cleanup of xattr handling
Date:   Thu, 23 Mar 2023 08:09:41 +0800
Message-Id: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch 1-4 are trivial cleanups .

patch 5-7 makes inline_getxattr() and inline_listxattr() unified as
iter_inline_xattr(), shared_getxattr() and shared_listxattr() unified as
iter_shared_xattr().

patch 8 converts the callback styled xattr_foreach() to two separate
xattr handling fucntions for listxattr and getxattr, i.e.
erofs_listxattr_foreach() and erofs_getxattr_foreach().

It has passed erofs/019 testcase of erofs-utils.

Jingbo Xu (8):
  erofs: move several xattr helpers into xattr.c
  erofs: rename init_inode_xattrs with erofs_ prefix
  erofs: simplify erofs_xattr_generic_get()
  erofs: introduce erofs_xattr_iter_fixup_aligned() helper
  erofs: unify xattr_iter structures
  erofs: make the size of read data stored in buffer_ofs
  erofs: unify inline/share xattr iterators for listxattr/getxattr
  erofs: use separate xattr parsers for listxattr/getxattr

 fs/erofs/xattr.c | 705 ++++++++++++++++++++---------------------------
 fs/erofs/xattr.h |  56 ----
 2 files changed, 303 insertions(+), 458 deletions(-)

-- 
2.19.1.6.gb485710b

