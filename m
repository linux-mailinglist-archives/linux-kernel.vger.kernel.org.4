Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2B63EA71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiLAHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiLAHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:43:01 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BF21741D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:42:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW7gIzi_1669880576;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW7gIzi_1669880576)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 15:42:57 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] erofs: support large folios for fscache mode
Date:   Thu,  1 Dec 2022 15:42:54 +0800
Message-Id: <20221201074256.16639-1-jefflexu@linux.alibaba.com>
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

v4:
- patch 1: move the change to the INLINE routine to a separate patch
  which will be sent laterly
- patch 1: introduce erofs_fscache_req_chain() helper to improve the
  code organization
- patch 1: misc improvement to make the code cleaner
- patch 2: also document the new feature in documentation

v3: https://lore.kernel.org/all/20221129115833.41062-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20221128025011.36352-1-jefflexu@linux.alibaba.com/
v1: https://lore.kernel.org/all/20221126005756.7662-1-jefflexu@linux.alibaba.com/


v3:
- patch 1: when large folios supported, one folio or folio range can be
mapped into several slices, with each slice mapped to different cookies,
and thus each slice needs its own netfs_cache_resources.

In the implementation of v2, each .read_folio() or .readahead() calling
corresponds to only one request, and thus only one netfs_cache_resources
(embedded in the request).  In this case, fscache_begin_read_operation()
may be called multiple times on this cres, while cres->ops->end_operation()
is called only once when the whole request completes.  This can cause
the leakage of the corresponding cachefiles_object->n_accesses refcount,
which will cause the user daemon hangs there forever waiting for
cache->object_count decreasing to 0 when the user daemon exits.

Worsely, as we mentioned previously, when large folios supported, one
folio or folio range can be mapped to multiple chunks on different
cookies, in which case each mapped chunk needs its own cres. In the
implementation of v2, each .read_folio() or .readahead() calling
corresponds to only one request, and thus only one cres.  This will make
the only cres used by the first chunk gets overridden by the following
chunk.

To fix this, we introduce listed requests, where each .read_folio() or
.readahead() calling can correspond to a list of requests, with each
request corresponds to one cres.


v2:
- patch 2: keep the enabling for iomap and fscache mode in separate
  patches; don't enable the feature for the meta data routine for now
  (Gao Xiang)

Patch 1 is the main part of supporting large folios for fscache mode. It
relies on a pending patch[1] adding .prepare_ondemand_read() interface
in Cachefiles.

Patch 2 just turns the switch on and enables the feature for fscache
mode. It relies on a previous patch[2] which enables this feature for
iomap mode.

[1] https://lore.kernel.org/all/20221124034212.81892-1-jefflexu@linux.alibaba.com/
[2] https://lore.kernel.org/all/20221110074023.8059-1-jefflexu@linux.alibaba.com/


Jingbo Xu (2):
  erofs: support large folios for fscache mode
  erofs: enable large folios for fscache mode

 Documentation/filesystems/erofs.rst |   2 +
 fs/erofs/fscache.c                  | 148 +++++++++++++++-------------
 fs/erofs/inode.c                    |   3 +-
 3 files changed, 83 insertions(+), 70 deletions(-)

-- 
2.19.1.6.gb485710b

