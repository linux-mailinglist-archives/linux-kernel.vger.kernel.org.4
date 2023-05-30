Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4AC715D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjE3LXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjE3LXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:23:15 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5195FF3;
        Tue, 30 May 2023 04:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnBwFRQbDORCZoMN7ppJdRymz7xU3BvYmBbFfXYzzzdB/wtny2z8N7gUUfpJFgaYbKvc/Gv4DV8cqW1jCCtA0Kqi2ruN5/5JzFQ+sd5L8UhPk9AO1w9ouHGu8+3+jBU291zlcN5INThlyYJRr5+kBQSQB3/SYnKAk3zRFcU5hJQjO5Rd/6RQ0d6ERkBMZCx9SXk0Sc8KQ3ah7Z5sFSH2NlkQFVpqg3NvzG4fcRwvjjiMRLeaVddmGnlLMYuvr6PhYJiChaShPhEOJwQU1jGjfmAb1Z5QpC2EmZzywjQaEwD9Ptz+yFyrHGVyOwtSOWfiv/1NPYOHrGxk9tIQT/e1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0wM7zE9RhmV6LCn9HAfk51yUsi62S59Lc8jp0P1k+M=;
 b=RrS4/PBNkDWkGOOx3zRsgsHHws3uNK0HlwzLCe3zlZKGa0cxr/e2dQM7ChUTnGYUY2wI1SliZGSjTH3OPP2a0HCesFlOulGQXx7WGct+F72yRjmr1UWytqp3+PAoZADE4AfeaRNOUDw4+eVvA3Zct9c5Tmfw5GoCinukQrFcysruo7eMCQyJ1eW2ZDQl0+Azs08Ayx+urH4fB49vO45Qs0G/eDhEsjMU9+f4ezMbfJyHwGN3Eo6tqFVgH8b4Wl0OOiv/h5opFBIQDyHWp5r730I0cJsCdoerKu3eSoPYxd0VcGoZfagqeO35LtCAAflbHwo8UrHNlCEL9dP4oTawSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0wM7zE9RhmV6LCn9HAfk51yUsi62S59Lc8jp0P1k+M=;
 b=HzA4KcRLy4f9IuNT3QD0CLXceDmdfBo3sASkU3shc7e8onKXTHoiBtI1hwgiiKhx0+/M6e5pnHBB/UOXmDvZstAXQOHdGlqx3QM5pFa9phThxE1bAb3Ip11HkjSwRgI+TofzYPVKqFz5cYzkPgVWoP8dFBc6EymB4QnJMfmAWDOAnOrHsRtDGz9BMADalLjOaObmKVYy7r7wuGGaGXmNP5UDc2/GYRVKc4gF+bhhQtFsgg/YWu8CZ7SSavX0sgrkXKazWYavuVsJl8KiO0KM7mUzXP3bzrw9Xwb/2YRRGP7N93boBblp0BVpXhhOV1mVcbBlInNQlu34yYVrNn8Mvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:23:01 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:23:01 +0000
Message-ID: <ed797fc9-98de-bcc0-583c-6b1c4a807204@nvidia.com>
Date:   Tue, 30 May 2023 12:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: tegra: Fix PCIe regulator for Orin Jetson AGX
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230526111727.26058-1-jonathanh@nvidia.com>
 <6dd9edcb-40cf-9873-b8aa-993bb18a3584@nvidia.com>
In-Reply-To: <6dd9edcb-40cf-9873-b8aa-993bb18a3584@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0387.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f905e14-b5ed-4532-0833-08db61003a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvMrW8Y5aDlx5gEP4WfooZ6t+HLr2EcDEZnbd+UynJIHsycxH9BqWpieK4Tb+vkcTMQv2GkKtpctiiZMNynMDzLNu9BCBsBahhbAv3+yxSLz3PaaBWdKCKYXHxuq05c7zgrhtFhx0ZhYcWBcGpWnVHHK36jzSy22tVbOL1YL7hsQfH8LCzy1lQC1vJiAbK14l+nmGBs/USOtCoMTweiNPTeu3qs0uBY1VAEYTzMVahpL15gAqYK1PRM89F6pZrupmf1ta0/95hYB4criNXuK6+7PY3Kpryt2HcWPLrkJDCriERbHwYMLJ4gylo9vkr8QmRT7oInoVHFzYmrgfQNU2S1/8ocSjYBuDVK5chjQcG68YDxaXHbmxYy0Jet86aSbYXhe+RrAj1zVpKDe+8lgzu+xsq3n1HZ+VGb/zHy5u3ftKveKARVK4uawTRErT7fuxd9A3TVU2j0OjI4gcy0gcze/qrQrhRKQZOvrI+ZEwCz8yK/LP7KKfoO3Pk9tc2SGC8hbSKFq8Juv4CgmZOG7rEIZNkBYFzHXyli2AitNjHfer5Genh9men6nURti6AohVlTOgyUMYKrDs//Bt591ExDfwgFONyM7mL4gimBrtYHYqkSNaFLKZ+Ocu+IYtH/CfDRY3Gq5MNcRplv27MjP6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(31696002)(86362001)(36756003)(110136005)(478600001)(66556008)(4326008)(66476007)(66946007)(316002)(6486002)(6666004)(8936002)(8676002)(41300700001)(5660300002)(2906002)(38100700002)(2616005)(55236004)(53546011)(6512007)(26005)(6506007)(186003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFscnJVVzhaeDNVazl1Y1pNU2ZnSjlPdUtuWTBxSE55LzBlLzExZFA2SkIw?=
 =?utf-8?B?RldwOFNsVGZWUk5WUitURWIxUnRpZzV2TTdCTllWaTJnUjZ1Vzg0eXAxd3B1?=
 =?utf-8?B?MzVXOW83VFkrWXg2S3A0TFgvMG41U210dUZibjgxbi9kZUd2NEV6ZWpiNk1I?=
 =?utf-8?B?T1RRNWJLWkI1UG51VnBpTzdZNVl3dXJaOVJSVGE2ZHlsNW9COHkrRVFTU2Vq?=
 =?utf-8?B?dlpYeVFwU3lWYWN5aUpqaThpdDBicmZVQzIxZnhGOSs4eVptYlNOVjhtL0Iz?=
 =?utf-8?B?WEZ1bW5Tc083a3pFck92Mnl0cTV0NWhZelpCTzUxNzlIbE9MN2RqdFZQS1Qy?=
 =?utf-8?B?bjBNVjZoVHJGWnkzQTNsSmh3eDNEYlg2amdJRFZLZURCWXFxWFI4VGJFSThy?=
 =?utf-8?B?STJBL1J6YUZRRGp6eXpWWERJcE4yaWFlQ3NUazFaTVBzL1hSbmdGMURjbGVF?=
 =?utf-8?B?VkVJODBBb25ITy9HSW5zZDlLSlZQdGZvN3U0SHIyL2tXbnRMSzR4ckxXMnN5?=
 =?utf-8?B?NjJZTXI3bWMwMUxpcGY3bEx5K2RpU1h1VlZoWWtRVFJIVHFod0ozNG1SOHZH?=
 =?utf-8?B?YXZCM1pmTTk1NWM3WmhZOUNXTUFPWUV6NU9Ra0NsUlhkYko3VWh3V0IwZ2tv?=
 =?utf-8?B?dVFsaWZveFFaTnFKdW1Yci9jeDV6NS9vaTlsVHJzajA2Q0FrZmYyYzBJUHRI?=
 =?utf-8?B?SEdpdVJlQVZ2N1VsN2xXWmlNTTBEa1d4MStDTmpjRHBudXFUVEVxVWVLaFFY?=
 =?utf-8?B?anBBdlBid1pvTkNpVkVxQjZqeExzRFZ0bVlVNkNjY2lNeXl2SWQ0UFFZZU9T?=
 =?utf-8?B?RlFiTnBUVGV3VnBTMlhQZEJwYXlsbGFWQ2R2TG9TZzc1SjhqN2VnbitrM0Vn?=
 =?utf-8?B?TDd5OHJQM2JpOWdaU1pSY0ZtWUZOU0wxT0RGMWM5b0tncnMzNmpjTTJWT0cx?=
 =?utf-8?B?Nmk4eG9wVjRsREh2WThzU21YOUpURmlTbmUzR0ZFeVFlVzF6ZGxBalZuZmM4?=
 =?utf-8?B?L3BpOFd4NVF5MHREVXpVbGNlMFdYUVhTc2w4dWRINFBnVk94R3dWTlM1bld4?=
 =?utf-8?B?ZXlsWWNrdTFWU0ljQzcxenJIaFVMbk1TQkdEZVczNDlnTDNFeTBPRDJxYlFP?=
 =?utf-8?B?QWFZUEs5UmVhSXFqSEUwZ3o2ckF0MmZvbldCM3k5M0wzMlRPMzRrN2xYZllm?=
 =?utf-8?B?dnBWMjJkczNMbWtrUEhxR25wc2UvemZEeG5YbXNwRmEvcHVtSWlhSWRFdUZO?=
 =?utf-8?B?VjQwSlhZeTNBSWdrbnFrK0VKTytCLzY2bjRCSWRwMWt2YkQ5aklVeS80dCtY?=
 =?utf-8?B?R043b3lnUEhVeUZtTlJUVWVKM3hKMjJ1d2VtWkVOVHdraVA3WWV2UG40RG9V?=
 =?utf-8?B?a0NQUlJCUVNQeUExY1J1M0l6VDhGVUU0Zk9HKzJ1c3hhcGVTZ2UvN085VmJs?=
 =?utf-8?B?TStVcGtBRVlOOXowcUNNaTRFR1R6MHd2UTYrU21lbzhTN1c0MjZLZytxL0dN?=
 =?utf-8?B?bEVwcG8wd2lrSjhzdEFSNXZxbGMxbTc1SHFUc2Q5d0xYYUJadTRMNTFucVV1?=
 =?utf-8?B?czJaYk1sb2RGaStyOW9qdXRNdkRpb2hkSXJUMWlDY1RuZVlHTENmdVhKOExu?=
 =?utf-8?B?UWhZMWRlSjc0ZHdobTJleXVUTjIveFErdlh6RXdnYkpVWElWVVZPYm9DL1pK?=
 =?utf-8?B?T09MSWk2NS9iYXY0WnlKYW5JeDlsaW5vNlZ3UW1qbVE2a3NGZkRCZFZ1Rk9C?=
 =?utf-8?B?RzBNUVU5WG9xSWJXM251bHNpZzlwTGxzQ0VyeVpBZE5JUUw2dURtVHFnU3FE?=
 =?utf-8?B?bWFML3JCRVJKMi9VdzB5MlJZZHhOak43ZzJVZnBPMUNvTkFrT3ZaYVZuMnJa?=
 =?utf-8?B?bXBjcFNTMGFNWnpVWWNPM3pETTNML0pYTTBnbGlGLytWUTY5S2pKdkJEUVVQ?=
 =?utf-8?B?dlZvY1NrS3g1Tjk1Q0Rac3V5cFNXdURyTmxIdTNGOWtsRkEzVDZwWnkwdlFS?=
 =?utf-8?B?RWNsWUFsL2djRUxLdElaNmpyT2VKTzR2MjBXeEdwT2UrNkk0cGkwaCt0RHBo?=
 =?utf-8?B?OXIzVm96WEt5YnpuWHZwQUpTVDlKb25uK21TNTRkZ3FMckxPN012dklRL3k0?=
 =?utf-8?Q?e2kqyLMfzkq5VkhYclVkiqJr+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f905e14-b5ed-4532-0833-08db61003a44
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:23:01.1382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY/w7ubpyjEAb65Q7xYc5FYJp6Eee30E20qfvZwC5BWlQcOlPG2E+kdy8mqtJgQQnIT0sYSxGsYZ/0hWeEd15A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/05/2023 12:19, Jon Hunter wrote:
> Adding linux-tegra ...
> 
> On 26/05/2023 12:17, Jon Hunter wrote:
>> The PCIe slot on the Jetson Orin AGX is not working and PCIe cards
>> are not detected. The regulator for the 3.3V regulator for the PCIe is
>> using the wrong GPIO for turning on the regulator. Fix this by updating
>> the 3.3V regulator to use the correct GPIO.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi 
>> b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
>> index e161618cfca8..4dce2e214002 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
>> @@ -142,7 +142,7 @@ vdd_3v3_pcie: regulator-vdd-3v3-pcie {
>>           regulator-name = "VDD_3V3_PCIE";
>>           regulator-min-microvolt = <3300000>;
>>           regulator-max-microvolt = <3300000>;
>> -        gpio = <&gpio TEGRA234_MAIN_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
>> +        gpio = <&gpio TEGRA234_MAIN_GPIO(H, 4) GPIO_ACTIVE_HIGH>;


Apparently the original GPIO we had was for pre-production boards and 
hence the mistake was made. Let me know if you want me to add that 
detail to the commit message.

Jon

-- 
nvpublic
