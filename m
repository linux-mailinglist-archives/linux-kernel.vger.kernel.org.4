Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EDD72D325
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjFLVUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbjFLVTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:19:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1D67D9C;
        Mon, 12 Jun 2023 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686604435; x=1718140435;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LDvta32C8U093yFYl9aBBIv8p68NdjGIwpz57OjwFpM=;
  b=OsAw3Rm/rf7H1q8oa0vDHIXyg97GpssA5nXKXibcmkzoATnvmHiw/3NM
   oAJIMMyhoa00d+wNxTfkpfm5gjtMa3kbz7VcxO2KJhLHijKSormzd7DD6
   JCQgy00Bxo6oYUWJOUzU7a8Tgxem/Birc3maNtG5O5h8hlqsjHiQzHDbv
   hUcm07eUqVwey9WsChFNDNQWUwyO07sFBrAc6ZsAj6NF5FZT6DbrMKLYj
   iT0FBjEENV9oahG/Lzwko44DPdqCggI/RhVW2lyG/E8QTgKC/LldFXEVr
   QnZIbhbYA24D/yZ8dGJEhYjD+dWjA36JpwcwRRBBuw+DbEE7QkEtw7hxY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342849604"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="342849604"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="855819029"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="855819029"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2023 14:12:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 14:12:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 14:12:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 14:12:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 14:12:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqtLxhhyqB8oYH3HawJy+vmaffezumQ0K5lgp60S/xrzxWpsqufGfAyX6UVrk9dLYRt8aQa1RXeGhDjD+VFxdlmn6n5F3aF9Z3SkZzbFlLnE9JXWoETM7YD46P/LhsDA83Tu9vkdIVbBDwBTApFLfKFEwiqn6T2MADpLejk15Oe0JpgAPSLurIfreJKTFa7Z7RRWHirTi9rEMUHrnpyvN7tnoE1MUlI4kr6UjlimdgCf0s/3P8xL8iK6C0Wo8J8egNST4iudyQ0aEXbVp6NIYJw9+EO0kMz7hq5Mob97xZPMb1l2wVHpFtKtf8ra56UsYm6VWnN2Ii14OYEcd7xZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLYmB49atYAp/XWuCM/7auChBGGhg+l0hKtG89ypVPE=;
 b=MpqmwNIU9m/r+TtAVdxzMZvLl41FkJdsvrbQALmyq0YgIngOorp98PfPdJ38UYW4Tf1Tmn0x0q4eAER/KT6LfOhNmd4sfouXmXa/etwQxjMLDXTK7MXrLLjYtartRsnN/JxfuzwqOu8vPBPnK33zoIEup0fpCZxJuqpCdbSN2cvNiV4EA6rgb3fO+U5v1m+xS7CgRsPSnSOXRc31Vw5FxHYE+qkPVA3ATBVSFRqRUgOr1hU7ABifUlFbKOAmt1+dsZDA2x7LSTL4wBSJabAeFujoEVNox1AVE1Rw9aFBHQN9QQu+JFsnQuMZyOhjMR7hGBL+8GUWkykhXt+Y66FIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:12:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 21:12:04 +0000
Date:   Mon, 12 Jun 2023 14:12:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 21/26] cxl/pci: Update CXL error logging to use RAS
 register address
Message-ID: <64878a219f3d6_142af8294c1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-22-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-22-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:74::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d405bb0-5673-4d3d-6b02-08db6b89abc3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuxyhcZARwRzp1XVxJPHAmcU7DgzsPwhH1cA4/tqkFbcIXhKcBCEDDvXtoAAOp/Pge4JfYeXBB1PURN48Z2aAdrxtF38RR9srCvxVEUJBUmbdf/UK2WG+c7oydFvQ8ZnbvqyU5KVLGSOLH3Q6JTjjSqj1YD0UCsTASGHcq7EMjjN4G2vP2Q3ksXzB5AmTOF1y8qKQcwlVrzk/gdOCef0VtgbYtLsApjK9T8VJ5Obj1OpQOs/B22xIJAnAMARlXNb3DzllMthAiiMaCgEurKqd+j2uY2IyQtzVff2SAvIIjk2LaMOnXxg4bzZUR90mjPsdvHo613X17fBkkM5+Sjmz6Ckko7qN0FsbwC7jTWvyt4kuOg2iywaCEz0wUMihK6SLBaUW6S27mv3j9vV3w7WiEdpkH2u78Fcci4Wd0chSDAZDBakze9aBe1ldhoGImIRFybRWfpIKSlThmWWArQa9nl94Nn8XL6Qi55Pi7pBvfHImarl333p7KdlM/uSFcHcXhv1ghBN4hoyWFxP1U07ONaEnOVSWB7N7x4zkX20Q6BFSWjMGxSot/Ot4h6xdCuZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(5660300002)(4326008)(66946007)(66556008)(8936002)(8676002)(41300700001)(316002)(186003)(2906002)(15650500001)(478600001)(66476007)(6666004)(6486002)(6506007)(6512007)(26005)(83380400001)(9686003)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sfJ0NweIvXBEY/T8LLWyZQdYbli7NkBwz4l+Toi2PM5ZYscvtiMmFrysz0jm?=
 =?us-ascii?Q?CtolJ1evyW+BAsSCJ0Pf6Dt1RVVwf1qsZ15v4UEz3Wgow/t7I0iXq8Ckf+DW?=
 =?us-ascii?Q?2pBCUnL7qa1i0aeIC2mBWzp5mGSwS4WYoiv6LZwbH7j3I1A50DcD9ulIOfIY?=
 =?us-ascii?Q?4yilIlJgYh5FQWRtwvaeP02fXvbKtxmbHNIwwMuM7SHhR0HVCH30JIZNdpVr?=
 =?us-ascii?Q?uxZQmhBHvtkT3W1Gz2kDoZxZRY1kvQGF3q418Z1hnCncHWHSpjxXUc7sFSYd?=
 =?us-ascii?Q?4g+J9lwzm8ZzsSiWEvg3hHDBSVblQoLLM982nFqYs2clEKYoOozYoW3Co2bJ?=
 =?us-ascii?Q?058AjVBEC2Ch/vp+U/Q9d9RfGZuXxUVqafAO0N8QwpL4gCs1vhs8fZwR6tqK?=
 =?us-ascii?Q?EjK5dFLubWtEa1cUEtM67W9JqUaUIgGgQdnwKoXVGCYhQGLXJv7EmmaUamxi?=
 =?us-ascii?Q?EqufCGxZj/Eyo2wI2iqqcrf76S2BJfYZuldg0KK7pGkeL6+6cMFNVrMgp5fI?=
 =?us-ascii?Q?m2sOr7vGB9TIZj1EAHxw4n3p15RJOpdZRbcKvlf1pqQ13ksSN2Pwwp8FnVzh?=
 =?us-ascii?Q?ymef6aH0CYpPCxYZUH2eyviFPqGYGlLXE5Vc3phMHf3KR3XBFKc8qc17jEUN?=
 =?us-ascii?Q?F2sVEPYCYtbnZbBXg0iDTZzbsddnRs4IRr8dbNX7KAOkurwThXYjC4caXx+d?=
 =?us-ascii?Q?EL0jrM1r4KDtvm/uuusn/NoP3SJ0DvyRD9cYry9M3DvhWaNJZRxpATbHU591?=
 =?us-ascii?Q?V7wK5cTRXNLkZrtfGc+ebx1Nebz4brf97+UVCGQdmO16PGy+1CbC8JXAsBhi?=
 =?us-ascii?Q?m/6s0SuEtvc3GkIGLoKiCdl2xNE7LiEhA25Banmxvo7KV1PuBRe9hVq/tPFm?=
 =?us-ascii?Q?JA22GpOKrU+IEJsFp6W8nUd9cVsXXpCuGUmFdaeOoo/8TYHCMX0hpWxEzZaP?=
 =?us-ascii?Q?WMRNM//ZwxocYOoNRVz6hKncCXxbUqpKhaEdJKn6lJIlcWX3mum5AuRXim7N?=
 =?us-ascii?Q?3Pw9CUiPqiFvpbUVEJo3IX3MQVQnT0z6YIST8KNWKH3Jumg3vm4hp7Ab2d2o?=
 =?us-ascii?Q?GxQFkUTjN8IkhMRAwOGtzEWp8Gv8vY0bbIlFyjEtu6XRRy0Up+y3SUs6qM5+?=
 =?us-ascii?Q?ASgKoYGXrC/zp8gjlVA2MIW90cBXD0/fTX61TWr4XNIlHO9iYhxY4svK+EgJ?=
 =?us-ascii?Q?Bh2/onRuXm7Eu5VCrMXfhWu9jJP3cf+1Ho81KjNHtFQHYoG2DtONdX3sb2Q/?=
 =?us-ascii?Q?eBaAyn5phshr6vmOxGOWrjua+R+HaGMd2tjOSDLRQUoJ/Abry5jTSZnbUsmV?=
 =?us-ascii?Q?4f0MJRacztrDJlwKjiAshy+Y/QkUKBZ1oInV2dUK3KSW22YS1IQeINOoIFmx?=
 =?us-ascii?Q?IwtERQAx4/W2WiHqUOINuI4cl/Khj5TX8JsEHfsvE6G51OP5NQMxCnJ2ZWir?=
 =?us-ascii?Q?feMhqEZyBATSPodZahnzXDRm39vPYSFiYrOmIeWxDCzhYlaOOWwhjaxGisvj?=
 =?us-ascii?Q?2alpKy5QXJiUI2fCJEKffuocEDAhBro1jWSODYfjHqNu1PLtzmiWVP9MHUuS?=
 =?us-ascii?Q?ZZc11wsYF2o6nx+6I4NkWzSxkOMH2gAXNNbzyzMcE6Pr46TJIb6urAT+m5zC?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d405bb0-5673-4d3d-6b02-08db6b89abc3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:12:04.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAydKopyogQEMVtsJSfNmcMTW7aeKI3Bz1kli/b7siDPqZi8cwkRsEO22xHQjuUNa7sxbRzlB9Irfxx2XR1hcj5uKWxGpS9c5xlC75xbuw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> The CXL error handler currently only logs endpoint RAS status. The CXL
> topology includes several components providing RAS details to be logged
> during error handling.[1] Update the current handler's RAS logging to use a
> RAS register address. This will allow for adding support to log other CXL
> component's RAS details in the future.
> 
> [1] CXL3.0 Table 8-22 CXL_Capability_ID Assignment
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/pci.c | 42 ++++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 67f4ab6daa34..def6ee5ab4f5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -665,32 +665,36 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> +static void __cxl_log_correctable_ras(struct cxl_dev_state *cxlds,
> +				      void __iomem *ras_base)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>  	void __iomem *addr;
>  	u32 status;
>  
> -	if (!cxlds->regs.ras)
> +	if (!ras_base)
>  		return;
>  
> -	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> +	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>  		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>  	}
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
> +
> +static void cxl_log_correctable_ras_endpoint(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_log_correctable_ras(cxlds, cxlds->regs.ras);
> +}

As I review patch 24 it leads me back here to grumble about some naming
choices. We now have:

cxl_cor_error_detected()
__cxl_log_correctable_ras()
cxl_report_and_clear()

Which of those clear the status? What is the difference between "report"
and a "log"? I don't much care what name gets chosen but these three
functions at least need to give the impression they were written with a
common vision. The term "handle" would not surprise me in the names of
functions that emit messages and clear register status bits.
