Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB961778F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKCHWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKCHVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:21:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13B260E5;
        Thu,  3 Nov 2022 00:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667460107; x=1698996107;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/IZ1RjDn7NQwLCpnqoy94Skv+lID/zSeufqGGbmw58s=;
  b=MN3Ew/27e3mbdpZ2DflSQTCFesT51PeguSXtFi8PVJCWC8Q2Gmhigx5H
   GJ0cCE0T5YfcX2v3N2Lz2c4mFd26pd+DqVJ6aGS4/6qhUG6wIVTbmFTMA
   bd/zzOzLG+wbB0qYohdcneaEoHfMnjsCAOL4rBMn8nfOQcxwx+EjnoH4K
   6f2C+WfDso+egLJpir9l7BQMEeZQpdGk87hgGSA0xusH/BshZdjvz3HL6
   yVs8xBinz07aPC1ltywnbJO8usVQlpGna6o2x+uAvyUX00Fr2yOXuDl8p
   R0C4TQRgvqgOp3KwJ9hAaQAn7PECHkpa+FGiTn0rEoYZ8gqSm7rThlcgi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="289997065"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="289997065"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 00:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="759842567"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="759842567"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2022 00:21:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:21:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:21:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 00:21:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 00:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/PUwIgQ9n5v4QHrvp1PD87WIx7xJHxH9UPOt/CBsaq/M3OHd8R90BEtKGYTDvuB8IdtfW+gp9TljBbXRTzPqYCeCWuuDloyvknGT4X/I7cuBtH6t6zdF62ltwtP+vNqXzDtZsq/Tns1uyiV52WBK447xFXnBQusE1e1SHgEugGlNhQxoEyKWTz7n6pREFHnfa0FVsaPdVWCIKJDURkWxOvq4/Mit6VEDf9ziaf+0hOEQ3BFeNN8HgxNvKtkBWdwa4WUXDiCFthRakNe3jpHmxyNfTRWht+BYbivPdcjLKAmDe6SbiOnYumsJbzseFyfuHHWU8UkeDlWBPVqoAanYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU5X3bO2vkfgKFSR0Q/b83KwWLyEKjZcASUAZS4Oh2g=;
 b=Ui5uY/Q7xsBQ+eM4hDuJ1HlpSeKvhJtXJDIkIioM51Y1xEmQE5LtQ8jjeQjrxQU+/e3GywckD6MucRbUQrh8isGud9pHj54GekUAxRYLsLp8xkyXG5+CrhT+yLfV7MMSj2kQy9pzi0GNhWS7U/mImSG7tyeygo68mX9+JpOKGugGYALhtm2L3EWw+cty6SPqWsKngpM9tPtfdSZ5KKfT5ybz5ICicsl6ZuNWzLHEx/TIxof7OgEPxLE83RY+vlDWDSAKvTch75kijgJ2iKmi35c2CronLu//XNzucwbxPDZDv4F9bqkh0ITTf+/ImwoeWwJi9QP40oBqidmw/f2+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 07:21:44 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b%3]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 07:21:44 +0000
Date:   Thu, 3 Nov 2022 15:18:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     John Thomson <lists@johnthomson.fastmail.com.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christoph Lameter" <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Y2NrRt5FF+zi4Vf1@feng-clx>
References: <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
 <Y2D4D52h5VVa8QpE@hyeyoo>
 <Y2ElURkvmGD5csMc@feng-clx>
 <70002fbe-34ec-468e-af67-97e4bf97819b@app.fastmail.com>
 <Y2IJSR6NLVyVTsDY@feng-clx>
 <Y2IZNqpABkdxxPjv@hyeyoo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2IZNqpABkdxxPjv@hyeyoo>
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: ab12eb52-954a-4970-dd7d-08dabd6c0f6b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWkemyp9S6Fg83eh1oC6dnvD0VbfJD5byy7pDVjzZKjwv35seR8M9fsgokRqui5s7+Nrvee6OBNtADUSeDPIKuPQepSzFBTmT5W1vb4h9IVyLlbZhsBNf9LjyIqf04QuSF6+JRBDnPHNw53o8NcUjXwZ5ejthPZ/K9VySKcfgzrfwqRHujYESJ7GRO5RDYAux5z/veipQ6hJKBdo67qRmG/azmko8DDnzcDTsGcLJgdQFxFfsWOidiMKn+FRdca8vJ0ZaYdU4cYPiVcBlSFLQMXWvJ9gSsBazyampaIrU4A9zFtj5+3QCjx/u+ptkHeilLi7FYFsmB/uHY3MarSPT46W1wkuhEYez5kLilS6YsciU8zOG7zrWS/zy73cHCZ7/VA9ms61zHoePQyrNIsuIkjJZ/s+UDnSSaskCnyu7LKkA1AFfQZjAH3RHMsgyD4AVBsOX5shBSU2WgSkAQ9p0mAXxkyp7g/rqqrkq3Tb24DIMdTwmdIS1BUx1E+OZVF1o/11IV7I3vTCBhnJi/kiT2fPZKYnVHYLqMhMQ4VEPWyxA8NV0j7gsBl1a9mGLuxz2WGUqKeGcrzZJ8PI2Bx1ssEIG9TCLAUnQZ+YzKoRhD2y/gyRIfWKoD3D8dDeAl5cBk79o+ZXw8XuDL2wlyoBjv8uZF7R65VMUih6Q0/0HevYMed8m0ao+RMQ4e/K26IO68zOts+YT0OQPIwcZa6ZnbxKTPBI0JmcvN61r/X5BWvoGwiL98WZZ1fMr1z4Mv/0gs1qTDds01IWJJHFb6+4yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(186003)(6506007)(6666004)(6512007)(26005)(9686003)(83380400001)(2906002)(44832011)(7416002)(478600001)(5660300002)(6486002)(8676002)(8936002)(66946007)(33716001)(4326008)(41300700001)(6916009)(316002)(45080400002)(54906003)(66556008)(66476007)(86362001)(38100700002)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nPEXF85MWQRhANLG57VLmL/5jmWf7veMx40FL6aLpEs2AfOuhJfaDuFQCTGN?=
 =?us-ascii?Q?Anwk9rQ0q99HWIr5Wff/ddJchq0ggRGYXkvOgPDMILKdIV2So/NdHja5dWv0?=
 =?us-ascii?Q?HhEqJd3XIPFQhUg0NSdG244UX2fzdzQI3HcIHmABD6QIIrm1OY+HE4BkyKgK?=
 =?us-ascii?Q?2QpdIdG+f0+eRVHo0me6ZhjOUQPUFF/QbqCayVsmi7Rl2AO0pRe+GQYcnWNF?=
 =?us-ascii?Q?YjQjeF2xA6rQFstY8JZzpMHMra3otFhou9R19YencLW3zGurSAlIOkX52wHp?=
 =?us-ascii?Q?xor5zRfLA3+6shY3gWSNJCAQ9XmaZzQSWv/wHOHRkyo91sd9vRHQovpd70UG?=
 =?us-ascii?Q?okw0AEDQ53DrBDKTybzl2i7UYdQrruNEEsqv4vkWaiq6F1A8oBpsJHNxfEum?=
 =?us-ascii?Q?YEnD/tvlqlm0ARLwp0ZYzcXAPwk8Uk3YbuZFl/IZGx2WY0S0rOMHsFM7E2uc?=
 =?us-ascii?Q?S21tnTFffUkRtoaQRPkGg7pQ/mQxfkYDUje19gzGjMGPxr0VJRMU/CZ/xiNV?=
 =?us-ascii?Q?GMejdqaOMNEo2s3WLvv44FY+nygQ6LzLP8DNhnUkDnBOMzJKDkUkoLxoa+kR?=
 =?us-ascii?Q?JlaggLTMBPzDqBJ9bAqeb+VAsPjU8EQxg7D4ZI0/cYiCjoFklnAqsVFwPSFI?=
 =?us-ascii?Q?uupYvCZt3ZuBJlzHr9m9dzg/FLQMqKHUmmGmGqgNjRYcAx2sPyLvbuKaoav6?=
 =?us-ascii?Q?lL9TZ7F1fg/BxX92l62O4/rEXGoWra22tIRk7gid9vcjrvJbc7/BwaM8TStK?=
 =?us-ascii?Q?r0QxjykuKMdZ9W2Y8VxgqJOiwtCYEuxvqfINX6de7EVNMf8ye73HLTT6EPga?=
 =?us-ascii?Q?xufV2gKvD+OTzg+c06VS48KcxNdAQVqnBcrPkXz5gpDAJLFX8ociheJv7BAY?=
 =?us-ascii?Q?gyP0Hi+4OBlnSygMsoK6ODkGbHHSFwrwoL4hOGfGE3idqW04FJ+rpTZl2rCF?=
 =?us-ascii?Q?eock8zAOCF24J9KustkJ7OkYJ4/+5nDxFz2aI2wDS+9IO8snXECeeDj4hr41?=
 =?us-ascii?Q?k8kKOagjEW4gPbg9LkLga6Y1d8HbjsDTE+u7cf5lZmQStuO+Jb3Cv8YrCppQ?=
 =?us-ascii?Q?jqK6+zGdXKSdZx2APfyGzOKz+1TT8eVjNCOjAIGMTsEhoeqYwLnTdwKh/Gyv?=
 =?us-ascii?Q?Bvgf7ZH/15C97kJkPLLBp8Urd6Y6z2RJvOp4wdWOymXim7xmR0+J8LJn1IeH?=
 =?us-ascii?Q?PyLDFpLDOVd/Vu9ys6FgrQVyHHTf5AvKjTMLnKdGaqLt47mg5RYK6u048qpZ?=
 =?us-ascii?Q?b8EiO9eokoGaDy8hYkE+xba9nwWdCKb4cseQRW5IlAkLvZDj0Vvq2Y8hQ3F5?=
 =?us-ascii?Q?ALTTEVIuYYMcMB2xwSaKrfzlcqfXpIJppMWfUNuo2lw3v7tKvae7pmgbgf7G?=
 =?us-ascii?Q?XYBFoWc/HG9qYHQdYXmjrHJAGfWqhXDaN5H6NFXDN4NN806RCJMT+rpjkTU1?=
 =?us-ascii?Q?7TR+bHQ6vDtQ0UqQWeZ/lyPxjkiiVwARKDu1dxhuNBdP3yGbAxg7F+dxaedC?=
 =?us-ascii?Q?CAbR9PmGGcfys+8h2ovTRkPPoEwlHYHn+tfR8bp3+fO1h4uQGTbcxe7onpq8?=
 =?us-ascii?Q?QPBfZpeCr8Az7YHIwcI8H3EyarwaWmcgPI1NFI7z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab12eb52-954a-4970-dd7d-08dabd6c0f6b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 07:21:44.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cifY7FXAP6xJOtcXA1ztC9zbOmU2EEBzsby6OjQjlTnSdEBceqr6C5wdbApzi12/EypkMp4t1GHql4Pfnd76A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 04:16:06PM +0900, Hyeonggon Yoo wrote:
> On Wed, Nov 02, 2022 at 02:08:09PM +0800, Feng Tang wrote:
[...]
> > > transfer started ......................................... transfer ok, time=2.11s
> > > setting up elf image... OK
> > > jumping to kernel code
> > > zimage at:     80B842A0 810B4BC0
> > > 
> > > Uncompressing Linux at load address 80001000
> > > 
> > > Copy device tree to address  80B80EE0
> > > 
> > > Now, booting the kernel...
> > > 
> > > [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #73 SMP Wed Nov  2 05:10:01 AEST 2022
> > > [    0.000000] ------------[ cut here ]------------
> > > [    0.000000] WARNING: CPU: 0 PID: 0 at mm/slub.c:3416 kmem_cache_alloc+0x5a4/0x5e8
> > > [    0.000000] Modules linked in:
> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #73
> > > [    0.000000] Stack : 810fff78 80084d98 00000000 00000004 00000000 00000000 80889d04 80c90000
> > > [    0.000000]         80920000 807bd328 8089d368 80923bd3 00000000 00000001 80889cb0 00000000
> > > [    0.000000]         00000000 00000000 807bd328 8084bcb1 00000002 00000002 00000001 6d6f4320
> > > [    0.000000]         00000000 80c97d3d 80c97d68 fffffffc 807bd328 00000000 00000000 00000000
> > > [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
> > > [    0.000000]         ...
> > > [    0.000000] Call Trace:
> > > [    0.000000] [<80008260>] show_stack+0x28/0xf0
> > > [    0.000000] [<8070c958>] dump_stack_lvl+0x60/0x80
> > > [    0.000000] [<8002e184>] __warn+0xc4/0xf8
> > > [    0.000000] [<8002e210>] warn_slowpath_fmt+0x58/0xa4
> > > [    0.000000] [<801c0fac>] kmem_cache_alloc+0x5a4/0x5e8
> > > [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
> > > [    0.000000] [<80928060>] prom_init+0x44/0xf0
> > > [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
> > > [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
> > > [    0.000000] 
> > > [    0.000000] ---[ end trace 0000000000000000 ]---
> > > [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
> > > [    0.000000] printk: bootconsole [early0] enabled
> > > 
> > > Thank you for working through this with me.
> > > I will try to address the root cause in mt7621.c.
> > > It looks like other arch/** soc_device_register users use postcore_initcall, device_initcall,
> > > or the ARM DT_MACHINE_START .init_machine. A quick hack to use postcore_initcall in mt7621
> > > avoided this zero ptr kmem_cache passed to kmem_cache_alloc_lru.
> > 
> > If IIUC, the prom_soc_init() is only called once in kernel, can the
> > 'soc_dev_attr' just be defined as a global data structure instead
> > of calling kzalloc(), as its size is small only containing 7 pointers.
> 
> But soc_device_registers() too uses kmalloc. I think calling it
> after slab initialization will be best solution - if that is correct.

Yes, you are right, there is other kmalloc() down the call chain.

Hi John,

Will you verify and submit a patch for your proposal of deferring
calling prom_soc_init()? thanks

- Feng
