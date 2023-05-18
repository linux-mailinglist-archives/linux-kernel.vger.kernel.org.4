Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A3E708BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjERWdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjERWds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:33:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A1E69
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:33:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so1776119a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684449226; x=1687041226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPcvilHxRv5tEGKC3PHnSqwH0oZyyl+v+Zg8TUGpbJw=;
        b=eLivEVS3iKurVg9hrVHfytK1IGa2bJfL0gEwTz9neJ/E/Tbjm2ePYOr1r8ikGFkSZk
         YMULVD+goAY9Bam6P9se2p9H7xW/8TTt55lrGMtIFtvsxBL3q0fKXHHnLsj2bNeXzOGm
         9fEFpzBwz5R7mn7DZBMeI0YdaH0QyvfQI1m8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449226; x=1687041226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPcvilHxRv5tEGKC3PHnSqwH0oZyyl+v+Zg8TUGpbJw=;
        b=JVQNZF3aEysvCFx6kaM/ipG67ZLwOBNUkxZpQT8Vz1I6wky5oVf4OVylUCo65usYRA
         GnwR1Fxp+YIBGzWdyX6bCE2MXXazw7JuqKjm7X1GKQpPrAcZFnLe0k6WdwCT98DuwM6V
         dhQFqx3LBe+oCEGx1mFCEbk37RT3+j6DLi9tcOXIFMq8xNe6mclQ4/bHZhACFEx3KI0j
         yt4waKU3IAyUgChd1Sk4SvzjU7tB+D990k3D3xxnP9q1Ad5187/96BRMzl8mza30lkRW
         lkLq+thTkQif0B93V/AoclQ8HxPKb8h5arRCG2Yh1YxES4m9HfiF6EtDawinRr4XPIky
         LtaA==
X-Gm-Message-State: AC+VfDxV2e/LTmhsLifQXlSv1+tS3fSx4BtmfvwnMnacFm8aKjLQbmBr
        Hey61wA6yAU62qfo1KVG8tLSaQ==
X-Google-Smtp-Source: ACHHUZ7srcWgRWNjK1oBR93TOXpdFS6fhRHeem/s6f029tvJAmcsLM8dRi+XaWwzfkjepb180UvfcA==
X-Received: by 2002:a17:902:9b94:b0:1ae:153f:4cb with SMTP id y20-20020a1709029b9400b001ae153f04cbmr560712plp.49.1684449226192;
        Thu, 18 May 2023 15:33:46 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([100.107.238.113])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902b10400b001aafb802efbsm1996502plr.12.2023.05.18.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:33:45 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v7 0/5] Introduce provisioning primitives
Date:   Thu, 18 May 2023 15:33:21 -0700
Message-ID: <20230518223326.18744-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 7 of the patch series to introduce block-level provisioning primitives [1]. The current series is rebased on: (2d1bcbc6cd70 Merge tag 'probes-fixes-v6.4-rc1'...).

Changelog:

v7:
- Fold up lo_req_provision() into lo_req_fallocate().
- Propagate error on failure to provision from the blkdev_issue_provision().
- Set 'max_provision_granularity' in thin_ctr.
- Fix positioning of 'max_provision_sectors' in pool_ctr.
- Add provision bios into process_prepared_mapping() to prevent the bio from being reissued to the underlying thinpool.

[1] https://lore.kernel.org/lkml/20220915164826.1396245-1-sarthakkukreti@google.com/

Sarthak Kukreti (5):
  block: Don't invalidate pagecache for invalid falloc modes
  block: Introduce provisioning primitives
  dm: Add block provisioning support
  dm-thin: Add REQ_OP_PROVISION support
  loop: Add support for provision requests

 block/blk-core.c              |  5 +++
 block/blk-lib.c               | 51 ++++++++++++++++++++++++
 block/blk-merge.c             | 18 +++++++++
 block/blk-settings.c          | 19 +++++++++
 block/blk-sysfs.c             |  9 +++++
 block/bounce.c                |  1 +
 block/fops.c                  | 31 ++++++++++++---
 drivers/block/loop.c          | 34 ++++++++++++++--
 drivers/md/dm-crypt.c         |  4 +-
 drivers/md/dm-linear.c        |  1 +
 drivers/md/dm-snap.c          |  7 ++++
 drivers/md/dm-table.c         | 23 +++++++++++
 drivers/md/dm-thin.c          | 74 +++++++++++++++++++++++++++++++++--
 drivers/md/dm.c               |  6 +++
 include/linux/bio.h           |  6 ++-
 include/linux/blk_types.h     |  5 ++-
 include/linux/blkdev.h        | 16 ++++++++
 include/linux/device-mapper.h | 17 ++++++++
 18 files changed, 310 insertions(+), 17 deletions(-)

-- 
2.40.1.698.g37aff9b760-goog

