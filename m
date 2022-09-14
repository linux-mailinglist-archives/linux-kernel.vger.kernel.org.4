Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792B55B8B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiINPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiINPMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:12:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBEA79A5C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663168320; x=1694704320;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Kwd+i9D6JWW7e5IoKid6VJpzy8t8OVv7BC1PZN1/A0s=;
  b=iDPdJ7ZE/mN06KxSkdkA1t+oCgfSC/4MvSx4e9qMGO79tv/p1u1CUAKG
   EiOX8bgWTsygQ2dGfdU2DNhJbHjiLvVynYG8M1WoA6U75TIOzEZVS+NJZ
   qL3F1676CZdjaw6jxF117d50TpS64Z1J+bt1t8zaW343TxuVQqHJNzalh
   p5wHoECcayzpqHoDpeQwN7xzRt7UAJYkrL6IJeZFIpx/OEl6cqwCspqsN
   LcW0DLn/CFH//uk6WflVgTXQH9u7DqkJsgLndHKzYgZi2YDnpihd6oA71
   iZkgpphfuggNhnifAURAQVXVFaJ1/bz1jPTpQfugXXJI7UWHg57rCrfMS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324707767"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="324707767"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="594417557"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2022 08:11:34 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 08:11:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 08:11:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 08:11:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 08:11:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdjYxNs+QP7ewykF1QHsDvktxOi770+LjG6sQBJYxiQ165ptL4uAjxidHdQvnt9IMm2ytCtI+hGMV0X5xb7aPQYdl3tpEElbTmq/n4SkBujZXEyLM+5sIqw5upv4TzL1p/oPwnsuJ0zw9hMtJyc6tUg+r0ihPvch5h7B9i9HLvEedLNsNf6Ug2CYGPEDTFKetBUwGa4or2xNc7GexQzT4seYr+WpLyMWFW2RPTyGC/DrvygiqycvflTVtLOS3aWdCuGZ720q+/AG29pYD3c7qHZSwLzJKYhLnnwMBOWboVkJynb5WTGINs/I8dDcoq7obD0HDIkWsM6uH03FcIzo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4P/O8rNFYeYzgOwP6Hw3+rQZu6fV4Evk3I9GzNPoKJE=;
 b=W35pXplKD+F6my2/G9ElD79tK4b7/lhqE/SAgkRaTz0R9ztNtPBd7DTRHQjffC3wivRD1dvCIl6D6JwB5Hn9Me1CpyRjLnqBd/fWB2xC6Gno9y4G+ce+MhZaEENOtis47Nvaz9FsBF2Z2LeS56lRyxgj/059RQYbPymph7dfHsJTTGaU0aQDdAshcmY5CQk/M2SIwO1Tm56J9jiCyft8eBsMv23Xz4CRmcn1TKCuBt/4ZafWt0rWU4x3JEd9aiNez/QOfsDEipKwmotC5ySZCOZlTs2zbj1prMyhLGvoTi0uAn2LXMNvZrqkwZFXg8uVg9HxtftwsMg/iNLSpJtxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 15:11:27 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ed7e:2f52:968e:2926]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ed7e:2f52:968e:2926%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 15:11:26 +0000
Date:   Wed, 14 Sep 2022 08:11:19 -0700
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
Message-ID: <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
X-ClientProxiedBy: SJ0PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::35) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: d561d26f-280d-4556-e47b-08da96636500
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfomnQILiDwESli8QyQftjxbs3ms0qd76Ey24tEKREf60bjyLM6nMk17HNqdzyckiYd/ep0BUCpuGphDChOpH3tgpukzS1PEXBeUQi6Df0UU/ZQcQzP5lGkvCN0iBwzviaIdI8y8PvIHMy7ElOO0+VCmQxMNJgIpJ3izuvNRNgnA8xQTwD/pO5fceKA5d0Pr6MjCDhHPL+4njsr+WMZ69FZaOUOs4hYaLWZqu5G1rZfcVpyJ02Wpg2o5t7ZTXlFCRqsSrIxlZZvoAMx7tX7P5zFTAaeRW8FxP3znbdR9WggTE6/ilb6Y+B2BbF/qFMgDl2B5YalgjmJIC3UL5euFVzkeF4JFrbyno1t1+/SyehKHRYgcXg0xdc5SZrEqeWilbt1NmCRRcNJI550IzdXr43rUAfaWtWFaDM+ebN4LYxhc+EnoJirHbViT62SG1N3hiaHTr63JsKfMOut7XGmYNQgrBMbvaVzh36C+eTqHmcDkVQOASkk97JfX1JFcHCJWcIBp/vuoqZh+AM6dg78fywUD7YeG5jHY2ngecaPIr8OwlD5DbC8iFGnP8FjTZCrfwBgy6TPabmv+SPTFxwavdOY429cBZDe6ELeujtH1Emcr1OCPtEfrb3EsD4X6+hWzQr0/vc+9f1KF9Wtqzwqq1/jA6rPv8S3HqkOw76166kFL6O8/jqrR2yvFldFcdvwYqJIFOtN0gcFItFcd7f6CFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(8676002)(54906003)(6916009)(86362001)(83380400001)(82960400001)(38100700002)(186003)(6486002)(2906002)(316002)(6506007)(5660300002)(41300700001)(478600001)(26005)(6666004)(6512007)(7416002)(66476007)(4326008)(8936002)(44832011)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TccHnQTESS2yO5XRpjUSr7x8RCTDbPIPvVWDEGtEFfgkDB//eiMKrVJadrLk?=
 =?us-ascii?Q?3XqRAss8N04KfIWJqEV6fCZgulw4xzhGi1/BvPyeRTIwolbwQptGkTL0LAQP?=
 =?us-ascii?Q?XhCRMk0L+z6QRbZ6p6xyoV1b6gTfTfVTtXU7ztES2qrk/3vSOigc1fprxjqU?=
 =?us-ascii?Q?4hKW9QNEAQ/7Z87q68tJTOSsaNPT26vw/fOr8p+9uvkGRRvAvbMAIibirWd3?=
 =?us-ascii?Q?PEaCHDx4wQxUd05MQSfymjtzkgUy2G9sanUgn4hGcBqK2gUVZFUQY7Q0FNe3?=
 =?us-ascii?Q?pioWTHbESS7zS0fWwk71B3F+nQsYD6856w0TAU9SiWFiGpPzo4bIw5/aHAmp?=
 =?us-ascii?Q?8ZCmDavalOQQW0lU4GQ+sxSCU8+RQ3uGxuiGuye65CsOWgWc9n55HVOFyVAj?=
 =?us-ascii?Q?Vo032FIvf2pkqhWLb2XVOef57CzQJhUJ0Vnw+7KXk8E4riKZAOkuPvC/jaJy?=
 =?us-ascii?Q?KODzpS3oHcnpyAbHOYUVC9eYH31klO9RKcrZH+CCzG0f29jZCaKcIpw+koBu?=
 =?us-ascii?Q?h9FKIdJZbXSBCM89NliOAsjnhpdtal/WfS4zwHOLgHaMPXtz/0yUUoY5ffbK?=
 =?us-ascii?Q?HPhL6bNMDjiv4BCFcobFxIbnX7GcVVkTlTo1MTbGcBOlRgner/FH1PidzgfS?=
 =?us-ascii?Q?VXc9vlBHvQrfg14kT43+J6GnQ1JWq3vY3aTBgu7WNBXjHAaR1PNe6O5GFyWi?=
 =?us-ascii?Q?6FJ77xbzCguhn2F2npXimGvyZ8xM7GuhYis2AUMwXd6ePlb7SPZkWakCKm/5?=
 =?us-ascii?Q?m3giGkIkRdPKhKOQbDK7YK5gXSd0uCHHeKsPeQOhF7o1RDkS0w5xiJW3SQUw?=
 =?us-ascii?Q?eT4yFTuegkuuo9DQAexhWn788wv+r04DZPkQfzOB/6rXS4ntVpSYtF3EDGoz?=
 =?us-ascii?Q?Y0lkgim4DRxeP8cnWgTkWXDQ0q9P9tjZBFiEFCmfHyAwHCXvDVI4u54G+JNb?=
 =?us-ascii?Q?ygyEr2rFo56e+v+MpKrTYfd2/kqyYWKsexVPKqLU7W5mfSrIiPtTB5iIEtUj?=
 =?us-ascii?Q?Zgx8CQpiaE6CJw5C0ayVk2yzazfJTMrpqLGFWhmubhWA0om5nxqlKxZWEIKb?=
 =?us-ascii?Q?t3OdAdo3RSwKymDa9xgmqtWVJmeSJC98tHS0DNMu4TQLBml1NVTHKaTfcu0f?=
 =?us-ascii?Q?gxkGOyUF2RASh+z4rJU3BztOxSSbq0LfPaFMWk+9AkBih63hriFhBt+u4SVt?=
 =?us-ascii?Q?6RZf3y1klI79h4JpdJQ1A9EIXlRMhQnc7s6Cst+rdcQhz6KSFkdrR/EJlSUr?=
 =?us-ascii?Q?p6/LXxMJkFuqA6sZv00oQR/cILBwyNpBIgycTpkTpztXcECZc07yFIeoFF9x?=
 =?us-ascii?Q?8ujebDCAzpLlkixxeMwSOeZFMVbs+1Mzo75njNB68m1jgk/NtHvA9cAL4vyS?=
 =?us-ascii?Q?URMNcHE7oKgYO/EMA4iKL3hRrxeRz+/qCtEl2leR4eSzE+3PlHttQUw4nODV?=
 =?us-ascii?Q?WqvbNLNbof42gM9HSpLVgq6zp/nLhrpWpgYA0lFYVqdA41pskY6FjelcUfZg?=
 =?us-ascii?Q?iE5i1Y/XMYN2K1tQuKdXDXxt6YMhB0zIWcOJPcCdo4AAVdbbyyWFDVVnlNz+?=
 =?us-ascii?Q?9Ikf3Q+oy7vcoHThEsDi8l+ub1KZL794Wv5krvgM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d561d26f-280d-4556-e47b-08da96636500
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 15:11:26.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X90L4pG8jvBK6n8J2pyaBVcsuzCYC8SBs9cLaqBK+wjj2zxgBnOiEZhzCGZUVMDB5veNsEE/JQbuSgTQ1bMD/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:45:18PM +0300, Kirill A. Shutemov wrote:
> On Tue, Sep 13, 2022 at 01:49:30AM +0300, Kirill A. Shutemov wrote:
> > On Sun, Sep 04, 2022 at 03:39:52AM +0300, Kirill A. Shutemov wrote:
> > > On Thu, Sep 01, 2022 at 05:45:08PM +0000, Ashok Raj wrote:
> > > > Hi Kirill,
> > > > 
> > > > On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
> > > > > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > > > > 64-bit linear addresses, allowing software to use of the untranslated
> > > > > address bits for metadata.
> > > > 
> > > > We discussed this internally, but didn't bubble up here.
> > > > 
> > > > Given that we are working on enabling Shared Virtual Addressing (SVA)
> > > > within the IOMMU. This permits user to share VA directly with the device,
> > > > and the device can participate even in fixing page-faults and such.
> > > > 
> > > > IOMMU enforces canonical addressing, since we are hijacking the top order
> > > > bits for meta-data, it will fail sanity check and we would return a failure
> > > > back to device on any page-faults from device. 
> > > > 
> > > > It also complicates how device TLB and ATS work, and needs some major
> > > > improvements to detect device capability to accept tagged pointers, adjust
> > > > the devtlb to act accordingly. 
> > > > 
> > > > 
> > > > Both are orthogonal features, but there is an intersection of both
> > > > that are fundamentally incompatible.
> > > > 
> > > > Its even more important, since an application might be using SVA under the
> > > > cover provided by some library that's used without their knowledge.
> > > > 
> > > > The path would be:
> > > > 
> > > > 1. Ensure both LAM and SVM are incompatible by design, without major
> > > >    changes.
> > > >    	- If LAM is enabled already and later SVM enabling is requested by
> > > > 	  user, that should fail. and Vice versa.
> > > > 	- Provide an API to user to ask for opt-out. Now they know they
> > > > 	  must sanitize the pointers before sending to device, or the
> > > > 	  working set is already isolated and needs no work.
> > > 
> > > The patch below implements something like this. It is PoC, build-tested only.
> > > 
> > > To be honest, I hate it. It is clearly a layering violation. It feels
> > > dirty. But I don't see any better way as we tie orthogonal features
> > > together.
> > > 
> > > Also I have no idea how to make forced PASID allocation if LAM enabled.
> > > What the API has to look like?
> > 
> > Jacob, Ashok, any comment on this part?
> > 
> > I expect in many cases LAM will be enabled very early (like before malloc
> > is functinal) in process start and it makes PASID allocation always fail.
> > 
> > Any way out?
> 
> We need closure on this to proceed. Any clue?

Failing PASID allocation seems like the right thing to do here. If the
application is explicitly allocating PASID's it can opt-out using the
similar mechanism you have for LAM enabling. So user takes
responsibility for sanitizing pointers. 

If some library is using an accelerator without application knowledge,
that would use the failure as a mechanism to use an alternate path if
one exists.

I don't know if both LAM and SVM need a separate forced opt-in (or i
don't have an opinion rather). Is this what you were asking? 

+ Joerg, JasonG in case they have an opinion.

Cheers,
Ashok
