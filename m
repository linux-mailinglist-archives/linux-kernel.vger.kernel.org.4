Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2FA6980E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBOQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBOQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:32:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3090D3B0DF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:32:09 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k3so12127413wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kVN86nOOyYYar4Mdb1dt7pims1f6cgmu15fTfzFSsDY=;
        b=vAkMmTWBai0DK5yuVBZWooHSqXvGdCA6ytAm/9kEV5E3Js1I+xJYb4iBYu5V8MS2HL
         0N8rE9RhOXMygf604uy0SC3/eVRIkARlrj6lT8LZWOqsUsHcizRQdc1FoBiU4Xf2JB7j
         s0jvvU77qqb6+3JAbVjgRn0nNg01J5xX+L06umCgkJWtv3yauSX3LI8Orx2/df3jRdKq
         yxi2ntvd8tVB9+Lc/2zikP7ZPFMYhxrHAoTEqT7MnGQaJhSHDx3j+MICvbXQQJfuDteJ
         V/wVabwBSayyi+OCZlsGlfw6m3HFKwHKqUEXcpnrCjUXp1CDw62sSLv6xXtI+YwUIwpd
         zEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVN86nOOyYYar4Mdb1dt7pims1f6cgmu15fTfzFSsDY=;
        b=l+FzSKw5YEy592Jzu0kRwbIPwbj/RxVopAy1mMfQu05KwUfZ8PAfMaJUkS8P23zqys
         3c4ZJaKcpG4GejhGu0tGoffObPXs3b0wUl8TjMLX1lsqb4Q8ofbOh2hYuJKijUktdHK0
         gWTaXP3isKGgIiin9Th2Stt9vHme9Zgju6aSiJJRUMJ/T5Cv/WAUyhfQeWiPhexbPUch
         y34YWuXE8enwN3IPdVpkv8PI+Nyma3UYQtkHWz23qF0WZrNvfqKixGlcmtqp908GWOaW
         KFMHqe8gh6W9HcRnUs5/v1PIL+NiC79vi/zaPAfkteC6MaoDaMn61EnKRZ/AYWErP/bh
         Bk5w==
X-Gm-Message-State: AO0yUKXIoZ5/8nI2Mnd8XQzsfhIy1E2YJzw2vk+vEzVJKsd5bW0SxARJ
        /I/EjFBDbnQ+CVV3SwZ6m8hIuA==
X-Google-Smtp-Source: AK7set8VMnRhrcgZzx+HKlf2UsCXmy5ooqQn+wMK6A6bWDl241bW1oacnKZE6ggvSa+57ZayqV3jTQ==
X-Received: by 2002:a5d:5502:0:b0:2c5:5847:390e with SMTP id b2-20020a5d5502000000b002c55847390emr2002643wrv.68.1676478727666;
        Wed, 15 Feb 2023 08:32:07 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d67c4000000b002c56287bd2csm4865055wrw.114.2023.02.15.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:32:07 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/7] Assorted DRBD refactoring
Date:   Wed, 15 Feb 2023 17:31:57 +0100
Message-Id: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another set of "backported" DRBD refactoring patches to bring the
in-tree version closer to out-of-tree.

These are (hopefully) no-ops, pretty much just preparation for future
upstreaming work.

Andreas Gruenbacher (3):
  drbd: Rip out the ERR_IF_CNT_IS_NEGATIVE macro
  drbd: Add peer device parameter to whole-bitmap I/O handlers
  drbd: INFO_bm_xfer_stats(): Pass a peer device argument

Christoph Böhmwalder (4):
  drbd: drbd_uuid_compare: pass a peer_device
  drbd: pass a peer_device to more bitmap functions
  drbd: pass drbd_peer_device to __req_mod
  drbd: Pass a peer device to the resync and online verify functions

 drivers/block/drbd/drbd_actlog.c   |  13 ++--
 drivers/block/drbd/drbd_bitmap.c   |  13 +++-
 drivers/block/drbd/drbd_int.h      | 119 +++++++++++++++--------------
 drivers/block/drbd/drbd_main.c     |  72 ++++++++++-------
 drivers/block/drbd/drbd_nl.c       |  19 +++--
 drivers/block/drbd/drbd_receiver.c | 102 +++++++++++++------------
 drivers/block/drbd/drbd_req.c      |  30 +++++---
 drivers/block/drbd/drbd_req.h      |  11 ++-
 drivers/block/drbd/drbd_state.c    |  29 ++++---
 drivers/block/drbd/drbd_worker.c   | 114 ++++++++++++++-------------
 10 files changed, 291 insertions(+), 231 deletions(-)


base-commit: a06377c5d01eeeaa52ad979b62c3c72efcc3eff0
-- 
2.39.1

