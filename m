Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2647274128E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjF1NeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:34:12 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:34264 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231922AbjF1NeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:34:00 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 35SAqQDa030756;
        Wed, 28 Jun 2023 13:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=Sf3u25kvysdXLN4r6N
        4xL38OPHKZkALW7HioKbr4PV8=; b=lVlHnb1mkQtVfbJ/YcRg6IeEFaB3WWcczj
        7WJxdIbc3jU05Uf/108mNSFLsnQh7rvfpovhyXwGLq5h3P5TDScdc/TBBjHoGt29
        clhfu8MPdzZmNpcTNH/ZP/COKy7OwWdZSohj7JJTxhly2I/eSDYCMzIRqJRSiimm
        q+Iv/C/Nd1v3GJVy4UcHb0AuoDatf5HaoRZ3FQG73+AUFYdkz+wNHhd+gSocbcxc
        ABHAuTl1lJGG4QuocYSBh9CE5rfPb5jm4RM/kjpi9CgvY3xQXIzTJqXjkhYSJy/1
        8sjEp83CRXdeBNdjNq/R0f7sweHWKg8yxIa0GmCcKgXQmH6dqxDA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rdqf4buuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 13:33:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGyxbN30D1ceGr/Oawa8zg0OZTD0C7TnFqfmrajc8YgPlgHOtZJ6dleK1YisoZ2ITv87b3QL2EaKsntUhXZKUGcXQWB5KacH7wF+uz/Bib5P0zTE+uYIK0jveI/8zWqWAbunSpO0SNJxKDgXJf93uF2DNn9te5hSyhcQiU2DWb3Orp05nqay1VAbPWqYr2fo1Sce4nL8mIV9mibDeO7XzvBKhkvTDugwH0Ch93t1kQI3W+2dq9YKjEZlmfA23m7A5/CpBOPOdnWqqwsOW9oYfw1ArE6Dz37WSLp7vxZthHmSY0RFBEuufhPveCjADO2NNLm48Zga2rw01q8kM/xs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf3u25kvysdXLN4r6N4xL38OPHKZkALW7HioKbr4PV8=;
 b=SEZSmoohk+OpaTFcgGfBLLQWhoEJqVGWJPm5crgo9qHQ7nmJW1GUWQt3i6PHMZlqv/HxkSYlJMZzO8ftQBZ/iL8U5XvHuEoJpfK80GecArZEl8UTslMWKQG9wrP3VcJ3EHuFZ88jAOI9E8pxP0SnXeH4cjxepRrrxKxaYdAILIaifJezfPrVm/9Y3tAnqKsspBoczHJ+K3dCJyvsjifaXYuME2yBC7zy1jliy3ig/+5zS+4Iy/MoHYe2uYLNKU0yFd+GZRtJtgg7bP7cCtODFnKDON4YvKLnq2x0b0wfasIM+MerJROlX32jzq6pVgJRAs5XSKNHnKQxOMXb3NntWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by DM8PR11MB5608.namprd11.prod.outlook.com (2603:10b6:8:35::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Wed, 28 Jun 2023 13:33:25 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::89a4:55ba:11f6:6b05]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::89a4:55ba:11f6:6b05%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 13:33:25 +0000
From:   Dragos-Marian Panait <dragos.panait@windriver.com>
To:     stable@vger.kernel.org
Cc:     Yang Lan <lanyang0908@gmail.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4.14] gfs2: Don't deref jdesc in evict
Date:   Wed, 28 Jun 2023 16:33:13 +0300
Message-Id: <20230628133313.1797409-1-dragos.panait@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0239.eurprd08.prod.outlook.com
 (2603:10a6:802:15::48) To PH0PR11MB4952.namprd11.prod.outlook.com
 (2603:10b6:510:40::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4952:EE_|DM8PR11MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1e106d-fa8e-49e9-b621-08db77dc4003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: og08x3Ry0YwrBrIit2RoVJ6sFgSjYHp5yGyS5vTzHhVL061TSeXvgfgvxviNXZUCHkcsXtR9KaRtyDDq/dnTA3/tRNzAMzbeVB2VbKFQNKRFmOPPGJgRIxfMjVVZRzoG/nChYJSICXUgTRzBDS0StMzgJXZwxjWnukHOsW9kE3sgrdivmQ5ntKxz8j86RtCEPII9v3lYk+z3sWyebMhmK/Crlu113YNKOehdyUBPA5a6ea/lnlDbJ49ynBLwPWkAl4AXtw4U+a6DbwbUV5NUrqh2nxik7lsGe2Ospd2GQQy8uNx1jGxdZG7PGWsthgR2avKs/+rqKn3mstppDP0qSr2OqpsrWEJaZ3czEPJ/o3w3Z3jpCHI5KXNKYeEXI9Pt6f8QNtX9fU/bWKoTl14MQLf45QbQigABVYWZDSYy6tnw5Ia3CQmBs29+o96/O2GWdk6b2DBYHjvtAZIkaWYqK3XyOSTFUjrOxLUWLVD/f13Xhbe2qkUeikQ9oalaSaYMQf80vo4Ug+Yk6VeAEMYcht7nF6xVEbmjh+u+pCDcMD6W5XEgG3kDqxrNeLKsnY+lOLtHJAt+N6lb2QbTlaWquG+Ptr6YLHsW2UXriSHTvEbaBZxFcNF4oDVtOgMhnAS6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39850400004)(376002)(366004)(451199021)(66556008)(66946007)(316002)(66476007)(6916009)(4326008)(478600001)(36756003)(8936002)(5660300002)(8676002)(1076003)(86362001)(54906003)(41300700001)(6486002)(2906002)(52116002)(186003)(6506007)(6512007)(6666004)(38350700002)(38100700002)(26005)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QeAj9ao4jQ+qFaOrOHPzgGbMdnmFT2OrjyLdDLXxKTmaQTSDVwCX70ghkhzj?=
 =?us-ascii?Q?IoW/PYD5enHqCwHY1+XSK0Er50nm4Z1rb4KtxCBj9kLZkkjtpGvLAZDa4wao?=
 =?us-ascii?Q?L4wj54uU1Jq00n4G7NsrnUPsH8ucd+s0f/Qc1P59BrpOprJsk7PSjkgAp5QA?=
 =?us-ascii?Q?VKj2ch6ITRtaMBqvZ9DaYU4yIWrl0jLgc9YtJ3/Jj5+pGWS4NAjx+MXdfeVP?=
 =?us-ascii?Q?y/lP1NhdJ5y/Ok/5P6PJGCKMxPQ9cMA0Jz67LC9++ugQ4pL86b17l4r5QkY4?=
 =?us-ascii?Q?hkf0EkauWx9rdD05+hOvl3H1Zc08N4xivQz5RVFJwrSB8bsi1ZY90jTG1c3e?=
 =?us-ascii?Q?LHRqv6Z5JhOAngEmrWEp2EjOMzr8S5Epn9LlxFx4W31UdsrDSptVq6cqZtwJ?=
 =?us-ascii?Q?3zC6PCmFl3aD1qmDoSHUIdH5eEKgAO+1n6OMycEr5THpkEgN2ElEq2/KlfB4?=
 =?us-ascii?Q?YdYwEr0RPi/MVDqqj3fmu6Fnuk+n9Btxsrz45bdRHF82p13EJJnPKWTqlLYR?=
 =?us-ascii?Q?oxOPsSc4fIj3trm3hm+y6wJf6V7/4iOHPo/HhOKvn2utoLA3koqvT4cVqgWM?=
 =?us-ascii?Q?hoA9F9feF3+pi87RX7T8U4dU+jZ4M22hlsZm27OI3dq0GQYHARWhFnx+wNfU?=
 =?us-ascii?Q?aB1ve4OKpd+Hr8YNwDBcEyXiIHJdCMfe1iWeuMTwJQEQxEEzY/epsPIO1G6Y?=
 =?us-ascii?Q?1OG+yQiTPMF5FyWqwPLaB3dRWQRcZDEf5H2BCaiWNVgs7C4ULDKp4DJuSVYp?=
 =?us-ascii?Q?z8cz+v8b2c98+9Q2lvMJ33NF005bQdCYl0ysGeK7lmfzvhlyjY7Kds+XJlxc?=
 =?us-ascii?Q?hpZBiLeYRbQN1o4KABFzzzIGG+0SxI+79yQJnkGc9XnoVV/mRA+F+COQKrpM?=
 =?us-ascii?Q?UYMnv/7lZMa+TqcUJVJOPGYlSefBnokpGWsEZAebvbAVmlm1PuxvhdOn7Id6?=
 =?us-ascii?Q?jVZZwufSLbc0axLoDjqiPVPv+2EIb/loS2rY9VWAoJ1ymwe2Nfu9jZmfhrfa?=
 =?us-ascii?Q?UBTYM2HR7ZdTNNKFqiaGK5lLlaCzJ840A/ZeyOAPy/Vz1go3/bE1Kz3LIgfp?=
 =?us-ascii?Q?82YlNhaP7Tf3pmp3Z+DQnXwwMplOMj6wdVAgP7NgR6StOLh+o7tZ2+zJ8vCh?=
 =?us-ascii?Q?B0xb8jcp6GlKH0zMzzQt1r8SkIf6JWllendxyyu/BJuj2YIH4ujRP65MbCSG?=
 =?us-ascii?Q?oHFj6WSVFKzMj3ZZsCJCPeahSqV0z/iKrlPiiHBfuXs09VLdVt3dsVpo+C/1?=
 =?us-ascii?Q?NQoruNjQJaSjynkpG7kyQlfavFFkuXA8YM1RlMTj+fikk3A7b1uayOOq+to2?=
 =?us-ascii?Q?bbpqLl2qM8iIVnlGZHJlLOoaotlX1qwh5T/zYlrSThFMUoFyvKeK3nD0HbF+?=
 =?us-ascii?Q?2OLL2OzcR83DEc6m2RV917NPWj5OKuNxKB2Xee5sO3YecW4MeRjW8RTUVpsU?=
 =?us-ascii?Q?bjypJscbRLAx6zyQZGJqd60aopogXOdmUlh3WUUV9YGfjpU9PnRBjDpQSzEP?=
 =?us-ascii?Q?K8nL8YQ+1q6/jFGAtAhl4WYIK69+XIWCmM11EexpiPgKqyr7pNp5tBtYuTZ6?=
 =?us-ascii?Q?/Z+o8Yr9Z0gs7cgY/2VjniaMVlJjEiV2AwCuEN7i0E7TSryLXMlVrwJG2fpL?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1e106d-fa8e-49e9-b621-08db77dc4003
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 13:33:25.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFclureB4T2eYklQ4fb5Mu7mJI7x3PfnLI1jT4u1ywVwkBK/6V9jLCnLGcnk/Hk8DU6JWK1lckwFATCpyjKImoDU2Wgm0DR/1AEa8ude4bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5608
X-Proofpoint-ORIG-GUID: ORpAf_57IuLrXft3AhjISiG7aZ79PS_f
X-Proofpoint-GUID: ORpAf_57IuLrXft3AhjISiG7aZ79PS_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 phishscore=0 clxscore=1015 mlxlogscore=820 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
index 56bfed0a5873..73290263402a 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1575,6 +1575,14 @@ static void gfs2_evict_inode(struct inode *inode)
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

