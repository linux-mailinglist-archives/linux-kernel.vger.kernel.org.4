Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874006392F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiKZA6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiKZA6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:58:01 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B386D5A6EB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:57:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVgyB1f_1669424276;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVgyB1f_1669424276)
          by smtp.aliyun-inc.com;
          Sat, 26 Nov 2022 08:57:57 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] erofs: support large folio in fscache mode
Date:   Sat, 26 Nov 2022 08:57:54 +0800
Message-Id: <20221126005756.7662-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Patch 1 is the main part of supporting large folio in fscache mode. It
relies on a pending patch[1] adding .prepare_ondemand_read() interface
in Cachefiles.

Patch 2 just turns the switch on and enables the feature. It enables large
folio for both fscache and the original device mode (in uncompressed
data format). And thus I think the previous patch[2] exclusively for the
device mode is not needed then.

[1] https://lore.kernel.org/all/20221124034212.81892-1-jefflexu@linux.alibaba.com/
[2] https://lore.kernel.org/all/20221110074023.8059-1-jefflexu@linux.alibaba.com/


Jingbo Xu (2):
  erofs: support large folio in fscache mode
  erofs: enable large folio support for non-compressed format

 fs/erofs/fscache.c | 117 +++++++++++++++++++--------------------------
 fs/erofs/inode.c   |   1 +
 2 files changed, 50 insertions(+), 68 deletions(-)

-- 
2.19.1.6.gb485710b

