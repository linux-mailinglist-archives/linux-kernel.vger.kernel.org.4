Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95B62A048
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiKOR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiKOR1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:27:05 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A710A303FA;
        Tue, 15 Nov 2022 09:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6HtVT/JWLmC4UVbRr+egTDwHp2bTfuHzku7TgTHALzVs9kD0R6TCLz2CL3fMLuSswGuciPRJYhJXJ8PEcoyg8JXPwvx3dNEqttl4FstCjzzQGJTN2ODY2vIxkonUcG6RxsV7UOFjRu7EyrwaG0us1fjSmqYuIIOUVqW6d5ZT93E8AS0nXmCi+byId3R250JGqu1cGJw55r027c7Odf72lTt0YkPmal3HtdLhs5EnqxuAt9AR33OaZM+8/CnQS4MmDLRKzE+25yhAidujIrbqBBz+LwQLNST+otdtmpRVA2L/9SyeebSHB2m0YY5E0tG6FLoYSf+5xckw3RXRoIyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UEy+cNb6ZD8E2nR9hCDDztH4V//IxrYHLaIv8X0BAA=;
 b=A02JlohU43om/npt46n1LtbtXDj9Rc1oihr9jGkPgIQqYpPLixbRjvUpcI1B4EowFP3pVwaOgJdmDueV5ETHQWWUVQUw6W1n2Nr/TK4LWFq0wt/bVMDkzqlHVx0HM63c+i3Mgm1BiaK5Il7/6J695km/xTFebEefhUI6oswrzYF5ENZ24y6rNdLgb3VPkYFK+wmbED/hY+J9V++s/T6/VEkAiHL48WZRIbRLcUf/HlhHhipCAqoRyIBFHbrr+xtYEATCHDrCrJmVcw/TxDF+ycwe4tTKVA8Xt6SMs78q18DO4LfCSvosT5W5ExP9YvkRR1vbFe4+US2vjBg7epfjQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UEy+cNb6ZD8E2nR9hCDDztH4V//IxrYHLaIv8X0BAA=;
 b=1EW+7vxghEL9mkrCu3RmgYL5A4ClpG3O+9W4TTSppK6uUD0YF5EYzb1uU57RNU7gONDWtZJamLWJ955vH/nlhuUv3adZ9+i3n6uOJU7cDJ/bC6gZabTBbFTW5zBPomt2HeDp9uwia7q9pfA4OsokYNnF2tNtC8CqS/euFfeXu+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 17:26:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 17:26:58 +0000
Message-ID: <bb86ba1f-c0cd-ae71-520c-b94d4d71b261@amd.com>
Date:   Tue, 15 Nov 2022 11:26:55 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
To:     Raul Rangel <rrangel@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sven van Ashbrook <svenva@chromium.org>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-2-mario.limonciello@amd.com>
 <CAJZ5v0iwpSkd_8CS1dq6+rkszeKGygBbeifvugAEEKqA0w1s7w@mail.gmail.com>
 <460b23ee-16ed-f1e3-0e14-35051c908671@amd.com>
 <CAJZ5v0id3atXfu1OAsr4kWNwYgyMVo90u9Lu2j4ZNFWQX+QX0g@mail.gmail.com>
 <CAHQZ30BCXtyJ9qqHHX5eztXbgA_A8yH48+AQVMCB64CXjqE+hQ@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAHQZ30BCXtyJ9qqHHX5eztXbgA_A8yH48+AQVMCB64CXjqE+hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:610:4d::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e48a0c5-5943-469c-8653-08dac72e98bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LiGX5JJPThkko6PUf07FkC/UbvxrsRUEs4GI8QySX4GOcCPap3iV1VThLQ3m+gtfttbMp8v8OQvUw2CMygpq9kBj3e2XJ3Lu0wLaonxTe3yEs0W2nmoahZORZfTZs7EHePUg2kH/HNr1KMlOYlci5uYMtv44095Ia9OHLmh55XI40+bA9lv+nfMwMVod2rxY5ar5H5r0OtjPQhYVu8jSC+CGPMtBQmTUp0AcYMQd+tKU/Y901bEAoQvkpg17uvx1cjaDczqb9OjWJ5opgps1UmvW4NKWGgjXvomVhA3k3j02PQ0WT/RH55GYhuhaQONvLEFiID0A9WmEu2TQ5zKHm0UPW0ZekNFds7kwD+f6KCkkeIDLxRuCHcZKlZY/13LjAWmNX4ZzzuEgnYyZ1Hc+b24rZUgD9jFlkzTY1RPjiN7C5WBFJI3h8EvmqMUmUfWZ9yyWfsc1tqe1aj0cUyjDylMQofmAmRhJjX5BCc2WzPgrzblfvHTGJq7TMmshlNwDDwXlFYFCohn9d1fo3F6X4csL27NNaMvQt19vrOv+CYp6rWEuRVN11PwnWBPwNOqT1mERs5zFeoi7ObZm6DXmofPajh9BGaHdr34MNUbHamYjObO6HNE4EM6TS8S+l53ZWdwVB6lP+wTB6El0uRYs3Mw5YFGillr+G78qEmoVribQAM6zCGHxJViK/DQFwKbYC8ZWt26u4v+8ZTGIjUtJP5ffXuJAtI97rU2+aD2kjHNsABIaLnT6I8SgGsrjpoptf/fZQmFbQYkdapwA/cXHCm7iS/upJXZMv31RoFh1GMDRXttENwiEFcO4DncARmhvAjnbAg8W73VU/qpz173AHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(66946007)(66556008)(8676002)(4326008)(110136005)(66476007)(316002)(86362001)(31696002)(8936002)(7416002)(30864003)(36756003)(478600001)(5660300002)(41300700001)(186003)(2616005)(53546011)(6666004)(6506007)(6512007)(26005)(45080400002)(54906003)(38100700002)(6486002)(966005)(83380400001)(66899015)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjV6NFhYWmJ4Y1A2bEpTZ2NMdnJ0MndmUEZZVlJXNmE1QmtnMURkRGVnYis0?=
 =?utf-8?B?emtlNnB1aFNQeDlkYnZlU1praUsvSEtBRHVzSFo5T2VqWU1MZ3U0aUtaRGxq?=
 =?utf-8?B?ckt5UWU1K3l5b3VGL1MwZVFtY0t4eTExRUVyTDFCNG9pL0x0cVFULzdSNGJ2?=
 =?utf-8?B?aWZOY1IyTG5HMWhOOFVPc1R6Z1J1Nys0QlBwTkxOTUxmWU5LSkRudyszQU5k?=
 =?utf-8?B?SkJQaE53NCt1Vm9ocHd4OE1hUkRmWTVSMzc0R09kc054SGp4eVJTL3VrckJm?=
 =?utf-8?B?aFUvU0IzQlc0RWpWZ2I3MHB4ckVJeStoRzBYWE9YN3d4N3JYclY0REx3N09a?=
 =?utf-8?B?VyswSGpjd3VxQy9XQjkxbitzUm1EMFYrNnc0RkFSTUd1b215aDFwejl4TnBo?=
 =?utf-8?B?RTVHZ1p6Z1JCY3JmdENBaXZtS29GN0xpZkVSNnh5aHZrQU84cngzemFtalpG?=
 =?utf-8?B?cXJXZE5uVEo1YURlUW5nMW91ekJZZVc4SmRuK0NXT0xGdU1iTjBKQlQvZlpD?=
 =?utf-8?B?TVRCNDQzRmxmcVBsKzdjYnhJVjJTWnpYTjlsSEMvT09JNUJXUUxybmtoZy81?=
 =?utf-8?B?TDlxYUJoUldwMEY2bGJReWRHRFFENEhsei9zTHF3SHJHMk1hdmJCd0J0ZzZa?=
 =?utf-8?B?QVFHNzRyM0g3WDJsM0l0UUs1dkwyRkE0b2hicmFBajhkQmFkOTlGNml4eVdR?=
 =?utf-8?B?b1RmSllMZ0N5Vzg2ZE9FY3FCZG52bWovMUc4eVZyTTcxQkYwUWdseldqMVRD?=
 =?utf-8?B?eHE1dG9jYjk4K1ozOWRrQTIwZU9TakN3Q2R5V0hncVhTY2VyaHNhV1FuWktS?=
 =?utf-8?B?SlFOWjhEaDl3QVpYNVlET1lXSENXdEQ3U0wzSTl3Q0ViMVNYUzRmTmJsMkZx?=
 =?utf-8?B?UlRyMlRrM0QzdFA2RTdWOGlTbUpDSnZyVThUTDV2blFIYWlXQTN6RE8yQ2Zh?=
 =?utf-8?B?REk3ckQvRGw0d3piSXRCVmhNZGcrSXloUFdqLy9vZFlYVTRpS0VpclhlbXl5?=
 =?utf-8?B?UzBtSlhtWjdPckRpNHc1UEg2ZjFjZWNhM2M4dGl0Z3NkcHRLcnRDc0QzZHVt?=
 =?utf-8?B?ZFU4S3llNXdPR3ZwYWhVSitSQ1pIZ1E5L0ZPZ0lxaUxwWFdJM2dDWXlHVTFh?=
 =?utf-8?B?YmY2cWFjRXB6dkcwcnYzSUx5RkFjMWEzZ3JqeEdtaXlmb3ZGdnY3czZlQ2FZ?=
 =?utf-8?B?MlVydnNIbjVWRUgxVnpYZVQzUitDand1Vkw4TU1jdWdNMkpwdkJjRmUwK2dB?=
 =?utf-8?B?aG9SSXFzcmR1TGI0KzdwdVJaWE9MYWFvNHNYNysvZVFRUnZOdG9JN0tsZkFG?=
 =?utf-8?B?eUM1aFZmaVpFYVo3VlNLb2RYc2NlSitwSjJPRDF1cXJFVDlTWUZPRjJNd0xi?=
 =?utf-8?B?WnQvS0IxRHQ0aEZnaHpXMDBYdzQzOWIzL3NEQmRHUTYxU2tveFNoOGpQbitj?=
 =?utf-8?B?TmFQb2s0SzlRNlFmUThyc1VSZFpiejVOU2dZdDUrUGpKZlBoczA3UHQwVkRZ?=
 =?utf-8?B?Tnh6cEpwbDQ0dFFIcjhsV2FCZzhLQ3ZqMjltZkt2VnpEZ0ZLaU0vRmQrQlBH?=
 =?utf-8?B?TXphV0RxS2I1VC9kdGxWbmI5VzdsdmZvdHdRWTdjUXduQXJJT3FmbDBEbnY4?=
 =?utf-8?B?bHI0Tk9IV2g4YWs2cWVaQ0YwbGwwM3pyZHFRWHhOdnJndHpjZklhcWdoNjhY?=
 =?utf-8?B?Y0s3c1NNZFFnK1JXUkMwTXMweXl6WjFqTnI1YXhzOWh3bXBEY1ArVmhpanI0?=
 =?utf-8?B?aE9xMHVtcHcxRE9KK2l5VUE4ZTVnUHBWeEtycU0zY0hzd0k2aytCckw1bjIx?=
 =?utf-8?B?VndGNkh0N3BnM3pRc1YzejEvWXpBZWZORjc3SjhNM1JKWEIzMzBKMGlpWkp4?=
 =?utf-8?B?VDNNbDg5N3B2ajhNT3R1dkRhakRRN2U2QU8xd0RuUWZzbkJKUm9aMWRUOHl3?=
 =?utf-8?B?KzdDeGZOYzVZZ3c4OXk4TXNQVTJWc2g2R1hYZXhtNng3Nk5ZbWxMcS9LNzly?=
 =?utf-8?B?YldKQVgwRTNZS3RPeEk1VzMyK1UrMXV6NEJxQitPbzZSeFVqTWJXMGxEZ3Fu?=
 =?utf-8?B?RnBLNGsrUFI2Q0lZZGlQblNOTHBDSDl2UHNUUm04WXRML0o5cEVMYzU1T095?=
 =?utf-8?Q?ZpTpdJqQHns3+yq6Ia5v/eGiY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e48a0c5-5943-469c-8653-08dac72e98bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 17:26:58.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYmjXf8X5udytqPRfmIq20k5bcvQVok/apYwrGW39MrTc3GzddPrRC+niJOtgUVuMS83YH7BwCxmIobZl9lp5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2022 11:20, Raul Rangel wrote:
> 
> 
> On Tue, Nov 15, 2022 at 9:35 AM Rafael J. Wysocki <rafael@kernel.org 
> <mailto:rafael@kernel.org>> wrote:
> 
>     On Tue, Nov 15, 2022 at 4:17 PM Limonciello, Mario
>     <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> wrote:
>      >
>      > On 11/15/2022 08:45, Rafael J. Wysocki wrote:
>      > > On Thu, Nov 10, 2022 at 7:49 AM Mario Limonciello
>      > > <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>>
>     wrote:
>      > >>
>      > >> Both AMD and Intel SoCs have a concept of reporting whether
>     the hardware
>      > >> reached a hardware sleep state over s2idle as well as how much
>      > >> time was spent in such a state.
>      > >>
>      > >> This information is valuable to both chip designers and system
>     designers
>      > >> as it helps to identify when there are problems with power
>     consumption
>      > >> over an s2idle cycle.
>      > >>
>      > >> To make the information discoverable, create a new sysfs file
>     and a symbol
>      > >> that drivers from supported manufacturers can use to advertise
>     this
>      > >> information. This file will only be exported when the system
>     supports low
>      > >> power idle in the ACPI table.
>      > >>
>      > >> In order to effectively use this information you will ideally
>     want to
>      > >> compare against the total duration of sleep, so export a
>     second sysfs file
>      > >> that will show total time. This file will be exported on all
>     systems and
>      > >> used both for s2idle and s3.
>      > >
>      > > Well, my first question would be how this is related to
>      > >
>      > > /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
>      > >
>      >
>      > This has a dependency on the platform firmware offering an ACPI LPIT
>      > table.  I don't know how common that is.
> 
>     Required for running Windows with Modern Standby AFAICS.
> 
>      > As this series started from the needs on ChromeOS I would ask is
>     that typically populated by coreboot?
> 
>     It should be, but I'd need to ask for confirmation.
> 
> 
> It looks like Intel platforms have support for the LPIT table: 
> https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/coreboot/src/soc/intel/common/block/acpi/lpit.c?q=f:LPIT%20f:coreboot&ss=chromiumos <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.chromium.org%2Fchromiumos%2Fchromiumos%2Fcodesearch%2F%2B%2Fmain%3Asrc%2Fthird_party%2Fcoreboot%2Fsrc%2Fsoc%2Fintel%2Fcommon%2Fblock%2Facpi%2Flpit.c%3Fq%3Df%3ALPIT%2520f%3Acoreboot%26ss%3Dchromiumos&data=05%7C01%7Cmario.limonciello%40amd.com%7C701602845ad14f37abbb08dac72db514%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638041296400209575%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=9ig2jlDevXMjzmTUf42WS5Ey3rLd2lDUXjncz3mbyMI%3D&reserved=0>
> 
> For AMD, we had some patches to add _LPIL 
> https://review.coreboot.org/c/coreboot/+/52381/1 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Freview.coreboot.org%2Fc%2Fcoreboot%2F%2B%2F52381%2F1&data=05%7C01%7Cmario.limonciello%40amd.com%7C701602845ad14f37abbb08dac72db514%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638041296400209575%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=KV6ASbdfNOex%2FZtJYcdItZU1gdjCIXEcP1ExiY0pkf8%3D&reserved=0>
> They never got merged though. We could add an LPIT table to coreboot for 
> AMD platforms if necessary.

_LPI I don't think makes a lot of sense on X86 today, which is why this 
was sent up:
eb087f305919e ("ACPI: processor idle: Check for architectural support 
for LPI")

As for LPIT - I've never seen LPIT on AMD UEFI systems either.  I guess 
it's an Intel specific table?

> 
>      > I would hope it's the same number that is populated in that file on
>      > supported systems though.
> 
>     Well, which is exactly where I'm going.
> 
>     Since there is one sysfs file for exposing this value already and it
>     is used (for example, by sleepgraph), perhaps the way to go would be
>     to extend this interface to systems that don't have LPIT instead of
>     introducing a new one possibly exposing the same value?
> 

Ah; so since Raul confirmed coreboot on Chrome exports that maybe we 
just need to add another way to populate that sysfs file for systems 
without LPIT (IE AMD).  I think that's a very good idea; thanks.

I think we still probably want to have a way to get the total suspend 
time out programmatically though to compare to.  So perhaps the other 
sysfs file I had in the RFC v2 makes sense still.

>      > > and
>      > >
>      > > /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
>      > >
>      >
>      > No relation to this one for what's in the series.
>      >
>      > >> Suggested-by: David E Box <david.e.box@intel.com
>     <mailto:david.e.box@intel.com>>
>      > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com
>     <mailto:mario.limonciello@amd.com>>
>      > >> ---
>      > >>   Documentation/ABI/testing/sysfs-power | 17 +++++++++++
>      > >>   include/linux/suspend.h               |  4 +++
>      > >>   kernel/power/main.c                   | 42
>     +++++++++++++++++++++++++++
>      > >>   kernel/power/suspend.c                |  2 ++
>      > >>   kernel/time/timekeeping.c             |  2 ++
>      > >>   5 files changed, 67 insertions(+)
>      > >>
>      > >> diff --git a/Documentation/ABI/testing/sysfs-power
>     b/Documentation/ABI/testing/sysfs-power
>      > >> index f99d433ff311..5b47cbb4dc9e 100644
>      > >> --- a/Documentation/ABI/testing/sysfs-power
>      > >> +++ b/Documentation/ABI/testing/sysfs-power
>      > >> @@ -413,6 +413,23 @@ Description:
>      > >>                  The /sys/power/suspend_stats/last_failed_step
>     file contains
>      > >>                  the last failed step in the suspend/resume path.
>      > >>
>      > >> +What:          /sys/power/suspend_stats/last_hw_state_residency
>      > >> +Date:          December 2022
>      > >> +Contact:       Mario Limonciello <mario.limonciello@amd.com
>     <mailto:mario.limonciello@amd.com>>
>      > >> +Description:
>      > >> +               The
>     /sys/power/suspend_stats/last_hw_state_residency file contains
>      > >> +               the amount of time spent in a hardware sleep
>     state.
>      > >> +               This attribute is only available if the system
>     supports
>      > >> +               low power idle.  This is measured in microseconds.
>      > >> +
>      > >> +What:          /sys/power/suspend_stats/last_suspend_total
>      > >> +Date:          December 2022
>      > >> +Contact:       Mario Limonciello <mario.limonciello@amd.com
>     <mailto:mario.limonciello@amd.com>>
>      > >> +Description:
>      > >> +               The
>     /sys/power/suspend_stats/last_suspend_total file contains
>      > >> +               the total duration of the sleep cycle.
>      > >> +               This is measured in microseconds.
>      > >> +
>      > >>   What:          /sys/power/sync_on_suspend
>      > >>   Date:          October 2019
>      > >>   Contact:       Jonas Meurer <jonas@freesources.org
>     <mailto:jonas@freesources.org>>
>      > >> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>      > >> index cfe19a028918..af343c3f8198 100644
>      > >> --- a/include/linux/suspend.h
>      > >> +++ b/include/linux/suspend.h
>      > >> @@ -68,6 +68,8 @@ struct suspend_stats {
>      > >>          int     last_failed_errno;
>      > >>          int     errno[REC_FAILED_NUM];
>      > >>          int     last_failed_step;
>      > >> +       u64     last_hw_state_residency;
>      > >> +       u64     last_suspend_total;
>      > >>          enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
>      > >>   };
>      > >>
>      > >> @@ -489,6 +491,8 @@ void restore_processor_state(void);
>      > >>   extern int register_pm_notifier(struct notifier_block *nb);
>      > >>   extern int unregister_pm_notifier(struct notifier_block *nb);
>      > >>   extern void ksys_sync_helper(void);
>      > >> +extern void pm_set_hw_state_residency(u64 duration);
>      > >> +extern void pm_account_suspend_type(const struct timespec64 *t);
>      > >>
>      > >>   #define pm_notifier(fn, pri) {                         \
>      > >>          static struct notifier_block fn##_nb =                  \
>      > >> diff --git a/kernel/power/main.c b/kernel/power/main.c
>      > >> index 31ec4a9b9d70..11bd658583b0 100644
>      > >> --- a/kernel/power/main.c
>      > >> +++ b/kernel/power/main.c
>      > >> @@ -6,6 +6,7 @@
>      > >>    * Copyright (c) 2003 Open Source Development Lab
>      > >>    */
>      > >>
>      > >> +#include <linux/acpi.h>
>      > >>   #include <linux/export.h>
>      > >>   #include <linux/kobject.h>
>      > >>   #include <linux/string.h>
>      > >> @@ -54,6 +55,19 @@ void unlock_system_sleep(unsigned int flags)
>      > >>   }
>      > >>   EXPORT_SYMBOL_GPL(unlock_system_sleep);
>      > >>
>      > >> +void pm_set_hw_state_residency(u64 duration)
>      > >> +{
>      > >> +       suspend_stats.last_hw_state_residency = duration;
>      > >> +}
>      > >> +EXPORT_SYMBOL_GPL(pm_set_hw_state_residency);
>      > >> +
>      > >> +void pm_account_suspend_type(const struct timespec64 *t)
>      > >> +{
>      > >> +       suspend_stats.last_suspend_total += (s64)t->tv_sec *
>     USEC_PER_SEC +
>      > >> +                                                t->tv_nsec /
>     NSEC_PER_USEC;
>      > >> +}
>      > >> +EXPORT_SYMBOL_GPL(pm_account_suspend_type);
>      > >> +
>      > >>   void ksys_sync_helper(void)
>      > >>   {
>      > >>          ktime_t start;
>      > >> @@ -377,6 +391,20 @@ static ssize_t
>     last_failed_step_show(struct kobject *kobj,
>      > >>   }
>      > >>   static struct kobj_attribute last_failed_step =
>     __ATTR_RO(last_failed_step);
>      > >>
>      > >> +static ssize_t last_hw_state_residency_show(struct kobject *kobj,
>      > >> +               struct kobj_attribute *attr, char *buf)
>      > >> +{
>      > >> +       return sprintf(buf, "%llu\n",
>     suspend_stats.last_hw_state_residency);
>      > >> +}
>      > >> +static struct kobj_attribute last_hw_state_residency =
>     __ATTR_RO(last_hw_state_residency);
>      > >> +
>      > >> +static ssize_t last_suspend_total_show(struct kobject *kobj,
>      > >> +               struct kobj_attribute *attr, char *buf)
>      > >> +{
>      > >> +       return sprintf(buf, "%llu\n",
>     suspend_stats.last_suspend_total);
>      > >> +}
>      > >> +static struct kobj_attribute last_suspend_total =
>     __ATTR_RO(last_suspend_total);
>      > >> +
>      > >>   static struct attribute *suspend_attrs[] = {
>      > >>          &success.attr,
>      > >>          &fail.attr,
>      > >> @@ -391,12 +419,26 @@ static struct attribute *suspend_attrs[] = {
>      > >>          &last_failed_dev.attr,
>      > >>          &last_failed_errno.attr,
>      > >>          &last_failed_step.attr,
>      > >> +       &last_hw_state_residency.attr,
>      > >> +       &last_suspend_total.attr,
>      > >>          NULL,
>      > >>   };
>      > >>
>      > >> +static umode_t suspend_attr_is_visible(struct kobject *kobj,
>     struct attribute *attr, int idx)
>      > >> +{
>      > >> +       if (attr != &last_hw_state_residency.attr)
>      > >> +               return 0444;
>      > >> +#ifdef CONFIG_ACPI
>      > >> +       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>      > >> +               return 0444;
>      > >> +#endif
>      > >> +       return 0;
>      > >> +}
>      > >> +
>      > >>   static const struct attribute_group suspend_attr_group = {
>      > >>          .name = "suspend_stats",
>      > >>          .attrs = suspend_attrs,
>      > >> +       .is_visible = suspend_attr_is_visible,
>      > >>   };
>      > >>
>      > >>   #ifdef CONFIG_DEBUG_FS
>      > >> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>      > >> index fa3bf161d13f..b6c4a3733212 100644
>      > >> --- a/kernel/power/suspend.c
>      > >> +++ b/kernel/power/suspend.c
>      > >> @@ -423,6 +423,8 @@ static int suspend_enter(suspend_state_t
>     state, bool *wakeup)
>      > >>          if (suspend_test(TEST_PLATFORM))
>      > >>                  goto Platform_wake;
>      > >>
>      > >> +       suspend_stats.last_suspend_total = 0;
>      > >> +
>      > >>          if (state == PM_SUSPEND_TO_IDLE) {
>      > >>                  s2idle_loop();
>      > >>                  goto Platform_wake;
>      > >> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>      > >> index f72b9f1de178..e1b356787e53 100644
>      > >> --- a/kernel/time/timekeeping.c
>      > >> +++ b/kernel/time/timekeeping.c
>      > >> @@ -24,6 +24,7 @@
>      > >>   #include <linux/compiler.h>
>      > >>   #include <linux/audit.h>
>      > >>   #include <linux/random.h>
>      > >> +#include <linux/suspend.h>
>      > >>
>      > >>   #include "tick-internal.h"
>      > >>   #include "ntp_internal.h"
>      > >> @@ -1698,6 +1699,7 @@ static void
>     __timekeeping_inject_sleeptime(struct timekeeper *tk,
>      > >>          tk_set_wall_to_mono(tk,
>     timespec64_sub(tk->wall_to_monotonic, *delta));
>      > >>          tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
>      > >>          tk_debug_account_sleep_time(delta);
>      > >> +       pm_account_suspend_type(delta);
>      > >>   }
>      > >>
>      > >>   #if defined(CONFIG_PM_SLEEP) &&
>     defined(CONFIG_RTC_HCTOSYS_DEVICE)
>      > >> --
>      > >> 2.34.1
>      > >>
>      >
> 

