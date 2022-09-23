Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B045E80EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiIWRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiIWRgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:36:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED07B14F2B1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:36:30 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220923173629euoutp01229573fdab111d0a93167fe7dad69ebc~XjeImLH_b1804318043euoutp01L
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:36:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220923173629euoutp01229573fdab111d0a93167fe7dad69ebc~XjeImLH_b1804318043euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663954589;
        bh=Sh2RcKnh/5VuMjs8+3FpX3d+pxMwsjOCK/0VaM6mGeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oa0FnbqlYw8XITmegdkbI6NUERsqttiBVUuxxgmC9tL4BKRRiokxTDWuv7jALeImx
         EzE1DgV2t4o8D5ZlY/myqUuRxz3EeSDSftuBzKO01rZGft3D/VSmWlC5n0QqnR9MGw
         /pYqOXmDCQNLd2wpwHLWe6tBm3dDCCUSUjYfdmwM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220923173628eucas1p18fb85791e90b4d490e510567060c7a77~XjeG_NuqU2512925129eucas1p1n;
        Fri, 23 Sep 2022 17:36:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EB.6E.29727.B9EED236; Fri, 23
        Sep 2022 18:36:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220923173627eucas1p2f134d9cb331e4a8f0fca8431eeb0f0b0~XjeGaf4Wm2090220902eucas1p2i;
        Fri, 23 Sep 2022 17:36:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220923173627eusmtrp1aee1e9e64ae111179bc934a5d4095dad~XjeGZuJZk1032310323eusmtrp1b;
        Fri, 23 Sep 2022 17:36:27 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-30-632dee9b3c4d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.78.07473.B9EED236; Fri, 23
        Sep 2022 18:36:27 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220923173627eusmtip14c74415ab09453de0caf11795fffa12b~XjeGAqtpe2755327553eusmtip14;
        Fri, 23 Sep 2022 17:36:27 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de,
        damien.lemoal@opensource.wdc.com
Cc:     jaegeuk@kernel.org, gost.dev@samsung.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v15 07/13] zonefs: allow non power of 2 zoned devices
Date:   Fri, 23 Sep 2022 19:36:12 +0200
Message-Id: <20220923173618.6899-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923173618.6899-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7djPc7qz3+kmG5zYZmGx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZPr85isth7S9vi
        8q45bBbzlz1lt5jQ9pXZ4saEp4wWn5e2sFusufmUxeLELWkHYY/LV7w9ds66y+5x+Wypx6ZV
        nWwem5fUe+y+2cDm0dv8js1jZ+t9Vo/3+66yefRtWcXosfl0tcfnTXIe7Qe6mQJ4o7hsUlJz
        MstSi/TtErgyTvz4zFTwRbDi8uc29gbGH3xdjBwcEgImEu3dzF2MXBxCAisYJf7snM7YxcgJ
        5HxhlPj10wsi8ZlRYvfGr+wgCZCG06uOMEEkljNKPDuxFar9JaPEna52NpCxbAJaEo2dYA0i
        AukSx7feZAepYRbYxizR+b+ZGSQhLOAq8fHsP7B1LAKqEtO+HmcC6eUVsJDY9dQRYpm8xMxL
        39lBwpwClhL9jTUgYV4BQYmTM5+wgNjMQCXNW2eDnSAhcJhT4vahVkaIXheJ1vP7WCBsYYlX
        x7dAPSAjcXpyD1S8WuLpjd9QzS2MEv0717NBgsVaou9MDojJLKApsX6XPkS5o8Sqhj5GiAo+
        iRtvBSFO4JOYtG06M0SYV6KjTQiiWkli588nUEslJC43zYFa6iHRf3kh4wRGxVlInpmF5JlZ
        CHsXMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEyPp/8d/7SDce6rj3qHGJk4GA8x
        SnAwK4nwplzUTRbiTUmsrEotyo8vKs1JLT7EKM3BoiTOyzZDK1lIID2xJDU7NbUgtQgmy8TB
        KdXA1Kb4f/++r946myy03spMyFyis048f4+mi8FhH5f6HzvuRE+4WhNloW88waK5KHS9z+lT
        6m80T+2f6Cgd8Nhd9plFnu6/E9NV/lb5PBZ5EqLLOPm4H++3mIeszLv2a8ZYdah/faax7FjE
        3dN13ac2ROhEr934sqDwiKkm36aFbS9XvNlyJHbCc5EN/RPe9ZjUZcgGzDvz40ZQ7mnpxW+C
        Xgaulp2TW7vSQuqw//Ud/xNFV4QoSJzTKl3WyzddQWtdQ2x+rWaFXdnGxw6h349IZc/ds3Hl
        CllWm/8fPqw5wHFo+uqjdoUarmoddg9fHKvykjtmfn57A+++H0oiD/Szi/U9XV9JvU0vZl/o
        wxUdpMRSnJFoqMVcVJwIAFCRYOL+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7qz3+kmG2xtFLJYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9JounV2cxWey9pW1x
        edccNov5y56yW0xo+8pscWPCU0aLz0tb2C3W3HzKYnHilrSDsMflK94eO2fdZfe4fLbUY9Oq
        TjaPzUvqPXbfbGDz6G1+x+axs/U+q8f7fVfZPPq2rGL02Hy62uPzJjmP9gPdTAG8UXo2Rfml
        JakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZJ358Zir4Ilhx
        +XMbewPjD74uRk4OCQETidOrjjB1MXJxCAksZZT4O3EVE0RCQuL2wiZGCFtY4s+1LjaIoueM
        Eksa9gM5HBxsAloSjZ3sIDUiArkSx9beYwWpYRY4xizx6V0fWLOwgKvEx7P/wGwWAVWJaV+P
        M4H08gpYSOx66ggxX15i5qXv7CBhTgFLif7GGpCwEFDF+cWPwMbzCghKnJz5hAXEZgYqb946
        m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbztmM/N+9gnPfqo94h
        RiYOxkOMEhzMSiK8KRd1k4V4UxIrq1KL8uOLSnNSiw8xmgJdPZFZSjQ5H5hO8kriDc0MTA1N
        zCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamKJyS467vDr82euO2Ydt9XNPtKvv
        e9d6bsZD5f13gyeaOV1qE1DvjZz3QEH6tnMyC7eG/B9XgbDo+CPTfywULRTj3Li1SulD21GN
        Qxd83gbUbopIn9TZzaH1TidDTNrQ4Yn4lmcv5V+FVyourubZZBphn83zJaVxmV1PRNCTX467
        /V5eTGSac/2ylNklA58+qaDpRkfK4tasfif0WlWv0nqDrxbfxffRj0ynzU9e9fXJjzqVbR0i
        p15pfIt93cy4t8lpf4n3iQ3qzwxkele9WheTH+ywQ9/2wHF5d2bGgM6PzzgOzFjNHaH36VG4
        sGzer+SsH2fvOxj+vLKs7cbBlU4d/zME/GfIzuN9f/FqgBJLcUaioRZzUXEiAMkXmtVvAwAA
X-CMS-MailID: 20220923173627eucas1p2f134d9cb331e4a8f0fca8431eeb0f0b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923173627eucas1p2f134d9cb331e4a8f0fca8431eeb0f0b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173627eucas1p2f134d9cb331e4a8f0fca8431eeb0f0b0
References: <20220923173618.6899-1-p.raghav@samsung.com>
        <CGME20220923173627eucas1p2f134d9cb331e4a8f0fca8431eeb0f0b0@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zone size shift variable is useful only if the zone sizes are known
to be power of 2. Remove that variable and use generic helpers from
block layer to calculate zone index in zonefs.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/zonefs/super.c  | 6 ++----
 fs/zonefs/zonefs.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 860f0b1032c6..e549ef16738c 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -476,10 +476,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
-	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	unsigned int noio_flag;
 	unsigned int nr_zones =
-		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+		bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);
 	struct zonefs_ioerr_data err = {
 		.inode = inode,
 		.write = write,
@@ -1401,7 +1400,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	int ret = 0;
 
-	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
+	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
 	inode->i_mode = S_IFREG | sbi->s_perm;
 
 	zi->i_ztype = type;
@@ -1776,7 +1775,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	 * interface constraints.
 	 */
 	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
-	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 4b3de66c3233..39895195cda6 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -177,7 +177,6 @@ struct zonefs_sb_info {
 	kgid_t			s_gid;
 	umode_t			s_perm;
 	uuid_t			s_uuid;
-	unsigned int		s_zone_sectors_shift;
 
 	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
 
-- 
2.25.1

