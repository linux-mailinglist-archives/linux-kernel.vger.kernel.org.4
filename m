Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86585E5B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIVGSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIVGST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:18:19 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AEEB56F2;
        Wed, 21 Sep 2022 23:18:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQRHxX4_1663827491;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQRHxX4_1663827491)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 14:18:12 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V5 7/7] Documentation: document ublk user recovery feature
Date:   Thu, 22 Sep 2022 14:17:34 +0800
Message-Id: <20220922061734.21625-8-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
References: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
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

Add documentation for user recovery feature of ublk subsystem.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 Documentation/block/ublk.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 2122d1a4a541..3f1bfd51898b 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -144,6 +144,31 @@ managing and controlling ublk devices with help of several control commands:
   For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the server's
   responsibility to save IO target specific info in userspace.
 
+- ``UBLK_CMD_RESTART_DEV``
+
+  This command is valid if ``UBLK_F_USER_RECOVERY`` feature is enabled. The old
+  process has exited and ublk device is quiesced. Then, user should start a new
+  process which opens ``/dev/ublkc*`` and gets all ublk queues be ready. Finally
+  user should send this command. When this command returns, ublk device is
+  unquiesced and new I/O requests are passed to the new process.
+
+- user recovery feature description
+
+  Two new features are added for user recovery: ``UBLK_F_USER_RECOVERY`` and
+  ``UBLK_F_USER_RECOVERY_REISSUE``.
+
+  With ``UBLK_F_USER_RECOVERY`` set, after one ubq_daemon(ublksrv io handler) is
+  dying, ublk does not release ``/dev/ublkc*`` or ``/dev/ublkb*`` but requeues all
+  inflight requests which have not been issued to userspace. Requests which have
+  been issued to userspace are aborted.
+
+  With ``UBLK_F_USER_RECOVERY_REISSUE`` set, after one ubq_daemon(ublksrv io
+  handler) is dying, contrary to ``UBLK_F_USER_RECOVERY``, requests which have been
+  issued to userspace are requeued and will be re-issued to the new process after
+  handling ``UBLK_CMD_RESTART_DEV``. ``UBLK_F_USER_RECOVERY_REISSUE`` is designed
+  for backends who tolerate double-write since the driver may issue the same
+  I/O request twice. It might be useful to a read-only FS or a VM backend.
+
 Data plane
 ----------
 
-- 
2.27.0

