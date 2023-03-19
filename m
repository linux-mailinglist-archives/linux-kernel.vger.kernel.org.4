Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AAC6C0062
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 10:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCSJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCSJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 05:27:41 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7D71A48A;
        Sun, 19 Mar 2023 02:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ccw6RGF0uxbN9wejF3TV2j3VLjMELcQH5HkLawsn1Qqq/SoqjFcnpg62yMerqukBKg93pSrLCJ52BnWY8tSAiOaD6Dl8ytVkl9ulI2zLI+bnRaUYoPPB+28JVGprwIoHo0lWLH5qgZ6ISghrObjossKNDc+d32+vzDFEAzrhk+7uqKFW4QA3Yv97gvU9Xo+vLgAmNkuWtz5NGWIKhhPsHa0HHedXRWqrRUhZl2Em30unzxGFa9eBmN3QUb3Gunw9AqXeL4AdlzcqzGnrtnwnVbHPUhHi2493UZoAPx4DJENtZL4PqS20Lh1pXAzFhpHNQe8tIzI5VOM+Wy3QrCE6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WayaedDV/a0VW4u6mHDaeEBAtKbErUi9bs6Ndywk30M=;
 b=lk/aARJfKX27iDPgz3QWQuCnuE5004PyMiXkrIfVFwC7+sYxLDYVa1ZzNf+pzurkQCNypAuZbtFNDo0B/ub53SgGKFvyUILKZXaKQglw9C3TCZMOTT2YAd0rgdSu5GNtNMD8vA4vaDGXF730wlnBBUD0eBad77yCE/ZOz9QVJq7WDjyWOpKwMVtJtM9JVbHW4RVg3JRu9EdwdAh2eZiOjqwlGvN7IQTvcortOhTywLzxHu8FjwkQ66Zr3nmGNCGHWlkWzGc0kS1p1WGxCecrbRQtHMl67CzpaZ1ESXfrUUahMTMcL7KxXDxVthJzbq7LvLPSaKRzzxcBUnfP/DhAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WayaedDV/a0VW4u6mHDaeEBAtKbErUi9bs6Ndywk30M=;
 b=qZHbrM6MC4YkPV/7OmL/AH5SunaCkm92WJvCbppx3BV2kIJDFZXD5UTuBSJSlzebklcSle+h+3iOBOMGOaIj1gk2tGHjAQp1VStrgD76cCNQ52mLJLuO8TRFiNyXqqxjzaSiUloY8ZjF2RjYcUFgggD+z9GEckfJxw0oCstsexNdLD2sHlLFTNtVRM9XYHMEqktHD9a2bcNirBdBVHUnJcBSVKZ7QxI1hTXUNwDmz80dEW/UrgmaIZOlVg2aEc0l4M000srFoeFkIu7vKnUNPlc7+4RG9r+sh/VhnBVtkqXchSjCAuyThP7plvHuHZQB1u7ujvbACR9LXTym9InJCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:27:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:27:28 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2, RESEND 10/10] nilfs2: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 17:26:41 +0800
Message-Id: <20230319092641.41917-10-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319092641.41917-1-frank.li@vivo.com>
References: <20230319092641.41917-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c36f81-8d23-4d9c-eace-08db285c2828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPm+CE1yA+rUlks5zQOuJyGghzCNqQzo5mNHzRnnqPEWJgGULcRkG6JK1BHHEYHF+zQiF+fQUevh4eaJIoIVG8WehFA8Iaxn0emWZ3VCk1vzpd+K5a3zDIFVOE/epDvY94QXiQc+HKfc59AKqsD61dpNTyEhNJ1dNG9+watc4+4hHta25vfcUwY+CDKLAMbNLv/ZtNLmpxLJQTINCkca2MuGgTcc8V7k5AL1Hmt11akME34EKizZFv8TXCL9UMutRADlvymBQbjUzCaehv2deLy6PvGmhxoCMAoh1bXbhs0jsMDxMRZYi3VQFYWyPECzgG9EPz0E+1LpYl3EDs31jLiKIQGuG0JykhbSusEKAMQUfuUAMDBrMehAuFhk4OLN6h8dXYMLlamgGwLw2NozDXQoPmMh16KxbpQOinXPtmNGVZaaOoVIdAfCeh8vTu4pNNH/W5nb+gGqKLoSeG4ex7DN8gLKeT2h0rZAUDjE76+xWjwm4UGwfk05hLemP4+B76+Ka6ZWLG2oiiNHzw1eWBrH9xL0LS/2C0Wi0QVw+rbpJxrU7o2UrUvPkhVfGToTYvX8X5hutDXRu/8nTEQhQzMgghSl5pIPrHXAFVUAc+kQ/UnEo5/M4cQtj5vywJaupR/MzwZ2bsR80wmPGM0NIFwDzs5+SsYEidSCDn3DC0mEBjKU0VH8EMiY33jaktG/scXyjJn/nh5wxGo/fM/VcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(52116002)(2616005)(478600001)(6486002)(83380400001)(6666004)(316002)(54906003)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(6506007)(6512007)(1076003)(4326008)(6916009)(5660300002)(41300700001)(4744005)(8936002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDuZT7jHrtsJoWzE3R4FbGm3SFWkh2Kvc5tddyg+EYu3P5dsCPAOqr+AESpf?=
 =?us-ascii?Q?qd2RIx28S9glt1+QvMdnjkn3AOTrTDYeCGOQj88/U967FBFkO/t2jRrfDeC1?=
 =?us-ascii?Q?Q4zf9JFUZRj/lYCkfLHtBbXVCQ3kJMLdxZC/JnNC6ItajrkPDLJHzpcU1CDf?=
 =?us-ascii?Q?TqAstseaMhjAu/YUHJsnQA6ZEdoiHk/MaHmxVLaDdXOk/4QgvbKL/tzDWPOg?=
 =?us-ascii?Q?ZS3olJB0k62dDrBM7BMqyHMC5IdkKm05CcS8W1ELpNqaAf4fuqdPloTo/tyX?=
 =?us-ascii?Q?8bfF3QrVOczgM8jq28vstKP2En0EiBU28KDYfTcHkam9YuatNCEhUYXZiPRE?=
 =?us-ascii?Q?FkbAgBEDZJfHGc8iXMPyu386fPLkmmurG+PEboHqMOgCDx6+pOV2GbFgdpwE?=
 =?us-ascii?Q?KQ3R3hWv5M8v70PYDADmsE1p/qatdLYqiz7BFkKLcIXAOxuEw89m4dHgWssm?=
 =?us-ascii?Q?UrYdo68abcWo2/GBTCCDYC5Jqotm6OnWetLID+fheqWbfesM4ASV1mxHLyT1?=
 =?us-ascii?Q?Jg0y5Y1jxS4oz9bVnDyj4+KwIDxoanJGl8u64MJ3CHQ/zLeNwWyV4dFjzn7o?=
 =?us-ascii?Q?fgwbhkzk4SyrLhuadSBGkqGZtzQiJEVSMTuA31PcMYzlvoRX8XpK+gIr07cY?=
 =?us-ascii?Q?cvPSpB3pfKXPwFESw0wsf3xjZoVnarAmrO+pAcHDhDSLHUjVx7mFPf/zqfkN?=
 =?us-ascii?Q?cWDux6yRshTXHuyCct33BGeBYGGdh6p5/oH9DtItdJUo9ZbvHs9PxlspWq3A?=
 =?us-ascii?Q?uejNpNiGr4Ps6kij18GF+BFHaagzkKquNrZ4E7z+bAv31bfsqx9tQERRPdZX?=
 =?us-ascii?Q?Jlj1o3krL+F0xE45VbX/uCBgkT8quF35FHr9c4c7OU7Ao8j50/+oOWi3gevT?=
 =?us-ascii?Q?pavxs8vu+kJJQyHUTeRSlyBwrctkiNB2mTuokLemnn/pSmDbQTm5/SNUSoJG?=
 =?us-ascii?Q?ABCoFFqJTFAHVCv0FsqFXBmbIqsRvZsuZrcz98LRE7zgKkaf4QUabhEBWMK7?=
 =?us-ascii?Q?C5Lc2VVYd3/yJx08Mos+O21+eaA3G+LmuQdCgvzYcP9hsA35PoKwSTKU7AoA?=
 =?us-ascii?Q?hOXNyUpvi6X3PdCeNDmC3HwyjBZkHrXe5/zarrpOiwZpQEf2Jq8HjOGkF6n/?=
 =?us-ascii?Q?dXYQTCtPb6Tjyz9RNs7isEaF3cGxs/FOFF5BunSZC0bDGGrKOuaps8Cfu2G0?=
 =?us-ascii?Q?+atiTJqH1I6WTrhabdUaR0grmf4Om00aAjY3WUp6PazaVtINYfc2zVUzrnSR?=
 =?us-ascii?Q?HU5qVhMVfiw4dQP778/t9LpztSNRBQOXd4g1JWESlw4aqcGOAGcAEOdJyCqK?=
 =?us-ascii?Q?r58DOZlAIomf4NsBkRHFH5bE5eaBBYN0ar1ZZ6LYE0aIAW4OztjnXjlIi+sJ?=
 =?us-ascii?Q?O7L3zETYRb8zdx/yli1zSpvD2gyCudzNfQqLlsgySsICp9zhWColmcAkslb8?=
 =?us-ascii?Q?SeDM4gWcA/oh0rEhjTFJBU4H5IQtkUc9kD0cwNMi1mr6mydCo3pJ8bNkl+NI?=
 =?us-ascii?Q?9bXFsd/8s1YgL1+70ifYiiM9TnvfxJQ9z0Ff4C3xiqXFYIVUgp8zoqZUR/bK?=
 =?us-ascii?Q?OxzWi0H5+Gt2AylQRU8xud7eo7/CQsjkyvD0uzxl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c36f81-8d23-4d9c-eace-08db285c2828
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:27:28.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ay5qR4Lten7nu/Fk8tdWxNOUUyHnx2hMHWwUzXLTAp10urSw7jGJVou84gShBYM86CmeO2FUxAOhNAsXB5O+fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/nilfs2/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 379d22e28ed6..150965d58ca5 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1042,8 +1042,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 	nilfs_sysfs_delete_segments_group(nilfs);
 	nilfs_sysfs_delete_superblock_group(nilfs);
 	nilfs_sysfs_delete_segctor_group(nilfs);
-	kobject_del(&nilfs->ns_dev_kobj);
-	kobject_put(&nilfs->ns_dev_kobj);
+	kobject_del_and_put(&nilfs->ns_dev_kobj);
 	kfree(nilfs->ns_dev_subgroups);
 }
 
-- 
2.35.1

