Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB66EE359
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjDYNoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjDYNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:44:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F7CC10;
        Tue, 25 Apr 2023 06:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ1tqetZCESVR4qatdPSg9sXrky2omZpG/zIrVvQWh2TCyNo0eixDwGCwPqP1PoxmK9/WMyusXOhbJMtmvbZHi0IZZ2iqPurSsNW1AA8M5lQCJySdZRp+q7wRbEZVBawo1Q6N4xyNvCyViaBuHlU9Q/OkdfAcgYgUIkGBjUxIiMbkjZWd7bXft+jdSpjt2b/qeiCjeTBlGnfjcKh1hAPgdieWQwR9n7EoXVEWkhYa7294cBaWdAY28xe7E7lhKtlJ3W/Me9v3dpbAMpb61hXQlNy0Bu5szEMMv1OMG9lE/mU+2QcKXpu2wzzRjlzkRit5o6vnzlxrrrqJcZkUAJ1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAW9B2xZ0/b4crDsxRoS5lzoNNmvDtI4kdoCtsYuQDY=;
 b=Pvf/LXKIHYbAptRspaUOKaM4DhE2Tc1mqAX9GApp3Tzb4bT7W7YAz8JOCo0HQhTvyFVR/UTDjE6FQCjSmoxXT0wQEpAheoZHhWjevwRqA88/co2fhjHRxzVahEYhXdGzTgK5TvTbeRgvlmJfzpBSRd8d2PMQw+MVe9RsbdjcMTYBBHA1xRXYwXCzGqbGJin+04eKAF1aCHKslXr3AJjI4w0B8ZrFUkIP/7sgM7kxfTH/AnSIdGcShglk9Qw1gFzcOj98qkOedTVT50v+BN0UKhGTfLtzSRmLiO6MgbeCJ/yuobI2HqZoeq4cQybku4xOCIbRu10z2K7nL4+GFQYE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAW9B2xZ0/b4crDsxRoS5lzoNNmvDtI4kdoCtsYuQDY=;
 b=RFx4s3udQQW5uK4DBlpeFDMSEMVrh1qH3avsOXl1mAQazOdVGZJm489EHOIatRMUHAP/7p6OZm/B5bQ4eZYxQdJKukEqZeY+CyxiayM3ybbF1/H9lVa7eV7r0XINRbgUtJ3IeRCqB3ELybc8MuhemW3Fk8ihdei1funherTNJ1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 13:43:57 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 13:43:57 +0000
Message-ID: <8c62e7cf-51e8-0e01-683c-e984f3f46f12@amd.com>
Date:   Tue, 25 Apr 2023 08:43:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Content-Language: en-US
To:     "corbet@lwn.net" <corbet@lwn.net>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Giani, Dhaval" <Dhaval.Giani@amd.com>,
        "Day, Michael" <Michael.Day@amd.com>,
        "Paluri, PavanKumar (Pavan Kumar)" <PavanKumar.Paluri@amd.com>,
        "Lal, Reshma" <Reshma.Lal@amd.com>,
        "Powell, Jeremy" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "seanjc@google.com" <seanjc@google.com>,
        "security@kernel.org" <security@kernel.org>,
        "Kaplan, David" <david.kaplan@amd.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <SN6PR12MB270262FCDB71ABF5303A125894609@SN6PR12MB2702.namprd12.prod.outlook.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <SN6PR12MB270262FCDB71ABF5303A125894609@SN6PR12MB2702.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:610:4e::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: be8d0b82-ace6-4a01-831e-08db45931de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hgiXeCgMBgIxhih5k11P24hZwDm/FW+PfiyXgtqvnk04hkHxIGhkNcWj1N5beLIEde8n55iWftYZO0MLyDgXz/17tjVRhBOXwt9StPbQjsyiKTJC9SVnyBoRdf/HtRmPeZodedaFEMY+5tPlZpOW1M760hO7ECi4V50o6SRJjsnCuDGDo57GADeKOP20xyR3eEGYs1WGVt/74XPfuR7hkhRjnSS/JWI93ZtaUZQp+iX6SI/1JOfez9nbibnj8NsRLG7ZcVAg1JcGMMNuKL4mKKZ02UL6T20QLFlK4Y3k0Fox+svIcVKquzhiyd6MfFyi9VSmvPY+Fe02GCKH09kyjiBgqpWT2JYd97mpnuudS1XTIYRQXOrQv4blUCpzNkgHW6q1hS/SI/4K4ZlWkv7jE6FPbpKEgeoalfhSU7jD/Nr3vJnh3fD4poqeRa07kLFxD2JmZGMYrRwdTEGIFqehVqzptV/aMYB24O0b/xniCkxwjJLlav76KOtnFO9vy/gSJOwKayjXGjtyjuFq3GzbzrCMu+mmBkcveArOecsjyH4t08/v3OME97FnQnQ7+fFzoAfjdOnpYWMGfdKP/zBhgAdXl0mK+Gpq5QeEkCox1pd8Wz5+KyYP5lYyfYCZpYy452N3CEzobUWJApLOVQkZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(2616005)(2906002)(30864003)(5660300002)(6512007)(26005)(6506007)(53546011)(41300700001)(83380400001)(44832011)(8936002)(8676002)(31686004)(7406005)(7416002)(15650500001)(38100700002)(316002)(66556008)(66476007)(66946007)(4326008)(186003)(6916009)(36756003)(966005)(54906003)(86362001)(6666004)(31696002)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUw4U1NhY0RmRVFwSEJJZWVwTVNzNHVybSszWm9zY1RCVDRVYTVBRDV0eUkz?=
 =?utf-8?B?VjdCRmNuUUlvRW5Sck8yR1RUT1BIK3o3c2EwSWhVUUNyOWFSOUNXRExoM2R1?=
 =?utf-8?B?Uk9mWXV3M3dBckRBWEM1N1lDekFsSnJZQUhaTjYwbG9tVDBWT0lPVVpUcUMy?=
 =?utf-8?B?ZG9yTWV0Smd4VGszNlBsNFpoSnV0QWZBdU9iOU5JZEdzcDlpVTUySS9YNjNQ?=
 =?utf-8?B?NnkrZWtoeUhqNjE4aUR4N29lYzVjZ2dkVEVZS3NpZlY3SkFqTDgxK09STUtV?=
 =?utf-8?B?ekJjSTRLeGtFdHZ1TGVTc0t2VEUrOEtManR3elVKeEM4eEsvbjFteHM3WmJs?=
 =?utf-8?B?R1ZtdE0wOWZHSTByZFpHYXY2Z3FzRVB2b0VQYnFHV2hONG9TRGF6QkdIRUh4?=
 =?utf-8?B?RlRILzREUUFSNmdiOGNtY3BhQnJocHB2MWVvRThCcmg3QUlJZHBGbE1Ob1BU?=
 =?utf-8?B?MjRJSEtuZlAyanozRUx0cnQzOGZvMXp6TERGcTJtemNSU3ZRZVFJeVJrckZ0?=
 =?utf-8?B?UTVmZjl6MzlYaUlsdVF3V3c5U3lrc1JRY3hiVUFsT1ZNclo0OHZ6WEUvTXRI?=
 =?utf-8?B?QmhWODBDWTBrZkhDN0xCZU9McUJ0RHRKNnRlWnVCaEg5Z2kzUGhYbmpWS0s5?=
 =?utf-8?B?QUJPZHRVQnFNMjdxNzVyaEkycVRhcnhla1ZnTWVKS1FlR0JFT3U4OXdhRWI4?=
 =?utf-8?B?Qm9URWRRRTc1Q2ZNYVBXVDB0QlYyVDRxenJaQnMxSVk2dEVUMWd4UzNWbGFQ?=
 =?utf-8?B?bTVkQXVVTW05VWFhV1dRRFVPTTZEUURGWWM5Zzk1OFNBZFdZZVhkcnNpcGpC?=
 =?utf-8?B?RGRWV3QzVENKTDVYV2lobVMvNThaVCtDUWh3enN6dXBERlJKNkwxVUVoUkRv?=
 =?utf-8?B?NUg3djRkcFJGNXN2OXVUcUpZNUphbk9TUVJwM08vSmtCVGJBYjJyenhyWVdQ?=
 =?utf-8?B?YlFQOHRLL1E5Sk1uQkY1WEkxbWZtOXRBc2xiUVRkUnhrRUNpZW94Y3FlTU1l?=
 =?utf-8?B?WncwS0Yxc3dDUVBJcFR0WDU5YnZqbHJIVk9ndERqUExGUjAzU1JrWlI0alMr?=
 =?utf-8?B?NHk0b2lDWDhPQjVqUFJtWHR0YnJpMlBZUnlETEhvMllTbUcyRXlxMmVLazZL?=
 =?utf-8?B?cTZxamtwSkhDdldpa3YrbzZtSWd1YldPVkt1dkwwS0dlZi9md2dYU2dSc2N4?=
 =?utf-8?B?cWJxVWp0MG5PSFJjSm43RmdmcXNzNEhhK3ZUbnJHRDRvbjRiL0Y5RVdRa3Z1?=
 =?utf-8?B?MEpDckE4a3h5bjNQeTVwUWxuMTJQNnFvTzJ1S0JXMEFlZEEwd0ZKWTVKNzBI?=
 =?utf-8?B?WHBDMlZKdU1vblJ3SUlTaHJFMXBsalRuS3hjM3haUUNpc2tycGJHeDl2ZzQ0?=
 =?utf-8?B?RXR1dW9oTTJmTHNscW9TRHQrUDEyWHRucGIwTzdyQkcrei9jL21LTDkxb1pl?=
 =?utf-8?B?cUNnam1SYVNrSmUrMVFndk5LWUR5M0RYSXBrV013Q0NZb0graVlrdnk3L3ox?=
 =?utf-8?B?Y2dyVyt5UDNoVlBFNDdiUWVaa2UrMXJQQ0dzV2xPR1ZHVDdJdUxkSHo5TjdC?=
 =?utf-8?B?TTZ2T1BqOTVLUnNvQk5BZmw1YWdpWlBZZjJhNTdacFNRUDk3Z05ITXVIMEFq?=
 =?utf-8?B?YzFpTlcxbjdMNFBjYUlNNHIrWm40aUtxU1FwbElDTldrbmI3Tk5FTlYrWDd5?=
 =?utf-8?B?ajhFT2h2S2ZxK21lc2VCUTFPY0ZqT0VZWURhL2ZsWnZ4anc5a0Q2RUZsM21C?=
 =?utf-8?B?a25FeURrMys1OGZtR1ZxdHVva3c3OXJaMlo3UGh2VGFXdW1FRzgxZ0p1S0VT?=
 =?utf-8?B?clozN055clkya3kwL01nK3loMjRoZGEzZTcrclhCd0tXc05yYnV6NHk5SDVP?=
 =?utf-8?B?NmozM3ZkL2hZdHhDZFlWYnJ3RUlWZ0NrM0ZoRWpERjJLZW5uSW5Sb1ZHYnp2?=
 =?utf-8?B?ZW9oa2JyN2dhZ1hHZlBVNlpZK2d6OFZvbjVjeHRBOWdWMnEva3VveHByYmZB?=
 =?utf-8?B?QjFYSmhsSTM0ZlBPby9FaDNvNktqU2VPenozMzJrVTc1WXB6eE5taVNwd3dX?=
 =?utf-8?B?ZUNERWUzN01wVFJ1K1ErU3Z3a0RaeUw0ZVNiWFFYdzcvWnJHTCttV1M5S051?=
 =?utf-8?Q?OQTtk1j6yrHW85XD8dm01jMzK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8d0b82-ace6-4a01-831e-08db45931de9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 13:43:57.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlVIkrWdsDYNmJmHGsA5l29DwrZswLdem86xCPm4epr5+ok+8cYTrpYZzvm7Y/g8zFi2yaqQOC6ytAZHHK+UoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/23 16:09, Kaplan, David wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Carlos Bilbao <carlos.bilbao@amd.com>
>> Sent: Monday, March 27, 2023 9:18 AM
>> To: corbet@lwn.net
>> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> ardb@kernel.org; kraxel@redhat.com; dovmurik@linux.ibm.com;
>> elena.reshetova@intel.com; dave.hansen@linux.intel.com; Giani, Dhaval
>> <Dhaval.Giani@amd.com>; Day, Michael <Michael.Day@amd.com>; Paluri,
>> PavanKumar (Pavan Kumar) <PavanKumar.Paluri@amd.com>; Kaplan, David
>> <David.Kaplan@amd.com>; Lal, Reshma <Reshma.Lal@amd.com>; Powell,
>> Jeremy <Jeremy.Powell@amd.com>;
>> sathyanarayanan.kuppuswamy@linux.intel.com;
>> alexander.shishkin@linux.intel.com; Lendacky, Thomas
>> <Thomas.Lendacky@amd.com>; tglx@linutronix.de; dgilbert@redhat.com;
>> gregkh@linuxfoundation.org; dinechin@redhat.com; linux-
>> coco@lists.linux.dev; berrange@redhat.com; mst@redhat.com;
>> tytso@mit.edu; jikos@kernel.org; joro@8bytes.org; leon@kernel.org;
>> richard.weinberger@gmail.com; lukas@wunner.de; jejb@linux.ibm.com;
>> cdupontd@redhat.com; jasowang@redhat.com; sameo@rivosinc.com;
>> bp@alien8.de; seanjc@google.com; security@kernel.org; Bilbao, Carlos
>> <Carlos.Bilbao@amd.com>
>> Subject: [PATCH] docs: security: Confidential computing intro and threat
>> model
>>
>> Kernel developers working on confidential computing operate under a set of
>> assumptions regarding the Linux kernel threat model that differ from the
>> traditional view. In order to effectively engage with the linux-coco mailing list
>> and contribute to ongoing kernel efforts, one must have a thorough
>> familiarity with these concepts. Add a concise, architecture-agnostic
>> introduction and threat model to provide a reference for ongoing design
>> discussions and to help developers gain a foundational understanding of the
>> subject.
>>
>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
>> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   .../security/confidential-computing.rst       | 245 ++++++++++++++++++
>>   Documentation/security/index.rst              |   1 +
>>   MAINTAINERS                                   |   6 +
>>   3 files changed, 252 insertions(+)
>>   create mode 100644 Documentation/security/confidential-computing.rst
>>
>> diff --git a/Documentation/security/confidential-computing.rst
>> b/Documentation/security/confidential-computing.rst
>> new file mode 100644
>> index 000000000000..98439ef7ff9f
>> --- /dev/null
>> +++ b/Documentation/security/confidential-computing.rst
>> @@ -0,0 +1,245 @@
>> +===============================
>> +Confidential Computing in Linux
>> +===============================
>> +
>> +.. contents:: :local:
>> +
>> +By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao
>> +<carlos.bilbao@amd.com>
>> +
>> +Motivation
>> +==========
>> +
>> +Kernel developers working on confidential computing for the cloud
>> +operate under a set of assumptions regarding the Linux kernel threat
>> +model that differ from the traditional view. In order to effectively
>> +engage with the linux-coco mailing list and contribute to its
>> +initiatives, one must have a thorough familiarity with these concepts.
>> +This document provides a concise, architecture-agnostic introduction to
>> +help developers gain a foundational understanding of the subject.
>> +
>> +Overview and terminology
>> +========================
>> +
>> +Confidential Cloud Computing (CoCo) refers to a set of HW and SW
>> +virtualization technologies that allow Cloud Service Providers (CSPs)
>> +to provide stronger security guarantees to their clients (usually
>> +referred to as tenants) by excluding all the CSP's infrastructure and
>> +SW out of the tenant's Trusted Computing Base (TCB).
>> +
>> +While the concrete implementation details differ between technologies,
>> +all of these mechanisms provide increased confidentiality and integrity
>> +of CoCo guest memory and execution state (vCPU registers), more tightly
>> +controlled guest interrupt injection, as well as some additional
>> +mechanisms to control guest-host page mapping. More details on the
>> +x86-specific solutions can be found in :doc:`Intel Trust Domain
>> +Extensions (TDX) </x86/tdx>` and :doc:`AMD Memory Encryption
>> +</x86/amd-memory-encryption>`.
>> +
>> +The basic CoCo layout includes the host, guest, the interfaces that
>> +communicate guest and host, a platform capable of supporting CoCo, and
>> +an intermediary between the guest virtual machine (VM) and the
>> +underlying platform that acts as security manager::
>> +
>> +    +-------------------+      +-----------------------+
>> +    | CoCo guest VM     |<---->|                       |
>> +    +-------------------+      |                       |
>> +      | Interfaces |           | CoCo security manager |
>> +    +-------------------+      |                       |
>> +    | Host VMM          |<---->|                       |
>> +    +-------------------+      |                       |
>> +                               |                       |
>> +    +--------------------+     |                       |
>> +    | CoCo platform      |<--->|                       |
>> +    +--------------------+     +-----------------------+
>> +
>> +The specific details of the CoCo intermediary vastly diverge between
>> +technologies, so much so that in some cases it will be HW and in others
>> +SW.
>> +
>> +Existing Linux kernel threat model
>> +==================================
>> +
>> +The components of the current Linux kernel threat model are::
>> +
>> +     +-----------------------+      +-------------------+
>> +     |                       |<---->| Userspace         |
>> +     |                       |      +-------------------+
>> +     |   External attack     |         | Interfaces |
>> +     |       vectors         |      +-------------------+
>> +     |                       |<---->| Linux Kernel      |
>> +     |                       |      +-------------------+
>> +     +-----------------------+      +-------------------+
>> +                                    | Bootloader/BIOS   |
>> +                                    +-------------------+
>> +                                    +-------------------+
>> +                                    | HW platform       |
>> +                                    +-------------------+
>> +
>> +The existing Linux kernel threat model typically assumes execution on a
>> +trusted HW platform with all of the firmware and bootloaders included
>> +on its TCB. The primary attacker resides in the userspace and all of
>> +the data coming from there is generally considered untrusted, unless
>> +userspace is privileged enough to perform trusted actions. In addition,
>> +external attackers are typically considered, including those with
>> +access to enabled external networks (e.g. Ethernet, Wireless,
>> +Bluetooth), exposed hardware interfaces (e.g. USB, Thunderbolt), and
>> +the ability to modify the contents of disks offline.
>> +
>> +Confidential Computing threat model and security objectives
>> +=========================================================
>> ==
>> +
>> +Confidential Cloud Computing adds a new type of attacker to the above list:
>> +an untrusted and potentially malicious host. This can be viewed as a
>> +more powerful type of external attacker, as it resides locally on the
>> +same physical machine, in contrast to a remote network attacker, and
>> +has control over the guest kernel communication with most of the HW::
>> +
>> +                                 +------------------------+
>> +                                 |    CoCo guest VM       |
>> +   +-----------------------+     |  +-------------------+ |
>> +   |                       |<--->|  | Userspace         | |
>> +   |                       |     |  +-------------------+ |
>> +   |   External attack     |     |     | Interfaces |     |
>> +   |       vectors         |     |  +-------------------+ |
>> +   |                       |<--->|  | Linux Kernel      | |
>> +   |                       |     |  +-------------------+ |
>> +   +-----------------------+     |  +-------------------+ |
>> +                                 |  | Bootloader/BIOS   | |
>> +   +-----------------------+     |  +-------------------+ |
>> +   |                       |<--->+------------------------+
>> +   |                       |          | Interfaces |
>> +   |                       |     +------------------------+
>> +   |     CoCo security     |<--->|   Host VMM             |
>> +   |      manager          |     +------------------------+
>> +   |                       |     +------------------------+
>> +   |                       |<--->|   CoCo platform        |
>> +   +-----------------------+     +------------------------+
>> +
>> +While the traditional hypervisor has unlimited access to guest data and
>> +can leverage this access to attack the guest, the CoCo systems mitigate
>> +such attacks by adding security features like guest data
>> +confidentiality and integrity protection. This threat model assumes
>> +that those features are available and intact.
>> +
>> +The **Linux kernel CoCo security objectives** can be summarized as
>> follows:
>> +
>> +1. Preserve the confidentiality and integrity of CoCo guest private memory.
>> +2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
>> +
>> +The above security objectives result in two primary **Linux kernel CoCo
>> +assets**:
>> +
>> +1. Guest kernel execution context.
>> +2. Guest kernel private memory.
>> +
>> +The host retains full control over the CoCo guest resources and can
>> +deny access to them at any time. Because of this, the host Denial of
>> +Service
>> +(DoS) attacks against CoCo guests are beyond the scope of this threat
>> +model.
>> +
>> +The **Linux CoCo attack surface** is any interface exposed from a CoCo
>> +guest Linux kernel towards an untrusted host that is not covered by the
>> +CoCo technology SW/HW protections. This includes any possible
>> +side-channels, as well as transient execution side channels. Examples
>> +of explicit (not side-channel) interfaces include accesses to port I/O,
>> +MMIO and DMA interfaces, access to PCI configuration space,
>> +VMM-specific hypercalls, access to shared memory pages, interrupts
>> +allowed to be injected to the guest kernel by the host, as well as CoCo
>> +technology specific hypercalls. Additionally, the host in a CoCo system
>> +typically controls the process of creating a CoCo guest: it has a
>> +method to load into a guest the firmware and bootloader images, the
>> +kernel image together with the kernel command line. All of this data
>> +should also be considered untrusted until its integrity and authenticity is
>> established.
>> +
>> +The table below shows a threat matrix for the CoCo guest Linux kernel
>> +with the potential mitigation strategies. The matrix refers to
>> +CoCo-specific versions of the guest, host and platform.
>> +
>> +.. list-table:: CoCo Linux guest kernel threat matrix
>> +   :widths: auto
>> +   :align: center
>> +   :header-rows: 1
>> +
>> +   * - Threat name
>> +     - Threat description
>> +     - Mitigation strategy
>> +
>> +   * - Guest malicious configuration
>> +     - A malicious host modifies one of the following guest's
>> +       configuration:
>> +
>> +       1. Guest firmware or bootloader
>> +
>> +       2. Guest kernel or module binaries
>> +
>> +       3. Guest command line parameters
>> +
>> +       This allows the host to break the integrity of the code running
>> +       inside a CoCo guest and violate the CoCo security objectives.
>> +     - The integrity of the guest's configuration passed via untrusted host
>> +       must be ensured by methods such as remote attestation and signing.
>> +       This should be largely transparent to the guest kernel and would
>> +       allow it to assume a trusted state at the time of boot.
>> +
>> +   * - CoCo guest data attacks
>> +     - A malicious host retains full control of the CoCo guest's data
>> +       in-transit between the guest and the host-managed physical or
>> +       virtual devices. This allows any attack against confidentiality,
>> +       integrity or freshness of such data.
>> +     - The CoCo guest is responsible for ensuring the confidentiality,
>> +       integrity and freshness of such data using well-established
>> +       security mechanisms. For example, for any guest external network
>> +       communications that are passed via the untrusted host, an end-to-end
>> +       secure session must be established between a guest and a trusted
>> +       remote endpoint using well-known protocols such as TLS.
>> +       This requirement also applies to protection of the guest's disk
>> +       image.
>> +
>> +   * - Malformed runtime input
>> +     - A malicious host injects malformed input via any communication
>> +       interface used by guest's kernel code. If the code is not prepared
>> +       to handle this input correctly, this can result in a host --> guest
>> +       kernel privilege escalation. This includes classical side-channel
>> +       and/or transient execution attack vectors.
>> +     - The attestation or signing process cannot help to mitigate this
>> +       threat since this input is highly dynamic. Instead, a different set
>> +       of mechanisms is required:
>> +
>> +       1. *Limit the exposed attack surface*. Whenever possible, disable
>> +       complex kernel features and device drivers (not required for guest
>> +       operation) that actively use the communication interfaces between
>> +       the untrusted host and the guest. This is not a new concept for the
>> +       Linux kernel, since it already has mechanisms to disable external
>> +       interfaces such as attacker's access via USB/Thunderbolt subsystem.
>> +
>> +       2. *Harden the exposed attack surface*. Any code that uses such
>> +       interfaces must treat the input from the untrusted host as malicious
>> +       and do sanity checks before processing it. This can be ensured by
>> +       performing a code audit of such device drivers as well as employing
>> +       other standard techniques for testing the code robustness, such as
>> +       fuzzing. This is again a well-known concept for the Linux kernel
>> +       since all its networking code has been previously analyzed under
>> +       presumption of processing malformed input from a network attacker.
>> +
>> +   * - Malicious runtime input
>> +     - A malicious host injects a specific input value via any
>> +       communication interface used by the guest's kernel code. The
>> +       difference with the previous attack vector (malformed runtime input)
>> +       is that this input is not malformed, but its value is crafted to
>> +       impact the guest's kernel security. Examples of such inputs include
>> +       providing a malicious time to the guest or the entropy to the guest
>> +       random number generator. Additionally, the timing of such events can
>> +       be an attack vector on its own, if it results in a particular guest
>> +       kernel action (i.e. processing of a host-injected interrupt).
>> +     - Similarly, as with the previous attack vector, it is not possible to
>> +       use attestation mechanisms to address this threat. Instead, such
>> +       attack vectors (i.e. interfaces) must be either disabled or made
>> +       resistant to supplied host input.
>> +
>> +As can be seen from the above table, the potential mitigation
>> +strategies to secure the CoCo Linux guest kernel vary, but can be
>> +roughly split into mechanisms that either require or do not require
>> +changes to the existing Linux kernel code. One main goal of the CoCo
>> +security architecture is to limit the changes to the Linux kernel code
>> +to minimum, but at the same time to provide usable and scalable means
>> +to facilitate the security of a CoCo guest kernel for all the users of the CoCo
>> ecosystem.
>> diff --git a/Documentation/security/index.rst
>> b/Documentation/security/index.rst
>> index 6ed8d2fa6f9e..5de51b130e6a 100644
>> --- a/Documentation/security/index.rst
>> +++ b/Documentation/security/index.rst
>> @@ -6,6 +6,7 @@ Security Documentation
>>      :maxdepth: 1
>>
>>      credentials
>> +   confidential-computing
>>      IMA-templates
>>      keys/index
>>      lsm
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7f86d02cb427..4a16727bf7f9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5307,6 +5307,12 @@ S:     Orphan
>>   W:   http://accessrunner.sourceforge.net/
>>   F:   drivers/usb/atm/cxacru.c
>>
>> +CONFIDENTIAL COMPUTING THREAT MODEL
>> +M:   Elena Reshetova <elena.reshetova@intel.com>
>> +M:   Carlos Bilbao <carlos.bilbao@amd.com>
>> +S:   Maintained
>> +F:   Documentation/security/confidential-computing.rst
>> +
>>   CONFIGFS
>>   M:   Joel Becker <jlbec@evilplan.org>
>>   M:   Christoph Hellwig <hch@lst.de>
>> --
>> 2.34.1
> 
> Reviewed-by: David Kaplan <david.kaplan@amd.com>


Does anyone have other concerns or questions? Otherwise, Jon, my "V2" will
be the same text with David's RB tag for the commit.

Thanks,
Carlos
