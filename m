Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB26A8448
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCBOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCBOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:39:21 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F12A6E6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:39:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VcxhpyY_1677767955;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcxhpyY_1677767955)
          by smtp.aliyun-inc.com;
          Thu, 02 Mar 2023 22:39:16 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] erofs: set block size to the on-disk block size
Date:   Thu,  2 Mar 2023 22:39:13 +0800
Message-Id: <20230302143915.111739-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v3:
- patch 1: remove redundant newline when printing messages (Gao Xiang)
- patch 2: introduce dirblkbits in on-disk superblock and disable this
  feature for now, so that the current kernel won't break with the image
  with this feature enabled later (Gao Xiang)


v1: https://lore.kernel.org/all/20230216094745.47868-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230217055016.71462-2-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/all/20230220025046.103777-1-jefflexu@linux.alibaba.com/

Jingbo Xu (2):
  erofs: avoid hardcoded blocksize for subpage block support
  erofs: set block size to the on-disk block size

 fs/erofs/data.c              | 50 ++++++++++++++------------
 fs/erofs/decompressor.c      |  6 ++--
 fs/erofs/decompressor_lzma.c |  4 +--
 fs/erofs/dir.c               | 22 ++++++------
 fs/erofs/erofs_fs.h          |  5 +--
 fs/erofs/fscache.c           |  5 +--
 fs/erofs/inode.c             | 23 ++++++------
 fs/erofs/internal.h          | 29 +++++----------
 fs/erofs/namei.c             | 14 ++++----
 fs/erofs/super.c             | 70 ++++++++++++++++++++++--------------
 fs/erofs/xattr.c             | 40 ++++++++++-----------
 fs/erofs/xattr.h             | 10 +++---
 fs/erofs/zdata.c             | 18 +++++-----
 fs/erofs/zmap.c              | 29 +++++++--------
 include/trace/events/erofs.h |  4 +--
 15 files changed, 170 insertions(+), 159 deletions(-)

-- 
2.19.1.6.gb485710b

