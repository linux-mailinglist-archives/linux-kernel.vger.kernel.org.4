Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910106B9200
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjCNLqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjCNLqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:46:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C8C9886F;
        Tue, 14 Mar 2023 04:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtgzgcwKzLOW7ibubpSpVi4CNo32IfGo6RRLO+gdBDNeLJfETeOYeSETnFl4hLt8/nXm662LH/I5lq370Cl4fRWq129j6Z0ns1TW4jPzgO4N21KlFJZXP48zgSaj0rGJoV9vccJLKxSm0Iv9ZU1pnv50XgWH93e32mUXFxjf6gFek6lArnnz4J6ThDyqxyDRglJDXPqFgS9zOuaTwWPXthIMlgwFqrth1xM+HCSDj1c2C/TlF3UjyzsINZpOxmo4bciQyLE8U51pY8Lsx9tjfW9b3DHxq0cR/kUxd4WtIglRIOiRrCyrlrA2IYtw0JA+h7RGblrPlXYN1AsZSzCCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BHD0l5zoVPZGVFhaMneyeBd3yufhWpQlhOLfPVQDr0=;
 b=RApmREzEr9xxeTt+nWeWX76VIKS8X5hXC2DLbTTZ9jmOPX/HPULWhCPPSFyp9uU0zKOo67LzcbGwklwnib0Z2iLYEENplVxl/v+MopFBPmb2A53FpsdgYmKFHRVYwHWLFcGvRMs5WAzzKWwyWPolizqYx8FGuOSyPOR4nHxV8wRIYCqNfUrtuODJD3Upt3TskwXk2RJhDxtojOLnJPdwzkxfuyyplYni5A1zTXwdCin5THqIDmJOWCmX4udfmxP2DyOBJQ0rXD8VzMEYwhUlZbw6yStKLtUg7lACT4Tpntk7QpOyHO+KqyLHEPN31BaURBiIUdaornQM02Kd9ZP63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BHD0l5zoVPZGVFhaMneyeBd3yufhWpQlhOLfPVQDr0=;
 b=s6Gzk5CBxVBOiHPysQ+vftw2g78JKQZiSoi0yeDPMDZVPnaa5pLkTMm6HQ45Ka82J3iVaGjBfcCxzwQgQf7+yjN8VYWn0Ybw1kP5ZBhBcsoKMIDYQxPWZepRdAJobAarSlxxwg2kD8NtcSR+Akha5LcJdL3y9onJuA/uOF541HP9Qvd5ppFZREFUqhF65O9GjEJltZFCZaCs58DMlVEzTcUc1wOS8/ZYhWyT19SSYXHppYTrcgJ4lvrl1uDoeS4C7kilxkHB0XCDAF6vuBodKZ19EPVlLZnsyffEkLsffY62KNp0oLmc5fXq+2AxVxD91zalo3Ump4MSdOdyIV8t+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 11:46:14 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%9]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 11:46:14 +0000
Message-ID: <f9308bea-7059-bac7-a69d-3405babc9c8f@nvidia.com>
Date:   Tue, 14 Mar 2023 11:46:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 2/6] dt-bindings: timestamp: Add Tegra234 support
To:     Dipen Patel <dipenp@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, timestamp@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl, corbet@lwn.net,
        gregkh@linuxfoundation.org
References: <20230310190634.5053-1-dipenp@nvidia.com>
 <20230310190634.5053-3-dipenp@nvidia.com>
 <CACRpkdYmC=eLiWPPPRG7DYBmQfPNCN4pcDhzTCO=hkQDx2HoGw@mail.gmail.com>
 <798dd219-f4aa-39b3-2368-7a6d072b6de2@nvidia.com>
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <798dd219-f4aa-39b3-2368-7a6d072b6de2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::7) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: bd53d997-b752-4718-8f38-08db2481b6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gv35jQI+XvtaAVs9FcJbOdhAsykQ8G5Xp0lQXvYStK6+QU/OMvUGz1ES/ljxTEi3TnYDYlpewi467xMWbcuHjF5CFsiq+5tnJHgkpgQLfomsfftPFrgUSaQAf1bXwK/EDpjO+G8G52eW5kUneujCnmSrzBCK/sJADbPqjv98JqGFuo6NZA+Fecqt1kYyDcMKUxzB0LzHZBGYwsvTWXYPHgg6NC/q/lbj7cIE1/hojtAFsBGWV3P0zgGscfjiNzrzr+Vc0+u7sRjQeuxGirIzVAn35N+z27vBAB1nZFuCrM4bwPhafT6+UFn2VHLhvoRSs7ZNWmq1zvQDtGW29n3KYyD2m5qjqhds5qNqPuxrTkiYeOo2+NdrW6dYQujbJ9Q1uF+YxPnFk+28sSrMRd4xc1CStaMXy4Nk2WFi29GmL123QRA9OmhEw62KEfonW5IgRXyWbRM8i//hOCuAdvUdTy57msRMRLj+wXN+J6ZFxWPoBKglFfbUDIT8Z01F29cS5oQQuiO4UvDN8z2hVMPcZB1rmcUfet5jOayVpPiTrKEzA3Ox8uNCWj5dxFHq16ASH3CO3JWfoDCoEFABBcO/MNilk/Hs6ORYc5UeVV/Ecv/ovj/yM+8g+/pRdswqi380fbNDd24b4ofy8EK92SLXIwTmNkyt7Mi9EIc0rmc9BDtDMrRrraTFpiZNK0vGKdEj/+ui9GukrBhVJnvrbpWj2TCdj2eTMwtsNzljc0GT/5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199018)(31696002)(86362001)(36756003)(478600001)(38100700002)(8676002)(66946007)(4326008)(66556008)(66476007)(41300700001)(8936002)(110136005)(316002)(2906002)(4744005)(83380400001)(2616005)(7416002)(5660300002)(6666004)(186003)(53546011)(55236004)(6512007)(26005)(6506007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzNRQWM5V3oxUTh2cFNEajVUaDRSRDM1c2llWm1Ld2orcGNpaTUxdk80M292?=
 =?utf-8?B?V3llcTUwdW5DdG14UEd2dEU0NzZzV1VXc09kMEJkZ0FtMzA4T2xrSmx0cHhJ?=
 =?utf-8?B?UFJKUWEzRFNJbjBxaHBQTDdXK0FISzd1cnlKT1pDdXBEVnhITDZqMjgrZzdT?=
 =?utf-8?B?MFMzc2o4NmtmN09nOHRlYVRyNmFtWlhGUlNKQ1NGYW50ZXZJUDVjQmp6Q0J4?=
 =?utf-8?B?QnBzbU5uVE95QWNaM1NSODZ4WHdMTEQ2ZXd0WFlKODFReWN4dzd4dmlmS2ds?=
 =?utf-8?B?VzRuOENIVHhZMmNESW5mdEt6dC8yK3JtVmJQLzhrd1lqK1NBUTRwdUkzcWU1?=
 =?utf-8?B?UFJUblVkZFZONlkxdDI4d0wrOW1VMkFDUVVrdWpDbDBaVURKUGdka1JDQ0Y5?=
 =?utf-8?B?bldqaWlJclBlSzZJZjJrZ0tuOTBPK0VGVnpoa1oreVMyeE1YbGhDQUdzQXpp?=
 =?utf-8?B?UVZ4QnpkL0N4cmpqczlLaHlhN3M2UFlzQmpvV3FFczRqQlNOckppQ1QrR3Y5?=
 =?utf-8?B?dzhvdjE1WitFVmpIMm1HeEkwYVpFdnFEck4ycGFLc0dQU0w0U202ZWZLY1kw?=
 =?utf-8?B?V1FnTVZLbVpOVHVEeDFQelBwdGJkV2VPRm8yalJrajVGcys5UERoSTRDYW84?=
 =?utf-8?B?akhGN0NQdnBXOWxTTXpFbGdyb0dMUHlkSksvVTg4TmFvVjNOZkswVlpVSHM4?=
 =?utf-8?B?MWloQTVyeXN2TGhFMDJQcHRXVGN1ZlVtbmRvSDZ1a0RnOFhLSlRyRmNJRjY2?=
 =?utf-8?B?M253d2pGbi9meUk1NURvL09HYWhyRDhrRkhwUnNocmlvSHlMOURzSC81SGZK?=
 =?utf-8?B?dG5sbUhUV251dVB1d2RSVjJ2a21ld1NrVW1YcUtWY0piWnZ6c2ppYmJTVGpp?=
 =?utf-8?B?NFNheHEreWpUR3g0RGxvWEJqSDBzcjVYWHJMeFQ1bTRaaUVMU005ZEYyOEk2?=
 =?utf-8?B?UThQenJoUnowdHlVRnVwaEgzditFNS9NOHlYS0xlaE1MOEowVXB1eTIxa0dy?=
 =?utf-8?B?dEQ4bGlwdVo1d2pOOG5aeFVRaVRuZnYrb3J5UUw2ZUxGMTlzMWY5cE0xczVr?=
 =?utf-8?B?TlNPcG82a3VHQVlUalc2SHA4bHpJOU92UFZGeWxxZ2Z3RnBEcFlFSTdyVUxY?=
 =?utf-8?B?OTVRZVhXeG5sTnU5RWdTTi9sbFZXSStVbWNzUDU2M1lGZys3L0plT0tLb0dK?=
 =?utf-8?B?ZDlPNzhqQ05SRE9QNGdvSFZqcmRSS1ZVWGlKQ1R5dDFTNnVBaktHQzQxZ3o2?=
 =?utf-8?B?d1FFc1graGM3Y2p4M29SVnQ3U1dtQ3pYTW9Ma2RDVzg4TlR2T3luVWRIbllp?=
 =?utf-8?B?a0lUcmhrWHJVYUlQak8vRlYyWXhNYzhEcEpRdTgxRG1hOUtXeWgyN0E3bFFy?=
 =?utf-8?B?dElYRWNEU0k2WDJkQXNURXROd0lIYm44RVpPamNEU3lrSkZ1ODI3TVZUTjdu?=
 =?utf-8?B?SDYyM252Zm1PQjVTYVVYTWljdUI0ZldJdzZkVXdqUUhxeVdkQTA4bkFNT1Nt?=
 =?utf-8?B?dGpVcUtkK3FXRkIzajdJUkdpUEN4OVVxcFpZQ0c2NWtFWHIxMmJoTnEyYXNP?=
 =?utf-8?B?TURrVDFzcVhsMmNsSEZKdjViaWNWNndBNWJXa3lqUCtzZkNMZ1JVOVgxNDlp?=
 =?utf-8?B?czNDcGhYdGNNUFZ5eXU1UFkybWJ4azVwZXFwaG1ZZFVJQ2pITG82aitjc00y?=
 =?utf-8?B?ejZhenhTdis0TjllMFUyMGNIS1pWdllaUk96UE5zZ1BhSVVYWmhQakxaTSta?=
 =?utf-8?B?eWwrZXIrRjJmSTc3clc4OE03MW5qWE1Ja1ZxN0VQVmFBV2M5RTIvM3RRZElQ?=
 =?utf-8?B?THd4ODJEWlV6ZnJQdHJMOXBwemhZc1RmM1lOL0tKdUh5UWVyYnVMYXJxcHJH?=
 =?utf-8?B?S3ZrWmpBdFc5UzU0UDJxcWVkVnJQRnRTbnMyK1c5S2ozN01JRWNocHRLZURO?=
 =?utf-8?B?RStjN0x3VzQ0KzhwbkNPZ3F6aFQ1T2lta1JSUkc5NzRuWlo0b2U5ODlmZDZt?=
 =?utf-8?B?UzBMWEN3Wm1seHJqZzZHK0k5dUFqa1RtcjBob1hqR0E2bjg4NWFPVTNOZDll?=
 =?utf-8?B?SDB5bys3MnJjN1NpbUw3b1NTUks5WmhlWk8vcXZSeGdoZUZWYkxFTjg2dHlC?=
 =?utf-8?B?RGxnU0ZpSnFTZlR2V0dxME5tVk1VOHROU1Bad3ltczBRUFN6WUxoVUtiQThr?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd53d997-b752-4718-8f38-08db2481b6f1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 11:46:14.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIVOEPYbwIGPeieDz9KjDK4M7Upzde69okbFhL7SEY3QIeZjiaRztvdCYL5fSQ9N/mwHp2ajBI8ZqQ0tQ917ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/03/2023 23:49, Dipen Patel wrote:
> On 3/13/23 2:57 PM, Linus Walleij wrote:
>> Hi Dipen,
>>
>> thanks for maintaining HTE!
>>
>> On Fri, Mar 10, 2023 at 8:06 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>>> -  nvidia,slices:
>>> -     $ref: /schemas/types.yaml#/definitions/uint32
>>
>> I would not delete this, just mark it deprecated.
>>
>> nvidia,slices:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>>      deprecated: true
>>
>> (And remove it from required, of course)
>>
>> This way you do not need to explain about why it was
>> deleted, it's just deprecated, which is fine.
> 
> Great suggestion, thanks, will make changes in the next patch.


When you deprecate it, please make this a separate patch because it is 
separate from adding Tegra234 support. Similarly you will want to have a 
separate patch to remove support of the property from the driver as well.

Jon

-- 
nvpublic
