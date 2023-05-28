Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7855713A85
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjE1QWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE1QWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:22:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF4DB9;
        Sun, 28 May 2023 09:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYms2NDHR+Yc1v4DrQaUF4DvQWDZhrvCJz11PpDh0zOSnOGnd5t9r0OR6uYbIo1ar6z4rGy+UVRO4CCqNfiUb/4hHxT0AmSrrFpCz5pQPVxUzbpjeDmcJ91kN4aBrLg8pNvuZtvBPZWYBwXUTZaynwpG9BnPHYLoCcqHB6GEhkgtLZZurT79xQyRk36LbEtv+af11V0WgpxZmvPmy+BYP/bXtEK9jQ+LRMeYUvH4QBDM7vkqgFTNjI5++m8EV6PZLBgZVv29ocFYBAHckDWvqvEcnkP+vI+vm5iwjpb7x4stG2Fk7ecGbEpaNGzQ2bpbpHd6/J56rC9K3QsUR1Tb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE3aLbFzfbyCaa4VUjajZbfNckV1Azuo35Q0Mcm/LEQ=;
 b=MlcViFxbxjW0reX6KWnpCx77ZodWQcWzmSS7divsPmIImdI1KrAUElvbuEtmzmN6hTqU0GO4e8nFiWi4MysFt9lDG+6Mn0n10tXMKb5Rr8Ztxt/N9NRQLfVk+9vMR7H0x6l3JDta9G19OFcYh4AE9YeRQkDimGj5N8X5GrAwu0J2RlcfYnseZ1Q88FYPny+faHq9sllZnb+kMlCQCxBD1RdilnSFibrVXhGNVO6yZOAGuJUqMGRtoQ+GM1TPcUczaVE/4+eu7VbagQTgqhCuL294+o8zw27MN924IXqd918SObCCd6M8e4R4BPKULkgDQtFgWPHiqJOvYZaWUksXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE3aLbFzfbyCaa4VUjajZbfNckV1Azuo35Q0Mcm/LEQ=;
 b=fIvNK/CIf7Yrl7dtCU1VxFni1ShE5XlKOVZAH5FYWhMJCLH7ym2CuCN0w5P5oDM0uhbwhKfUALqL3Z4U3ZUPnKHa8/atlDlB6NghsBilDE/JXxYVqTEBfDWZlJkZgVR2KDHIL7x1/PWFZc57tKiQK6oaK9Q/mn+kSLinNfx8SoFXifEV9T0CPHfAEPNCd6N0VeyrEDBeOAKlbtamAYxcAt3BxJujdO0k/x6Yy9xu8eKZYW6+xhZ8lLCvCSpwoV8G/b/Ma5fzicCdfBqafHDh9PjURnUK6/0q6rzBlxuPzeO97PxT34KWdyc+2JQF8jctAdUUjbJOKjLjHei2paOFmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sun, 28 May
 2023 16:22:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Sun, 28 May 2023
 16:22:21 +0000
Date:   Sun, 28 May 2023 13:22:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
Message-ID: <ZHN/u5hefVwsIdDN@nvidia.com>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
 <ZGf1hV7iEQyqAim5@ziepe.ca>
 <1ca47b8a-292c-47ab-aa6f-ca24fdfc0d3c@lucifer.local>
 <ZGiEEPXdAMnKqkqx@nvidia.com>
 <0bc9dc2b-0da6-4d5c-96af-e21aa287eecb@lucifer.local>
 <ZHHSwRzksE+KukTK@nvidia.com>
 <617c2e26-8450-4a35-9b47-c0482921f030@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617c2e26-8450-4a35-9b47-c0482921f030@lucifer.local>
X-ClientProxiedBy: MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d54f8ba-419a-489c-f6a7-08db5f97b66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGcHrRVwpASTm5kLQttkysOX2FhbQikQsA/B4SOb93KCONXMQvc5D+MRsNOy2HYsJggLTEPXbTmWUqahz/3TzALxXm+ZSNV0cWtGSnY8mEXksXJ5YLe7BeCO0lUEjuGF5raAaDRS+qZABpF/jQ9vwCSO5Y3b0qxuBnENJYrxTxRFXipuAQ7Cdnst8Qiw0leSl6vWmv2ERnYvPJ0N4srbqovDlimCN3ai5bVfnVpS+bvF6BmrG+LnQZtczCGJvFdB1M/tWzyq1G2CNO6exzgcVJQWnb5GtOdZYNCzPZ+e1sBdsPjMphctRBfCJi3Exd5e9ksE9cEdxujRtlL+w9rqptUbkshlldW5tMkdxKvuoEOh7OQEU5d7x6uqQLcZsFxFNTOyXazSX92Qklxl9c4brSGG63qzSsj3dIrOsODRyKbolBJPDr5uFjQuHPlk9G55qZ7LrHMO5CtzehU0PCoom18+2pxJvoMjBEuuZMCK3CaxQWxQK+NDiuNdZRnoxvLr0OSuA1rUmnRZ/CDeopcpvuydix8JFw7Gpj7Dq86xCjXa1H0m91odIWRqT2Gl6eIb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(6486002)(86362001)(41300700001)(6916009)(4326008)(316002)(66476007)(66556008)(36756003)(66946007)(7416002)(5660300002)(186003)(2906002)(6506007)(6512007)(26005)(2616005)(83380400001)(38100700002)(478600001)(54906003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6jEK66z4Azqz9222LSywSYczi2Vtxsu5sVhl3Xp5t7++AOI91E1XYwsHi+i?=
 =?us-ascii?Q?qkSHLaaP5nd7YMHrTZjsdEJSSMAJYIwtx7RIaMkbWcjb2AEz/VST0y6AkLUK?=
 =?us-ascii?Q?xuQ8iUCgC5yr1D6I8L8GVUJC4vKPTL5IzhG6ATXMsHeVXT4LERp6T692JJfl?=
 =?us-ascii?Q?ChX3mmvsJ0D2rcZgVvbeeiqHXolU+GE7xckbTz25K3oRl9gVjfSUjx/pMai+?=
 =?us-ascii?Q?jFZY7VZj1y5WvIpvlxb3ZxEenWXTpnZidvKG2IyJ7ZFbN+1iBqrnwPivz45x?=
 =?us-ascii?Q?g7oGbFkloaoZobrJFNaevIRhI+cEfSvWRSrxWxZa/SXkRkWbRYtQ+4B8bBjP?=
 =?us-ascii?Q?oE607tLzVrYTPLUBuCpNVr8dyUpSjQGb5tkv1VqxP4rBFypZOpQJR/KYfUXz?=
 =?us-ascii?Q?4oLc4T98CWpzrmXsmUhJ0rPYi0IGcRm6MngThOAmi3yWmD3s5X84+5cDZMuz?=
 =?us-ascii?Q?HJyNO+1nH7NIarySbrG6tZ0bo6JB++StUg2KDEojv4kRtvD1LUcMF+rnWjGt?=
 =?us-ascii?Q?MXaeviijT4jKqlpu5nDCL/ZV9O0txbyBl+ONSFL35dw4s1GFutxnlgr5GlWn?=
 =?us-ascii?Q?TVZvLuUmbgmBMf5No4ORkEshYZp7Zh+74klLgyEpl4zeCkMm2krVTG1vYUK6?=
 =?us-ascii?Q?nJGxgsC88B493gsO2CGa7q7UGgnJQQujPNw1xnSHrvGIhXfSXBiWGYqAxeHz?=
 =?us-ascii?Q?oQY5cF0TG9XaJyybC0c3+gWT+RsjAZ4uOkUfhF3KMolWjVKkV00pnwyCsQtQ?=
 =?us-ascii?Q?C+oEZ15eALadRkhjnlaX+2NNyGqivtfYG6DBRaNTllLIHxTNABZaqedSuBZB?=
 =?us-ascii?Q?4WHKuJ8o4dkBVCAwuCDN/1Yyo4JWVy5d9d8HcG9+mKslNlMod28D3LB5Rql3?=
 =?us-ascii?Q?V6RooQ/t7hZXTlKTwyoz9vvf+ef7o6Hyv0M79h2l7PwfXynBq52ZGuQz5NZi?=
 =?us-ascii?Q?XamNefvy4dJ+smJE+qKBI2sfQRzj9pj9Wvp6Bn09OMlZMgO0VlKWzkNv4OfW?=
 =?us-ascii?Q?wnqQNjXbL/3Nk63d1Q+CtmxmmXikrkH2tjuwJBgb2oz8YZZRGX3v0wGWP+ma?=
 =?us-ascii?Q?NNfwBdxMqlEN2icyrFoUHT98N5+QPoNTvd6RsjRbamjAX+ffxQ8cSwunbw12?=
 =?us-ascii?Q?bfk2/KAZqGadipvnB1P3hyC44dQGZpkOOElxntDLW8Emy2uRnU9QYeuSIHlG?=
 =?us-ascii?Q?7upK/BKTio9a6yMvoJyq22PMQ7C2M6X3DKUWIzq2etIiF6fARuCQXV7Fqrka?=
 =?us-ascii?Q?Kq9Dm/JPZkL3T8OGd4Grm5sIQ+UB6CZYSucy6w6yhp7gVZXM6wKNVfxG9e7y?=
 =?us-ascii?Q?Ssy7BjVuG434Ooiz9M7yp93iMMuydsgl9ov7K6XauqcXVHC+LfWkfTcv7Qpn?=
 =?us-ascii?Q?/VNz1P0sWQ7cxExeEjW0zLWFPaC4La8rRwKHC+pKIvG3RxXpefZqHvN43Ncy?=
 =?us-ascii?Q?/Y3ZuhGfbElHbwdS4ld/hE6drzPs2GX7Ytg1S1tmWmcvDnjXQAhP++cVMU7n?=
 =?us-ascii?Q?xLDfhrjHMHZgxUCE1MdSKBRpfSectsDZ/f8mHcjaVUKtxQoo4DfWqNNBM0c7?=
 =?us-ascii?Q?z5BQkFYBjH6xEHJPOzw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d54f8ba-419a-489c-f6a7-08db5f97b66b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 16:22:20.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4FBulXovieQH3xwbLotTcxuLq6DbuVU+jJVp74BQXsF+buXIV65bQIX8kQHbzQk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 04:13:44PM +0100, Lorenzo Stoakes wrote:
> On Sat, May 27, 2023 at 06:52:01AM -0300, Jason Gunthorpe wrote:
> > On Sat, May 20, 2023 at 10:12:40AM +0100, Lorenzo Stoakes wrote:
> > > > No, this returning 0 on failure is a foot gun. Failing to pin a single
> > > > page is always an error, the only question is what sub reason caused
> > > > the error to happen. There is no third case where it is not an error.
> > >
> > > The uprobe path thinks otherwise, but maybe the answer is that we just need
> > > to -EFAULT on missing VMA and -EPERM on invalid flags.
> >
> > I think uprobe is just broken to think there is a third outcome. Let's
> > just fix it instead of trying to pretend it makes sense.
> 
> Sure, will take a look at that if I get a chance. We can at the very least
> adjust get_user_page_vma_remote() with this fixed.
> 
> Do you feel that a partially successful pinning for other GUP callers
> should equally be treated as an error (and pages unpinned -> return error
> code)? In that instance we'd need to audit things somewhat.

That seems more deeply ingrained at least, I'm not as keen to change
it as to get rid of the 0 return result.

Jason
