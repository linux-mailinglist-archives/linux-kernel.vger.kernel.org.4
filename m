Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA886DAEB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbjDGORW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:17:18 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C76EB8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:17:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfX2QPl_1680877030;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX2QPl_1680877030)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:11 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] erofs: introduce long xattr name prefixes feature
Date:   Fri,  7 Apr 2023 22:17:03 +0800
Message-Id: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
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

Background
=========
overlayfs uses xattrs to keep its own metadata.  If such xattrs are
heavily used, such as Composefs model [1], large amount of xattrs
with diverse xattr values exist but only a few common xattr names
are valid (trusted.overlay.redirect, trusted.overlay.digest, and
maybe more in the future) . For example:

# file 1
trusted.overlay.redirect="xxx"

# file 2
trusted.overlay.redirect="yyy"

That makes the existing predefined prefixes ineffective in both image
size and runtime performance.

Solution Proposed
====================
Let's introduce long xattr name prefixes now to fix this.  They work
similarly as the predefined name prefixes, except that long xattr name
prefixes are user specified.

When a long xattr name prefix is used, the shared long xattr prefixes
are stored in the packed or meta inode, while the remained trailing part
of the xattr name apart from the long xattr name prefix will be stored
in erofs_xattr_entry.e_name.  e_name is empty if the xattr name matches
exactly as the long xattr name prefix.

Erofs image sizes will be smaller in the above described scenario where
all files have diverse xattr values with the same set of xattr names[2],
such as having following xattrs like:

trusted.overlay.metacopy=""
trusted.overlay.redirect="xxx"

Here are the image sizes for comparison (32-byte inodes are used):

```
7.4M  large.erofs.T0.xattr
6.4M  large.erofs.T0.xattr.share
```

- share: "--xattr-prefix=trusted.overlay.redirect" option of mkfs.erofs.
w/ this option, the long xattr name prefixes feature is enabled.

It can be seen ~14% disk space is saved with this feature in this
typical workload, therefore metadata I/Os could also be more effective
then.

Test
====
It passes erofs/019 of erofs-utils.


[1] https://lore.kernel.org/all/CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com/
[2] https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i



Gao Xiang (1):
  erofs: keep meta inode into erofs_buf

Jingbo Xu (6):
  erofs: initialize packed inode after root inode is assigned
  erofs: move packed inode out of the compression part
  erofs: introduce on-disk format for long xattr name prefixes
  erofs: add helpers to load long xattr name prefixes
  erofs: handle long xattr name prefixes properly
  erofs: enable long extended attribute name prefixes

 fs/erofs/data.c     |  23 +++++----
 fs/erofs/dir.c      |   3 +-
 fs/erofs/erofs_fs.h |  20 +++++++-
 fs/erofs/internal.h |  20 ++++++--
 fs/erofs/namei.c    |   4 +-
 fs/erofs/super.c    |  42 +++++++++-------
 fs/erofs/xattr.c    | 116 +++++++++++++++++++++++++++++++++++++++++---
 fs/erofs/xattr.h    |   4 ++
 fs/erofs/zdata.c    |   4 +-
 9 files changed, 192 insertions(+), 44 deletions(-)

-- 
2.19.1.6.gb485710b

