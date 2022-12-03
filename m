Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8554A64130A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiLCBlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiLCBlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:41:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A536210FF0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670031688; x=1701567688;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a8QDhxlkbLUsfkEeQnHJAIZl2yZVVURTe7f2t2Uwnh4=;
  b=eFCXrb4G7UhA9CFwV3H1LFzm5N+AOyW3Xe0YW6oqkJrwISGO3hD/s9wz
   ywMTBoGrjoa8MYlHNAE5fbTEXzLTao+u4dHHYCX6SgqBCZ5SGnzBUvoa1
   W1blGUR/LlI16ZCsKcAyohS+Gz5Aj97l720ezoWjOcoxcKOOCm4tdYP5Z
   Ios9Y+0Arz0gsXxvuSDE8yvdWQNWwenM0ooYw5cf3QUgyuay+vbWM5UDp
   NPlheTKVs+VdCw0njhfvHHl3aWXIUkOXzjseIusfwDfi6dx3LhGDimxUD
   IdfI8e2llCQPSOq4pnNjXuQn0Q+i3ddrxkv7aVO1CIcjxuH8eXf9e7zzx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295776704"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="295776704"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 17:41:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751486675"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="751486675"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2022 17:41:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 17:41:27 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 17:41:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 17:41:27 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 17:41:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXrbIt96WX7j4LJSqJNo+yPk0FJJR6xxdlvviV38k8vwvZirKaGbVZjhwUm86WRzktptdPyRZyovLen5FlfT/Y0wtvybktGyjJThLV2sX2mG5/2WO6cGw8rAyR40vSDwQV/7S/jUBsBALFlewjv8Rpj/jWMR+eD0hQhvfbZ+wE26dGqE9U07eAMYgduIj7joM/cdGoUr0MFUHxhsNFtztHPeS9RXkcgf4lGluCzFQ9AdOwm48epqd1ZHjk54G22mxrMfQS2c56v9qSQqFg+gLLvKFVM4R2WqLKjLW6HdJRjfE0xkpR0ZX/MudiU2Js+rqfAaKUoPMSNCpMqe6q3JXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwMlxb4+qAZLkM/N9H6zx/qrjBkiB/I/zVW4KYTLnWk=;
 b=ZiNFpOBUzxGTZklkjXCHbG9n1gzZjM5V1uVRjHgYnkQUT7Wq7+zwte+LlEUrQ9GV9fPp2RtWEQrQJtu7xAa85ZvQ342gK6xM/qOMWRWJDTZBe5K0VUKwOk6Efr3TJoXYXYYRNOqoF7qcq558ld/DjlkqtRWiTdxAM7t5rVP5oQj3uQ7jVA5JalZAiqnwaFmBBuNfT/z4UWGLxXN90PnHNZZP3U3PQ3RFffJmbtV1QkJyggiUGiroFNy6mfdzI4fHcz0+2fcdRzizG36WWuVs6GzgJ9jysuLSNTthlA+gtqf5lFyjCWoId0wp4zWSOgl5Dauoh9Vzhfl12hC8GU7BKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sat, 3 Dec
 2022 01:41:25 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 01:41:24 +0000
Date:   Fri, 2 Dec 2022 17:41:19 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Fix buggy QAT device mask
Message-ID: <Y4qpPxpXO9XQ2NEL@a4bf019067fa.jf.intel.com>
References: <20221203005610.2927487-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221203005610.2927487-1-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32)
 To SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cde143d-9dd0-4764-5bb1-08dad4cf7d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQxHza2rmvUlehys5zM2PDps4oxbq3zntwzmfMoIo2zmSaGvPvvVvu6kG03ZsF0DCPMO3s2IXZAh9O9ubZtcSUrvxXGqefsT/T3nWqe9ONiGKHyUGx8Jnj3sPuMdCfbzKTQNJ2LmZA3MiKrLtIPscRDX8idIcu3isNp8DZ4+rI12yWMYir2IPNeyg1UxvRxdWMra+1vtC4zjXQbuMNwRHVRpjcC3poJLOf5VBSxMB0uT+r9ow83eqd+VwoBhPGKHbI2H43mjEAIBuAoFxaLf45SuT97xKtyq3Pql5/Jip8qiyvigfpJXPIul+Dwbp9lB2JdPpzZAvNF1njr7UMIl4zuJduHSKgFJbzi091oy/3L5c9jIGHjARfMsyWQtW0rUqbghYBn6F7kn8ou09VmtOam7igFAvPEAK6+PxBrjOnOGKoxcM4hMfun2VNu+RzP8uLxNuAt2nSVxY8twWuM0cQ4BOMz3GjoaEqrmzNXiBtAK6MjwpJaLRCuauCaNIZdIlYZRrKNxauLeMI2/yRFuPKC3C1K18PxM4pzh3v5WS2FhRfsvfz0UOkI8mY0s/f2JPvHDGshCxlxPLBpKK3ESu04UuJFKVLVSWJH83kmy+YkrmZr5HzUw55OIUOO7aiGJZIngavkkcYjqR3uBuCLH9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(186003)(8936002)(316002)(4326008)(41300700001)(66476007)(8676002)(66946007)(66556008)(54906003)(6916009)(82960400001)(38100700002)(44832011)(83380400001)(5660300002)(86362001)(2906002)(6486002)(478600001)(6506007)(6666004)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kbLXCAB76zXaCZ+TImX3Rz9q+QSUfZmisw+1CSHUXXRrZ6psaK797J8BHoMu?=
 =?us-ascii?Q?FZq1APF+ubmyAUGesVC45suWEvdB4rzypq38z37UJPdSgMK6ORRDwre6wh8Q?=
 =?us-ascii?Q?MVqE+maqSoXzefOJqk0nhIYG2H8jX8ZPmLievIpwhArwRUmUqS3UAflB9IX9?=
 =?us-ascii?Q?ZNUzuOZHoXg2Ye2CS4ndTJ/g5aCwVDLmDNDBWzyr9ogEHY9mELrk8j49dX5s?=
 =?us-ascii?Q?3uA85NdlDbPK2IhaqpyVyu/g2JgURdXIyBT475mfUXSZrkxTNuoRED3H4Et1?=
 =?us-ascii?Q?IVdtGHEgJZ8Zo6EesbhGZP7+yG5QzAhPAT+xja91RY+XWSBbompXpCSfpk8f?=
 =?us-ascii?Q?8lw5IG84PwxYHPqTTufvRvJ88c+prm0tH6gSuSv/hUG7KqT17NdLYLLlAAq8?=
 =?us-ascii?Q?ecu3JY810kHqrNrThrCTLFZPbGVKVGUpIUzHN4XiIpIKe/v25VjlsNMtFcDv?=
 =?us-ascii?Q?ZOE4/i0KU7CF9ShEAh1My0ifkh/D6V1wJm7UQ1sv3VJkFIZ03fqGekYRa5Op?=
 =?us-ascii?Q?JR9ea9EcRI4fJOiET+KTyy/Q3Dqkk+ij2QH7xwjj5xTT4fr3F8yAO18qV3Im?=
 =?us-ascii?Q?vQLe3r9NNW0A8mIAjIBha4Uo0UJo5LS/IuPl/kEhng+EL1NZStLA+gyEL9DJ?=
 =?us-ascii?Q?EuDpAfNuCuBoz3LY1MSeJmLcoUXfELtgKZy4sdTaaMBAFCu3jfVpXb/pkmtQ?=
 =?us-ascii?Q?29ttMtnF95uefkC5ogGYKGqxuWYGTTDbyPJI7cWZ0av/W/q6DRAxDg//sOUv?=
 =?us-ascii?Q?KOg8bkJL66Hrj3oJhksW6tVRVxC5Y1fCQ8q++qyMjWdfeWVSCmEOEjv+Q4Zi?=
 =?us-ascii?Q?rskwfFHFi3TduuyhdfHyz89PmCo3QVZzMbfjgMILiLRPDxfJ2tIxRuBksMds?=
 =?us-ascii?Q?VqieYow9CaKyjcQgCtUhow9iUYyHXP7kR7/rcl/vH0iA78GezZ/KC2zHDCjI?=
 =?us-ascii?Q?/meElNGMsh897NJrvFnv7eeETpSVFJG+VvemWr9wi4o9z0X0IxSsEA1SDet1?=
 =?us-ascii?Q?1o7TRm/lpJKOnzlL94IkIV2eEidFexvBHnfhFpLkE6QUIVJX8+18G3l10jia?=
 =?us-ascii?Q?0oK/LQefJBvxawUGYvWrzzPykjNVGhSOmsRSfB1h1uen6fj5hTZjYtnoojRv?=
 =?us-ascii?Q?eN0Lp4T1sX83wpXYy5JjWqUz6z1O0WkSiPLKI0ebEBOXwLAeuULx/tMgaQaF?=
 =?us-ascii?Q?EA3Hc+mgTHv6N/IssDTz5hZaFT2oXwI4d/D0NCctq7JYqRPYNWo2ON8rl6fw?=
 =?us-ascii?Q?/dn3m4RPifDXLt/x32x+OC4r0dD4Mji2zDdT4LEE+lsQ1W5pdJhYeouA9Ges?=
 =?us-ascii?Q?bchnoZjIUSBlI+wUAbR7hNgQH2dU71BH/b3t1S3zY1R+EfnqYtalvFWrXfAe?=
 =?us-ascii?Q?CzFtKK56JspZJWrn7oNean3HyosAyW0I6PWpSY0CeF/B0GfF0w6SrV4HnPzE?=
 =?us-ascii?Q?lW4LKOLMWmxyoL6TNA9mAEAxYh+txZiFF+r/K6IRz5Od3whYaLlAkeWaPL+3?=
 =?us-ascii?Q?vmFfJzatFz9COR80kNr1NJC4F6UpZCsnWhHuOWiupWiDlha02WmpiUTOhUhB?=
 =?us-ascii?Q?UjWD83DXw100xRu+tElmehHyu6Cb/eBMZMJR8maquM31lMozltFiqhghQKrz?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cde143d-9dd0-4764-5bb1-08dad4cf7d03
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 01:41:24.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNBPeqPEXAWMdJywor2O2Ozk1uIZq4W1RzrJsy4bchYqFtuMV0bcr07jydOW6CvXuMZ3ZXho+TA0xIVvuvtGGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:56:10PM -0800, Jacob Pan wrote:
> Impacted QAT device IDs that need extra dtlb flush quirk is ranging
> from 0x4940 to 0x4943. After bitwise AND device ID with 0xfffc the
> result should be 0x4940 instead of 0x494c to identify these devices.

Can you add the lore link for the original post here just for reference.

as a Link: tag, since this depends on the other patch.

> 
> Reported-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d8759f445aff..0b10104c4b99 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1401,7 +1401,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
>   * This quirk is exempted from risky_device() check because it applies only
>   * to the built-in QAT devices and it doesn't grant additional privileges.
>   */
> -#define BUGGY_QAT_DEVID_MASK 0x494c
> +#define BUGGY_QAT_DEVID_MASK 0x4940
>  static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
>  {
>  	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
> -- 
> 2.25.1
> 
