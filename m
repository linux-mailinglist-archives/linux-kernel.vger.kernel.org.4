Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB887180BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjEaM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjEaM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:57:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B04811F;
        Wed, 31 May 2023 05:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TCRcVCim173fPExJScP8iGYYdkO7p+IqfWzbHLnQrJo=; b=SVjvPhq1NDTXcpZVBo/A8Azx73
        Co45sPsX3AmbXu31TsFUOdhj53Nua58OQXRseCOkFufV5afqMT956ggLC+wrzGra3RWjoV/jL7jhd
        UXKczF6pXk2QfH/947nmTL002RAd5B97Defa3jEZTbrLBFpw6wgfvupLXwq2OXBxn9dDLHAD+QiOd
        jVYRSPV6FHqkuYhBrnFxdJAB5cEqWW9HUyWKbfBe7mH85FBsxYmKrdMU11nMaXLJfB9WA96cMWonc
        wYljZflwvLxHwT9fxvRyJOS7E3X1WAIjTlS7bjO+HwpuoCHbUeUFgOK4xO2/YNHkA9ribqGOZtdJx
        B7jNzwCw==;
Received: from [2001:4bb8:182:6d06:2e49:a56:513a:92ee] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LNb-00HRVg-31;
        Wed, 31 May 2023 12:56:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 12/24] init: move the nfs/cifs/ram special cases out of name_to_dev_t
Date:   Wed, 31 May 2023 14:55:23 +0200
Message-Id: <20230531125535.676098-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531125535.676098-1-hch@lst.de>
References: <20230531125535.676098-1-hch@lst.de>
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

The nfs/cifs/ram special case only needs to be parsed once, and only in
the boot code.  Move them out of name_to_dev_t and into
prepare_namespace.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++++-
 init/do_mounts.c                                | 14 ++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685ff0..457c342d15977e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5452,7 +5452,12 @@
 			port and the regular usb controller gets disabled.
 
 	root=		[KNL] Root filesystem
-			See name_to_dev_t comment in init/do_mounts.c.
+			Usually this a a block device specifier of some kind,
+			see the name_to_dev_t comment in init/do_mounts.c for
+			details.
+			Alternatively this can be "ram" for the legacy initial
+			ramdisk, "nfs" and "cifs" for root on a network file
+			system, or "mtd" and "ubi" for mounting from raw flash.
 
 	rootdelay=	[KNL] Delay (in seconds) to pause before attempting to
 			mount the root filesystem
diff --git a/init/do_mounts.c b/init/do_mounts.c
index d5c06c1546e82c..86599faf2bf8a1 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -248,7 +248,6 @@ static dev_t devt_from_devnum(const char *name)
  *
  *	1) <hex_major><hex_minor> device number in hexadecimal represents itself
  *         no leading 0x, for example b302.
- *	2) /dev/nfs represents Root_NFS (0xff)
  *	3) /dev/<disk_name> represents the device number of disk
  *	4) /dev/<disk_name><decimal> represents the device number
  *         of partition - device number of disk plus the partition number
@@ -266,7 +265,6 @@ static dev_t devt_from_devnum(const char *name)
  *	   a colon.
  *	9) PARTLABEL=<name> with name being the GPT partition label.
  *	   MSDOS partitions do not support labels!
- *	10) /dev/cifs represents Root_CIFS (0xfe)
  *
  *	If name doesn't have fall into the categories above, we return (0,0).
  *	block_class is used to check if something is a disk name. If the disk
@@ -275,12 +273,6 @@ static dev_t devt_from_devnum(const char *name)
  */
 dev_t name_to_dev_t(const char *name)
 {
-	if (strcmp(name, "/dev/nfs") == 0)
-		return Root_NFS;
-	if (strcmp(name, "/dev/cifs") == 0)
-		return Root_CIFS;
-	if (strcmp(name, "/dev/ram") == 0)
-		return Root_RAM0;
 #ifdef CONFIG_BLOCK
 	if (strncmp(name, "PARTUUID=", 9) == 0)
 		return devt_from_partuuid(name + 9);
@@ -631,6 +623,12 @@ static dev_t __init parse_root_device(char *root_device_name)
 	if (!strncmp(root_device_name, "mtd", 3) ||
 	    !strncmp(root_device_name, "ubi", 3))
 		return Root_Generic;
+	if (strcmp(root_device_name, "/dev/nfs") == 0)
+		return Root_NFS;
+	if (strcmp(root_device_name, "/dev/cifs") == 0)
+		return Root_CIFS;
+	if (strcmp(root_device_name, "/dev/ram") == 0)
+		return Root_RAM0;
 	return name_to_dev_t(root_device_name);
 }
 
-- 
2.39.2

