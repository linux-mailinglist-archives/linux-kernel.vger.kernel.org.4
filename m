Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7923F64842E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLIOxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLIOxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:53:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82940511E9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:53:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r26so3378553edc.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtCs8GxpjiNUlKe9jLRTDXiumifJAjD1jl0L4CeLiMA=;
        b=MHoLj/reYCEaCu2BZl791sUFMu9EsJFTpuGoSGhqpzPg1G2i0+rLOnXbsB74P9BAN9
         nIpY0Gnji9Fvtm+3k4SGTzoM0pjpKrp58glH6ITl3OGiRQ4wKlxsE9B9MO3Ta6kSCCT2
         FRjDRDKxtEPLDb/k49mnKJLE4k/GiOCWaPQdx5p1AmTeufBD40E2oASTNMZES01XTvDU
         ob7QGOqAnUyVU485JtXEMbvjpSShmh7tyXcQ/pABd4lut+BrUnbtpdiECjQQjcELOV9s
         ZKCVJhpPA+iSjzC1lop/aOkPvTKR9c3ijh4XvJeNOj9EW0nnSFcsgUUAmmnPFcmuOJa5
         hZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtCs8GxpjiNUlKe9jLRTDXiumifJAjD1jl0L4CeLiMA=;
        b=0Zx+uWV0OzfPkjC9yjmV40Lx7MWTN/Nz5DVTBON+tiiAnSITEAV4H3XPL3yAGCJK9M
         2TMt4otPTDdR2Ig71EuLhzRgXduExbKTnDDnqRu0664Z8X7Npyw5HyaXCd9rNK197SkC
         WrnMNzvBlyiG/KmNULFSxjYfD+tv6WcRoRxV2jkofZJr65fVZRwuhdFsWvf5qSqCQ/YB
         qIq99dV4iDi2Zd65tYmShcAkU/jckpCtnwwjb42mVlDNlcg/THV4b5UL9DSWD68OHZsp
         NtJrr1YlyNCqLvrnFJTQv1Sg+Ulunm25kBAfn5UWfbro6cd0ZUCNhh2FM6w8gcyh3IdL
         mu5A==
X-Gm-Message-State: ANoB5pnK0RW1t9XlvESmbxutOgX4yiZqA9jHitaZDk4XhOWqRwKccDiu
        QQff4//MWWQ366Nh9UIkjAQJYQ==
X-Google-Smtp-Source: AA0mqf48psVfOczEhg6GzyTLj3NBiKg2BMDsqH01qlhK1pulUi4SHigJ39yDwhJazBez6TTHcD8srg==
X-Received: by 2002:aa7:cac2:0:b0:461:608f:f3e0 with SMTP id l2-20020aa7cac2000000b00461608ff3e0mr5102001edt.28.1670597612099;
        Fri, 09 Dec 2022 06:53:32 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:31 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/8] Miscellaneous DRBD reorganization
Date:   Fri,  9 Dec 2022 15:53:19 +0100
Message-Id: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some more mostly trivial "alignment patches" to (slowly but surely)
move further in the direction of re-upstreaming DRBD.

These should be fairly uncontroversial.

Andreas Gruenbacher (1):
  drbd: drbd_insert_interval(): Clarify comment

Christoph Böhmwalder (5):
  drbd: adjust drbd_limits license header
  drbd: make limits unsigned
  drbd: remove unnecessary assignment in vli_encode_bits
  drbd: remove macros using require_context
  MAINTAINERS: add drbd headers

Lars Ellenberg (1):
  drbd: interval tree: make removing an "empty" interval a no-op

Robert Altnoeder (1):
  drbd: fix DRBD_VOLUME_MAX 65535 -> 65534

 MAINTAINERS                        |   1 +
 drivers/block/drbd/drbd_int.h      |  12 +-
 drivers/block/drbd/drbd_interval.c |   6 +-
 drivers/block/drbd/drbd_vli.h      |   2 +-
 include/linux/drbd_limits.h        | 204 ++++++++++++++---------------
 5 files changed, 110 insertions(+), 115 deletions(-)


base-commit: f596da3efaf4130ff61cd029558845808df9bf99
-- 
2.38.1

