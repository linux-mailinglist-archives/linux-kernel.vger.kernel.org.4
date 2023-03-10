Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426356B54A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjCJWkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjCJWk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:40:29 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF412D499;
        Fri, 10 Mar 2023 14:40:22 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678488020;
        bh=epYWXKBJa5iht0Supr1GuLtnIZPiqqx0ImoS4kq6TGM=;
        h=From:Subject:Date:To:Cc:From;
        b=X7PmYmEI8zQpdzxZCcZgH9hgKVvymkqOEjLItz78ML4Hj8n0pWpdaxdKVgCAXZyL2
         osay/o4H00w5YyTIzcrnY8+GrLRJ42esWtU8nOhkHsdpA8WjxuQq6m2ulSZU1+e32j
         R+q3in5+enQaNk4gDC2CLrEGTSJZPesv1U63K2z0=
Subject: [PATCH v2 0/4] blk-integrity: drop integrity_kobj from gendisk
Date:   Fri, 10 Mar 2023 22:40:01 +0000
Message-Id: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMGxC2QC/42OQQqDMBREryJZNyWJVmhXvUcRSeLX/CpR8qOti
 Hdv9ARdvmF4MxsjCAjEHtnGAixIOPoE6pIx67TvgGOTmCmhcpGLO+9H864DDKAJeAe+Qepr9BG
 6gHHloEorjJWq1JoliTlqJmhvXdL4eRhSOAVo8XuuvqrEDimOYT1PLPJI/95bJJdcq0K0twK0L
 cXzA0hE1s3u6iGyat/3H/rNDRrmAAAA
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678488015; l=1205;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=epYWXKBJa5iht0Supr1GuLtnIZPiqqx0ImoS4kq6TGM=;
 b=uySd3xs1k7nilNKYWnr0GVxVHcN0tRbT2G6Nhc2ykxsf49vZIgoKnSeNrA14wCKXwELIvE+GR
 mm9hfIqCr9tAQZem9afiZR7shoyPR6T3QYspwCMF55juDxewqgpMYY5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The embedded member integrity_kobj member of struct gendisk violates
the assumption of the driver core that only one struct kobject should be
embedded into another object and then manages its lifetime.

As the integrity_kobj is only used to hold a few sysfs attributes it can
be replaced by direct device_attributes and removed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Get rid of integrity_kobj completely
- Migrate to sysfs_emit helper
- Link to v1: https://lore.kernel.org/r/20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net

---
Thomas Weißschuh (4):
      blk-integrity: use sysfs_emit
      blk-integrity: convert to struct device_attribute
      blk-integrity: register sysfs attributes on struct device
      blk-integrity: drop integrity_kobj from gendisk

 block/blk-integrity.c  | 159 +++++++++++++++++--------------------------------
 include/linux/blkdev.h |   3 -
 2 files changed, 55 insertions(+), 107 deletions(-)
---
base-commit: 55a21105ecc156495446d8ae75d7d73f66baed7b
change-id: 20230309-kobj_release-gendisk_integrity-e26c0bc126aa

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

