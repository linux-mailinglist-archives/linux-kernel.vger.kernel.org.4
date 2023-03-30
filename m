Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA55C6CFE37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjC3I3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjC3I3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:29:15 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD860E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:29:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VezvKlX_1680164950;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VezvKlX_1680164950)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 16:29:11 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] erofs: cleanup of xattr handling
Date:   Thu, 30 Mar 2023 16:29:02 +0800
Message-Id: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
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

changes since v1:
- patch 1: keep erofs_xattr_handler() and erofs_getxattr() untouched in
  xattr.h (Gao Xiang)
- patch 2/3: add Reviewed-by tags (Gao Xiang)
- this refactoring can be tested by [1]

[1] https://lore.kernel.org/all/20230327123926.92934-1-jefflexu@linux.alibaba.com/

v1: https://lore.kernel.org/all/20230323000949.57608-1-jefflexu@linux.alibaba.com/

Jingbo Xu (8):
  erofs: move several xattr helpers into xattr.c
  erofs: rename init_inode_xattrs with erofs_ prefix
  erofs: simplify erofs_xattr_generic_get()
  erofs: introduce erofs_xattr_iter_fixup_aligned() helper
  erofs: unify xattr_iter structures
  erofs: make the size of read data stored in buffer_ofs
  erofs: unify inline/share xattr iterators for listxattr/getxattr
  erofs: use separate xattr parsers for listxattr/getxattr

 fs/erofs/xattr.c | 683 +++++++++++++++++++----------------------------
 fs/erofs/xattr.h |  23 --
 2 files changed, 281 insertions(+), 425 deletions(-)

-- 
2.19.1.6.gb485710b

