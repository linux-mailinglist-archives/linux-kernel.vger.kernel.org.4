Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1063BF92
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiK2L7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK2L6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:58:39 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB54C65CC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:58:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW-kQll_1669723113;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW-kQll_1669723113)
          by smtp.aliyun-inc.com;
          Tue, 29 Nov 2022 19:58:34 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] erofs: support large folios for fscache mode
Date:   Tue, 29 Nov 2022 19:58:31 +0800
Message-Id: <20221129115833.41062-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

v2: https://lore.kernel.org/all/20221128025011.36352-1-jefflexu@linux.alibaba.com/
v1: https://lore.kernel.org/all/20221126005756.7662-1-jefflexu@linux.alibaba.com/

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

 fs/erofs/fscache.c | 166 ++++++++++++++++++++++++---------------------
 fs/erofs/inode.c   |   3 +-
 2 files changed, 89 insertions(+), 80 deletions(-)

-- 
2.19.1.6.gb485710b

