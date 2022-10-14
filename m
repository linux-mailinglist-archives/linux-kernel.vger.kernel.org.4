Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECD5FF19F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJNPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJNPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:44:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC041D4DD2;
        Fri, 14 Oct 2022 08:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvisPIX64fqvgb9ka4uu7vIKqpH3TdW7u7jAb/avmlnGudb+DvDR/GbtTs4vuYBnGGRtYLh4hME8oQJDgrcbxtnvbL0zWjrva5g+uDaq2i6m0NY3JEy8ytTIOB3uqlMVGAl89LNncuLL5NIU/h3Vd3NqAwF1C0rGV1jBNoM8Bu/nuRAkb6K35Z6woiWMCaFOAtvGOvSWFXODIXREduiHwB9QtvofX1B8Bes2b15Tli6m2zgqPNw4PgxWmO2YVsjFvSFBbNyb1RrqDJHUYL7kJ8D4NQTY0yJQmqos674myIlIL1E3QG6qG2CrhZ3pzV8eheGGI7i1aGsHxEHyssM1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWe8nZK9hJhf/EDxn5aC3M+3XO0537OMuP8ohxUWB20=;
 b=NhB4qNAWk9CRppuxHRmrVwBQFsEI9DCox/9l8hWnJVoq4Y1lVuZh2iDpaHisLhhopcv1xsBdnPxkCviv06GoHKb3v61xaJsHVoHQp5bbid6gghmWOmhOlzyon3L61t2FVyM7c4rJ7wE7O96/KDpaKg3GLGwuNa7LGG5e8Pujaii1z5BCyDKNDWR+JD+wjmfmcKBaVU0CyFfh28JPJ4DyBT0/5tYqwu0iYy8hbzoR9Cq/Zh2B2m5DhN8ByKWRI3FEjUBcK6q+fOaRCefQ9w/s5nXm3hYV7An1PZh64pKzzrjJkQH9UfIkt1T0cmfVXXSd/6x16Q+vQ96nffWdbcbPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWe8nZK9hJhf/EDxn5aC3M+3XO0537OMuP8ohxUWB20=;
 b=b0aKi2UZYaB0hgbTCjzyUmB5c6SCM+4kHT6KK47w3ueJKP6rVpfjwzDb77Ps04h86xhlMYXzyvjZu09y1QF2zy7QLLbwcTQuRSgyiG4oChWhCHBoh8LQrSH76p43vX8zsIWuNEPogatfQJml0CxIwqzRVP6JU+D5aYk3yiQ3u34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM6PR12MB4976.namprd12.prod.outlook.com (2603:10b6:5:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 15:44:16 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::ea28:b6e6:143c:8649]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::ea28:b6e6:143c:8649%7]) with mapi id 15.20.5676.032; Fri, 14 Oct 2022
 15:44:16 +0000
Message-ID: <ebc1bf5a-c46d-376a-79c1-4659f8c7a1c6@amd.com>
Date:   Fri, 14 Oct 2022 10:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221014142454.871196-1-carlos.bilbao@amd.com>
 <20221014142454.871196-2-carlos.bilbao@amd.com>
 <CANiq72=DuRw_0AiC7LtWA7n_0Rpsz3cExXj4YX4zu4o8RxugJA@mail.gmail.com>
 <735f9ddc-01b4-f9ab-8d28-6d10630c994d@amd.com> <87bkqeh0xh.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87bkqeh0xh.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:610:cd::12) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM6PR12MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 9968c3c6-06db-4594-c40f-08daadfaf2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USv/rB8OLSsmjG+fWqDUqcR7Zqy+QU7lL20BxXRZwVFEmR1TjcrMWCq5qvXF1pd4Nw23yMLdvrdIqPRXNDQwTEAc8cTV4o9UlE1NXujocaptO2KP45eWuQrnK7Y0oVlfX6fgZgSuTulwd+0mTMdMJZz/IXN88ZBLUOiWv8ApzcDLy3HUH+PRDerSCznBSi5fwqDj5etGCfpZYXOEM9q2jZB90+GpK5+BNwNcO6nwdC5jk/57GIuopMhXcQLy76WtyInd3UH/yMz+ym1s5ZMOtwelkcaiIXZEn84L9/uzgd2tZW5ycASxXlBEouczB9TCWBe95TTHZV1AlPjsXLBCWq8GEAcqE4JZ+jIPxLFroT5xbi0nIz7SAAGnVUvUxFenY2DCS5Hp00UjwdKqkXZRKRnrcE285luGsafXwjgnxPRCUIeBeI6Bd1L6E4Z9I28hDDJRDCy5Q+lcNNICy1vzcGqjCeHsVmproESPL9J3jOZn2o7ejtYS62mB6+r+da2yw+FfShQci9GtUQMmuUWcVWLEiVDyPIacimsQD1nNFFKicT0WG/XSXuBq4mPtB3ZRYkKPNd622Pw6pARPvNUIl6P8fhiHFY/1CBq40XRG2nJ3L5586Gos/Xv9gmqSRBYnZFxTppnQ1sIpX1XmZ/n78tLPLCiEMZkZlQVuDOWPrJkwx6UO7jXsrvgt9gIFJkpcIbyffMz/Wqb4Lt7WHxhDClM7z8RuHX5Mx0UrTAq+snlJpjPKfY4qVS42hIQwEQR0lsCXT6FFoxz38dJ7dsT/Actyq0P8omoNg9YnL97g2Bg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(31686004)(83380400001)(186003)(2906002)(2616005)(5660300002)(86362001)(31696002)(8676002)(4326008)(36756003)(41300700001)(26005)(6506007)(53546011)(316002)(38100700002)(8936002)(44832011)(6512007)(4744005)(66946007)(66476007)(66556008)(6666004)(478600001)(110136005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXc1b1Rwemw5OE9zTU83VVozajFSTUN3bW5WRU1FcHByM0FTSlFweEtwSHJZ?=
 =?utf-8?B?ZWxEbkZlZlQyQ0sxUDU4ZjVoTHJZVFJDcFFub054WnVHWG5nT2lmNnYxOXB4?=
 =?utf-8?B?WVh4NjFwU0NSYzE4Y1dVL3c2UVlTcVB5S0p0RFp0UGwwMEZmRWNGb2FKRFhL?=
 =?utf-8?B?cm8xa3VHVU85dk5Ta1FFZW1SWkI2bjR5T2xSWFJBU0ZudENxWmk4V1gwUGFP?=
 =?utf-8?B?R28wc1B4SXg1Vzh5d0xYcUd3QVRmQVRKQnI4WndvOHVlN1dWOWYyS0E3aUZV?=
 =?utf-8?B?TVhMK3B1V1UrTFR4TUhxdHpDakt1aVNvRTQ3eGlVcy9ZN3JCMzd4ZnRCM29Z?=
 =?utf-8?B?V3pRcWZFMGhmcEpTcW1UeldTWGtpMGY1OTA1R1lSQmttRnNmb1IyQ1RhTmw4?=
 =?utf-8?B?VEcyWVQweDdsVGxCRUZTV2pQK0NPMWpuaW9qcmhFQXJNRURqWCtuWEpLV3lF?=
 =?utf-8?B?d2FqMzh4VU4yV0I5NzZzZ0hnNm9MT2V6QU9rSmpRS1FLZGRrQVNBdGVLa3dt?=
 =?utf-8?B?RlhLb0xYQ1ZXaDRpdkhRMW5WTFVsTUpOQUlqRnJxUEk3bkorb0xHK2lwcVFp?=
 =?utf-8?B?MlF0ZnhCalUzUHp0aml5Z0hRdlBZTkgyNXNKMjRCY0hJaXdoYVJIT2Z3VHM3?=
 =?utf-8?B?TzRMNnUzVW1wSG9KazBQLzVjQkhTZGd1UnhzeHdneEpiVmlzV2xTNVVSc1lG?=
 =?utf-8?B?QURyMEVucEQrU3VDSTRyWTd0eVNmanBlTno4c0V2YkNhZnhMWE90dlh5K3pq?=
 =?utf-8?B?VHVoejhmUG9yVytzY2x2eFdud3I3RmZQcnd5UVBNbzg3anZaTHFOdkdCR0V1?=
 =?utf-8?B?UE9tNTRnYXdsbU5UNUw2ZEVkSXU0Y3BHbUpIdE1TY2NRWGY2YWRYcE50MU52?=
 =?utf-8?B?U1RUbTF3dGU2UXdPbnpHZG9FeWRQZ1c0L2FZRjdVSy9rRjdleTFxOWJXVGRh?=
 =?utf-8?B?UmRKWEFLRmNZMVA5V0FWeEpmemxnZDlIbmVuLy9iQjYyTUFjR3NoVUpzNU9H?=
 =?utf-8?B?YlhQbFRpWWwzM0VZNDd5QTcrS2YyRXdyMzRXTXl6TEZ0YkFnZG5UaHdFRlJj?=
 =?utf-8?B?Q2VtY3BWRHdTa3hRQVhvV0dDR1pOWklGaDFvVGFBWGRMTmp4ZHpCWWVFVEJY?=
 =?utf-8?B?a3JOZTVsUEZGRlg2Njd0bmdzWVlyckhPUWxxcEkxbFZrV1YzWDQ1bWZtMVBy?=
 =?utf-8?B?cnhhOW15V0xLOVBTSEQ4YTZyaW1GYnFEV0tzY1RleDQ3SnBXNzJ2T1FiVm5q?=
 =?utf-8?B?WkJaR2YyYUFJa20zaVc0c3RDTGM3L3h6Ni9PQzRtdTZKMEI5eHpsRWczS0t2?=
 =?utf-8?B?K3Q2ZVROSmNMUStUc0FTanVjVHJUSU83WDJLU1JTVjIxKzZVQmVKTTNLNktq?=
 =?utf-8?B?Nm1OZERSOEJRTkZ6MkZ1Sk50R21laFNtU0JqejBJcGNFT2wwL1A2YkhjZ0tU?=
 =?utf-8?B?cjY1RFB3SXFrYVVlcnp6dmJod0tvN2V0TWRHN3pJUklTNjBQaVNlUURMVlhJ?=
 =?utf-8?B?RnpkWGlFOVVPa3lwRkFxRlA0SmE1anR6elFsR1gzT2tNQ1pLaGlxRmUwMEYw?=
 =?utf-8?B?Q2JsZjIyOUMwQ09Wczl6eUxTYVBXS0prT01pS2RpTnZPM25ESHZJdXJUZ3Vr?=
 =?utf-8?B?dnZIMk1icG53V1BDbDlsdzdGanFuRjlCRTYzS3VGWlIrMCtVMldwaDJtdk00?=
 =?utf-8?B?LzErSzVXbFlGTWxvblJGOTZTQVQ0cS84bGhvTU9FYUl1Z3RPTGU5M0pWZWxq?=
 =?utf-8?B?L3VGQ0k0MTZWWFhGSEZKcWY2WFkxcUx2ZjZNb2k0UW40MGx3ZkljNFFhMHAr?=
 =?utf-8?B?NDVZeWFLY1plYnNjTFFSYmZIa2JWeUNOZjRWZXNSa3B2dGVDRUJmUStoSWxh?=
 =?utf-8?B?Y01yTHR0RjJJVU9XeGVoOXhmRnB3YVUvOWRQdmh6Nk5yZzdaNVFrc1Ribkd0?=
 =?utf-8?B?TFpNQ3Axa1VyTmJScWhLY29BSitLdEE4RDNQSjk3bWJiT05LN2RNdkxNQWty?=
 =?utf-8?B?eFhFNjB3U3NVcXd1MnJGdi9DK0pGNHc1SVRXSDdwUDg3RHdUNDhPSzdIRXhs?=
 =?utf-8?B?OE9PS3JsbzdwQmRWUS83a2IwOUd2bVlEWXNJd0Vic0lEdmFvZkdpdGFxVFlv?=
 =?utf-8?Q?qCqTL0NC6emJM6iQ5++Jo8G+P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9968c3c6-06db-4594-c40f-08daadfaf2fc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 15:44:15.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9ErdsheN6qauJdJD/J6N/ztM/Jwo9z6O42juqQAoPv4dF/DcBauc70IRROfg/2yckIDK763w0cj4IbFDuKHVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 10:36, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
>> Thanks for your feedback, Miguel. I will wait to see if John has anything
>> to add before I share updated patches.
> I am, alas, not well qualified to judge a Spanish translation (leggo
> facilmente quello italiano, invece :), so I don't have anything to add
> there.
>
> There's no hurry in any case, I'll not apply this before the merge
> window closes.
Sounds good! In that case, I will wait a week to resend, to also give time
for more potential feedback.
>
> Thanks,
>
> jon

Thanks,

Carlos

