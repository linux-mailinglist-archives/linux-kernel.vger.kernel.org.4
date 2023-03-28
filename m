Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D486CC7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjC1QQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjC1QQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:16:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2112.outbound.protection.outlook.com [40.107.93.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ACCE054;
        Tue, 28 Mar 2023 09:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK1bPSnqscx/xlHS5rzZA9uvxyoGK4qOXUOHvLdbRYkkYWCiQ4JEV7UjE/sc9gbfvPQjOBpoLUgx/YdHuQQmQ4FqP/l5u1IRfQbWl5P7AEhKs5U7GLyxvwF2cA5NJ3f3O7KAEKa+x7UInno94W7WwA5D7YLLOYhfDtQYWOQ0A2TwM/lJHS+m2YnGIGNB7f8zDCMd5DrHuv3AU1UQjSjZTJDlJpPjQDWpT1ODBCVttjoB2PSRqxiCPfKJ+sD4bbjyd+bkHvwvs7p1RTP9ONtgvjpEQmFHa4AaVMHQmHSRpPEl9Gj+tJBre7CTgdFSZ1Wk/OI08z0bBV4E28EyDdLegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEIDXiUOnYnvcchFb4TfKcW2SLBtwi46oN+ScGHw/0k=;
 b=kMmvS8M/2yzghxvZR6OnU4s+ck9mulv0Kk57C5ciUYzw7n/OZCp/Gcz0/19bUw2+/JXLvpQr5r2grtrdctb96FPSGSDo3nMut6R6Gnj8OMgg0y3huZM66r5a/vfh/cCdXbQYZWO2ampdKrk2H146FMueP70pD51Rx21mDO2ouxpkcM56cXgyUc5gQ1p5BODuGFqHE+Fp0LRQ1dhwX/Jx4mJiKRYNUdk/4cxuPjVTAEevd54nRJ7KAes9UyBGhFhJqO4Eq0Yrl9ZCFJRPQ4m5UO11o4sH3JjvjvBJRULK718s8ef4LyWQlYrVXCm5AIepcn3EcnHmC1CPcTs3lJJFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEIDXiUOnYnvcchFb4TfKcW2SLBtwi46oN+ScGHw/0k=;
 b=ZCfcUo/2VZ6MUd9lgmlnbh6rRizj9wclEMJcn3CYY878jQpRiDL2hlnwA18X1nhmmiBXv8SzraOkxaLccb/NLMoWR8WqNLobpxzWrLciSkGsGDTrrv1TECZtSyK3rhoXmWRI2nHara6LTxSEl5WnIU35FBwbardPH6bASMuE8mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 BN0PR01MB6974.prod.exchangelabs.com (2603:10b6:408:16d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.15; Tue, 28 Mar 2023 16:16:29 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26%3]) with mapi id 15.20.6254.018; Tue, 28 Mar 2023
 16:16:28 +0000
Message-ID: <fd5a6b16-9297-5b11-53d1-4ff3d5be1ddd@os.amperecomputing.com>
Date:   Tue, 28 Mar 2023 09:16:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, Yang Shi <shy828301@gmail.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mathieu.poirier@linaro.org, adrian.hunter@intel.com,
        Jiri Olsa <jolsa@kernel.org>, acme@redhat.com,
        mike.leach@linaro.org, Will Deacon <will@kernel.org>,
        suzuki.poulose@arm.com
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com>
 <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan>
 <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
 <20230313121420.GB2426758@leoy-yangtze.lan>
 <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
 <20230314003610.GD2426758@leoy-yangtze.lan>
 <CAHbLzkqMZMB7sGLbJk82CpE9cssEU+WZYaXhVTVC-B40bY52jw@mail.gmail.com>
 <5a120a90-0b95-cfd0-beff-e9228a9d394b@arm.com>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <5a120a90-0b95-cfd0-beff-e9228a9d394b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0052.namprd14.prod.outlook.com
 (2603:10b6:610:56::32) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|BN0PR01MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e107756-a76b-4fc1-1ead-08db2fa7c926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WJaOUPixyEhHvoMZG/fwEhepnI4eoHOESWMTmsVdVieFW03RN20bFn9QpKgIPCMLynAKJBdd5MgwZfPuknegRrMwzsmWtxIO4pxnNTDI81sBPKSHvflmZYnD6rsjCFmLJbzeo/NKG45O2FIatbW6+FjJghhM+qw+3FQ0ME+hTpuu6T7r2YqmiJatj3lM2uQUIDonq7kJ87mIzMcKW9vmHs4f/fCc3ph5grT3zAwKqbUodXHvpJYubBNZZOo1PVO60EjfiZHl0GJBtwAM17eOVQYNEbozShobA3+7RLrOURA1CuSrHpKGf5OAtTG/D5Mmnvqn5jvjkF0fp89fbTNzkifaOcc4tliqnGY6/bS/it2ShsQjCZ69u1QYEmBEvpwrrBLLQrpNtZaJPrvAeybNcZucHA/5iEehoNo4TcECI+WFSfFfS4bPqeKasFY/on2Ih6QScoldWmlk/vZ3TG4H/5WJ+pNUiIfekpyite9iaSv96/7lmnt32Mk8q+9ogsP6nFB1QRSHlrzMqE6Cz9RcH9RcB7EGMfb7l5bJ6diMiifbabDT49ya97lrbB+NVlUf8a6ZTyJdewyfO2FV7U4IbKY/Sy+aDdtfaOm2/5XkDsnsJoGYQhpG18WWaA/Ue0ywxmdBMBdC2/zcX47JPb7cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39850400004)(451199021)(38350700002)(38100700002)(31696002)(7416002)(86362001)(8936002)(53546011)(5660300002)(6666004)(6506007)(186003)(26005)(41300700001)(52116002)(66946007)(478600001)(316002)(31686004)(110136005)(8676002)(6512007)(4326008)(6486002)(66556008)(66476007)(54906003)(83380400001)(2906002)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFdvODN0UTNwQ3kzbXlwSXF4TGlKcHNhMzA0ZGFkM1I3UE85NlhFTk9PNWVI?=
 =?utf-8?B?MGc1NmpURDI0SGxvaG85TTNkejcxR0hsbEFXdFV1Mml2Y0Z3aFYzcUpaTGNW?=
 =?utf-8?B?SS9MZnZnamJsVXhaaEhTcXpQY1ZHV0x0THZadktTZ2NHYXdFV0U1czhDMGYv?=
 =?utf-8?B?bVRHNWl1M2YvMVdvQjFTdHo0SzM5SEJpM3JnZWxtbU9ENExoL2ZhZzR0QWpK?=
 =?utf-8?B?UjdNYk5jcitFNnh5WHFNaWhlRWRWanJKVFRsaGxxc1NGdVVsMUhJSmFmbmlY?=
 =?utf-8?B?dTk2S2RKaVNtUmJuQytBc2k2RG1VR3IrdGt6U1pwMHNKRXlzZHNQTldaMlZu?=
 =?utf-8?B?MkpHcEV3SUZzRks3NGhkcVpSMU82eW52YzZBbjNPU2ZBcWk1dnhoVzM1TlA5?=
 =?utf-8?B?ZjQ5V2t0L1NMaVFSaEhvYllpajRwaCtGdEZvYStOR09SdUhGazNDYjMzNDdB?=
 =?utf-8?B?VCsrcUI4WFdLMzRIQ1ZLVHB5VklaWVdmcXNsMEhyb3VwTFpBdnNNUVh1MHhS?=
 =?utf-8?B?SURjVVZ2Q3NYZjBQMXFjYXNmVWFRNlNiY1NMdUZIN2p4NSt3VXJHZnR5MVlP?=
 =?utf-8?B?YTl1ai9neHpOdnNqRS9sQzQ1Y1NoZERTT1lqbFFWSGRCQ3lxS1VMU3ZESkMx?=
 =?utf-8?B?c3JTMGc3QW1WdHBPMVZ2RnRHM0xkZWJTWUFtSk1YT09ySHlhT01jU2xleElJ?=
 =?utf-8?B?ZVg0Zk80Wm5HM1pveWhxT1NqY0w2LzVybjloaTUrTk9Qb2VSL1QyVHZRRWY2?=
 =?utf-8?B?Z2Y2MjNRMUFJRVorZDRBa0NzUjhmazlUTHNqdUNyc29aaElGUHVFenA1K1lw?=
 =?utf-8?B?ZXlJaDl3aHM2S2lpUFZKc3Q5QzdQSU9DSHhOOWhNTU5rUGEyKzdGci9TWlZN?=
 =?utf-8?B?NzJlN2ZZSGsrVXV6YXBueW5SRGx3Q2VGMmVTVkIvbmd5ODJkOC9Jc0FDTDJB?=
 =?utf-8?B?VHJpTTRva3cwcjNXYTVhUE4wOTFteDl1M2ZFWGZTZGpkbHVaaHZHOXUwSXd4?=
 =?utf-8?B?NkI5UEU0eTBaZ0RUWXVuR3M5UE9PRkpGUmViUWJHSDVKTWtLQ016YkVJaWx4?=
 =?utf-8?B?TUVxeWVZV2ZNUkwyRmJvRWNUYUMwbjBiaGlZUlBCOFRFQ0ZMMXNqKzBxUjcx?=
 =?utf-8?B?TFNDWTlJeHNPU3ZMU3BmN2ZmMG4zYlpqdk9UMTJZRkhoV2ZBK01TbTVzaEo5?=
 =?utf-8?B?MEtBazZDd1A1bzdSQkR6STIyVlVTK1dlU29NZ3BLNDdvRXRWR2N1TGZTOGdh?=
 =?utf-8?B?RHRoYzQrUHFCaTNwejRtUWVNWTVudmw0T2RLNHYxUUh6dHRLZk9ZQjlGTUlr?=
 =?utf-8?B?TmthQ0NTajBFVjYzNWUvNGs2SXJ5TDJuOVhKcXJubzY4ck5BSW1KNzBFRFBG?=
 =?utf-8?B?OWc3QVRmckw4NTZiTm1GalFIRTltd3c0VEdZcExEMlZDVUF4R1BmL0FlNXpI?=
 =?utf-8?B?a0puOWo1OTh5K1dvOEF6cWd3cHFBVThwVVV3YUZCMk1BdzhMaUlTNm9KdnRj?=
 =?utf-8?B?K0M3bWt2OGNrc3NHZ1UveStsa09NSXR6eWVDM0g4aTNRUS83bzJQL1hUQmYw?=
 =?utf-8?B?MjdFRnozS0pJSGpVVVU2N1BHZ2pZeVlxSkxIMnRJODZWYkJrY0VITmNsK2Vp?=
 =?utf-8?B?M0s1TS8raFBhSU9sUUFTMlIyRGorYVRic3JCVjBkY2JJV012TmJENU9zN01s?=
 =?utf-8?B?dk4yTkpzOWl4WThoSk9zUFpXeFJhdDFoa09FenZGZXpWZ0JmMEc4c1JVYnky?=
 =?utf-8?B?eTJyd3ZyVHI0M3BsdVJjUEJSTDlvQ0k5eFIvMjFOUUEvdVRYTEtZMlF4NTAz?=
 =?utf-8?B?S1lIck1IODlMVGc5c2NQQ2Jhejh0ai9GemdLV2FRRGRjdmt4TjFMVW5xSWR6?=
 =?utf-8?B?YUxaUzNVcEw5RWtXaGtKTlhSenZUUm5PTnlseUFPMk02ZmZDMjVaOTVxbEtQ?=
 =?utf-8?B?YzJoQVhuYjJKcjE2M3VtUmM5YWdiSUhCY0NWLzVWYU5kaXViRUoreWdQZ25O?=
 =?utf-8?B?c2l3aUVFdXlsUEZlRW1ZRkREU0tPalVwdHN6OThycWlkY3F3WHpGWlZqTHR0?=
 =?utf-8?B?RUVVNEFMY2pkOVFKRFlEZ1B4WmMyNVE1Wk02SDFiUTVZd0xsMGFqY2k0K1Mw?=
 =?utf-8?B?a0VNc2FrYzJpOFlxd1ZsOEVCNndiaEFLSDB2RWZXbGtJenFXVTFuMzNFWmV1?=
 =?utf-8?Q?nFMXv/byvqiGdxlZEDDvqpE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e107756-a76b-4fc1-1ead-08db2fa7c926
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 16:16:28.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKg33GcZ0rZ6EWU2vaUMGlXth9a6UXhn5OSzZxfR9Sgh+u2zoEPa6Qpw1BKAbG807y6UYyL20+1KB6HUnvjNLmwINmkaQhuD0CjM+uvnfqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6974
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 1:59 AM, James Clark wrote:
>
> On 28/03/2023 01:53, Yang Shi wrote:
>> Hi Leo,
>>
>> Just follow up on this one. Any update?
>>
> Hi Yang,
>
> Sorry no update on this yet from me. I was just finishing off
> "coresight: Fix CTI module refcount leak by making it a helper device"
> which I hope to post in the next day or two and then I will start on this.

Hi James,

Thank you for the update.

>
> James
>
>> Thanks,
>> Yang
>>
>> On Mon, Mar 13, 2023 at 5:36 PM Leo Yan <leo.yan@linaro.org> wrote:
>>> On Mon, Mar 13, 2023 at 11:15:44AM -0700, Yang Shi wrote:
>>>
>>> [...]
>>>
>>>>> Just a quick summary, here we have two issues:
>>>>>
>>>>> - With command:
>>>>>    perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
>>>>>    -- taskset --cpu-list 1 uname",
>>>>>
>>>>>    perf doesn't enable "text poke" attribution.
>>>> No, it enables "text poke" and perf fails to decode coresight trace
>>>> data too. It doesn't matter whether "--kcore" is after or before "-e
>>>> cs/etm/@tmc_etf63/k".
>>> Understand now.  Thanks for correction, if so we can ignore this one.
>>>
>>> Leo

