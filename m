Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E806E86D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjDTAtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjDTAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:48:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35659C0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:48:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a66911f5faso5481715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681951734; x=1684543734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF9Var5VZaH4S5EIpXHW6R6bAqiZWgFJai0UoeyTkwE=;
        b=RsEx3aqjyFopn7F7zL/TWwQWE2vj2KKqrKmn1n6a2Q5eW8WrikILTPDMirUfhOp/G6
         HopHTQc6FNfefty0a5xobk0bJe8LTeTR1De2vKMOzjzsexf3fScn7kYzzMrvrzbpUNmU
         QomqppKaOHT6sXBr/Rs1KE9zgLzSGdm8UhDeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951734; x=1684543734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF9Var5VZaH4S5EIpXHW6R6bAqiZWgFJai0UoeyTkwE=;
        b=eFUOuyyPSeVNdWDmOZ1Iw8Z2/Ou0ofTj3HJu5JReayGFtVcCDJpbH6YpPeQIaBA8+W
         WRarCp9jDMpXnNKJjeDqmz30rwu4tUpRbMBuRYtCMh25H+C14bs36PWsprMCiTjIY2b8
         xJwDy2xKh5JNqwX7iQoufJbObML2tpjQ9CCXUWMqdHYTPTLe9xMFhbi/RftDLDaf8Flf
         6kz4qRu8g3zS1IHmBoCKr7W51qVTgyNnnx9kpKctDgTjy7Q+/YFhd4CgUJe3EES8p693
         P3DIQYT3iWAU/CArlfcDIBo+xqUNxmnwJXOMe00uARlztduZoa87Dm0uDLfP/DKTJwSo
         uedA==
X-Gm-Message-State: AAQBX9d1MulYiEbEe3rbFkCNjXqfvHO1/XovbZC4aC5q6aBbwSR/5hEB
        wAm1WUU8cfpNsxdXwtnrBwXpbg==
X-Google-Smtp-Source: AKy350bnjW+rV3sEg0tC2tTj1Uiqplfmhzcjp9WRxYk7355tnhy27//NgU2Ws9tKNLyyUuU4hwqcAA==
X-Received: by 2002:a17:902:b18b:b0:1a6:a327:67e1 with SMTP id s11-20020a170902b18b00b001a6a32767e1mr6367289plr.57.1681951734635;
        Wed, 19 Apr 2023 17:48:54 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([2620:15c:9d:200:5113:a333:10ce:e2d])
        by smtp.gmail.com with ESMTPSA id io18-20020a17090312d200b001a65575c13asm74323plb.48.2023.04.19.17.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 17:48:54 -0700 (PDT)
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
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v5 0/5] Introduce block provisioning primitives
Date:   Wed, 19 Apr 2023 17:48:45 -0700
Message-ID: <20230420004850.297045-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414000219.92640-1-sarthakkukreti@chromium.org>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next revision of adding support for block provisioning requests.

Changes from v4:
- Add fix for block devices invalidating pagecache if blkdev_fallocate()
  is called with an invalid mode.
- s/max_provision_sectors/provision_max_bytes in sysfs.

Sarthak Kukreti (5):
  block: Don't invalidate pagecache for invalid falloc modes
  block: Introduce provisioning primitives
  dm: Add block provisioning support
  dm-thin: Add REQ_OP_PROVISION support
  loop: Add support for provision requests

 block/blk-core.c              |  5 +++
 block/blk-lib.c               | 53 +++++++++++++++++++++++++
 block/blk-merge.c             | 18 +++++++++
 block/blk-settings.c          | 19 +++++++++
 block/blk-sysfs.c             |  9 +++++
 block/bounce.c                |  1 +
 block/fops.c                  | 28 +++++++++-----
 drivers/block/loop.c          | 42 ++++++++++++++++++++
 drivers/md/dm-crypt.c         |  5 ++-
 drivers/md/dm-linear.c        |  2 +
 drivers/md/dm-snap.c          |  8 ++++
 drivers/md/dm-table.c         | 23 +++++++++++
 drivers/md/dm-thin.c          | 73 ++++++++++++++++++++++++++++++++---
 drivers/md/dm.c               |  6 +++
 include/linux/bio.h           |  6 ++-
 include/linux/blk_types.h     |  5 ++-
 include/linux/blkdev.h        | 16 ++++++++
 include/linux/device-mapper.h | 17 ++++++++
 18 files changed, 318 insertions(+), 18 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

