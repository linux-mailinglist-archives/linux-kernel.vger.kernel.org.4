Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA686727EC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjFHLak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjFHLah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:30:37 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F132711
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:30:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkeCuqc_1686223820;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VkeCuqc_1686223820)
          by smtp.aliyun-inc.com;
          Thu, 08 Jun 2023 19:30:21 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] erofs: cleanup of xattr handling
Date:   Thu,  8 Jun 2023 19:30:15 +0800
Message-Id: <20230608113020.66626-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v5:
- patch 1: newly added into this series, in preparation for the
  following cleanup
- patch 5: rename erofs_xattr_body() to erofs_xattr_handle_string()

changes since v4:
- patch 1: make conversions from erofs_read_metabuf() in xattr.c
  to "erofs_init_metabuf() + erofs_bread()" a separate patch
- patch 6: add "bool copy" function parameter to erofs_xattr_body(), and
  thus make erofs_xattr_namematch() and erofs_xattr_copy() inlined
  inside erofs_xattr_body()

changes since v3:
- patch 1: make a unified erofs_xattr_iter_fixup() API with newly
  introduced "bool nospan" argument; call erofs_init_metabuf() and
  erofs_bread() separately instead of erofs_read_metabuf()
- patch 2: avoid duplicated strlen() calculation in erofs_getxattr(); no
  need zeroing other fields when initializing 'struct erofs_xattr_iter'
- patch 4: don't explode 'struct erofs_xattr_iter' with inode/getxattr
  fields; instead pass inode/getxattr parameters through function
  parameters of erofs_iter_[inline|shared]_xattr()
- patch 5: don't explode 'struct erofs_xattr_iter' with remaining field;
  instead  calculate and check the remaining inside
  erofs_iter_inline_xattr()

changes since v2:
- rebase to v6.4-rc2
- passes xattr tests (erofs/019,020,021) of erofs-utils [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests

v5: https://lore.kernel.org/all/20230601024347.108469-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/all/20230531031330.3504-1-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/lkml/20230518024551.123990-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230330082910.125374-1-jefflexu@linux.alibaba.com/
v1: https://lore.kernel.org/all/20230323000949.57608-1-jefflexu@linux.alibaba.com/


Jingbo Xu (5):
  erofs: use absolute position in xattr iterator
  erofs: unify xattr_iter structures
  erofs: make the size of read data stored in buffer_ofs
  erofs: unify inline/share xattr iterators for listxattr/getxattr
  erofs: use separate xattr parsers for listxattr/getxattr

 fs/erofs/xattr.c | 652 +++++++++++++++++------------------------------
 1 file changed, 227 insertions(+), 425 deletions(-)

-- 
2.19.1.6.gb485710b

