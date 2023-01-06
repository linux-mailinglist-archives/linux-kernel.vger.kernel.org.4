Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5817965FCDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjAFIee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjAFId2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:33:28 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE33F676CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 00:33:27 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083322euoutp02d97892875c4e17f854bb7d8a1a5dfacd~3qy6L_q652168121681euoutp02q
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:33:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230106083322euoutp02d97892875c4e17f854bb7d8a1a5dfacd~3qy6L_q652168121681euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672994003;
        bh=LXXa5WqRMuw776PYfMbNhiRBXFUIY42wRgq3is6fToE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfYx0haNy/Z/IHN2Jg15oeG3zyLR+5J6K4SMptCdBwRXbGvciBpxgPLCHxl5okyQT
         jFH/oeA9BE98cmeKnb0avDbZ+s1xr5VtTkeLnliH6Ad9xTDeJtYmEEnoSe9md9liaw
         QXOltcxuyS4Lln43dbMfeoEP0csvFtq2zs2WKkZ0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230106083322eucas1p1c3c3079982519376276cf618f4614634~3qy5RsdUQ1103011030eucas1p1F;
        Fri,  6 Jan 2023 08:33:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.93.56180.1DCD7B36; Fri,  6
        Jan 2023 08:33:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230106083321eucas1p15e9087bcc62bc6a4f5a61467e1c98698~3qy44kw8g2243222432eucas1p1A;
        Fri,  6 Jan 2023 08:33:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230106083321eusmtrp2d3f5148d45e550f1ae35a15ae7e369b6~3qy436qaB1128211282eusmtrp2B;
        Fri,  6 Jan 2023 08:33:21 +0000 (GMT)
X-AuditID: cbfec7f2-acbff7000000db74-9f-63b7dcd19fcb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AC.AB.52424.1DCD7B36; Fri,  6
        Jan 2023 08:33:21 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230106083321eusmtip134788efdb299072ab1171e30bcf8eb04~3qy4l1qIF1412914129eusmtip1J;
        Fri,  6 Jan 2023 08:33:21 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 4/7] zonefs: use bdev_zone_no helper to calculate the zone
 index
Date:   Fri,  6 Jan 2023 09:33:14 +0100
Message-Id: <20230106083317.93938-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106083317.93938-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7oX72xPNljYZWWx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLmwd2MlnsWTSJyWLl6qNMFmdefmax2HtL2+LyrjlsFvOXPWW3+Ly0hd3i
        xC1pB16Py1e8PS6fLfXYtKqTzWPzknqP3Tcb2Dx2tt5n9Ti70tHj/b6rbB59W1Yxemw+Xe3x
        eZNcAHcUl01Kak5mWWqRvl0CV8bP3ZeYCw4IVjz++Zy5gXE7XxcjJ4eEgInE1KOX2bsYuTiE
        BFYwSly+uYQJwvnCKNH2Zj8LhPOZUWLy1ZmsMC3t675CVS1nlGi8fQDKeQFUtecTYxcjBweb
        gJZEYyc7SIOIgLDE/o5WsEnMApuZJG7/XssIkhAWCJL4d3ceC4jNIqAqsefcNrANvAKWEg/2
        LYTaJi8x89J3sEGcAlYSz6evYYKoEZQ4OfMJWC8zUE3z1tnMIAskBLo5JdpnbWOBaHaR+Hz8
        HiOELSzx6vgWdghbRuL/zvlMEHa1xNMbv6GaWxgl+neuZwP5QELAWqLvTA6IySygKbF+lz5E
        uaNEU+sfqAo+iRtvBSFO4JOYtG06M0SYV6KjTQiiWkli588nUEslJC43zYE6zEPi/ocrTBMY
        FWcheWYWkmdmIexdwMi8ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzCpnf53/NMOxrmv
        PuodYmTiYDzEKMHBrCTCW9a/LVmINyWxsiq1KD++qDQntfgQozQHi5I474yt85OFBNITS1Kz
        U1MLUotgskwcnFINTIrFHZ0t6uuvVNYH2CY7nPaab67Ppqr7otxcqZX5r26/7/XDlVza0pc/
        Jl3Qv3P/D3/P7OmhyhI7XV/sPBSdnbIg027mxy/WmZqsuWFeevOfKXM2HDNkefyq9+ytRyHb
        d6pWHX5uzLV7pb+76V+N8v2LpBKSJvjYiL5atCRZeUKi/IRdti1PBVWv3Qg9Gc18p7Zly4nH
        l+38fnRtfNZrXXGgfpr+tn9tM1cGfbp5eF7Wt79RR3adr0v597/8fMXWWzfXsbBf2lbKejuh
        4n2PeNfWyf+n97j+/yW9cfp1zrKJU9a0PSxYt/blbNF/7ncd+NdN0/m+7vHCssRqMwuthjK3
        y9YKzjNEc/4mSfwv5VJiKc5INNRiLipOBABUXKzy2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7oX72xPNug6K26x+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLmwd2MlnsWTSJyWLl6qNMFmdefmax2HtL2+LyrjlsFvOXPWW3+Ly0hd3i
        xC1pB16Py1e8PS6fLfXYtKqTzWPzknqP3Tcb2Dx2tt5n9Ti70tHj/b6rbB59W1Yxemw+Xe3x
        eZNcAHeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        XsbP3ZeYCw4IVjz++Zy5gXE7XxcjJ4eEgIlE+7qvTF2MXBxCAksZJaZsu8sMkZCQuL2wiRHC
        Fpb4c62LDaLoGaNEz6tW9i5GDg42AS2Jxk52kBoRoJr9Ha0sIDXMAgeZJJ5N+Q42SFggQKLz
        0282EJtFQFViz7ltrCA2r4ClxIN9C1khFshLzLz0HWwQp4CVxPPpa5hAbCGgmo6PvWwQ9YIS
        J2c+YQGxmYHqm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgfG3
        7djPLTsYV776qHeIkYmD8RCjBAezkghvWf+2ZCHelMTKqtSi/Pii0pzU4kOMpkB3T2SWEk3O
        ByaAvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJlGOhx+rLt4T
        fHKhOv0Oq8zv3A8mViY7pycpP1ZjPzyjxKLw5pnMyR27ZjGdWFLoszLUwdLK8esNa9lZIsUn
        Mw+6cMxcl635nv2Z5dTdRS/L2P+s3Hm3VTn90gSeJYdDZFP2PgttMkmJnrzt5s/HTalO8nq/
        AuyeWDmlf717l9Nkrs2k0q2bmrNOtyw7le/hdlRP4OHEzXYBPadLGUL6taclPn7uf1rz8RrJ
        WN0J1i0zJ1ytXyU753Lu2gyfbJNinUk6vkrH7MPNm5LvSm099CTRPXffy+SnPCvTJoS+fZC9
        eFKa/78w767exJhzXCZndmwW2TJ3r0NJOYPBJZs/zGJ6sYduLil/m95z0l5knRJLcUaioRZz
        UXEiAM7UemJIAwAA
X-CMS-MailID: 20230106083321eucas1p15e9087bcc62bc6a4f5a61467e1c98698
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083321eucas1p15e9087bcc62bc6a4f5a61467e1c98698
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083321eucas1p15e9087bcc62bc6a4f5a61467e1c98698
References: <20230106083317.93938-1-p.raghav@samsung.com>
        <CGME20230106083321eucas1p15e9087bcc62bc6a4f5a61467e1c98698@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bdev_zone_no() helper instead of opencoding the logic to find the
zone index.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/zonefs/super.c  | 8 +++-----
 fs/zonefs/zonefs.h | 1 -
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 2c53fbb8d918..c2ddc62e99dc 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -487,7 +487,6 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
-	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	unsigned int noio_flag;
 	unsigned int nr_zones = 1;
 	struct zonefs_ioerr_data err = {
@@ -502,8 +501,8 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 	 * size is always larger than the device zone size.
 	 */
 	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev))
-		nr_zones = zi->i_zone_size >>
-			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+		nr_zones =
+			bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);
 
 	/*
 	 * Memory allocations in blkdev_report_zones() can trigger a memory
@@ -1420,7 +1419,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	int ret = 0;
 
-	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
+	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
 	inode->i_mode = S_IFREG | sbi->s_perm;
 
 	zi->i_ztype = type;
@@ -1804,7 +1803,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	 * interface constraints.
 	 */
 	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
-	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 1dbe78119ff1..703bc4505b29 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -179,7 +179,6 @@ struct zonefs_sb_info {
 	kgid_t			s_gid;
 	umode_t			s_perm;
 	uuid_t			s_uuid;
-	unsigned int		s_zone_sectors_shift;
 
 	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
 
-- 
2.25.1

