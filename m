Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE3566E70B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjAQTeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjAQT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:26:29 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D74A1D2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:34:18 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 1422126F66F;
        Tue, 17 Jan 2023 19:25:02 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Subject: [PATCH v2 0/2] nvme-apple: Fix suspend-resume regression
Date:   Tue, 17 Jan 2023 19:25:00 +0100
Message-Id: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPznxmMC/2WLwQ6CQAwFf4X0bA0sxIO/Yjwsy0OaaN20cUNC+
 HdXrh5nMrORwwRO12YjQxGXt1YIp4bSEvUBlqkyhTb0bdcNHHN+grW8wP7xDJ14lhXO5XIObGmg
 uo7RwaNFTctvPur/KhsOWZPbfd+/9b8JvYwAAAA=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=j@jannau.net;
 h=from:subject:message-id; bh=ew343/vV0kObrwRGYdFiYCkdG6wuIuazFB7ONX5IV3A=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuRjz//u/zFXvKxAXEqpljGG5+/NNq2bMY+aPIK3L2wqeRij
 fv1/RykLgxgHg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIn0uTD8M1+ZeDcmRXXiwtoDq84XHm
 GsWpcW1qF7bsdzZ/bM7QtmnmBkuP3Ds+Uxw7Rcdt7XT/8Jb4t596dKeoXiLe2M65MdHj5wYAEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c76b8308e4c9 removed a NVMe controller reset in the shutdown path. This
broke suspend since it triggered a reset on resume. This reset hangs
since the co-processor is not up.
In addition the reset is needed on suspend to shutdown the co-processor
cleanly.

This series contains a functional revert of c76b8308e4c9 (a simple revert
is not possible due to other changes) and issues the NVMe reset only when
the co-processor is running.

Changes since Hector's v1:
- keep the fix localy in nvme-apple
- disable on shutdown for clean co-processor shutdown
- disable on reset only while the co-processor is running

---
Janne Grunau (2):
      nvme-apple: Reset controller during shutdown
      nvme-apple: Only reset the controller when RTKit is running

 drivers/nvme/host/apple.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)
---
base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
change-id: 20230114-apple-nvme-suspend-fixes-v6.2-rc4

Best regards,
-- 
Janne Grunau <j@jannau.net>
