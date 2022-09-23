Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842925E73D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIWGRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIWGRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:17:48 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01C412387A;
        Thu, 22 Sep 2022 23:17:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQVS1Vn_1663913859;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQVS1Vn_1663913859)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 14:17:45 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RESEND PATCH V5 7/7] Documentation: document ublk user recovery feature
Date:   Fri, 23 Sep 2022 14:15:05 +0800
Message-Id: <20220923061505.52007-8-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
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
 Documentation/block/ublk.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 2122d1a4a541..c3dde087e601 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -144,6 +144,38 @@ managing and controlling ublk devices with help of several control commands:
   For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the server's
   responsibility to save IO target specific info in userspace.
 
+- ``UBLK_CMD_START_USER_RECOVERY``
+
+  This command is valid if ``UBLK_F_USER_RECOVERY`` feature is enabled. This
+  command is accepted after the old process has exited, ublk device is quiesced
+  and ``/dev/ublkc*`` is closed. User should send this command before he starts
+  a new process which opens ``/dev/ublkc*``. When this command returns, the
+  ublk device is ready for the new process.
+
+- ``UBLK_CMD_END_USER_RECOVERY``
+
+  This command is valid if ``UBLK_F_USER_RECOVERY`` feature is enabled. This
+  command is accepted after a new process has opened ``/dev/ublkc*`` and get
+  all ublk queues be ready. When this command returns, ublk device is
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
+  handling ``UBLK_CMD_END_USER_RECOVERY``. ``UBLK_F_USER_RECOVERY_REISSUE`` is
+  designed for backends who tolerate double-write since the driver may issue the
+  same I/O request twice. It might be useful to a read-only FS or a VM backend.
+
 Data plane
 ----------
 
-- 
2.27.0

