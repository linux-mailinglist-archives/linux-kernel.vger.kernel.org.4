Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774635ECE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiI0UfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiI0UfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:35:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632EA51A0C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxGY4IJ3Wlhv9e0EY66AgKAaCBQ/EoOzzPo1ASYvxx45aEVI92Lq2TTxU4+p+kq/Zg7USXVY9vw6vdEgVoPmcdHUTPP6Ep1iaHKnUOlDh4O/S3GElYHL2keCSjsvI229ylygXXlkfWrGLa+X2QBeRbxUj4A2k6BiyT7/XCA+/3TA1+t4F4l3HjxuDuzuEH6FdSZHvqfYtbbCvGezVYBQUYfjYBF2lORBmIMpHXjOU/coYkUuneak8FNoKqch3B6BADC4RvBNZQdmJbSCmNCcP5w53T/HmeLE7TCArCmnw/Owh0bBNotb+HkG7r/gDd3xsKL9iUCNT0Ws/WP/faVo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/1vIa1uyfJ7kSF454yycziVoVCK4oyv9NwzT/aKcFc=;
 b=OuFpY8pyMvAqVAIbl5Nl23uw2+Q9TOZ0/lIm+WtlM2KFuUH5BQM8U4ynElsLMJgKwF6kHrimy0zO9+CuHtvA/yfqgdWMe45rEW+AOuBG9X7IvIG1hsVCj15G74tZ0K2wG68txZomvvt3pi737SWHMSNyNSPIlFWrfmj6qE3k3VVMI/ZS9uRaYS7JUz1kGbdTT7ACo0hD4pNbCqRUlFc5vQfPMRkNMmEIlXORkpj44IkL7CtV01DnJqwFQJbc0M1alXp3pcaLTU1RvnXKrzic0MiJrIngFbFWrohxAEXMQHRhfGqPXwxWNUOiZyO9kkafYy2G7LTnlRP3fNTv9ckFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/1vIa1uyfJ7kSF454yycziVoVCK4oyv9NwzT/aKcFc=;
 b=fmWwouHJyZFYP1BwG53wx9duyqZPxOeH5o/zBYExmp20uuoVjDW+pwEy6ucYGtNNAHS0hBwmG16jUI09SVMydNXNpaCoE9DriIM7yAOL8x0yCGDYs0BIxlhHtqVh8fcNjnGQqsSyUTM7dOrd8nTZXehrSAWSRnNtb84MrecvMnBSjkX4paVDSLHDZ+Vj2LBn9we+xsZgmnc75wrFozBhVzgQIucv8Cp9x8jeu4W+nCHC/OxHymWetGThPV1+ZFQ5J4FixxmgRTPqXAcwbEPixe6oyDGdcyjuHJGni3OI1N3pVAPq7KDLYgf3OB1iBmLfG31jNR3KbNriS6yXOpNkaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 20:35:00 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b%5]) with mapi id 15.20.5676.017; Tue, 27 Sep 2022
 20:35:00 +0000
Message-ID: <46807002-c42c-1232-0938-5b48050171ee@nvidia.com>
Date:   Tue, 27 Sep 2022 13:34:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal>
 <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal>
 <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:a03:333::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5d891c-b062-44f8-0784-08daa0c7bfcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXzigm03ABfcBjFdnOpoZzW8Mw/zg+dbTZ8xbBOCGlH3A40+Zw8PEDAje1UiZEn5IyoDrUFU+eGKAdmQYkwjXLjxvZP50J92qFiWyLxG9hth7OAod29cForcB/M06ewzR4Xoa+KaUO/v4Y51eOxRIoXRddl2lZuUSJYYrMihfHZoadqqFBPEe8w3CNodosMwJ7iBoF+YvSUa23O9kKkvKs6stEl3pPt53gO5b22KgNpqmHA64Vrzdyq+GZ8ipW1VqHNJAYu8uwmrwW3OCdPa05+IOkV3ojtcla77ATh3IrzBYw6MH+Hf8l3HbdMJ38e3frWwWGyxNq2oS8KXQsa1AT0TSiCzLjny7Yw6JiI55tBsy2GotIdsOSdB8JRIul0paXup+raGzOcUyaJQii0QDQEb5r1XaHw53xNNNSbKBC5hZaSWV+0nM+V7CyZqfga4OwOnYiQJz4dVkfgCgGXOiRiDVkJImbSM2Vl2XbsEkNxbvh20iEUqdV/mbH4j5ljm0eE2c01QbxTzMamhSCyb5tic2w3jVIA8u4a3mYOfQjVbqh9rPZ7vJglEYZ3J9V3b8/AROuR1SG7ei/oXTxUHwgamhA5nyDBM1RnG+nuf6u8Gv6PnXjpwyYGshvfZAO9eEXXTs4SQ2S0GrL2e0D/3kF46kNOrG00wIz3qClgKvP1ymCs2uGzX1vmnI/3wS0r6xzPMYMlb+6jGpm17zJ31lutlunKSfS5zOBULNBIabeX/DQdkTsgmlfpTcnHhWOg2KOc4ckxafb85gr+M+8XgTCgALf+d5CK9YoTgUviQ7OmuRA7UHDapHNRkaITaKlPNnOlFnZoUyjV1HkGk40c+vmwhqxvnau3N/n8si1B8LZfiJnozUQdsCMFEaQyN2IGB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(54906003)(110136005)(478600001)(5660300002)(26005)(6512007)(316002)(66946007)(6486002)(31686004)(6636002)(8936002)(6506007)(41300700001)(53546011)(66899015)(2906002)(66476007)(83380400001)(38100700002)(31696002)(966005)(186003)(86362001)(36756003)(66556008)(8676002)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTFOWTlEWTY1ZjR1Y3p3V013NWgwd01ZZnhlVXU0aWdPQUc1eDhvSnlQaUQ0?=
 =?utf-8?B?K0ozaHl6V3B4VTkwUEFScVJBbnhWdHBBNjZoVlB3MlhmSXNxZzlaN3Y0Z1Yw?=
 =?utf-8?B?a1V4NXlsM3Fyb1NkZ2R2MjI5LzZuWlpaN2RCNzV4Tkh2U3FnY0Z1eG5PVUxp?=
 =?utf-8?B?THRmeEY4Vm1lcnlTODRQMThuZjhFMkxnVFNld0oxaHJaZ1BnOE1ERE5pRys2?=
 =?utf-8?B?WEg5QklOM0NVTUEzdDlwR0ZJVDVybVVnUFBOdGRnSEhhekJtdFR6R2JMeUlZ?=
 =?utf-8?B?Q1F0VnpIZVBtbXBMWjhrUUNEWUliT1pBQnRGb1lRTEpld2dzRVd1d2dmMjN4?=
 =?utf-8?B?NXo5S05iVTBuUmlQQTRSZmxKQ3hSK1dYSE5zdXREY2VDeDAwVWFUMmxad3Ft?=
 =?utf-8?B?QlJEalliczByYkQ3REwxalVoYW40b0NXL0tyZHp0YWp0TmtCa0NabENGcnZ4?=
 =?utf-8?B?MzJ6am5QM0hXZlhVcDd0M1lzR0c5dk0yVW1LSVRXeHlWV0RaZWVWODdoNkpn?=
 =?utf-8?B?UzR0UXdZZjdSa21uVzlrZS9nWlB3UEJWaWs4K09OU09xQkJFbFhJdUY3ZmZD?=
 =?utf-8?B?d0pkVkhlZXNxSFRhUTVYRlY4ODd3SkFRKy9ud3lDckdvMFVHdFQydVJmN0lp?=
 =?utf-8?B?UC8rTVYrSXZVL2twMGJYdE5FNTRQUHJ2ajA5UThNT0laWW43dFRmUHVsdnky?=
 =?utf-8?B?SHlPNVVyTUpka3Ivd3RSVzBMYk9GK3FqYUlwOWNkbU40Myt1SFpvVzU2dkRT?=
 =?utf-8?B?aE9neTR6eEIvcnplN3dkendUZVdKVHZXQSsyMmREYS9TR3pUT0lFR0IxU2tp?=
 =?utf-8?B?V0NyMnVqQWYvTUt4emRFNkVOWDZuUThGc3ZLK1hobW14TStmNXp1eWIrMGpo?=
 =?utf-8?B?aHd0Z3A1V0ZlR3lNMXBFSFdjQ0l2emVtRFdVeFc4bTU4c1RsZk9rQVlUL0F5?=
 =?utf-8?B?K0I3WVlGWTZ3dHV1c2IzQnpOeUd0SlNwTThMR3NEVXZrNU5iT2pDaStiSFUy?=
 =?utf-8?B?UW52QzhKUUtYeW5tZlZ0N0VJNDBQOFh1SURsT01ldE1jRHR5cUVUUHRvVThQ?=
 =?utf-8?B?cWRIMGh5LzFUbWNZbDlOMnNNS3k3SDlncEhPNWlBRzdDRmlBK0o3a3NCOFla?=
 =?utf-8?B?ZmxMZUdKeThycWszMk5pRlNpZi9DMGdvQ1loUnZpb1hWRjN5alZEbVN4ZHNr?=
 =?utf-8?B?YjYwTlVTWW1lNmg5SEF0bnNPWFZ4M2RESmV6aVBlenRwK2dZRXJ1U3pYakls?=
 =?utf-8?B?Y2hFVitmakxKcUNDSHlaRDFQVjFPb01SM2RPMzAvelBiY05pNUFVSnBwMjRn?=
 =?utf-8?B?SGtRN0VhUG1XSHNPNXRsZEtMS3N6Z3BGNzMzZUc4dlcrNGdjRytvcnpTaFlL?=
 =?utf-8?B?enhZUzhwZUprMHJ6VTdrbm9hYlp5c1lHcTlXK2UvU0c2Tm5PR2ptbUVUVGhl?=
 =?utf-8?B?Yld0MGxmZ1R2TnlGVjR1cEc0bnAreHI5QWN4b2QvdmVYdGEvOElaY2tHV0lQ?=
 =?utf-8?B?YzNYSUhJV1RzOTMvUkcwYWs0ZEhuWG9uUUtUVmhpS25udHhDWWpUZnVobzhW?=
 =?utf-8?B?NWo4MzZlWUhqNzNuV1NaL0gxMkVHUjlEeEpxYXorMUVGbTRtT29YYWhJVUdD?=
 =?utf-8?B?c3NYeXBibjVlcHVtZm03aWVncjZyVGJhR1ZMNXpsMHBlbGpmSk5qTUhiaTBj?=
 =?utf-8?B?czU4TFBnVzF6MUpqSE5hcTltSHI4WFl3ZU91enFFVlNFZ2NFN3FsQlpyMlQ4?=
 =?utf-8?B?aUhRbUE4OTJlNjdyNFBPb1hudnc3Zk53U0w3Zm14MWhSdlNhWWl6OGh2UzNS?=
 =?utf-8?B?SGRqVGtLSWFhN015MUpvaGpyVGJVMVpncHIvTVZCTzNNL2dmUGdLVVlVZDEw?=
 =?utf-8?B?L0w0NXV4UDN1RTJ2Q215ZDVjczdtWXM3dm04MWxBczg3WkhkZThWSHo3M3Zy?=
 =?utf-8?B?OHQ3ZDhnWlk0RWpTUVhPSWRyOWVJTVFneFlsZHA3OXhYZTVncG9JVUx4QjF5?=
 =?utf-8?B?eFgxenZzSnFZSnhGc2dxcUtXZjlwWUkrU2RxOCtlNkR2K0RZNENGQVMrbm5z?=
 =?utf-8?B?eEcyWHBvYU5BM0sxeS9XSzA2UWhSalVYZnk3d21PODFFZ3FXcjFqakVEaG8v?=
 =?utf-8?Q?8hm+axEkCbVPHu0V95cqyvdWA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5d891c-b062-44f8-0784-08daa0c7bfcf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:35:00.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OC5SBiu1Gx6uAJiD+hpkksf0KcYLtfvgSq41VI+yU0eCUzuEzjUswY48ZE/fn+s6VwzSsaObG3sNRbRBVRJ8GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 18:51, Huang, Ying wrote:
>>> But there might be other cases which may incur deadlock, for example,
>>> filesystem writeback IIUC. Some filesystems may lock a bunch of pages
>>> then write them back in a batch. The same pages may be on the
>>> migration list and they are also dirty and seen by writeback. I'm not
>>> sure whether I miss something that could prevent such a deadlock from
>>> happening.
>>
>> I'm not overly familiar with that area but I would assume any filesystem
>> code doing this would already have to deal with deadlock potential.
> 
> Thank you very much for pointing this out.  I think the deadlock is a
> real issue.  Anyway, we shouldn't forbid other places in kernel to lock
> 2 pages at the same time.
> 

I also agree that we cannot make any rules such as "do not lock > 1 page
at the same time, elsewhere in the kernel", because it is already
happening, for example in page-writeback.c, which locks PAGEVEC_SIZE
(15) pages per batch [1].

The only deadlock prevention convention that I see is the convention of
locking the pages in order of ascending address. That only helps if
everything does it that way, and migrate code definitely does not.
However...I thought that up until now, at least, the migrate code relied
on trylock (which can fail, and so migration can fail, too), to avoid
deadlock. Is that changing somehow, I didn't see it?


[1] https://elixir.bootlin.com/linux/latest/source/mm/page-writeback.c#L2296

thanks,

-- 
John Hubbard
NVIDIA

> The simplest solution is to batch page migration only if mode ==
> MIGRATE_ASYNC.  Then we may consider to fall back to non-batch mode if
> mode != MIGRATE_ASYNC and trylock page fails.
> 


