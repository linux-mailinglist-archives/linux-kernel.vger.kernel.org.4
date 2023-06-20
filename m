Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24448736247
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjFTDrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjFTDrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:47:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEA11A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewydNPr4L22MSnRv1+GUj2OJ1VT1q+ZUvdpoitoqvQg4un6bdulb7dQuXjeADtU4czHZeFdZHKMZ0vuFPSGahx7M/TV/Kf+DOEKyrrmKwrZgAC7FrOABn/UdjkXJfV4DcxHF174G4BWBQ91yyvCdpr1P1f35KgIv/mD9hOJerDUBHWh6FhE8Bb0x/EZrGqLyDTWjd5dLjAMtXLTxaLR90ze/CJGrLnLnj8SeipPvmq1bocWm3L9V80Lx921NKLuW6GT7GPK80mKqy+NAQRl06YF67XaxHSxixQWJIsUib3VVkaOU8C4CguWWhejJtNjL6eb08/jXfNCDQcKIDlQLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW06/Zogg/Ej08Vvz+0zpacLfC0O424UJjJqGG6NKTw=;
 b=ZLB6/KPYrjUiBq6sXXanBz6vVySAllUxAbjtfKen/9dyf0E0fQD5HKIrZLj0o9RTZMRdRQdFx+l9eW5rszT5J8ktqKqD4FsEl56SVhujr1NrNnSgCnXPWCmssT7STC05uTHifO9BvgHRwokjd16BUTp0l3rgtd/CrtahUoEzyVuy+CdiWU2zTtnRPWBElHZaUx6rivknaIYJyT8tMZNqHAukHTAw8StEKlqiMOgzMYW3I055AUUHxdIMIR/HIwRAn2WLFgRQXh6fpynUZhxMoq0XiE4XnZgZJ+DrHeZqPIi5aReg3oy0vDej/jQfzK5D0AfHskDtFThwg6cjFRORIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW06/Zogg/Ej08Vvz+0zpacLfC0O424UJjJqGG6NKTw=;
 b=KlaGFGZ5lKwWtXUE//o0B4ww7NyCG1Tg6eKovLRdb7Us5cLjT8JVLFI08BBbwTZl8FhIXEu5TvyhHdRHA0y8vy+zX3N8r0+b8nY45UzQ5zdwAc2cEficpl+JTL1Yn7oSZ4cXbQKS1GOi7HcMOFGPlYr6rxW7XFDqtA0RCkERV5vKKyGuas89YR7knxgUc6EOaKc/jzNJGtBV0tDWJ2D/13lrO6OP1p0JPKij3hYoqfMPzHk2ME2CXfNBLG4Bp/8zKkbJMw1sc2rh9BhV8N4LTLiTPRUu8fSPNdpKSVzcZYXvZD72r0eUUiYE2DopFnEjjnTpDiThpgq2oia5oo3pow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com (2603:1096:101:48::5)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 03:47:05 +0000
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c]) by SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 03:47:04 +0000
From:   Li Dong <lidong@vivo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com (open list:GFS2 FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, lidong@vivo.com
Subject: [PATCH] fs: Fix bug in gfs2_freeze_func that can cause deadlock
Date:   Tue, 20 Jun 2023 11:38:39 +0800
Message-Id: <20230620033859.997-1-lidong@vivo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0006.jpnprd01.prod.outlook.com (2603:1096:405::18)
 To SEZPR06MB5022.apcprd06.prod.outlook.com (2603:1096:101:48::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5022:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 3541a7f7-2836-4c28-8b53-08db7141030b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5n4PUP63YtDBW4DL7Z8q99W13pWMzuxeA5RsZ1zwqbO+Oq1DswUCXcViqxtCfLmpiDYeTjFDdwrKZa/xEKitvAMHhYLP8R4f5NQpes+dbtm66Q0pHTrGWoixd+L7CmQ+eRarhnqLLHxBQm31aBez5zsfOozXMkVkB5i1zQgu0g9v0gaXBH3rR1SNb9Wco3R3IJ6eZL2r62kf7mu7mhRNWnDyuL39Rkg9+eZA4v+Wu4fypWx4+r1FN7FvJHYYsfNZhwJpiZrwiSPLQkysT/LM4101uMfnenoz0bScDgJ4DAsbOFrsaAX2EWW7nESx94giaq1DnATEawAzljkJPZe88OlJAHO+w2K3ePuGTXKcV8MYzqHSPHAVKhfKrzZ7EqS3XEFAiBF2jlc6BpnAcbdKYj3HCnrn4qOzBknqlXam8wk4A7LH+a3aKkfO+oAcYPFmd0cXvVBw7Kf1JAJg91BcssnR4LTLi6td2xx9U8AHG9Veumw5h2R6fvdFWLlj5G3G2doXju8f+EE3B1jNOGMb4q2x33+NdeZ1kJG10XGilMURnfOuofgVTNENwGaN3eLTv8k66G72BFOQBXyjbJgmKood1DRDxw30fULWePTQBBNl43pdoWOWqiTToq0bZZ4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5022.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(5660300002)(66946007)(4326008)(66476007)(66556008)(1076003)(316002)(36756003)(4744005)(2906002)(8676002)(8936002)(41300700001)(6486002)(110136005)(86362001)(478600001)(38350700002)(38100700002)(6666004)(6506007)(186003)(107886003)(6512007)(26005)(83380400001)(52116002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVVQUFdLeWVrS1J2MlRrcEtDSFVOYnJaMFU5SnJ0ZjRaMWpudVhuQ01RUkM3?=
 =?utf-8?B?T1F2aEtWYzNORFVYVkJweHh2WTB3TFZxN1Z6SzdBMUVmc2pzY21GT2NZS1ZG?=
 =?utf-8?B?ZjNMdEtqZ2xaMUlDT3hmM1ZSRHFWSHpCZERsNU1jbmNKMTFTMHVnemhJZW1p?=
 =?utf-8?B?ZWppZElnODRCUUtpejRpZnNyL1V2T3VTRFBZQVptcnpxNjlLcjk4eUlwdWh5?=
 =?utf-8?B?TzBaTWpOY0gwa09ZVjdHejBrN3dZQzhZREJyRmlXZm5mekdpSVVNN0pOeFJF?=
 =?utf-8?B?WU8yYzY1amo2dEV3NTZHWU5uN3VJaE5ibWFDVytuRGc0V2Z2Nmd0ZXRTVGYw?=
 =?utf-8?B?cmdON2pTM2N6L0kxTzhQOFE1cDBEQkc3dUdBMElraUxYZjJDdWE1SW1RYm4v?=
 =?utf-8?B?aW1aU29DWDFmT3FaL0xvbUJ2S3paRjl3WnVxd2JzelF6NHlMZEpIMm5nVUVn?=
 =?utf-8?B?YlYxc0oxdXB6TzFzQ2gvdnFzcEZ3MzRlcU1ud1V6cFlycmhTVEd4SFBwUEln?=
 =?utf-8?B?R3NnZDFkTVVsdFFLMXNIRXRZSU5xcVlXL203QWVHM3RIa3hUcEJub3dsTnpy?=
 =?utf-8?B?c295amU1T2ozTVF6SnM4czlQdlRob1VIeUtmL3FCK2hkK1MrRHVCRURFWTFO?=
 =?utf-8?B?ZVIzRkhab2pLd29iMkljSDN4MHhPM3UxaVB0aU9LNnVLSFRkODBBUkdYTHpn?=
 =?utf-8?B?WE9MV0l4Ym11R1NCektwTURsamk2SHVaMEtuVXRqc0EzeTZCejlqekdyMmFH?=
 =?utf-8?B?dnQxc3FyY1BUYmo1bTUwWFNXaEg3N2pYMjMrVnpyT1F1Wmo0aU9yUGxSVnlo?=
 =?utf-8?B?M2Ftb3BvTTNxdmN2bHo3emtqRmJjeHZPVFQxb280ODZQVEZhNTk4dDBzS2dY?=
 =?utf-8?B?RXZQMktmMkhqQ2dGSzh3emFTSEtnYzQ1NXN6SnBaR3hZVUo5S0cwVmdtT1RF?=
 =?utf-8?B?dmVWY1ZlUnBxeXA3b1ZvNlF4UjU3UUlodnZHVjBxS3lHaWpGWTluRVhuRG1Z?=
 =?utf-8?B?Z2hvV0Q5WW5NSkRFQVRCNUlGRE1jMGlZNTcrb3p0eDVvRERvZFVkTVdzS2Jm?=
 =?utf-8?B?SGxYOWlTY1k0bm5wNkZ2blB2dnVIYTg1c0c5azZOTWx2b0UwRlZueDVKMHZM?=
 =?utf-8?B?THp1UnNBWnIrK1lGODh6bENFSVkreFg2aWlORkYzVS9BbDhjUjFER0REV3FC?=
 =?utf-8?B?eWhQTUlWZ3dmcnAxQklGRXl0cG5Dek1ydjUrUjhnOGMyUlZuMjFVTWZHNEM2?=
 =?utf-8?B?Z0tiNldibWIrOHBpejBINzhZL2EzazBKUnJNcldNT1FvVUJSTlRWRXZlMlov?=
 =?utf-8?B?bEJnNGRhNWtJaXdBN3lNc1BlY2I2MG9NdXJQazJUUHRvOW4rZ1g2YzlodXpJ?=
 =?utf-8?B?c0ZRaldScTVJUUZaVGw3YXBrZk5xK0RDOE00K2NBNlZDc1BQRnVYNHU0dU41?=
 =?utf-8?B?b1RqQlV1R1lTSHRFUTQ1ZzU2ODl3NnpiU0J0RG9meHVoY083L1BGNVhhM1hO?=
 =?utf-8?B?WXcvd280Sk51aVdUTmpBbnE4T1NoVkQ0eThudW1xcG9tZko1NVBYRXlsbDVa?=
 =?utf-8?B?MDdTRTNQMDBaK3FqUjZMQW5acFpTVXo4Nk92MWpBeTk5RlFjUnNNaFFYRjZG?=
 =?utf-8?B?THZzNjFvd0RSc2FmR3pxQWdEUENndFhJcnRMcVdRVk5VUW5UUU9rZndLQyt5?=
 =?utf-8?B?REhLM2xURWZVMUdNSzNMRVJwcUVvWHNLRjQ1WjQ3aVdDQ25lV3NsZHJ6eUZP?=
 =?utf-8?B?NkkrcHBaWTVLK0dEblN4WDEwZDBTaTdJMXZxeWw1bVoxbDNKSzdNNGRhMCtT?=
 =?utf-8?B?c2xYblc0dHhRVTI4N3E1UGFrejFFRkhzenRZN1FkU3NQOTlTZ0FUWGxhVlZD?=
 =?utf-8?B?ZCtZYVJXZDlmK2xtaVpORzZWa1IxZVdHYnQ4TzBSNmNVMU9BWUZQclpBcUwr?=
 =?utf-8?B?MVNqQmZGTkFOY3EvMWx5eThRYlFtS0VDeWUwa0NPQks0bDFpMlNXNXZxbnRh?=
 =?utf-8?B?aG9UaGIzR01XeVZ0MkpINjY2akphci9zamlBV1JDZW9KWmQ3a2hid2g1NUlY?=
 =?utf-8?B?WWVaVXZybHhwR29MOFUrbFN4VmlIa2VKSnNsQ0NlMUNpL0tVTlJtdllvVlRl?=
 =?utf-8?Q?Jm6UavRba5lsVh23/pSpDuLOF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3541a7f7-2836-4c28-8b53-08db7141030b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5022.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 03:47:04.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAIcxzaQpuKC6+YJnZtd05nyyvrN60nRBkeAi0qxkBBb59koyg/CR1MowfXXrwUQNuexU9jX0FkvBFto61+xQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function gfs2_freeze_func causes a deadlock，because sd_freeze_mutex was
not released when return

Signed-off-by: Li Dong <lidong@vivo.com>
---
 fs/gfs2/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -741,8 +741,10 @@ void gfs2_freeze_func(struct work_struct *work)
 	set_bit(SDF_FROZEN, &sdp->sd_flags);
 
 	error = gfs2_do_thaw(sdp);
-	if (error)
+	if (error) {
+		mutex_unlock(&sdp->sd_freeze_mutex);
 		goto out;
+	}
 
 	clear_bit(SDF_FROZEN, &sdp->sd_flags);
 
-- 
2.31.1.windows.1

