Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C61647DE1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLIGoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLIGoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:44:08 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72DA7125A;
        Thu,  8 Dec 2022 22:44:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdxRGfKlpJGRm2KdC0iUgE7V9vbcZnohk7+2Hm0+4Rf5Z8a/9gqtW4KIpIC+8x1b/KZEsUppjTsL6Nr8OWumx7oTpF6PEUwiB6wO+dZtqXWoQ3i2EUKZQBQe6u7QihmJJvmrF8ioChcnv1wMkFFo0PSJv9wR1YnKzUKVz8PM6MWV3H0W9+7FTozXzcPyMk09+8xGQ4c7EawDxKoqXfnNHCh5Z073LpFOM829VKRghK9QsNtNUwUKQEu6eFWHYmDrtCxqKZCiKJKN75IYpwi9KiuC6cQuNHG/0rMJDcZax12DNJyrD2uHR7x46CGzgpbj2po+vYSLUnuYS9n8d17qEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH9bKJbTdBLWRoYfQhTgpSbn0hghEgyUE/HnF6VcTLU=;
 b=chELt61UPnDGMX0HI8P5qPqdKU6NCJAl9Xjo3g8jEB+GdX4FjlJ0j0+tw0YFNKyKo/bhX4quoxLU8ZXJQGrys3QGapKbX4YLuL8EX1Tss9uqDatGRBX1E/mjVw/ykBNJJahHYFMcIK15DmezNa/Gb3KSOWshxyyzbf2LHp0JD+gvMb1iH+E1XawVxYYEpMIQj31MFhMa15WXPQEKYP2GN2zcU5lTNVKYOjcfKtA8vadY2pNA587gGtGi4iuXXVndv5bO7w3A4r48xCKLN1P/3aRK+vHBwhSLxXXC76Xh+Tlwql1ry2nWnXa21t+BP9s/ixZAhtteRywoFJpQBcb+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH9bKJbTdBLWRoYfQhTgpSbn0hghEgyUE/HnF6VcTLU=;
 b=WeItxTbXUEmaUhTfXOAD6rZRaXl4xKefs6zfntmO+2GL/Xx2FGSn2c6hKAxCF/LkADbrsHx7fy9jONUdLgKHEX/A/7BJCCPYhUxrAasXuE3nG63sDGuxQ7JTgWygkOqxgcFeXtlEs3v47FWMDFju9E3yrBDxVi9ivOfjeRaIRsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 06:44:04 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 06:44:04 +0000
Message-ID: <8da7cbbc-0a03-32e5-cc92-56931365782a@amd.com>
Date:   Fri, 9 Dec 2022 12:13:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] Documentation: amd_pstate: Move amd_pstate param to
 alphabetical order
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Perry.Yuan@amd.com
Cc:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com
References: <20221207154648.233759-1-wyes.karny@amd.com>
 <20221207154648.233759-3-wyes.karny@amd.com> <Y5FPBNawZgvk7GBe@debian.me>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <Y5FPBNawZgvk7GBe@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0216.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::14) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d02e53b-da62-4d3c-20a8-08dad9b0c31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySnNfXC8n83jkZFSzRCw2VGXhcFFa9q8oBSMj66WF2bzj4PCRsis+48tu7XosIPfdSg69bjsUwkoX9x1+r/Y8nymlLR/bbrPH9xu2SgyfHnn4ZP0UU0OTD+XFrupKd7wkkPacVujsS/7p6n36KcXVD+tQbv/PtBA59x6m3VkT+vXD7xxoxRpnux/kUAOpgKkL+b2NPr5BdaLDigwVVtiVnIp2OJPbPb9TtlTuolL9QMTCIDBE8c2dXEyy+em7Glc1xZjx8r6U5owhgiKstenLvRVRBwUx6y46Edst86ihmLQaBsdAbnZ3baEx8LhmnCtSiF/fufbBZS47mZ6E98jZDD52cswF66GDRln7ZYWjLKHtewdfRNYtlkpXEmaR6IQQ/vcihQP4c0gA7X+RbdqvXGZ+/T9ZGNnKO+Jwvba4K2DDAuYrBEBqIrsxCAAM5ZkQfxr1IzrvA5MwqncPu/G1ZvMUmiVZtspP9QzqvJLVFSpJcyTEzzJDMvil/TCRyr+/ZxGZs8JfX3ywSpoIBNLRG+NoPXB2zEx4dibCTE5C+LAixPfzFsBsL9gUZTQcVCgVXnhxXJbXHHB27r7v1hXNnXTd0Ua8PumqHCdwx+Kk6BXhElpZUPxbpEgSc89VMcMYjh3IMZ5wMYEPsyVIyOany2jdPgrC9xZNzVDK9/Rw1JBnSRvbYVMvx6wYC6AQbDJRIdu8EKKv+a8CAttu4Y7zogUNBqV5drIsgwtylq1s5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(41300700001)(83380400001)(6506007)(8936002)(31686004)(5660300002)(4326008)(36756003)(66556008)(8676002)(66476007)(6512007)(2906002)(66946007)(316002)(44832011)(38100700002)(2616005)(6666004)(86362001)(31696002)(53546011)(186003)(6636002)(54906003)(6486002)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXdqaHVzaVEvMUlRWVhudFZvQnJob3lRRXp4a1BhRVYrMERyd294bmkvM3o5?=
 =?utf-8?B?WGViWUFpaFp1MHdvUFFob1dCVldKTnd0ODNUbWFYcUg1UEdDL2lNTWQra3lJ?=
 =?utf-8?B?Z3Uwek50SEIxZ2p5d1ZaSkVSb2lTQUxkNFB4c3R0QmczRlRUaktRRjRHRjhF?=
 =?utf-8?B?YWJlbWhoQXFwd25qZG1PRVZjYXplUlJWWVIxNHhtVDExRlhxNWRoZ1ZyZUN1?=
 =?utf-8?B?MGRwTjZSMjBwZ3MrVlFWNFpNQWxNWEtLOHNiejM0Lzh0Nk5tdGxlLzFrc1RL?=
 =?utf-8?B?VEJYU1ZjRGUrRHl2S1FYbk9hcTZkdDYvb3p6bm13SE9qMG5STldETEJiV1F4?=
 =?utf-8?B?M1RkZEFnNkxEZWJpd093MjFzdmRiUkQyRjJWN08vTHZrajFmTVNUbzRGUUdT?=
 =?utf-8?B?L3RZcTJKUWl5YW1wK0FvSlVlazBlZkJSdU1JUFd1UEpZTlcwNTRnTlkrZVlL?=
 =?utf-8?B?bHJQbHd6bmxObGN4WGQyR2w2eExKRU1XeWNvdE4zVHpLeEZNVU1yalNSRG50?=
 =?utf-8?B?djZNbnZnbUpBOFduWjJZd1l2YVBXSWQzRUVFWDNBNktVSWhJWFEyb2tJNW9G?=
 =?utf-8?B?eWljdlVGak10TTErd1lpZ29mdEVhNkg3Q01manVZclN3N3V3QVJWcytIL0FF?=
 =?utf-8?B?RW5scjBFTjF3ejB0QmUzbVlBR1ZLalI2Q05lWDY0aGxmY2RkWlk1TzRROXlT?=
 =?utf-8?B?UmZaMktad3FHd3ZWME9MSlVjTmlnbnlCSU9OWkhrbU5DVzdkb3Zhbk1GZzdy?=
 =?utf-8?B?S3c4dGFmK1dMQ0g5d1g1dW94UnBBTVBNU0RNbmNFQUJCM1lRWHdndTVPVW1M?=
 =?utf-8?B?cFBRcWphd3NSZEdqSm9scWI1SmhJbEMyaEFmeUpieHZXcXJUSmxDV0tFUVZR?=
 =?utf-8?B?YjBXbHpPYTU5T2NtSU8rZFRFcUh2ak1SU24vYU10ZzdZT2RHTFUvaWpSY3ps?=
 =?utf-8?B?WlFXK01ZbmtPbnBZTXRpaUt4dDQrZ3h2MUE0MWRwMG1OS1V0cHdjZHZqUm80?=
 =?utf-8?B?bjRtSS96Z0FIb3pZNnEzVXVwVWxrQ3hKUFRYQ21teHkzOEhTVTl2ZTNaWUdi?=
 =?utf-8?B?dzd6WExqVWEvKzUwZndaVW9MR1RBdFkyanlIbnAyQUx6TUxkNmJVMEJuNDM3?=
 =?utf-8?B?K0Z4SUMvYnJRUld5SWJlcUpIVW5ibDdEWnM5YTZDN3JySU9kUVZjYzY4MjVv?=
 =?utf-8?B?MHJRcDAxSzR5MVVlTElLK2NNTUduLzJjY3UyWkhGTDJScTh6VTd1azhJbU1l?=
 =?utf-8?B?Tjh5VFpHbnV2T2g5Rkd4Q2hobWlpMEZwcXByUVF0Z1ppemNZZmVXbUlxYUhm?=
 =?utf-8?B?WGxrTnNOUnpnWmoyRTB2b2Z4Z1RzN05lak9jVkZCUHYwY1phS2duWTZwS09j?=
 =?utf-8?B?TXNDL1NqcWh1SVRuNVlNRlNwVGdVTGVDSkZPdHdTRm9hYVJYMk5xb1oxTVVh?=
 =?utf-8?B?S0VjNG9Nb3kzYnpOZVphYS9VN1lWQm0vRGFzVzQ5aVhuK3VITSt0ZHhWWlp0?=
 =?utf-8?B?RDVSY05OMGZVK1ZoMFhOK1hNWTNNaEV0L0h6c2lucTBOMmpWOUU0ZlhaSGJD?=
 =?utf-8?B?dnJEZFVyaG96a3lOdEk1Y2Y3UENXSnp2YkdXblJqME5BNGFHRWZIMllOV216?=
 =?utf-8?B?djdadnQ4NzlIYmdxampORjVkQjNVRDhSRWcrZnBDcEMrTkxweWtOWWlXb2lT?=
 =?utf-8?B?SkJPRnh3M2FCeU9KKy9YY1RqTnphRktpV3ZrQnJIUEw1TkRoVzFqaWwvMmV1?=
 =?utf-8?B?cDJXOTFWeXVNOStEWG9CV2hXOHFNOUlnVU1UNDZ0cXVpcmYwRXdGdWQ0Mkww?=
 =?utf-8?B?VENZOWEzQUx4MmJsYWIxQmNPdXlvUlQwMksrMHEzdHk2aWJuQnpoOFlMSkFP?=
 =?utf-8?B?NUJ5dWpKL3ZWVGZUZysrdXpQOURxdDFFSG00VjRiYUlOd1pzaHdtYUt6RXNx?=
 =?utf-8?B?N1VhVnp1RTBMeitSV3ZuZzkrVmx5ekhnMTBzek4vODA2Q1hMZFRISWFMYXl6?=
 =?utf-8?B?bHdLT2tuNStscUZIdk5PKytKdDVhVG96UlptR0hRQ3Y5Z0tpSWdMY25QVEcv?=
 =?utf-8?B?cGNqVmJRdTd6Z1hXTWxpVmszVnlVejc4SE5KZVkwNW9rdXIraE05cEFNOEdS?=
 =?utf-8?Q?3+aor18Y2FpWBU3EakS2TAqkK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d02e53b-da62-4d3c-20a8-08dad9b0c31d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 06:44:04.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOxQCmkhFwei+CRWCGD+BK+Bh2wTqVWHH9lIFhyqJSu6P76YUen7PjCkouKKOP9oyXqtXU+hxdzYRlzHn06TPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas Sanjaya,

On 12/8/2022 8:12 AM, Bagas Sanjaya wrote:
> On Wed, Dec 07, 2022 at 03:46:46PM +0000, Wyes Karny wrote:
>> +	amd_pstate=	[X86]
>> +			disable
>> +			  Do not enable amd_pstate as the default
>> +			  scaling driver for the supported processors
>> +			passive
>> +			  Use amd_pstate as a scaling driver, driver requests a
>> +			  desired performance on this abstract scale and the power
>> +			  management firmware translates the requests into actual
>> +			  hardware states (core frequency, data fabric and memory
>> +			  clocks etc.)
> 
> Device drivers request certain performance level?

What about the below wording?

""

passive
	Use amd_pstate with passive mode as a scaling driver.
	In this mode autonomous selection is disabled.
	Driver requests a desired performance level and PMFW
	tires to match the same performance level (if it is
	satisfied by guaranteed performance level).

""

Perry, let me know if it looks fine to you?

> 
>> +			guided
>> +			  Activate guided autonomous mode. Driver requests minimum
>> +			  performance and maximum performance and the PMFW autonomously
>> +			  selects frequencies in this range.
> 
> Same here.

I'll rewrite this as:

guided
	Activate guided autonomous mode. Driver requests minimum and
	maximum performance level and the PMFW autonomously
	selects a performance level in this range and appropriate
	to the current workload.

> 
> Thanks. 
> 

-- 
Thanks & Regards,
Wyes
