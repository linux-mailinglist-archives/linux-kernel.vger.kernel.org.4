Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172317077CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjERCIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERCIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:08:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916EC30C2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQo0Zj1LEugpIjiB2R+PPnwYVAPDmNUPTXJcmElrX1YKP4lhxpAMHJLV9mNOy64e4wiyuUmv4PGGZI1Lv9v9ErgrwPfrE5mS0SyyXU0dxFfZmo46oJm+NJocHhjL03vGlhV7ESUipiSuQJllLOmttmeMZbt1PO8Rzaxr+oJJX56u5LTqHn81gXpZ3Sv8njc6JqD4Jq9YI/mMmpTea8003lhfMFchhZApsXxqpQOBwhMRlXzWCTFCg903IUFVrmhZ67Zmoak95qvN0sQqzuwyNT0k7xmfjj/Fdd2FQ6Nn1pQdx9XQVz695cgWDi0il5EvOUTuGqEpSDe/lTQuMbTKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM6iu1dxFVv42b6nPOAwogB0muRwyKv+NhJYXoG06cA=;
 b=N4qATb4aVt5tQVNfFfRPO1cVHVLliFK41cjyyLR/66CVLIoHWC8ejvfTIF2xVIPj3cKhaB1x15K93oU/34mUhIeTo7QUStMaBn2UFtLYI3aO5cHYa3Lbbj/28aP0AiF1LwJeDWvzdD+CUn5vVhW1ljXXSK7hcli+tOsR7GmzQ8tsTm3/V1a2YfO26nKvRGTAqmykmQVaRGC1HO3Oj9iMRQAbc1WSffxj9bsMIXVVn2uPj5UguNxkBOuFmiLx/oWIFsdrr4ieuDmNlfXYG7EP7P3nLUXWc0Sd+3oCPJdXTyC0fWUqt3/aLPjdmpngXZwVU+3yxso50iZtc6UpOzOnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM6iu1dxFVv42b6nPOAwogB0muRwyKv+NhJYXoG06cA=;
 b=Zy84+7B3C4yUJAUCR9oR+ydusAAWE3uSWCBKW/jUOlyT8Bqle0oPUf/nqtBPTTN1VK0lJsUNDTFuKEvfas4Uz6CSYyAhz4KqxyDJuNoVePAaHWpEVwTMxmbry39RgB6Svhobn7ig22eqjwjIClIbqScLKk3Mt2Q+o5SDDZN50QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 02:08:36 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 02:08:36 +0000
Message-ID: <f250222e-d34a-632b-0243-fc76de586065@amd.com>
Date:   Thu, 18 May 2023 07:38:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/2] drivers: base: cacheinfo: Fix shared_cpu_list
 inconsistency in event of CPU hotplug
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, sudeep.holla@arm.com, yongxuan.wang@sifive.com,
        pierre.gondois@arm.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com, palmer@rivosinc.com, puwen@hygon.cn
References: <20230508084115.1157-1-kprateek.nayak@amd.com>
 <20230518010254.GA19915@ranerica-svr.sc.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230518010254.GA19915@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5060e0-c33f-4132-2fff-08db5744c967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCQut/RweMVWQ/QzfcioHC0okxo9PGjgE7a5O8RKFmbiEaECwfAhVnnoClXVraeRS8YKQUIvg9DiKHurqhkWvVLzumk8aY6jPeuLe2VXs5gSn1IumM+70KKj8yApmcgwSLgBQwiMt98QHiu8IO9aT9w80BWzUpAZRWX9YYtFZEIsXdF6yStBmIaR9R4qAk8BMlF5SEHlW5vy6oKSLlPhg/8fw4XAVRMTfg6Vi/1t1JvRPOJ+nCKPG8LsDkd4Fhp/Acwtr+gkLVpclAR7XtZ6ynp+CtYPrPWPQdAUmAODCOeCP3gpGNWVfDJaMlj6pHb1nbZCgvlMr4mEXhG1kTUlDyBm/uB1tadRLZ8THigYfPa6crPW8afrbT8FKxzrdohvH8v5fGhCfdIb8yyYBJQpdaMFmeMlE4i5gHFCdLn/WP8CzWpVXx791RvNMo/2Uts7Q+aNPG5eOGUXuyycR1Hxd3igI+SiDDT8y1nan6Y77wSGXdMYaPZapBgQqJdS3IZybL9OiQLipSVjKoibI63vDo0Dmq/g9Or5ig394qvp41qxQ305BCmpFVV+KDoZd2XeBYKoGrZ/hO2nEvOupfpT/iaZXVZoXQKvWHjrjMZs9BavmKa8PoPMQ4IoHosAtjGtGesHFQNYKPrKeSiZGskHyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199021)(86362001)(31686004)(83380400001)(41300700001)(6916009)(36756003)(5660300002)(8676002)(7416002)(38100700002)(31696002)(316002)(66476007)(4326008)(66556008)(2906002)(66946007)(186003)(6506007)(107886003)(6512007)(26005)(8936002)(53546011)(2616005)(6486002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzJTdnVzY0JBb2RvdkppVG5Vb0ExbDJ2Sm9jS2k1dHRBSG5xSUVBbUUyQ21O?=
 =?utf-8?B?cVVNU1FJRGxTc2ZEc3ZSRDZGT0t6SmN1dThxc2p4NW9VSlBTR2xiK3Q4QWVO?=
 =?utf-8?B?S1E3ZDRxTXEyTjdpdWFsbEZuV0lMckJ5WWhhbmRVWHA3VloxZ0ozcm9kL1RG?=
 =?utf-8?B?UEFYU3JBMmF6R1hwcnlhMXBnWU5RQk9VbVRCdzBTOEIrejRMZ3hJNEtjYy9V?=
 =?utf-8?B?L0hCSFRIS0xzcGNpemhkNmN0a3VsYWZ3THpCN0N4TnpQdUo3YmxHTU1iYzMr?=
 =?utf-8?B?R3ZBQnYyNjJMdXh0ZUJzVTNrcTNlU3BWRDlobGdmek5zRCtqcExLanE5UlFG?=
 =?utf-8?B?Z1FhWlkwNllsdU9IY3pSSGxyLzFFNVVVWkJvS1k4Nm5mZitldGJrUmtqNDNj?=
 =?utf-8?B?MXNOZlJycGE0eEM0cWV2T3lISk1xNHFRQkZFdk5HZG5waitGUWlTcHhHOGdh?=
 =?utf-8?B?WkMzTHhzbVlCdEYwSStpaGJBTjZaWmFLSEhIaGZHRkdKTVFac1FyaWlMZ1U1?=
 =?utf-8?B?c0xhRVNOaHJvby9nQTR4aUlZVmlmTmYyZUVkRzlsbk9MUUlTS2s2RlNaVEZx?=
 =?utf-8?B?WVlQYUJVbllVcTJ2YXhJTkNDblNrMEdSMllqZExOUFRRYUY1M2hVd1lXdFpy?=
 =?utf-8?B?SnVrMTliU2w0TWFkd04rOHFJcjVJRHFGWlgxekxvS1JkL2Q1a0pWYWlsK3Mz?=
 =?utf-8?B?SWpiWmVCYWJQTW1MU0FaRTRjcFVuSU84U0JyL2dQY3JzTTM5S0tmTXZKeC9j?=
 =?utf-8?B?SC9nRDZXeEo0cENHUzFyWEFFeWFPNFY4cTdoMEcwM0ZDT3RKaUo0YUNzOXBV?=
 =?utf-8?B?eVRPMGdnWS9peURoQ0gxc3lxSXUvZnZDNjNWYml6NzZkTGxnaU1iRXpaRWp2?=
 =?utf-8?B?VTdWV05adXZXbzJpcTU0OHArUFdTZmFHQjMxNmEwRWJnN0huck54dTcxS0FD?=
 =?utf-8?B?YTNlakNXM2FaL2M3cVE2N0NGUE1TeDRWazFJSWJVM1A3QUNFdkZVeUdEemd0?=
 =?utf-8?B?ZXI5anVCNndnbkFIUUorQXFvZGppWWZPUDFhTC9EN3BFaWxtZDZ5V2Q0UFh5?=
 =?utf-8?B?Q2JrUEVIMDR2WlV4MVNqaWtPekQ2amFoMkRydS9BNXRhSG1Ra2F2cmErb3Zy?=
 =?utf-8?B?RkpWbjlCWVd2bDZ2aW9GTjlSemFYZFhtd2wvYzFRLzI5RFdGUkdTSVdLcjd6?=
 =?utf-8?B?bzBMV2JSMHd1UU1vYWdUalNleXNXcXd4QjJBS0VZaGFNelNTcUZlb2xaUHBu?=
 =?utf-8?B?UWsycE1pcUgyYis3Nlo4WEhmMlRWbE5JRVVIcFFMdy9GZzY3SThQc3BwUjAw?=
 =?utf-8?B?bW9qbzRaTDJZL0c0NkhEQlB2eVpoMitYSnp4RGNQWndwVldHNXVHMkJWUFZY?=
 =?utf-8?B?UG1RNmxDTWljaFVxbzVNSWF6anF4d052RFBMT0pKTXlMQVBRalFETzFmS29X?=
 =?utf-8?B?T3Z4OUYyTWVKWTMyT0dDVEcwUGRmRnI4MDVZcTYza09TczUrZzJvN0NvU2hB?=
 =?utf-8?B?cUVCYlBEVU90WGZqTm5uOVpCb0pJN0J6eUpzUUw5SEkxeDQxaGNtMTE5cjBH?=
 =?utf-8?B?b0Y1MUhJVTUya2JQVXpJakFDa3I4cG1tTmVmb0VTOW1XMFdkNnAvTHZkWnVE?=
 =?utf-8?B?M0hzQWs2c3hOcFZjU1dkaTRQeHRsVEhtT1B0NEpoaWtoakh4cExOaXRLRWw5?=
 =?utf-8?B?eWRxSjlvVGEzOEFuWXBnVTROcnFleU5WRW9FSlczZWJFYXAxaHk1NnFremlV?=
 =?utf-8?B?OWFVQXd5V09xSk5UMDlCRXZRdGdaWEk2QUJkMXMvdmJaV2c3T3dMd01uT0dr?=
 =?utf-8?B?em1tNXVIdGY2Vmg5c3M4SjFBVUo4ZVNlZGhBdng0OHo4NWxOcDl1Nlhjc2tN?=
 =?utf-8?B?YTROOWdqNFdBVVUvSnN4b3Zmd1FoVnFYbGxzZ3pxRUROUHJkeFBIRE9maDhF?=
 =?utf-8?B?Z3BEMUFvM3U2dlBuWndyRDV5RUxiamh3UktGMmdWK0g5WEx3Y2ZnNy9qcFJx?=
 =?utf-8?B?WFZkakVTZ2xNQXpKRzJqaVBqamN2WnlsdlNIbW5EVktYeHJubEQ3WVpwTUd3?=
 =?utf-8?B?YjZTS2Q2UTg1TXIya25HS0VwV0VWMy8rT2trc3FZRXpuR3BsSE9ZY0NOZTNT?=
 =?utf-8?Q?MCl51FBBFgxGEF8r4bgqIuu2M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5060e0-c33f-4132-2fff-08db5744c967
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 02:08:35.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ob+S7Jfe5frWUYkE5C/sMlwdVpWycQVasNhvMs7QLEx7ZVCdta2IyV/8r9cuOcRNQKBESQ/pa9M5W2BBqx3UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ricardo,

On 5/18/2023 6:32 AM, Ricardo Neri wrote:
> On Mon, May 08, 2023 at 02:11:13PM +0530, K Prateek Nayak wrote:
>> [..snip..]
>>
>>
>> Running "grep -r 'cpu_map_populated' arch/" shows MIPS and loongarch too
>> set the cpu_cacheinfo->cpu_map_populated who might also be affected by
>> the changes in commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported
>> through sysfs") and this series. Changes from Patch 1 might also affect
>> RISC-V since Yong-Xuan Wang <yongxuan.wang@sifive.com> from SiFive last
>> made changes to cache_shared_cpu_map_setup() and
>> cache_shared_cpu_map_remove() in commit 198102c9103f ("cacheinfo: Fix
>> shared_cpu_map to handle shared caches at different levels").
> 
> 
> I was able to reproduce the issue on an Alder Lake system (single socket).
> I also was able to verify that the this patchset fixes the issue.
> 
> FWIW, Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thank you for confirming the observation and testing the patches :)

--
Thanks and Regards,
Prateek
