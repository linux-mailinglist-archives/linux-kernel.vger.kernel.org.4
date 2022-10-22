Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2767760904B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJVWor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJVWon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:44:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072A013F1D;
        Sat, 22 Oct 2022 15:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666478680; x=1698014680;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X2foddRq+aczzIq2tTVM7OYAN3N8sCz48UJIX/m+r/E=;
  b=Eb+8uEIskp1IOOZB4YzftN0YWeyEBijgnOdqlklqygSSSO6s7SKs76kg
   onMdvwg/gbbGy2/xCoHompikp4SUQSTfKWwt2H3Zfqh72wCImNWucvXvV
   g4qs0UTLPpMi4mE5DqHRdzN9oxRWFSIeY/r/hhi4lbDwrnpNi4HIOtCFB
   B9xPcfDcIRPYfNjz5BTvqnTvIs1ihsnC4ShJoTuhlj/oh7AtCWB3V4tx6
   HB1Kvyw7NPLg5fzTGLXBzhNmCErSrcW5ABYkMpJtk+B54Kq2gDbs24fEY
   8KitbmsVnIR/JArKclnVhnwpaxCnPLlHwaiQfed+QAJ8Q2SsvTj6XVvmm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="333798377"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="333798377"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 15:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="694118110"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="694118110"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2022 15:44:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:44:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:44:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 15:44:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 15:44:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJzJ+LVrdz6cCuRTKxHjJN+OAACdz/zCvBsQHVjEMC0zGw+NL5BMbsXJm8rdaHtA6qNslKgB+1Wmx9Chq2QGNIao6nG8Kqd9KRCbf3P350fR6FGiPiEnqE+kIEj7U9GgLhXSOUkIfrMZ5+Xg5rCbu5RINkoAk9TJ5MmI5Y7vPlhomRstcdqdYYsIjlzLccy6PqUS8yeZhifFghsGBKRKzH40oCPCh6VKACpjjhRVyWfSECX5ZKrTDGGRCZAbnAKc23BqeSdEiePwE9rDyXBE+uD2f9HQP70l0vI4Glpy+j1QY4OgqH0l1eUiD5+pjx0WTzlSzIddEgclC3Yh+HbuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7o/Sj3aQcx29Mfhn+L3G/NNHgxAUH2SIKEaQyhnxCM=;
 b=NdxPXqdLUApF+81gxxZb4NwHMuS76L4hmYpqFtY1UVjKJxcL7rflP2+wyHLEnDLW0tC1Pii7j6BSliK0gammuaOHExUxm9G81Sd17Co3471VAS3NrngyQEOWSS5slbtigwpdQb41++wTkxSlGFtBk8lOBZA/cS7u8Sz7rVYuIDGke7tgKQPUx8upe/4YDf0BFNl9OiMbSsvdtTTEWlUhXwXUS82kQGtWuV//i0IRgn+kQ7VYfZFTzFdWDfNDtDOtx97PGPlzfN6k4AoAvAPYYepI7/SSkagw3765oNNmNtVcG6j1x1DAfLUZayGMtU2YcCBql3l/NXvhk+ybOVtc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4530.namprd11.prod.outlook.com
 (2603:10b6:5:2a4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Sat, 22 Oct
 2022 22:44:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Sat, 22 Oct
 2022 22:44:36 +0000
Date:   Sat, 22 Oct 2022 15:44:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: RE: [PATCH 3/5] cxl/pci: Discover and cache pointer to RCD dport's
 CXL RAS registers
Message-ID: <6354725122f2c_141929457@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221021185615.605233-4-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM6PR11MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: da3d9848-9aa9-4151-d457-08dab47efed0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhDTgK4hwJzo9/sbt3X58HpovA6MPkbOs4OCYZVLCi9Vts/6OeXxN9gNTHIkDEasLXaVf6EVDXRHOFQxbUB1wOJvmeCIyEypxxbikKlWT6Q/bkGDjORZIhV92FqU6Q+l1v0NXUNMOGxPgR6CJgchCoufLmWlx89hFdwI42a9FnXGZTxVNCEkiQMBVy0id1GimblGg8FwonxnrnK3fqtLs4mXzaxcfE77I45RRo0b54Qa5Q0bfdVEmBbBQqRB4kqTBrRHzkHla4M2U744T6zJ2GK/645dAgsSGTUHmGbjVVUFlCPnIxSeiPkRtMvZQAin/oarIFGn36oGOXhnPyy47rufXlFjPF9lvlqtskLqreZCwmJkj9290PZm1i8LZ13OW1zTBxOaiJA3zirQOU7YzsdflnWb5ycRZvyF393dp0SIyasrc+Ao3Y2Dw/+wRful64Hzr2a4skaHxRrgtjUGraQxIVibJxcBsuQAWFh3ZeMifsbJlXpYN9usWzdkYnFYuOk6vPujLe034aqELzpY/Eez8RJlr+65C4SZID2t+wdvhLHydiUloLmwFme8FzxB0uYQhY1UDud6FsXnybI6o7XowTXDG4GPL+wbwG+4uFoa9fo0WUZ/Qi4m2C+N8bUt6HBT7/zHBi78LJPGe1JFG6dqmdneLcW2Icp57/MVlP9lnkwkFRCtQ2SFnU6ijyUEhadidyTALndDAUlFVN7xYAzavpUPYdjGUw0iDulVghvRqDoIpd42mSn3Hii4XzU0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(4326008)(66946007)(26005)(66476007)(8936002)(66556008)(86362001)(478600001)(6486002)(966005)(6666004)(186003)(2906002)(5660300002)(83380400001)(6512007)(6506007)(9686003)(41300700001)(8676002)(7416002)(316002)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dtqyg6HIqm3k+4rXouvYa+UBt9W/AtgP65k/Q7FO3Hu0a7Y/0qCNl7eT8Xv9?=
 =?us-ascii?Q?wdeE0vZCyCRtOxoc8jeQJqXtTzhSNEniWjrPmbsWoQaY9kDoREXoGmcNWYmy?=
 =?us-ascii?Q?E7VOXn6CQT7R5x1FPYA0KT9rCdq13wuk73DmENa4IrsvKxu98CVbvChop37g?=
 =?us-ascii?Q?M9aYGDcieDPwm2wA4plCoMPzQRjkyOEESYP4a2q+s0IhHi7QAvCcNZ0SDRVP?=
 =?us-ascii?Q?qF3aam9HQM/HvIPPRlZibYO4iA4tIw7IkWrk29NxYGmxOwszt0Vd5w/7QuyP?=
 =?us-ascii?Q?4J1YZ3+KFSYKUaARPJUtq6L+j6A+RqfYxkVYaXIAzn75zG/TILfxh6bgmeW/?=
 =?us-ascii?Q?k7imW7E8i+rkYZBRRKGEG8OB8zpe3pydguyIZCuBjl7Af9tN+FDHivHJ4IyK?=
 =?us-ascii?Q?60P69yTkmnnNlRAHN/Oe1Tv2NsNrmbIbgl1tk/5VU1DJq1u2C4zin9vA0rzk?=
 =?us-ascii?Q?VOXHBKs2UCLJVfPv7jckDz5jEffuBZ9G67a7j0//c9XKA44HjF7Ykys9oveU?=
 =?us-ascii?Q?KzJfzxRrusw2k09cAmmEw0vdMNYW7T52Ub3vfZVdyMyGbEkgLFRKqMpeW/Mf?=
 =?us-ascii?Q?XGwFNYpVZ82BnKhdKSG+kJuj9xGUbaXUsvIF556HTrxgdGyPkQvIbx+blar9?=
 =?us-ascii?Q?xPeMsnwGPTF1cIqpbiWCKky2zmHJxfJ9hlWAZDki9KA5y+4grUNUJnJu9ReG?=
 =?us-ascii?Q?PtcpU/f8mWQjAnvEoA2A3q4EgZ3dznRdI9ByI4QnTrKuEDasZiSwPzdPWkZ/?=
 =?us-ascii?Q?Z2f8Rmcd7a+7v0MBqjQ1ih5VaOnyjXuSJl2VDgOADVYsKt0Prirne5U3zX1+?=
 =?us-ascii?Q?mFVQsHmWth2vaoA2k/dq5fhLeTX8vB1RlOwfXCEUfNLauSsy/hQlIfAnSJZa?=
 =?us-ascii?Q?xTG/Q9jINnY6RZ8hUO+pVw+FDiDJtIrEsl7LbTYi4gsuF3YLW3aqrb81Z3EB?=
 =?us-ascii?Q?GV2a8D5Koz9MkVV2aAP1b57y/KYhdP83Vuo6EPQwMnVuoEDgIT+6YrmmmbGJ?=
 =?us-ascii?Q?WQmJ/mmvMr8dih7VOchIE4f1DXVH8knMWwwGbr3qNcbsksjFha9HOa7sy6pK?=
 =?us-ascii?Q?7AH8ToCjitNDxrU+r+31fKAcUFdyYu83/eYG2iormbpAPiFE3hEb60RL2Jf5?=
 =?us-ascii?Q?P/L5IaBn9kaH6Gl36X538NNCCPSnXtwKpSZ8RFMOb7JCyMQcjtJNqgYGRFx0?=
 =?us-ascii?Q?7mGIG7VtRXRNeZG15MZoRrIJlLlH8UbQfoDRj33Syfbzag22TJtU0QAzL5rc?=
 =?us-ascii?Q?qZqM3TNDWY4wyotdrzTSYTMxP3kXV9aHdQ1P2ObaY4yJsf6Tba5s4z6exbQG?=
 =?us-ascii?Q?5wPfUOvtSHdtds2L4ogmoB6GjkzlamppLsrcFzkxX0a2e4lksRrPeWlUww0X?=
 =?us-ascii?Q?B3iZn1zwRVL+aON0nxFxTg/Bi4uvgAQnuwBF3j9FBLru/qvZbZEoVfox8NAd?=
 =?us-ascii?Q?sx3N9k74rpjxdQOjV2KZgz2RGfdMQG+dYpDdRQurQrG/Z6l6fDzvBGxFfbbe?=
 =?us-ascii?Q?n9mKKd8XI+Am3d7rrnaGNQxt9MRSRATDDXd/KFupc2bHYpdZUcomicebqnm4?=
 =?us-ascii?Q?ozLzeJmRqug5viWaNX13vaIio5f3ZlqHHx2KnjwQnAWZfVAIwWDGfJMeUkEe?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da3d9848-9aa9-4151-d457-08dab47efed0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 22:44:36.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8284d8kpFZOUImtMR5KV0F44wG8rFuDSsEP5lKk+d7H7lUAkVLXTGXMgMp2/OUUDSnWpgNRmcxpN6lhYUpu2oQZGXg7keOLy/LduXxHJ0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> CXL RAS information resides in a RAS capability structure located in
> CXL.cache and CXL.mem registers.[1] The RAS capability provides CXL
> specific error information that can be helpful in debugging. This
> information is not currently logged but needs to be logged during PCIe AER
> error handling.
> 
> Update the CXL driver to find and cache a pointer to the CXL RAS
> capability. The RAS registers resides in the downport's component register
> block. Note:RAS registers are not in the upport. The component registers
> can be found by first using the RCRB to goto the downport. Next, the
> downport's 64-bit BAR[0] will point to the component register block.
> 
> [1] CXL3.0 Spec, '8.2.5 CXL.cache and CXL.mem Registers'
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/cxl.h    |  4 +++
>  drivers/cxl/cxlmem.h |  1 +
>  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7d507ab80a78..69b50131ad86 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -36,6 +36,10 @@
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>  
> +/* CXL 3.0 8.2.4.2 CXL RAS Capability Header */
> +#define CXL_CM_CAP_ID_RAS 0x2
> +#define CXL_CM_CAP_SIZE_RAS 0x5C
> +
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 079db2e15acc..515273e224ea 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -243,6 +243,7 @@ struct cxl_dev_state {
>  	u64 next_persistent_bytes;
>  
>  	struct cxl_register_map aer_map;
> +	struct cxl_register_map ras_map;
>  
>  	resource_size_t component_reg_phys;
>  	u64 serial;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2287b5225862..7f717fb47a36 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -586,6 +586,78 @@ void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_aer_init, CXL);
>  
> +static resource_size_t cxl_get_dport_ras_base(struct cxl_memdev *cxlmd)
> +{
> +	resource_size_t component_reg_phys, offset = 0;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	void *cap_hdr_addr, *comp_reg_mapped;
> +	u32 cap_hdr, ras_cap_hdr;
> +	int cap_ndx;
> +
> +	comp_reg_mapped = ioremap(cxlds->component_reg_phys +
> +				  CXL_CM_OFFSET, CXL_COMPONENT_REG_BLOCK_SIZE);
> +	if (!comp_reg_mapped)
> +		return 0;
> +
> +	cap_hdr_addr = comp_reg_mapped;
> +	cap_hdr = readl(cap_hdr_addr);
> +	for (cap_ndx = 0;
> +	     cap_ndx < FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_hdr);
> +	     cap_ndx++) {
> +		ras_cap_hdr = readl(cap_hdr_addr + cap_ndx*sizeof(u32));
> +
> +		if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) == CXL_CM_CAP_ID_RAS) {
> +			pr_debug("RAS cap header = %X @ %pa, cap_ndx = %d\n",
> +				 ras_cap_hdr, cap_hdr_addr, cap_ndx);
> +			break;
> +		}
> +	}
> +
> +	offset = CXL_CM_OFFSET + PCI_EXT_CAP_NEXT(ras_cap_hdr);
> +
> +	iounmap(comp_reg_mapped);
> +
> +	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) != CXL_CM_CAP_ID_RAS)
> +		return 0;
> +
> +	pr_debug("Found RAS capability @ %llX (%X)\n",
> +		 component_reg_phys + offset, *((u32 *)(comp_reg_mapped + offset)));
> +
> +	return component_reg_phys + offset;

For the RAS capability in the cxl_pci device this patch needs to be
reconciled with this effort:

https://lore.kernel.org/linux-cxl/166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com/

I think we will want RCD and VH RAS capability reporting to happen in
the same place, and that can not be cxl_pci because cxl_pci has no way
to find the RAS registers on its own. It needs the help from cxl_mem to
do the upstream cxl_port associtation first.

Given CXL switches will have their own RAS capabilities to report it
feels like the cxl_port driver is where all of this should be
centralized.


> +}
> +
> +static int cxl_setup_dport_ras(struct cxl_memdev *cxlmd, resource_size_t resource)
> +{
> +	struct cxl_register_map *map = &cxlmd->cxlds->ras_map;
> +	struct pci_dev *pdev = to_pci_dev(&cxlmd->dev);
> +
> +	if (!resource) {
> +		pr_err("%s():%d: RAS resource ptr is NULL\n", __func__, __LINE__);
> +		return  -EINVAL;
> +	}
> +
> +	map->base = devm_cxl_iomap_block(&pdev->dev, resource, CXL_CM_CAP_SIZE_RAS);
> +	if (!map->base)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void cxl_pci_ras_init(struct cxl_memdev *cxlmd)
> +{
> +	resource_size_t cap;
> +
> +	/*
> +	 * TODO - CXL2.0 will need change to support PCI config space.
> +	 */
> +	if (!is_rcd(cxlmd))
> +		return;
> +
> +	cap = cxl_get_dport_ras_base(cxlmd);
> +	cxl_setup_dport_ras(cxlmd, cap);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_ras_init, CXL);
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> -- 
> 2.34.1
> 


