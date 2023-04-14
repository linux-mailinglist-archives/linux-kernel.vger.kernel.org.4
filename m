Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E315D6E290F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDNRO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDNRO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:14:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1384326BE;
        Fri, 14 Apr 2023 10:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD66bSjnuzI/t6ryI1pOwbR9Z0bCs+4GTXyq5ru1lowHqxvAN4wlRFkckDu7ixIrcRCikciK5XeHSnslOUuxTJdgKzxbwMOtuL0ukoOHiactc3uxdrZLyFZYgsCYZDxsAJa3vwpur4SVtgw/l9Ue07SCo0yZoDZfZFe30x+gOZXDp2ewsn7RodZT9GPtlCtCi7DaDgOg4sK1BLz8bCMeFbOh0utbYcNtGBQKobEUbwpWzwiSW3KTQnksQTGqibSh0vFf/7DCcI7Ts/GfKMnNR5aaN7uDCbGnKXRwRQScYY8sbxvsN0Bw27Z9+vvRfMxFjmvSdbJ4fN4+/9G/8/vlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNWMPgWNdf85QIgERBrgkU3xuTUUuBnvjDdkq7DdMAs=;
 b=oEO2BMKO66qZWUW+8dNpeNmINu1XzsPsZ/lbPS37+QO2ansez4br0CJcdCRzeM6hqO6+iTwZ2AmYNaaPH5961eK7+HtaO6/26j9ai9vRT60mxsIS4JbryYnUyT6mRNRce06dMxDqfrPHZtKjw33Two2ilyG7XcbyTejIPQ/wMsJFoDYNCYAXg85UvsT3yC2nngVKdpFPiGLGsAWT3Lous2XmnfMyJ5dW1FIe9dNcxRKs/4ka3VROJxw0bq6k3AYk2NSzyrSBMQQCzJifOS9ua1kqUScDjAcPoWAImIUlgmuL6kF300VtHRMPH8C0DWza5zfhgQpBT27nnOTY6vkgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNWMPgWNdf85QIgERBrgkU3xuTUUuBnvjDdkq7DdMAs=;
 b=Jw1hmyBKgo9fQgiU3YCPzrtEaFtdtG5Z6mYKmgP8NG26kj4PAbL4kGsuj9GBXjBv7dcvfDuMiAr2fSEbrrB0GF1tNTE9MJh6womY02B7Vdk/WC/s4jed2TRNW1N4Q419r/iJgXujh2LztMwAyXC70noaLfVuy+nJPYgAIdQqGUgFizHftBiG83Hwes9X46J6zefib+n6NR7vo9ajyLexzG1QK03aR2igzvMpW1oUUV4VADTXbINugLRNPix401JkbJbxFGSLLdLedgRYOHeDO4Lty3FlYMXHeKKxmaf3pp7kr74VKp+r9aePRAkTTM3rGoPQ/acPr5zfSC28XwIZRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 14 Apr
 2023 17:14:24 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%5]) with mapi id 15.20.6277.047; Fri, 14 Apr 2023
 17:14:23 +0000
Message-ID: <a280fe0f-b8b1-4cb5-b4b6-aa9e9367241e@nvidia.com>
Date:   Fri, 14 Apr 2023 10:14:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [V6 0/9] Add Tegra234 HTE support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, timestamp@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl, corbet@lwn.net,
        gregkh@linuxfoundation.org
References: <20230414004455.19275-1-dipenp@nvidia.com>
 <373eacb8-be3f-6b95-3e08-f0ff36f79891@linaro.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <373eacb8-be3f-6b95-3e08-f0ff36f79891@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::38) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f86e32-2c31-4b1b-2f9c-08db3d0bb14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8bf8O28w4CEF7Z4EEZpwa3pRUHAUdz97IbHZTYKUeH8tbpuiIdhW+ewlfDq/rrySJVLk889mx0z8IhyXYAMCnMBJli/kqkdKR3Qj8oSMtTS/O9pNSfccAjMBtwIPLueGGQCbx1/fsq+1bUv0xaTvz2ES9lWP6zgv3NfbO1sGlXZ8rn7ufK4Oy4nYyLjm036RmYkcpsUhr1NJDp8ma9LCZ/Te5usSqvvmXwprbw/nxe2Xe4Qu0dwWtJrEHYovfot40I16WDY7SqZYVT5s97N4ATwBBzsGez1A/96P3EBvqDNX5vstVfVlKm9oKds2NBQcdBPb6FbO0lXaZZ/jEvtHFXAkwBy9FFn9QhdRxR6rvUE+TlVV2W+KG/CoBxItIfUIrf6FPiaKUTexDF832WLfv+GGNyxMNBLFdX6/cpFckfTfMdkUC6OhwkGbGs7dnrm/F3NCKWcXhym3z7pPmGzC4tETfL5OT6V58M9m05S0q7eX+m3FP9mB2DBVvC4jiFd1gLSz4IVUtJYbx+ntrDyoViIWmgQu65e9ZmgvMKz0WMaVQh65W03A+QTgYnkOEYydqodAVBYS4XoNvNZ2EclMJPrmI0s8zr4N4yV8vGLOqlp8Nn3v3wuAOA5HyHinc0qaopE4EUBsCfUT/jmA9FYIGLRFPujOGzUt8RC09FTLKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(31696002)(86362001)(36756003)(186003)(6512007)(26005)(6506007)(6666004)(2906002)(2616005)(478600001)(316002)(7416002)(66946007)(8676002)(6486002)(41300700001)(5660300002)(66556008)(8936002)(83380400001)(31686004)(66476007)(53546011)(38100700002)(921005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZjWDVybWtWY1cySCt0WTd5eit6alNHV0lIa2ZGdXA2WUd4NlRBYkFhMW5w?=
 =?utf-8?B?aW02b0ZDVWUrRzI4R0M2UGZXQnNsS2EzN1VsRVBweGphRU5ITWh1QTlBNFAw?=
 =?utf-8?B?cTg2eW0wWjFlQ2NlZlludWhYcThkZWg4WEl3dFdsa0xVYmVsQ3hWVWlqWlIy?=
 =?utf-8?B?cGttTWZWUk5UTDhsN2xRK1hMdXhmeWg3ZHFXM0ZGbUx2bmg2M1dEeEUvM29I?=
 =?utf-8?B?d0E5UUZUSHQxU25yd3VFekI3dWFCd2tGcFhqVlpyR21xYVppdnBKc2VWeTdQ?=
 =?utf-8?B?T3NZaDYwaE43S29aUDRIOTF0Mm9ldFp3QVJQT2tFWFVvcjQ0ZXc0UnhMRFJz?=
 =?utf-8?B?M3A4LzFCOTVWYkk3eTV2enBwSXB3eityU3ZFQW00QjdmRWlOZGFEY1ovVlZi?=
 =?utf-8?B?M3BkQXhmZmVxS2dsVGtsZXo4Tk5pK212VVhMUGNmVHdaRlRMMWlkVjZmMG1s?=
 =?utf-8?B?bjZHMEdLQVF6TnZ2R056am8yQldHTEI3ZkVSVzVWaWlxMXMxOWVmM0JVb1RL?=
 =?utf-8?B?RU9TMHZza2ZrdW56TWZvTitoV0ZmM2ljQ3p2dzY5M2FqbjRwZ0FTNVkvcDdE?=
 =?utf-8?B?d3ltOVhkY0RUN0hkZzlrU2EzN0RrZ0hNNVVJWXRURzZWQjlBUjBKVjBrSTF0?=
 =?utf-8?B?YXEya3hmcDB6SWk5cjd5akFieTAwa2lQdzVxUXUyT3pXUFM5akQrbW1uQUdj?=
 =?utf-8?B?VHhOMUhiZThCeDBYeFp6M01nVks5cEcrSWNDalZKV2dsblBRV3NvQnhpRzU2?=
 =?utf-8?B?N0h4R0NkcUZtdjUwNldJdzBtdjEvMVROTzlzSDJ5bEFrZkxRVWJVdlBXU2Y5?=
 =?utf-8?B?RVhoTHMwWjJ5ZXZtbTFUeWJHZ1Q5cVU4Z3ROdEQ4MGZPTEFzSmljMzFldkww?=
 =?utf-8?B?ZXliRnB2eDY1MDF1UmlSSnJDb2dxUG12MitDRTN4M085WE5NWmtnSUVKczY3?=
 =?utf-8?B?NDF0dnR1THNGYkoyWmRWaGp1MnNPZXJYcVZ2YllkdE5ESEkrZzdmY2tja3ZJ?=
 =?utf-8?B?V2FxSkd5TDV2ZlZrTjNJbDhmcWNRMnRTaVdDRytLL1NuRm8vb2lkRllsTXNX?=
 =?utf-8?B?ZkVyWFd1UVdjT1J5WEN2SThjNDFlT1VnQ2I4b3B3a016UXVabHI4bVpJWW5o?=
 =?utf-8?B?MjRvaWlWWVQ3QkY1RTUwanRrcWVCZVlSMlgzNFphMjErMXlQSXgzTkJhOGM4?=
 =?utf-8?B?bjFCMnZBNTQ4TXNieDhyaDFhNHhYbTBlYnl0bW5YaXA3Ky8wb01va3ZxeDZS?=
 =?utf-8?B?b3BJL3Q3b1lPbXRUK2ZwWkoxVlBTampDMzUvZEJtdWFLSVFKOCs0WFZ4dFRv?=
 =?utf-8?B?MHdpa2kzOVYvTnFLd1FBeFZzUDliVkNrQmVkZmhScUZ2RWNqZWwrRnYzaEta?=
 =?utf-8?B?SnZ0eGFZRWhVeUtybVRmcGxzMnJHdGFaVnVDV2FndDRrZnZqSGhZbUNXVlRv?=
 =?utf-8?B?Y0tTVzZHSkdBRjlobTNMZ1NjZVp1V1B2UWdDRzFzQWVqQnFWR3JTQXZoTjBx?=
 =?utf-8?B?aEJlcnVoRExJNmhpNFQwRU80U2VIT2E5ZnIrSkN5VVF4VFUwdm85RS85MUR0?=
 =?utf-8?B?eWFSYm5yZXNLNmZaTDRuRDRWUnF0RVRhZ2Jxd1hBSzlUd0lienpqYmU3d21T?=
 =?utf-8?B?K0ZsVExod2tTdlh6dzVTVFF4YVBrZ052MEJvZm1SbTgvNDRCYmMzWmRRZ0F2?=
 =?utf-8?B?Yi9pSFNReVVjb3NEZTZ2Z0tGbStvOGZQSGpqRkRad2NCMG5iQnhrUmhHRkNS?=
 =?utf-8?B?dVNFOTN5Y25VSERnVlhHSldhNUYyTkV0Mm9SSVhpcXZPYlNjaTRqWEhXN1ps?=
 =?utf-8?B?WUllc3l6Q0szcURXM0xCd3B6NnhlT3NMZTZuN2d3Sm9nL2lmZXB5RDlUQVpr?=
 =?utf-8?B?Vmh0cTlubTMvK25lOEhncXZ3SlNWZkVRVjROYzREQkpRQTBlZEZTY2I5b2VR?=
 =?utf-8?B?SnYyUlJNTjNQNlVHbjlqQ0pzTDlpMWRaL09qUTQ0ajIrM3V4V2tkV3ZkZkxE?=
 =?utf-8?B?SGJiUXkrQjVkQUhHSThqNkZFdmRON3VGd3B6eXZYcmNmMHBxbXMrNGRnVnhO?=
 =?utf-8?B?RWh1dnlYbTdKRHpNSWNXMS90R3pmdUZza0RIQ243WklEcmwwWkxzYWI2OTgz?=
 =?utf-8?Q?W/z4iWvswwLpwiqfb51iqfqHK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f86e32-2c31-4b1b-2f9c-08db3d0bb14c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 17:14:23.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT8/cLKhg4Rk6iTukACvmcRBPBt3Z5qfMJO1s4koQs5nuconoDsxtUz3KjdIAvAa36jU0IXDCuWIhh1hZS7ADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 12:36 AM, Krzysztof Kozlowski wrote:
> On 14/04/2023 02:44, Dipen Patel wrote:
>> This patch series mainly adds support for the Tegra234 HTE provider. In
>> addition, it addresses dt binding comments which prompted code
>> changes in the existing HTE provider driver without breaking the
>> Tegra194 provider. The comments raised concern how existing code
>> retrieves gpio controller node
>> (the node is used to help namespace conversion between HTE and GPIOLIB).
>> To help simplify that process, new DT property is suggested which adds
>> gpio controller node in the HTE provider binding as phandle property. To
>> conlude this patch series:
>> - adds Tegra234 HTE provider
>> - modifies existing provider code to address new dt binding for Tegra234
>> without breaking it for the Tegra194 chip.
>>
>> The V1 patch series:
>> - Adds tegra Tegra234 HTE(timestamp) provider supports.
>> - Updates MAINTAINERS file for git tree, mail list fields.
>> - Updates devicetree and API documentations.
>> - Enables HTE subsystem, Tegra194 and Tegra234 HTE providers
>> by default in arm64 defconfig and dts files.
> 
> All your emails miss PATCH prefix. Use `git format-patch` to generate
> proper versioned patch. Stripping important part messes up with our
> filters. We have quite a lot of emails, so proper filtering is important.

My bad...excitement of sending the patch series got hold of me :) Now I have realized
it is been happening since the beginning. Since all the previous patches have been
sent without PATCH prefix, is it ok for this version as it is or do you want me to resend
with proper prefix?

> 
> Best regards,
> Krzysztof
> 

