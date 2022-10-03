Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FDC5F32A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJCPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJCPgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:36:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172DA2CCAD;
        Mon,  3 Oct 2022 08:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alTr4Sdz7EQhN3EMb7jyO6X9Dn97g1DXJ7gRldIwEIE8wXOgv04EYIaF65D0hOEBasUoqxEKnor94o4NDQT1ttQxVknjRP9KsL0f006zldcwVxxjQPj9WsnUJC/uzIquFrROT6TR0Do1YA+C4GptWxAf+gfSemZUhBoM7p83Vf9ZxamF2A7YguEM75XtqSXrD400O2hOJoQE0nEL9eS1FGifBwnMGfgElsqJ/c5EwCYD5CnCKvPyo1c3JfsmFovR7l1waOVWtO0xvXrhPuY+C5/IlU8wsE57zfCebDRIZnJlU1KM8vQUstUOcbDZW2/UNIaByGDWuo/tIhA7/rUh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iu1ywa9ZoE8grFfj6y4ESYlYF6r05E8m+3Teuh+oke4=;
 b=ElT6tn9w9c/wzziR3ZbXwV8jKkvfGqi0VzgSjwFn7IHBmIOlNyXlJeWdsIANIJdlLmGQ71hKm6YrnAhRWNcMohsNfblLQEeri50QtpuuUCNuVKYVq1O/vE5fRT0IVDae1h9Lo++ZPh+jPWU7XLNnHete79MREa7YYVeV4j9j/Bob56BdgFu9KiTq7xQKnmRuQc0sU37N5apq8fjV7okvQpeM57aNfZLm1mP4MYX2CwPJ4vI6U1EsALjNT+xco6rjPrFhLCbc18jaZcexNFagx4Ho8wr4doOdnKpUBKEF/aRMNJOmRvJsvExSS4KhmrDRvHTEqwDr+Sgi//NjuWdaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iu1ywa9ZoE8grFfj6y4ESYlYF6r05E8m+3Teuh+oke4=;
 b=rkNHGY6MXIsKhmjQ17k5BcLIYO3U5BAG5JoBk9kanTp8ajHeGqRGca/kA8iIV9uSg3niehkJb0/ib4TNncSUCOgFlPCYtTevLJKpgbS6F6MWH2ToC5AcxI/w1diYIuP4Li93g1VHZbLBaAMJ/QM6puDqJOu8OfMb5jkXyFw7Oqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 15:35:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 15:35:58 +0000
Message-ID: <fa1b00bf-6a7b-dc74-03bb-4fe3e0b2ed61@amd.com>
Date:   Mon, 3 Oct 2022 10:35:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 01/12] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431033184.373387.6520785024194837522.stgit@bmoger-ubuntu>
 <9c45dbf7-854a-1a26-8cec-dde1a1d645e2@intel.com>
 <1cc357af-326e-cf7d-1a8e-2a0c511912ab@amd.com>
 <f42ac1ce-c23d-49de-0b32-d82cd5f49e1f@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f42ac1ce-c23d-49de-0b32-d82cd5f49e1f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:33::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: d699f528-a7ed-4823-9427-08daa554f80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQjV8BvO3JpbaB/lqY1ecXYlb4/p6m4txiV5Xtv4AXlZvuTdglBn9rAAfJIf+g1gXEhHBijjAG5Z7qYgBhenoPVk+5Z7Vni7JInJ6knIOEty6grhLh+CHlYZ3JiL5MWdXal3yV7TdZLvhV4BsJHVXHBYp+d6zZdXWiyfDDXQnL3N1cT1kNY1U/aDMucRbsl1DmQ6F76xhZl9QmhtbJwXmjOnTIDY38I9amGjS41xB5+vepmY5CKTwhn5t8h9YkeKyGBHWySJdh9fB0gSqSF0+r2SVjOUo3FwCorIdcfaz3a3oQZ/kFSsWqtLKYDgBuZWUnCeO2jMwIsOT9vAPCOlfrL8TUP7jJoYAabLjqeiFOsCHSgHsXorz9lbQidGXUWLJdMELFVSdBJdp+/UnpoBmakfXJAwP5Zom4EYbOwYqtqcUOSKRRCiercK6oBg2ogbFR2xXeHDbPx72e8JEYDASCPtW4mm+/jabojI8Xz2sfgvfaEnA+Bb09uGRBCVso2HXUlViImCVPDQuTQlclVSNDhUXX45lZOPauChCu7CBmUxGivNbluF87pP29Iw3P0LajqqyUmzi2UlH2AGJzzDSiqxZv/6ONLZ4Z3bGEadWBk/1zXtee2VCRIMosl4e8aN5wS0MrOfHUUEOwBE3LzJvMPaaFSykwa0ws38yZzBY/VP4Y1IwG+i44IxdPzw5/nJ4EfdD0PjN+UiVYtAPxS7eot3Rn9wjTTeIJSqlLyNJXgPmGqu9cWm0udKFCddYN8SzzGCChuxW4dFxjB8lACym1cZ+oeAakX2l9APvybp+vK6rMgGfYHmK+dvEb8s46N4Z2Vf4nXJv/VHgGUK5iS+W+DBwYAaHlZGqPXeamPsgnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(2616005)(6666004)(316002)(186003)(8676002)(38100700002)(6512007)(4326008)(66946007)(26005)(6506007)(66476007)(53546011)(66556008)(966005)(6486002)(478600001)(36756003)(31696002)(86362001)(7416002)(45080400002)(8936002)(31686004)(5660300002)(41300700001)(4744005)(2906002)(3450700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzcybnJyKzlDMlkyaWcxM0FBOEZldFAxNUc1OHBQdmhHR1M4TWU2KzlDeVpG?=
 =?utf-8?B?R3d0ckNuK0hXamVGek9WUGIwSjVZQWNNaW13Rk4ySGRucXkwRFlCazAwM0JT?=
 =?utf-8?B?N1paRG0vVkxUVE1FMWdEWEgrZmpreXZQSEdUbjlNZ1Joa0hpR0RiVHVuemk2?=
 =?utf-8?B?TUVmVDBibGI5bmRxemgwNWI4WEVZUk5FbUlsWmtBS3pwT0xoRXZIZXNHSHZI?=
 =?utf-8?B?SU9sekd2bHZDM2VCRHF4WGpjSFVRaTBVLzRGTHlwczRFZzlvcElhNXd5aFBJ?=
 =?utf-8?B?ZWE2cG5IZ1dsSnVFQmptZzRsOWtETjFRTkprZzF3dDBTTTNPMUFvQ3V0cTN0?=
 =?utf-8?B?ekZ4ODFyaXBXUzhmNEEvRURJNUYvUWZ3MzFRWk5oZVdGUWZ3TkgwazFRVm1j?=
 =?utf-8?B?U2RvODRwNVo5NHBtbmFhME9QUVJBbjh4S09FZHNrTzFhcDl6Ynk4Ty8rdzJ4?=
 =?utf-8?B?V2h6VnpSajdQV1dIYWNiTnM1bU5iTEJ2Q3ozOWh4YWpudk8wTVljQ2xpbEl3?=
 =?utf-8?B?dnd1VzErWVBwSk43R2NMQ3BBQ1VjZnFQWnJvWnFERmxQTE5TZG8vY1c5UjhE?=
 =?utf-8?B?WEFyczVpWTlHMlNqUmkzZ2daUFRUdS95bkhJRWhtTGhKL2paYjhFdkQ2cnJH?=
 =?utf-8?B?UVRxWmdoeHJvcy9za0wyUHVsNXBzYnY0R3NORjB4YzNnSFdtV3hyN1UzZHBO?=
 =?utf-8?B?eG9ROC94MXRLRXoyeVFBTkhlMzFmUWsxSVNGby9nWklOTTBYMmE4ZTRaWXJX?=
 =?utf-8?B?ZkJWb05rMk82eElUbkIxRHVHRFhiQjkxMWF4cTd2dHVDbkVQbldwV0FkQmhF?=
 =?utf-8?B?TUZ2T2VmMHVuKytESjRrdkNxYTZqZ01NUzFoK3l4MjVONldsdUt6UE1yQndz?=
 =?utf-8?B?TWRZWUxEcVBaRjR2WVlCaE83S1pTSU5DajR5RzhVTisyZWtUc2h1MDBjTEJH?=
 =?utf-8?B?K01rU21QdU1yL3RzVExKODJnM2VXbm9ZanpwbGtVcG9McEUvSUVrK0g1dWVN?=
 =?utf-8?B?c2s3d0tDN0ZzK0M2OEptcC9RZDVjQWZqWGdJVm53akFtTmpHMk1KTmZvTGZT?=
 =?utf-8?B?cXRVZ2JFYVdwNWxiRjJENGNscFFUejVGeFVSVGhDT05uTjNCQUE1R0VvNXk2?=
 =?utf-8?B?M3FxVmJqcjZqUE91QTllS3JXZHFEY2VndmpPY0FrdmpJZFJOTWZOZkdEWXZz?=
 =?utf-8?B?S3M4eVZBSGtySEF0SHErc2xSbjB5cHVKczg2WkpNRHlpQ0U5eTd6eTY0WHIw?=
 =?utf-8?B?WVFaYlBWVTJvOUVoSnp1OVJaZ01qVHR1ellmOGJSZTBZQW1iZjdWYkZLd2RD?=
 =?utf-8?B?dFZSL25WaWtieXh0VG1BK09ZUEUzQ1ZOUFZrRzlDbnNjd0YwWnVEMTR5OEdQ?=
 =?utf-8?B?RjVEb1NwUHdFZGJZb05GbWhLMk9RMm1KWGFzL1ZGUjI2cG9Nc3lCZXJvNVJG?=
 =?utf-8?B?R1VkS3dmOUNrNFRHN0Zmc1BBRUZWU0RhRWo0aHVJVFRQaUY5TWhtK1Y4R2Fm?=
 =?utf-8?B?ZUF0aXZXOWNiUFJQc3dkbytwZkFYN0ltU2REdzlaOHRVTkRPQXFLZVI1Tk1E?=
 =?utf-8?B?NG5sWXZMZ0VoS2VQRlJCbEErQWhDT0VYekdXa3JJbHZLaUI2cGxBclBjSzE4?=
 =?utf-8?B?clZYS3duUkdMbmxWMHZVZGxua0NhQkF0U21ZMk1IeDJxd2d6SVhMMGVhcGF1?=
 =?utf-8?B?d05HNWl4WnJUbTErb21XM1VJaTNxTjhhQjZacHdHeVZjUWpHV1FKeWRCU28z?=
 =?utf-8?B?b1ZZcmVWRkJJU05veitJYTF5M3M4U0dqRGw0TFJCTXA2K3kxVzBqVmxNTzVt?=
 =?utf-8?B?U0lzbFdXWmFQWjBRcHBQLzJ5YnNOMHFsY1lYeG1zcFdWZTFIWjRsUE9WK2VI?=
 =?utf-8?B?UWM5UWE2WFVGaVl4RGc4aHA4cU1DQkFYQWJqaCtOakplamxFZ0liOW12eUNG?=
 =?utf-8?B?OGFwdmdYRTI4K25YdkZZQnVUNE9GOG9wVkN0WHpXakxzbDFiTjY2Q0F0b25q?=
 =?utf-8?B?dkhRd2tzYVhYVERtWjN0S1B2M2RlY3kyWnhuTGQ0akFaNVY4ejJkdTNCR0hS?=
 =?utf-8?B?MFpKamx2L1ZQNjU0L2VoZlpMNkVEL2pFSFVhd2l3b2xUbTMzYXdRc2duWFdq?=
 =?utf-8?Q?pkYc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d699f528-a7ed-4823-9427-08daa554f80f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 15:35:58.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMluqL3yGznfR2zRGeSgf3EbUdbt3j11qdyS1CSoqXeKXsyYFbNNbYQKpRaYOlEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/22 10:24, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/3/2022 7:45 AM, Moger, Babu wrote:
>> On 9/29/22 16:58, Reinette Chatre wrote:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2Fc4a9ea23-4280-d54c-263b-354ea321f746%40intel.com%2F&amp;data=05%7C01%7Cbabu.moger%40amd.com%7C53d5e005b4b74893037308daa5535bcc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638004074680714971%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=njkAflVPfMsB2b3bY3R4D%2FPoweDHkpSejfX52rN%2BVmE%3D&amp;reserved=0
>>>
>>> Also missing is highlighting that configuration has changed from
>>> per-domain to per-CPU and why.
>> Already responded about this in patch 10.
>>
> It is not clear to me which response you are referring to. Could you please
> provide a link?
I meant patch 12. Here the link.

https://lore.kernel.org/lkml/05f0ff0c-b328-46ac-c1fa-7aac09fbb9bc@amd.com/

Thanks

Babu

