Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6127418AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjF1THO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjF1TG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:06:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2201FE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991ef0b464cso241521966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687979212; x=1690571212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHp3wJL5M2L2G+YbB2Q2IPPSaeVG/zhpefUOIq4q2Os=;
        b=jDgSFPLYEQZXyfEfZwepmlvYqaf7ynGTJ/aFKkuF+COAMkmY5RIkoCJE95ml123D3X
         UqZWhOf4hphOdA7/m4fHFsFpUS/J/mSoH8ZBxH2RGgl53vhshBiaN7SuwAJRhfooVX/x
         WWNrTdXp1DqTl6AAr/hWDTEdkXv0ytzmp7ANidt/mJIlX4pEENnkZvzAmnA/QqEvu4gP
         uQoECeyhbrWd471Vo0z5ntYEPpMAkwabOLZz59o1I2Lu6FhlbxyEdnZDSCsOO7G1Z1O3
         FJ78dss+Xv1TrnD1mS8ISDOVB0TVcdv79MsmZPK0uFbMqe5mr3Xycd13426VHGsDgq2D
         Uq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687979212; x=1690571212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHp3wJL5M2L2G+YbB2Q2IPPSaeVG/zhpefUOIq4q2Os=;
        b=i1kZcWUQ+6qRS9Xfog5S6uu4uiOum0uvEPD9qj3a2L1ybDUxSt0ydQYHGrhZmAzlzl
         +jbhff55+yvNX6YQPXdulvtHACItOxvYgwih0vsiPJaGdTt8mT5yfxIlFau/ugZicNJV
         zV1NsO8w7LaJTPFpWWgYjkKqBiyfsQFrEss0Qku4z+X+i5UZCt+RXzmVpCNRCiYytPP8
         dUwC6SAUyphO9FxE0ehh44Pk4LcvV4hx4LQUe7ojIQnklz7WsC2HxgSkgAJkGyY+abia
         9YfM5EMOIDGgkBF5w5DVMk4yVoHfhlLNz3BJqrf1/16+QImXrN4BYnIuKJvuMCRaIX0o
         RjYw==
X-Gm-Message-State: AC+VfDyGMM9AO3SF/bQPVu3RcX9Skf3fWM0hc03BMNB/uBhOMJMhXhsn
        +Qwho8d2Mgjk8vGds9TurlzNpw==
X-Google-Smtp-Source: ACHHUZ7DXPXOc7rcX2RdtEk+UOMmjqKmTj+kwlNVuFuW4fXpjyLiii3gpj23e1r4UYEmXLFngtcUmA==
X-Received: by 2002:a17:907:60d5:b0:98d:f2c9:a1eb with SMTP id hv21-20020a17090760d500b0098df2c9a1ebmr2479087ejc.24.1687979212156;
        Wed, 28 Jun 2023 12:06:52 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7da10000000b0051d2968b26asm5072022eds.77.2023.06.28.12.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:06:51 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org (open list),
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v4 0/4] ublk: add zoned storage support
Date:   Wed, 28 Jun 2023 21:06:45 +0200
Message-ID: <20230628190649.11233-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All,

This patch set adds zoned storage support to `ublk`. The first two patches does
some house cleaning in preparation for the last two patches. The third patch
adds support for report_zones and the following operations:

 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RES

The last patch adds support for REQ_OP_ZONE_APPEND.

v3 [2] -> v4 changes:
 - Split up v3 patches
 - Add zone append support
 - Change order of variables in `ublk_report_zones`

Read/write and zone operations are tested with zenfs [3].

The zone append path is tested with fio -> zonefs -> ublk -> null_blk.

The implementation of zone append requires ublk user copy feature, and therefore
the series is based on branch for-next (6afa337a3789) of [4].

[1] https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952dd88bf5e668b
[2] https://lore.kernel.org/linux-block/20230316145539.300523-1-nmi@metaspace.dk/
[3] https://github.com/westerndigitalcorporation/zenfs
[4] https://git.kernel.dk/linux.git

Andreas Hindborg (4):
  ublk: change ublk IO command defines to enum
  ublk: move types to shared header file
  ublk: enable zoned storage support
  ublk: add zone append

 MAINTAINERS                    |   2 +
 drivers/block/Kconfig          |   4 +
 drivers/block/Makefile         |   4 +-
 drivers/block/ublk_drv-zoned.c | 155 +++++++++++++++++++++++++++++++++
 drivers/block/ublk_drv.c       | 150 +++++++++++++++++++------------
 drivers/block/ublk_drv.h       |  71 +++++++++++++++
 include/uapi/linux/ublk_cmd.h  |  38 ++++++--
 7 files changed, 363 insertions(+), 61 deletions(-)
 create mode 100644 drivers/block/ublk_drv-zoned.c
 create mode 100644 drivers/block/ublk_drv.h


base-commit: 3261ea42710e9665c9151006049411bd23b5411f
-- 
2.41.0

