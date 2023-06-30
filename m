Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905F8744400
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjF3Vks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3Vkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:40:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A28E35BC;
        Fri, 30 Jun 2023 14:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXsRy42QRsVos5bvzvyYIsU1ngP4+msJVCUIR365xHTuvc5N633IKpCRaFeRzeUOPcdfDX3EIW3O3pmM7u3vsPTgMJiNklDtIE7PiwvZ3H13ETFOYOjUm6/ZLzWW14PqhX4CZlxLvq2HKUujj+zgrOkSMHl1OzSiGABZ/TUyC2Cz9ALj2yGwkD8Y93mQQmO61UtDysm6KvEJFm4xY1UhAkrQ76mO7GRko4DfDDRx+RkwNAykILTs1IlQIp8WxResW1vA5EJdx/S6oF+tY/4C8VfvfGJ1fJBO5bDwhsUkwTlnmnte/5flpA/k8/9r/9MLD2+n3ldFeGQDPkUxg0t+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vxPyn+iYA1JUcdUlC5oKIMG3YV6OK/O85q8Jsw8rhc=;
 b=cY7sw3VGeaOqC8rTUyqmxQ4i9ouQtsyHtZk4KGJwZEkADOvTF6Nn4nIpafNja8srn/KNVB0Vkh2pS9s67zIwO3JDWMgydBtyTrMTAHFC/loLqj1NI4VEu0k+p1QrDvVgCCaknli+Lfxx+x+/QzccfC/ul5gybK0Ec4HfEU9SRsYQ0z+HCFZ3cPk1Qxu2BAlLu3ZWtTlriOwHBsGYDnPCOAkEGt2QoaVdi7HDaqxmMr5euaIuS3tEHEgTU4ebS4XyKYU74J8ZhdSRvvnu8KRxFHpINN5XSwuWfmid6d8X/XCli11OE3dzrQhnEWv+A1HkkMt2m7JSb6Lucj4LAGLWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vxPyn+iYA1JUcdUlC5oKIMG3YV6OK/O85q8Jsw8rhc=;
 b=Ddc4qvyXRm7pJmoPFhdhxkf5AXFeoSjIciWtETR4YhtJn9IQA8lLBEg7tka4oFQts7mR2dxRaGbh9k5jxwCYjh9bwhEP/n6FwOXjWTvRZL4o/b/vMOwFe36ju/NBiSGSRMVDDv/L7Gvm1OjgEf7ALcJJUFw5lOp2GN/cp73g/Z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 21:40:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 21:40:40 +0000
Message-ID: <0bdbb7a3-b8fa-1afa-23cf-afde1cec3d25@amd.com>
Date:   Fri, 30 Jun 2023 16:40:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Content-Language: en-US
To:     Nick Hastings <nicholaschastings@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "1036530@bugs.debian.org" <1036530@bugs.debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
 <MN0PR12MB61017541F5AC55485A490BCDE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tudULtvt_Hcdg+uqXeYkSAR_NZ1oD=R_KhuE_THSRe88g@mail.gmail.com>
 <MN0PR12MB6101DE067CF85E59AF187763E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tuqAH5Zt+X9pjLFZ-RcFgxpgjpqmrAHPvm4=fb_DMBHyw@mail.gmail.com>
 <ZHkxYo/a+/uInkLG@xps>
 <MN0PR12MB610181D29933EE4787DE9BC8E24EA@MN0PR12MB6101.namprd12.prod.outlook.com>
 <ed5f982e-c12c-b3a2-1108-62fba50bf9db@leemhuis.info> <ZJoSWftrHO65wmxz@xps>
 <35e9ae66-76d0-5a17-31e6-7aa8de5bfadd@leemhuis.info> <ZJ9LPZcgkDLscww+@xps>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZJ9LPZcgkDLscww+@xps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:5:100::47) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c681f94-1bbf-4bef-9f0f-08db79b2a685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYnT5/Ok96jiovfEwXoA+i6PVZeAikPWDFuq+/i7oHF7s2FJPEvt85NUfFmi7mJCqYoCTmK/QSeXhW4Q7/r0kwy2LZHXXQKU7b6uedqBZrDnD3E64TXSP5ZpaAoYp/Hqdp4/sQU9GxvJwNhNg+OZsPqG1FB080MiSH6po5ln/yEaR/TWOI8i/rBfX9LqbnMx9ZxzEItZEVZ6TUEKsCd6m2B1YBG4BIS2AcKB2sDBgDyqdHzIAJuZ2LD7R42QXh41TrDlvYlUCPWlJZx3UedWEK3tm9wcSii+r3Ht1Uga9mvmZ9RCQ+9vLpyOANPHhTkGWy/5OtqLEO63ZQ0V6KlW3kW5q7ibYsBFNUytrFKf/6ZuNvwarcAjGhVfC5gU9oBslMvJMURyWDpiY52mpVjvuFvOIGBhLYw8Dkb7PvZKkjb5fCt9Cpx5RKqscN40oexAqkXdxtdYpbqT31KaqhgX0HpEMj88rhniU/147h7tfnABJIiN9KsGvK9RCDIR7T3Wxz01ZMAU2QLsVHMM8baZGACFVQzw/Z2yhqZOvreF/F41U7oBTBJwCN9oFGdLCqueK5mmhXIBbb6rXKBbdNxwAZKF3uBKZvdj+CINWexzl3JyAjmZFtcPWpn3aHGlud2z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(31686004)(86362001)(54906003)(8936002)(8676002)(5660300002)(110136005)(31696002)(7416002)(26005)(6506007)(6486002)(478600001)(558084003)(66946007)(66556008)(66476007)(4326008)(966005)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzlhTkdxbENlT2NWRlc2THAvcXRCNFZNd01vd0RudG9sNW9IeHpOWVNySFBt?=
 =?utf-8?B?M2s4M1M3T1ZnK005WVZDR2xzZG5SNnY3SW1DV1poOTdPSmxseWpyQi9aTXdR?=
 =?utf-8?B?VDNnazNFM1REckxaVkhSaVZBb1FSTm1JWkxTT2lPZHgvY042djNlOTVxZTFG?=
 =?utf-8?B?QktQcUJmSkJuaDVBVmVzY2pVVTBFL2g0WjgvZlhDeVpRODd1cFdYcGVTM0xl?=
 =?utf-8?B?QlRUaC9DdnJuakVlR0hUc1VGS1hYNG9aUVJMN0JMRGdEamg2S3AyaFAyOWFP?=
 =?utf-8?B?YWh5UVFtNndybjVmYm9yMUowYXRIVmR2aklNYndYeHQ3NHR6Y3IvSTZOUjZ3?=
 =?utf-8?B?bFBBUi8yWVUyTjFhRmIxRkk2VlI0ay9MSDVEOTNzcXhhcmpGZEJERUtaSFRF?=
 =?utf-8?B?V3V4ZW1Kb1lkR0s0ei81VUhpdnpBdVhRL2FGVktBVHlWeFdKLzhNVndpSTRW?=
 =?utf-8?B?Vmg5Rk42UTF3UDdSbEdmU1pNTmYwMXBIV0FwUWZ5NG5DcmI0S2E2WkoyaUky?=
 =?utf-8?B?S09Bb2hhRWRrK254Z0liSmhnejE1N0xjTjBzOFN2ekZ6Q0NpVWwzdENQNmd2?=
 =?utf-8?B?N1d4Z0d2TnR6NDE3dlFNWTI2VENCS3JSandFSnVCOEdJOU9KaGNoM1ZHUXRG?=
 =?utf-8?B?anNZUjQ3UHNwTVNNZVNVVHpBaDlZd0pQTGJhS2NSNW5vUDlmVjltTG1CTGZE?=
 =?utf-8?B?RkI2dXN5MFVDZjlIZ2plakRXUENrYjdZVisxZkRBS1NsQk5RaGg2c281ak5v?=
 =?utf-8?B?NEJpOVp3a2ZSeHhDY3Mra1hmanRXREJHMjJhdU8rN1ViQ2lNb0krMyt6NUhk?=
 =?utf-8?B?MkpuYTFPNzd3OU5RVy83bUlKTnQybTVma2F5UWdzakE4OTl4MTFwdXl6Ujd3?=
 =?utf-8?B?T21UVHJoeUlOV3J3WXhDbkc4dmlJMjd1dkN4Q2pCcjFidTJMbTQyZUN2KzFQ?=
 =?utf-8?B?emxXWlc2eDdKVmROOURFa21BSE9VUkhzWnU2bjBKNmExdDFqTFBCalRHY0sv?=
 =?utf-8?B?N1YxTjArY292cTNHaUxnMGZaMW9TQ2NDVzhzUklIUnRGTlYyZDhCZFFmWklU?=
 =?utf-8?B?MDA2ME5jRm00R3g4TGFoV3QrQlA4RnJpTklvdVFmaitDaGU1OXdRUDQ3M3JQ?=
 =?utf-8?B?eDI4cnRWNWoxb2dEUWVhYzR2SEQ1SkxzaE1tSlc0ZSsvQTY5TVdvM1RRMFc5?=
 =?utf-8?B?Q0lxOVkzTkxsY1NBcHk5SjI4VjNIeEllL2h0UWozU0hoaXV4aXMxMStlWC9K?=
 =?utf-8?B?YUh5dGZMY1hkMUxtbnd3eEYvWGRCMUg4OFMvREEyVGRVcFV2b0xGRi9nNXo4?=
 =?utf-8?B?cHdmazhadE1vRitLcERma0loV0NmOHBUNGRadnArMHdYNUZYUFJhYkZxbmlp?=
 =?utf-8?B?K3N4UDl5ZU9Ob1gwWlZzVHpRejJRN1lkMEl0U1pONEFhM2NtSU9GK05hS1RT?=
 =?utf-8?B?OGpjN1BXMGh5R0ZZUldZUkJXN05NVUhIdkpBVHExVjhtU1lyRC9lVHNDVlVN?=
 =?utf-8?B?WUlmWHRlK3NrZDZaeFJvU29vNmN0b29sWVlkS2tKZUdPUXdHc1gyWFVmTXh5?=
 =?utf-8?B?Y2FjYUREWkhRT1RLUkFpQitrSjYxbFVGa1FsemxaVXRsZk5aaGwzTThyYjVz?=
 =?utf-8?B?QUp0bDFMSFpQdmM0bWtTNENQYXBpZEtkM2MzMWpiWlRRcitOZWVTekVYVEZx?=
 =?utf-8?B?M2kwa1p0UkVSeStBdUN4TDhtNDBzUXowTzE4NjFWN0JuRlcwWGlmTHZNd0Nk?=
 =?utf-8?B?THVIR2gxMlo3amVwSzVtMnNCQXZyUkh0UDlNcm5PekJKTjkzTS9Sc3ZpbFMy?=
 =?utf-8?B?RzNSS1BEWEtrL09uNWhwako3UFNPY0tUcUNoUTM2M2lsVU1QQ2VENkQvZVBQ?=
 =?utf-8?B?ZDdqMTkydWJvV2lNclVWcC9OVUJ1UE5BRC9aTEJjQk9yR2xCVlhoWW5QaDdF?=
 =?utf-8?B?MUlDL0FSMVU5dWNOZkRhYWxvUG1FZ3Nrd1F0MWNsbVJKUE1JWVRaZWNWUXlB?=
 =?utf-8?B?QkNCY2xmZWYwS1B3bm4wYldmcVBEd1pUYW52RkJxbkIxaXpPM0hQblZ5RlZs?=
 =?utf-8?B?Z1NjcmxwbFZFa21zUHFxU3VPT1lnL0k4K0FMVmNwYnFhQTU0S3lHV1FvRHNn?=
 =?utf-8?Q?ZiOFh5wvJehJxTBjBk2Jo9WTa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c681f94-1bbf-4bef-9f0f-08db79b2a685
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 21:40:40.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLhvfVZQnpfRAOs0kuOhfR4asVYWxkykFlIWFoMp03M7XlJlR6SM1UWbFVbrs354hAAKR/bajz3K/KkxXDs6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Nevertheless: thx for your report your help through this thread.
> 
> No problem. I am willing to try to do more, but right now I don't know
> how to do what has been suggested.
> 

Here is where to report Nouveau bugs:

https://gitlab.freedesktop.org/drm/nouveau/-/issues/

