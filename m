Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBD74128B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjF1Ndm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:33:42 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:21054 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231910AbjF1Ndb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:33:31 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 35SBA2tD002888;
        Wed, 28 Jun 2023 13:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=FzntaIMIEqZNLZogt7
        dvDGQ15SQo0lvSC9otQFCE6tc=; b=iPQcaUmiW75e3SOOd9HEt1h9meFa3uzZAf
        Yxaw6s603Yk9bvsh0yAuv7eZbY9a5JvC0V3j/o1AL1CU50bDAZmbkt3LpsjqgL2N
        dOPK8o1x64tKas1hlTAJbUVDoOAzvWxS9pDZBtKi8Dvzxrbb4AdlGlKpPPiW6b3H
        mOcpBbM/bynmRXwTbiuz6Qdf1gXm6m+o5yTJGdKp+o1e6N+z2sgnH2L/QtYX4RU3
        gEZSKqsSkuw0uGyGLG3uNHwyNtKdVOOOMQCQ//ISNNvOawyUFLIuLuI7m2eX55uZ
        RJL6UpQTf20FkzE6kKEVKtUGUpCzVGAYxbPzwff/a9IuBY1Lmsuw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rdpqb3vap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 13:33:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI0Io4UIrnAGlZs0F6HNfIRB4WKe8C/CFuIKaNziKBa39eKgnZEP7XEonm7fp4ETdCfOnnVUmL/b2geTAra619qKysCvog3r8rkuN0hhsMJNZ1S14hv5GVvGqc8zC9O9t+Iz6Eb3OENi9W7c81PY89MdQpo9vqEfSmWKV0Rk13CoNQ8GPIxskisd7YEU2U8z/2xKk2Q/75YPW7MPDY1fC+3PGT4kTjBuAjtFVnn3r3YV5zq1ePqOF1zi5JR6coWiqoBwXGkgmaj/8ZD0b2o2EamTAP5+q5CJOJTfAHiVX/f+Zkw23vr09fA/Trx9Kh434Cse9iIpS7IGdvBKEFxIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzntaIMIEqZNLZogt7dvDGQ15SQo0lvSC9otQFCE6tc=;
 b=kUoKbZiAn59BtAzRgbmD/+JrxEzhKtjbeErtlXjUCAAJmf9JpOaxgfcwsz4qzsFP0SmiB/7C2DK1z10jZalF6iVb7PlROeCz1KnTjAhu+RdVCPZOi+sM2FXeK/ADk4+AR7NQhvJ/ZmqnQdUS4/UHIg4oMAAiRXcpG++iyLngolfwLWPTCbe4ftZcKdJ2XUZP1g4o/EnfgKyz8s2PBYHfe3eFi5gbElsODvo33L+KSogJjPmZHemMQnBRUETgy/9p2l1tsCgsOLJ+0PdaDpI8TQuAa8taHmpGfsu6oCkvbr+zFVf+oftS47XjfD3ICmN7Ve9kchXKcOYjZy3T23CdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by DM8PR11MB5608.namprd11.prod.outlook.com (2603:10b6:8:35::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Wed, 28 Jun 2023 13:33:01 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::89a4:55ba:11f6:6b05]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::89a4:55ba:11f6:6b05%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 13:33:01 +0000
From:   Dragos-Marian Panait <dragos.panait@windriver.com>
To:     stable@vger.kernel.org
Cc:     Yang Lan <lanyang0908@gmail.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4.19] gfs2: Don't deref jdesc in evict
Date:   Wed, 28 Jun 2023 16:32:50 +0300
Message-Id: <20230628133250.1797254-1-dragos.panait@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::20) To PH0PR11MB4952.namprd11.prod.outlook.com
 (2603:10b6:510:40::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4952:EE_|DM8PR11MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ed4229-348e-40fb-6e5a-08db77dc31dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdvTyW/sOWnyWw3JAx7lUlaGKcOvoOY5ipzcwkh5Pbzpr6eLRV7TXKttJLBP2QxMZOVBy7w1NfINJwy8Ejli+jxR4yVN95qrwBNwZ1jlD3IxdycaSrGJIV6admT9KDGp20vQYby/Z8kAsOx6VP0EGytnuEXlMO7TVwzHU0EIhG6xdgLUYSvh8vMUiyiYV7rh5oQF+xuL2pPKODC5a3j1pE507Hm0HljFbOgScjt9oxqD+pps+VET3JYuouYr4UrfPSaSKppMieFBQYy2opWYwnficAq5Z5iEBhrWqQDOPY0OTEroeCc900D3JJgT70qe5B8J5+G24kFzbOSg4bg2NjiN+0Z990UwbduLGbJJjrlmJU5AF30mo0lxIljxzBnDXz7+FEPgWNh59DOq9/oo1CVcWCdIr2MrJLothVPpDLYZk/B4bq/+N1P2dLy1uEMnS3Gtn76uV39FcvsWk6DOqaKE+MA1oi6ZTvoh2tWRulk9sSY2/UoaihCcxm2s9g33nt82TbnCAu528adHpuYVxAPVJOREMDX1hZsb3i3m+Cjt87H2i0SKWSaquTQzH/fCb8GsHXVusJjRvPAabqriEm3Ujzorz2/IMuKLoclWTyqRwS08Vy5Cfouvs3nBtFy2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39850400004)(376002)(366004)(451199021)(66556008)(66946007)(316002)(66476007)(6916009)(4326008)(478600001)(36756003)(8936002)(5660300002)(8676002)(1076003)(86362001)(54906003)(41300700001)(6486002)(2906002)(52116002)(186003)(6506007)(6512007)(6666004)(38350700002)(38100700002)(26005)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uNbYzONA2d5flUmJB8Kw4OMy7a9q1SwYnayEtxhWCuWrFWrbifM5RkSp7q/F?=
 =?us-ascii?Q?8oWAaLv0rQtO5hcOA+gX+JJmqFV3Y9DG8TB1EIeUUwyqQ+XYZNyIls/9yOnh?=
 =?us-ascii?Q?Z8J1AkKUQT1wyk8BnqHOlb7opR2BqE/X4BJn4nGzgjvn+dfHAfhJ7kZLObNT?=
 =?us-ascii?Q?g9kHRelkJZo9c+U3bzYSfFzoPWvIcMKVsyfTGhPS8z06nms9xc+PJecFpafq?=
 =?us-ascii?Q?ziOzcnHb89GeOFSixpnpiiu4G36k4rJCJXvOwLdFr1iLjboQCWq1LNubqcxB?=
 =?us-ascii?Q?6MGZzic86fTPdKNwjaFAh3iHi2s8m2KrY3G7jd6fjQcvFMw4p0+jfu/vOgg+?=
 =?us-ascii?Q?1iR9X/TL8zycN6bbCcZSt449JQVU1o7dbxIspc+XBX882LRFzHe35prKdWNW?=
 =?us-ascii?Q?UapYv/s+okUSFDSXHKJwLFhbyF+3c82X1YHBXPMz+uIrB7/xFs+ldP7QV7fx?=
 =?us-ascii?Q?NTuvoR+6OiFhhCFmOTXJs8PhNMn3cYHRQ9C7zcxOMoMqBW/bHaKV1iqFFLvL?=
 =?us-ascii?Q?ADoZtg613kx6rjmkaVSD7ERUGHQ/0UH0/lrQfGuytgu/kyvuJCo7ciojilmv?=
 =?us-ascii?Q?hgOz12if+VavrCs6UIxcZV3yT8er0VnmGcFtWiwFVY4Kiqxes0JwSByIxRrr?=
 =?us-ascii?Q?NaqRaECmT6LzMnGi3EDzipd6hrPkwPVpUoQbYtcWI6Ab2w6kxWZZPdMaT+5s?=
 =?us-ascii?Q?z4moWx8rLQlxdHDM0+zuA0xSuJQzYIRciwM6zH0SwQwTtIkkP3OQok88ZM/p?=
 =?us-ascii?Q?qEUo0NaMF5OMcJcLJgS57rezWOGrpjbfdSqkLEXfkLVmUVKZOtK0yDZSoQ4G?=
 =?us-ascii?Q?AavGtbbLjAYkRp/6cpidF7XRNVxq+yvYWgiS7TmJjbjZmu2q7YF0SCTF/Myr?=
 =?us-ascii?Q?sJzb4Awdl/cdd35Pr+qWX9CWKolsUce16/PoB6wzcE5isJIYJKS5DcIpuLEP?=
 =?us-ascii?Q?lJ8C6o/2EENZ1QrCbOJ4/ujTt5aOx8j7WP372ogl01H0As4pEzG91YYdniip?=
 =?us-ascii?Q?JjqA2ChXKRo9uCspaMc4p97MPTz4F4kPl1CNMN2TUZfwtIAgyf8GGR5sRr67?=
 =?us-ascii?Q?7gkAX6eFaRcZW4IHKqNJ6QoFQ9hntSahZrfT2zICNE+49Kea8gs1mSsElUtK?=
 =?us-ascii?Q?gzWn/PpVeib1+sVt56ScQu39eC63uTmKmclcfyh7GrlGkHlmOUwURiRt34DL?=
 =?us-ascii?Q?C2isFdtlTKO8w1vK6scSdcHDxR3GhhPh6Gq9LKoJbYyOGn384KnnIPJvrQu2?=
 =?us-ascii?Q?iNEm48d0Q225avlm82QM7eP91IZi/qNfunJ2wDRTaDPMwAPkwd9sCO3ZYutm?=
 =?us-ascii?Q?NzhQiMGY6BTLZJgyPrIGn2oaWnZQHUPdNBLI/w5XDGStpQpaqb6m1Pfp0kH1?=
 =?us-ascii?Q?snyTfotCij6wkXljXBXRzyc/putoGgKQAXNorm79LG/C/WuXnUCyIh6F3Rgq?=
 =?us-ascii?Q?bkXu/1fv0QY/DEW8MxIB3U6A9MU7hyNS+h7KP/rOt1as9hclIxxjd8soka2y?=
 =?us-ascii?Q?vs441KCaVEBLBa5O8DyiS6M9d54HIVk+otRnwvtveFyzOiWcHx2x/ILc7F0x?=
 =?us-ascii?Q?5LdZAd1PrXuTqQvfPMEdZxiZDlsF/lC/MXtv/Kud297spJsVdLutSeXvSQ8W?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ed4229-348e-40fb-6e5a-08db77dc31dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 13:33:01.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQbyhJsPB1rVCuHr9pStMKtvx3pYaHH0lRNju1Ks9f++rTnLBcNi1w5SxYn+oJZKz458oPoUQjeGgJlYo/fipJ51AbRt7hXYYqPLO9CFArM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5608
X-Proofpoint-ORIG-GUID: AD3tY-fg8X_QLKXArQrCXSLZwapYUkEm
X-Proofpoint-GUID: AD3tY-fg8X_QLKXArQrCXSLZwapYUkEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 mlxlogscore=820 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2305260000 definitions=main-2306280120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit 504a10d9e46bc37b23d0a1ae2f28973c8516e636 ]

On corrupt gfs2 file systems the evict code can try to reference the
journal descriptor structure, jdesc, after it has been freed and set to
NULL. The sequence of events is:

init_journal()
...
fail_jindex:
   gfs2_jindex_free(sdp); <------frees journals, sets jdesc = NULL
      if (gfs2_holder_initialized(&ji_gh))
         gfs2_glock_dq_uninit(&ji_gh);
fail:
   iput(sdp->sd_jindex); <--references jdesc in evict_linked_inode
      evict()
         gfs2_evict_inode()
            evict_linked_inode()
               ret = gfs2_trans_begin(sdp, 0, sdp->sd_jdesc->jd_blocks);
<------references the now freed/zeroed sd_jdesc pointer.

The call to gfs2_trans_begin is done because the truncate_inode_pages
call can cause gfs2 events that require a transaction, such as removing
journaled data (jdata) blocks from the journal.

This patch fixes the problem by adding a check for sdp->sd_jdesc to
function gfs2_evict_inode. In theory, this should only happen to corrupt
gfs2 file systems, when gfs2 detects the problem, reports it, then tries
to evict all the system inodes it has read in up to that point.

Reported-by: Yang Lan <lanyang0908@gmail.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
[DP: adjusted context]
Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
---
 fs/gfs2/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 3cc2237e5896..bb0eaa4638e3 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1586,6 +1586,14 @@ static void gfs2_evict_inode(struct inode *inode)
 	if (inode->i_nlink || sb_rdonly(sb))
 		goto out;
 
+	/*
+	 * In case of an incomplete mount, gfs2_evict_inode() may be called for
+	 * system files without having an active journal to write to.  In that
+	 * case, skip the filesystem evict.
+	 */
+	if (!sdp->sd_jdesc)
+		goto out;
+
 	if (test_bit(GIF_ALLOC_FAILED, &ip->i_flags)) {
 		BUG_ON(!gfs2_glock_is_locked_by_me(ip->i_gl));
 		gfs2_holder_mark_uninitialized(&gh);
-- 
2.40.1

