Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE36D2ECF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjDAHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDAHBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 03:01:30 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2094.outbound.protection.outlook.com [40.107.11.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E721B36A;
        Sat,  1 Apr 2023 00:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7ceWvTreLuqH6dJRaikff8HyH1RIuV7uENw5v/qIK8pFutx0G/flWIydS+KX5+m6sgtqwlQFmi0K5ZfLFSR0nBBTQevkebUmb9pJt5s0XQArLPtDJQIgXiJ2JWcpc4+wowprzPG94YX28BjZCVxReyCjrezSZuuHpOBPCzTHzYfSDx7Ze7iVXhNo5YpuQnModH/19ICXNzuStI9s5YuDNpt+QgjXr1A7faSletiLgFgGAnuf4JDJ0BYTixipe9JH2zK+e/jTEZXjBges7BOkIx2sJEJEnTC3/IPsBErw6Heaf0kjcdS4cSM0VtNkiv+M7oAcDSjAi/6ov0o+5hRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7e/kUoA3BsvVtnd4syqmK5MTwpyjcQcca3lfDGhmZs=;
 b=lc1JlOqKnnJiYDBSVoNmCKXw31UtIqz1Ylb6OTb+vrGC7qPTecIwmD6oRRaYW7hKNt8pC1Rw+m0q2cO3JNvE6ZtFMIL8H8VCPKWrBxYO59iEy6N167IRmAVGN7NptfGG9UvQOCM+hfJJffdqkjZiN+i65edpetV8NRCt7P/m5T5ZLfZJ2JWv7/IvaxMlecm23KzQNi22Z1/eNUHS1mpCpu689X570ZFedUeUqTnUhM97dWdXYDgDHn5LePh1vvK44nL/iGCX5n2L+fwGtbYQKyzb5DkZyvhRIQfUaQFPBUUdIzerS/x5+OzeermwMoM9vQ4E2pjN2g6fE9KzfO4B8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7e/kUoA3BsvVtnd4syqmK5MTwpyjcQcca3lfDGhmZs=;
 b=sYscVJRT33Sy7myrqx42rio148Fi1Ru9LuyEEITOQ8d0loAoC5dfhovzlOAdjF1HOvbzggnvrUe8MFkGUraRKhZm2LLCLCeu5VrPj+ey+W6tbKWMDN8aht4PZM06e4EPsIw8bJZ5+zlStHtxGJkdAAJ4hJKSvf5aM1gftFY7pL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2358.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.26; Sat, 1 Apr
 2023 07:01:27 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.026; Sat, 1 Apr 2023
 07:01:27 +0000
Date:   Sat, 1 Apr 2023 08:01:00 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/13] rust: introduce `Task::current`
Message-ID: <20230401080100.5fc898ef.gary@garyguo.net>
In-Reply-To: <ZCeubhgETf84thv9@wedsonaf-dev>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
        <20230330043954.562237-10-wedsonaf@gmail.com>
        <20230331034701.0657d5f2.gary@garyguo.net>
        <ZCeubhgETf84thv9@wedsonaf-dev>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2358:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d57f9a-7e0c-4289-1500-08db327ee9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZqmLkHbA9646FYr47nxSTxCAn7AHOp0/IgGhmR40VJ5Zzc5MKgLYd2svhz/sBmFsAq53w8o7/jSk0zLT34D6ogMdb8BYxXzU+VUa8ic+NkBBPjJJxwMIs8c3Wo0UthQC28vq7jk1+to4lweISe9kxwgoSz6UoQON8PHDeEY8IeXx2ef7x4Bj2Kioe1buSi97xsTh76BlDHQlwdmDBqJd4ikXhoeFtD+iAPKZjjKtqY1qY2SsyYYAzRtwZY6lsM8Yfleto+fsqIh5cPG5P2yqdOnAMUw5fXX5vSn7PnMlJkfr0tO5PtUWamtgmnnhJfuTaqfGgLTCW9DbmID8JQpQHUe0BPx++vUxgF2U56Rjeh/MrC1g/O7vFzC/8J7DTpGnBogsV1YTzUJVKU/yzIgoRSqsGy6Bz+Z7FEhPZSpryd6jbF4RvKaSK6vZWkdJzvWzxCmhqU3bZFHIQ8E01R55L2Z0etcJrMynZ7wTdJeuGrW0jo6Kl+rN0dUF77HJb9V8q4P3ncJqXCP+cGnNerKLbO67bNPUQhPB3Dmf1XyS3U4dzs/FtlxYW3tFKaUuPTyAQAY/KBdsM/imLbxN/1n+R2O1pBiStIKuPq3ZYQdjY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(376002)(366004)(346002)(136003)(451199021)(8936002)(38100700002)(478600001)(2616005)(6666004)(41300700001)(5660300002)(2906002)(7416002)(66476007)(6916009)(8676002)(66556008)(4326008)(66946007)(186003)(1076003)(6512007)(26005)(6506007)(86362001)(54906003)(316002)(36756003)(6486002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5IKffKeoW7WhJ/sZSrlcJOpgFSMaMEeokdOVI/irdlYd7DJX2D6In015yMWl?=
 =?us-ascii?Q?NimiknhaZPFTyxBDUYHU00MZvhBV0lEAbkT7ukvudeRsFU0H3X4CUfJoeJ/C?=
 =?us-ascii?Q?r/Tf3Tn1PsJghDPEhm07uRxFH/YtR7XmfiB8sgaM8uHHwziL73vYV7p3hnOK?=
 =?us-ascii?Q?xZZiYYjP+hHXl8THX4tPSx2V3SRyoESMH7y5SJHRHgqgNeySZcoMrEq7kWHP?=
 =?us-ascii?Q?3/2BZ4E6XaiurOFjM5CtRW6DHEUybmnYHQnlEyZsK0nvhp/dDAvIezYPHAtu?=
 =?us-ascii?Q?iOTzRm2Xb2MYjnud4JXilAt08n1/bZR3PTnzyMcm8/iSesyOuAPgqyAfNldR?=
 =?us-ascii?Q?R/1deEeuDxCCoNKpI9yooqc/XHnGaIZetYteIQ58yaHPvFOmfViQr32k7zqE?=
 =?us-ascii?Q?CUjs4uZBHyd4cag4aOJJHsCkZkX3gEg34JEIhwB8sjF/EBhzt13LJ7tFmxxn?=
 =?us-ascii?Q?IBAyvdkZi5moETrQzoalddiQhDlK6PMkE2fQJwo8USBEnLbhDucR9p1FlbN7?=
 =?us-ascii?Q?HZoZ4shR4V+A3dZeXKsSJYgttPjOc0AkWPXcYlwjqRmFd7D8KnEwGSy/AElq?=
 =?us-ascii?Q?EOrFSoJI7ZKZTLrdS9mURhf4CxmCZkTXIr81yDkwelXv+JC5ep0xYrY6cdxx?=
 =?us-ascii?Q?xMPw5AOS+8E33u4ge6rDBS4YFUQGNVNd5l2nCy6NJS96xAQG0CKR29fme/VU?=
 =?us-ascii?Q?Uite5b2ZWqdD8D3w4bWfGm3QdTrY3AFb86mu2zZCbbswib1ziPbC8vW1YNul?=
 =?us-ascii?Q?kVHAzGm9Wja9GcVU0xr+CFyZp6otCQJwus6YRie6G/QbFQTKPcVxVN89LIak?=
 =?us-ascii?Q?4p8e5ev1U9EXCNdIoTKbgTeFfQugAp0cQVdoSrkAIzB48xkqsWAMjM+vWhLc?=
 =?us-ascii?Q?MGdAvvTo/yShFvr6thgCLE/i+s28kV8Y/Y6ZcvAhKR3ifPofuBY6bqo+T3wI?=
 =?us-ascii?Q?HIWCmXQaJ6pvowj9G2ijcm/msemIKsebt01XexuTqHg7Tkl5xgDeUJP4Kyuz?=
 =?us-ascii?Q?KdSwXRjKzfNhs3QibWWwEyROQP6agCVOrpFP0hRj++xmXZ3pGq92squA7SyM?=
 =?us-ascii?Q?1hv9+Z9dcAdhCKrZzNecTQsHNxylQW2oWB8OXCCtNWIW323qGVPm7H+vGt5a?=
 =?us-ascii?Q?HqUTy3sNJkRX2MiupUzB8pJ8LXNG4dI9AEr4X2dDT/Kov2CS21oqWtMf6kJK?=
 =?us-ascii?Q?dl21czPCkYbyyOg1+a2aNXnFDcmruBbPivDmXhpOYkbpD9F6fZSzvBkBhD0+?=
 =?us-ascii?Q?L8YMKKf1vtLg+43LbmhfeDNpAHTjDD70Bgm6nwgHucQg2AxWqXYSijggMnk0?=
 =?us-ascii?Q?BNVeoNKheQCmmWUJzGPiWh0nfHg6OL9t3Nu9iK6TXGMOXF+ku0icnTpBYpYs?=
 =?us-ascii?Q?UVcnRDkHig7dnmWhv01YSKguli/breM1sVxkz2iY3YTMsDkSsvdl0ETst1NI?=
 =?us-ascii?Q?2z1Fp3DN9/crHefN/c8RNti2+c/xWR9Hz/n3h1Y4ujiaq8pZNFHZIRws8hkh?=
 =?us-ascii?Q?LKxGYk7cB1xwIhiuJw9kYYspUaw6aj930UdR4T7JlgR4pyTSZGclzzFsXPEz?=
 =?us-ascii?Q?Cd6zkjL4zWis+kJpj7tTI7DOqktEkAbciMQoXcdL?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d57f9a-7e0c-4289-1500-08db327ee9f4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 07:01:27.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wfjFOyPoOvR7/VgFdnf5BR+TvuhQqfIy1jcjZeO11jQaFHeeXxV/N3g/t11pYfC5RBTfZGBhgNczRy7Rl+tdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2358
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2023 01:09:18 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> Gary, thanks for reviewing!
> 
> On Fri, Mar 31, 2023 at 03:47:01AM +0100, Gary Guo wrote:
> > 
> > I don't think this API is sound, as you can do `&*Task::current()` and
> > get a `&'static Task`, which is very problematic.  
> 
> One thing that isn't clear to me is: how do you get a 'static lifetime in the
> example above?
> 
> Altough `TaskRef` does have an arbitrary lifetime param, that's not the lifetime
> that the returned `Task` reference gets. For illustration, I've explicitly added
> a lifetime 'a in the impl below:
> 
> impl Deref for TaskRef<'_> {
>     type Target = Task;
>     fn deref(&'a self) -> &'a Self::Target {
>         self.task
>     }
> }
> 
> Which means that the borrow of the `TaskRef` you use to call `deref` must
> outlive the returned `Task`.
> 
> So how do you get a `TaskRef` with a static lifetime to begin with? Or is there
> another trick to get the `&'static Task` that I can't see?
> 
> Thanks,
> -Wedson

Hi Wedson,

My apologies for the confusion. `&*Task::current()` is not
sufficient. I typed too quick without double checking.

However it is still true that `TaskRef<'static>` is unsound, and it can
be retrieved from `current()`. The missing step is `&'static
TaskRef<'static>`.

So you can write `&*Box::leak(Box::try_new(Task::current()).unwrap())`
and get `&'static Task`.

Best,
Gary
