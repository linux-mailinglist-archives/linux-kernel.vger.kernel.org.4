Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E805274CD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGJGq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjGJGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:46:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C5130
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:46:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f96d680399so5651248e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688971575; x=1691563575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3CjRlY+9IwHB/vCT0xsrYeo8Yy/XAul/gGCFGRXgxQ=;
        b=G6wUuVx2c8HcjAYn+aPkqBi6G+wexpIlQx1W25PUMlBsDFh7Wo/NPUK2L2Jx6UDzwP
         c3Ldh/h3imqc6IVMlFmRXS9okiC1l3iFRlW9vR0NLzV9Ubo628kp5ZLSZX49QjGi8jYA
         9hBHJXAU5235xnlQjT/r2G8THovqGE7DYKQdMDd5mVe7eB6i+yhCS0DJSrbi3a5I7rgF
         q5+Bcglg9Rpm19Q89GmjtqLnuUedxR31S5PPdcFFVq26VtqaV6sZQFNSbZFh1l8W7Dn/
         HJEAeyh9UBuZG6Rpmbk5wJLQiz06GDx7ZU1NAgsR7pTkCYW+Se+7pHKP6jv6+WUklTeK
         7D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688971575; x=1691563575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3CjRlY+9IwHB/vCT0xsrYeo8Yy/XAul/gGCFGRXgxQ=;
        b=a7H6H45eQygiulRsvSpM/Cmp/CqJGmzrIPB4U5TpRkjahKm9epVuLMUONaxTTzQ7Pv
         VySaU9e1nMQIhTORDKXYgYndbKt451hJZJ6Zamu5nT9lgJTPjcKaQEpY1ZaFxFIqlr4Y
         NFM6HATJrYpci6Ub/HetRnBTjuFqwWNxIIrlx1LLp48YIRoavKLeebnbnf/qPL7opO7N
         4NMuXkdC/UgJTIUyfr/yBvaau4jxw6Duo8UeepgGVKIzbDfNcyiUi89R1o55BqZRpiQS
         OLLDF3kgeLas+EUrbwQ0aigGxhPVMEXJCuvDOPptfGm9T2A2uQJRWAzuCSoiudMr4hHH
         8nCw==
X-Gm-Message-State: ABy/qLZCU0AOF/GR9bK5MZAxKHe55Xw6MV70yDozo/DoillCMUcS3R+/
        mIQkJyN78bfnxW4vQsWPoBE6eQ==
X-Google-Smtp-Source: APBJJlFV/vHNan6v5Tu1SBjCyP3P2neQtUFBv1ZEDhD85R76IffzCYoJ4jivQ0PVpLPy7oSYYpFN1g==
X-Received: by 2002:ac2:5b9c:0:b0:4f8:565e:f4ae with SMTP id o28-20020ac25b9c000000b004f8565ef4aemr9599418lfn.39.1688971574888;
        Sun, 09 Jul 2023 23:46:14 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id o3-20020ac24343000000b004fb99acbbe7sm1586725lfl.231.2023.07.09.23.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 23:46:14 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        Johannes Thumshirn <jth@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>, gost.dev@samsung.com,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>
Subject: [PATCH v7 0/3] ublk: enable zoned storage support
Date:   Mon, 10 Jul 2023 08:46:03 +0200
Message-ID: <20230710064607.155155-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All,

This patch set adds zoned storage support to `ublk`. The first two patches do
some house cleaning in preparation for the last patch. The last patch adds
support for report_zones and the following operations:

 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET
 - REQ_OP_ZONE_APPEND

A user space component based on ubdsrv is available for testing [1] with the
"loop" target.

Read/write and zone operations are tested with zenfs [2].

The zone append path is tested with fio -> zonefs -> ublk -> null_blk.

The implementation of zone append requires ublk user copy feature, and therefore
the series is based on branch for-next (6afa337a3789) of [3].

Changes for v7
 - Style fixes
 - Rework error handling for `ublk_ctrl_start_dev()`
 - Remove `BLK_DEV_UBLK_ZONED`
 - Add check for IO command support on command enqueue
 - Remove check from `ublk_report_zones()`
 - Hoist check out of `ublk_revalidate_disk_zones()`
 - Remove check from `ublk_dev_param_zoned_apply()` when !CONFIG_BLK_DEV_ZONED
 - Rename `get_nr_zones()` -> `ublk_get_nr_zones()`
 - Open code `set_nr_zones()` in `ublk_param_zoned_apply()`
 - Reorder fields of `struct ublk_rq_data` to pack better
 - Remove redundant checks for chunk_sectors
 - Hoist check for user not setting zoned parameters for zoned ublk device out
   of `ublk_param_zoned_validate()`
 - Remove helper `ublk_dev_params_zoned()`

[1] https://github.com/metaspace/ubdsrv/tree/1ac32cf841b07259cf8b075a5c0006803eeb3981
[2] https://github.com/westerndigitalcorporation/zenfs
[3] https://git.kernel.dk/linux.git

Andreas Hindborg (3):
  ublk: add opcode offsets for DRV_IN/DRV_OUT
  ublk: add helper to check if device supports user copy
  ublk: enable zoned storage support

 drivers/block/ublk_drv.c      | 321 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  49 +++++-
 2 files changed, 349 insertions(+), 21 deletions(-)


base-commit: 3261ea42710e9665c9151006049411bd23b5411f
-- 
2.41.0

