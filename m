Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAB774D28B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGJKA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjGJKAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:00:31 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B873A1FEB;
        Mon, 10 Jul 2023 02:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvrOY8vD9Kx6dZ09ZzlDX9FFB0IM+Ny//75S5cvFIGeTaLswKPFeZnEkj/sVbTmXWykpHx6mAXhDW8CaufXw+XGx8BzYqMB9CGiyZoZAo1cTlrlpkEjL6PS6ZC9brfFtF6T0V7bXIPK4gUPDbQL4af+3i9TvaaRX4NIbJGveCBvHP/v8UQEeH9YufEE6OcPZkg8twilhhRK+f55LmoU7Rtib0OuEPLy5ZbZt1c1lCbKHGPbr87EI9CIr9RyBjILhak1jAOwjy/UxWhRlheKBXMuxFbikpaLgFG2zOF9FLjYhQe1pqIUIQhMqbw/Xxr9P+Mun5zNpA46GRlSUj7rT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2Adq8onv3YkD9n463dstTY7T5e1xbQ1B4d+39jPHYM=;
 b=b06c5gDGKo8u0xGOCj0mfGkJ6SBl4qAlRxZOb/kiLvChuKbRo/WYaK8eXhZsDvBXqMSuTjapFHxZgrwhnzTD0WFP6FPbUz4bvx5fcmQtLGtM74Bs66n4RlOIsTHehLFycqHszeSem3XCqWrYJ3pE/gMYxbeZz6t0vp8zx//+z744JKHRmcVtQXtt6cxc0qzeWxlGzQpxI+icRjakbCUJ4zP/j51/awFfhEtQFNqTM7Uh91TXW33oXrQUtibtaZ6FDVpjlUvXe8vBwFT9RZoMyNf/abDjiMtWhF7aDMnDXWH9gI7w459+83bw7sTAtABeJsoDRSbmY8+qYWp/P9J3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2Adq8onv3YkD9n463dstTY7T5e1xbQ1B4d+39jPHYM=;
 b=RyPEKRdNKUa8ZFhJ+/cAPGoNV0CGtemBqThk18uwixxRsrs3+2ehwDi+TLyiDW5frNCHzgEGJrAVZ3n+cbBI88YBAkoQVvxHliBG6EtSW2TWHe1zRMRCFOack89K9Xyg6HhrGTzB3f/WB/FyamkY5AxAchOxi+klXGKEjBXCVqNLqSjvqKvXWISjuTlH6AVn7bxz1X7FGzLny/YXRhl87rreLeyhNGU+x7KajhVtMW1Zpnq8ovMqYqucU9/DFgMycYRZ4P//H/XseLI553YZJj86VJ7jBAVMtlXkqxWMBMB7RQ07yr8WrGigZyJOTpa0xLk3HBDgn6Sby0agDVVgYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5079.apcprd06.prod.outlook.com (2603:1096:400:1b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:58:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:58:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        niklas.soderlund@ragnatech.se, heiko@sntech.de, bzolnier@gmail.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, u.kleine-koenig@pengutronix.de,
        chi.minghao@zte.com.cn, broonie@kernel.org, johan+linaro@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 00/21] Add devm_request_threaded_irq_probe() and devm_request_irq_probe()
Date:   Mon, 10 Jul 2023 17:58:36 +0800
Message-Id: <20230710095836.15372-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc615f3-d04c-4dc3-12ca-08db812c44cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6IYlJuKjUF3LbVal/q2eqoF8vpIroPdJhrLZ30UUAZzwI/yKa/W1G8s3VCy3/gFqUyCdJT3yk//ZACFLKcgetnDEQDvcpmX62wr4YH12LF4eXCdc39PWMBgELDK2Tk46BAVpT+lbCO4n/oQoa7KUDeMTC3nwdmKy2Sz5bMMP0TfS+KzfnJdeS1o8xmUrhe/NOruvTheRYViCZLzQv0HcSh28YQe8dJXVzG+s8zSktR8p7JfjWD21xJcRPxYP7tcj2YsOzqLo83wkOU2Vk7LGXXeSdScp5y+uZR0pZ/STVygUsOoGE8PgRYsYcpmsVPGAy3kNemhkDWO6cDhTRBVb9Dc0fc5qC0CBnUlLopZmVhu76Nas94SaQH8huFEYQiKINt27Y3Hy7X4agLVPzqqHAs25GG6x9rKsRyney7ysOCqfwb+Nkx2QgDTyqNgUpx7gBpsnfDzUr6l/Mds2DqukAAagS6osvdYztWyNVRzfW9xHBY2H5L9MOxWquV3L2CrZEXwPYmqOg1iPS1AeHhf9sf3KdRpdlf12L49noYuNaoG4t2KxwcuKImMh9dDUSOnRY4UjyxwZ6kUWuc1eqwwO2ajt8IpUx9spoK3tk5r19DvMSR9OTCRCirIihOisbmJxkJBbsbnEFSUaz25WCle3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(107886003)(26005)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7366002)(7416002)(5660300002)(7406005)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(36756003)(921005)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjVCS1NIR1RveE03ekdxRmlvWURMcVE0Wk9oWWc1ZTcrT3ZkOFYzZ3FDdE45?=
 =?utf-8?B?U0tzU24wV0Y4cTZjUFhJN3NaL2ZmSmJvTnFZSnVMQVpma2pWYVlxMVBLYmkx?=
 =?utf-8?B?Vm9JVm9DaDlzNnBrdUFCSy93cWJLak9CYkovNGlCZzAzSDZYWkM0UmREeWhk?=
 =?utf-8?B?Sm9maGMrLzdhQVpDR1JvVS9CU1lQSXNoNC9yMlJEOHVadUlDbGhNQ0VkVHF6?=
 =?utf-8?B?WTUvK29iTGFQeDQveHhSb0J1VTBITHhWai8vSzRjUzI4elpWUUI0bkdXZEMv?=
 =?utf-8?B?YWRCb1VrY0dIcFQvVlVLQlRqQmlKSFBxdVdyYmRPdlNuMkpCaUhGeWxjdWcx?=
 =?utf-8?B?YkVmVUhMbU1jY3ZnamkwdlNGZ2J5LzJjclRvT0hOKzY4eSs0Y1kwYlFjMGNl?=
 =?utf-8?B?cDU0RTFhSFlUOW9EbmloR2V4TTdwcFVMUk5WL3NsNG1xcEtZa0V4MVgxSmd0?=
 =?utf-8?B?WkVIZEd1bCtHTW9LYUZYdGpGeEtoUHArdXRCY3h3QXlPMjIxMDM0SjN5V214?=
 =?utf-8?B?RjVFeVlxK3oybFJIaGVkTXNlLzg0R3BobXpBbXdtTHZld0ljeUdGRFh1dG9Z?=
 =?utf-8?B?bEFKVlVveDJqM3d6V0tPZE5yUEY5THlrOUZSRnIvendoM1UrSWdVSGJyWURV?=
 =?utf-8?B?cm9BTlU4V2J6Mno2Qnk3UXhVZ25OVDZta2ZZanVqRXhCU0JlQklzNnFJZ1BH?=
 =?utf-8?B?UzRCRU1vLzhKTHZhWFBEQ0tDVDJDVDN1MTZNRFFtWFplbG9VSlRUSHR5Z1oy?=
 =?utf-8?B?MnhmZ3laclkvdG1YcUN3aG5rWXFUWmxXaG1Wci9mQmcrSElWMHFKUmVudGx3?=
 =?utf-8?B?NWd0OWsrZXY2M3dsV2YyanM4R29vaGtrb2VocE84UDdVbHpTdExFamMrQ0Zh?=
 =?utf-8?B?VnRZeTBRVXpjcXlQeXlDT1ZxV3hPQzV6MGxtQllEVW9NRll3MklDK3lTalRP?=
 =?utf-8?B?QTROOUk5c1oxcHVUMWxsT3hleE5kTDB3ZDl4NnZiL2RYTW9Vek9aTFVBU0dj?=
 =?utf-8?B?VFo2ZUh5bFRnVktUYXk2VkpiK2VkdEZnR0FMejV4UXdsRWpBS0pYL0tCZ0Qr?=
 =?utf-8?B?cWZHL1lyeG9NVEc1RDFZRXRnaTgwbVVzSUZqNURHQ2JsZXJ4anF0N281L3pP?=
 =?utf-8?B?dHN4OE96R3NUdWU3MW9SMGF1b2YvWEV1b0Y2VWxPY0FBMStmZE9yR2h6MU1B?=
 =?utf-8?B?MWkrcURtUVlyRnBIc1pNTTFzbWtCclN6eUoxSktObVRKZ1FjNTU1MlpCeGZ6?=
 =?utf-8?B?MHNmTFZnaXhXVFBJZmxGY0c4c3JPRDVLYXBVRUs1cDhjRmZOK2J0YTk2by9I?=
 =?utf-8?B?VVJydTNnVXpSWjZ6WGMvNi9jTElRNG41S3pKck9qS3dvbjYvYlJYcHRnMEw5?=
 =?utf-8?B?K2l4OU9qWGVUckFxcEQ1RU5oV2ptVzZqY2xMUUR0MzRKYWsrVGFRMVhBT0ZD?=
 =?utf-8?B?anRadk41WnZ1UWhNb0pCdmNYaU50QTVXZ25rakdhaGpUeXJYSm5sNEVDZnhO?=
 =?utf-8?B?clB5aXU1MFhGS2Fvc0xTNGZ2Z0Z0TllmbUZTT3FJbkdiWElRekI0dWVvVFVJ?=
 =?utf-8?B?a1plMGJxbCtxZTdaNjRmd3BnZ3lFWitSNC9ZUjVTUUFvZWU0UTc0LzJkNXU1?=
 =?utf-8?B?MkZrQWUyZk9IdHZvUEpRRE1uMFBQbjgxUndrOG1QYkx6bzhYM29CanVEbVJ5?=
 =?utf-8?B?QWdzMEtjSTVHRzRGendIS0VmeU0rUXFUMkh2SXdiZlJNRFNHSGxnMzg2RmMx?=
 =?utf-8?B?THJEYkhISlNxZWxNb3hZNlQrYURMbklPSUlCWXJtMHE5ZXZpenpmeWFNdUhC?=
 =?utf-8?B?aXRJaWg4SDZnWEl2elg2N1RLRUpvelJoQWJleWRJZ0tZVVBXSWt5VjZDaUI2?=
 =?utf-8?B?SDFjaVg5WW9CQ0RRWGlCUHFzL0lmQWkveGw5RUtrbVI1THNaa1RxWE42RTBQ?=
 =?utf-8?B?ejhlK2JXZlJhK24zS0w3NjY3ZWhnK2pYa1FJZDV0djh0S2xVMzdqbTVDTGc1?=
 =?utf-8?B?RkNZZ3V3ZE5Db00xdU9aVVBobnB3dkl0R2lWOUlRN2JKUjIwekZ1MzJZVWNF?=
 =?utf-8?B?ZmQzYmZkQmhpYXVzU0g0eld4VEdTY3d3SG5Gby90VHU1a3hVZVZJQThtUkRm?=
 =?utf-8?Q?tXFkoncGs9IxzM8CwBbn1U2wn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc615f3-d04c-4dc3-12ca-08db812c44cf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:58:54.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upC6zVJq542dSDYvdUOwZ30IWHiG4p7TunK9bmFB86DFDD6Aywr3CAMy1JXT1WBkw5kGCOyzDjm4qfMr8NIX5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

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

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Yangtao Li (21):
  genirq/devres: Add devm_request_threaded_irq_probe() and
    devm_request_irq_probe()
  thermal/drivers/sun8i: convert to use devm_request*_irq_probe()
  thermal/drivers/armada: convert to use devm_request*_irq_probe()
  thermal/drivers/broadcom: convert to use devm_request*_irq_probe()
  thermal/drivers/tegra: convert to use devm_request*_irq_probe()
  thermal/drivers/db8500: convert to use devm_request*_irq_probe()
  thermal/drivers/rcar: convert to use devm_request*_irq_probe()
  thermal/drivers/qcom/temp-alarm: convert to use
    devm_request*_irq_probe()
  thermal: intel: int340x: processor_thermal: convert to use
    devm_request*_irq_probe()
  thermal/drivers/exynos: convert to use devm_request*_irq_probe()
  thermal/drivers/hisi: convert to use devm_request*_irq_probe()
  thermal/drivers/rockchip: convert to use devm_request*_irq_probe()
  drivers/thermal/rcar_gen3_thermal: convert to use
    devm_request*_irq_probe()
  thermal/drivers/mediatek/lvts_thermal: convert to use
    devm_request*_irq_probe()
  thermal: max77620: convert to use devm_request*_irq_probe()
  thermal/drivers/intel/bxt_pmic: convert to use
    devm_request*_irq_probe()
  thermal/drivers/stm: convert to use devm_request*_irq_probe()
  thermal/drivers/qcom/tsens-v0_1: convert to use
    devm_request*_irq_probe()
  thermal: qcom-spmi-adc-tm5: convert to use devm_request*_irq_probe()
  thermal/drivers/uniphier: convert to use devm_request*_irq_probe()
  thermal/drivers/imx: convert to use devm_request*_irq_probe()

 drivers/thermal/armada_thermal.c              | 13 +++---
 drivers/thermal/broadcom/brcmstb_thermal.c    | 12 +++---
 drivers/thermal/db8500_thermal.c              | 16 +++-----
 drivers/thermal/hisi_thermal.c                | 12 +++---
 drivers/thermal/imx_thermal.c                 | 11 +++--
 .../processor_thermal_device_pci.c            |  9 ++---
 .../thermal/intel/intel_bxt_pmic_thermal.c    | 11 ++---
 drivers/thermal/max77620_thermal.c            | 24 +++++------
 drivers/thermal/mediatek/lvts_thermal.c       |  6 +--
 drivers/thermal/qcom/lmh.c                    |  7 ++--
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |  5 ++-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |  4 +-
 drivers/thermal/qcom/tsens.c                  | 23 +++++------
 drivers/thermal/rcar_gen3_thermal.c           |  7 ++--
 drivers/thermal/rcar_thermal.c                |  8 ++--
 drivers/thermal/rockchip_thermal.c            | 11 +++--
 drivers/thermal/samsung/exynos_tmu.c          |  9 ++---
 drivers/thermal/st/st_thermal_memmap.c        | 12 +++---
 drivers/thermal/st/stm_thermal.c              | 13 ++----
 drivers/thermal/sun8i_thermal.c               |  6 +--
 drivers/thermal/tegra/soctherm.c              | 38 +++++++++---------
 drivers/thermal/tegra/tegra30-tsensor.c       |  9 ++---
 drivers/thermal/uniphier_thermal.c            |  6 +--
 include/linux/interrupt.h                     | 15 +++++++
 kernel/irq/devres.c                           | 40 +++++++++++++++++++
 25 files changed, 172 insertions(+), 155 deletions(-)

-- 
2.39.0

