Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D170602381
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJREzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJREzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:55:01 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D01C91D;
        Mon, 17 Oct 2022 21:54:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VSTAzRM_1666068875;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VSTAzRM_1666068875)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 12:54:47 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH 1/1] Documentation: document ublk user recovery feature
Date:   Tue, 18 Oct 2022 12:53:46 +0800
Message-Id: <20221018045346.99706-2-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221018045346.99706-1-ZiyangZhang@linux.alibaba.com>
References: <20221018045346.99706-1-ZiyangZhang@linux.alibaba.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 2122d1a4a541..ba45c46cc0da 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -144,6 +144,42 @@ managing and controlling ublk devices with help of several control commands:
   For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the server's
   responsibility to save IO target specific info in userspace.
 
+- ``UBLK_CMD_START_USER_RECOVERY``
+
+  This command is valid if ``UBLK_F_USER_RECOVERY`` feature is enabled. This
+  command is accepted after the old process has exited, ublk device is quiesced
+  and ``/dev/ublkc*`` is released. User should send this command before he starts
+  a new process which re-opens ``/dev/ublkc*``. When this command returns, the
+  ublk device is ready for the new process.
+
+- ``UBLK_CMD_END_USER_RECOVERY``
+
+  This command is valid if ``UBLK_F_USER_RECOVERY`` feature is enabled. This
+  command is accepted after ublk device is quiesced and a new process has
+  opened ``/dev/ublkc*`` and get all ublk queues be ready. When this command
+  returns, ublk device is unquiesced and new I/O requests are passed to the
+  new process.
+
+- user recovery feature description
+
+  Two new features are added for user recovery: ``UBLK_F_USER_RECOVERY`` and
+  ``UBLK_F_USER_RECOVERY_REISSUE``.
+
+  With ``UBLK_F_USER_RECOVERY`` set, after one ubq_daemon(ublk server's io
+  handler) is dying, ublk does not delete ``/dev/ublkb*`` during the whole
+  recovery stage and ublk device ID is kept. It is ublk server's
+  responsibility to recover the device context by its own knowledge.
+  Requests which have not been issued to userspace are requeued. Requests
+  which have been issued to userspace are aborted.
+
+  With ``UBLK_F_USER_RECOVERY_REISSUE`` set, after one ubq_daemon(ublk
+  server's io handler) is dying, contrary to ``UBLK_F_USER_RECOVERY``,
+  requests which have been issued to userspace are requeued and will be
+  re-issued to the new process after handling ``UBLK_CMD_END_USER_RECOVERY``.
+  ``UBLK_F_USER_RECOVERY_REISSUE`` is designed for backends who tolerate
+  double-write since the driver may issue the same I/O request twice. It
+  might be useful to a read-only FS or a VM backend.
+
 Data plane
 ----------
 
-- 
2.27.0

