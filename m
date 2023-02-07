Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192B768E0D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjBGTE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjBGTEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:04:25 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A48140BD9;
        Tue,  7 Feb 2023 11:03:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvqdQ41IfvE6nnHAkpl1NrCl+sdeDWxDuwdOq/xGlhgxKfQPJs46rk0klFfpE5kUNg1UWo7dsTrG5G7LdBzskOqdhZ4NPyOeiaZTqhpKh/1Lj327p+NyjSSnvHe0HJlXAugZ2lSYVlitG7BdKRBDJ+0qjxTi7+pZfIJucq20+ZCxAwrq/bjyl0TsloJvdBiCeqS0O/VLcmqI4Hygbm4lOrXdTUjDUo9nDfk4mfpwCBvaOYiLuk8311k77qt91Wfw7OzzYHJ29Y8usNDcPIjlzjPVO87yxYza3R0zBF1N2w8AuggyDnECRVtUJgXOg8pMsLNL9B8nEuVbkj8+hhSevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOjNC2VMFH/sKiBmdQAjNiih5ZU2+vwg9Ght1+ALMjk=;
 b=IWNTosYPQf3dL9l5kiBv+UBxismYJEb5rUmeD0K0P0PsGR+qAbsuD465X4DNTyTI5OIUszMYzKbflCFSCeIEr2ArXm2BlDYknqhu1YvBIIg/dV4TbroDrZWnkBoNGZ+20s7uR7NdiTmf/8vNJdamw3a17mKLwp8y9qBnQejWHhc+KcvOjDaPBI3Tsdk9fJ6EuoQvKxEgjo5UcArgHkxfcjAPMUUYkQY4rb6zNcP487UyAdJhCu8JqX1M47nJ/HNaRF2NYJBo3TuQNGPnBnrS7V5dEAkEO8D0a2xacftCTgoOFEKrJOfFN/MLCwYFITUabo4h0rQhktpakz9IevBTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOjNC2VMFH/sKiBmdQAjNiih5ZU2+vwg9Ght1+ALMjk=;
 b=tdlyhMl/yvTxFErEY8WDAqX4nWbj2JqR/+aQm1M/foRXaMgnHI6fRum2+EYRMFyFqfMlu2y8bk61WQNfo2szbyvbzHfP3/vv8TR32/pIb5nqr2JBohvZAaWwqFWCzki40f+PYTsAqWoWdF8oQGor1o+hq/E/3+61fZyGGoMOIEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 19:03:55 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24%5]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 19:03:55 +0000
Message-ID: <718cd090-1a0b-d485-c595-f14ea1d41d9d@amd.com>
Date:   Tue, 7 Feb 2023 13:03:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] rust: sync: impl {Debug,Display} for {Unique,}Arc
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Sergio_Gonz=c3=a1lez_Collado?= <sergio.collado@gmail.com>,
        Finn Behrens <fin@nyantec.com>
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
 <20230207185216.1314638-2-boqun.feng@gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230207185216.1314638-2-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:610:58::27) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 347054fc-a8fc-4e97-14a3-08db093e0f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxR1epuz/KDZCrSWujPMGl/5uo9QIMwu0QfzCzR0O866RF+GmUGkY5unNxlss96TdrsuIg3scNjY/syK1R63bEKDuQNIzT2AchrSd2D6BadKggMwAAfOuxVB77dGUY3KsY9TQqkZliv1TH+ATwMagQWGR0sXmBl6odP8KMJkxYxUhZ1QKGvF/SXn4vgo4J01uqbeS8aGe2CYMHQdcEdbEVgsZ67w/S6GcKhs5pHLDl6lV8PEi9Wj3VQjOgINOkX+oi5b2tjWfk0rYJxPbJHVDi3qcUiN7boh9j4AtffRgy9hXSsKMh3GHxSYf3U71X3J7BF4Ai2/oSJ9LDtOOZS0urbKuT9j/b/JeWpcau+R+hqnbhp1+CZdgix7IhWwby2hG/ep8k7eRizXnd3XwkwNPNrOw+VdGra05bHjWBHQujHwtQPJx0BKeSjirPM3CXyxCxxy10+wnq+pPvwhAN29nyGZ01nseqZ2FCNPhBWPbPGUzwV895KqcD7BmjPsmlj2pxr+SdU8rWWQh8IIylPHbSPae1dqscnUeYgq8o+7LIw8sSj4F8PMwZWJiDcv/wUUCL5gp2vZAkfXyc08kEbC7oL8ORpZ6kz/n6fC8qHFPa/7kMSz4WaRAKcdlbn/RWO4SujiY1KACg6zRRsfqLcBbJTyW2Hvecsqqem35AqQgc+AZPYmbJwMlPdxfJeWutL6qxstm5ZSAjZvzWX6UIcCi9SKg6xBqVesBtTNwNZEBhLKCgzTKbRBGkaJV0OTUbODOHgVEQN2BdQ6vhTcHumNZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(31686004)(54906003)(66556008)(4326008)(7416002)(5660300002)(316002)(66476007)(8936002)(41300700001)(66946007)(8676002)(86362001)(31696002)(36756003)(38100700002)(186003)(6512007)(53546011)(6666004)(6506007)(26005)(44832011)(6486002)(2906002)(478600001)(2616005)(222643001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkNJQmhaZU1GdWJZWS9hL2h2TmlnS1ovajdzMGhQMlpYMzQwZEdVdmFVOVpX?=
 =?utf-8?B?WXVxekZTdHYzcmgrSld5c1A2K24zMnA5a0EzeXp0Ris1aDZ4UWl0dEVmVGJn?=
 =?utf-8?B?aGwwQ2xkTThqWUVHczQ0TWhjbWpJMC8xdklIdGQvYXRlay9XVm83a0lQRDM3?=
 =?utf-8?B?NWRoMjM4M2pHOTVkWWFML2Z0dGJldHlCUmlRRU4rNEhtd3paeU9sL0NVaFo4?=
 =?utf-8?B?Zi9lTGFKVGZtdUFQS2dIMjl2bnNOZXNiTGdlSkxjcnZCVkVORkZvMmJjS0lz?=
 =?utf-8?B?RWsvUE1KaUNsZzQvOWxFY3hFRGdwV3p0VzV3L0RNY0RkZmx2Z0R2d1U0Smg0?=
 =?utf-8?B?aVNPUU9mM2pQcm1Ya0xob0R4YkVJTHFFamw4UCsreUkxajNDL0dZSm5ESVNu?=
 =?utf-8?B?TG1Vd3AzRG1lSTBYb2o5TUFQOUg5aURxMVcydkpxaFFnZnBIdzg1amY0dDNO?=
 =?utf-8?B?eEtMNytkbGxTVDFET3lWelNEWUtkbkV1US9TYlR3TE8rMVI0c2pqUGpNQ0s0?=
 =?utf-8?B?OVI1MVQybmZ5ZmlpanowQ2pVTjFsZ3ZPVHJQZGpNd0RtY3NLaVdyc29aUjl3?=
 =?utf-8?B?NG96WkZHQVNlcWZTd3NTVzNxN2o0T0Q1ajl0UzJaZFlnZlhZc1BNc0k2YlAz?=
 =?utf-8?B?Qlg0UFU2UmdtRngrakxPNE5rSVErcEJrSllTNEFPTjBubFNuQWFSU3hNVzdT?=
 =?utf-8?B?dm1QSmR6K2xVSzBCQnBYRE9XbzB4L1hhaEtWQjhWSFk0WmxCUlRCRXhHbWh4?=
 =?utf-8?B?YTMxSEtBN1RIVjE5bzdrV0NJUVpManhFQTVTSkh5RTZyRHVnUExuN01FS1FB?=
 =?utf-8?B?eXpiNWo3d1Uxa0M0bnVhb1dRRVRiYm5mKzFhcEpKeGpMQmNXaE11cEUzYnRV?=
 =?utf-8?B?NU9IdWk5N3BJTCsvZXJsc2VqbElnWXhqTjh3TDduM0NvSEV4aDhuSlRwNGo2?=
 =?utf-8?B?MjRxa0M1VW1uVGVNY1JXWEdTcnNnUmZKc05STDFqcEIvazQ5TTE2MzBUTGxV?=
 =?utf-8?B?VktuckliWUdCK2dsVFQ4aDgxTmYzWFpQbVVYbU5qVWJBK3lLZE4yU2MydkpZ?=
 =?utf-8?B?Z3RzS0FnTG1yNkdyeTUxMzhtNCtFUjlTcVR0eG51NEVjVXlUVnA2TnhBenNQ?=
 =?utf-8?B?NXVTYTIraDFrNEU0TlJiTEl3S2FndHZiSjd6L2tNRG9zZFVPd292REtLWTF1?=
 =?utf-8?B?WFM2OE9NVE1UbkNJUW1hUk5IWUhMOHp2MEc3RStwNlZBbVQ3VkRyeWJVMy9D?=
 =?utf-8?B?RmR4cy8vc3ZiOWVKM0J0M1IxcmR2Y1VQbVI1RG5VY1dhVTM2LzBqWWJEVysz?=
 =?utf-8?B?M3BvN0NvMnYxcHdjZlVrRjN6M0wzWm5qbzZtQVNHbVBPOFl1dUl1bW8rbzMx?=
 =?utf-8?B?RnJKQ2FEank2ZG15c29Nd0JTbDE1M1RBL3dvY2JtTjFlM1Z1aWJ2RjJqVDdJ?=
 =?utf-8?B?eWVmeExILzJraDJObWRTcUlUbFBEK2dqOVVvNnBwZURmR01GS0c3amh3aWpP?=
 =?utf-8?B?dmxyd2tuSnhVOTZMZUtJY2RCalBYK3prQlFjQ2tBaGY4NTJSWTlyTG1FU25v?=
 =?utf-8?B?eXJkWXpuYzdGQWZTeDJwZlZKK0RoV2RBTU85KzZnOUw2ZklzQ0p0R2lGYUxa?=
 =?utf-8?B?ekYxSTVMNTRtL2VwTDE2WmVFUEtVYlIyazBtYkFpcGc2eEZHbjAvRWRiUGlV?=
 =?utf-8?B?WDVscXg1RDB0MGFsZ1FYcTRSVFFJUklCeVM0STh4ZTA0ZE9LRjFPYjR3TkJB?=
 =?utf-8?B?NWhSaTBwblEwRXNQcjRKSThyQVlFUUhMS2tkUU5KSnNqYldaR0dUdW1vV2o3?=
 =?utf-8?B?djJKOUJodUViMnhlcUpVTXI0b0pLRTZTYnZyVG5Na3lPdU1aeWljS2RtSStR?=
 =?utf-8?B?MGpRY0pCZC9wNDY4YUFNdVRkSS9zS0ZYNmdCMTczNi9Lay84RHR4amNwa3hK?=
 =?utf-8?B?Tm1tMjVpQjRYRzBzWTlUZnRFOCtsWVRhVDJMcGtiTUh6Yi9PRzJZK3JFR1py?=
 =?utf-8?B?WGJRQXBlSDMrL1ZhY09aWlNBbW5Sbmtla1VRY0h1Z2dhcVoyTlJxcGVoTlNs?=
 =?utf-8?B?c3dLRUVGR3RVbFI0SUU4SDJ2emFvNWZpaHNBcG1lODhUOHp3c01JWVRVWE1B?=
 =?utf-8?Q?5+488pRJhfD1k+dGKLptbeKpf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347054fc-a8fc-4e97-14a3-08db093e0f78
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 19:03:55.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oVlevjuuZNoWym4OHXio7qnmdz37b2Hfpfu3d75NmlPkSv6yWTbmm9dpcQSeqiFn2sVAiwVnr6QrVbh/GYXJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 12:52, Boqun Feng wrote:

> This allows printing the inner data of `Arc` and its friends if the
> inner data implements `Display` or `Debug`. It's useful for logging and
> debugging purpose.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>


s/Reviwed/Reviewed


> ---
>   rust/kernel/sync/arc.rs | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 519a6ec43644..e6176d9b5b29 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -22,6 +22,7 @@ use crate::{
>   };
>   use alloc::boxed::Box;
>   use core::{
> +    fmt,
>       marker::{PhantomData, Unsize},
>       mem::{ManuallyDrop, MaybeUninit},
>       ops::{Deref, DerefMut},
> @@ -522,3 +523,27 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
>           unsafe { &mut self.inner.ptr.as_mut().data }
>       }
>   }
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Debug + ?Sized> fmt::Debug for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Debug + ?Sized> fmt::Debug for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(self.deref(), f)
> +    }
> +}


Just a thought, perhaps it's worth creating a macro to implement this
trait, since all do the same with fmt and others might join later on.


Thanks,
Carlos
