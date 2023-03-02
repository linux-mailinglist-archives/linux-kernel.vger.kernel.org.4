Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72476A82D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCBMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCBMz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:55:27 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826A27EEF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:55:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cw28so18022486edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 04:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1677761724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZgw50LCuKrnZIMnz0+4XFexCiqGPxROK8CODTa/Oy4=;
        b=GzfOcygfycPPjUjyHE9sLQv2L8G0lcgA08J/nQN++LQMU+gVOjO1CFZLsDsq0NOULA
         80rKUCwRNjD170l3SOsyh9HMJoWZCLEuSoku9ow5rayFbMrj8Cxz/xHEzJvZsnHixAWB
         dDiCdE83ON4HuC4tudrbuEoP4MS+Hl3st4a2xeaA+pugznYBYCLqgcmrHskhsxrRncS4
         f4Sw6ge7pgF6r2+Hi2TDzQlyRyh3ChiAx+dm+SAwtw/H6W/rd3e4gigXKchsAkNtZKvr
         NcP5XJuoq9q7/TEh9RLepKsGQzSV3wVqyOQ1nBRVOR1+3Ih8HiF4VaziVpAMkTGxFecr
         q/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677761724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZgw50LCuKrnZIMnz0+4XFexCiqGPxROK8CODTa/Oy4=;
        b=RF308jEwJwlPk7HupYFQ+ejzvY4oxi++hGJrYUALDe9TYD0t3n+QM81Azqkv2NzoNW
         zF3WSWeUMvAczV9MTnZRKY2oNOFrliKvUQ3oNQ7fQHUUQSMXgYpEhErZB8Sisf6h0EhQ
         yd1gtHSwLPv60AzfNdr2ex2NFqiU33Y5cE1uNspGs1HyUGRjwYENehY8L5P+4s0uL+Hm
         TePPBdgKaM/SZzwbT8VCnVhLwZcz3W64hZeH+XI0iKGU6l53dlHyEiX5MoCKx8IaZZFa
         KCUslle10/BfsgXurB0CA1d8YHNKy4CFu0LrArltwMUrN+a0NyElan96HuRGc/vyagHv
         4yLg==
X-Gm-Message-State: AO0yUKWwYopgbBsEkoxDGBue/2oVj5naFrb+nkUgJic/gLDP1zTfUuKZ
        NVWm4eiEamibu7JWLE+KE9x3Ag==
X-Google-Smtp-Source: AK7set8rm/kGgFWfUtgEBHPO0TIzJXFir8UyXV2ZEqsMcKwhBuRbPe0/rYsenCDFz6rWlfFPa7Eyag==
X-Received: by 2002:a05:6402:1016:b0:4ac:d973:bb2c with SMTP id c22-20020a056402101600b004acd973bb2cmr11266829edu.28.1677761723988;
        Thu, 02 Mar 2023 04:55:23 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id a98-20020a509eeb000000b004ad601533a3sm6955034edf.55.2023.03.02.04.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:55:23 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 0/7] Assorted DRBD refactoring
Date:   Thu,  2 Mar 2023 13:54:38 +0100
Message-Id: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
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

Another set of "backported" DRBD refactoring patches to bring the
in-tree version closer to out-of-tree.

These are (hopefully) no-ops, pretty much just preparation for future
upstreaming work.

Changes since v1:
- Address some compiler warnings
- Reorder/merge patches to avoid breaking compilation between commits

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


base-commit: 326ac2c5133e5da7ccdd08d4f9c562f2323021aa
-- 
2.39.1

