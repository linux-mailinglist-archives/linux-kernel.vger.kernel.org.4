Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798176A53FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjB1H7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjB1H7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:59:04 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CCF1B2D7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:59:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY24TPfApkhaA+nlSUyvCWTAqtLquZXjdQJwuDAHC255WRoR5k2p1ubuyVjgQbS+0x8gmsUAkWS7z+y4EDOQl8Cdp4ErW1mGgGXD56RliWXYMN5rcHZ2cSjLDmHdHMJpwShjW64iiFe5WJl1Lfjan7W0zciwz7+Y0nJanYhTYxxv8bA87N/0oJs1ST4Sf7FL407cu3HaibTPw6IMO4B3gyc9WnPi/3Zj3BJTSowzUswDCIOeSNbRljbqkg+bdRvGPKz80fG76SVkHWxOup91jgLOhMM4MzfxgoYq9UKRmyX9g3k0R1cvFsQvKigEDRY6XiljZBfibnLlRKn9UyTqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F60hxucCort2NZ60ENR9zW4KGQuarl3ytM+NGFonp+A=;
 b=PBqJi2u3OJvFqoQFZWKcHheL/NPEUVYeexQ/b95M1rYTeD57pApCve6gkD/FF5iDtR0ZEeRpPGyFqcCsrfME3sVrGGmnP5nFMZ2BWYQhuy1jfKRuuw6BHf1Ae8MwS1kOQgK13EczyEVTB0sqp5WdWKwOK2od3DVgUIP1HGETZPk7m8HaE1HXwAxY/VLbzltElVBaIWKrZ5boqPt6mdZSegUDmPNS+iIgTD45/yW3ErLFpRmPBnrpmsX8NZzCaoz/9eqQ5FkpQ6k0VfVEdGZRDveFcIn88jIVXlpDeZddZIxLoOURIrlUThH0SXcIOppKmFroy7KlGVLYpty625nayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F60hxucCort2NZ60ENR9zW4KGQuarl3ytM+NGFonp+A=;
 b=BgCqyrRDLSTta0mLWNZM+8QfGcQy14vAQiEFHDlTbhjivdLLPx6G90JFjpijos70FSQwH2hPDbr30TWrm+T28sfEb6BAF689msdiTCNodikVLrsfxL06qWiyqVZD3IJ/YEsvRIuNba7iUGEJ85luYqoHWKq7d8je94rs3aw//2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 07:59:00 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 07:59:00 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH 0/6] soc: imx8m: Support building imx8m soc driver as module
Date:   Tue, 28 Feb 2023 16:05:26 +0800
Message-Id: <20230228080529.412669-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: cd756664-e44f-4bd3-ef1a-08db1961a676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BhMOk/JBFYPW0q/HvEzWQ0xp9Q8UDEYwCfXX7MwSqZeX9ytJaNdYhdaWWsJy+tDBT4GTwpVFq6FtSfhp3OhtGwCKbqxNTwP51cCqS6VGBmWZttriWhMphDleRVvmiNcvcz5vjZZzxwvqypzYKYgEW7dhiGGrIC4y6o+3HmE9vntCCZjub8UATe1LmHGHG/AhwKFfuz9oYZpKW3H/wueH1aytS0rcyDS+aBk6UPL/i5Fs+tQ1IwQbE/TnzAUi81FeKpJLOZuy/BcdgBH9YFREnsQK59utV4fn4ulvWyDBGU9oSdWo2dr44jIn+kVWlyOb195jTxwht0u7t/5zE4huVAxtceCHt/kcjaIEP3ehIpVs8dFGCb0t6HTlE46taWnck015MubMKhkQ9ysFMakiCQNTiVRpvUiwCQP/vje/K5IgvVsV7oUqBfPnC/Zg/NWDjq1VCRx5PvItIZ2fygNSmO9WZ3dsMrUT9o8XSbJeNgGXyCUPyxQb63zuai/7AusnhD+YSqqh+UJMB5yAcCgeu4pP5rK8bblYmuYtJVj8jYM2LIOKXKxU//sstjy2K95Nk8uDvHI8/1ntF4eW6nCixF1eHsu3eBracV/AoVbsS9FTNcOOmjkG1f0/HM5CEJyT0UON25O8iQmF9FaHg73B4xTfvHJcHyxdS3IIWxvrgU/q2aNBXeYfWmxsgxyebkYsXKpyVjcMbll+hCecBlaR3bfVlXDtefbAhz/mSgXICg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199018)(83380400001)(316002)(36756003)(4326008)(8676002)(38100700002)(38350700002)(2906002)(6512007)(6506007)(1076003)(2616005)(478600001)(186003)(26005)(52116002)(6486002)(6666004)(5660300002)(66476007)(44832011)(66946007)(66556008)(4744005)(8936002)(86362001)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZnYStQKzBTcWF4c25VTlkxaDJWSjZFQjFCQ3M2TCtPWVNnbklrL0Nwc0Jr?=
 =?utf-8?B?ZC85WTBTbVdwQVk2bCsvRHVRZ090QUlGK1lmMHRkNVlBdzMyWXhkZnNUMUtl?=
 =?utf-8?B?QkFuckRzUlcrbng0dm5IRFVPbGtKRDVmdW01d0x2K2k3c2xVRFJuNWZtM29Q?=
 =?utf-8?B?eklKRnF5bUlVMzhjWGJWQkxCWnpQeTM4b3FhMnBsaEY2eERnVlUzUEQ3V01E?=
 =?utf-8?B?aWtHRlp0OVp0cjVIcHRoc01LUGZVZHV1TnFnUkgxYzRET3Bud281Y29ya3Rr?=
 =?utf-8?B?RnVMV0FQeGRkLzJZdC92TUg0cEFESEVFeWtCVzZxNXFVZVNHUVlmQytXR1pR?=
 =?utf-8?B?cmZBaGNOSU5pQ0FHUzZZbVF0ajRRbHN5ZXZGcVhteFd5U0V0YzZ4MUhyREhT?=
 =?utf-8?B?NmV1bkxqTCtrbExrUit4bjh0TEpVTnltNWl0WHlodUlJMHI1MXdQS0dkM25D?=
 =?utf-8?B?NFY3bHN0ZUpPZW5rRXhIUCsvemJYcUo4clVMZXIyeXZUQ3ZlclRRSTNGS3RH?=
 =?utf-8?B?R3FhUEhNV1lJTUZMalQzODFHdW9ocmw3Qm1kbVJTWUN4cEt1R0Vac2dnUGdz?=
 =?utf-8?B?UmpXeVpQQVRydGlVWWxRQ0JJLzVEaTRhVHl5Z25ESHJucjRLT2tsb0FLN1gv?=
 =?utf-8?B?QytsZ3pCZ2NzbGxCTEdncitGK25mdlVvRUIwUHdPcWlDYzhkVmpFYmNqUGd6?=
 =?utf-8?B?b2YwbXV4RDN4S1NoaDBZYm5JbHFUOEkrcitxeHAwbTFFek1xR3M3Uk5tRmJZ?=
 =?utf-8?B?ckFlMm5mb1ZxbENVdkpaWGxaeHp1RHpQRmk0SnZOcTlXaTBEVElmelVGdFBu?=
 =?utf-8?B?RkRnd2NFSVpockpOZVpIZ2ZjRXZ2TUdFcnBhWGs0RUJzUDR5UVExRWlRQ3ZX?=
 =?utf-8?B?d0I5cUJOL2JlOWFtUDVBdnNnS1o1Z1N2UVBZU252RG0wb3pqU3VOaXBVVjVL?=
 =?utf-8?B?blNBTDlMVmNkM0hFdFRqYmN2OWJyYUwwdHk4c3B1UHEvc2crSHlmMEdYbHNP?=
 =?utf-8?B?ejlhby9MeUhjSmtLWjV6aFdUK0N3bmhwOG1FZHJJNEkxOUtGc3VJZE1TZ1hP?=
 =?utf-8?B?cjY4UjNScFA0MWhxRlhWSjBqNGp6NHpPSXgwUHFqYUpTWitUNktadWpLZHRO?=
 =?utf-8?B?MGQxTDNSNS9NSTBpNFV0ZnFrNjhEZWhGbmxHLzFwdjlLeWVCL01jOGJrNkJY?=
 =?utf-8?B?NDZraXRsc3ZySm9Ja3pMbWhnZEpUd01WMDZOTWw1RGR1OFFaWlRqbFpaMzRk?=
 =?utf-8?B?c2ZoenlQR2VtaHZZOGhtSC9IT0dyQ1dVTGFNNUo5RlVwOUhUeG42RW5Ta1Ny?=
 =?utf-8?B?ZS9sOVh5OHRyN3VMTmRqV1NzWTRDNDFiU3g2UVBjRG8rQk5CZHhFUk9BVU9O?=
 =?utf-8?B?K3hNREJSUGdORmJGUmQrNUF3TFZqNDB6UFZkRVRQbXFlZHA5NTV4Nzd3a0d0?=
 =?utf-8?B?am1NWGt5QlppZFFYR3JBRDdCREN5SkxMa1I5SGxNcm5wWEhqSFo4UG9JTW1y?=
 =?utf-8?B?THJuMnovR2JMakt3QWZ0S0tEandkT3VWN0lKZkJjVEI5WUcyREwwRkJXNkIy?=
 =?utf-8?B?dmZKNXhndUFXMllVZ0lFVmZIbFFSaTFBeVZPZ29BS09sQXdWS2hCSnl0YzFz?=
 =?utf-8?B?WmRFNjJFWjlzZFhjMkJ0eDNLbWxqei9hQWxEbjBhUXRmdDRUSWFnWkd1a0Zp?=
 =?utf-8?B?TXpqUE4wVDFmSlpmZHcxRDMxL3A5a2l4Q0V5YnlpZ3M4bkJkTlVhT2VpR2Y0?=
 =?utf-8?B?aTNhZ1hSR2Z2R3hzN05obTl3bGFVOXB5dERodmNPZDZyRHVGTGljTDF2YjJa?=
 =?utf-8?B?b3R2d2pNMEhXcUVCRXpxbGJiUjd1NXlUQWlSdzNqdWVMNDNGdU1HeWQyYTJC?=
 =?utf-8?B?OEtkWEk2Z2RwUlpFbXE4OVpSRUQ3a1Z3TlYwQ0huY0FIV1NqZnB5aXR5bXhQ?=
 =?utf-8?B?ZFRNY0JGWDljSWluWTZsa1JUZXR3MjN2ZU1aMW5IVTl2cXlGTzBnQnQ4WUJY?=
 =?utf-8?B?UjZuNHROMTlFMnd5SHYrQU10WDlKcHZkWHZBb2hVdFNndGFaM3ZRVWl5Yitr?=
 =?utf-8?B?R2lYVHlrN3diOGtQeTJ5QWRIMk5EWmdTL2VkL3BvVHRSZ2NOOWF1OFhEdHZL?=
 =?utf-8?Q?cGEeUdOzIAbmdnVWINMHRhYDm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd756664-e44f-4bd3-ef1a-08db1961a676
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 07:59:00.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAtfG5gawXzd59nbHYuLOBQHwwoxeBhV+QLfpPVayx71sJJMNvBZoqan/O62AAy1uBSXAEEetajTd0tCNXV/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for building imx8m soc driver as module.

Jindong Yue (6):
  soc: imx: imx8mp-blk-ctrl: Fix typo of imx8m_blk_ctrl_of_match
  soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
  soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
  PM: domains: Export genpd_dev_pm_attach_by_name()
  soc: imx8m: Add MODULE_LICENSE
  soc: imx8m: Support building imx8m soc driver as module

 drivers/base/power/domain.c       | 1 +
 drivers/soc/imx/Kconfig           | 2 +-
 drivers/soc/imx/imx8m-blk-ctrl.c  | 1 +
 drivers/soc/imx/imx8mp-blk-ctrl.c | 3 ++-
 drivers/soc/imx/soc-imx8m.c       | 1 +
 5 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.36.0

