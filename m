Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7366D0125
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjC3K14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjC3K1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:27:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BC58691
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m2so18529911wrh.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1680172068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWMXJxxwrgkEjVmzs+eNT0Qowo5s/hOKaWMHuz+eeBs=;
        b=LGY8X9jeAZsnZqrd6iiPqgz3EBWUVGVtU/6yYhHJd3x+CarpXn+LOauB+5k1htFFGK
         S1m2MWwBgC6ku18i/0XzrPOHnGP06LqKayvzg9fbleyIgLTYMtHAhb3nfeH5sSUMxM2n
         aZqkg3b0powZjI62T1xZh0Xe9ONtMC5xir6g9eECyzZhkhpgXwg5lC8TW6JeBeT2oCHo
         994bF17n7JmrF48m6lLNg0XdHroyKcQHzKCkWNM0LiZD6L0/F+Ca+PSBUP6HStFtLTVG
         Uu65P1mMFxD0Wou5Fo0UJozsDqn3I2ZliMIBj58j5uADygw64Vv5IzPpLhNt49CMzCKL
         CRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWMXJxxwrgkEjVmzs+eNT0Qowo5s/hOKaWMHuz+eeBs=;
        b=yE+G50WyHt6tIyB/EM2HKlqPXZdfChBcCHEfFmURkIy/nN2QiSPkxizhveU1E3B9qU
         upHP7ZGw20sbD/zf8/TNLbrHannMO3vu8J2gepY0TMwH6LFs9+GW+n0smZf+5N88t9Me
         Xe1NYsgxTQ/EqOw5vazf/kkVSlVV9hvI/I7jPoPo40tMF9dNb0bng1JUwryIs13Vejsf
         aaKug1rmM/7P+MAFRlcPf6cxzEyYnXMDX8C+iMQU3Sd3TLkWHzL3vsugtBKFck0J98PG
         Z1E4z0NE6qGCLjhHFlnKD4j9jjdwYsq7Ax0l4+I2YL58wJHGfqZioKftS1Yt/sABf5cA
         k50A==
X-Gm-Message-State: AAQBX9edjQhfWsVRtnd3Y4jURwiGIWFHJ+ZiQ5TFk+ozRYCGe5DMvIPX
        4v2AIbI+Q1pzM4p9NM6FCwmHrOnAmnKpYl4uBytWlWoq
X-Google-Smtp-Source: AKy350ZkXk/QHbS/x0wXE8lWicCBIp7JnAIt4hFbdSQi3HExlmgprtZgJeKyinEKRT02pvO0Crje/A==
X-Received: by 2002:adf:fec2:0:b0:2d2:39d3:ce78 with SMTP id q2-20020adffec2000000b002d239d3ce78mr14390988wrs.10.1680172067889;
        Thu, 30 Mar 2023 03:27:47 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm26352514wrp.42.2023.03.30.03.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:27:47 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 0/7] Assorted DRBD refactoring
Date:   Thu, 30 Mar 2023 12:27:37 +0200
Message-Id: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another set of "backported" DRBD refactoring patches to bring the
in-tree version closer to out-of-tree.

These are (hopefully) no-ops, pretty much just preparation for future
upstreaming work.

Changes since v2:
- Rebase to for-6.4/block

Andreas Gruenbacher (3):
  drbd: Rip out the ERR_IF_CNT_IS_NEGATIVE macro
  drbd: Add peer device parameter to whole-bitmap I/O handlers
  drbd: INFO_bm_xfer_stats(): Pass a peer device argument

Christoph Böhmwalder (4):
  genetlink: make _genl_cmd_to_str static
  drbd: drbd_uuid_compare: pass a peer_device
  drbd: pass drbd_peer_device to __req_mod
  drbd: Pass a peer device to the resync and online verify functions

 drivers/block/drbd/drbd_actlog.c   |  13 ++--
 drivers/block/drbd/drbd_bitmap.c   |  13 +++-
 drivers/block/drbd/drbd_int.h      | 120 +++++++++++++++--------------
 drivers/block/drbd/drbd_main.c     |  72 ++++++++++-------
 drivers/block/drbd/drbd_nl.c       |  19 +++--
 drivers/block/drbd/drbd_receiver.c | 102 ++++++++++++------------
 drivers/block/drbd/drbd_req.c      |  30 +++++---
 drivers/block/drbd/drbd_req.h      |  11 ++-
 drivers/block/drbd/drbd_state.c    |  29 ++++---
 drivers/block/drbd/drbd_worker.c   | 114 ++++++++++++++-------------
 include/linux/genl_magic_func.h    |   2 +-
 11 files changed, 293 insertions(+), 232 deletions(-)


base-commit: 06965037ce942500c1ce3aa29ca217093a9c5720
-- 
2.39.2

