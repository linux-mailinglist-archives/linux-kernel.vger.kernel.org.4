Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9496FEC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbjEKHGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbjEKHF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:05:59 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830DC5FF2;
        Thu, 11 May 2023 00:05:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0ViJZHzM_1683788724;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0ViJZHzM_1683788724)
          by smtp.aliyun-inc.com;
          Thu, 11 May 2023 15:05:25 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Frederick Lawler <fred@cloudflare.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 0/2] capability: Introduce CAP_BLOCK_ADMIN
Date:   Thu, 11 May 2023 15:05:18 +0800
Message-Id: <20230511070520.72939-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separated fine-grained capability CAP_BLOCK_ADMIN from CAP_SYS_ADMIN.
For backward compatibility, the CAP_BLOCK_ADMIN capability is included
within CAP_SYS_ADMIN.

Some database products rely on shared storage to complete the
write-once-read-multiple and write-multiple-read-multiple functions.
When HA occurs, they rely on the PR (Persistent Reservations) protocol
provided by the storage layer to manage block device permissions to
ensure data correctness.

CAP_SYS_ADMIN is required in the PR protocol implementation of existing
block devices in the Linux kernel, which has too many sensitive
permissions, which may lead to risks such as container escape. The
kernel needs to provide more fine-grained permission management like
CAP_NET_ADMIN to avoid online products directly relying on root to run.

CAP_BLOCK_ADMIN can also provide support for other block device
operations that require CAP_SYS_ADMIN capabilities in the future,
ensuring that applications run with least privilege.

Tianjia Zhang (2):
  capability: Introduce CAP_BLOCK_ADMIN
  block: use block_admin_capable() for Persistent Reservations

 block/ioctl.c                       | 10 +++++-----
 include/linux/capability.h          |  5 +++++
 include/uapi/linux/capability.h     |  7 ++++++-
 security/selinux/include/classmap.h |  4 ++--
 4 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.24.3 (Apple Git-128)

