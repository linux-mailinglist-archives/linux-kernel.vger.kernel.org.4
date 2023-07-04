Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8496747734
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGDQwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:52:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC44DD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:52:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d9128494cso5593550a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688489532; x=1691081532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCEuud2npCtaP+WAwUQoRnlKY8hdkU19aLP9Y84PvRg=;
        b=VI57yG1MiCludDVUSlMzYw8RlbygdCdy7DU1GtAtpp4ZqiXttzsdWHfm0fk/OIyF1K
         6GRq0T/Hw23jT/wf2JejLA58GHEmUyowJjP92JgIxOM7fdJq+iCsUZprvS3HV0u9PBWH
         oemiTCPAm6+QgcYQUIHxHTkCpSkDEwM24DTIzucfIAhLQ6pRorQZZd873SMoFgtR9YZL
         tGx0ZMzuhLwXRX1/m0e/zNLGAyZDVpJ+jcQGbjh27qT+fhjYnD4cpXXJbmIWtNxZRlhu
         wVI7vuHqkQE+eTtqi8bromcpMh+TzHh/pDx8HEUe1I862SRmUfSqX2bYDhEa4w+OQKnG
         +tdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489532; x=1691081532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCEuud2npCtaP+WAwUQoRnlKY8hdkU19aLP9Y84PvRg=;
        b=Ciqw0ZyXZzzfSgbVTx/X0FigyNBcufEEdQGr7eXNDcvrSLFKmb2F91ty/RlsGiSv26
         tWTEBuUzxMA48tNC1GJwJAMLsNTxvo6HxMiAQgyfiCYAeVarTkqc0mIHpvlXVfYhdM0Z
         8ZNUtEgivVELqg4vOPlP2SpelPrChKcgkx8xalQ6qxjWuLSdEKir0VQzhysaN/MpMeDD
         bo0Pa9Hua5Q+jzUILtQIkhXObZFdhcnLrqGIBQTfdjFO3CNfF+71PkdfGwVZeh2kUAIc
         m0Y2FSbzY28ROzywgVg5rVpyRB8nARntoPqAP2fGT+GdynLVOYtILC4VJ3f6uk7Zx0kL
         QxCA==
X-Gm-Message-State: ABy/qLZluC69pqBqOSZW2My0IQHISHR9f3x0FdTuj23BqKZOCVFMiNOb
        6dyjXI2nhVY0VGLwRmTz13MpHp0+0LYkiiloLz8=
X-Google-Smtp-Source: APBJJlFmC1hy+2lDGDv/PJFcapa3pXqHpnvzlzeQUFrvLzx32a7XVI0J6/Qfxr3huJyRQP03KgwJMA==
X-Received: by 2002:aa7:df93:0:b0:51d:a124:62cb with SMTP id b19-20020aa7df93000000b0051da12462cbmr10146841edy.28.1688489531957;
        Tue, 04 Jul 2023 09:52:11 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id d17-20020a056402001100b0051a53d7b160sm11969824edu.80.2023.07.04.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:52:11 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v5 0/5] ublk: enable zoned storage support
Date:   Tue,  4 Jul 2023 18:52:04 +0200
Message-ID: <20230704165209.514591-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All,

This patch set adds zoned storage support to `ublk`. The first 3 patches do some
house cleaning in preparation for the last patch. The last patch adds support
for report_zones and the following operations:

 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET
 - REQ_OP_ZONE_APPEND

Changes for v5:
 - Merge zone append patch and zone ops patch
 - Use defines instead of enum for opcodes
 - Add a helper `ublk_dev_is_zoned()`
 - Add a helper `ublk_dev_is_user_copy()`
 - Fix a leak in `ublk_report_zones()`
 - Use goto to handle cleanup in `ublk_report_zones()`
 - Change name of module from `ublk` back to `ublk_drv` and rename source files
 - Fail to add device if user copy is not supported (implicitly fail to start device under same condition)
 - Fail to add device if kernel is not compiled with CONFIG_BLK_DEV_ZONED
 - Fail to apply device parameters if chunk_sectors is not set while zoned support is requested
 - Change kconfig entry
 - Check max open/active zones are valid
 - Document UBLK_IO_OP_REPORT_ZONES buffer format
 - Use function stubs rather than if(IS_ENABLED(...))
 - Improve validation of zoned parameters

A user space component based on ubdsrv is available for testing [1] with the
"loop" target. No changes are required for user space for v4 -> v5.

Read/write and zone operations are tested with zenfs [3].

The zone append path is tested with fio -> zonefs -> ublk -> null_blk.

The implementation of zone append requires ublk user copy feature, and therefore
the series is based on branch for-next (6afa337a3789) of [4].

[1] https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952dd88bf5e668b
[2] https://lore.kernel.org/linux-block/20230316145539.300523-1-nmi@metaspace.dk/
[3] https://github.com/westerndigitalcorporation/zenfs
[4] https://git.kernel.dk/linux.git

Andreas Hindborg (5):
  ublk: add opcode offsets for DRV_IN/DRV_OUT
  ublk: move types to shared header file
  ublk: rename driver files to prepare for multiple translation units
  ublk: add helper to check if device supports user copy
  ublk: enable zoned storage support

 MAINTAINERS                          |   4 +-
 drivers/block/Kconfig                |   5 +
 drivers/block/Makefile               |   2 +
 drivers/block/ublk-zoned.c           | 225 +++++++++++++++++++++++++++
 drivers/block/{ublk_drv.c => ublk.c} | 186 ++++++++++------------
 drivers/block/ublk.h                 | 180 +++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h        |  44 +++++-
 7 files changed, 533 insertions(+), 113 deletions(-)
 create mode 100644 drivers/block/ublk-zoned.c
 rename drivers/block/{ublk_drv.c => ublk.c} (95%)
 create mode 100644 drivers/block/ublk.h


base-commit: 3261ea42710e9665c9151006049411bd23b5411f
-- 
2.41.0

