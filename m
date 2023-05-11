Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA26FEEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbjEKJgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjEKJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:36:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2CEA26F;
        Thu, 11 May 2023 02:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhaQ1sPZeF0D0Ojlunob+q54Wl7qcYMiS34oQ8IAbAsXZLSn7JNogx0q+w/E+/FClgR1Pj5eROgsa0iOZXW+dbaHiYGgzs1a/kYW90KRIJ6KQoDSNx6T5TpEvQMenrivYeJxAcMuJjqzycw2o1rKNAM9sX5hyGWCMf3tls9mV3XCEbTWATAR0Ta5jDqJTIpdlAT6eBrGGbQBn3rsy8i0SPgS/L+myq2p7uBWhyQWJFx2fl0epOZFNzmMdQIqplDAVSxJGXR81D76xxWtLifleI5nlzlRggZb90VkSzb644xBozDz/o8qzfwuhRwHZPjpdP/a4HaMNHAh0xRBZFm8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWSYvHK7vKIdO64Z0gZ2dZPsjAtDaq3s+yYvNUfc5d0=;
 b=LkVBYgiPhFrlEZmlr/5TbHwi3dZaE5wNidEufz6tIwCUzoQLdMEhikoK2Z9Z9Gle5IeaswWwvOD/+IW9Op0M3ArkNrrF5qQB2DzWF65NeJck4I9BiST7Tcz1Kfwap63IE4f435sdFv6aR77F4m2SO+msy04rG+G0mbtf1+SW9d7S3wBOMdRlMbA/8sVjJrFtUPNs8MRN7S4i+jckrGb2V+JGKwMausyLtstBrP19SZbJr0Kk01D4IB2Am2526OMOnlFTZg3BuJWv8YwH4RlyfYMgwlqk7CDUC+ZCn+MHgCFbh1yP44set5Bz4hvRwVCtLdNkEQNNZN6zfSbjRQFc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWSYvHK7vKIdO64Z0gZ2dZPsjAtDaq3s+yYvNUfc5d0=;
 b=gTXNxnEhJwy3MdLek5mmkGL2hG4tlf5WHm2uKGIUfIOK6BMcSptfIemQg01kf5XKFtKpXxZUav91huT3oqHt1nWytaJbmEnE+z+ITGMHEWi7q4j0uCFRe1yO+e2Ko93Rf812C/HU3iWHLtIy7FwC6FcOt3UScnEH/35LDutmjQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 09:35:46 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::ef8d:bf8a:d296:ec2c]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::ef8d:bf8a:d296:ec2c%7]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 09:35:46 +0000
Message-ID: <c5ed90c7-7126-0757-a0e3-e3d1fcab2ecc@amd.com>
Date:   Thu, 11 May 2023 10:35:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
From:   Ayan Kumar Halder <ayankuma@amd.com>
Subject: Need suggestions for smp related properties in cpus.yaml to support
 smpboot for cortex-r52 based platform
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        konrad.dybcio@linaro.org, andersson@kernel.org,
        mazziesaccount@gmail.com, conor.dooley@microchip.com, j@jannau.net,
        mailingradian@gmail.com, me@iskren.info, lpieralisi@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, Julien Grall <julien@xen.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Michal Orzel <michal.orzel@amd.com>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::18) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3e89f5-2b1a-4b77-4bd1-08db52031901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTerL+xn1kvy9U04ktRLCJbDNPYTeRULK9UV9C69xKz+3Lb+MZy3tQHRPIXH/cU0aqLzSganY+uCm6JIxMQWX6pBf05IQTTXoEGl6VTQodT9v2KBIo9EAu/GbCphem9DmlUd0OgjPgAWKQ9Auex88OTtVXtAm95aByoteVLXhJcqYPMO6yzvf0mIsPeb0dbYNWyBKwO8dS7VU7dVaLDUlaRC+GNdjUYfyOnbhWh6sRhhWABJqunT9U7mkgUAeFmF2UIw7zKnTFGOKQ71O+zmp9NZsYFWvf9S9fR1MQ5yWDzYMCgm4xhueOvepxA8qtgE0OvByNKGqGTA3hjoAa2PVKAfEB3wxgT3E942wFJJAX5OClsBaTaHI/v2ENFeeJJGAaKOxH80KbDK59YQJWM6m2dTdRodbgIf++jLJjA38IS6EFBlaJL6gEwS6vEcO1hWPg90c3pTKY1SNL7S657gLosriyYtzWf2xtrMdJHC4He9X9ueOGdjV8wBUHOr/rJq54Ypa1Ac2ASmjFmQa632HzWTeFyeWEPqmr/KteOeGV27PDYL1EbBFPIC1u5QXQ9X/F4V4z1+CgcIWDVWvup+rjtYEaH8DdTPR3hUEyBT3FnP42a21WYg7k1TV3p8S5PjMiZa7pADLHPm96IbnG6XH93B+VzzrjjZtv1iG8nc5a+XEajVZjbhpUGre4RvSsiZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2621.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(6486002)(83380400001)(6666004)(41300700001)(6506007)(966005)(26005)(5660300002)(8676002)(6512007)(8936002)(7416002)(2906002)(186003)(36756003)(2616005)(31696002)(921005)(38100700002)(54906003)(478600001)(66946007)(66556008)(66476007)(316002)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFRTNzVjUGpiNnU1aS9QeEtjS1AveUF1aDkwZ1h6UFg1NEpCUjNuaUh3eDFT?=
 =?utf-8?B?UXRGQzREeVQ5WWdMU3hlamVKakdLKytWVXd6Mzl3MzljTUxYRzVuZWYzZ2h3?=
 =?utf-8?B?MEJNaGFNTnVZUmIyT1hQdzk5Z0R4bXVuZG9YaFFpTnNTdER6ZzJtQ1QwNSt1?=
 =?utf-8?B?Y3ZQUzJxRld4cFNxSDJ6czRFZVYxZUhSNFpjRWJZM29rRTB5Y3NUYnNwa3lT?=
 =?utf-8?B?WUJ4cUVFUDJ2ai9jREdRZGoyM2JHWjZFc28xa0t5T3hPc1lUN0hXVGFycm9K?=
 =?utf-8?B?ajdaZStuemtqOXAvWW5JWHc1Mlp2L2tBYitTNkFIejdHYUx1TENpOWZ1enRa?=
 =?utf-8?B?Z21kRkh2NWtDVXRjWjlEbmFDdEVoSGRRNzJId1I5UU9DcmlPVmlVWXkxd3ZU?=
 =?utf-8?B?MUFJa3k2TStLWFJzbDNtYjFkS0ZWRUErRGxENENPWXZUV2dOdzR2OVp4TTBX?=
 =?utf-8?B?UlJSbTJ1VlRoV0d2ZmdzMHhvZjdTSUQyU00rNW5WNGJxbTdzbEcydHRBa0F1?=
 =?utf-8?B?WUxSZVRxbHpiNE9TZXFMZCtERDViZ1J4ckYwM2wybCtNSVZqczlRZ2VHN1N4?=
 =?utf-8?B?ZVZiN0VXMnMzMEYzVnFXOG5RZWZScDluVks4dWFhajVLRkZSc1FRSW1QUGZD?=
 =?utf-8?B?UUZRVHV4ME5Ud0U4M0FyclFOMWIvZkJ6cUtmN0orTFNKeFJsZG85Q1dmUmw1?=
 =?utf-8?B?UTdaSkd3SHU5UFphRjc3RVhydkV1Mk1QcHMvRG5HTmk3NXZLUkNmMW5IYnFq?=
 =?utf-8?B?VGtXRFI1WmYzaUpiby80UVZGeSt4WFk0RG16U1BtRUxSekhxZG9JZDZRL0c2?=
 =?utf-8?B?bkFrZThlNk1SVTZHVzNPSk9Xb2NuRi9SekpGODdOdElvcjdzVXJHTUg5cFhz?=
 =?utf-8?B?aFJyT0IrL2NzT0JhLzVuUlBiOWVOUlNBS1BIWDFxY2QyeVNwUThMbC9RdWQz?=
 =?utf-8?B?eS80UWM0MnF5aXM0ZnBKTlZNK1BDL2dEVEFLMFZ3RUVUaWNBN01QYWp2eU9R?=
 =?utf-8?B?SXZJQVNmbzRSVDJTWWtwSWJNN0taSkRVMk5DUHJmbjBZZVA2dHpUd3c2VzFN?=
 =?utf-8?B?RU5YSUFtT29DVGhrb0VrNU5zaXF2R1R3ZnhzWVlLQ0NNS29lWTZ4ODJ4YlYz?=
 =?utf-8?B?ZVBMYnNjaUlKUTJTMmMxNDVVZ1dSNm5GdXlRRGUvWWNBWm5kOXVxRTVHVHFZ?=
 =?utf-8?B?RmVySGp2R09jWVpZRWJKcUNzZ2VPMzU2MTFnckd0SERtb0pEZUNZYUQyM1Rq?=
 =?utf-8?B?UGJqeUZ6QXVqbjRDUG0vSUJQY0dwMWpSR0QraTdONDJQemljZy8xZU9Pc3l6?=
 =?utf-8?B?ci83UkRRb1JFY3ZRa3l4TDhGMHdsQkllUjlhcmxFZDA2SHI0aDdDbVZhNkd6?=
 =?utf-8?B?Y1JINFl4MFc1WjdDV05jbXloTnl4dDBabmZuM253czNRd21WTGFxcm5GRHkx?=
 =?utf-8?B?dXdnS0daWFEyajFmYkVPd3ZITTJDRHkxTHBKS3VmQUQ2WDlLNlJtc3cwREZS?=
 =?utf-8?B?UEd0Nyt3ZEpKT0hnUVFqTU5jdkNNNzZrYVN6djJhaTZGOEt4TDNNK2syTm1v?=
 =?utf-8?B?WnNtOTJMK0NydU9SK1VYaTM1WHp4NS9Pc3ZqTElPVlN4aGMyVW9USkU5WitB?=
 =?utf-8?B?WTZkVXhlYUNZcTQra3VqSzRLTlRXM0NMZkpyMmYwSUJXdWtVbVMwQnJCU2Zs?=
 =?utf-8?B?NXlqanJWeUJaRmdybWxJdlhEYkxQeGlRQkRXb3Q5a3F0VXl0NmhlaVp3ZlJv?=
 =?utf-8?B?cmhsODdDaENoK2RSeUcrR09xYVpBeTE0M2Y5U0lPU1paa2pKMVovbXdFd3Q1?=
 =?utf-8?B?K2pXK2dXSDRFZ3Z6UVhDcmtjMUV3MU9yekhvd1lOanpacGdnZ2xpdlRoaXAy?=
 =?utf-8?B?a0lId0JFVkFaNjdlbDNYcGtWOU9tNW9MV29ZQVpDRzh1Q3o3NWZGYXpDWjIr?=
 =?utf-8?B?TjViTVE3emM1SGhZeEhyeGo0bTVHTndNYlJTZGYxaUVtMDFVMHJzQ1lXZzNj?=
 =?utf-8?B?c3l5SGRTUlRTb1JTRlNqM1dSdXBPTlpNdTNlWjVtdmYzYlFGQ0xDL1RYR2Zi?=
 =?utf-8?B?VlZpT25VU2NlWVJUTG83eVhUTkVIUW9rVlY3ZDEzdTM2ZlNSeWI0b0Rtb3dL?=
 =?utf-8?Q?7PS8EmqohDrMlRXhdNB5qhfEJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3e89f5-2b1a-4b77-4bd1-08db52031901
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 09:35:46.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kfOkxhb/CQ0e3+JTz6Lys3gt3OlnsIAzI1yVPNTxus8jqZdeiZwoa76/q/B+rj/1xJRG6xk9AStywsLgeRZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Device Tree engineers,


Recently I have ported Xen on Cortex-R52 (AArch32-V8R processor) for our 
AMD platform.

I was discussing with xen-devel community about how we can properly 
support smpboot when I was suggested that this might be the correct 
forum for discussion.

Please refer 
https://lists.xenproject.org/archives/html/xen-devel/2023-05/msg00224.html 
and the follow-ups for context.


The way smpboot works on our platform is as follows:-

1. core0 writes to register (say regA) the address of the secondary core 
initialization routine.

2. core0 writes to another register (say regB) the value "0x1" to put 
the secondary core in reset mode.

3. core0 writes to regB the value "0x0" to pull the secondary core out 
of reset mode.

regA, regB will differ for core1, core2, core3 and so on.


Currently, I am trying to bringup core1 only.


I am thinking to use "enable-method=spin-table" in the cpu node for 
core1.  So that I can use "cpu-release-address" for regA.

For regB, I am thinking of introducing a new property 
"amd-cpu-reset-addr" in the cpu node.

Please let me know your thoughts on this approach. I am also open to any 
alternative suggestions.


Also I see that in 
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/devicetree/bindings/arm/cpus.yaml#L87 
, "arm,cortex-r52" is missing.

Can I submit a patch (a one line change) to add this ?


Kind regards,

Ayan


