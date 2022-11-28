Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C194D639FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiK1CuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiK1CuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:50:16 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF4C75
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 18:50:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVnFHaB_1669603811;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVnFHaB_1669603811)
          by smtp.aliyun-inc.com;
          Mon, 28 Nov 2022 10:50:12 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] erofs: support large folios for fscache mode
Date:   Mon, 28 Nov 2022 10:50:09 +0800
Message-Id: <20221128025011.36352-1-jefflexu@linux.alibaba.com>
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

v2:
- patch 2: keep the enabling for iomap and fscache mode in separate
  patches; don't enable the feature for the meta data routine for now
  (Gao Xiang)

v1: https://lore.kernel.org/all/20221126005756.7662-1-jefflexu@linux.alibaba.com/


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

 fs/erofs/fscache.c | 116 +++++++++++++++++++--------------------------
 fs/erofs/inode.c   |   3 +-
 2 files changed, 49 insertions(+), 70 deletions(-)

-- 
2.19.1.6.gb485710b

