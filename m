Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6228C63EED4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLALFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLALEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:04:31 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAFC5C0F7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:04:28 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id o13so3355497ejm.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bCSFONotMGlT5jcNSWA3wEw//+37lRPpQvu379eQdb4=;
        b=mky/H4kqev/SBa6soq1k+oMgOaV2tJ6fff0Qn4zByh6t4++4mdmoeRtyyf3dT0AGXh
         8qcdBXx/eU+yX2ubXovz++PON5OelriwP9No7rBn8afMyyq4glmQiIX/S4k8FEotVKNa
         tm5Ta4VNNWwL2Di8riPg+0yKi3AJntfpfgWvpOprnbKahJ/NZpIqhIm20ggN6r0EuxmC
         c0uM8xGx2bd7ZsNkzMYTihZTjhxs6FHLbzuzIFza+54tb64iXc/1ks7O2IfHtQ6zedtz
         bjZcNpxzIuMAiGBZ/+cNhUThlzgMlYueD6SJic/P2fmG9VN7zurkQCVwTEoN4AZ87+gY
         SvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCSFONotMGlT5jcNSWA3wEw//+37lRPpQvu379eQdb4=;
        b=4Rnck5kAmOE3naeO7xySrKlThpRxf1osqc/ynEJqQM7Sxced2eBZTpyL0rDHyO5J2e
         FpVNZSdqMqpJrM5/KmMTKoWabUMuq9P8U+QXh+9PjeB8RMZj9zldVMm3Lz79Q5aCFTVv
         h2WMNnyRCv4Wp1ujxx1/5IT1XqThnXwr8CLFAnstpux49mu0yOL3PfqlQ8EqFvY9aRWI
         XGFdtd2EPJQlRfBAo2aJTvBDiTwxwI1/UZ5ZYdClbOyyzajOzTZnDLlCt+WJSDCHm9VS
         upFRFl0GuuvSpIEk9E5MO5x3nmU2rbS3kaxjftMw0Q2Md4KyF3wHtdBDdy95r/gxjCwt
         RP7g==
X-Gm-Message-State: ANoB5plMFbapSiTN0XBBrQsDg2QklMB2zISxzRYzEW1a3Qrg49Iv2Dve
        6BYh3fnwjERYesk5C/QyZ1pSDA==
X-Google-Smtp-Source: AA0mqf5D3lvSWXlbNVxaPnrYe5tMWRFbul2ScpxDzKf3ljJWGch6rkuPwy1XuKM1ffPLdoJA/bIXmA==
X-Received: by 2002:a17:906:a198:b0:7b4:bc42:3b44 with SMTP id s24-20020a170906a19800b007b4bc423b44mr48503029ejy.101.1669892666946;
        Thu, 01 Dec 2022 03:04:26 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402161a00b00463a83ce063sm1576424edv.96.2022.12.01.03.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:04:26 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/5] Backported DRBD printk/debug improvements
Date:   Thu,  1 Dec 2022 12:03:45 +0100
Message-Id: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
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

Some changes to DRBD's logging infrastructure, backported from the
out-of-tree module.

Since the two code bases have diverged so much, it is tough to preserve
authorship information without "putting words into someone's mouth". So
I ended up using Originally-from tags to try and encode the original
authors of these patches.

Christoph Böhmwalder (5):
  drbd: unify how failed assertions are logged
  drbd: split polymorph printk to its own file
  drbd: introduce dynamic debug
  drbd: introduce drbd_ratelimit()
  drbd: add context parameter to expect() macro

 drivers/block/drbd/drbd_actlog.c           |   6 +-
 drivers/block/drbd/drbd_bitmap.c           |  60 ++++-----
 drivers/block/drbd/drbd_int.h              |  68 +---------
 drivers/block/drbd/drbd_main.c             |  10 +-
 drivers/block/drbd/drbd_nl.c               |   2 +-
 drivers/block/drbd/drbd_polymorph_printk.h | 141 +++++++++++++++++++++
 drivers/block/drbd/drbd_receiver.c         |  16 +--
 drivers/block/drbd/drbd_req.c              |   6 +-
 drivers/block/drbd/drbd_worker.c           |  12 +-
 9 files changed, 199 insertions(+), 122 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_polymorph_printk.h


base-commit: b4c0482bfe89cd6c4f030314c86aae35642c44a5
-- 
2.38.1

