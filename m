Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B874E7E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGKHYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjGKHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:24:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F41B2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:24:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so7763846e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689060243; x=1691652243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4WcNTK5NsQ5dOJiZQLvmjFzuKbNktz5/qTdexoEOG4o=;
        b=Rro6maM1+bv6acpMyKuoi0ocEz0mITQoQUX3TBB1mG7E9UtjFzd8USruiSRLlifJTS
         DG0j7m2TN2WewEVTlZXNMFwwQXFcrp3p/vrEwfWrDUOUoYglSaNI2HlMYCwzBHp136po
         1T4FnqjYnTC3g6b9j9C5aE0pXPOPVUPD+JDceIIMWl4DACI5ycAhXSc8eGxtH8j94zfm
         ygjBbS4o1RIVV2VRjkyBWSb7Hp4W1Xa+ruqRKpi170+IW14zUwUnSWtcLdz/g69jzZka
         32iTXbcaFGs05dWG0W8Yu0KMsSgElj1o6NC3Cbjy1S7Gpss2AZhB+qyz1Xqv9phtc534
         c0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060243; x=1691652243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WcNTK5NsQ5dOJiZQLvmjFzuKbNktz5/qTdexoEOG4o=;
        b=Z2Or8goETfnH37U1UsO31dXZtGNZKIYwC50BsQmcceQ2woXyG3vYAGivfCFXM+qa91
         aUV9zg29Zo6OOHWmHs/viuWAfEMcfzOM+3/y3LaCmStpHYHJIpc1a5hC/1OfNmvX+qMF
         UzwhRG+JwXVCFTEl5XSq410ocIFBDZSQVusi7x98+5Mf1Ybc438HUGXR86iYYouEPIrF
         YG2iiAFQmylZ4QjQuXiBWGzcxfe4Z2aHtZfNLU1J0I6yAwvD2DqFxNe/QEzW90KbRW+2
         KIH+M2Apk9aDm4XDsYZvc5bjW74bAICreuO0WA0E2obxGqI5Et73HZHB6JDIa0ACtCoz
         SjkA==
X-Gm-Message-State: ABy/qLbN3RD8dEDPIly/dlEBPFtd7R4F7yhHbhQ8dp4FViejmJvFPtTh
        IV1PFFGWglf0NhsXm+BBiyGnRuZ7nV/lt4Mf5b0=
X-Google-Smtp-Source: APBJJlHGmWROz1qgSUYyTVfcuVNS88gaDH97gZp8Ez2VDrlhE+uMGJcR730lHxY71qJ+YgZFHmWTpg==
X-Received: by 2002:a05:6512:281c:b0:4f4:c6ab:f119 with SMTP id cf28-20020a056512281c00b004f4c6abf119mr16503652lfb.64.1689060243008;
        Tue, 11 Jul 2023 00:24:03 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id r23-20020ac24d17000000b004f61ae50a7dsm203876lfi.142.2023.07.11.00.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:24:02 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org (open list),
        Andreas Hindborg <a.hindborg@samsung.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v8 0/2] ublk: enable zoned storage support
Date:   Tue, 11 Jul 2023 09:23:51 +0200
Message-ID: <20230711072353.200873-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All,

This patch set adds zoned storage support to `ublk`. The first patch does some
house cleaning in preparation for the last patch. The last patch adds support
for report_zones and the following operations:

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

Changes for v8
 - Remove __UBLK_IO_OP_DRV_*
 - Move report zones command identifier (UBLK_IO_OP_REPORT_ZONES) next to other
   zone management operations

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

[1] https://github.com/metaspace/ubdsrv/tree/acc072e077bceea390bae14b6ccb8087f6d0cf1a
[2] https://github.com/westerndigitalcorporation/zenfs
[3] https://git.kernel.dk/linux.git

Andreas Hindborg (2):
  ublk: add helper to check if device supports user copy
  ublk: enable zoned storage support

 drivers/block/ublk_drv.c      | 321 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  36 +++-
 2 files changed, 337 insertions(+), 20 deletions(-)


base-commit: 3261ea42710e9665c9151006049411bd23b5411f
-- 
2.41.0

