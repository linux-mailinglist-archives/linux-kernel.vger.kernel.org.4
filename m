Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8667E85D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjA0Of2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjA0OfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:35:24 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25EB2713;
        Fri, 27 Jan 2023 06:35:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpkAporF0YiEcRBB4/RTjhnpoTKyfcszQ9Dfdj7/J6aBRHftMSl+Mkw2t3Wi+0tPIunkAj1tMRqEcu0ECQ1Xwijn7vEqejoxSxFbtFlhkHrt/abU8CNdTfOoFmJJNNUJZTj3+S5XWagUbtncO+atj0rjKrVzW4MdYbBnXDxC5f47BW7ellFHyEF+lY+e1x38w8uDuJzEkaWv91QEDMrxzIGuWngzkdgURj371+ESBOiQQ9DbUDgkvh+DqjkGjFYkOSoQnfJjvsUCf3ZiZPkut7LwlQaBPgaTkPFPc2WVMagSdDczQ5DB1xyl5KDpyETLRvMUTcIUiq1/HxxDcSNpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL4bodjZMQDXJoWcxbJxKs6eqx/X9ErrVPLdF1E5lFA=;
 b=cTx3vshGXpQH5uGsvhG6dtHH1Ox6K/iZsbu/wyfnblnba3oH4UlAFPC9IxYKMw23nD1clTXeJcALgLghHb1KanZGeVMWDZCkZcdIz23NUOylB5r6jl5DN2W6pOgH2C8X593fZLapEG4UMRRyFxJowH/BNUlKK8JRtohHENfsfMcCUlhi/pL/yhqjLn+wd65GiPYeRRcG5Jirx6ULrglmbU1B3Yp4A70Qi4RFIMqRYOmsEIzT5fvORHRIXnpRmQMrteRQ/EPV3M+FFJzcQY5cZSh/dIp889UaVPYelSvBdRpdMMliS0/eH1fsCUPv0qiB27t5b9Zm4pqOACPdgW6Y4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL4bodjZMQDXJoWcxbJxKs6eqx/X9ErrVPLdF1E5lFA=;
 b=bSVrnTTVqgrJeCdlxDQO0/Rqocor5dTJgQluRz8ADfSUhUcKrjXM7+mzL5NENpKAYcJi2fqJGkmrMbD/hortVieh553z+I9kjmDt8j5zBWlsyBgF9uyLnMBwHQJT3+gZrPXR12g7yKHW1EXhK9Zkrk6YdbdK+xJFOgG4f9/UbSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 14:35:21 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%7]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 14:35:20 +0000
Message-ID: <de2255e9-827d-72d8-2f82-a8a23eae1c27@amd.com>
Date:   Fri, 27 Jan 2023 08:35:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] MAINTAINERS: amd: drop inactive Brijesh Singh
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
References: <20230127105935.99174-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230127105935.99174-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5967d656-a82a-462b-fd27-08db0073b780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G04mwHamr+a9vEIPidSvr7FXW62Jxjaw/sS3ZHQtA2qU7BKB+rbDJH7E15+DvNGdHsHYfhny9X8uLjA0MKO2kWpYhsceaBx2TdwZSLHPXD/ldKYBrHe9lDA/ShEcIPu5bZJjff3n+TBnKUvzqh8zUCfMuQ7gG2oThBUKK1JiEwMgiB/oWvovwhoWielFXQmtVewU3kkCss0qBkX8botPhXFavR5QDa8vqMbFXFRxPDqNxpMbHynzwbE4BF9TDa6E83f1Wzm1dR4Ta39LFfNCmuDRojPKPUL103wzij474q4Gq+BTp71NYdFrHdOn14YFm9kfEOWv8rnOVwFO03LcPZ/lMDtDljK5otdJf8jC9UE43yIFCXf9QItuB3rgmxsk77mS9S1z3sSxHVCeZJ3qquLE7CyKORdgnsviM5G0dH9zcLN9KFsnZ/wIPSIOKfOg0maFVhTs5RSGBrZ/JHNEUUAIJVisOvC5L/KzxVWxndLhyXBwzK4GDpQZ5OECNDVMw4MeHWTfTnyQyobqjNS4VOA78pvwOQKdZlG13QEUp9eIkdiqhGsiRWI7fvK3p51yACKjAgTv+g7TyfDfEpSjNZMq7Wt5BmvAk5sKWrqvobdZxq9um7VXH+3e/DlmrF30bvfk4ejhn0bqbNpH+e+3kLZLWsY0mFfONxcAMBml3NjEsXjO52AYdgRionNbA1CnFo2Ydw7nB3mMbcGw1j4OsyhHavXIcArQqxruYU3DbeC4Hm7eUH4qO0lZzbZ2dw0m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(41300700001)(66476007)(66556008)(66946007)(83380400001)(8676002)(31686004)(8936002)(316002)(36756003)(26005)(6512007)(186003)(4744005)(921005)(2906002)(110136005)(5660300002)(6506007)(478600001)(53546011)(86362001)(31696002)(2616005)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDZSYndoTDFBV2t3dmFyVUV4WnhFcmhxZkZEU3BWV3Vaait4eU9BL1dYd3Zk?=
 =?utf-8?B?ZkRIODRBOVFER0RJdWtENEZrVXd5OFVPYUFrY0NpMFl6RjJENlArMVB4bFU2?=
 =?utf-8?B?NXFZUDM5MmYwWHZBZWdPVWJGNURGUDdTSkNzZUZkbmd3Y3EzUGZIMlZhajRB?=
 =?utf-8?B?aEhQekZKcUpEdVYwemp4bEhDQUM1YUU1TzBMV3dqOGVOWWtNbnlvSVNUY1BN?=
 =?utf-8?B?TWFxQk1aQkh1dFNvR1dVVVFGQTdWeHNJdDlraXZwQTRDSWRMQTFsQ3F4ZkJO?=
 =?utf-8?B?Y1hKdGJUelowU2VNbGVXdUl3SUx0RWpneXdyS1ErYVE2YXBGVzlIS2hvc1ZF?=
 =?utf-8?B?U0tvc3QyTjY0UFEzNE0yRGZJeEsxcjlPRTNCbkF1L0NjZU5sWXMzOE0wcGh5?=
 =?utf-8?B?dExSZnRLQ0QyYTFhOXVYWkEvczMwc05JY0tjT3RoUklWSzlLdjYzQkM1bysr?=
 =?utf-8?B?dm1FTHRlSzJnNXlZellBVzFHTGFuK3BSc2dzcHRNdGFrRkNFenc2T0N3d29i?=
 =?utf-8?B?OXZFYldxY0dNVGtwODY4Vk9BZ0RmL0hNQnJDVGVSQVd0K25CV0MrNWx1aThu?=
 =?utf-8?B?RmVBcGduUzRQdTBiazkxRitJZTdYRTU0SFB1NHcvd2R0dGIzY3EvNkl3dDFJ?=
 =?utf-8?B?T1VpMTQwMzNuYXJ0ejkrY3pUMFlDTW43dXIrRWQ5bzFiakx0OFRwWlpJNWQ0?=
 =?utf-8?B?aDloWFFhZ2NaanNsUHNkVWphd29WYWYxOTJVajhNdnFIMjZ3ZytuSG5mOXVL?=
 =?utf-8?B?U2RvV0Y5Y2svZVpFeUJJcG1IbUY2VTZ4YjMwZ2pjODV3L3ZZSVlzdFAzRVo4?=
 =?utf-8?B?Rmc1UXRYN1d2eUt1T0wxWU16MVNBeFk0OHg4VVU4VFlQN3pVTGdIL2VQUnVk?=
 =?utf-8?B?Qm1kVFhIUS9lVGdXRWtFSVlrV3hWYTJUYjNHQ0JldlJWekM0VFJ0ak96Z2x3?=
 =?utf-8?B?T2J5ZDg4WHhVbUJEanZQMGpJcVJMRUdVMXlXdC9MVnZEQ01YalhJcnB5UWNt?=
 =?utf-8?B?RmFaQ1ExQm5hWnZVcDMySGRpeDNqQXBWTDdiUThtUGhiZU51R0Y2cHNvU0ZC?=
 =?utf-8?B?TGZQNG1CbXNSTlhab0xQYVJleldBWmNyQlJzdUJQQ1ltSFB4cy9DdnQ3LzRV?=
 =?utf-8?B?SDB0RVVBd3NlZmNSN1hVNlRtaGR6a1djeUxidU8yYnRLdEdheUx2MFg4T241?=
 =?utf-8?B?NU1aNXkzYjB5LzYyb3VFYUZVbmVxTzA3R2FEbzlQM3JMY3o0TnhnREt4UENl?=
 =?utf-8?B?bGs3RUI1d0o2U2Q1OGZiVGFDTkVHNVZjMy9YclJkVkpOZ081RW5ubmo4U3F3?=
 =?utf-8?B?bmZzaC9LWFB0REdheTlHNjZKNi9PaSttSElDTDBWeHJjTXFYRWtEVHlqVjZy?=
 =?utf-8?B?dVFqQmNOUmZ1U2xibTdNUDFFQk5aVEhFT0E3N3R4bVZXL2pMbzdSUlVQd1kw?=
 =?utf-8?B?RG1DUmZYMmwvWUNQTUNscG0wMDY3Mk00cGJuMDhmNjBGK3NzL0U3TkQzVytT?=
 =?utf-8?B?YUhwWVBzSXhleGVHeHg1bklsa0dpM1YxMEZTWTJyRkRuRlRIMVowRm4wdUNk?=
 =?utf-8?B?RVJKM2hMT295SHNjWERhNXBWeDAvZjdWOEEwb0thY3VROVBZdC9LT3JBZjg1?=
 =?utf-8?B?Vk03dlZnTXlYekFWbnpoQ01aakFvdEFBd3NGcTdoQTI4bFlKWEpvNmlDR3pX?=
 =?utf-8?B?dW5BV2lVcUZaTWVMV0IrTDJYTVoxR3BuY0daWnNtNE9qM05VV2diZzhMNUdH?=
 =?utf-8?B?QWtoSC8rWTF0OTFiZjNjUS9CNmRKdTJjelNaSy9GdER3cXZoOUpyV29Eb1Zn?=
 =?utf-8?B?YXIwTmozY241UldHaW9PZlByV3JUaDRKSFhQamdiUzdlSDFBaktkWUtSZk5Z?=
 =?utf-8?B?cWR6SWtLczRxeFN4VWkrN3A3SXYyVjRTbGZGUG00VmYvVUhaMWtueGR2WTdQ?=
 =?utf-8?B?RXUzeWF4QUhteUxxMFpiODU3ZHZQamh0UXVLUDdGVEdaK0tPdG1sTkdzcnI4?=
 =?utf-8?B?TGFiN0ZvWEpXSms3bSs2WDZWTHpxZXlCRDhMMkNKQmhKZzdWMzRQejd0OHRu?=
 =?utf-8?B?cHNuWndYaWpSaE1sZ3ZmaHYzTE1JcjZqVWhQejZ4bEVWZDgxSGZmTkovWVVD?=
 =?utf-8?Q?zN2mRym/UMPiJEZVIYoJGpk9o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5967d656-a82a-462b-fd27-08db0073b780
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 14:35:20.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbRWsAfucoUENdkAgXqdon/PjVTPKVLX0X6X7d3k8fMZJtSIdIMHWCaDDXWc2cuKPGp39Bvb1cr1eEvF0UrXgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 04:59, Krzysztof Kozlowski wrote:
> Emails to Brijesh Singh bounce ("550 5.1.10
> RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address
> lookup").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35385df2302c..028df656196f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1099,7 +1099,6 @@ S:	Maintained
>   F:	drivers/dma/ptdma/
>   
>   AMD SEATTLE DEVICE TREE SUPPORT
> -M:	Brijesh Singh <brijeshkumar.singh@amd.com>
>   M:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>   M:	Tom Lendacky <thomas.lendacky@amd.com>
>   S:	Supported
