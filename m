Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE37413D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjF1Ocj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF1Ocf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:32:35 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B9C173F;
        Wed, 28 Jun 2023 07:32:34 -0700 (PDT)
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SEER59021773;
        Wed, 28 Jun 2023 15:32:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=jan2016.eng; bh=KpY7OVWqzWGDmJBhM43mCk/KE57+lLQLG7sWyncxyec=;
 b=JmHFkDZC8i9wrdYZjvCiDdhYo2h86r5bRuidVNQlTOn2HIc/ApEtQxSR/9E9uo+6tkqN
 WZfZCV+tw9frEcozCbynZY2zmXWlo3eWpD3picAXVotjUCP5+A7AstXW/RzR5fYCDiJk
 E2ZVtQ4w2SyLmFfPH5LPzVPVVwKeeOWWEQn9UICioyvV/nq2nqFzelLZzXM7vwprWrb5
 75hJnEEI3X/0ZRgAYrh0b6LmnY/2djIL5CHl19bPo1fSNxlDN353+CgRwTB9+1gDh1ys
 cR1wghFiIFaUmG30Aiij0BbEgkFCWlrr0VRE+6RER6mtEx5aqmyBJdusZ1myMqVV1amm SA== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3rfwuauddx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:32:28 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBvLXT027699;
        Wed, 28 Jun 2023 10:32:27 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
        by prod-mail-ppoint4.akamai.com (PPS) with ESMTP id 3rfv6dftdc-1;
        Wed, 28 Jun 2023 10:32:27 -0400
Received: from bos-lhv9ol.bos01.corp.akamai.com (unknown [172.28.41.96])
        by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id 435C0240C;
        Wed, 28 Jun 2023 14:32:27 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.de>
Subject: [PATCH] md/raid0: drop discard support past the first zone for the original layout (stable fix)
Date:   Wed, 28 Jun 2023 10:32:01 -0400
Message-Id: <20230628143201.1522227-1-jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280127
X-Proofpoint-GUID: yRApG8ji_juYw68fgH-alSgk1t6oT30O
X-Proofpoint-ORIG-GUID: yRApG8ji_juYw68fgH-alSgk1t6oT30O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280128
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

The fix here is a minimal fix intended for stable trees which doesn't do
discard if we have the original layout and we are not in first zone or
if the i/o crosses zones (we either do the entire discard or none of it).
The proper fix to actually perform discard to all zones for the original
layout will land in upstream versions. We have implemented the minimal
fix here for stable branches to reduce risk.

I've verified the change using the reproducer mentioned above. Typically,
the corruption is seen after less than 3 iterations, while the patch has
run 500+ iterations.

Cc: NeilBrown <neilb@suse.de>
Cc: Song Liu <song@kernel.org>
Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 drivers/md/raid0.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f8ee9a95e25d..2713a4acb44f 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -444,10 +444,25 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	sector_t end_disk_offset;
 	unsigned int end_disk_index;
 	unsigned int disk;
+	bool bio_zone_overlap = false;
 
 	zone = find_zone(conf, &start);
+	if (bio_end_sector(bio) > zone->zone_end)
+		bio_zone_overlap = true;
+
+	/* The discard code below doesn't properly support the original
+	 * layout for the zones above the first one. We are adding
+	 * proper support in later kernel versions but have decided
+	 * that dropping discard support here is the lower risk option
+	 * to avoid data corruption for stable versions.
+	 */
+	if ((conf->layout == RAID0_ORIG_LAYOUT) &&
+	    ((zone != conf->strip_zone) || (bio_zone_overlap))) {
+		bio_endio(bio);
+		return;
+	}
 
-	if (bio_end_sector(bio) > zone->zone_end) {
+	if (bio_zone_overlap) {
 		struct bio *split = bio_split(bio,
 			zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO,
 			&mddev->bio_set);
-- 
2.25.1

