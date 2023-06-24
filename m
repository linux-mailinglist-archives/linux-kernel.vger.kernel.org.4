Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535EA73CBBC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjFXPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjFXPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:53:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4301AA;
        Sat, 24 Jun 2023 08:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alUj0XrDnBZQDGvlYLwwgzbrieyM/vXDrBs2PyCNJsz8Xy6wuVumP6NburGnwOYhY/KKoy9mQLl5SApuBvrwHxyKFQTMmgxKZKZa7OKtBOCZ5oh1MB9Lmcga3nR9nY0crNP1BmOTWvvYbEaqinksntnt5aAO2U4ZzbxrRpAf0a6CwMo76fyEQ4u07/F3quK2uAnaL+V3murXmYxr41LlOo9+qDRU0HTAOMtgA869l98J/YejQ6QC9a2blXCeinspE8xt3OMVsxQZb34UQxBCVp+UqmH3kPFBaT45Lf8+9fKfh59jf+QBveGJVgUUeJrREmdX/uUc67A/tHPu0Jai5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuR3YoRbNj3c4R8qpi14Q3spTej+xL93JeaFaa/3po8=;
 b=eJ+ZbHZjXNKPQoooo7ossfmSrvxKSVjMcxQ7frdkpTtDdIrrwN5JVN0BDaBQ9VHmrVPZO3R9XAFlxnNAGCe8x9LwxJeY8obJxjZuvE1qvZqZd2URcRf3LyUCmOgeYg80VS1uHl4b6nNqy7RsTey6Rm5ah8Gb4aTDhbOFe6vFisY4tpLyg0XeChAJgKANO3/UHIXdcCvhZH5Gcb3aIxiF5OZkf7WGYrOe1aVuE0kgLKwuFd25zkfwXiI0oDbD8TtD02DQJgMvgToUi5gq6LKa0r0djV9pjM6+yx2+jzpBqcc2c0GP+iMpD3LKES+e4J/bG5P5Fkh9lFoHUYHcLAkU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuR3YoRbNj3c4R8qpi14Q3spTej+xL93JeaFaa/3po8=;
 b=qzJ98kCjSykeqAD8TGUoWFKlzUfLrgCEbdRek4JNrAfzVLkuELXwUjp3d9/MEBMawAmvk42P+0jglPZdtfE3nD4o8CDREQQb29nCaCcaQgNPRCJSb6u0qyuxbYxYLIaMpVdCwhullF037lifMt7n4HgCOJ7xJcQhs7q+640+G6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4895.namprd13.prod.outlook.com (2603:10b6:806:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 15:53:42 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sat, 24 Jun 2023
 15:53:42 +0000
Date:   Sat, 24 Jun 2023 17:53:36 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Tony Lindgren <tony@atomide.com>, netdev@vger.kernel.org,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: cpsw: fix obtaining mac address for am3517
Message-ID: <ZJcRgHo5skMBLWge@corigine.com>
References: <1477668756-2651-1-git-send-email-jhofstee@victronenergy.com>
 <20161028155213.2t3nwwe3lqaynaer@atomide.com>
 <d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com>
 <20161028181914.mskebckucukzhxhz@atomide.com>
 <yw1x7cru445g.fsf@mansr.com>
 <ZJX9FBBvOTv10IO4@corigine.com>
 <de546232-0638-318a-535f-169184933a20@victronenergy.com>
 <675a346b-faed-4e86-87e7-b332da540055@lunn.ch>
 <ZJcD4sqqzZCq7Fww@corigine.com>
 <yw1xttuw3nv4.fsf@mansr.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xttuw3nv4.fsf@mansr.com>
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 134a4737-afb5-43bc-1f7c-08db74cb2f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oimd3uinZT6D1JGD7zcnVaTBmfMjAumVRjvxDNODLF2ZxwGbgCnSWn4H5Qd9ooxwxyDmmuCBHQqzZlfFaAjAJnPnd+t0L8YeNN2A1tOIc6vpyeqUJQ5QhCKNcL/oEvbIxADy18ss82rJQMEXeEQIDZKnOEpfZXbXRFjuOWjomNwCPFSo2zym4eCO5iQ6EpTYYr8BAvucmpt3osoRNva6IZVEfgIkcmSOFKi5sglonUZOYl/UG0FUEeGT7pd9GgIZq7Jjz17Epcuot/q5g8GZpJp5amlMZ5sygMJnsdAOxGuH0oMCi042yE5yTfXHlFnw8WZK292kVv66aFqJv9sPCpjldZqCioRVHmaIZkwdmhka3TB2pUn+6w0qe/VwNDBNpNaY6+Ep4G0CA1S+Wwxeot9dUC6+uyJXCM7i6he1BizSG3XKwEiuRlrAA3AG4ktHCKeWQqsxR0v3x1juK+GHqFgaDyIMZ+rBLLzgYgb2lp7lZ6bs1qXSjcvQAakevZlULBDQZfFEo5gc2YMDgLsMiG40oUncC4n3tbGK6pt8336mQwbv0+ab72tdLioRrPKpYNlY2lPc8/Ye2/C91zSobUWm9/hQ/13U7U1lTiUaYmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39830400003)(136003)(451199021)(36756003)(5660300002)(44832011)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(6486002)(66574015)(6512007)(6506007)(2906002)(186003)(478600001)(54906003)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZ0Z3JJWVU5Q2ZPb1R3T05IMHh0MWpocUF6MzF1Y0oyZFkxK3NPa1JQaUNz?=
 =?utf-8?B?OGwrNTdpODhtWGFOb1E0OEtQUnZFNUlOQWxtelhsSkgxWHF5NTVqUUMwY3RR?=
 =?utf-8?B?SWpCN1k2V1g2bFg4eE9KcTFlRXlQd3BPdTFMNk9taTRXZlBidCtwT3FKdkVE?=
 =?utf-8?B?bVJLQVZLcHV4MkJkd1EzZ3oxMkhwWnFWeVdEQ2p6VUNLUUdNOTNQcXBhSEdO?=
 =?utf-8?B?aG5TY2hKWW9McEhza0FqWVkwNzVGcHdLT3ZHV3JwMlh5MkN5WnMxQVk1WEY3?=
 =?utf-8?B?b0ZHaXp3NEZqYnk5S2dzRVhINlBubkZxYUFINHZkelBSSCtJUjQvczhBUnI5?=
 =?utf-8?B?dDI5UmNKQjFON0VqblRibXdsRVE0UFRqa0pORTZhODZ1NCtoOTFpcVlNQ1F2?=
 =?utf-8?B?blpxVktNeUtNOTBieTVvLy95bmFpZDd4dStNbTF5UVI3elM2alB2dWY0NkN0?=
 =?utf-8?B?akV0dmtEUy9KeFVtTnVDU1NyRTFLYUhhMjhIVEI1K1RjRnk2bkVMSnZJWFdj?=
 =?utf-8?B?TTBOd2orYnV2YzBpUElZR2hPMVV5cldoeXRHbm1BTWZWRHV3YWpoamgxeGhQ?=
 =?utf-8?B?eDRGa0ZUcjlseDJuL2hUeEZ6djdMT0NJT1dqQjdxTWJyY1NzcXJGRVdpdzRP?=
 =?utf-8?B?Z1I3WXNvb0Z0cjE1Q2FnbnBtLzNVQS9EUjM3R0pmbE9RRDBjYWxxS0RkZlB0?=
 =?utf-8?B?RWQrOGFBdW9weW44Y3h2aXNWYWt4dmRDYkh3R1Q2WTZ4QWtLZzZiM3AxM0V3?=
 =?utf-8?B?ZnJ2b1pBcnlRa1UxN0FNSlA0TlYxck9xL3JrY0I2N1Q2THhBaU1wUk85RGl6?=
 =?utf-8?B?UjFEZDRCMmFvdUtDMU8vSktVWHZCZFJxZ1pvY2lvMjAwNVMvaEl0Y1RCbFlz?=
 =?utf-8?B?S0pqL2l0UzNWTTBzVloycHN3dE05dE10NjNyRW5NSk11N3JBK0hwem1PTFRa?=
 =?utf-8?B?L1Qyb2ZuTWcwZnN3NU8rMDRVN1lrTWc4Z0Q0TVBvMjRZYUQybmp5WlVpS3Br?=
 =?utf-8?B?VXRvSGdDVG1uT0tBZS8ySlNnSDMzRi95TDZyVFQzNHZ5TElKQ3QxK0ptanFN?=
 =?utf-8?B?RGQyWE1SMnNjaFJYOFhibTVyL0toL3N5U0hmTE1Xc3ZLUCtsdVJETkQrYUtl?=
 =?utf-8?B?Ui9KSGx2QmZmQ2xTZlp0Y3F1OHp1cFN5OVBlYlU4cGw2Z3NGZ3NBWEwxWFJT?=
 =?utf-8?B?L2pqNGhpM2xyMFl0OEdwRklJOVJIN25MY2lQTGltUDlDUXFiUXAzOUs3Mkcv?=
 =?utf-8?B?V2JSNjFPcGpkYmdsY3NvZWhibnN3NVA4REZ5ZHVvcmNIR2VjVlc2eS9LQzl5?=
 =?utf-8?B?SHp6d2Y3RTZQOXlIWG5LdVVraVEwcTc1TWN4Z0NJMTVndVZOVTlKUE5aOUhE?=
 =?utf-8?B?djFqa1dvVW1PU0p0UHU4VEY5cWloaTJVbjdOeUlUYmliWGFiWXNvd3FKMVB3?=
 =?utf-8?B?ak9idzJPUHNDbUhzNlphOFI3WU5jNFpSOUxMWnE2akV4VDYyVFc1bnVDZ1B0?=
 =?utf-8?B?UUtWSk82cVFUWnJ1Q3lKVjg5RjFIQ3lKUTJ5UXBRMlN5cDlGNDFSRGxFOFh4?=
 =?utf-8?B?VmxrbmhGY3F2U3A3bitBZ3hwR0RMNHIrSzZCZnNORzRnL3BPdWZ6dW5LUjAy?=
 =?utf-8?B?bDhtc0czdVRZMUJwSGx2RjdGMkFkdW4vRTJROWdaazZmb1MwYmdWVU9DWXlp?=
 =?utf-8?B?MmtzNkFhZnI4aGNhSUZ2OGY4dG9xN3E3Mlg0SGVHVWdMdDBQbDVjVWRHSmZM?=
 =?utf-8?B?Vlo2Nm9EdGsxN3NkeDgrQ2V5RFZ4bERTOCtLNjR0eWl5SkM4MDZSZEZ3cGU5?=
 =?utf-8?B?WHVBQW5kTGUyWitiLzcyd0xmTm1lU25vN0pad2t0YXdNbVBaOTFUdSthLzJr?=
 =?utf-8?B?ZVhSRmNYcnRzdE83UCtEdGo0V21KQUgrcTBlbW1iUzdMdnowRHl5SEU2OTBs?=
 =?utf-8?B?VDcxZWZtOEo5cDZyTjNYQ00vQ04zU3ZSV3h5TzdWeHFCblFRcXpYSC8zajhR?=
 =?utf-8?B?OFFETCs3QzRHN3VMTEFDM0VBaDBJNy9Gd2F0QkJ2VzhUVCtXVGNvaVdMb3ln?=
 =?utf-8?B?MXh6NDRKeWVtTE1RWlJQTTFhenphdHBOUVpIUk1tRnMxWXVTUEIxVzFNd3RN?=
 =?utf-8?B?ZWRRUXo5QnJYb2pwM013SFdKenRMRUxkaWltSHpxb1EvZ1I1TE1LQThvbVpm?=
 =?utf-8?B?NVFBYkQ3SUl4R3E0Y3FGWjVPYVcyQWJVQ1p4ZFFiMmd5TW1RcXRqR0RxWnRC?=
 =?utf-8?B?NFJpMDRlZEpHbFM0bzBSSUllTnl3PT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134a4737-afb5-43bc-1f7c-08db74cb2f4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 15:53:42.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsiUvbr0GTnEGYVvZ4pBgSx02zEVOutIbJYA5AHwikUMsmFY2r0YpKvZQevI2hADnCCmNdjNCwQiARiv8F5ikngStnaXJZF5sig9qTlDusU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4895
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 04:02:07PM +0100, Måns Rullgård wrote:
> Simon Horman <simon.horman@corigine.com> writes:
> 
> > On Fri, Jun 23, 2023 at 11:41:10PM +0200, Andrew Lunn wrote:
> >> > > I feel like I am missing something here.
> >> > 
> >> > That is a weird response, you feel like something is missing
> >> 
> >> There is. The patch.
> >> 
> >> Maintainers have a slightly better memory than a goldfish, but given
> >> the high volume of patches, we don't remember threads from 2016. Also,
> >> all our infrastructure has limited memory, this patch is not in lore,
> >> and it is not in patchworks. So in terms of getting merged, it does
> >> not exist.
> >> 
> >> We do however recommend that if a patch has not been merged within 2
> >> weeks, it is rebased, any Acked-by: etc tags are added and the patch
> >> reposted.
> >
> > Thanks Andrew, that is also my position.
> >
> > A ping for a multi-year old patch is unusual (for me).
> > I was wondering if there was a back story. I guess not.
> 
> The only story here is that I was reviewing the set of patches we apply
> to our kernels, and I noticed that this one, judging by the discussion,
> should have been applied to some tree or other ages ago.
> 
> Now if it takes 6 years to get a one-line patch (a fix for a regression,
> no less) accepted, I have better things to spend my time on.

A long time to be sure. As Andrew explained, the patch is now stale.
It will need to be rebased and reposted in ordered to be considered for
upstream.
