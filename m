Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56174E515
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGKDEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjGKDEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:04:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDB62727
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDpcmjfBUp8qSexGCbuMrE7ybT/1fYh0cKLA9J6D5UortG9VAehJteKWEKphg2SprzFp/iazharsz5AZwjYvbUmGGvZucGEKIDwqsWMpVh2maqyEvrvSaRJdRknuA6XIWX0I8JzeITGbNbD7BmCm7db0tdGgdqIpgWnpWRlrrHbTmuGHwWNvNJ6y+D36c+K6QTIMluwL9q8RX6YtXODjtPVX2VcHTD0//bi1H/UxUu5qHg+WVBmxi5t1NgSyacVxb8wTQm15N0I/V0+t5MQYyCSOmJhQ9UpEFMORbev1+l2jsIEjidkW5mt3CYecUkXudHC+XfhBHoAqhls04oro0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hluyxtjTfJqZ+6gsiqcjcM1j0jfs9lYvY9keF+ofB0M=;
 b=CZQ1pzrvS8ibHG/RD/kekmNWqxFyeQersHEpM6xYhbHyiCE378KIKcBH+Jjq+DIS7Vn5C5YG/6ECwTkzR5XfZFaoaiPn4WFY/F6JkmljnjjY7kXHPbM5+ldmrbgl5N0NE+29vPQajXx/xBWNprOfBHpI05swvVfl2hn1JK6f11+PtSOM+K2DM9Pv1pttesdERtkeetOOJx9E7eM3yfoNgAdyW5JBLxFWpn0L2LHwK1ujC9Ty3/rOidovnRtU2KpSb75YTwybv7OwGFrE8PC/9Mamg2fCIrb2D4+0mqVWrrWzG/pPXKIkDxKuH7aiwNejZO6GtqY3nWQ9urkrtUo+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hluyxtjTfJqZ+6gsiqcjcM1j0jfs9lYvY9keF+ofB0M=;
 b=tKdXNc6sjpq7Ak+qneg+UNLnIbVW22sqHDLymT/GtTXsVSJn2820WZC39ngxzmmyr4ywjrldDXNj0c6pdO8hKg4Xd6yX7eApOED5mBe1JbsDlwX0zKRpPew8xg9ttQJ3Q+BCWbgPirT9c42Lp9JVDuAs8S/kzgZGQBXQ/t9VOkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 03:02:41 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6565.026; Tue, 11 Jul 2023
 03:02:41 +0000
Message-ID: <4bb4c12b-4f8d-1069-6fe8-fe256292a763@amd.com>
Date:   Tue, 11 Jul 2023 08:32:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Sandeep Dhavale <dhavale@google.com>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kernel-team@android.com
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
 <ZIEBB-A1arYKSK2P@slm.duckdns.org>
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
 <ZIJbMQOu_k07jkFf@slm.duckdns.org>
 <d686347e-f76c-7f9c-3f1a-f4326f5167ca@amd.com>
 <ZKW4374Xc6YrRrEW@slm.duckdns.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZKW4374Xc6YrRrEW@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0222.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::12) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: efc390ae-f073-43fc-05a7-08db81bb4a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bimMtD/Jth2jTTX33BDDiFlTSFEXEb2Ui/8ObACR/LspAk0YSLTjCUHIdMDs/aAELfPTHQvWWOi1NnNRc2AkCGFLsVsPyl/ZU1SWQZQF6kGZmmpoykET3J4o4jpBJToNj540Md1uif9VYKWpCB4YIUfIuFXQVQGeatWb6RAHR/zRzSQ9R6nnRTw2XbLGl/S1sMy9Aqahusx3o5aQ7XgbS7mfnTjwZhyZBVV5Atr9Yskl/RPczJYDhmIyy+LVK0wwxGuUzrHo5N+scVQyuvPG9quieYFJJqB0m34JUlRBR4YjsD1Nr9wKLhm2/uNh5ZUgywhrbIjDxbrokcvL5Dj4KBmv7fzgH+2PUOcySLrPv22CgOOnvvC8xsQBZa17x1PohvAJYECnAjsQWkHoJuSDMdTabZQzdQaGQ3H9Gu1KkGwblzWH+66CyNmW2cbXdKeatEzdlgF1UFz3vSRSS4eiE8v8TSGbJ11beMrrH/2qwUYEMEBZ3cnvog8R1yFID650ZsGC8pwiIx7BKikwxWgL0vazQWrpi08/wAu29V2X0wzcHCcxn+/ICNQxncZeSu2mQmbLPILGZz7xkRkYuo1IMXcx1CdjcGbCOgAO/Y0WGTLt1oVi+k8RiuYbABLG+nCXvowIl1gYLQnGYTi6hQ5MIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(7416002)(41300700001)(5660300002)(31686004)(6486002)(2906002)(316002)(8936002)(8676002)(36756003)(66476007)(4326008)(6916009)(66946007)(66556008)(6512007)(6666004)(478600001)(86362001)(186003)(31696002)(38100700002)(83380400001)(2616005)(53546011)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU02UisrMHJmM3c0bEhWaUNnamx4d1F6bzM3ZUpKTGlKaklMbDlaR1J6RnBn?=
 =?utf-8?B?Z3BGMS85NlRwUk1MN3M5U1JyT2Fhd1AxYVQ0SEZ5R3dEWWtkcjR0ZW45NDZ4?=
 =?utf-8?B?dEY2OGZnK3ByZzZ3ZEdBZzVnZnpCV2NLQVZFOVlObkVtL0o5Sk9QQ1kwMWJp?=
 =?utf-8?B?Nm1aWXZ3MWl5ejM3NHY3MFpTRHFaU0hzZ2lkS1VMeURPNjA3d0dhVzBCWG9Z?=
 =?utf-8?B?azhicURJMTNvSzJISGhzK2lMbUw5aHBUNko1OFhiamczZ1VnemZSREJ5bmRs?=
 =?utf-8?B?eURJTW9GM0lpM0gzT21uSnpSMklabk5VdG5QcktteGJoNnFIZkpSc1BIR0tn?=
 =?utf-8?B?MmVMQkRHbk91TE5SZ2JRcWhoRGpZaGpVQmVpQ1NlTk5oYTR2REFENTFRUlNW?=
 =?utf-8?B?a3VmL3VMVEtDRW1jY1Y3MW50TUJMQzFsSHZseTBXWVh6NjFPMFlDZXVZTnNS?=
 =?utf-8?B?bk5aUVh5MFpxdzR0MnUvdWxSL213SlZyWWZ6blhmeGdVMHlvS1NIZ2xzM24x?=
 =?utf-8?B?REJKd2p3dDBFUkhVdExCV2prM3dHaVFiMWEvU2xESUppYW1sY0hEMlNCcWVx?=
 =?utf-8?B?ZFkvVkhkb2tHTDNVQjc3dTlkL3FPVWR0NzVOOHhJZVJtVkVFT3hia1FhNjJJ?=
 =?utf-8?B?UW1LZDgyQ3hubUhZK3k2VkhscHVLQis5UGJYU2V6TDlYLzM5bFVadGJNZW9P?=
 =?utf-8?B?ZVdNNkpjRk94ODlxd3VEWmt1dVpSWGcrcVMzcVZYY0hzSDEraU1ZMEU4NTBs?=
 =?utf-8?B?TWxpSGZuNGZEMG84WUZHK0NGNmE2QUhoNUZPaG1pMm5sTTloem55ayt1Tk42?=
 =?utf-8?B?RGVmenBjR25JSU5JdjlxQWVCK0ZPS0thTHRuSlhhOEduY2k2VVhkSnoxQUpy?=
 =?utf-8?B?d0xrUVAxUkQxamRVWHQyTjQ0OGM1a0h1bGV0S3J3ajJkSndUN29QQllrN21O?=
 =?utf-8?B?K3ZhbE1JdzJ2WlhSUzlSOEtzYUFWcEI4aURvbzhBU2xRcjh2R0I0WVNRNG5D?=
 =?utf-8?B?cysyNEpZOEZjcFFoaVY1akZ2eWhsRVluR1hyMnh3T3FQZE1VSDJLYnY4OTVG?=
 =?utf-8?B?aWVORWNGYXFCUTlzVlZKQ21LeXQxSE10bGc1TmZLSmthSFh6MXVQUUdMRkp3?=
 =?utf-8?B?VGk2RXFpenpyZmwwTW9XbzI0a0pzMmZaMTY1Unp4MDJjcjdra1BnMklWOGJo?=
 =?utf-8?B?NnlwVDh6NW04Z1IrbDZsUGo5RDZ3ZWZZVWFKSXlhTVNSeXliQXZvUEVoVFYx?=
 =?utf-8?B?ZHpCL2pKNU1vMm1UVjdpUlRaNW1hcjhrUXE4c1pmRmcraFR6d1RZeVZuU3cw?=
 =?utf-8?B?TjM1cmVMeFZ5UDFWYVFpTkoyQWQ2czZzelVlcnNCTWhXWjQxMnk3WmxDdWRr?=
 =?utf-8?B?RVhIVysweDJYdWNxeEYxNmxFNTIrNGhreWpVM09uRTZXamJQQTI0aytiMXZ2?=
 =?utf-8?B?V3QrYjlCbXA5VURndndXRU5yc1lvam12UitmcXRVMkVscklDY3lVOVAvYmdy?=
 =?utf-8?B?a04vTVpMUDhqRGc4R3NENnFhRzhXRTdLTFR2TDB2RDhWM0lSUUxZUW1taVA3?=
 =?utf-8?B?R0lZV3o5dzNJbTFTVHhDQlZxR3doTUk3MkRxeE1xRmlUMGxtY0tTN3EzMFU0?=
 =?utf-8?B?SlgrOWx5L3ZyU2hJWGZwUkEwTy9YRFIvVE9yS1plbzRNeUcySnFKejlJT2FT?=
 =?utf-8?B?TTlQT0doQk5KdWxGZW9lRk1EbDhxcFlRWUJPVmpCbUVHQkN0NkdITnFXelNp?=
 =?utf-8?B?c2ozaHN0RzR4Ym83RTFSVjZRdVFVbFZHa0ZSUFIzSnVwZmp5eXJkWnFjT1Y3?=
 =?utf-8?B?dzlGRUFiS1JKSUFML0hJeVVHU1Y1NC8zMTRuUFhzQTAwQzdQZDZqQzNTRlNT?=
 =?utf-8?B?d01tK1B1SC83RTMrQi9jOFlOSDBZNlNPanVjZnJFRnR4UUNCTnBRazJhR0J0?=
 =?utf-8?B?ck94K204RGl6ZXk5RDNLTDdLY0E1UHdXTEcwK1B3VlZOclcxWU5GM01MWUlT?=
 =?utf-8?B?b1kwMzc4dnRyd2hBWU02NHBYUWxCYWNVYmEvOXMvMHpucWkrdWNrWi9BVmFm?=
 =?utf-8?B?UjUralZSS3FHMDB0NDZ5ci82T3RoTmpBZUdZQk5kdUVUVGhsV0pkaGo5dEJj?=
 =?utf-8?Q?HFg7TS4rGNMYBz5PRs2o/HGTI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc390ae-f073-43fc-05a7-08db81bb4a1a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 03:02:41.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7UBx4tbjwSpbxsjL6wUDVuglLsp/oxwHzXRvVqHM4fl+/WFL8+O7O51FrCKjSFT4xSR5TnnUdQ9FRKkZuZqUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 7/6/2023 12:09 AM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jul 05, 2023 at 12:34:48PM +0530, K Prateek Nayak wrote:
>> - Apart from tbench and netperf, the rest of the benchmarks show no
>>   difference out of the box.
> 
> Just looking at the data, it's a bit difficult for me to judge. I suppose
> most of differences are due to run-to-run variances? It'd be really useful
> if the data contains standard deviation (whether historical or directly from
> multiple runs).

I'll make sure to include this from now on.

> 
>> - SPECjbb2015 Multi-jVM sees small uplift to max-jOPS with certain
>>   affinity scopes.
>>
>> - tbench and netperf seem to be unhappy throughout. None of the affinity
>>   scopes seem to bring back the performance. I'll dig more into this.
> 
> Yeah, that seems pretty consistent.
> 
>> ~~~~~~~~~~
>> ~ stream ~
>> ~~~~~~~~~~
>>
>> o NPS1
>>
>> - 10 Runs:
>>
>> Test:		base		   affinity_scopes
>>  Copy:	 245676.59 (0.00 pct)	 333646.71 (35.80 pct)
>> Scale:	 206545.41 (0.00 pct)	 205706.04 (-0.40 pct)
>>   Add:	 213506.82 (0.00 pct)	 236739.07 (10.88 pct)
>> Triad:	 217679.43 (0.00 pct)	 249263.46 (14.50 pct)
>>
>> - 100 Runs:
>>
>> Test:		base		   affinity_scopes
>>  Copy:	 318060.91 (0.00 pct)	 326025.89 (2.50 pct)
>> Scale:	 213943.40 (0.00 pct)	 207647.37 (-2.94 pct)
>>   Add:	 237892.53 (0.00 pct)	 232164.59 (-2.40 pct)
>> Triad:	 245672.84 (0.00 pct)	 246333.21 (0.26 pct)
>>
>> o NPS2
>>
>> - 10 Runs:
>>
>> Test:		base		   affinity_scopes
>>  Copy:	 296632.20 (0.00 pct)	 291153.63 (-1.84 pct)
>> Scale:	 206193.90 (0.00 pct)	 216368.42 (4.93 pct)
>>   Add:	 240363.50 (0.00 pct)	 245954.23 (2.32 pct)
>> Triad:	 242748.60 (0.00 pct)	 238606.20 (-1.70 pct)
>>
>> - 100 Runs:
>>
>> Test:		base		   affinity_scopes
>>  Copy:	 322535.79 (0.00 pct)	 315020.03 (-2.33 pct)
>> Scale:	 217723.56 (0.00 pct)	 220172.32 (1.12 pct)
>>   Add:	 248117.72 (0.00 pct)	 250557.17 (0.98 pct)
>> Triad:	 257768.66 (0.00 pct)	 248264.00 (-3.68 pct)
>>
>> o NPS4
>>
>> - 10 Runs:
>>
>> Test:		base		   affinity_scopes
>>  Copy:	 274067.54 (0.00 pct)	 302804.77 (10.48 pct)
>> Scale:	 224944.53 (0.00 pct)	 230112.39 (2.29 pct)
>>   Add:	 229318.09 (0.00 pct)	 241939.54 (5.50 pct)
>> Triad:	 230175.89 (0.00 pct)	 253613.85 (10.18 pct)
>>
>> - 100 Runs:
>>
>> Test:		base		   affinity_scopes
>>  Copy:	 338922.96 (0.00 pct)	 348183.65 (2.73 pct)
>> Scale:	 240262.45 (0.00 pct)	 245939.67 (2.36 pct)
>>   Add:	 256968.24 (0.00 pct)	 260657.01 (1.43 pct)
>> Triad:	 262644.16 (0.00 pct)	 262286.46 (-0.13 pct)
> 
> The differences seem more consistent and pronounced for this benchmark too.
> Is this just expected variance for this benchmark?

Stream's changes are mostly due to run-to-run variance.

> 
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ~ Benchmarks run with multiple affinity scope ~
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> o NPS1
>>
>> - tbench
>>
>> Clients:     base                     cpu                    cache                   numa                    system
>>     1    450.40 (0.00 pct)       459.44 (2.00 pct)       457.12 (1.49 pct)       456.36 (1.32 pct)       456.75 (1.40 pct)
>>     2    872.50 (0.00 pct)       869.68 (-0.32 pct)      890.59 (2.07 pct)       878.87 (0.73 pct)       890.14 (2.02 pct)
>>     4    1630.13 (0.00 pct)      1621.24 (-0.54 pct)     1634.74 (0.28 pct)      1628.62 (-0.09 pct)     1646.57 (1.00 pct)
>>     8    3139.90 (0.00 pct)      3044.58 (-3.03 pct)     3099.49 (-1.28 pct)     3081.43 (-1.86 pct)     3151.16 (0.35 pct)
>>    16    6113.51 (0.00 pct)      5555.17 (-9.13 pct)     5465.09 (-10.60 pct)    5661.31 (-7.39 pct)     5742.58 (-6.06 pct)
>>    32    11024.64 (0.00 pct)     9574.62 (-13.15 pct)    9282.62 (-15.80 pct)    9542.00 (-13.44 pct)    9916.66 (-10.05 pct)
>>    64    19081.96 (0.00 pct)     15656.53 (-17.95 pct)   15176.12 (-20.46 pct)   16527.77 (-13.38 pct)   15097.97 (-20.87 pct)
>>   128    30956.07 (0.00 pct)     28277.80 (-8.65 pct)    27662.76 (-10.63 pct)   27817.94 (-10.13 pct)   28925.78 (-6.55 pct)
>>   256    42829.46 (0.00 pct)     38646.48 (-9.76 pct)    38355.27 (-10.44 pct)   37073.24 (-13.43 pct)   34391.01 (-19.70 pct)
>>   512    42395.69 (0.00 pct)     36931.34 (-12.88 pct)   39259.49 (-7.39 pct)    36571.62 (-13.73 pct)   36245.55 (-14.50 pct)
>>  1024    41973.51 (0.00 pct)     38817.07 (-7.52 pct)    38733.15 (-7.72 pct)    38864.45 (-7.40 pct)    35728.70 (-14.87 pct)
>>
>> - netperf
>>
>>                         base                    cpu                     cache                   numa                    system
>>  1-clients:      100910.82 (0.00 pct)    103440.72 (2.50 pct)    102592.36 (1.66 pct)    103199.49 (2.26 pct)    103561.90 (2.62 pct)
>>  2-clients:      99777.76 (0.00 pct)     100414.00 (0.63 pct)    100305.89 (0.52 pct)    99890.90 (0.11 pct)     101512.46 (1.73 pct)
>>  4-clients:      97676.17 (0.00 pct)     96624.28 (-1.07 pct)    95966.77 (-1.75 pct)    97105.22 (-0.58 pct)    97972.11 (0.30 pct)
>>  8-clients:      95413.11 (0.00 pct)     89926.72 (-5.75 pct)    89977.14 (-5.69 pct)    91020.10 (-4.60 pct)    92458.94 (-3.09 pct)
>> 16-clients:      88961.66 (0.00 pct)     81295.02 (-8.61 pct)    79144.83 (-11.03 pct)   80216.42 (-9.83 pct)    85439.68 (-3.95 pct)
>> 32-clients:      82199.83 (0.00 pct)     77914.00 (-5.21 pct)    75055.66 (-8.69 pct)    76813.94 (-6.55 pct)    80768.87 (-1.74 pct)
>> 64-clients:      66094.87 (0.00 pct)     64419.91 (-2.53 pct)    63718.37 (-3.59 pct)    60370.40 (-8.66 pct)    66179.58 (0.12 pct)
>> 128-clients:     43833.63 (0.00 pct)     42936.08 (-2.04 pct)    44554.69 (1.64 pct)     42666.82 (-2.66 pct)    45543.69 (3.90 pct)
>> 256-clients:     38917.58 (0.00 pct)     24807.28 (-36.25 pct)   20517.01 (-47.28 pct)   21651.40 (-44.36 pct)   23778.87 (-38.89 pct)
>>
>> - SPECjbb2015 Mutli-JVM
>>
>> 	       max-jOPS	     critical-jOPS
>> base:		 0.00%		 0.00%
>> smt:            -1.11%		-1.84%
>> cpu:             2.86%		-1.35%
>> cache:           2.86%		-1.66%
>> numa:            1.43%		-1.49%
>> system:          0.08%		-0.41%
>>
>>
>> I'll go dig deeper into the tbench and netperf regressions. I'm not sure
>> why the regression is observed for all the affinity scopes. I'll look
>> into IBS profile and see if something obvious pops up. Meanwhile if there
>> is any specific data you would like me to collect or benchmark you would
>> like me to test, let me know.
> 
> Yeah, that's a bit surprising given that in terms of affinity behavior
> "numa" should be identical to base. The only meaningful differences that I
> can think of is when the work item is assigned to its worker and maybe how
> pwq max_active limit is applied. Hmm... can you monitor the number of
> kworker kthreads while running the benchmark? No need to do the whole
> matrix, just comparing base against numa should be enough.

Sure. I'll get back to you with the data soon.

> 
> Thanks.
> 

--
Thanks and Regards,
Prateek
