Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86076B12AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCHUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCHUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:09:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFF273037;
        Wed,  8 Mar 2023 12:09:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSWP1IObAjlCty9xxTDHgvVinvf2KKONN5R0VrsahPVBskOWd2fsdenUQUkJQIaIuDK3FHwBoWzSsiiJxX848dvXROpxHEFSEujJ8ePGQwAOPW8UIl7caif3guspxrILnXU8uDLvmeDxileZLFK17bFU4ptDwOlW1TF8ESfVMk+yD8HvoViWoybRlDRT3YcJP1tl26du8pTh6fUnBy1urWr54dbTJ0f6p79KtgmZz/eRTHPjKPQvCSJPwRzyL6LEbtD6AIBlzCr1Bd/zL8Fd0Y5ZSvCUeABprIpTpkq+F4LSUIo8dnV8VZslABpwYlEljj3dDQ+XhWfpvcgZzSgwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQz+3w1dT9A8V1JpnLMz4Nkdk2Z3mgBsbwjlQ2u38+8=;
 b=hPp1GuYYd5V9FakVanuIt6XdA47DYh0I3d3qHP4eTrKj7VZwKgicL9lQKD5i3FKBIohjDyOgPtXCdCej96b5amyLr8N/wuC9MnkNTpOMC68TPyEwWJEhxd3DALLlWLOn8LV1QIbk62vxCtRzfFY7tNxqftmWbinHa+FBbNyR6HNpHSK8+ndQ+hi/dxIwA/e0UCO/mzuk+xVZqv6f3804kwov4HwLN95pvcglHyiIMBjzuc/1fl7dSfPfmMqgW155f7BgM+f41uhVWFdoF7ubPRx35/Ywj4f69jUBeq6EzU9Ue6g1z6wasHwwIcwo+RMafK15gyowWNQ531S+GPfuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQz+3w1dT9A8V1JpnLMz4Nkdk2Z3mgBsbwjlQ2u38+8=;
 b=DaEU5jJjv7cy1cje2ihe295ozTNudLWnlbKRIneEeMEDNSewxw6MzAJQm/NpzoJrevQjvL1pHWYfZPPXRW+9jhZmOwBLkXpUg+ic+ZDS6x+X7NCejs7CIUiyZrzsjXzw5KB6vn8Vk/V91SEtnt/4CTpgQqROVFoWfK/FAEMDnLw9AS73rOk3vms8Ur8+GjBIE8YjNtQBIpF0NYdxRbIXjzdsls4UQ3AXVUIOJxlyzNPaXkbEMnHjS+T53IyU+RHcqzeUbi5mPtL3vedVZa2S5A3AWWSgH4plohiO0mCkfbSBTTeSdUbr1VedxqGA3NvRlqZxroh2QUZoUpl/8TyxTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Wed, 8 Mar
 2023 20:09:19 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%4]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 20:09:18 +0000
Message-ID: <18f9a6ca-a61b-4cbb-b729-1fdb6d48651a@nvidia.com>
Date:   Wed, 8 Mar 2023 12:09:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] dt-bindings: timestamp: Add Tegra234 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20230214115553.10416-1-dipenp@nvidia.com>
 <20230214115553.10416-5-dipenp@nvidia.com>
 <3c0ad963-ce69-bd5b-20cd-888e5fbdecaf@kernel.org>
 <7a8027c9-dc73-3684-c5f2-3071f315b3cd@nvidia.com>
 <a5e897e5-4cb9-d50f-47a8-ffb8bd8774cb@kernel.org>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <a5e897e5-4cb9-d50f-47a8-ffb8bd8774cb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::17) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2b6031-ec97-4fb0-3505-08db2010ffbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLYTvoLYkZCt6OsEIOqZg2dO9gxLodpqs+RdNs3v/ptsty0BdD66CqHNs88FyebcU5c7Up9Nrvz+VtXSuMLci9MofDD49LhFMTv88tzs04+7fiOuFHJf+S8g3yXoOp4e2Z+1zouEcYXOPUpvS3nQXTuCnO2kt7G0QPlcF2NQia05Cv8R5+YbRBw55J/+Hll8xVDDTvE2SLbC8IbiPJ6iUmOX8Ke+H1bqbSbL3IJw85Y7gc3rEMY1sm37qmTl04qAK9dp6z18rQYnn23qIj+oKeGG1Mtt+7oxaVrVY/W4CmYLlMtqMSpnPCn/2+NnhOLi2qlWyKsOvmE5ITj+zW21izoVZHKQGCeqCYUisvLxl1w8T3dgSybPWjsQBvqQ1HvNlqTHzrUdjYVEsRJ6/oMZPrUO8eE0f1cC1SNqOSOzqzAXZox58s5N3lBJT6ESr6XLeAnjGAoVRtJX1M4I7B6Y7+jx0n/V5PeyneBDbiiFEzSP86dqNjmCndDq/AcqWWgBf1+dARVpM5ZUAeIkphi1gPWaGOPWXWMGA5fXm8n0EDrSWqGboc64IK9XwFO4/YKwFj3TNbAUZI1TnztYj7VYb8ellO5yl4h5k6sGWIUdaHOoYrgnU7mPl1TVnefK7xoJ6X/TyUnkiGaamJv2wkwKVmEa4p1KRgnc1UufBLX59Pp253fvjP50+wlmtkgq3bQS7b0+l52uIByAfAlqSg2/Y+qW4NQQ5FWzXzdiEUhpxMq8WqP2PsiTNarpXV1XMOD9PldaS+4te8dkRwS1rSUL/19ybI3n7m4JwJ/koMj4Iv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199018)(36756003)(478600001)(966005)(6486002)(316002)(7416002)(5660300002)(2906002)(66946007)(66476007)(8676002)(66556008)(8936002)(41300700001)(6512007)(38100700002)(921005)(31696002)(86362001)(186003)(6666004)(26005)(2616005)(53546011)(6506007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm5DeDByaUxjcHExYTcwSU5tZUZWeHh1dDlvQ2VJRW8xOHdCN0dSdEp4bUZI?=
 =?utf-8?B?ODdZUEZPSkJoTSs4THVuMXluVU1Ca293aW5BTU4wSXVBRy9PdkdFM2ZrdXpK?=
 =?utf-8?B?NUdhY1p1NW5MT1BadXp4VUl4UE5STmtHbHBiYk05MmNZRk85VFc5b2VrVnVR?=
 =?utf-8?B?dXZZKzdNaEdLMGt1L3ZxdXJRa1FVNytFUWV6Z2xmTDlkQXUxVUJSZ3NEWC90?=
 =?utf-8?B?cjlGbENJdm0rakhyTVVxSVM5cWtsRExsZkduRFVtanRiUTZLbmNHSDBOTk5z?=
 =?utf-8?B?YXFXQTNGbWVzRUcvY3U5cit3L3g3WmtxNmVhQkZOYWtEcld1TFAyaGxYUDBo?=
 =?utf-8?B?NzhCWXF4Ym5UL3FWNHNaMDU1d1BQV2pxYnRmKzRhTFV0S1pFbzA4ZS9mdDlp?=
 =?utf-8?B?L3pDTFV6ejF2NWZVZHgrc1M1SUdNdnpER2Fna01GQjg0SkMyVmVkUjcwQ0o2?=
 =?utf-8?B?MU5neW4xOTBQajdGMnNqanFRcEVVTHZSbVBmazg1Tm1vdkMzYVJqd0NPMStn?=
 =?utf-8?B?S0JtZ2VzQ1FvZlZQQzhNdEpxd1ltOWFMRGFnMmNpV3JjT2QrV1Q4R3Z3Qm41?=
 =?utf-8?B?NVh2UVdDRzYxdXByYW5xVnBwQ1FHTmlwQW9aZXE4Unc2akd4QWFndnh6UTNE?=
 =?utf-8?B?RmY3azBtK0wwNGQ4ZmtXZzRabnhyYXRQSERkODgyUmtyRFpRVWhFclJoaGti?=
 =?utf-8?B?VUN1M2lybFpTVUhiZVZpbmdDejBSVjJJQzlnY05qNitGZWxyWXdTWFlreCtn?=
 =?utf-8?B?VmxBY0hSRHU5ak43aUlvb2QyL084RlVrUVdMNnNIMi80UnlYUzlQanRlQ215?=
 =?utf-8?B?cENzMllwZWNWUFZkTFJSeDB3bFhUcG1ZL05vRHJjMUtkSlpxRk1QSm14M3Er?=
 =?utf-8?B?QWozcTRvQ29oeUdZOThyWHhaeUtocmhOVjZqY3pGWlVZbnJIR0h0LzllMWh0?=
 =?utf-8?B?eWZUMzRRVGhOV1dmcXhlczBvQVNNZlBVUS93WjU3YU5xdEo1cGJUZzd5c3VE?=
 =?utf-8?B?UFUyOHphZ3pYOXpZajk0NE02bjI0L3NQaXlSa2FrNDBzN1VsVHUwckNTYlBv?=
 =?utf-8?B?NmlxQW9YbGdleDZ0S3VpbGNLdW13UC9QZXloUWY5cVdPT2F0SEVuL3dCU2F1?=
 =?utf-8?B?Zm5oV2V5dlNBWUx6N3JwUURyMEZrZ2VNOU03cVppUzNUVXp5cGpnWGhWY1h6?=
 =?utf-8?B?cncrQ2ZOeTZSTUJLWFUwdGdQd2d6Ry9kWmkvRDJVNTdISzZ3azBpb3BGNVEr?=
 =?utf-8?B?Z1JvVy9DRFRIZEJHTE1ZTTkrdHBaQmxkKzE1dEMyaEhHNzhxdGFsa3VjbTNo?=
 =?utf-8?B?NXprMkM5enN0MXB0cUFDSXJlZVcxUEo3cEhKZ0RtbjVxQllKeDhDclBRcDZK?=
 =?utf-8?B?Z05ERGJhSkxMVDRQY0pDKzJpUTJtMXlrN1RDaUN4Y09GTy9YQzhCaTg1U2xv?=
 =?utf-8?B?ZG1sajZNQnpJS0p5MmpBbWtrN1QvYUY3YXN6N0RrY1ZsSVk0RnFpN3lsSHRi?=
 =?utf-8?B?bVVlTi9MQzZIZnY3V2xrc0I2c0FKQTdZU3U3REpaZlZuZkQyMUN3SEMvUVBO?=
 =?utf-8?B?OXJwcWlUYUhuODQvNGtCa05GUEwwS3RteGgweW53WjlSZ2VIbUhNeGtseDBX?=
 =?utf-8?B?MEVvc2prUTg4RkF0Qkk4citLS3lqc3diVFpXbnl3ZVFMLzVnams2NDhQSkxK?=
 =?utf-8?B?ODFRRWtrbVhYZjlGU1UyR0J6NWxKUkhBRHhKeHhsa1pRV3hlVGp4Tlh6aG80?=
 =?utf-8?B?U2ZpUnhoZlJtTFVDbzYyYmthOVNOMGE1WjhNOUlTZGRjNTBjTVU5cWZtV3RJ?=
 =?utf-8?B?NzFhejF1SHlJeVhIZ3lrR3VNalFKYmwyNUhpTFV5N25kUGttWGJsdkhwUmE5?=
 =?utf-8?B?YUdTSXNtRkdTRkpjWkQwS1RzYnlTZktzeGRNcnVENEhoWmEwcGt4WmM1QlNW?=
 =?utf-8?B?VFZ0dGpiMFpLdkFMbGI0SkVyYlF4MkU1dXdFRG9YbVVsZ0xQd1M4Mm04WktM?=
 =?utf-8?B?WHI3cytRSGlCL1dUZ0x4V1h3SEpKdTlKUi9LWlBQQkhlbnZXOTNPbjBkN2dP?=
 =?utf-8?B?M1NkNnVBM0g4d0FWUTVmNEtKV0RsQXBEUG9yWVYwdFVMemduSlZoYUFOeklz?=
 =?utf-8?Q?231VmzOsdNXnOIRhcVpJxPGWB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2b6031-ec97-4fb0-3505-08db2010ffbd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 20:09:18.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTKLb41pNZ834RFgQjRmogosdz5ComvC9NDdEw06c7pJDaI3RYpqCZHBW08TV8pnWjsMPyzISQF3cBpLwWlk+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 11:05 AM, Krzysztof Kozlowski wrote:
> On 08/03/2023 19:45, Dipen Patel wrote:
>> On 2/16/23 6:17 AM, Krzysztof Kozlowski wrote:
>>> On 14/02/2023 12:55, Dipen Patel wrote:
>>>> Added timestamp provider support for the Tegra234 in devicetree
>>>> bindings.
>>>
>>> 1. Your commit does much more. You need to explain it why you drop some
>>> property.
>> ACK, will address it next patch
>>>
>>> 2. Bindings go before its usage (in the patchset).
>> Ack...
>>>
>>> 3. Please use scripts/get_maintainers.pl to get a list of necessary
>>> people and lists to CC.  It might happen, that command when run on an
>>> older kernel, gives you outdated entries.  Therefore please be sure you
>>> base your patches on recent Linux kernel.
>> It is based on recent linux at the time patch series was sent...
> 
> That's good but then why you do not use scripts/get_maintainers.pl? The
> hint about recent kernel was just a hint... Just do not invent addresses
> by yourself and use the tool to get them right.
> 
I will take a note for the next patch series to add any missing people. The current
list of people/group is what historically helped review this new timestamp/hte subsystem.

> (...)
> 
>>>> +  properties:
>>>> +    compatible:
>>>> +      contains:
>>>> +        enum:
>>>> +          - nvidia,tegra194-gte-aon
>>>
>>> This is an ABI break. Does your driver handle it?
>> yes, handling patch is part of this patch series.
> 
> Can you point me to the code which does it? I see "return -ENODEV;", so
> I think you do not handle ABI break. I could miss something but since
> you disagree with me, please at least bring some arguments...
Refer to patch https://patchwork.kernel.org/project/timestamp/patch/20230214115553.10416-3-dipenp@nvidia.com/
which has compatible properties added and also code changes to reflect addition/deletion of some
properties.

I am not sure I have understood about ABI break comment. How else one should handle if
there is no related gpio controller property found? I am assuming you are referring to the
below code from the patch 2 (link above) when you said "return -ENODEV".


-		hte_dev->c = gpiochip_find("tegra194-gpio-aon",
-					   tegra_get_gpiochip_from_name);
+		gpio_ctrl = of_parse_phandle(dev->of_node,
+					     "nvidia,gpio-controller", 0);
+		if (!gpio_ctrl) {
+			dev_err(dev, "gpio controller node not found\n");
+			return -ENODEV;
+		}
+
+		hte_dev->c = gpiochip_find(gpio_ctrl,
+					   tegra_get_gpiochip_from_of_node)

> 
> 
> Best regards,
> Krzysztof
> 

