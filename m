Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC966637ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAJDvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjAJDvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:51:36 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D765AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:51:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRZI8EonQyN6LZYcf3AN+uqG8LLLvEJc/0y0ozNWlMbbwqpsufAgYpfb+HwFaRmR/bFAyPRjxa8sjT1pKnPxrPyq/HeMG64dj4JPhPxEI8ol74ynljDSm5iawsRB11w/RzBJy03B+46ULdmrZAsabMxENaKi/BfYRh12fG816/hNM+41IknBp1ZvVTAE51/IzqhTad0inXOLGgD6GqbQsvQq+RQOZbLcZrHetl0KwE+rqz+w6Ijrv8eNQewwwVeigNnOenDlunXnDzUYdXElUrEY+VnIEwcoKzYi+m1a1C9C3yWITijg8XVU+OjRyOWceLIhtOyHbVEo6gvZZxQy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb1Yg90Ytn+zsQ305caI+CSTubO/PEQudhEMezlfKW4=;
 b=a1ax6SSD48Sdn0G/+E0YZ/hnq3diBapYOAG92kfejVwQ0Qm0p5/MlYAHyc9ZaV07MMFm0h/H8Yf0oX89x7Xer2h9FVTEAcR5J2nyROidFZmKcMf7TXkebtVNBDfOSCzqWPZgIL+HeuUAa23F/zmIT4pbZlG4JEUQRv243sMGvhWDElKSHEaaH+DSVbTd1fcyiAL9XCkc0PdWA+6JgzXKP25KWdUqvIZI6NMg9bJPJMcjQypviJH9RGRoph1pzhLQ+/0ImEVxyh2YuEulA1Cm3iL2TLDRookan5pXoM2tNjbm3USls4uqPRU0z5RDNQS4dqQgCyrNEyrAhhMwAtOoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb1Yg90Ytn+zsQ305caI+CSTubO/PEQudhEMezlfKW4=;
 b=LsnPIlct7V5Q39JV6wxnAes4SmruKOJNl7b9cBqUMHBEsIo4IkaQci8J82z1EbV6B5C2SEywdSAKkVFDjoSweSnPTHYA0BAnpDzJOtRV4dAVNC/YtG6JdQwjiAYPz/jQ48zlZfE6O+pTb19le04H89OHD+pgS+jA0Aw9fwX6hVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DBAPR04MB7381.eurprd04.prod.outlook.com (2603:10a6:10:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 03:51:33 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5098:b45:626e:a5c1]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5098:b45:626e:a5c1%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 03:51:33 +0000
Message-ID: <0f22d1986a0648bf8406a116f035d6112b9611f5.camel@nxp.com>
Subject: Re: [PATCH v5 RESEND] drivers: bus: simple-pm-bus: Use clocks
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, geert+renesas@glider.be,
        saravanak@google.com, linux-imx@nxp.com, greg@kroah.com,
        arnd@arndb.de
Date:   Tue, 10 Jan 2023 11:50:47 +0800
In-Reply-To: <20221226031417.1056745-1-victor.liu@nxp.com>
References: <20221226031417.1056745-1-victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DBAPR04MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: fc52c1ef-2bfc-443b-56ee-08daf2bdf670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtkSgR5bIO18m5HvBsoYgNgQWmbyS57rLJIxETGV5xICkGBy3LoSb5tC41/JOcy6kbUEJPKeWKQzCwXkJYyGIaQwNRGHKIUKgwDwEoFbMj1Bu0F6Z7D/Mj3ykd2KAC85b1USOAtedxRiyFHWb9w+0xXl0DOCwxzpdjO1RCOoFGzEKusYrvbDJlpQyQHSM71Ru7cTjp1jBVxKIxEnP3i01aEQy0/ex2+kehaGkoy346IjUKO20FatpfuhYe/+zKudsvNvnhIA4miksOKvXC4EFmFpyV9WRT/9p2px4+0hfHlDMYhvSC1oJRnAbegATuQ36HwgpZiI/VScfvgKAUVX3UYDYzsGpBDMGE+sMpJ968ntBdlNiIK9ueuZoCFBG3dNvmzdO0d6U83WslPdmfWTg7U8xDSn1moa6b7n845UcCr8J6YBk71PKlUvoS+epUmuNSDvjyY0/LDzNgf3DQ2ckeKVRMN7FT3Y0pqYyIa+9hq/abfnXTOoJnvD/8pysoXjNmwp99z4TSGVm/6DocbeTYsW+X1g9hQ1LKswu1zEjLC9L9yGwnKm6RqUQY7saYunlQA7adewdNcxaBZ8JLPX3taA8i0tDLoiZMP2Sxl2Xhv97rAbC8yt0kaw1C3lGILq31HacDYwZoP/gl5vBGU6W7kO/0W8tWtrc420nJIr2GO/mTDjaGlIgQgHyR17vAHlWIipw7uUsBpD1GuhAfGyFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(4001150100001)(83380400001)(2906002)(2616005)(66476007)(66556008)(52116002)(5660300002)(66946007)(6666004)(26005)(186003)(36756003)(8936002)(6506007)(6512007)(478600001)(38350700002)(38100700002)(8676002)(41300700001)(6486002)(86362001)(4326008)(6916009)(316002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm5WUFU5VHd1Rm00SW1sVnFXcHJqbXVkeEZkTUpSblNpZ2Q3K2ZGS1prbkFG?=
 =?utf-8?B?MlRzeFhURlptQjY4RDdTNmZ5djZGejVsbC9DalAwc2pKaUIvNm5MUm5pSjNU?=
 =?utf-8?B?SDcxelQwSTFyTzJBNUF1eDQrb0M5aTR5N0V3UlB4K2d6M0FsWHJYY2cvbmtP?=
 =?utf-8?B?RzBWemd0bGQycmltcTZzN01HVkxYOWRpU21lMGhESVUwci9SVi95dlBRVlNa?=
 =?utf-8?B?R3VPQkNmNGNmeGVSMVlZYmhsZmJaL08xR0VLZXNrejRLQ0pZWjhqaWtVR3hO?=
 =?utf-8?B?RVVady9LYWoxaW85S1kyWXpNcDN5eDVxaXVRWCszYkIxR3Y3cFk4UC9COHJ2?=
 =?utf-8?B?czFGenhBcFltRm5ZRlBXdExmaWxNYVhiODNQY1B3ckFyNlhlMU8wMWdmaFJ2?=
 =?utf-8?B?YkRldm9DOU1oNGFReElZeU40RGdmUTdVK0UyaUZpVDhERlQra1E4NHhxVGQy?=
 =?utf-8?B?NUZLcEZEYzNJbXRpeTkrV1VLZXkzb3hvc01NYjl2TlR4QnhGTnh5VjdsRUNm?=
 =?utf-8?B?M1JZSlZ3SGptdStkNThhRjNkQkxlTzh1Y0tkbVlaQ1ZLU1pQVDdoRUYvRkVI?=
 =?utf-8?B?U3VuNGk5YitSVnVnUjZ2UkRSdnlHWXl0RHhqMWNVMnBvZS80dk84YVZCTWZJ?=
 =?utf-8?B?bWIra0dSWFNjUHhIbkVHZU9vdDN5TStHVjZIbFNXS3BDc09yZDE0eUdJTEJI?=
 =?utf-8?B?RyttdGt0ZE55ajVZUUZzRjdMZnVKZXRNVWJQd0JKbWdLd2xLWGdkWEpJZmJL?=
 =?utf-8?B?L24reG43RklLVm5mMmgxMUNXditoTmJUMEVEMXhSN01IOTM3cjNoMGc0aWhI?=
 =?utf-8?B?K1ZQd2wxVGhDZVZLUGZqaVRpWUFXbmpNL1lwRklVOWFvTStlQ0p6U1VBVTRD?=
 =?utf-8?B?OURYQVNJeHh2bzNWenhlbVV5ZDlMT3JFaEJmaVBsVjhoaUEyUGcrQkx3eXRh?=
 =?utf-8?B?SHZHYWVkWmJUNlNsQ2tFV3BKYWVGSXhkN0I3Vnc5VWRXTjZpUTRIMkRoWEIr?=
 =?utf-8?B?K28zOWNmMWJmd3VTQ21icVpySGNQTE9rSVBMdnUydUU2THdCTU0yYkdXTEJQ?=
 =?utf-8?B?M0grYmhJVWtPUjlucVVLWU42eTJOUGp0amI4elpCRHNXZzZHQTJpMjdjcWNy?=
 =?utf-8?B?dE40ZEFTL1A1eWRMWGNYRFQxS2xLaEdpWjJHc2ZPMmdaSW9tL21Oci9MMmEr?=
 =?utf-8?B?S0d4NEJScDJYNHo5YWhKTGpwYWhvTUtBZXdvRTdVNkdMOFZiWnVJUTBLUkwr?=
 =?utf-8?B?VXE4eTFLcnJoMnNTdTU5T2V6c2hHa2NyMk5LZkduSXRYVU5WTHczK2dyTXpC?=
 =?utf-8?B?c1NOUnpGNk9rY2tJOHplcnFBVk9RaCtXRzQ0aUhNN0FBbm93UndRbmpOaFF6?=
 =?utf-8?B?Z0VyeDlGcGp3L3hsK3IyNVN6MGtjTTQwRGpqYlhTUXFMbGNRSVZvT0swZGpp?=
 =?utf-8?B?S3p3QVdBSllRKzF3S1daOVhjaVZBUmMzZC9YTkVHL0FDdUh1UXdJak4xM3ll?=
 =?utf-8?B?ZDJjN0hBRjVjU2hLS2Q4TTBBcXc1QkR3TThyc01UUDFhdkRqRDlPR1lrQTgw?=
 =?utf-8?B?bjZCc2dGZGlhNjNYQ2szMUw3VWx1cVBkSzJqdjlKWFY0VXRzN2xRUy94T0hz?=
 =?utf-8?B?YmxHb1oycjV5TXQzbFROUENPMFEvZnpkWnZ1MlVEeDNVWEY3ZW1WSzJTcCsz?=
 =?utf-8?B?WTBtUElyLzN2NEtCOHR6VHlyUWFBSzYzRVFJZEtXdXBUUWhSYW9HUjN5ZWlV?=
 =?utf-8?B?SjEvdTR5b0libmlFUUt5c3NSVjUreUg2TjlWRlIyRXlUUWw1RldSQm53SWJE?=
 =?utf-8?B?WVltbXRLSjZuZlNCVHlmOHM5eFE3cjFJZFJmUStCanhVSkR6YTN4eExHeXBP?=
 =?utf-8?B?VjBQcWRxT2x2K2xrbXVOaDkrbzRjR1Z1KzFGOFlaZUoxZ0Fnd1JCY0dlYUJt?=
 =?utf-8?B?cmx5cFFnWlpNTjdJOGFrMndjWlZGb3AvVnd6QzJkeGdVWW5IVEEzdk1LTzRw?=
 =?utf-8?B?UDMxMXVYdHhySDFMOVlaY2FraXRwYXJDb2cwdEVaMGNzTzdPbHZNam1sR2ox?=
 =?utf-8?B?VHBRd2N3aU40VlFmWTh0eFc1aURWNDNrb1VOdmNrMTdTSXpxcWdxTzhNaFE1?=
 =?utf-8?Q?jYmR+SJdB+HCKN6e/5kZGMjHd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc52c1ef-2bfc-443b-56ee-08daf2bdf670
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 03:51:33.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJVO0+K/CYnAkZMRaoQfEkHcqKJVYoHu9UZjzNLIONT6BhNAEmX50lszzQdMpUn/FbTFsws3LagpbOY5y/6ESg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-26 at 11:14 +0800, Liu Ying wrote:
> Simple Power-Managed bus controller may need functional clock(s)
> to be enabled before child devices connected to the bus can be
> accessed.  Get the clock(s) as a bulk and enable/disable the
> clock(s) when the bus is being power managed.
> 
> One example is that Freescale i.MX8qxp pixel link MSI bus controller
> needs MSI clock and AHB clock to be enabled before accessing child
> devices.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v4->v5:
> * Fix build warnings when CONFIG_PM=n by using RUNTIME_PM_OPS,
>   NOIRQ_SYSTEM_SLEEP_PM_OPS and pm_ptr macros.
> * Drop Geert's R-b tag due to the fix.
> * Resend based on v6.2-rc1.
> 
> v3->v4:
> * Drop unnecessary 'bus == NULL' check from
> simple_pm_bus_runtime_{suspend,resume}.
>   (Geert)
> * Add Geert's R-b tag.
> 
> v1->v3:
> * No change.
> 
>  drivers/bus/simple-pm-bus.c | 46
> +++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Gentle ping.

Regards,
Liu Ying

> 
> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-
> bus.c
> index 6b8d6257ed8a..7afe1947e1c0 100644
> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -8,17 +8,24 @@
>   * for more details.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  
> +struct simple_pm_bus {
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +};
> +
>  static int simple_pm_bus_probe(struct platform_device *pdev)
>  {
>  	const struct device *dev = &pdev->dev;
>  	const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
>  	struct device_node *np = dev->of_node;
>  	const struct of_device_id *match;
> +	struct simple_pm_bus *bus;
>  
>  	/*
>  	 * Allow user to use driver_override to bind this driver to a
> @@ -44,6 +51,16 @@ static int simple_pm_bus_probe(struct
> platform_device *pdev)
>  			return -ENODEV;
>  	}
>  
> +	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus->clks);
> +	if (bus->num_clks < 0)
> +		return dev_err_probe(&pdev->dev, bus->num_clks, "failed
> to get clocks\n");
> +
> +	dev_set_drvdata(&pdev->dev, bus);
> +
>  	dev_dbg(&pdev->dev, "%s\n", __func__);
>  
>  	pm_runtime_enable(&pdev->dev);
> @@ -67,6 +84,34 @@ static int simple_pm_bus_remove(struct
> platform_device *pdev)
>  	return 0;
>  }
>  
> +static int simple_pm_bus_runtime_suspend(struct device *dev)
> +{
> +	struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +
> +	clk_bulk_disable_unprepare(bus->num_clks, bus->clks);
> +
> +	return 0;
> +}
> +
> +static int simple_pm_bus_runtime_resume(struct device *dev)
> +{
> +	struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(bus->num_clks, bus->clks);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clocks: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops simple_pm_bus_pm_ops = {
> +	RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend,
> simple_pm_bus_runtime_resume, NULL)
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> pm_runtime_force_resume)
> +};
> +
>  #define ONLY_BUS	((void *) 1) /* Match if the device is only a
> bus. */
>  
>  static const struct of_device_id simple_pm_bus_of_match[] = {
> @@ -85,6 +130,7 @@ static struct platform_driver simple_pm_bus_driver
> = {
>  	.driver = {
>  		.name = "simple-pm-bus",
>  		.of_match_table = simple_pm_bus_of_match,
> +		.pm = pm_ptr(&simple_pm_bus_pm_ops),
>  	},
>  };
>  

