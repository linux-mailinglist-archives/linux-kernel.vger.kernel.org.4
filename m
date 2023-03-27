Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A176CAC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC0RoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC0RoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:44:16 -0400
Received: from out-61.mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0AB1998
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:44:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679939052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+8CD43ZGiWjT6MHE5SkeNeX0EuJT+mw8tc66Q7ZwIjA=;
        b=m3il4bn4F2lRCFAqMikjepInaxpldm8c3RgfIJ0SZOeOTlhuu+cS6+SY8RJiQ+/nArOD6g
        uUHrvbGInK7Hb//MjsjXY6R4btQbtcwM35JI9ZkG3R37B/n7LW4ssqowm+x9rTZLX/jpSS
        JwM4zudDXp3INfol17Hp6CqQ4GWNWDk=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, willy@infradead.org,
        axboe@kernel.dk
Subject: [PATCH 0/2] bio iter improvements
Date:   Mon, 27 Mar 2023 13:44:00 -0400
Message-Id: <20230327174402.1655365-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small patch series cleaning up/standardizing bio_for_each_segment_all(),
which means we can use the same guts for bio_for_each_folio_all(),
considerably simplifying that code.

The squashfs maintainer will want to look at and test those changes,
that code was doing some slightly tricky things. The rest was a pretty
mechanical conversion.

Kent Overstreet (2):
  block: Rework bio_for_each_segment_all()
  block: Rework bio_for_each_folio_all()

 block/bio.c               |  38 ++++++------
 block/blk-map.c           |  38 ++++++------
 block/bounce.c            |  12 ++--
 drivers/md/bcache/btree.c |   8 +--
 drivers/md/dm-crypt.c     |  10 ++--
 drivers/md/raid1.c        |   4 +-
 fs/btrfs/disk-io.c        |  10 ++--
 fs/btrfs/extent_io.c      |  52 ++++++++--------
 fs/btrfs/inode.c          |   8 +--
 fs/btrfs/raid56.c         |  18 +++---
 fs/crypto/bio.c           |   8 +--
 fs/erofs/zdata.c          |   4 +-
 fs/ext4/page-io.c         |   8 +--
 fs/ext4/readpage.c        |   4 +-
 fs/f2fs/data.c            |  20 +++----
 fs/gfs2/lops.c            |  10 ++--
 fs/gfs2/meta_io.c         |   8 +--
 fs/iomap/buffered-io.c    |  14 +++--
 fs/mpage.c                |   4 +-
 fs/squashfs/block.c       |  48 ++++++++-------
 fs/squashfs/lz4_wrapper.c |  17 +++---
 fs/squashfs/lzo_wrapper.c |  17 +++---
 fs/verity/verify.c        |   4 +-
 include/linux/bio.h       | 123 +++++++++++++++++++++-----------------
 include/linux/bvec.h      |  70 ++++++++++++++--------
 25 files changed, 302 insertions(+), 255 deletions(-)

-- 
2.39.2

