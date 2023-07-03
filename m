Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8932E745B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGCLrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGCLrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:47:14 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39A0DD;
        Mon,  3 Jul 2023 04:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhVXOVsGODKphvdHZwRp/Ng2hIIQn6rs7N16kqLl6Rh6mV8cXQQGAeO2pDXVhkPVriJp+hSvKyY7X9Vw20W1VNHx/VyN/PSiTrf13gJ3g29/TpLF2e+uQ+Vf/QKoFUIrCos6i7403Ddlm01KnADxTUBeuCR8mBP56mtFqnytwdBeUCZHQ13bMJfDglNURhGiONgR3VbeKQpeU/gFSo1VJ16Ai8mUtDv2wTi5jCHonoVYzEU5WSww6sdsVhoyPHd7gzsHyx6Cti4FoA13nZ6znpKmGzhFZOyafTi/MTuNTT0uY2wWZKP12tJ2u5RMvO4A529xslu3aJ1sYlOHni6avA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzDL5rltfDcG6ji798qc7pzM5LlTr54uHF6jx371a1k=;
 b=dpPSzF2xEX90aDZN0kmOufe+KX4Z29ZMPJmpIFhxRvQt37aj99qlnJqhDzYbwPwkvralfrDp1tvq/XX26Bnd47kKIJziHDl4oIzjQBfdouv7WKITn+fuH1DZG/Ci02oSOqmRCCNr8hjjDg+tvUes0K29vE4jmuFnieUKZus3LfXjh4Jm/T8za+RzVFYmGNrKrirfY0tWGcWLUotz7kOZE/Mbg4ScLKPX0cjbGIxs3igT4AAlKiceNLQ6vXnUtXflucGWDfQyoJ1DMcOfvpfDHm5jzDPgsU0Ml6Efz8Js1tQmE4dKr+Du84znhjynD7Fo2bM5+IXlrj5cr5V2COnMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzDL5rltfDcG6ji798qc7pzM5LlTr54uHF6jx371a1k=;
 b=UbeepGDTSfms0qbCcmgGczdnwzqqCn670rvs6IPiY7NXDgBlNyfRAxIURqYf5c0bEd848stmehC3RXxZHGHpwf9Ec2ljCReDBQxborqe3ajUMN8Za4Jx0+/Krcl7/8Bm7m+B59yfJcnH4tclTYT9VbGBPya3F50sKALIHBi4eWCP+LxHxdZfuOhXDyCvEqDJ7Zj3l5GaME0MNG91LflxZfJY0yiPAOYW8JLEllt5a2Jthzzqn9QJIricMn3gJRGfTkN52cnk7MRXWLtXCowEOuOZY4OjQ49b/2btadaUcjXD+DPx4X/ySp7o+5WNX8szIOHEXge/LNFD0mCusgahww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5014.apcprd06.prod.outlook.com (2603:1096:101:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 11:47:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 11:47:09 +0000
Message-ID: <73d268ad-b6cb-37f3-5aab-35e58e3325dc@vivo.com>
Date:   Mon, 3 Jul 2023 19:47:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 0/5] introduce devm_request_threaded_irq_emsg()
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230703090455.62101-1-frank.li@vivo.com>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20230703090455.62101-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 923aa6e2-c67f-490a-71d5-08db7bbb3b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMM6sWKG7ZPD0RivU1runf1StNqjsvThbli//Hg2jEh51uTVT7toKhO5ueUGPcx0R7k5FmhEuhLmroUQOzloQfaUGliJKKCtGadYMnCV0/+U6nhkB+kx2WMg7MvCbRm1LQ55nzyBRDoa/id+fcPY/Rn4U4L51sIzpn0jxQThO6LULo7j/uQIufYTDK5mdnh1vkc+QE/AqB/WsHYPWr5cMexgAnVdAVRjUUlrxck9qKHAVKFlQd/ruOzZQJOfLTWWwwZs/O5GzbenDP9lBUQyGqL3NdXjgon8x7baTheIpv8FQSPlKhoZq4SPW/D2+5GEWQo1lRZi+bvmk/cTCDfbO5bK/u4QCCHa6ulpZwi4xuIYI24TtI+JJakkr0zjFPB92QqzSkJSuiD/Qz/AyZwskA+s1kOVR/LAZsz00wLBDZqGItNj+OAHfSgaGMU436VsrGaY20PXNPWGmmTUFTK9z+DS8q/unXFTpUlwSbOqGuoHICpKq6qyhKIGletFgyQQM2xlcVAMGs6ijMyHvQmM5Tc6hUFz3Z2hfzH1TaCNqJRgmmyXmHo5IQKGYhxOn9M3DPvP2mdMFF2382JwaLKhCrm6E2W4sMviDs7XFPGlii+7XxOhq1LcUSsoX8WleDJYtRlzKkT+z3r0v43vdHmj4w/v8MNBiayeJe5b1sZ1CoaVgOuVjZazIZhTBppoxTGBDRMT6GymRxfkhgt5gAN6Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(31696002)(41300700001)(6486002)(38100700002)(38350700002)(6666004)(2616005)(921005)(83380400001)(6506007)(26005)(186003)(53546011)(52116002)(6512007)(110136005)(86362001)(478600001)(2906002)(316002)(36756003)(66476007)(4326008)(66556008)(66946007)(8936002)(8676002)(31686004)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXp0c3NBbVZ6R0dvQzQvQ2tpZTdzTUJBbVJXc0xnMjFsZ0RPZGtBaWFNVjlD?=
 =?utf-8?B?V281b25Kb25DUndwTHlmSVpuY0VXbnFzbTZIbHNqbkJZd1A0KzdUdHo1OWNP?=
 =?utf-8?B?UjVGdjY4SFcrbXFHaUFvaGF0YVlETURXdkoxdEg2SDlXY21KMDMrbkowYUFj?=
 =?utf-8?B?YkpvbGhZNDJtU2pJYklVSnNrMW12OUNNbFAwT1BZbXdSNEpHMHhCTGhnTnRL?=
 =?utf-8?B?cndsdlpMWDRvc2dXUktjQ2N6cXZ0elBrU1BheW11TTlBMG1nc3dtSzYvUHIw?=
 =?utf-8?B?azhnQTJmNWRYNEhYS1d4elhCRUdjSmlsSEo3OGYyMk01Q1IySWxLUUhiR3Ar?=
 =?utf-8?B?d1FFVEUyWldCRTNnck9HV2Y3Zm5TSFFmTGdGbHZCenV5cVNzMXM1TndLcDZh?=
 =?utf-8?B?UnRLbEtpSXdjTGlLa1dhZzhFdEUxcWs5b0dhUDNLQUdLcmhZQ2c5VFpwcWtz?=
 =?utf-8?B?QktIcVFGNmVJd0dTMmNvM3JiaUM0Zm1tZVQ3UHNTZXNCTlBSbDRDWThoUHV3?=
 =?utf-8?B?YUVDZGNEZlM0V1pOaDFwNUplT3pHQUtESVVhSXk1YStlTDRPSDNXMk9yVCt1?=
 =?utf-8?B?VkRYVUVPbSthMTNqUXoycmtDM2tGVjNFOGR0c1VjUDl2cUV0aVZHNm1MRm1V?=
 =?utf-8?B?MHFXaHlOOHA1NTF6NVRyU2FsN3I2ZHVtYWp3Yi9MRi90eUkyblc1TnZQbGRu?=
 =?utf-8?B?cFNrRnZtTEVGc1pEME9EUUVLVjg4VW1LaFJFRE9hZ0ZNUEg0cnFiZ0tpNnV6?=
 =?utf-8?B?dzgrRkgwWjcveWU3c3ZMMWRaTFh4S2hRRFZySHlJTnM3WjVuSklOOVBmVGFn?=
 =?utf-8?B?Q1FrTFRjK1RNWXNhaXoyMFlGNU1jL0c4N3l6bUJzN0NVRVo2bllSbkpINTNC?=
 =?utf-8?B?OGJ0RHZrUXVuaU9FenFVanlITTV1b0hPR3YwUGlvY0RoZ01NMVBTejJvRmdC?=
 =?utf-8?B?VTB5REhlY1lKNGdtT01Eb3NrUTE5TjR6RE9SZU9rVW1UQWRhMlZVL3NXTDZV?=
 =?utf-8?B?a211VWNEeXdWTGUrcnRZZmJ2aGttcU5IRE5CdVRPaDZaUGJ0MUdVS3lZUEJK?=
 =?utf-8?B?MDdtMUk0SzZETVBvWEt3dlplODdnNUtRSjhVNGdUNkdJN2NRemhFakg2dU5n?=
 =?utf-8?B?N1ByNkdBTkx6VGNLNVBrcFFoUkpobTIxekx4SXV6eWU0YkVVL0FZRUZkUUtj?=
 =?utf-8?B?eklGd2FSd2w0N2R4UGluMFZUTVZDOG5tWWV3R2ZVUHJyQXU3bGJOMWpNMzNV?=
 =?utf-8?B?TVdxbWF5ellRVkRqcGZaUkJUNzNtQTNsOFRISDZ5QjM4eWduRDJyd3E2WnN6?=
 =?utf-8?B?VjV3TGlQVkpJRDR1bW9ob1ViZDJDVGhiaTNXMjhOSDZnYng1T3Ixdy81d1Ry?=
 =?utf-8?B?K082dE1JNjU4aWtCcElsdElFdWZ6bThxNitqNVVIdkpTZDZobHhweFNNelhL?=
 =?utf-8?B?NHJNcGxGU2FwU3FVck1TTWM4RXlHdXlZSE5FZ3A1TVpGaHZ4YlY5RHhzSUNa?=
 =?utf-8?B?Ym5OM1lPaUQ2RU8yN3U0YUNxU3ZaMjFWcmIwa3BZZmFLbU9TZXFOUklXaGNm?=
 =?utf-8?B?dkc5MVhHRXdzZzAxT2dLdVRqRE9hMWg1MXp4d0ZuNG9zeGRFaWZXTEIxWUF2?=
 =?utf-8?B?ZGVOLzBOTnBJMzVyaWFnWEhzQWlmdzEzRU9Nc28rdEh3YWNsN25yUG5ObHJY?=
 =?utf-8?B?bHVVN2EzWTFvWkg1SHVBazJRdWxoK1VZRkVseFVyQVlhZ21tb3Q5RklDRTFu?=
 =?utf-8?B?akJzNWlEdGphQ3RFNXF4R1RoWVJCM2VxV0cyTDdtRm1GZkE3bnB0WDhqdUs1?=
 =?utf-8?B?LzlSVjNuS3I3N2pQY1V1T1h1dmlxVXNlQXdlS09SbUp2c09PR0RMdlJnaXZh?=
 =?utf-8?B?bzJVN3ZDV2hjV2V2WGoyOW9ORjd1NjZlZ2RDSGh5RWxOcXprc2NnTzNUWG5z?=
 =?utf-8?B?allQY3IwL1QzaU5OZGdrckh1YXdQak4rd3NZR0orK1RnVFVETHBZSmxRMkND?=
 =?utf-8?B?cEZGbHo1UFVQYzRSckl1ZnRzVkkwUUJmNzhDWWxzdHFwb1hvN2M0c2gySUZz?=
 =?utf-8?B?RUdrRFcyZ2ZGckhqQ3RTbDlyTFNuZFUxeERudldoWjZZVjFxSS90K3QzVnds?=
 =?utf-8?Q?yHj+Q6y/HgkJaClsnKLsM+7/F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923aa6e2-c67f-490a-71d5-08db7bbb3b8c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 11:47:09.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPTl65Fo0GvXCsIAjntk8eW5dM9JWQkO4C7I0uCKmyP2JGfOfSwlZJ1wTM6nfN7U66xNmjBUt0JxAmTTt9uKrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5014
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc u.kleine-koenig@pengutronix.de, krzysztof.kozlowski@linaro.org

On 2023/7/3 17:04, Yangtao Li wrote:
> There are more than 700 calls to the devm_request_threaded_irq method.
> Most drivers only request one interrupt resource, and these error
> messages are basically the same. If error messages are printed
> everywhere, more than 1000 lines of code can be saved by removing the
> msg in the driver.
>
> And tglx point out that:
>
>    If we actually look at the call sites of
>    devm_request_threaded_irq() then the vast majority of them print more or
>    less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>
>       519 messages total (there are probably more)
>
>       352 unique messages
>
>       323 unique messages after lower casing
>
>           Those 323 are mostly just variants of the same patterns with
>           slight modifications in formatting and information provided.
>
>       186 of these messages do not deliver any useful information,
>           e.g. "no irq", "
>
>       The most useful one of all is: "could request wakeup irq: %d"
>
>    So there is certainly an argument to be made that this particular
>    function should print a well formatted and informative error message.
>
>    It's not a general allocator like kmalloc(). It's specialized and in the
>    vast majority of cases failing to request the interrupt causes the
>    device probe to fail. So having proper and consistent information why
>    the device cannot be used _is_ useful.
>
> So add devm_request_threaded_irq_emsg(), which ensure that all error
> handling branches print error information. In this way, when this function
> fails, the upper-layer functions can directly return an error code without
> missing debugging information. Otherwise, the error message will be
> printed redundantly or missing.
>
> Yangtao Li (5):
>    genirq/devres: Add devm_request_threaded_irq_emsg()
>    thermal/drivers/armada: convert to use
>      devm_request_threaded_irq_emsg()
>    thermal/drivers/brcmstb_thermal: convert to use
>      devm_request_threaded_irq_emsg()
>    thermal/drivers/db8500: convert to use
>      devm_request_threaded_irq_emsg()
>    thermal/drivers/mediatek/lvts_thermal: convert to use
>      devm_request_threaded_irq_emsg()
>
>   drivers/thermal/armada_thermal.c           | 13 +++----
>   drivers/thermal/broadcom/brcmstb_thermal.c | 12 +++----
>   drivers/thermal/db8500_thermal.c           | 16 ++++-----
>   drivers/thermal/mediatek/lvts_thermal.c    |  6 ++--
>   include/linux/interrupt.h                  |  6 ++++
>   kernel/irq/devres.c                        | 42 ++++++++++++++++++++++
>   6 files changed, 67 insertions(+), 28 deletions(-)
>
