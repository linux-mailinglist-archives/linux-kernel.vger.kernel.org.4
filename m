Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06C70D5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjEWHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjEWHqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78870C5;
        Tue, 23 May 2023 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b4caBsqRj9WgFDF1CdiyuIzyBrf32buPv15Igm1OGNU=; b=WhENlxHUIDOj4WfSHpZmeGSqbG
        vUiinRR9sgFVzAa6AJUpClm6jiechzZRFCFoQOMBZgcgEyyNfTPkP91bAtG69iCrNEq/glQ/uJbNx
        sAOQ62dPF9soTqb0kTrLOwvxuMSQt5oW6OzozXVmnZvgp/wauMKJRxyVsHuNGgJsCVYGzh7D01TWu
        caWLwi0NXlp+j+GN8bktnbZRg2OcJyv/uKT1OuzU3MMn/gNrZttHEkMPnvMkbUA53UNwWPOcTb/hS
        /FeK4JBZmKQY0mPDmXMOVZpL0vVDpadh2lV6EKfqVBTZSgXK5QlkE/1IVOY53AaWwoNvZ6GHaMTIg
        oj91dTFQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Mi9-009GTZ-27;
        Tue, 23 May 2023 07:45:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: fix the name_to_dev_t mess
Date:   Tue, 23 May 2023 09:45:11 +0200
Message-Id: <20230523074535.249802-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series tries to sort out accumulated mess around the name_to_dev_t
function.  This function is intended to allow looking up the dev_t of a
block device based on a name string before the root file systems is
mounted and thus the normal path based lookup is available.

Unfortunately a few years ago it managed to get exported and used in
non-init contexts, leading to the something looking like a path name
also beeing lookuped up by a different and potential dangerous
algorithm.

This series does a fair amount of refactoring and finally ends up with
the renamed and improved name_to_dev_t only beeing available for the
early init code again.

The series is against Jens' for-6.5/block tree but probably applies
against current mainline just fine as well.

A git tree is also available here:

    git://git.infradead.org/users/hch/block.git blk-init-cleanup

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-init-cleanup

Diffstat:
 Documentation/admin-guide/kernel-parameters.txt |    2 
 arch/alpha/kernel/setup.c                       |    2 
 arch/ia64/kernel/setup.c                        |    2 
 arch/powerpc/platforms/powermac/setup.c         |    3 
 block/Makefile                                  |    2 
 block/early-lookup.c                            |  315 ++++++++++++++++++
 block/genhd.c                                   |   92 -----
 drivers/base/dd.c                               |    6 
 drivers/md/dm-init.c                            |    4 
 drivers/md/dm-snap.c                            |   14 
 drivers/md/dm-table.c                           |   26 -
 drivers/md/md-autodetect.c                      |    3 
 drivers/mtd/devices/block2mtd.c                 |   62 ++-
 fs/pstore/blk.c                                 |    4 
 include/linux/blkdev.h                          |    6 
 include/linux/device-mapper.h                   |    2 
 include/linux/device/driver.h                   |    2 
 include/linux/mount.h                           |    1 
 include/linux/root_dev.h                        |    9 
 init/do_mounts.c                                |  416 ++++++------------------
 init/do_mounts.h                                |   14 
 init/do_mounts_initrd.c                         |   11 
 kernel/power/hibernate.c                        |  167 +++++----
 kernel/power/power.h                            |    3 
 kernel/power/swap.c                             |    2 
 25 files changed, 603 insertions(+), 567 deletions(-)
