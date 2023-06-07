Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0743726738
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjFGRZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFGRZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:25:29 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2109.outbound.protection.outlook.com [40.92.53.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E51FC2;
        Wed,  7 Jun 2023 10:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDUvLMgBaIcbe6GyY6XhEp+YzpaPP9wTG5rsCb2RGfutvyiy8amrMV4gYQp+hUpD/aDGoaDsLOj0gJdHeFppDGriij6fw4wDGTEcPSaO3y8dxq2Y32pJDIHjae0U3/pPKYxdAHrn8ung2Ys0CZ4IaRvUpQP2yFYr9HkWq4ATkKhVKY/8nzRocS1kXlEr+BrMIdvmoSj7aqb2CS1/MiMQBAhVBTqW4LKOvZW/ZIbo384Z9wCYeMCSdVQ8ZzdCPC4i8+sj2FyqO2jg7+l2YJi/SQ8C71lo69r5YAxOTcwqwqiUCLOU1tm1aY9J2WW9KrxuuPSfwnDd3d8VM31eiuJ8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2VKcwdIzZLSBE9XVzaQAJrkXkRY0virbAMOibGoB+4=;
 b=cQzIoGGPiWV9izkYk5NhaXtO9AbzMk3Io1sTj3rZshlkEy3OT8qpeHXq40kE+Y03VXMLbBm/fUmsw6cfP3Wh+5pZybSqO0Wqk8rmr77wuakv+lZGoHFow+WnLqmEF8Kjn/T+IjFoiu6VXvS1PFMrsEJth+u2pVfOybtFJOHqfUH9sLt7qDGqVoMpRsXt0sQPQP7HkcHV6eZwNCu6VTJrKunUMMXYxxbOfV38sDvfgSkgs+kzoab0Y8vgruw4zW80/5tXjZ7fGt4vmx7ar9xheNKrFV6Ni8GuP1tfMh4TTebmFKtkA8/xlLFqqRaHJONal7KiGEyI5w46/nRMeOVkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2VKcwdIzZLSBE9XVzaQAJrkXkRY0virbAMOibGoB+4=;
 b=bdsY1kap8R8QAvf/sM0G7TyIul+lDKeIWJ7scdr8kesmDGPlc1z9ZkoLb42p03aIjZC9ZNtKKcgblWaCd2jLR9OIdRR6VMOj+9Sb+PhHebsWyiK/LLmwfaw7HOkq1itT1n5JvkuaY/SRVtDMTdySNpd3P/ORFk22svhnrUjnFyxh1zO6UW8fiVwnF3GpzgI1qoZEV2xTXJCa/EXd9jxdCUgQC1XKbpY+/nekXkfftjqyON1XH/Pii8ekPUzDiDBwVZmVmEDcmMXfdHLViGXpd6ZQiknGW0AqaOvNSDJTSLy8whHFWS8VVNNUKXZ60FkzlobaYfxJYP2SXq+yCA+hKQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SI2PR01MB4396.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:25:06 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204%7]) with mapi id 15.20.6411.021; Wed, 7 Jun 2023
 17:25:06 +0000
From:   Ziyang Huang <hzyitc@outlook.com>
To:     kvalo@kernel.org
Cc:     quic_srirrama@quicinc.com, quic_kathirve@quicinc.com,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 2/3] wifi: ath11k: Restart firmware after cold boot calibration for IPQ5018
Date:   Wed,  7 Jun 2023 17:24:38 +0000
Message-ID: <TYZPR01MB55566969818BD4B49E770445C953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607172439.2258343-1-hzyitc@outlook.com>
References: <TYZPR01MB5556F7C9F8E5BB5F5E1C8770C953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <20230607172439.2258343-1-hzyitc@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [oTcwOAdqUETCwEmNZh5EpQkLpFB1DQkj3T5Dh3kx8vQ=]
X-ClientProxiedBy: PH7PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:510:174::10) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20230607172439.2258343-2-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SI2PR01MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2b2941-f850-44c3-ef49-08db677c228b
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKyrQfZcuz+zjlXZpgEjMWpep3TL2SFAz/CHNQ/wPfd+vbpOHMLPXfBmY59JVgkabY2C40ThEeanFPatU7qJ6E3NV7AWOeGENtWp/k3pjG16M48UuK+1nWcouXcb0dVJcv1i4d4Zyj2FolNeabs79eS714nVKqa6EuerAl+5U6ZBM0uyQy0nwpffBDFC04HjYC4oqDByUH0owxG+55bAmbqdClKB7wGWLN2J6WXjfg62rzsR5KJt3pZpp5W5qBpAOS1VuHl7WuEEd38CEGUGKI3AaOOR3XDW/RyEcOlWHg7W6itB509i9az1pPkS/pmnREDHE9UyWuEfptCLtofLgSpCyao+tmPim/wmGC6zmrA3NW3sLwEOISZ7nocT20HiFG29+TbcF4KkR/+qs3RFzIdPw8EsBAhv036MOv9IF1Omtt54nOCdsvpYsybLtCahuqZV8lM5o6JNc2AoXKBEwOTWdBoaSbpH6kuce2r2qaTNZvn0wPQYxK8jYkcfMeRGudFNL/bhi/Qaq2PgTkhj9T/w+QLsU8hIbbF6176ICIh9jE9hiRjZdfJ9XernY5CGM1YGLjj0qN89isS1KGt7ow3GeTyRPZ+VRSIdwzzdZxTpjapjJCtuhGP1ef4f5bwCNJy1wmgOd8PhUMgXI1FscTY7YHfI2PCtKWogfnATr1bA0Vav5V0d9/TdU2EFL9jpLxxFYMZiRgBZANpvCLmlCzPbOIOBPvW2FQ0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjMswBtLjtoUBwrsfsEuVGw9vaO9beiW1xzk8iWvNccWMf43JpLZ8qEJECq7sr6OJvWZwpkfLfy2MlmlUaTPkTVEr0wjVbuxwZ5m/aBzgDjb5vX63S+yGX7/YkqZGcd4GUS/HkEwKeDY6dqdBletzSkZhE3p6VcBLQn4byvr6eSbW56qrBT5neBaMluiDQs7jSYIUjE9J+Jeh+UUfbyGyNaFxIrremq39Xt9gOigAwV/7C5iVUdvMw9TdMRmPsieXREK+hRNtAex71J3WGFDSXl4C0qLgCu9OEeZMrmmmnR5Bfkh98UhMBZHXWzfEgwQZJjsvLMqkj+lRwjvqoQWQoPFa7/hbe82/UDVX1iwcG+turCMcebZYiLhFZyaCztfvXvFqsdVqzhqp58hBOetq/pp1WKRq2U98c71EHZMPGnvReCu6X+877HLcrrb02VE4+wOw1yk/HFs/i3vZAWrBFHOzGpKM2TWTtkRt6MQMtpew76aoioD3lAvRbtKjoAsR7Rg3Do3sESjKx6hChNQplulwXrISP916dkOQlMSt0CgGPC6oTa8TQEUr06CP/fBttVb5prOZN+syVNe+MSDXsCY5Og6ngKFAv+2LLVEomocC4oWmDSijrypUZ9bnWgv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Wwv5T+VR/Ozj2zn+s3QjZQ9MNxY1/cfQ4HhapCtCclXiU+tdPIQGI/7/MtY?=
 =?us-ascii?Q?s8W3xpbNtODgF3IRXt/v9diLJkGUgF4Vd2rJcTeYtbQpih45C+w4u1c5CxfX?=
 =?us-ascii?Q?XWBpbNE69wT1C5s6kzhvMA7Lz7xH3EPjPRimkk2SSI/IAH87I3TCbkPGLOo9?=
 =?us-ascii?Q?G/ahsurrVp6pUUTgaAhhFjujg9g4SQWBR0s31lIANvroYs5P7p+17n5y0piR?=
 =?us-ascii?Q?UUHgFj7NZqwFdUugGDhQhoQKM5dFP9Uv/WyGkhD7RmwNDlNi6omFHBlJDYV4?=
 =?us-ascii?Q?BQmavivxHgYYz7r92U4KNdW9HeTE3eO5JHvEs7aC+vShfgVMuZq+JqfFMv9g?=
 =?us-ascii?Q?Oj7lc06HI+jfhjl/zV0QMapZX4JgIDGDjBEkXpIeYJofoIDh/fzNCBxJjFfC?=
 =?us-ascii?Q?JQUI2XDuVvvq7BxA4ObScap7TmvG6y95Kb04VixE8hHUFESYzPhqVMP2OryC?=
 =?us-ascii?Q?5pMat1MU5410dbNnvGbn8rl0yHp2GE6pgO7Ej7ZZCXq77u4xVGR/wEkoW9Ji?=
 =?us-ascii?Q?lIum6j2tbyFEfZarfOuhAUzequHrgnn0t/0qvkuqGOttHLLaNnQw5NYf0OzX?=
 =?us-ascii?Q?yUO+YsZ1MsO0dUNj3EvLcSOEuslDQjQ9cyIyHcbzfrVY4Fg9RW/aJAiu3xTz?=
 =?us-ascii?Q?qbD8IQtuBEjlCUGiQl4hD1d4G78NlWMgXUtUrN/UlVTpzrV0P99Gw6prn9b/?=
 =?us-ascii?Q?BUq2TeK5Du3PY8mqk859ABYl6avYW7Eo3Lr6fQ92vducFQYaDudtaPPzQ1Ro?=
 =?us-ascii?Q?Ntsy7zfmu8pdMpE/k+7ostjo3Lz1Y0S5rsT7Pg9BdVqAN3YTRINnO6q+fAxK?=
 =?us-ascii?Q?TEZNiYVFld+5QK06jV6X82VFv01vcthu/++qX8dvdjxJXNG63huJ9ZoBXAxC?=
 =?us-ascii?Q?P+v/6xNoYedjAVFKQ3XKr/HfyIZueC5+0Vub98cClOTPr0bzyivIuGOUiXMs?=
 =?us-ascii?Q?PdsyxDhtFburCEnaAdV0xsuTfgoF1UJUfU7HfOTvl0T1rd5fJ0W6L6zH4C67?=
 =?us-ascii?Q?4lSTw78EwlTW77PfJY9bHr8d/xzFh6p0mt1QO8WCGUiIaeMoAjr6g1KIWzz+?=
 =?us-ascii?Q?QcY4FYDqY1pYurTPtT6o+z6msDU5rDuPRPVda7KCAeHSjvZXhy+ctKzCFWrP?=
 =?us-ascii?Q?xBRKr7QNQkKKHMlAgFazrQkpnIz7JThTKOCLeQKA5F31SBEF3xD1VeCW9y6N?=
 =?us-ascii?Q?A1tytisN/q+AUJjiqmqpaM6Lov9m3XAhZQQuIn87OHHq6RQTrC540sX1jro?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2b2941-f850-44c3-ef49-08db677c228b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:25:06.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restart is required after cold boot calibration on IPQ5018. Otherwise,
we get the following exception:

	[   14.412829] qcom-q6-mpd cd00000.remoteproc: fatal error received: err_smem_ver.2.1:
	[   14.412829] QC Image Version : QC_IMAGE_VERSION_STRING=WLAN.HK.2.6.0.1-00974-QCAHKSWPL_SILICONZ-1
	[   14.412829] Image Variant : IMAGE_VARIANT_STRING=5018.wlanfw2.map_spr_spr_evalQ
	[   14.412829] DALSysLogEvent.c:174 Assertion 0 failed param0 :zero,param1 :zero,param2 :zero
	[   14.412829] Thread ID : 0x00000048 Thread name : WLAN RT0 Process ID : 0x00000001 Process name :wlan0
	[   14.412829]
	[   14.412829] Registers:
	[   14.412829] SP : 0x4c81c120
	[   14.412829] FP : 0x4c81c138
	[   14.412829] PC : 0xb022c590
	[   14.412829] SSR : 0x00000000
	[   14.412829] BADVA : 0x00000000
	[   14.412829] LR : 0xb0008490
	[   14.412829]
	[   14.412829] StackDump
	[   14.412829] from:0x4c81c120
	[   14.412829] to: 0x00000000:
	[   14.412829]
	[   14.463006] remoteproc remoteproc0: crash detected in cd00000.remoteproc: type fatal error

Fixes: 8dfe875aa24a ("wifi: ath11k: update hw params for IPQ5018")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b1b90bd34d67..9de23c11e18b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -664,6 +664,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.single_pdev_only = false,
 		.cold_boot_calib = true,
+		.cbcal_restart_fw = true,
 		.fix_l1ss = true,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
-- 
2.25.1

