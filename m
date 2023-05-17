Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77073706213
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjEQIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjEQIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:00:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D704E76;
        Wed, 17 May 2023 01:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGjITytBBwYBlTdWOv/o8uBK7FWCHAxUmq3UAu/yWdBAFxDSxN2HDOYhEpxne6860m/aWtcgu4LCN1Yw1q3VktY7xiKIY4qm6yYfQIEKko500Fq5xPBmIwAywwRX8wPH++uwsW7CdmwxFVGiN7wd8z6VVpiHO8pkhUwKVi2fFmc9cOvgaDQSP6XT0JbPJfg0YJQui63w30NFbNdRuqnpCwtgUXxL6Ef48j8gS2fhVwuB++KNqm/qHvM+NPE1zITNbnerI1WWELlClv/5++vxttAteD/tmdfFa6iY3MUnFDdicCtsBSRQn53abEt116KV9lZVNqJipMXqtvbIvb+qiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSFUkbHoU23sFDkWeMb5RNj9vJHGz9+mn5rwbSMxnRg=;
 b=EavJXw444snX8XDsaYwA69/ibgXnHOJ8IzgREcJBF9AHhu0/dRRAbNQgwIRH8RdLOTJrlgwrrQ7LIzi+aeR/YwB9/TjICEovFM39ZIVWfguimD1zNm4jb26hKumNnwyeXh/6t9DU/+rhR5YvuLFvy/chAt0xLmzuzcv61zA3oE+7X0YLr6WzZLF38Tr9TWwVSpOHLtdi/BwXhrjk7sFv/CnloxEIdwB+PNYDJHx227eQ4fsazpGtjrrHi3Dqj9x7EYwRxljSW6RvqN4f6AehT58id95tC9SfPqymva2qYbYbNPdhfjyUPwqBSn2/60wl578xuvPsdsq6ImkCXsY8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSFUkbHoU23sFDkWeMb5RNj9vJHGz9+mn5rwbSMxnRg=;
 b=CKlVK1oO7baBhH+cjhV8kjJ3SGB/X0Z0SfQN/JnDUz62nxNRn3tde/uiuGQq3k2phFdU0u8VXbbLyjB+1mipiO8vkryDk2M9p7eT6KHyqtLDUeMWOcbyI7vSmLo1N4ulP6/PDFqDdvOXSXMarzB8mxPLV5iMOCotRQ92eExOilJn2GjKvlPxQ85hNo6LhyGWSvp2Rma4KqrfrvSB1cWKyTj4XzWuWYkWkv8MMnlg+HIZaLqthwxjRaPs1CzQCtrEM8QA3nFEyN0a9D23ioiAgjT+A27Kkk7kObnxOFZDloZxDdi4JiN3DDh/QWwDBkUmI6yPsNYNIPiGCJXn1GKHWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Wed, 17 May
 2023 08:00:00 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 08:00:00 +0000
Message-ID: <986717de-89d7-0167-a09e-b1031bd9dde7@nvidia.com>
Date:   Wed, 17 May 2023 08:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 6.3 000/246] 6.3.3-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230515161722.610123835@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 077f7042-dba5-4117-f76e-08db56acb694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7G90Yq2TQxa3eea1vTDzKky+qUzxZDmY2rJwIKUQcFpfA4OAUzlC1fFXzamxu5c7dwUESeqW/9ojAiRtlS867lNeqzM6Ovn7cFBcn1d32oab9waeZjRkQFW4nRfpxQ6yrN2w3Lco6JullOq/Cp+VwkP5VetPPhQaP5jJnipsFArpLRRSHZZfCGUHhWUh0LsvX07ZtYePQUYERu3f8+8IDDWJX+Mnnmb9rACHjYBO/KFgyRCvYWAZNUvTqlKZ3jfxSK7M06JrZ6Gdn2fCSesrpHscFi2rfPTN1NJE+r/3Ix1X+Kn2DAxr7CicTuOErejy9Dbb4TNKGxbcgXNaBKO/CfjTDK7qSFMa/37vkII25zTfxZcE/Gy48deXTpSqo7yKXJ8IIqEWhfJ70OW6wfvQ/biR5JI2cJMTki46aNLdLXL2y/S/X9AGh4HuvWiCMPk+oKF7tnI4lcLrZdybBJiWC95cBYXj5oARfNYA190DqeRdn5EKSBW55X/sEgAI36wsoJTeDxWPSF4O5EZe4SDngYcZ7r3kDBkXmPbSj6iPClLb1n12Xxpg1tzGbP0vmJYorJ0jAC+DZHa41UZAlqFnpVc7Zoh0C1gtGgX03CoQmtVFuevzAhJRYgg1f9oPBrVWaY2Yu7cWhvD4tHwtZgNM7DuxhoFkmhjK4RxOGbqlIX8KKgmiGpeMNpaDWE8J1r6V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(2616005)(6512007)(186003)(53546011)(2906002)(38100700002)(6506007)(31696002)(8676002)(8936002)(966005)(6666004)(7416002)(316002)(4326008)(41300700001)(5660300002)(66946007)(66476007)(36756003)(66556008)(6486002)(31686004)(478600001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEsrNVdJK1dQYmNTc2EzZjNNVVViK0EzMEF2bTFGazA5VFNVZFR2Q3pWNStj?=
 =?utf-8?B?Nm5IT1Q2SGRVZTNJeCtZRXJiQTU4blNBYytJODhXVUZFbEZxd2Y3U2k2eGlH?=
 =?utf-8?B?UGtYWllTRjhpeTFYcUhjT1ZoNENjTkZXcUFzWG16aUEvMnpaUkx3VkNseldC?=
 =?utf-8?B?OEdVdFVQN3VSQTAyL0ZQMXErUktBeHpNTXZvV3RGOXBWTGFSRlVNdmxiVHBl?=
 =?utf-8?B?dDRKWHpiWjlORXBJQWRMYWt4Mzc2QnJPUUxiOWoxRk1DV2drUG9GVnQ4ZkJl?=
 =?utf-8?B?QzN1bkpiUVpCdEIxZFREWVB0OUIxMDcvVitQaHMzbHpQUEViQzlSMDNyRjRL?=
 =?utf-8?B?YTJZa0RwRDR6ZU1ONVdza1E4NnRXeXoyOHkrYjdKSDdoaUhnNkJpaFJrb3py?=
 =?utf-8?B?UG1TL1dQNGZTMWRzNEtlVmc5QUluejd1ZGtlWWJOaGJrZ3pTbm8vS1g0Tzkv?=
 =?utf-8?B?UzUrTzNCaTE5NlFHRmlYaTllQUdLdFRJVDJjeFYxYlcrTVJoMExXSzNDS0VW?=
 =?utf-8?B?N1h6Q2tnTnBNR2hqWjM1ajV4aG5GUGE1RjB3UmUvS3BsYWxQT010QVpGelJK?=
 =?utf-8?B?dzR2RWtxVUdhNVZ1Z1FGZnhRS2x0Q3I0TThvV3A1Y3pKM2I0aE5yaGlCM3Bk?=
 =?utf-8?B?Qk8wVHNvUkIzc2NRWGp2STY2eUJKOVJGdlJmRFNsNnlDMjU5M3o2eHFTbFYr?=
 =?utf-8?B?V2hlL0JISURVRm5NRDBiem5rRXhKNzRkM2pMemwxQlRleVJ6NXp0Sk9IL2FK?=
 =?utf-8?B?ZXNJUmY0dVZNN0tQNVpyTXJQR1loeTZMN2ZyR3VDb3VQUHd5bkg1R2lCU0li?=
 =?utf-8?B?QWVEQlpJL2sxZHd5dEpFTXR4aXpMNG1qbzZuY1dyRmMxNXRRcUNiQzRha2hj?=
 =?utf-8?B?dUJNa09sdjN5ZVROaGFYMEc0djBFcWZQZDVDS2x1V1BjV0hIOFFKSXZsTElG?=
 =?utf-8?B?ZzRCOFpvSXpBRHNNRUI2eHFEQjFQeWdmMVJSaG4xQTJHLzZ0SVZpQWpEeFUy?=
 =?utf-8?B?SGoxMWtoMkp6NXRzelM4VFl3SE5VUDJjQU5UQWJTS3FsSXBRb09GVnZuT1Fq?=
 =?utf-8?B?Q2ozRTd2eWtRZHRCbWpTNDlnY0V5ajN5QWF3Z0tIVHJZeVZnTmw0bnFnKzZG?=
 =?utf-8?B?MmxGU2Q2UGxaVWw5STQvVlBDOUVydFlVYVg5M2pqN0t1SCtNcXEwWEFmOXc1?=
 =?utf-8?B?RU9BOXVFaXB0ck9Ma3k1VXNkSUxpTzBIQXJ6RkhJWXhqOTNFdUxkQlJ0dlhv?=
 =?utf-8?B?ZVZXRSt4Tkp0SkRBZm1VTEkzWVRHQlJSMjUxN1dNclUvRUw5OUpnREtkQ0Ex?=
 =?utf-8?B?YUdtYTZzOHozdFpkNHJtVU8wTzhqU3E5dTRJYnhkVXovNW5PR0tvdTd6OXZ6?=
 =?utf-8?B?MUY3V3dGNXRGMHk1WlVzaFE2TkdTUUJvTk1UR3NhcWhkdTNIMjBhZjd2cHlI?=
 =?utf-8?B?ak5iOCtRa0MzVkJ3RTJJWW5lblhqdnY2eXdXOElYei9BTHlvWGNPekJYUGp6?=
 =?utf-8?B?OUdReU94V0hYSDk0b3ZkdStmQ2UwSTBKM1dFR09TYWxBcTdNdzdHZHBLSVB0?=
 =?utf-8?B?L3RaRU5uLy91OHAzbEh6Mi9tb2ZIUEVuSC9KbGFZdHNuY3RCQmJReWowOHJO?=
 =?utf-8?B?SFZRcyt3bmJPV0J3WWI3cEY0b2ZGRUxsSVZ1QTZ3aHdodkZpTHJqbldNM0VD?=
 =?utf-8?B?WCtsbDBYczBsYUY4blZJUXFpbzA5L0MrQzFCK1IxeVVhV295Z1lDWlNUSnlx?=
 =?utf-8?B?UVAwampWcnNxZUdJT0FlN05Wc1pzYnlXVS9wS3grZm5zRVNTM0xhL051V2hl?=
 =?utf-8?B?aURId0xzMVFQV0JRVjY0NXdyZHQ4TC80VG9ORTVLOGNabmJzQlcxQXgzMFF4?=
 =?utf-8?B?QkhGdU91dXFRellEWEdBMkMzUW00b3Q1bmpuTW9UcWhRbTExdnhxMHFTeDhi?=
 =?utf-8?B?V0dXSzZyeVRwUEZtVjZjanpjdHAxK1B6bFVlbG83S2VpdndIN0VsZUFOSyt1?=
 =?utf-8?B?RmtYUThEVVNKNFZDOE5yUDA0bmZ1OVFYUzNtQVpkWEhvTUlNbWdMQWQ0dm43?=
 =?utf-8?B?VGl0RE9OczhtWlBwWEd5OWxkR1BIUzJTK29GMkVVZUdKNnJZQmhhMS9EZDVl?=
 =?utf-8?B?TzFWY3gwZHFsVExWMjZ3dzFvU2FJSGFWRUE2QnZPVkxma01Ba0dpcjZHaTFP?=
 =?utf-8?B?bUc0WlQ0Y25jN1B2ZWpBdCtGa3NVZTJTclYvdWZxN3VUc2QrdHpvUFAwSmt2?=
 =?utf-8?B?TUZNdGJvenFhWUgrQ3JWVCtUWWFRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077f7042-dba5-4117-f76e-08db56acb694
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 08:00:00.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR54CqBwtC0UamtakFK/aNBZVr89FiXsuH8yTZZW7cJ/51bYLQ4rzcAIRkxS9gg8MyRFJIu0uYajH456xhCrIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/05/2023 17:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.3 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


All tests passing for Tegra ...

Test results for stable-v6.3:
     10 builds:	10 pass, 0 fail
     28 boots:	28 pass, 0 fail
     130 tests:	130 pass, 0 fail

Linux version:	6.3.3-rc1-g5a952cfef67c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
