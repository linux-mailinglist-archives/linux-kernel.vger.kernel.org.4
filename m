Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FF66C207F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCTSzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCTSzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:55:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B09C233C6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw9RQJbCcrL8A2VIpLhdRjEaRg5qr2LePu7/l46bvJ7GaFxWto5Xb9aH6z75uawnwwpBnJ7568N9qn+DBorSPsz26vb5bFLc6Ucd3eaWddjpHC6R/UZ3arTzxfShSVRRDm49PyHoHVVmHUa3eFt2Kp6jusj+jpCxQi0uNaLdDf167I5Gnc5SwbjTQcqCpAbzXaqFDeqNDGGctfL8YI2rwzNOupNniNd4g1JicKa7g/My1k5cnem8+1v94QDZZ/6/8mjHIpQhiCJtnBUQDA7GgFm6WRHdOcydNQBFUFdW8o3IS8eGjax6pcnL3yvzjKNlqpMK2zJF2R+XoXBcGFO7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX4N8DgWgxcksV62oYRh79eSYh7nL6ePu6WISP6rzL0=;
 b=nPLV0YsYO+vuB7QlG39hjqIzpihr/KrpMeM/S3cU5U16NRoDjNL/7Vf6MRWtcyb1zzNyQyzcOaBz5MPNXwT2vyffS0F0vIaZ22MN6DJ24pOGJsxsipC2zv+iTmUXu+3tkN+BXY/Ze2pqZK8+L1TrslIPqURX3pdZLrwb/IuWRWQ3et8hR034WcDladPEtSot6Y5HB8Ffjzq+I56i+f68dsgVMXts9foLTmbAdprIlomNWfS1MI0ufN11mtnYLCmYKWxqYZDAQuk93q55cPqgak0uNKFn19xZH1Cq0LxcfEDG/WrBCU+f2v+xitxiQkwjpPYcXyf8fWzpC1feCWEv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX4N8DgWgxcksV62oYRh79eSYh7nL6ePu6WISP6rzL0=;
 b=Htc4RuG5f6btDTujdEYvIPBJrbBW/ySupVG3WJk3jkYoQNiWRbuSeCzGpfjals9gpcEUS//N7EnnzLh97XlZFuZ09dRljDpLRSiMp37ayZ1IjhzIJrxEbuZlQwHqR+nvPJTu7+TwTcW+oleTetdrExGtAUU+hVOTkUhb+4NK1w6AlEHPwuf0kLE5ZYbypwYXmMXsth6MHFHjxrF+bi2AeYN9KGNqCV0Ip/MM6ZepvLkmckrPL+C9LR6eAk/qAXL8RnvjOW5gyjB3Fk7Vh6qaCEwlsReaxKT02hgnlMjsy7g7LLAfjEWOf05+EJNsaBhY1+DOmLEORdRXjslZQkdhKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 18:47:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:47:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [RESEND,PATCH v2 02/10] f2fs: convert to kobject_del_and_put()
Date:   Tue, 21 Mar 2023 02:47:21 +0800
Message-Id: <20230320184730.56475-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: feda5d6a-c008-4f4c-0b8b-08db29739856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjsTnVmEtYu9pWz8JA0OgzjJw10X0FlLZsRogOTOfpO1NhsoG5ipgeciQIhrc5S/dom8l1G54hHLZMvRfv37/mSeSKd2QPW5IJpfnhX0UPk4yoqTUCTrIh+L+slGCIVVgu8G0QE5rzHVtZ5t6EVUciQ8sklImjMqvgmHn5I4sXjRaiVOATzIiMV+GAWEd66rAyCZHmJdeQ6Yn+XrLNW8tRs9E8LrJ3vbJSvrtSaMJ+7UJd9IFAb9z8TgM5zlv65s762wOfhsjeva05TrU6HXYFwwho3g94EfiZ1rb2SZ/0CUjKTNS0qHyEGO20wVltLzL7dJ4NIuR6RVrQPYxSEbvnwcAnpdGLSOpjOZMB7qPcdjWL4EH+zLyao/ixNq1+CDZyELaeTiGIJZ2VlK6YGx4+2hszx77eEgsFYrIvIiB4cAh2ebNvhqXKrDC9ofpvRl8UTYDV/bBxZuUIhx7g7JGK8eh9ja6zzRkJ09aCw1ISajZD7++7b6zmqj17PqPO4t6GU8+Mu16aAvM7JEESdEpcyh8FDiG6K+cAY6ymCKQXZfsc7SfQ4Mjuvm/xbEOlo3mtCynV+HQvLcL+bdfu4FRpAQpIrcfuhsrHUxSXwVKz8iAOBX+5bKrkqam9Usui5hPrIUPSZQn8KE4jVLAteOS6uqxMLnUKRjuWG3VI/H7wj3sWz4dmYoX7SFrOSkeQUbTpg4bcu6fYbi263ORhevpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(52116002)(316002)(4326008)(83380400001)(66946007)(478600001)(66556008)(110136005)(54906003)(8676002)(186003)(66476007)(6486002)(26005)(6506007)(6512007)(2616005)(6666004)(1076003)(38350700002)(38100700002)(5660300002)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9jh+SgG9exosHxb7pcsbKogVUwx2hGcwMYXYGwQyF1ZfB1UPKywmixJdiE4?=
 =?us-ascii?Q?UFWZxLJhkFv6+iAZEgxPwJ1gkqqz+HF47scmVv7UZK89m6CItbQP97wT3jEi?=
 =?us-ascii?Q?mZnavFHFjK2/bJb2ZKdoF9xVrx5XzuGRpYAQkNPzmNDMlNnGAy9AoBonzvOY?=
 =?us-ascii?Q?uB6fc8QFXq9pACR2NF+BzXL5xbqcgv93WVHr8atJG7IZF6VT7Ihx1YbJyBMG?=
 =?us-ascii?Q?+BkN6eTqoA2hMtdTcbVTZWmBwURyLXr85e1FHcAdke54bK4W7Xof1MVUINmv?=
 =?us-ascii?Q?MlGlx9POmooXe98AHReClHkRBl7w3/MrW53SVH4ydMV1YvG/Tw7d6Gu3WvQf?=
 =?us-ascii?Q?AmHs1GWnkzJJi1M/SwVTGEGedOhqrBckPtHhbIdcjFJixfguPZCRp+FYZn/O?=
 =?us-ascii?Q?gxAUIiFQO8eFb4wJpFEFJmTQO/xLuNoEKv3x+07EDAvQcwaRwZDNSOWqzbvm?=
 =?us-ascii?Q?e9+oxogd4OJ7+VLjnPpDduRajgyAM84cF0i+4qm3oykBtBErE80PTkYpEKQP?=
 =?us-ascii?Q?PZcR/FaIbrKZm8soMnuO7xav8TRpCbTRwa12dcTKazRkwXLcjKLVvCUhFeZE?=
 =?us-ascii?Q?tYGHSBXwpyqha/1jf8rYTurkTYS9cUdAdn4S0l3x5fjNH9+yAGfmZbSlWA7h?=
 =?us-ascii?Q?Wsw7qEgXqF2fLxyAE6WaSm0cSD2YAQRfQnWPDVhTNomQqX50b8z4bhAOFPMC?=
 =?us-ascii?Q?NETRsA9FATBlaoFhUwRSNsep90pOXD7IFNscZ60fhzwSs45d3kSMvyQo0NMH?=
 =?us-ascii?Q?BjnZgGHb1C3aawzPha66XBakvPbIIkvtk7jZkv2iTyY0Xvux2y4LchfmbAgn?=
 =?us-ascii?Q?9mpeqInCijn1akSxq1IhxDALOShfu5IJjg/8EgcuBThDiiwzTvSh0IpVkaEZ?=
 =?us-ascii?Q?4lM9x3mhkMjzZPGbZRlsiYhakCEQ691stsTIdrvSfOXnS1CkmHOuqs4on1In?=
 =?us-ascii?Q?dYQ5zN13uSPZF/jI51whzQxM5Eq4iT85aEn4w7eEHT1rreMwxscTNROTL7sW?=
 =?us-ascii?Q?UIXX4IbWEk9XGoNW45RZvxlQ9qwM2AdhMcRIJZ43tZKimj0B6UqlKF3Bodd8?=
 =?us-ascii?Q?SP4UpD/qd9CnsPWxAqougE2hPLH6/t0j0vJNrRW/aubuW+1NSKQtdqyw27LX?=
 =?us-ascii?Q?v05qF1JihDDirLCK3deq4J21OHdNXV//2RoDjApWTJJ2kX9t/EP6Ho/40/eh?=
 =?us-ascii?Q?IcQWwbBI0AEmMQG4NuLH+pNmb15RWaH451c724/eL9fnkEUc63kYdTOnY8X9?=
 =?us-ascii?Q?ITUGl/+/VlhJ7CbRJ5sKEG0ki+81VJGZEddRIDcenc1t9h7EyoB9ar/TYfo0?=
 =?us-ascii?Q?A95RWiWqba2PnPhqscB+ERi4qK+Pht25SdlEL6SGJ636qHu0t/9lU3EkmosC?=
 =?us-ascii?Q?i0ffNdlfXI3EdcOZfPWs+K0wyiPuoSK4YvxRoQ4uh4RArX5ivNe4ErlgM6ls?=
 =?us-ascii?Q?CHv0Y49Fhu7XPyTu7ECTFNMxLiJG6GQiMRZPxZ1BeBGz48wRiF5k8jgSGsvQ?=
 =?us-ascii?Q?mI2ZFfB/BFwqgwKvbVOxzk2qjMxqXpLPz+f1g4kf/2zwo8rCYAU/dZ2ktHz7?=
 =?us-ascii?Q?4PqeAR6xDVqHxEulKxGA+zIO941nYMLuDxGQTRBz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feda5d6a-c008-4f4c-0b8b-08db29739856
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:47:45.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FGC51j7KVLLFcNxOoe3ciV7Di2ri5lcCQqycldo3uXBpNOeD1akGplzyvJuPVUwBmY1cr3Hs8a/7dMVWbh4mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4121
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
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/sysfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9ddc6ee19433..b455afc12cfc 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1478,14 +1478,11 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 
-	kobject_del(&sbi->s_stat_kobj);
-	kobject_put(&sbi->s_stat_kobj);
+	kobject_del_and_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
-	kobject_del(&sbi->s_feature_list_kobj);
-	kobject_put(&sbi->s_feature_list_kobj);
+	kobject_del_and_put(&sbi->s_feature_list_kobj);
 	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
+	kobject_del_and_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
 }
-- 
2.35.1

