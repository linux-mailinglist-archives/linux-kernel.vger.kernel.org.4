Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FACA745806
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGCJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjGCJF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:05:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98A8E4C;
        Mon,  3 Jul 2023 02:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNS5uZ8vYLcs0tCJfdkxynPWi+hkbB4dNi95dh26wrtcjppKZnm5Ak4y+5LvlulwOkQjL2oukUedwCziBDaLFlyAyPImrsrypCMWgU5zPbKkYr6vz4Q8SICEYWPzd8UnqvhON2KjD9qM+n2orSZS/GOvQqjKPvgQUxK0wMXJLZvUgILnZNT8aKzAd2obqIpz00mosI7QlkoXTNT5fJ/wd2QXdougQ2TrGg7ILTiKX9lSshpJ4FWJKBeEBpSn/bVCxDNHdEfPSaanaej2nO1iIli16lYd/cuBld6YxufdDSUVVwVGxeoAhB20d2BuUFdDAPfG804C4XHM6jTKXjM/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0magnPJQRnCZwr1tEy52cKTZtysz6+nDWT6m4PG6trg=;
 b=Kr9amVwjNNx4rY5KglMpb/HRVjzX5kr7rEoOrdSOmrcFo0KRd7AzTBAlblOI3hPzUk/7HP/jISWgmL3CBUsd2000//WPwpTOMn99Oh3O5Ma09XWP8wjEEo2AkdZ/THeVbNST9UB3d4MePGPC2CTV6nftao/WOId0LXXSkqf17lyoPUau8J8LwdmpHJzpZiVLtISDz549qvOmE7YsmNRn5jqX3r4sVqdiGLcob/L/vGh2/G6qmgfaMOlPjz4eVJFMr54x3indnah5/V4xo9fMEURfbRm8A7oiJtnB56OFqTCGfa/ftlkMwXvX3mBZZ+AANak8gf+gVsznQtIdHqfF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0magnPJQRnCZwr1tEy52cKTZtysz6+nDWT6m4PG6trg=;
 b=pd+K4a34lmg6ewUWd8+K0j+Kc59fTdpWGyK8f7JTC55XLSQRQU13MKAAubHBOb9KjXcpuL6e9GAsT7z+cbiA+U9UG6/JQxe/sCzgtlbUbB31AiboT4cjeb/EP3Zzirw9sgyxSyao12Bqqib4eT/28oprkR0/5OxZSbv9IdCCNieVEDWWqSWQec8qkM+IdoQ0HBekRF1koGqDheEZ+LcC0DitKPq5iNcf+nHgDlSw10dwT+0EqojAHTmOW3R1QMEnTWNySTjRZO9ArIIVg9XOgRLu/5kGOJdBxr0OL/a+drA7IXY6MUNkmDMEt3UgxFgX2PCx2NNbAcoZz7uryrD7ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5850.apcprd06.prod.outlook.com (2603:1096:301:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:05:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:05:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, frank.li@vivo.com, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 4/5] thermal/drivers/db8500: convert to use devm_request_threaded_irq_emsg()
Date:   Mon,  3 Jul 2023 17:04:53 +0800
Message-Id: <20230703090455.62101-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230703090455.62101-1-frank.li@vivo.com>
References: <20230703090455.62101-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b6ce06-857e-4cf1-3656-08db7ba4a25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWAoBXtVhr+Dev5SYoFRUV/0BP4x4fdWrLEdlCpxegI6Nv9pQymGrarUu7I4XsrFZ+xkMn8hBZtyogvKn8ehxuLH3TBTJPte8wNdrZei3M/ZVcV3eapvE5qexsXyNcWqJDyzyiVmMP7q40IZGw9VHumkpg0VmCEUDR9mISHjfh4KJ1A4fiE+ik17xU0+q/YX/to5tfnvgmJiEzXkbeFnAu5TVeYEo3hWlPhr6xgusWsv83LUzlAiw4B7zxu+i9BjsisiF3mq+/ODATT2adwFoANFGZJ5fN8p2vbddSWspwLgPP0QIsHyALi0NUgXo4Nlb9Q/7pYcLxBk5fyKxMW+g7KmyPrr0h9EZAkec4voN9C+Ez6kv/4o762yul8Dd3kjUzMmVmxiN7pY0rKQiIuzba9LSjctFD9GWMDHhYSQzvIWIMvaNuJi+gr0r8+bqu4p66pdYPKiSPsF9ieHQt46Fl0nLFsR6CsMa1dYdLuNO/sEbVvFFARbkA7KVhBoe5E0FhFkYZ9zHg07bdHjnd4Nci/tjsB4FnhQp8/4cigTBfY/k1P+aOSR751KE1+kWUCCoX9oBsC3dVdXF4zrMid0Ml1OwXwHQ4W4ICZXNNH5r/6yRiBmUwBk0LS1qVpZh4Dlv8/bcjFDM1q6jkwhUckqMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(7416002)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6512007)(6506007)(1076003)(6666004)(6486002)(52116002)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(38350700002)(921005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F2UB1UvMdTFnD/RLGPVng/jYSNo8TiJLtW8s5qbjl0eOhrogH3pRs7/xY+kr?=
 =?us-ascii?Q?TglM1S/qQFfZMBAv90Bsv/C+lP1aFeNYqPPeY5mhIMsgduyI2XdJ+cohf/jQ?=
 =?us-ascii?Q?wGM2YHKmXUSvJ4fnob7nbR4uyF/fkidpEGV5ISd5WjYb/fohDOxH0FbmehXE?=
 =?us-ascii?Q?Cewav+9WTjP1I0KMV0FJlki9MlBKpQNMQ7kgytvt7M2On+QxfVH7jpGVNN9z?=
 =?us-ascii?Q?pGx3nTWPnWvPDDTMswRhe6LiG1GI/O5ck62reUUL+rn7hEWooo5h4siceuqU?=
 =?us-ascii?Q?oSbSzyOGMPpddeKvG/UXsJ34DvgwfxYEyBFz6/bRG71+IT2Iv8rQZp6MmJmU?=
 =?us-ascii?Q?UrnoVmonuFGrL+aXcWWbSfV5T/OMtnXJS1JI7YL6odId+zYqg4nv8xfIEM8j?=
 =?us-ascii?Q?pUV05cxFzLJHbfeOlQ0LmIVyKFYrD6W5MRwJdewx1SxNoWB0Nlmbq18++5oi?=
 =?us-ascii?Q?Pk1ykT2aQqyR3Q5TzcDudrSvbdRaPpjxDpdRQatf1VKmCf+lq6l9jiKChkFY?=
 =?us-ascii?Q?ZMZ6oDUDtmCjzNmDGTbM5bnkKmxBXmdHQHQEPL68HdYt9Jt7HvB/nnThSJRN?=
 =?us-ascii?Q?1twlOM4AYGyVLtoBRgAPCqVTsqSgABTjKlXsnthn9AEZTdAsRkOLCGe1xHNk?=
 =?us-ascii?Q?5eowBnSCwdgU7LLYgzaxbVSRt+r753PclI0k3OW+RVHpwh1Hx9JJhIMlSV6Q?=
 =?us-ascii?Q?9psUvemtGX5JAqj96LrS1pJ5QfCQx1va/SuZyhLiwsqMGu/dL9VqMe+Vn87P?=
 =?us-ascii?Q?MryA/S886LeRdTVcbhHKYoYGh739iLFowB+bhqOQJ59yV9shkwKBr97BqaaM?=
 =?us-ascii?Q?ahLI7PmMj1lJrk4KDbrgc4Ou6oPcha62peEDg1zMNpyqT9RToTh0sPmMgqr7?=
 =?us-ascii?Q?9CAHjcIvPNg80Luoz+82o26QYV5kYeBJ2ThDRDt/mSTIHiWilKSMC1bNfGOb?=
 =?us-ascii?Q?z53y0r2MRYhJALsUMrnmLBx9zyPaXHMWquaziawMJ00DaLJhfV0MP++BgnwR?=
 =?us-ascii?Q?4o9tcNAGmWNyMhnE/q1TyyxYBM0ZKoqfxBxX4nrUASm9r5ZH+3S9vp8KnLLc?=
 =?us-ascii?Q?PBElHwpwaptTr9du4QOL8EE8KVbeSxIIEBLCnVkq4yV2f6hmTa1prQMy2LCP?=
 =?us-ascii?Q?RX3T9A51BK0iVlT9PHyIEn+C5vnrYWjEtG80tzZD3Q4oc6ogAJPuArqDDqVW?=
 =?us-ascii?Q?hj1c5Z5/2AcRHXaEc0PsFl7BJyvRFINcHgMjYx6jIqj6keRwZ4KxtQW0bOXE?=
 =?us-ascii?Q?RxpOUS14qiUn3E2qc+oZ/uXkmfJU/ZYzlRPyRh1lSVI30H7pPaS0cvHSYlhl?=
 =?us-ascii?Q?Cx0meuamLGDbzyNrSDduQZY67Mp8zN39kwNAJscgCxxvbFoWOnYuBKx6VdNe?=
 =?us-ascii?Q?G3YonGCmTCK82NrzvQsbwmr4Lwo3za3szkAZLQ0Um0hEYHBGsWUUSyN93w6T?=
 =?us-ascii?Q?sSZoo7QHe5JUg0Y2H9a+yUpM2QTV7995qmZEl6WQH5mL6koI+Fo/GMgavlYC?=
 =?us-ascii?Q?yIJysdB0LBlYcz92jba0Or14g/FG6VGCy0NRQM/YjQJY9WiyrqaDuAJi+mvj?=
 =?us-ascii?Q?HinFjDzZhtEtMNtgf96sW/LxUU4N0I2M7uryhHLt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b6ce06-857e-4cf1-3656-08db7ba4a25c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:05:23.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ia5KjdP2DcibX+OQfXajaZcmbnsMZSWQoZSALUqh9pSzt8xMLisDOSUv96O6PHdm4/P2vSkID24pOLMK6AuqfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to the devm_request_threaded_irq method.
Most drivers only request one interrupt resource, and these error
messages are basically the same. If error messages are printed
everywhere, more than 1000 lines of code can be saved by removing the
msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

Let's use devm_request_threaded_irq_emsg(), which ensure that all error
handling branches print error information. In this way, when this function
fails, the upper-layer functions can directly return an error code without
missing debugging information. Otherwise, the error message will be
printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/db8500_thermal.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index fca5c2c93bf9..195caf954aca 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -164,25 +164,21 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	if (low_irq < 0)
 		return low_irq;
 
-	ret = devm_request_threaded_irq(dev, low_irq, NULL,
+	ret = devm_request_threaded_irq_emsg(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_low", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp low irq\n");
+		"dbx500_temp_low", th, "temp low");
+	if (ret < 0)
 		return ret;
-	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0)
 		return high_irq;
 
-	ret = devm_request_threaded_irq(dev, high_irq, NULL,
+	ret = devm_request_threaded_irq_emsg(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_high", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp high irq\n");
+		"dbx500_temp_high", th, "temp high");
+	if (ret < 0)
 		return ret;
-	}
 
 	/* register of thermal sensor and get info from DT */
 	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
-- 
2.39.0

