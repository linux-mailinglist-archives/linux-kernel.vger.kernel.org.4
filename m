Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C411373F10A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjF0C63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjF0C60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:58:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C10510C;
        Mon, 26 Jun 2023 19:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii9Yhlq1QJJGupOnSKkFAIrZGRUkjyC+5Z5ybFpP9gvTH/+iXucyJ+4pAYASGLVK7Li3hKFDj4umd672P40NnvlWqjZJAoS4MMZdO6byflVyFQWQBvN66wTlYLhuR1ntj3hyJmJ19JjQOwo389BmJapqFWbD9fWxH0Ek0j1M2gOo/UJWbKAMWQFhObFAEa/GyjXCLO6i8oYoszgtn5CYHTYqB9YRJ6TkEtD42cmevssZytKXs4986MBJORlolNvFlxcjdOkP7TGLUIiZzacZ6C1iTUg/G+4CQ/lVsUDdC2O3O3FVPvvFkUR9vramUMYCqLGeoq7OMJkNT3roJZvsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPa0Go/flytUesKvk9Rg3Gd3bcWkaCUL78YvJNW/u3w=;
 b=oGx7fkhG8Ulsu+3cOi8iyORTEmA80lsv0EYZFrTLbaysiy9PneZImoayaycaTr1hTnH178/MgV81KiUjEazg7bV6OA9nfhV2crKsE6LQqc2Q/uM5e9EazdA4/MqA0aCKlfTXIyCIFbS4Kev2BA40kYr8lDP3QuRBGs+HFukU9LUVBCdLMvFXc+bPQgCnAuxlXdTnp2X+psuCgw01JAnbLu6opS2FajoX0sm6ifWTlnO5YIanik8hLFLJsduAkWrTky5At8ECJOoQ5TEaIy7csw1hZACt2R6d4GyE4KfY0ODSPMsuZ8X/FdZ+/c45nt4xYpAhCmeaprqUdrVd+oCKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPa0Go/flytUesKvk9Rg3Gd3bcWkaCUL78YvJNW/u3w=;
 b=Y7893OmQrp0j5mYlHDT2HZXcP9dvt+428FovOGwvjGJNxxYYo7FTrqLd0S047KJTNiNIr9hMqOkbG7W9tvscO+nRQr3+3GUqLXudBLMGRTfu7eF2wvV9+UMwoh3lK0fnWlv9tv9S5A8sAjClIJ5MKQppC1ceDqSg3gixlLmW+noQJ3Te/hCXIZBSjHR2UDo4EfV55RwanNMOAH6jOdhhFEFa02swVfUBMofrWJ3YP8CaS2/c7y/Kc/mlcncbEp65uxExhQsueIuipywMv+K5Z/QYqW02B1GsWJtekji4V1jP63CPj/VNOqV2uYtqRO+tEUD6mBvDNlbO0dG1Fid8/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4069.apcprd06.prod.outlook.com (2603:1096:301:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 02:58:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 02:58:21 +0000
Message-ID: <2f33ff1e-ec4e-e060-a84d-ee38ed17c9f7@vivo.com>
Date:   Tue, 27 Jun 2023 10:58:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/6] drivers/thermal/rcar_gen3_thermal: Convert to
 devm_platform_ioremap_resource()
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230626124334.15100-1-frank.li@vivo.com>
 <20230626124334.15100-4-frank.li@vivo.com>
 <ZJm8p4GnTG-vtb0Q@oden.dyn.berto.se>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <ZJm8p4GnTG-vtb0Q@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6993b5e8-1087-4349-cb02-08db76ba5d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0s0MD7bVo7jV62S9sZKzxYI300gPbvIxLPtA57z/iuC9bN0ciGfE9/K7N9IaMhykiGeqadyIYprqzMqKdVN17IQPLCR/333gJix9RiZlr9ssCltNNFBCpI3ZNskaAfRe+qY/MotOK0siCM//4kwa0JLSXq9WXgDKeIEXs1sjCvRndqnRrIb0j7vWXcMCXDYb439bahsTDdjj9e269VVdDnpLBDilHPEwnsDIaekLWSZW/9I73dLg4wBdWBrBN9gmJ1/4QOy3lkUzvpGHi7XNB0If66+sBvfBnjKVR05J8zxFxf7XasSDFfEhuBHj75UpBjymQ6pyp0mO6Jjwy8EO8A70Tp/HvEPfGHlHk4zgz+AJiDQxfjo/YNNbWg8gf3S0LSwcFHkbH5Rx+KzQfDC+UNhFZTSfM2j5zEsYyBa4PVBIQZ4PcGjcxRxe2GiMIKYOSqgU1hO1/DnANSa1fbBwZWq+q+euR/YYQaDCdDLpketOWYyDWMVKMHg1JUvHK1UwYWq3bBsgymoT9ZQqoAxxEYZODkAv7Rym9OqRvizovDCP4y0Uy/1a8aYLl0dwqTYgk8NiydGPkPfhClqM7YPAx/ozEHasbCq8GWh1YdrhXC/9tFDh+Q6Yl898MZfJ+pPvAJCYwqRBLwuc7ObtrVGXsxkEFqRme1fq093jH76Iu66PAQFnG5oit7F/41aL8rn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(346002)(136003)(376002)(366004)(451199021)(316002)(66556008)(66946007)(66476007)(6916009)(478600001)(4326008)(36756003)(8936002)(8676002)(5660300002)(31686004)(31696002)(86362001)(54906003)(41300700001)(6486002)(2906002)(52116002)(53546011)(26005)(186003)(6506007)(6512007)(38100700002)(83380400001)(38350700002)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1RxRTJJT0UxRnVlQmUyRmF3NTVvbWt3c3UvYmV2VmhXWXJLZkJ6dWVDYWE0?=
 =?utf-8?B?eWIrMER3UjdGdk9JTW03SGxQOHhVcHg3eTdhekxUNDhHak1KNCtnWjA4ZHhl?=
 =?utf-8?B?VVh4NXhZT2RaNStBc1JrdmV0UXZOOFVNVE1wWjBVbjZHcUxidTZ4OG9zWXVn?=
 =?utf-8?B?RVY0STFMT3Z5NkZaWWdJcUU4RkhOMjM4cU9LUU1UUFhkaVFFZ004cXJLZjFJ?=
 =?utf-8?B?YVkrVVRPOEVpekZQM2wzRFMvWGZIR3Z2WjJTcnNaMVIyWHlVWjlTWFYxdm5T?=
 =?utf-8?B?b1JHenZ4dHdQenNudWM2elJCVVlRaDRxZTRxRHdiaXBJeHN2ZzZ4K2NUUXBE?=
 =?utf-8?B?TVdxL0MrU2hmUGFCYzlneXdwdC9EUG9jTDllZmNuSXF6UDVJOGxhYjFBdk5p?=
 =?utf-8?B?WGNBMWt0Z2NHMnZCakp6c2FtMDk5aFEwQ3F4RS96WGk5d29TcXlOZ3MvR1U4?=
 =?utf-8?B?ZFBtSmlYR2U0dC9aRFZUTjRmUG5xc2p6NE00NjZZUGVMTmkrcGExKzFqd0FE?=
 =?utf-8?B?M3RJWmhKcTF0eVM5SC9tQThxdXBnQmNnOE5xaVRLQlZ4WDZJblpTZ1ZHcDhs?=
 =?utf-8?B?VVo2M2RsTkE1czA4VjlSazR3VnlRRGFOcEZ5dzM4T05mU2h6ekRUQTloTGhR?=
 =?utf-8?B?U0xwS0FYZEI4QThSRnFkeFRpc0ZLZTR0MXFrWW85M0tacDZETzhjQUlYMGlZ?=
 =?utf-8?B?Z29NOXRTUG9sS2diRjU5KzF3NWpBVG9nelBQMUFUeHFVRmR3d0VSRzBxdyti?=
 =?utf-8?B?ZmRhckJyZGRHVlRESnFRazJiSkVzVXJlb2NxeVVuc1Y1UzBCSGZBc0dBODhK?=
 =?utf-8?B?aGhWUXJwVVU1YlM2OW5oZXBhNURHdUdUUElMZkM0TGpTbDkrTUtIODZsb0FV?=
 =?utf-8?B?OElaTFdHZ3JrRTJZbWpBQ2pYVmRnT3ZVK1pxQlFVWUVsNmY0Ry9Ya0c1NVpV?=
 =?utf-8?B?KzB3cEtRakMvTnVUajV6dC9CKzh0ZDZmRmp3UmhQSnA0LzRXMUNsdkV2WGY4?=
 =?utf-8?B?Sk40VmNoUzVuNXhpejdPYitPYWMyajd6V2JDN1RYZUxjYTNaQ3lEbEFBNW5J?=
 =?utf-8?B?M2l0WDFZQTdyWUR1SXlFOGI4L3BLQXUvRTEzTVJjT3RyMDZmbTZtU1NFb1Fi?=
 =?utf-8?B?TjdValFEV2VVY3NpMTNETHRxVDNONGpWbVpsOEtMRi9PMk1NbEhBUFBOdk5h?=
 =?utf-8?B?UHh3blFsbURQYzJtMTIvOURBaWdKUU8wc2E3S0s4anRwaStLV1oreTY4cjB2?=
 =?utf-8?B?L3RGR0hiSE9ST3FSa2lvQ1g3UGo4MnM3TVBoVWw3ZWs5S2RiT0trMUQyUUhs?=
 =?utf-8?B?OWV0TnQ4bWxUZkJuK2djZEltSW9vQTB1Q0VqNWlidnFhZ0NYZ3Y4VTNTTEN4?=
 =?utf-8?B?bU1zQVBaSVc4a3lTQ3FoeXRTRjlPcXkyVjRKZzB1VDVBY1hLSEMxaS90TnNk?=
 =?utf-8?B?azhBam41MHFJWVo4cU14TzJQMVB0a1FscytwZlVESll4NjdiazB6dFVZRXR3?=
 =?utf-8?B?TTlTWnpucklJSTdOVFJVMmRSYzFzdG1MUjkxWjRCU2FTeS9mMHR6VWh4Tld4?=
 =?utf-8?B?NGUzbXNuajA0M1NHdWFKOS9Zc3ZjbDY4SE03MDc2MzI2QXRNYmVBbURzUDk3?=
 =?utf-8?B?ZG03bUx6enVjcnNOSWZUdzF1VEJqYmhSanJ0U00xNFBYU1ppSGVMaWM0RFIr?=
 =?utf-8?B?blNEVERNUTV2N2ZOWkxrMHNObTMxelIzUW5xbWJqc3owN2NLSDU5U1JOblNn?=
 =?utf-8?B?OFdKdU5NWjZGc0dOSjkxTklGNy9aWFdjaDJrZElCU01qQWNldWlNTGtSKzZS?=
 =?utf-8?B?SlNSaDJDVmNxamtOWkVlakpYV0tldVJSVWlqbk5Lc1BqcVBacGJtcXJqaXFw?=
 =?utf-8?B?Z0xXbHYyTnZqTE80M2Z1cm5QTzkwenlmZ2orY3dCd3hPRkVPUmc2cmhCdVV3?=
 =?utf-8?B?d3BMRDN1K0dkZGR2cUZnVVUvbDQ2QzJKcTJvb3p5ZGQwUndHUTg4ZjQxVmVB?=
 =?utf-8?B?Mm5aUjQ1Um9WWVN1dWF5UUgrSjBOblRCUUMwRGU4YzN4ODllZ01qbUZLc0pn?=
 =?utf-8?B?QVoxUEt6ZnlIU0pBbXNtWlQ3Z2ZEZTdTMEpUMm5EK29Nb0o0MnNzWVZYQy96?=
 =?utf-8?Q?/Ls5nALWtOex+cTLG0xo0mZO2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6993b5e8-1087-4349-cb02-08db76ba5d4e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:58:20.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ispqvn8ANLmJY7kw0K662ZLvUH1/+PvLHMM7DoDyMWnUkYwhD6XK/WLm3AzyUpRxnhULhrUNR5QpHcwahd0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4069
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On 2023/6/27 0:28, Niklas Söderlund wrote:

> Hi Yangtao,
>
> Thanks for your work.
>
> On 2023-06-26 20:43:31 +0800, Yangtao Li wrote:
>> Use devm_platform_ioremap_resource() to simplify code.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> This do indeed simplify the code, but it also breaks the driver :-)

How about the patch below? Can the following rcar driver also take a 
similar approach?


diff --git a/drivers/thermal/rcar_gen3_thermal.c 
b/drivers/thermal/rcar_gen3_thermal.c
index 9029d01e029b..0cd9a030eb9e 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -481,7 +481,6 @@ static int rcar_gen3_thermal_probe(struct 
platform_device *pdev)
  {
         struct rcar_gen3_thermal_priv *priv;
         struct device *dev = &pdev->dev;
-       struct resource *res;
         struct thermal_zone_device *zone;
         unsigned int i;
         int ret;
@@ -503,22 +502,23 @@ static int rcar_gen3_thermal_probe(struct 
platform_device *pdev)

         for (i = 0; i < TSC_MAX_NUM; i++) {
                 struct rcar_gen3_thermal_tsc *tsc;
+               void __iomem *base;

-               res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-               if (!res)
-                       break;
+               base = devm_platform_ioremap_resource(pdev, i);
+               if (IS_ERR(base)) {
+                       if (PTR_ERR(base) == -EINVAL)
+                               break;

-               tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
-               if (!tsc) {
-                       ret = -ENOMEM;
+                       ret = PTR_ERR(base);
                         goto error_unregister;
                 }

-               tsc->base = devm_ioremap_resource(dev, res);
-               if (IS_ERR(tsc->base)) {
-                       ret = PTR_ERR(tsc->base);
+               tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
+               if (!tsc) {
+                       ret = -ENOMEM;
                         goto error_unregister;
                 }
+               tsc->base = base;

                 priv->tscs[i] = tsc;
         }


> Before the change, failing to find a resource at position "i", breaks
> the probe loop, and probing continues and the number of resource
> described are the number of TSC find are used.
>
> After the change failing to find all possible TCS will fail the whole
> probe process, even if some TCS where described. And not describing max
> number of TCS on each system is perfectly fine.
>
> Nacked-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
>
>> ---
>>   drivers/thermal/rcar_gen3_thermal.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
>> index 9029d01e029b..5c623f13d9ec 100644
>> --- a/drivers/thermal/rcar_gen3_thermal.c
>> +++ b/drivers/thermal/rcar_gen3_thermal.c
>> @@ -481,7 +481,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>>   {
>>   	struct rcar_gen3_thermal_priv *priv;
>>   	struct device *dev = &pdev->dev;
>> -	struct resource *res;
>>   	struct thermal_zone_device *zone;
>>   	unsigned int i;
>>   	int ret;
>> @@ -504,17 +503,13 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>>   	for (i = 0; i < TSC_MAX_NUM; i++) {
>>   		struct rcar_gen3_thermal_tsc *tsc;
>>   
>> -		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
>> -		if (!res)
>> -			break;
>> -
>>   		tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
>>   		if (!tsc) {
>>   			ret = -ENOMEM;
>>   			goto error_unregister;
>>   		}
>>   
>> -		tsc->base = devm_ioremap_resource(dev, res);
>> +		tsc->base = devm_platform_ioremap_resource(pdev, i);
>>   		if (IS_ERR(tsc->base)) {
>>   			ret = PTR_ERR(tsc->base);
>>   			goto error_unregister;
>> -- 
>> 2.39.0
>>
