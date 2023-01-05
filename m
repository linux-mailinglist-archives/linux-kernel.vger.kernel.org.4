Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8165F196
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjAEQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjAEQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:59:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C358D38
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672937948; x=1704473948;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s64+6I6G3uiKbReBnudB2qZFDeRPEdZoj27gGQgh+68=;
  b=dk9vvIOypyNSVOtnQl9drhM7XLf7+UcVFjoljtE1hKn2mDxIK5zDvec/
   oHME61sqij+onU4mM7g0cA7eaKc7QRLxQeClYN1LYaF++cko8Vp7Lu7jy
   ODnlDJOV1j6GA5N1rrDI+KLidUk9Pj8kBcbZZ/lubK0PhpHstRCNCeHPl
   CPReN+wlX6ttCBhXsU/fOm7lcdp/NDNwgxJjpgc+13ilh/rWwYxOWktPo
   Z2ZCGgdMZcWqIXLIqdpO2UMkt05a9ie1AxxePW+yItFHqxIgkQNUL5SWh
   HSd5xcbWpS5ulXY+n1vD350tMfX3qNBSvRjXHgGhGzymF1752+pxUWH1k
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="323510750"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="323510750"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 08:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="687983206"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="687983206"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2023 08:59:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 08:59:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 08:59:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 08:59:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 08:59:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUvdn8Rlj1unA/p8+SIeLyRh0EUBWYVe6bvD5YzR+93XMjVxmtGC3l2deY2Y56jVrUAKNWrNGLoHj0MMi+ZsAP+aVNCRTN/oqcWAs1Mewhj5HiyZYQCQ7hMrg6Jxu/V1dr/SgBh88iU8AtRKf/c7SDsIt8EGNF+HHki/T/E7A0Aje26WvrDcXS49QfvZbWUJUrDrdewHQfchujHvz64JkCl3+pfZG9Ybss0vQzjO0Md+435Uy9kHRBszDxOZ7f/3BjVcYzSRiEXS/ai+Ri5DmQmQ+dQC9k80A8lIG72H9F1Zj/EnFiO60b/P8Rgrz/AwXDx3cJpf7N35lxYBa7sFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/y6VsgEcA5a51+7CCKVeKAvoJiwx4cQXtMXHe3neM4=;
 b=JJebNz69TXqDR2C1e9p6OUGCtFVzNe51w1K4g8QYAohWuWm5fHttNNC3SfcBeXA28nFEGWyjic8WIBMscATiE4hmBCOcgRq761R0DRcto804nGw8XbH/6hKJTdt1Ti9Ah1QHjn9Er8qsiEsEAT1Dbk0oeOorKYvTxow54pPhQFj17c7K7bIa1EdoreaTKUReO7VMGaLyhWErSQC3YwYraB7cq8Bs9n0v5tlu1shlsdersCmCmVs1VctMZOxC6Zz874JIW3oKfNCw3U8qGUtUTe0PI+xiSJu+QkDUG1HmHITKpG6+LrMhg4iKE9AlJslGY4+YRYwxiocZwBAW2mabaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4800.namprd11.prod.outlook.com (2603:10b6:a03:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:59:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:59:03 +0000
Date:   Thu, 5 Jan 2023 08:58:59 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: Remove an ambiguous sentence from
 kmap_local_folio() kdocs
Message-ID: <Y7cB069naGgBCTIA@iweiny-desk3>
References: <20230105120424.30055-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105120424.30055-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ee596f-c445-42a4-3215-08daef3e2631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9WU4A5pGYFF2tbgddHevnrESPDqkavWu5b+o7yvgq8yc60St7csB8WIR8OFE0cqPgeIq7bgztwUqwDyaSTjGJUpRhiThFmZXGAceOuc+/Utx6Czfj5zZJ+7v6co7Q3/4r1VFfHjqI/jutK/nHYMmUtNih+efCqOdE1eSG7VcMjV86v3PW4sGEcohz3eT6RdYB8NmaW/jmjcHMpOE+2NtkiAMIfLv3XD28477PC2rPyPergHFbO1pVrCpP/6ktDHMrVMlt0J1A3xSC1HJHjNou0zdF5J055I+xaAky15+yRxaDe1QArgmJu0CEQRB2cugRyEz6hDCwYMBziaWb7Jvkkj3uhh4yqnXLXvnY78qU+Frqx3lx3jfziVTjXjoTQdarng2sWGtVeoU8lewZ9dKYK4zZCWmaDZABY+m4mG+qu2fLdMCCYipZngDWOAUtdRWRILLDXvBvxI/RFdYNTTCEpsIKHkkBVGsAEjBg6PxX7C7v1p4i140iN1whYe1pKAMRuhbHaBThXMLuQLk9EqilZV4sMWwA57NiNxVzIuvePEEl29jO7r2BWcMCoIcdSxH+RHG/s8d5rtmKaZ7rOUGOvPR6aNqyooLJr3nWJows++UD8e3hpfkbgWXH39kG+z2WjkzMcWhiuI2EBM2W6yVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(316002)(44832011)(5660300002)(41300700001)(2906002)(54906003)(6916009)(8676002)(66556008)(66946007)(66476007)(8936002)(4326008)(6506007)(478600001)(6666004)(186003)(26005)(9686003)(6512007)(83380400001)(6486002)(82960400001)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?83VYUR6fm5DYlWIln88R5EuxfnchEPzjccuVmvytSAQXbAGLmRJwzCpRs2/I?=
 =?us-ascii?Q?GLtJmVqVeI1MafXgNSy/szeymTViK4EHpXU2XZgIqRNj6fsO/m9eBeSHSBNS?=
 =?us-ascii?Q?RHtM39mMvm9XyA3HWagstTtRZH2SaGk42wCoKP/dXcl1Ex9832eY5rPJlgSG?=
 =?us-ascii?Q?c3qJYxnoru0bPDpQ9PlG2CdtIA4WcepQMd/i2cz5cke5zkvwd+QEORm6qNAg?=
 =?us-ascii?Q?sqoKXRXIW0dCObiFDPUkyCW05TND7dyIZA9FjlWU4CqY7qbeKj9kzN96Yrbf?=
 =?us-ascii?Q?pIK09ZNu/vv7s9+jG2diAVzIRxLX7Y+L3xaRkCA8P1Zm5E3dV45qBj2FLESi?=
 =?us-ascii?Q?l/bQ97OUMSS7TTOyD82ag9z0BcdLR7s+ufcEYmCy+nG1yYRvpXMDWNQTO5iL?=
 =?us-ascii?Q?qWV7ijJkkf9bPKm4tbwmjg8tBd+YK8I38g3y3xbO01xm0cLmo8TRntfJfOzj?=
 =?us-ascii?Q?A7AK/t9JkWjqu57oQ4gb61Ma/QJiDfPREjxDEq7wn3ZbjXeC/eRak03rqswk?=
 =?us-ascii?Q?kpGUQsbgHVdsfvoo859EydUrizplb2Ow5yaqZD4YebfhmxJ6Z9x/o12bd1Qk?=
 =?us-ascii?Q?xoV/lZYc12qntC2UowgmwR91LmqoZFq4z+t0cxO+Gim3zVbYiDCFoZ4uE1/Q?=
 =?us-ascii?Q?qGssQDB+l05+4j4VkNp5nfq8jdNQAqspteDm9xVobTjm1FmW6ZVNFgqU5+GP?=
 =?us-ascii?Q?moY0m6p+BivT6TDlsy3ObNMG0QuSye6MuBz6Mq5b0N34H3uixaUvlhr3ux2q?=
 =?us-ascii?Q?wYGCm6K1zdifYnLXGg+OHe0z5zZ/2PW37/iMbQLjQR5MZI9oPO+wWPQvMBs8?=
 =?us-ascii?Q?QjsMa5iyh4tJbL8YsJaKuGdsXK6oerX3LfWujJK12Ky1jo2ExBJkXG74DhIf?=
 =?us-ascii?Q?SUyHdFjwMrz/tzK5S7ciqWsA9HKmTG59KTnAH2/KEv/frSf0Uc6eHDLvHDPL?=
 =?us-ascii?Q?jhLf1Lb6kNNHdPrKN2aA0oOcd29gCcCCTBD3+UXuPrJ90Ere303aL4bmae+b?=
 =?us-ascii?Q?zFX95LivkC9r1xGQ08Kzzo8kkSk4nq15OPPKjwFfDk4kYvZPG/ROG/8DWUu2?=
 =?us-ascii?Q?ioJemqJHYtGAk3K9sSUQhMDYtgugprOWfCvL+clzc5iZPbZwrwn1ugGz6DE4?=
 =?us-ascii?Q?jiu+C3TwiVYRzBhFq8oYYa2ThAY2pFoZ4FFt7Vl7QH92TAjLlg/suiEfui7N?=
 =?us-ascii?Q?wNUcSUABLV41C0zAUbuCSPCJPR1EpMy4TKfs8IT7V5Sryr55UMpMG5+nGVH3?=
 =?us-ascii?Q?mpsdI8H1ltJSaHBH3twSnkiEaGCPMOZNnXtZ+ITego+/YruZHLOB3iLj5pQs?=
 =?us-ascii?Q?oMeloVu4H5eEtNnW7gav8bwwoKXHH+Sq/fLzHRv8xGtnz68FNFbYmxy7aCdS?=
 =?us-ascii?Q?L3QcDmJvNnS+iSIAMUxsnnqOpKrZMDa0XD2yT/IUBjoj8Zqpnvc3jnyVnnvl?=
 =?us-ascii?Q?X9XmyR2Qs+BmQDK1IyetMEL2vsYehrxJ6ZrmfvpFuBhAhtz/BCNPwV84eewV?=
 =?us-ascii?Q?GEa7h907+tqqq1B2GG8WPTDxI2Rc+2seCcAIYnr0SCYPJBy5aMFPHFR+r3eb?=
 =?us-ascii?Q?IfNHqv6QOj0DHpeLcnn9tmtl3tm1Um1mfC75Tg3s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ee596f-c445-42a4-3215-08daef3e2631
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:59:03.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePhT+oTg76RCG5wripiwnf34PvurUwi4jrnZs0odSC1/nW0qu4v9jQW17UVty7GttiFU0Kqokeeiqh9Tx0AXhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4800
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:04:24PM +0100, Fabio M. De Francesco wrote:
> In the kdocs of kmap_local_folio() there is a an ambiguous sentence
> which suggests to use this API "only when really necessary".
> 
> On the contrary, since kmap() and kmap_atomic() are deprecated, both
> kmap_local_folio(), as well as kmap_local_page(), must be preferred
> to the previous ones.
> 
> Therefore, remove the above-mentioned sentence exactly how it has
> previously been done for the kmap_local_page() kdocs in
> commit 72f1c55adf70 ("highmem: delete a sentence from kmap_local_page() kdocs").
> 
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  include/linux/highmem.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 44242268f53b..7b0085a61e67 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -120,8 +120,7 @@ static inline void *kmap_local_page(struct page *page);
>   * temporarily mapped.
>   *
>   * While it is significantly faster than kmap() for the higmem case it
> - * comes with restrictions about the pointer validity. Only use when really
> - * necessary.
> + * comes with restrictions about the pointer validity.
>   *
>   * On HIGHMEM enabled systems mapping a highmem page has the side effect of
>   * disabling migration in order to keep the virtual address stable across
> -- 
> 2.39.0
> 
