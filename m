Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCC85B8BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiINPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiINPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:32:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2534455F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663169532; x=1694705532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mMwdhPAeuA2pj2iNcSy1zQDBb9ADZVvMg7J2hH5wJR0=;
  b=iKJJski81TzLnz4s2Eirc5HHLUylSyhdANxRO7Zo9tiZ/jlxt00In+by
   qVF8N/kBDF0HbbmSQBW9pvT9pkEdM0CTfyJPsv9YebSLljPyHX2Q3S9iL
   bp0trx8nKm5sH/lQ1xt/vRcTU4CTKF4aRrk0TRJFAbjKrI8epYVpDQGx0
   bDhS6jIAbLiaPCRg4SHFP25iX6GWGcQrPhIkPgpAJshopN8gk+XwmgcSU
   a6cK8j+ByUU2OMlve+nYRjhez0K5Mc9TTuMGtjf5723A71OkPAK3Nuy8h
   LJOmhfciCDazg53vkd7/ifqSHTAFt8Gje9BIfEfLIs4qWxKOvyCGzieZl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="384751457"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="384751457"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:32:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="568052406"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2022 08:32:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 08:32:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 08:32:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 08:32:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 08:32:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T04xyJTtNBkKAICUzmRkuUk2R6VXH2zQ7B6Q5ck7M9vehlbyLc6SwiDizqR3ZJVRPh4c046rN2ochuTecZl7qtStNlTPrlf+Xwwb3tAiwPHSjE6Bw/ERDqzhrO/UQbLXKy1OEKAJ9JP5gFadVN/hb/juPPNxGBBG+SnmRpQm487iUVerjrpZg1b3pdFb70PGP/EEQRXto0+styD2xU4jWvIZuygsoOR3baH7o5iKaFRHNs5es44Y9egWcFgstEKphxyO0+vfJQEBOjjDC/Yg8k/okLn/na1IsI8Z4ONoyU97YZ29dX6ROeptWEibbkkj0jb1djZ4tcglcqn1wmCvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX3qG3rBQ9X0FLp0JpcpM8lx+BunmdmcBES1YUv9ZCA=;
 b=DnoJN3iTssZGkqK2wrIveN27MEw5VNW4ZN/gzQcvrrcUmJ+nNc/6iNG1xxMayqjf5Df0p6dC7GD4K+KjlGwvPuamdC5Jdpb9QTB0o4jQhJWZcJu0+d/VPfnzyRrlwzXODCIrLMmz5bndumFYymOy7EGuqtWy+EvtXUN0kqeotCih13qpSob50fiBhcDlqUCKtYREAngXHy3ZtfxCfafPxDSb2SxhXP6he1ficmhtMf7OyVZ7giLqJ9w/0bcYYwrBXuFD0/C/V0ieddQxmq5cozY+9EAImxhnZCiTv7S8njHZioKU63iR+kqXQrHCadU2lP3Z6Jr53u8KHVz0jgOeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BL1PR11MB5367.namprd11.prod.outlook.com (2603:10b6:208:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 15:32:02 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ed7e:2f52:968e:2926]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ed7e:2f52:968e:2926%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 15:32:02 +0000
Date:   Wed, 14 Sep 2022 08:31:56 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|BL1PR11MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: 0652c804-0e3d-4724-c199-08da9666456c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pU4Va5FF42XLzZTlAzOVgvFEyitaO5InbWwEkdKYEQpnqwJYK2pp7Wv7lPD8s8KKV6xspujpko0dI2wt5p58DgJevPXD9s2mpmfpR6JF//LKKgnyKpeW+osI/8+16NIM4ADm3v+JhTtep9bt4X4Yd0pEmUxR7EWKqXNieWZr0+SE0x857fTbsMczWksyRALWDdno/lX/fQuITQspoUOrhqHsj5aBEhB8sX7DpLSyYVBtF3PStvldwyoPJHs+Nw3obC9J/6xR0QDD1etCBKyohB7zVCddLyItuIZDa+uxQOmohq1O5w4r+2aFLDpiA2pK5UkMLawkoHn+VMvdZWIeh/2Pg4fD6aUaAvSeiQOPvgqkpSZpMgVLBoYmzdq/hHlbc7m4YAiIeNKy4UJdCY5aPVZsG9EP2upwonSf1Myhr+8uahMEvAkL+UKPL3hjjxKji6EilrtbvCgCn+bqwJiGhcMka7tBOa0qcdeoZmJqR1igUvewDoeud3NxWKyZPItJNlHUwg4RL6d31mmtWNmIxdHe8vv2TxwQGI3MtF7uNCxBcqkny3jGm0GGRFIDbstFidqO6T5mO1onJ4yjk7q8qV0Cwt4AIB0b/eweVVuTh9Y6Qcyd1U4g5ydCs+UOTk2yWDtGtpBnIrT/NzYuavzi6BrCAb2n90NEgRy1qTrWA9KGqaWePfunLqgAyK23JgOZ4PIAly+GTJPWedzu61mqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(86362001)(38100700002)(82960400001)(6666004)(41300700001)(66476007)(8936002)(66946007)(4326008)(8676002)(7416002)(26005)(66556008)(5660300002)(6506007)(478600001)(6486002)(54906003)(6916009)(83380400001)(2906002)(316002)(6512007)(44832011)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u5LA2whjuYYl1eR4WwaagnFIw2bRYuVsh2qoTC5BdKPq1WVmKK5aPKXjkvee?=
 =?us-ascii?Q?hi/Zjrrh4og6KJr7V8WVhmBlbLMj7QMMVpIQUH5+o6VDWXxsX9g1ye/KAdQM?=
 =?us-ascii?Q?5dbM5btkfYBbURE46LrkydwXa1H0/8AChax945BNK90v0Dp8YXMajg6EC6b3?=
 =?us-ascii?Q?wT8yuOHln0J8AYRPcWPYZoGT5O3R4l5+Jvi4JU9kohMt1XO6L5GkImQJOJLX?=
 =?us-ascii?Q?aPiPNYo2Hb7IOhlo+UeV4C7e36iWdYiawCvhJtGB6u1fGW3Fj3bPUmRMo7Xr?=
 =?us-ascii?Q?KmzdSIP02sHHaf5pYKjAAizn5KFhm09WF9su18T3o4FNprPUBr6bc1aCOMw+?=
 =?us-ascii?Q?zrQ0/XDmUTJb5XeRLjUdvHM08vSthvHG2AtmTyuXXyB2Ai1WpG+4V3BYXsW7?=
 =?us-ascii?Q?rhPesOH/2QXjTctxgXvpBQruzfO2OkGx/ZDcdhklDjJmfpeATStFxDjJ5Gwy?=
 =?us-ascii?Q?pvInY6npJoUvvhMvU/MiQNr9bui203tWKA3iVHWLJWWfDxEjhgbCCJ4bHvLo?=
 =?us-ascii?Q?XU03lBjx24h4SU5XUvUUZBRHLhWxVB3HBj88yObLN4xyjG7UQVw7PLQFgJy+?=
 =?us-ascii?Q?+3njLU/FfCVqooBbsiq8cXkkEbLQ6NRqSU+TR41NjOpd7vwrw83WdSFY3Kt+?=
 =?us-ascii?Q?WHs3MKwOYeVsU7t6QZN6ewwqM539hB+jkRa/3YHvP51eIwd0cml6ocoUPaqh?=
 =?us-ascii?Q?YHzrA5hgKDEEuyGHm9lB0s6aX7RPpVgNsiNPTBUv8zNk3XiWLP02vI+ZOlEJ?=
 =?us-ascii?Q?SsGdJ0sxYv2W2Qh/oFXK5RG6R9VldPdsNRjz0IiUF7xkym+TxVd3PUfaL1Aj?=
 =?us-ascii?Q?c7GS2CNH5Ep1R8ataIO0kr31wLAetykJEwRv5DbmBPs/k63l7WbOs528t+WJ?=
 =?us-ascii?Q?6uBDw0WLll34DBZXhR6qeNN7mrwrk4A/0RCFN97PnjGeDz5rwTf76/QFFy7Z?=
 =?us-ascii?Q?muRuqtmjzXaq0uy4fOfquoJek9DZ6+P264XAktn60T/nV+R1eTzy2bwfQHlk?=
 =?us-ascii?Q?q25lrLzK8tcKVomGp8dBTGFeu7twsPei9N/EgI/zXNRsoWzU6hovv8gkRTU2?=
 =?us-ascii?Q?GUjrR0L055pOG70GgcNMh899GW/D+vCyf7OdCy8eJnkG3ju6H7c2ZlrOlaTT?=
 =?us-ascii?Q?Of4x7zSc75ltej+m95d2xuKYn658sSZMY6rHtqecTbNk5XPKtHgWbwBvbCLV?=
 =?us-ascii?Q?hO6zc44Zf74x5xMo3HBPPrRwRco4JLCiB5Hhr4eEtCvV4pmBCEFMLTGH4OYs?=
 =?us-ascii?Q?A8lkRDLPZ0aMUX7I4G0Gxa+rWoCJpXeUWtR/sKYUOfOnvqfOgzqspuosKD2j?=
 =?us-ascii?Q?46t+d8JwXgJeAMvxSlqAnrKux6o7hQvHot8qOcg6bbKoiYOCS3zGxmmYvEjG?=
 =?us-ascii?Q?tdmAzzR2BFprI952zYFoia5J5X5w2OWtLuh/97KWcSuGSs1XyZCvFBhaIo0P?=
 =?us-ascii?Q?scEntK0Si7RwailXIXjoU4RX7jMEOeCXaMSY/EMQQo/lAXUuDxPhHyRJtVSo?=
 =?us-ascii?Q?2UN/LgMfE7yRL46jSt1LtraSG10Bj8oglhn+DmDUTk1yIH85TQM7CMc6qzsK?=
 =?us-ascii?Q?aJBL1UwWyjYlYEfIEoTWboJhukLmbTGmbab2SOwR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0652c804-0e3d-4724-c199-08da9666456c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 15:32:02.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfOH7mH2W1N15nfobyYvkQwfI5kZRbfzzVbr4rwLuBQdasAfZDr3W9z6KPF62jUccGhaUIkUAGy+rTJLiXtvMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5367
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:18:18PM +0300, Kirill A. Shutemov wrote:
> > > > > 
> > > > > The patch below implements something like this. It is PoC, build-tested only.
> > > > > 
> > > > > To be honest, I hate it. It is clearly a layering violation. It feels
> > > > > dirty. But I don't see any better way as we tie orthogonal features
> > > > > together.
> > > > > 
> > > > > Also I have no idea how to make forced PASID allocation if LAM enabled.
> > > > > What the API has to look like?
> > > > 
> > > > Jacob, Ashok, any comment on this part?
> > > > 
> > > > I expect in many cases LAM will be enabled very early (like before malloc
> > > > is functinal) in process start and it makes PASID allocation always fail.
> > > > 
> > > > Any way out?
> > > 
> > > We need closure on this to proceed. Any clue?
> > 
> > Failing PASID allocation seems like the right thing to do here. If the
> > application is explicitly allocating PASID's it can opt-out using the
> > similar mechanism you have for LAM enabling. So user takes
> > responsibility for sanitizing pointers. 
> > 
> > If some library is using an accelerator without application knowledge,
> > that would use the failure as a mechanism to use an alternate path if
> > one exists.
> > 
> > I don't know if both LAM and SVM need a separate forced opt-in (or i
> > don't have an opinion rather). Is this what you were asking? 
> > 
> > + Joerg, JasonG in case they have an opinion.
> 
> My point is that the patch provides a way to override LAM vs. PASID mutual
> exclusion, but only if PASID allocated first. If we enabled LAM before
> PASID is allcoated there's no way to forcefully allocate PASID, bypassing
> LAM check. I think there should be one, no?

Yes, we should have one for force enabling SVM too if the application
asks for forgiveness. 


