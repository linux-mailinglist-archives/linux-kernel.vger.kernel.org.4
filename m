Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9402373BE45
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjFWSFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFWSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:05:46 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C0B2133;
        Fri, 23 Jun 2023 11:05:44 -0700 (PDT)
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.17.1.19/8.17.1.19) with ESMTP id 35NF09rD022471;
        Fri, 23 Jun 2023 19:05:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=jan2016.eng; bh=htm+XPVEuCfPBUIZTQtKhAJBmH97xCi4K/Ly7dTTMyA=;
 b=PvuNevD2K//pqEYw4IWWlsFICCbgC/0rt6qCDYP6rgimIba97dNCenDeeJXmKJB8DXY3
 YaOOcFjwhmuHP+IXxOYsP5ng5PsDf+Lyf8AxoNm383TL5hAe5T18OfqASUvu+ZLvbyfl
 ScdMfanh8nPFC04DZql0MKyl96PQKWdtuWJdglOblH+qKBqnCg8WOlPXNbxIr5JFVSUn
 Gm+M7pLbbLFrVOo7T0Yc5BvlXTE1qn75VJK0AYyovJJeMsyUrEIZqkxlk9dZBV5RmY1z
 OWJ0/631F6d4snJll/QFRKunFbQDye1RiN9yJWV6rb1AWIoBdqyHwvhMKRFx7uJRO9Os BA== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 3rcx9ran2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 19:05:34 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 35NGksgt006213;
        Fri, 23 Jun 2023 14:05:33 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 3r985x9n2n-1;
        Fri, 23 Jun 2023 14:05:33 -0400
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.41.96])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 8553F60244;
        Fri, 23 Jun 2023 18:05:33 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        jbaron@akamai.com, NeilBrown <neilb@suse.de>
Subject: [PATCH] md/raid0: add discard support for the 'original' layout
Date:   Fri, 23 Jun 2023 14:05:23 -0400
Message-Id: <20230623180523.1901230-1-jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_10,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=824 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230161
X-Proofpoint-ORIG-GUID: DTE1bIEHOp7siIdK37VJcbuBwamvW4zv
X-Proofpoint-GUID: DTE1bIEHOp7siIdK37VJcbuBwamvW4zv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_10,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=769 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230161
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've found that using raid0 with the 'original' layout and discard
enabled with different disk sizes (such that at least two zones are
created) can result in data corruption. This is due to the fact that
the discard handling in 'raid0_handle_discard()' assumes the 'alternate'
layout. We've seen this corruption using ext4 but other filesystems are
likely susceptible as well.

More specifically, while multiple zones are necessary to create the
corruption, the corruption may not occur with multiple zones if they
layout in such a way the layout matches what the 'alternate' layout
would have produced. Thus, not all raid0 devices with the 'original'
layout, different size disks and discard enabled will encounter this
corruption.

The 3.14 kernel inadvertently changed the raid0 disk layout for different
size disks. Thus, running a pre-3.14 kernel and post-3.14 kernel on the
same raid0 array could corrupt data. This lead to the creation of the
'original' layout (to match the pre-3.14 layout) and the 'alternate' layout
(to match the post 3.14 layout) in the 5.4 kernel time frame and an option
to tell the kernel which layout to use (since it couldn't be autodetected).
However, when the 'original' layout was added back to 5.4 discard support
for the 'original' layout was not added leading this issue.

I've been able to reliably reproduce the corruption with the following
test case:

1. create raid0 array with different size disks using original layout
2. mkfs
3. mount -o discard
4. create lots of files
5. remove 1/2 the files
6. fstrim -a (or just the mount point for the raid0 array)
7. umount
8. fsck -fn /dev/md0 (spews all sorts of corruptions)

Let's fix this by adding proper discard support to the 'original' layout.
The fix 'maps' the 'original' layout disks to the order in which they are
read/written such that we can compare the disks in the same way that the
current 'alternate' layout does. A 'disk_shift' field is added to
'struct strip_zone'. This could be computed on the fly in
raid0_handle_discard() but by adding this field, we save some computation
in the discard path.

Note we could also potentially fix this by re-ordering the disks in the
zones that follow the first one, and then always read/writing them using
the 'alternate' layout. However, that is seen as a more substantial change,
and we are attempting the least invasive fix at this time to remedy the
corruption.

I've verified the change using the reproducer mentioned above. Typically,
the corruption is seen after less than 3 iterations, while the patch has
run 500+ iterations.

Cc: NeilBrown <neilb@suse.de>
Cc: Song Liu <song@kernel.org>
Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 drivers/md/raid0.c | 61 ++++++++++++++++++++++++++++++++++++++++------
 drivers/md/raid0.h |  1 +
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f8ee9a95e25d..cb4b3e248519 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -270,6 +270,18 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 		goto abort;
 	}
 
+	if (conf->layout == RAID0_ORIG_LAYOUT) {
+		for (i = 1; i < conf->nr_strip_zones; i++) {
+			sector_t first_sector = conf->strip_zone[i-1].zone_end;
+
+			sector_div(first_sector, mddev->chunk_sectors);
+			zone = conf->strip_zone + i;
+			/* disk_shift is first disk index used in the zone */
+			zone->disk_shift = sector_div(first_sector,
+						      zone->nb_dev);
+		}
+	}
+
 	pr_debug("md/raid0:%s: done.\n", mdname(mddev));
 	*private_conf = conf;
 
@@ -431,6 +443,19 @@ static int raid0_run(struct mddev *mddev)
 	return ret;
 }
 
+/*  Convert disk_index to the disk order in which it is read/written.
+ *  For example, if we have 4 disks, they are numbered 0,1,2,3. If we
+ *  write the disks starting at disk 3, then the read/write order would
+ *  be disk 3, then 0, then 1, and then disk 2 and we want map_disk_shift()
+ *  to map the disks as follows 0,1,2,3 => 1,2,3,0. So disk 0 would map
+ *  to 1, 1 to 2, 2 to 3, and 3 to 0. That way we can compare disks in
+ *  that 'output' space to understand the read/write disk ordering.
+ */
+static int map_disk_shift(int disk_index, int num_disks, int disk_shift)
+{
+	return ((disk_index + num_disks - disk_shift) % num_disks);
+}
+
 static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 {
 	struct r0conf *conf = mddev->private;
@@ -444,7 +469,9 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	sector_t end_disk_offset;
 	unsigned int end_disk_index;
 	unsigned int disk;
+	sector_t orig_start, orig_end;
 
+	orig_start = start;
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
@@ -458,6 +485,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	} else
 		end = bio_end_sector(bio);
 
+	orig_end = end;
 	if (zone != conf->strip_zone)
 		end = end - zone[-1].zone_end;
 
@@ -469,13 +497,26 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	last_stripe_index = end;
 	sector_div(last_stripe_index, stripe_size);
 
-	start_disk_index = (int)(start - first_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
+	/* In the first zone the original and alternate layouts are the same */
+	if ((conf->layout == RAID0_ORIG_LAYOUT) && (zone != conf->strip_zone)) {
+		sector_div(orig_start, mddev->chunk_sectors);
+		start_disk_index = sector_div(orig_start, zone->nb_dev);
+		start_disk_index = map_disk_shift(start_disk_index,
+						  zone->nb_dev,
+						  zone->disk_shift);
+		sector_div(orig_end, mddev->chunk_sectors);
+		end_disk_index = sector_div(orig_end, zone->nb_dev);
+		end_disk_index = map_disk_shift(end_disk_index,
+						zone->nb_dev, zone->disk_shift);
+	} else {
+		start_disk_index = (int)(start - first_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+		end_disk_index = (int)(end - last_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+	}
 	start_disk_offset = ((int)(start - first_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		first_stripe_index * mddev->chunk_sectors;
-	end_disk_index = (int)(end - last_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
 	end_disk_offset = ((int)(end - last_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		last_stripe_index * mddev->chunk_sectors;
@@ -483,18 +524,22 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	for (disk = 0; disk < zone->nb_dev; disk++) {
 		sector_t dev_start, dev_end;
 		struct md_rdev *rdev;
+		int compare_disk;
+
+		compare_disk = map_disk_shift(disk, zone->nb_dev,
+					      zone->disk_shift);
 
-		if (disk < start_disk_index)
+		if (compare_disk < start_disk_index)
 			dev_start = (first_stripe_index + 1) *
 				mddev->chunk_sectors;
-		else if (disk > start_disk_index)
+		else if (compare_disk > start_disk_index)
 			dev_start = first_stripe_index * mddev->chunk_sectors;
 		else
 			dev_start = start_disk_offset;
 
-		if (disk < end_disk_index)
+		if (compare_disk < end_disk_index)
 			dev_end = (last_stripe_index + 1) * mddev->chunk_sectors;
-		else if (disk > end_disk_index)
+		else if (compare_disk > end_disk_index)
 			dev_end = last_stripe_index * mddev->chunk_sectors;
 		else
 			dev_end = end_disk_offset;
diff --git a/drivers/md/raid0.h b/drivers/md/raid0.h
index 3816e5477db1..8cc761ca7423 100644
--- a/drivers/md/raid0.h
+++ b/drivers/md/raid0.h
@@ -6,6 +6,7 @@ struct strip_zone {
 	sector_t zone_end;	/* Start of the next zone (in sectors) */
 	sector_t dev_start;	/* Zone offset in real dev (in sectors) */
 	int	 nb_dev;	/* # of devices attached to the zone */
+	int	 disk_shift;	/* start disk for the original layout */
 };
 
 /* Linux 3.14 (20d0189b101) made an unintended change to
-- 
2.25.1

