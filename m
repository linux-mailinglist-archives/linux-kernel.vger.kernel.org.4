Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404B8747D26
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGEGej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGEGei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:34:38 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A02B10CF;
        Tue,  4 Jul 2023 23:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dwh7hXateh5b/XxVmJ+ys6w8YGvZ/0Q5uF1wNyD2lf2PSlO1OvE46/vyoL4VItTlv9AtLSUaFvBxa6UwjbF+u1VqVEawpC8rSyCPUPbMybu1HesQLYBHRx5vypODiF854rUMvl0qOYdYBRVzkn6Ot3dXdU50iD8hWtD0vPh4OHA4mceXqev+5i3z7/m56SEyVm3wQDz03L9e2LVnM8NfC03nsrcKt+cuxEreUNHiIYGFHgQdxf7wmxm38WFjv/qMMmGhKkI5H1kgIJNo3jurcktTW+IxcQSnDLQZuW7nrKdwo5smtR97KSpS5w+o9cOQvTZvD1gQ23yc6Lt8jCC7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb6535+fUGVvBL7oEdNU/9nDLCsR/CsAQ4SW0TE0nLs=;
 b=UnHr5a76mKWbRd5LRT3FthhSqTsX3FwMK/A8wlMqmH/TuRlvHWd5H6iANvxFh42xzNrxE3wnqsSTSOxMXyZ9z7BjffCYkmZl/G3iHbkrKVbWPjGrIOLAxgkPtwdjtURH7lc6lX+S6JLwmm6xbusDck1HfzEc9X73DgeISe8B0lbWn9uMZ1u8/1nkJk4DIU1JStwiqAs7D6VdVNt5al/sAe21RIlsubernkW584ul1X2Ar1udHWke84OHl08GTNlpxdBU+DZy49g5YgfBE0HxtXy1eYVd7OtUeDj1C/9GdN01YgYskHglXCZkHao09Xad45Gwz6TzieCul2x3Zorm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb6535+fUGVvBL7oEdNU/9nDLCsR/CsAQ4SW0TE0nLs=;
 b=A1TACPf5eNBFFYyVhSlC+rIUpsciIta+tr7twJU9qvJnbMmJRY36S3/Sng6APr68nlL0oTVKPJ5WjTIdoHehwY6NOeTdeSSF48T7BwZ3GNHa10iCfGzddRujsUUpLCljnXK2th8wTgV8aiJqBPtdIhgWB6ij33oTPT96Ve2fW9RCiK1hZufgTLUvawEHiK9fu4RJ/Hxm9CbIjS8GVq4YllRmvNLdabxwbyFWxYWSOYsF9ftPapw/EY4sDT62COkxA+hx3GdE8le4YAbmbhtQBkO7c50izQx0/nckfl5tjGdSOmH0p6otLcN9YT4JsPh0+kxL5tyBrNmz4Sr3EAscJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5482.apcprd06.prod.outlook.com (2603:1096:400:287::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:34:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:34:32 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Minjie Du <duminjie@vivo.com>,
        linux-wireless@vger.kernel.org (open list:INTEL WIRELESS WIFI LINK
        (iwlwifi)), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] drivers: mvm: remove duplicate assignments
Date:   Wed,  5 Jul 2023 14:34:21 +0800
Message-Id: <20230705063421.9827-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: f88ba19f-ee93-49b5-2cb8-08db7d21e413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMX07JSMFPb70DODz/Fuzmxy1AuSklt95+QFqezkh1UQopIF8bbHhDnbTbcsCpNnKBzY6zfqqwzDXFOZyqOuuvLqcqBBLcCR1plsnaPbb26c+dCij/+4a4qgKyEvG+jxKB0ZTgwPt3GCIZxYH3bklo/O3q3fRhGCCDw+jD86rvqBexY4CvtXOUGHkJm36eldtRmBST6rK+hHW/VLS9TQQGpAnFVBntvulGwh5z398UyxM0NB/6cO0Q9ur3syejt52BI0nmdXt7bp3887Lm4m77JyT7xPQ9c73ZeNXOgyACjyn3cZD5DrnKCJPTBYSbGVGdSWFITj3XLAl/INiqOgEpxargZmZoBWify3A3PH4LKnTf/DAxaOLVGtfRIDVXosyMqXmp2DZRM47wiRam2ikQVrDFET1wRaXDk8WRkOUQUAp/6I/wrOZdbxsednLVZMmhd1/5/Tj0UJosUe8QndoCmgMd8sK3xpggfLywz/PpeKFTPo3CRYcyjNxrMBcol3qoalIF2WoTRWo72ZvfkeRqZ8kulTC1ymNtSEfWZQM6HVJV++ZDwQEpU97QYaDc8RxrWuOvB1VVKq9xIEJlMpOY/ATdENFrBHwv5k0kRH8SlpRhjAkdNjwJAVFPwszYFI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39850400004)(451199021)(26005)(478600001)(1076003)(6666004)(6512007)(6506007)(107886003)(86362001)(2616005)(186003)(38350700002)(38100700002)(66476007)(4326008)(66946007)(66556008)(83380400001)(110136005)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(4744005)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GW9isPRQpQVFs9fL4odG4ssJPNDXPC3UOW/BFaNuvLSgyAgifwNNn4NeAFOv?=
 =?us-ascii?Q?vZz1765RmsFoG8diXjr9V95iG88sNi+fdZklLLL+jjU2OJ5gRAagYQPui4u9?=
 =?us-ascii?Q?7abOBh6OE36Z/pgPQUParvKmR8tZFNkkBbV/rGAx630W/aQCDBi1WyQPkM23?=
 =?us-ascii?Q?L58VoilsK7eezYz6H5fiDjLn7OsEzxWRtkcF9NriSdTBC6HhL+sq5Q1v9HpL?=
 =?us-ascii?Q?yIG5ThcKylgUXgn0sqmwb2VyEBHZHHS26mdVplY7h26Lp0JfqOmfp+nqWCAg?=
 =?us-ascii?Q?5/PsaIOJC8nxdrvovonVzzrB36h9cN1FK12H1bg9dDAKG8komppIuw/Ol/Y8?=
 =?us-ascii?Q?a3FtDynmq56YzEQMDlELWw+m+jwffR/uJD09GWO0LLHjnJSNGS8/y1LEEIg8?=
 =?us-ascii?Q?0GofwFpB3LCpiF1dxPP6qLxKYpIaCwEwMRuXKPLjKBjFIlZkisVfZuiH5Us9?=
 =?us-ascii?Q?m7NTbxgHKF0PGK1BWbF3w8eCnQwC7tSjYz90WuSvvkUO72lJYlpgzHf3spy+?=
 =?us-ascii?Q?aksRUNimDD9huQHyqtcAkoPoOed9wa1Vyr1pK6u5WvsnoiJLVRhQ5sQiCxxB?=
 =?us-ascii?Q?lrHhUHQsjINmv++YrRSYAKldx0Bc8mFaX/AoMkea/9jX36ritRRO1fvib3P9?=
 =?us-ascii?Q?75BDnHHUbrCG+JZ10HQYbij64jVuMR8Zi7YCpsCmtqILyRSP30E5xheLoKyf?=
 =?us-ascii?Q?nGZJgbHt0AmIXwxfn8bK2KR5rGLW6km7wZzMZ3HZ27izBT83bkw7hngAOPMb?=
 =?us-ascii?Q?9KjqD7lEsk89C9RLV4isl1blXf0OKO3VRiKErk9mZEDs4jYzQJDcHtuprYmz?=
 =?us-ascii?Q?8XezIdMawlkwYKbQSQes2wAO91MimY0iHnlfDD029frr05kaKubGAsEngKEX?=
 =?us-ascii?Q?D3pOlRywP6TpOKozqS3Uy2gxJdBT8kykvYErZof1jWnLrPEKUYbntRKN0m6t?=
 =?us-ascii?Q?JM/7OiRLNbOpbAKZdyF04g6f8Of/eKpUs3TjR+XLYlaIWmsoDo5W86pFfUpw?=
 =?us-ascii?Q?c3INNudVq7KpzdisNtY8P3wux1IEtUi+PbLAGUwsxdkKb+7QULc+Jgk0MpE/?=
 =?us-ascii?Q?k4FUGFtNBe322YArpg2eyF9odq9HzW+q676dcj1cORNqV18A0XVzB8SaEnMy?=
 =?us-ascii?Q?ABYAXcJuBHxB+qZFAKYfZVNW1LoJ74xe6xIpjk0aesQA0WM6R96TVnwshw7Z?=
 =?us-ascii?Q?YJ8N5pIA5Z+SVHbkDJ4+mdioAhsFfN0Lso6m9DNXgioQE7TVAEuI9RIeFTgp?=
 =?us-ascii?Q?wf4WdDpDP2PxhoitC7J6hpXZ38KEk3S+ZRVQ01lcDYCD8qH24Z/ebjyL7KMQ?=
 =?us-ascii?Q?jorAQ9Gd5ThppHG1CMkvn5ChrNV+K7hLMr3/pym8q/4D8VGy1049OynaRlJp?=
 =?us-ascii?Q?q7RBdPI5znnM8fNG3sfDhtsh4VjHZNVoS+qFdpa16Zp6lUJBWAF2C9qUPMWj?=
 =?us-ascii?Q?PxPGnn/6q9gTuy+Xv+OxxZpqmP1iPoD56J1NiLUiVB5DQvhanHDv+yJ+rKR9?=
 =?us-ascii?Q?1Lfjgw5+C/gupEShmDO3aR00LKfJxrMNSdI5uifkUNXJ9WgmE0PI+wce3VOh?=
 =?us-ascii?Q?Eejzi/LOS1HoWTumbbXF63nFkeASaHbxD8FIBuga?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88ba19f-ee93-49b5-2cb8-08db7d21e413
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:34:31.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP/UicP2t7kRKgTRLEvWlFLywO29EM2YJ4p1LgiggQToURetDVfq/+apvY3Y/qXQSTVLL5JOK6ZlNktWWyuYLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make link_sta->agg.max_amsdu_len avoid double assignment.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index cf27f106d..7f48457a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -455,7 +455,6 @@ static ssize_t iwl_dbgfs_amsdu_len_write(struct ieee80211_link_sta *link_sta,
 	if (amsdu_len) {
 		mvm_link_sta->orig_amsdu_len = link_sta->agg.max_amsdu_len;
 		link_sta->agg.max_amsdu_len = amsdu_len;
-		link_sta->agg.max_amsdu_len = amsdu_len;
 		for (i = 0; i < ARRAY_SIZE(link_sta->agg.max_tid_amsdu_len); i++)
 			link_sta->agg.max_tid_amsdu_len[i] = amsdu_len;
 	} else {
-- 
2.39.0

