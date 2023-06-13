Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8725172DCD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbjFMIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbjFMIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:40:14 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C671C0;
        Tue, 13 Jun 2023 01:40:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vl1SShK_1686645608;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl1SShK_1686645608)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 16:40:09 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
Subject: [PATCH v3 0/2] block: fine-granular CAP_SYS_ADMIN for Persistent Reservation ioctl
Date:   Tue, 13 Jun 2023 16:40:06 +0800
Message-Id: <20230613084008.93795-1-jefflexu@linux.alibaba.com>
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

changes since v2:
- patch 1: disallow reservations on partitions entirely and make it into
  a separate patch (hch)
- patch 2: rebase to hch's series of converting fmode_t to blk_mode_t
  and execute permission check upon blk_mode_t (hch)

changes since RFC:
- only allow unprivileged reservations if the file descriptor is open
  for write (Christoph Hellwig)
- refuse the unprivileged reservations on partitions (Christoph Hellwig)
  (maybe this checking shall also be done when CAP_SYS_ADMIN is set?)


RFC: https://lore.kernel.org/all/20230609102122.118800-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230612074103.4866-1-jefflexu@linux.alibaba.com/

Jingbo Xu (2):
  block: disallow Persistent Reservation on partitions
  block: fine-granular CAP_SYS_ADMIN for Persistent Reservation

 block/ioctl.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

-- 
2.19.1.6.gb485710b

