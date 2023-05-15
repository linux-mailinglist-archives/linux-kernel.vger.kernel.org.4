Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610BA70364B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbjEORIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243684AbjEORIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:08:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B28A71
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4MmLYHnUyyYD+DZwi5yDKczJiksf/NA8+L7chHCwhfdp53Mid4WkSxb/qixnyx8AxEPPNyGG7j/wkQS3cKthu6X5kd+KlnydE02dhNoadtLEWF2IfJXpcGotGkC+CXpLnQTHlr8/20w2GklVALFjSGO2ak4bcDRJDFpfgLRDFqRApVAAOOQQ3/bJGCCNJLtDPA2mga2zpzDOQ8k4yhra9/vBHo86vqPEvNYyo1igyBe/tbZ/PFeKzrBUP6xewlAoHiVeQiZtgXBaSKGTLn7fAy+ZdpkUjXkuBXwpRBQAGorT+Pg9pHwDS2PzQUprF5o7f1lfkDeCrOorQgy6J7V6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC/AHtCt60zgdtdM5uY4ic1D4lo+5hrW8zcmySpsvDA=;
 b=S64fl+N5FW84aF0Pn0ecLX78AlzYkBWyCrDI1u83NM5h0FJatYjznRjGfZ6+Ze+UaFX9/JMhjJlPugbLmtr9OgHfp7lvXwwAdIrnriHB40wxulVOHj0Ck7aPiRGda2DoLA1WenC8J/LvpNOQeHerysRykrOwLO/bIkk7iIhlFab3TdR5dHZPLGuTeay5LUI+llQkvBvUeCTYdCGOVOmOiYTq4qlrGlnQIlKjnsjU/QCJ79YRDgDC6znsL1NkDzRiQ3CV/EdUGLmSuOAbbvVzb2FkCJRRCukQGROEebWv1CaZQ1/pdZoZ63vQiFrHEF5DPssvVjCmETzn6b93sBo3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC/AHtCt60zgdtdM5uY4ic1D4lo+5hrW8zcmySpsvDA=;
 b=hhBAiYGt4QUX/G+r/G6pEvMyGLtm/4FuzU810iSXwlEvhjMEUUZeLNDraRmUoPBy1iMa7NJ5tP0KF2odH1lx291cF2kHUbO0muPeRGw868EpTRXFjDAcIkPQitBYJbbHJCh4amNsiwP0g4Vq0YL/sNhor7+EBJq+f1OmnZf2Wal4Zny1eGLBjRJ6orkNGV/UsjborTBbvKTaxiAUO3CCSulFLFdwa+ziNs0XhmZFiJAk5X9bU7vwFgj/fI/jW6ikAa3eex78tXvqga34uOtvXWJQylI4EmSZgaeyjoHWRcfQiidnrit8CR3haP+sNb/sHePIrtntehrmUBFWoY+FoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 17:00:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:00:54 +0000
Date:   Mon, 15 May 2023 14:00:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/gup: Fixes FOLL_UNLOCKABLE against FOLL_NOWAIT
Message-ID: <ZGJlRQ0S7xC/t1um@nvidia.com>
References: <20230512003102.3149737-1-peterx@redhat.com>
 <ZF5yHLMDCLq4IBqC@nvidia.com>
 <ZGJUQWFBMBfbKHaz@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGJUQWFBMBfbKHaz@x1n>
X-ClientProxiedBy: BL0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:91::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdc9b71-3b7f-40e0-9d97-08db5565f23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmPQgfcAM3RW9mG8rwP6hYeEddXlYpLgs3B9WGyF2y9/BbY0tacOJLxTvkr/TtZpyPzX2hScQNy0C6OeETPJV81unONMG/ssqdFo7LYwwGd9iH5r9dutxBMmuhonamIeOgo66d6cnBgO8dH+t4F06/hdIwMNMwTUeb4SIBvnfmF+3+g2MY72Cxt3v5vSYZadfWTOU3yDT679lJANiXDmyydrUYGVdb37Q7QzTD82pt8XESVE2F7IrHGt8D8z4HxF7NCzqgcl9ZWj2Lvgg9KHP4O7yvGATIFFZcGoXsI6wlaRzaTs7YiColuxYcNtD9wr4rjfXwEbGIuTGWBOrQ4M2SMmWidGflYR0RZt2fiLmadfrsubGntAygqb5z/i9SYVJJWqyDTooski8z8ScFrCDJd88Zt0alMl+VQEVuusF9jJGybqRJcNmANK3Uzonv/0pwwtul48g+hKbD/c6VTTdyq+384/pwKyZOhYgmBkUo7A4XxLcUUdO9oeTqC9me5jR075zGWssm2gKaqON6u2UvwdcKSS2vAd08rVMN6RSdvCqhc31rFElg9PJjV2Tesh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(4326008)(2616005)(2906002)(83380400001)(6486002)(66476007)(66946007)(66556008)(478600001)(54906003)(8936002)(8676002)(26005)(186003)(6512007)(6506007)(5660300002)(41300700001)(6916009)(316002)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t7JrEfautmLgWxSFdSJhIN9GA9cAu8b3FcSBD0Dvhoun/m9G7gYqY2Qeesaz?=
 =?us-ascii?Q?JCQeXPuTfqNK9o8jEligXmk/tpRAyzpm9wllwEscEsEAAw8pQ3Cu9m/J4PW3?=
 =?us-ascii?Q?OznHbQEI+i057wKA1EtRKbxfK4DBDg1Ny5S3gpGS9+zQlDEGhUsthFT89/UN?=
 =?us-ascii?Q?udaFVxHofwA6pHE5sSpRoFh1I8NmrtyfYhdUSvxUKMaKxQjKAcGtvAOk5iLx?=
 =?us-ascii?Q?mlKIohlFBcPlYuH2KKGw1cQLNoIx546KG6t6DGz8ldX1Ad7deR849T1XXFu/?=
 =?us-ascii?Q?unExz+PVtUj86MgTJ3YAlz8iS9n5HCG7MvymGpTafJOF7JQa8FVNT/ZOxxDz?=
 =?us-ascii?Q?af6aVAZI0DakX5uvSUP+xLEVadT9fiSsWgKtKCHPdV9xZGrBl6KaTptr9mxO?=
 =?us-ascii?Q?+m1qMB795BhgC6sHC419iVeR+RLde+mtAbYklgJes4Itznlw2p+vurBFFMvB?=
 =?us-ascii?Q?B5veebsdMCLtJ7AmcfwepgmSdjBK0U5MrH16lB2lHD9Aswq2gtb8aRPviad1?=
 =?us-ascii?Q?+yD4WFWClMeINmQG75Vsn0CUNBIesbU+LQ0PGbJbPcLv/k0s/0qvKHJuN8Aw?=
 =?us-ascii?Q?0eR9BguBxHrtL9IAcaycF2nyn+P2b8zXqFEdTWKmyikOv+C5G2We2TMDmshY?=
 =?us-ascii?Q?X8CYbN8boNNWV5TDEuDr+CY0wPpzQK3im2R0VuoDXlno4BuKlCkBpERxMyA2?=
 =?us-ascii?Q?U+Xtw4tKWWfgNnFoxO8TM2N09tmBLxRSDdLrNGIXlextJFw4gxv3a7f7PCsz?=
 =?us-ascii?Q?Sidnh/BvU2fvfjzznsJrbP1YfAXl4O0kjrnl0OBlWHh3p+aGT5BWBYNzo+y7?=
 =?us-ascii?Q?d6Gy+vpHsmq4qK8vb3FlSgySRYke1WoWYy8qRbFRtfM9iNN2mk6WXAp3RI1y?=
 =?us-ascii?Q?m8i6OYm6u3zJgnonXSldkDVcfD/SXnVAAmtUbsri+wNjSvsQKLvCyTE0nfPe?=
 =?us-ascii?Q?RaqqC5173LevzVkET8QoTecLNyRDw/5xTDs33YksUjXiMMXfegaeC0M+UidT?=
 =?us-ascii?Q?lfqafhPWkFCkmZUmPrM1wJahpzmdpMY/IPzLo9rh1Pu+ADOc9gj+cutkU/f8?=
 =?us-ascii?Q?E31HtMdSQshsjKpfZlN8xszuzh2k3tpDjgLuPMG4k9v1hO7qcF8NethisSf1?=
 =?us-ascii?Q?xsHXbSuNfr18xIQjuvVYhB987hd/9DtMyri4CptpmDGJQT18d/B4yWrJKImW?=
 =?us-ascii?Q?xnU6TVozUYGViv1Su4TzbNnCtePazBW2x5sj8ollmS64rt71reB7pQ6EYgrq?=
 =?us-ascii?Q?pU0udchqK83IwxsqqL6R9IDInWWVgv+EBlfTPrrdMznjalARTw+QPn9ZTfGI?=
 =?us-ascii?Q?/S5mLanGQFf2ZeykOhgomP09lL7r4WTgwKAWV2ovnmy3p9EFjjL+oakMldEz?=
 =?us-ascii?Q?Bgk39nTP1sODpSGgLgpB3Mo13VkGG6z6aFYAK3KhtO3mSf4vUFnwiniKvRzp?=
 =?us-ascii?Q?Ib0IgFx+7HWAkXSxuJNrJzI2HFRStCNJ+7vu8avCsZEqW9pENcroYrDYuFFl?=
 =?us-ascii?Q?g9qkrKUZ5FT9XbTNws2p6rOcvftYlWXcoyWxi5o6wOY0z7RUXVd54uyPvqkz?=
 =?us-ascii?Q?NXPEgUfZt/ILa+7xZWvSD+gxCg9fsA3I7G6zNcho?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdc9b71-3b7f-40e0-9d97-08db5565f23c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:00:54.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nu2oJybGFD3xOA2gM8qw7nMQvBu5eOP3YAnmT6yuI0DJIjEUcZ6ms4mw9m8Pqwa9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 11:48:17AM -0400, Peter Xu wrote:

> The problem is FOLL_NOWAIT implies FAULT_FLAG_RETRY_NOWAIT internally.
> 
> Then we'll have FAULT_FLAG_RETRY_NOWAIT+FAULT_FLAG_KILLABLE which makes it
> very confusing, because RETRY_NOWAIT means we never release mmap lock or
> retry, then KILL means "if we wait, allow us to be killed".

I don't know if it is so confusing, the flags still make sense when
composed together even if one is a NOP.

> Considering FOLL_UNLOCKABLE is an internal flag while FOLL_NOWAIT a public
> (even if only with a single caller...), I'd still think it makes more sense
> and cleaner to just remove FOLL_UNLOCKABLE if FOLL_NOWAIT, no?

I don't really like it..

The FOLL_ flags are supposed to be statements about what the caller is
expecting. In this context the caller is clearly perfectly happy with
unlocking the mmap sem during operation. It should set the flag.

That the underlying code can't possibly do that when FOLL_NOWAIT is
set too doesn't really matter to the caller.

If there is something that needs tidying I'd say it is adjusting the
FAULT_FLAG logic to not make the combination, but I don't think it is
actually that confusing. "don't sleep" & "allow kill if you do sleep"
are still logically combinable operations.

Jason
