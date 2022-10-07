Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B655F7B99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJGQhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJGQhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:37:41 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B89DF8D;
        Fri,  7 Oct 2022 09:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS+eFXZbLjMgc7ZFhS+P5IiPLRJIIvVYcmGutATwKD7oIxcY1m8m55HZ5WFE0XMzxxsnc6O61bOKqk3aSyiXPFL3WfnZ4NT4PfcgbIBLgqw1r2di9OskHojPkopKCW7j55W45YSnSCawpvb6S8O0NlFOk03ollSC1crXR7TOln0b6Rpr6xchYrmz3GFTmPAeixi9TNf8JmU6GOL62ICaIflDZAYK3plT19nXGWtg0233b5PTybjRfQ6o2uBl1qy0KQLU0SSlc8BHQuwzK/TjVcx+lpGBetaCsbitCOBZHPIUnuL32GwS8V2+CTWSz5DR8HelRrSoKqiB7ycITCEDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iK38+iH4xamtSFva2bfOYvdNj11e6ybNsskM67+GnnA=;
 b=QY8zuMS/xhkGyKw6GSNr0g5WTbi78DjDW6CjiVXsdBs9mWLArwO1yMuPxuyX7LMlekiNdMfYh4uDSupeH+hDm6EY0kHeC68FeqECyjtUKzTqy2hom0AZQ2a8Zb1lvod89P8fdWriCuMJoKuvBQyK9977PfSDvBFkXDH+ZHW9lsDXyPB//0qpo4VFV7pD3+UpA9lxC5LFkdkv5whGvEsUBT7mFZYvGSlAYRg+LS2yUgNC71D/8Rr37G6+9wiRRoAfHe6iAgI1+zCy8apHeObDAl+g92W5QgvG026uRRHDcjk16VJBN4bcGG92nSI/LiIpNeAfsyoRhtCSLB5o4jxy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK38+iH4xamtSFva2bfOYvdNj11e6ybNsskM67+GnnA=;
 b=VGtj/T2u6+nIohQRiLvoN+7XogPY3i8Ltok5ZQU53k9isM2Ekdjb2wrTyZadFTlQAYbPQrfYf/rIV+Bzb79xvxWkrqdo1ohoIYY8ou8KfQZitMsHhw3JhuclBrH2HHANJeJ733QBuHywQXyNtOIrR8NsL0fGKVZz6mjj7V086xEFemmV3MnaTjTxZ/QxN8NAWwILVLg7R/lAmoMJ14L5Lig+X46DwKB9WQv1vopWNQdxJUaNCuQTGdz2Wq2bFHpAbQvIAXXs8RxE5L7pHfHv5SHAEGk92ZwLwBs61PRnfpF16Av117whLNpwVNKPuZ6J+uuXkEnlBmTQziQDJ/K2Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB9PR03MB7771.eurprd03.prod.outlook.com (2603:10a6:10:2ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Fri, 7 Oct
 2022 16:37:36 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d%6]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 16:37:36 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] rtc: abx80x: Don't warn about oscillator failure after PoR
Date:   Fri,  7 Oct 2022 12:37:12 -0400
Message-Id: <20221007163712.2193966-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|DB9PR03MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae47ece-2aec-47c8-d5f7-08daa8823d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5uaMjPJ3CwxBv+T/sAbJunu00ho5iGEaAinwQnd/ZX0T3LtTml64xB33YHVUVZoYbIcLyGxrmECnbcLXSe/8Jo7QNhGmXfpECwgi21lbgHCJBc5AKsKCuPy/W8uGypLj9VUkKiMVbX3bv3JzLwhDdvrccCGguCBOe22vbiGIjfw5exNVuYF3G9WsMeHf2dPaONjWHp0jh+sOfwM4SiKLmwGCUAiYgDjLNJ5KMVEcssLQAcnKL/lu+vlYbOzwyjS1uSWARH0+NGa2RwKii6sZCSPGOZkHdHjcI4FFeZu2qsLBBFiV9BLAJhFOg/t1fotGMYMwr9aYYgbrdYnlvcwDhFWGMKvIUkToWN4JAJggsHr56L5BzTYiYRO/74PAQgLqtToJJcTMg7OouzX6uNY6A4EsuDMM8i7/TMKkRa3LJeRWVOZt3P3+jQnAFv515n+GOZJMsMAojTGNsOcrPCkrYnm3SnLlz84NQ5zYVNALd39IJuqSWhXIv+K+xE7QEdYxyRhQ6G3jtRMpe14DTHNulQJTuZ7R4IrIC2qzsC/GvdhNG1z3Rhu8E/vlYtgQkAr2cDYXO2Cj8yknhYD0ADOMhie5smjWfAVwUBl0oPZ3A43YWJgh4LNK8eeoeYK5JQEjLbJ1lj9d7tIZmF289Xtz7aeoOLsDMaEBOhvTSRt5yMJ7rzPEM2FnQFwvp5hRQq61sJzTOVCkX7UYA6F3o2i87dTqMwKfDljGF0+0BHpx68poNEMyn8LVBfu1mN4lKOc+T4jdJERdZl0slP8kIH9lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199015)(6486002)(83380400001)(44832011)(478600001)(6512007)(6666004)(110136005)(38100700002)(2616005)(107886003)(36756003)(38350700002)(86362001)(41300700001)(66556008)(26005)(66476007)(186003)(52116002)(2906002)(6506007)(8676002)(8936002)(5660300002)(66946007)(1076003)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kwqRa+HJpZ2Cx/J/4yBKL1Kb+K6zQCNOAy1c2qNJS1eHna1sBEMnHXfd4wPR?=
 =?us-ascii?Q?CpAADznUeqVOjf1Zc4g3zbkfS8UvEDx6xvFtUqOKviYdUwUaYGQ8TVvLxbjz?=
 =?us-ascii?Q?SIA3HWtFBnKePaBfCWlUT4IUgnetkGvqVCupW33P72i4yj3ijpG3+TdWGgzd?=
 =?us-ascii?Q?W2CDNgqyf3oEh9ITNX8ujTJSlVCV8QlGFBzmJy7mzaxViwW0cOp0UbhujX7J?=
 =?us-ascii?Q?wxIgZG5+vrqji8dhNvdqrsY+y/5ryPcLsTmZ+XuDeTEkDK7S8nndjHOWqYiM?=
 =?us-ascii?Q?/HhbDRnJLXebV7h1775idHwxphfCMHx7ifXe//lCpFjRoK7A8i1rfZG6QomP?=
 =?us-ascii?Q?A2Es2VJ0DZ7bY5j+gFxJa9svBCnbLZifWl/gdlu8t5Uzb9aOaU+o3BkHfOQO?=
 =?us-ascii?Q?6NjPt67mWfeklFaoBUplOyr+74sFr4A8RB2czmFWNvfWfhBZvtYKWi7yjvTX?=
 =?us-ascii?Q?l9Z4ncxQb6C7uqYd8OlqGxTnq0R5OUCaXRcoM2m6OVs6yzd5Vl+TdTFPrVqR?=
 =?us-ascii?Q?YSvFTc8s8eEXFQ2swPHHeqAjlJwhlosFrIuY+4NtGKvZHrB1DxJmFf5BQpwZ?=
 =?us-ascii?Q?jiJBC2BMVLpuXszIyP3M4f0q6lACfS0MW1t5h1YK9OkUowb2PpzjSbdKNlvg?=
 =?us-ascii?Q?qfSq6TEtLJEGTT1ctlntF9xJk+Los94qyKxDUGD7QMcHQ8f0xfdz9lmf0J0+?=
 =?us-ascii?Q?a3BGw3Ftg/zEAAmqdPA25AEfKH+sEHyTcQIrIVMjJQ9cLDozHQuCmV+46f0M?=
 =?us-ascii?Q?cyDXZ7bJVk+nT1HCyUgQkyIhNmm2n3YJOaU2edKbDFzk61ytOHnCS9nDV9Vk?=
 =?us-ascii?Q?RopyXXApQyDoSRyFmQwGhH6jP9EiC4mYwTHEAM/OK9Z+Aj8yv2+UVUCyxh1w?=
 =?us-ascii?Q?z17y8wUmqMaqfl59tQpRxVzY+msJQODwS7ec87YBUIF6McvSH89CF0YbNJhq?=
 =?us-ascii?Q?TiQ/oGTHvVddXLJXKp+EdA94LMaTGi3NVTnWYtiTnhgLP3VK8KSGIrRtHPej?=
 =?us-ascii?Q?A0KVGY4/5cowtho5+Pnyr9BUSiByJlQx9sltiKs+huwAVXtYXwriwHkEta0t?=
 =?us-ascii?Q?C76ecCIHT3O2fxYGG3mAuh7lliskJGA7u3JdSmc/MUSCA0iKYs3rkDetdRc1?=
 =?us-ascii?Q?R0z0eb/q+h/I2dYkUkmEH1RCjNcGb2TpX+8txSlaSRWZHjIr4VHWx6po7t3q?=
 =?us-ascii?Q?MleSZyIq80RamOflWPC9JMItFmssX47LlDi7vFYJlknCGZzwJKGMu+lcN8Zq?=
 =?us-ascii?Q?tWwtbxe7GaOnFf/zzKhBKmt7dUgg8AUIQM5162QLLLhOHhEWs+4E27FnuY8e?=
 =?us-ascii?Q?zKnOZGInowWVXbNsMm4wXQqbqksZkLayumYmzrVUQSAoMYk4uhHFPaJ00vfC?=
 =?us-ascii?Q?ylt5fQAcY9/BwOkxvJzUrTEfYeB4EYDWAOls0GayWHB7ZtEvRfUbnS7R0ela?=
 =?us-ascii?Q?cZVVtj9P60SrYYIypQTTZ+4jjoJJE9qwJ7+OIP+/xd0aFosTwtJKqqevkv8i?=
 =?us-ascii?Q?JsXAiMfo7ep8zVOeI6/nyT4jqcK1bSa4ZUavs2lnu2k5+rZvoOKaCXdXQb25?=
 =?us-ascii?Q?0NKSgY7yPnL2333pRVVSdDb2AopB8BUSlnwrXHbAfpMCeuoJfQJn+6ssnC7N?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae47ece-2aec-47c8-d5f7-08daa8823d93
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 16:37:36.0534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng8BWueMVz7Bpsy6li2NTePgmPjNpduAqHyhZxXFoHoFgD+XMJUeKorNrdd2N5fs3d/9OK8DFvSS449oiz6l4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, the "oscillator failure" bit is set

> ...on a power on reset, when both the system and battery voltages have
> dropped below acceptable levels. It is also set if an Oscillator Failure
> occurs....

From testing, this bit is also set if a software reset is initiated.

This bit has a confusing name; it really tells us whether the time data
is valid. We clear it when writing the time. If it is still set, that
means there is a persistent issue (such as an oscillator failure),
instead of a transient one (such as power loss).

Because there are several other reasons which might cause this bit
to be set (including booting for the first time or a battery failure),
do not warn about oscillator failures willy-nilly. This may cause system
integrators to waste time looking into the wrong line of investigation.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9b0138d07232..1eb752e4e39d 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -115,6 +115,7 @@ struct abx80x_priv {
 	struct rtc_device *rtc;
 	struct i2c_client *client;
 	struct watchdog_device wdog;
+	bool wrote_time;
 };
 
 static int abx80x_write_config_key(struct i2c_client *client, u8 key)
@@ -167,6 +168,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
 static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags, rc_mode = 0;
 
@@ -181,7 +183,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			return flags;
 
 		if (flags & ABX8XX_OSS_OF) {
-			dev_err(dev, "Oscillator failure, data is invalid.\n");
+			/*
+			 * The OF bit can be set either because of a reset
+			 * (PoR/Software reset) or because of an oscillator
+			 * failure. Effectively, it indicates that the stored
+			 * time is invalid. When we write the time, we clear
+			 * this bit. If it stays set, then this indicates an
+			 * oscillator failure.
+			 */
+			if (priv->wrote_time)
+				dev_err(dev, "Oscillator failure\n");
+			else
+				dev_info(dev, "Time data invalid\n");
 			return -EINVAL;
 		}
 	}
@@ -207,6 +220,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -240,6 +254,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		dev_err(&client->dev, "Unable to write oscillator status register\n");
 		return err;
 	}
+	priv->wrote_time = true;
 
 	return 0;
 }
-- 
2.35.1.1320.gc452695387.dirty

