Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47574837B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGELtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjGELtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:49:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C273CE6E;
        Wed,  5 Jul 2023 04:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwtEzIe+sE0kwlWkKxPfU+vIm0D/voTtkQbWBoUa72QmN4rygzh8qFr3wQxM3maI6eh+SGBjq+0DXwKa5ej7wMzGp8xE5vxHj2YtxWVaD1PtBLkaJ+0brYHrM2TxtBMZ92YhjklLcwSL4/U7s7MwfYh0XMzg+SikFo2npHhgdecRpwxMZuUGtqeYqBwySLLbYSpy6BpDqTQkcjLzlBQQEGBsjp23/jlIjccdhmYcsVMrcZTQ4EbL0cyBMYML1tIY9j5tdgAL9M8IR2Ag20lO5QpckKMB4BwxAA09pUZq7FNlaEEIlnqgQPuKdKYK0rOuimzLEPTUcIVuKNf5jHXIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHtOPpeP9wbxVI/F+1cMeaMiMg7zyY5JnI0XNF2i/DI=;
 b=ARyGlH38aHwA2NK6uOT7aFsMk9hpMEMd50blkAd/EJ8UO/T7mql17Hv0gpTQpgBl7mfuzYfclnLVksEut8tafdRWkEFv3FwiMGgE7ooYK0TEC9AHIfzzTezXxB/Flrxtb7mx3KAj/7lt+g6fSF72+qU8RNNCOHmAZC1ZQBLVw8O+5R/jwHl/9ZWslBvStQRJWI3Foi9S3WIEzVqePQy/AUTMjNecX1qarnxOZEy2coKYVxKMiaaHhf/2bYXgIyaJGcUugudVNQe9MMtogrU2Nushx05g/cyYoMPkk/EnScfE0BjyYytrGQBAQzO1NzIFgt6xoMWdrDiJblzXJgFUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHtOPpeP9wbxVI/F+1cMeaMiMg7zyY5JnI0XNF2i/DI=;
 b=JLVAbe6Hfq7ePzSnYu9K8slIXwoN/kYUzgw9lD6aokPtiSCI9aWWddcJeaBhgDlJQvVA0MD+CNLqxa430YyZEzesybQzwjc3z0ylYp/ZfZvLiiPbN6hl2lM9Uh5nlbJQ6kfxN1/ZJzqiMcxUoG1rNgrJJVWiLNB9tpjsO2U+a5cptp+B06jqgBiZAc/BwNce7TYDBA49vl2DqQJVzc9wwU6r4JaM7CzWX+JIj3vixPV3sgozB7aOgNNsOAhNROAAPi04Y/YGRtMvfZKBfUPl+QapZ/98jdYca1zdFHhXjVsT+IpGxEYoNNRLLCdpSUn3fNmD7P4PLsIi+EGpMI1owQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SI2PR06MB4139.apcprd06.prod.outlook.com (2603:1096:4:fb::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Wed, 5 Jul 2023 11:49:43 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 11:49:43 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Markus.Elfring@web.de,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Minjie Du <duminjie@vivo.com>,
        linux-wireless@vger.kernel.org (open list:INTEL WIRELESS WIFI LINK
        (iwlwifi)), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] wifi: iwlwifi: Remove a duplicate assignment in iwl_dbgfs_amsdu_len_write()
Date:   Wed,  5 Jul 2023 19:49:34 +0800
Message-Id: <20230705114934.16523-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:404:f6::22) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SI2PR06MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ba11cc-e259-478d-77a2-08db7d4dec6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUTZ38OsWk9DX63shZtTVSFENairG9ZFWNYuFlAMqLyNt9n9076CZCqiVNQe1Y7Jb7TX/8fNDlfBU/SBu+ZQNKPxeTFbNzN3wvsoCtt4T6i34qpSK0Q0Cs0o1PMl+eWZ8RRlmMTyp7xVlXTJ1BCpz3a+gOSucG5lQ57VXNDPs1N1YG+QWnvLk1JH6QmbjwcrQzgXayaQPfSWyysaOIPqeCRH48AZbWxNIW1BUWBnYaOCJs9a8j32evaUt/m+I3XctSoQJ0Qq5hElJN9TN0VLxik0+FhPN5oQJAFf/5ndLOeJ9HxWYP8ybL78jp6WHvcxPO8jN9o7vmzsRz4gpODXkGG7Zkcf3GMsH4O3hbFv7KAEIXG4UTDEydTMrloZdC6VUq+ZklcrYuHe1h2xA8Eu8SUw5h7MMDx58xtQZC+azsP314E2t0FOXbqUoZRNLjInxzYFBarRtI0TN5TryHBSnvIHAJJex7mBLTyLB9xmbKbHtukU49TD+9AGQQOvJpfR+/9DIf2oX+BafciMINWnBuNGTwmgbXHRTLgQyyDohlqT7k/RxQvti4ONp2VBJPI8OGIhhZsKmw13MXldpwLFHFloUJ7OYb6hy400eB/EMbwEd8h6W6xXX/zDgzQ/LAxp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(107886003)(86362001)(8676002)(5660300002)(110136005)(8936002)(26005)(6506007)(1076003)(52116002)(478600001)(186003)(6486002)(6512007)(66476007)(6666004)(66946007)(316002)(4326008)(66556008)(41300700001)(2616005)(4744005)(2906002)(83380400001)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5mOm73etzpfHzaRrW56McHtRRxdieaTrO+fVKt0WVPytNBZ29NXc6RjvGW6k?=
 =?us-ascii?Q?ZFES4jd0etvz1KJgF+NWiCwyDFe4bw7rBW9JSCt0aVUnpnIfh2XtmAI4bt2b?=
 =?us-ascii?Q?x5OKFD3R4Ht22m2oEXP0+bW+B/qaIaPlqpw/NfdGjwU9JwjSRvQER8GCpWnu?=
 =?us-ascii?Q?l2nBpYPmuRHmEzT8WO1Z2XiuayFJOu9K5jKnSQ1DTGk7xSDi/T5yWVRgaZ6N?=
 =?us-ascii?Q?n1Rb1VY0yge3q5EsS5zBUA3Xw4sCaAM+DH1lG1pCO3Y8/9CV2kpMFRL+XYOz?=
 =?us-ascii?Q?d2iWJsOjW+lOx5eGvL1FmZeJ2+YNvyz2tc3Z2AvQFtN4f92ev+Rrs2mzXTDk?=
 =?us-ascii?Q?UlLC/rt0app+8OCwKTyYD2t3fFt3kUJbQm6Jsu52KG7dn33ZZ0n50txCfknM?=
 =?us-ascii?Q?LH3ixeF5vtJFW86Jr0fNtKhAHfPQso5mHvDjOc2HF7dglXs9a5Drm29f+FtZ?=
 =?us-ascii?Q?D2nKNObClNEmRkXRL923hy2feJeG8qXSFe8FG0JoMyz8XCiFlWY7/UgYQzpb?=
 =?us-ascii?Q?Ves1QieZiEE5ggzoeFXGdgDSgVACNePCmL/pihDbCxcd76GZqOj2HW3P5Z6d?=
 =?us-ascii?Q?d0Raxj6slgChNxPIF1E6+LzQB1HM+e1PUVr0O1O0WHpoTpfi8PaB0Qd5x3wo?=
 =?us-ascii?Q?MitLB9ZtUi6/DDaD7MI04Wr5spHo49sVvbOmbCaPIakuyZXFai1VcIBLaPoT?=
 =?us-ascii?Q?ZAn/5FFg25YOTveQxgeXX6viHKSLfzS8Vyb3ooZdfbN9X8KB26a/uTnMvUb3?=
 =?us-ascii?Q?oAZxdBLWlm2HlruERjyTCQNiOuuHnvK8tPNX/3mKJ9zgY7xlpdQdG6VQnuv8?=
 =?us-ascii?Q?mgRg+0bnCT03BVB0vBO9mv13AXZeFx1gXQEEfu2YPPpov6sBSNaC7nm3HpHa?=
 =?us-ascii?Q?jVYJ8XeqtKDMPKBs9HfPu74UKIzP2hygft6mAUUTA4Dq5kHe0V64o/OZjW9g?=
 =?us-ascii?Q?1kbbN1tSfe1IQ9hB6lKJ+fbxNXwoZfLNk94OOplMXYwWKYTT8dojmqE5Mbpb?=
 =?us-ascii?Q?sAqBzPoop42SvQ1fi+jua9i80rLc/QLmbr3mrI4ijinPiHiMwIJUvdHDh6jK?=
 =?us-ascii?Q?+J1NHoHwjgQnBleLSh33FnnJu/TZMbLnNR4CJeLuogwYFCODWSGLmEhAKijo?=
 =?us-ascii?Q?VYisxMLJ5hCTpVAMvRfzStXiuTme/oC8UVHGK5k3lGHaOWNW4ToRxG9xQFwM?=
 =?us-ascii?Q?mx/uzoqXGpByPAHWjh9LL1idID6GfERli2xXvhplyhRn6DfaO2HOXhB1njz8?=
 =?us-ascii?Q?Wy//wd6dZ9Or/AqQxhRvJCVmP6DX/F/PInNAIVkl9z+wvf5TZz3pvuvI7vbw?=
 =?us-ascii?Q?gsMkjEWjUkkHGD4oqq2eMl1I39tJiUBbIsXD8yQ0+RTTUTtTdNxH8mQCs1Qf?=
 =?us-ascii?Q?JT5PSU1VJJyLC50rsCwChusJ3bODWhW6hHcBlh3FrSEPrfQHwnwJ7kFkdjHp?=
 =?us-ascii?Q?a+uV1mkam44tKZp5k34O1tdEk3Fo7yzBzhVFJtkuNeepB6IlZeg0mvicES2K?=
 =?us-ascii?Q?1Bc9SpD2VePl3luKsIRzHQ4zW/YgvTZtEfjH0cct+gseXK90YjGo/eoRnyQs?=
 =?us-ascii?Q?kKQzsVjwK8GHdBqVlpBz98DJum+nlRjIBuoUeljh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ba11cc-e259-478d-77a2-08db7d4dec6f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 11:49:43.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pubLkWZV5qxziOnL4Mf5c4Am4+c6IY9dERhIrSbFSZVf8svabo7HGI0e1oz+Ue9tsROjyd07/KD9OCThrcnag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete a duplicate statement from this function implementation.

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

