Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC0264522D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLGClw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLGClu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:41:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436AC4C27E;
        Tue,  6 Dec 2022 18:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670380909; x=1701916909;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vKs0Lhw/Qax9LYiO8XSKvo1T76NEHkriRpbIv78SH3Q=;
  b=RbtpvT+KGTx7LmXEqPsESxhMSANjRXzEtJlmCoMIF1gHIHKksmRv12Ju
   Foa8RQQf2AX3IZENwb+h1rcUmPGLuR9b4yvK5q0x/gLrx9jp8RFIU1vYY
   e+g9a5zaHqDmkQpJNXCj9uDDaxHnHEbTCRUux3SetaC/cIZTddI8/TtT8
   T8JG1dMKVEf0SVztaIoHWmn55LLlXDMnlm37M3RQZtFI3fI0PtdGG+bE+
   eFZbj03teqVfntkVVxBw6w1IP5RLxWY1kSN/U/pxBZPpdGc5oXq0kH8Dt
   UkZr54J9MYF1ocW6NC7E6IDqY3KXjdgP3jumiFQmNn1QtwiDq3JGGJtO3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="403059272"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="403059272"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 18:41:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="820802121"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="820802121"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2022 18:41:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 18:41:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 18:41:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 18:41:43 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 18:41:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsReXechs0igWmMyzyEksZewvERJZ748gii0PYduju1yPCqg/X9t8Bv2VwGhavq9JNmLg8XL3yjUn258nPcI1eaPRs/w9hhMotDMNcp9VjK6VJKR80WJutYm4ER9yJazGkRPFGV/DqUnhCysoREn7AUIMZE9bbclKRRpwKDN6lkxgx0fp65bCQtHfrKYZeNimTzSTePO4xirfFutmxIbw2tzYywlrV4mfzsyyh4tfm9MfE7F+5djGI9NHyphPGiepDmohVegcBmwy7Gjj70gvKCItabKfXTZmndp4kClWVHuL+C0RyWk3Yhr/NUvpoHjNoL+4BMEX0ohud9pu7S0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR6jZwDcrHNzZrgvWwG9wPm6/Rh/5ZKgQJhhGvHTrAY=;
 b=ClXxzHz8qgGqFzsqHb7SGQaCgaRikpLyd3kzmskOIp0jzx0RNeCQ/Ikrxf9BXXgLpuAIsKrf7BdYcFzAgxEIeNAl3IIsMhRXyR5TeuYfrG94nceSdFMgqL0/rD8+DfJ+b6q6yaqxlSA0HxVDU7sb9FH0q7tcGSXCpPkD75CpWADn8Dc1TO393FlgCULbg2TZuujypK79DrwsFKMx4n5+YoNVqZvMKOkzcSal0CL+RjRgwNTKu691E4B6YrCETgTv93uCN3cpRctGmTMSTndYLwah/ENkny5Q/8k3xPHVNipuNbGeQ5KKnpXH+BkJQSjwio0DX0x3RGxzJZb1oXr0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS0PR11MB6496.namprd11.prod.outlook.com
 (2603:10b6:8:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 02:41:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 02:41:40 +0000
Date:   Tue, 6 Dec 2022 18:41:34 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <638ffd5eaa3a7_c95729426@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1668115235.git.alison.schofield@intel.com>
 <46c7c7339224744fce424b196da3e5566effec17.1668115235.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <46c7c7339224744fce424b196da3e5566effec17.1668115235.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS0PR11MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 692f7966-70c6-4aa3-c0b5-08dad7fc90c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMJV4xeKq9Dibbf0NnkCDBP5LCObkA3TNBD9xFd7R5TH3LF59vmZh7h6/IZvxJMRjTDfj6BeQBnvY934dX5zVCDRZCIXNs75Kn81lnTZWqBo06XGfd2J7hFmTDeIW0w+2E04vhyVcgS0AwQq/NixfhUrA+MsqCyCGPOP7x4FXFbYzoRY+1kPMfNm2BYigdDkcHLllwAE4oovK6BuqODNH3jpDG8rDn4obp7bl1tOXf/xyo3kXnm9w36SdFiUZ8YkfyXnBDQczTPrzqiOTf/9RujsoNXLNEeAwO8cwihspk1NcRc0n5VlNJ1axm7DqspelqKgSljqa4JKUuCQHjx2d3jMJxSMGwtKTnuAP3NMP2ov7wyL7gVv5vc+iBpPxY4CE77x/9Fpzisj1A7zlIbefNwWoF8W8yMvMF8Tde8XozQe6keHSYKM5ftDrdQ18apK1OIXpYMBEXWshC6I2KDv68WH23yj+FJnUOASefqSYT1N8yS7n41edWpVCoasZIcUxK/fDTm8D4PVifSnEu4KeEuvxyL/oFWbaQb9cBHghVlQ6uDBIn/HLZdSp45w4LoN9O3xs0eWFyeK1/ZS+jWjqKOPMj5Tne1icwZThXdONSqiqKsAovvYG3jZ7q4J3/kpO0HRvSbe8GjQ1vbIisF2Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(186003)(110136005)(26005)(316002)(6506007)(38100700002)(83380400001)(6666004)(4326008)(8676002)(15650500001)(6486002)(2906002)(82960400001)(478600001)(41300700001)(66476007)(9686003)(66946007)(6512007)(66556008)(8936002)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wBH1uQnPW4qu9wPlcU4fp+/5pbBhOGAQlrpnvaZKsmwWpBmdlsqDjrDOnjT?=
 =?us-ascii?Q?07chTEHGyQN7GdLqe9f/yzbleMvLuBhIyue4aT1cw8ETHV332xscSmy06xea?=
 =?us-ascii?Q?oHng01BrWvDkHp257cUtP4/Aan2fRdmsn65OahUcjv2SSfI3ORm1zxQu4ccJ?=
 =?us-ascii?Q?80SsKt5Hevm/zC3NYQ3Ch/D+W85QO4JvIQEHcdCao+raG8TD/RJbs13BmBRz?=
 =?us-ascii?Q?SzR5Tk9H5a1x0t3rY2hSOP6wG1FjAhMcdeoJiqOKQ7iKoRXUiSLeY2OuhNjp?=
 =?us-ascii?Q?8erh5KV8NpNM55Z73hL2dcTmATRuhyR7DIU0D8izMK8pi66j1s4GtiahxqhK?=
 =?us-ascii?Q?V9fSF4hThNcFHzHt+lz/t8jF7WQI2C24CYMMO9Fabs1Bhj3bVGOYJK7fOpmv?=
 =?us-ascii?Q?WxvTbeLZUzD2NwTs8MeGaCXoRwUS9bQa0yJCAYDzHM0JoD7idV/o0D4+dSq6?=
 =?us-ascii?Q?RckdnSP8S6rGeNfo8+vIYSwbVAuRBAfk4Wl+v12EGNz4j72BtvfSP1G3zWyj?=
 =?us-ascii?Q?Tq1YexyphfRjKIcOFAGtxONeMVEVFh7GTkUqaszyjwldYM6UHG9iqpavu6P1?=
 =?us-ascii?Q?VBvIlFiQKQu3NckPaGN3Fd2zj6B/DGavFwZzEwEMqIwxcW4hrXhDD4xa66Ra?=
 =?us-ascii?Q?MlWupzphCu+CZNP31CXhgVS3tz0M1QEzzB9oC3spqD7lqxm/D+bKx/Wrsgjr?=
 =?us-ascii?Q?i01sRdBg9kPfFpPbbHV1CpqXle1uadqnrgpHls+a4Ac4po++WoTTtA+0YfZw?=
 =?us-ascii?Q?Fx6yfFKobw8DuZ1Em1ydvavImalmz/TXPAhn9wKfeP6/7yEHAwVgaMYCivDh?=
 =?us-ascii?Q?OHK4z7N8WJd5AU46ASdujg58KyUpoKLPCALMqELA7RpcXiTguFGCHcSLz7ND?=
 =?us-ascii?Q?d9B9gjaE6HgxLPbK5nubL+yWTOQ4dbcErQXnQDYD6Am4iBzh2MepNzEdgLLM?=
 =?us-ascii?Q?vq+sM410AIOzr1LBo3TEw8p8rHdYTasAlRH0bsCmtIfVBXIYlq/CgzoBH+Fs?=
 =?us-ascii?Q?rLbQ8K2ITWbG+rYECpTAgaaQSOhLt+BJKtZiAMkDdcUl0iSUF8lTQLCSuWRB?=
 =?us-ascii?Q?F/r+7rZxhshZZj5OPphXh0tSgnP12ud6wPIpa8K85F7Nw4ufEUMgSzFY1Dwe?=
 =?us-ascii?Q?R4k+wLuZWQxTbP9BYHYy417wyem/9yW4Pg6zRR6MpOjKn9EFx4LRaek/eeBI?=
 =?us-ascii?Q?3kF4W/+n4A+nqgUDDmUOejbTDuL3nlm67cQYk0j/UcUBS7tBX3e5G5l+PULh?=
 =?us-ascii?Q?9XCs+poxje3aYq1JFh3XXkWrkV0NQ7JR00cFsdB5i9oPwxb0jcT6p6Q4w+FZ?=
 =?us-ascii?Q?n659rE8LX4aHsw0hJm+rLjhjhl/hOGjw2mmvOwFvEOiF3CnRA3jC1PaKdemZ?=
 =?us-ascii?Q?Bg1dSagkmporRpn5Pfn27MwLGOXW4wAJUeqQZnJeJnd7TdXTXfRuaxjYtq9R?=
 =?us-ascii?Q?XKXiqlrWUg5df6ROKADofZF/J9NQLK7wCKUcKrNpua0EEtHnqiV28lk3Em3h?=
 =?us-ascii?Q?QI/UCt9V/ykQqTtSwgAOEXNgMEgnyIII1xexiC1fOYArOgwx2/3uNxprQ4Bg?=
 =?us-ascii?Q?K7pEs4c1iWlQsPUha1Kt/Lf0UwV3OIVy0+dqxHN0IkoWv755gG3l6ftSC/cY?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 692f7966-70c6-4aa3-c0b5-08dad7fc90c6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 02:41:40.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyKPbdiGnizU5F3VGxCAOX0HE3VbKJED0Luv3Xi6hzjF+8y2FjDsLtUOe8vTM7yP6cf25rdklt3/aAw1fw8kKoc6DPitu3+oxLHQa76fASM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices maintain a list of locations that are poisoned or result
> in poison if the addresses are accessed by the host.
> 
> Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> list as a set of  Media Error Records that include the source of the
> error, the starting device physical address and length. The length is
> the number of adjacent DPAs in the record and is in units of 64 bytes.
> 
> Retrieve the list and log each Media Error Record as a trace event of
> type 'cxl_poison'.
> 
> When the poison list is requested by region, include the region name
> and uuid in the trace event.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 81 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 37 +++++++++++++++++++
>  2 files changed, 118 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0c90f13870a4..88f034e97812 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -9,6 +9,9 @@
>  
>  #include "core.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/cxl.h>
> +
>  static bool cxl_raw_allow_all;
>  
>  /**
> @@ -752,6 +755,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  {
>  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>  	struct cxl_mbox_identify id;
> +	__le32 val = 0;
>  	int rc;
>  
>  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
> @@ -771,6 +775,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
>  	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
>  
> +	memcpy(&val, id.poison_list_max_mer, 3);

I see Jonathan already commented on the need for get_unaligned_le24()
here, seconded.


> +	cxlds->poison_max = min_t(u32, le32_to_cpu(val), CXL_POISON_LIST_MAX);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> @@ -835,6 +842,79 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>  
> +static void cxl_trace_poison(struct cxl_mbox_poison_payload_out *po,
> +			     struct cxl_region *cxlr,
> +			     const char *memdev_name,
> +			     const char *pcidev_name)

Type-safety please. Pass a 'struct cxl_memdev *' and 'struct pci_dev *'.
Might need to be 'struct device *' instead of 'struct pci_dev *'
depending on if this needs to be called from cxl_test, but anything is
better than a non-specific string.

> +{
> +	const char *region_name = cxlr ? dev_name(&cxlr->dev) : NULL;

...and push this conversion into the trace point.

> +	struct cxl_region_params *p = cxlr ? &cxlr->params : NULL;
> +	uuid_t *uuid = p ? &p->uuid : NULL;
> +	u64 addr, dpa, overflow_t = 0;
> +	u8 source;
> +	u32 len;
> +
> +	if (po->flags & CXL_POISON_FLAG_OVERFLOW)
> +		overflow_t = le64_to_cpu(po->overflow_timestamp);
> +
> +	for (int i = 0; i < le16_to_cpu(po->count); i++) {
> +		len = le32_to_cpu(po->record[i].length) * CXL_POISON_LEN_MULT;
> +		addr = le64_to_cpu(po->record[i].address);
> +		source = addr & CXL_POISON_SOURCE_MASK;
> +		dpa = addr & CXL_POISON_START_MASK;
> +
> +		trace_cxl_poison(memdev_name, pcidev_name, region_name, uuid,
> +				 dpa, len, source, po->flags, overflow_t);
> +	}
> +}
> +
> +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> +		       struct cxl_region *cxlr)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	const char *memdev_name = dev_name(&cxlmd->dev);
> +	const char *pcidev_name = dev_name(cxlds->dev);
> +	struct cxl_mbox_poison_payload_out *po;
> +	struct cxl_mbox_poison_payload_in pi;
> +	int nr_records = 0;
> +	int rc;
> +
> +	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	if (!po)
> +		return -ENOMEM;
> +
> +	pi.offset = cpu_to_le64(offset);
> +	pi.length = cpu_to_le64(len);
> +
> +	rc = mutex_lock_interruptible(&cxlds->poison_list_mutex);

So I do not know what this mutex is protecting if there is an allocation
per cxl_mem_get_poison() invocation. Although I suspect that's somewhat
wasteful. Just allocate one buffer at the beginning of time and then use
the lock to protect that buffer.

Although, I wonder if this and Event handling should share locks and one
preallocated buffer? Otherwise I do think it is important for Events and
Poison handling to be able to make forward progress without needing to
allocate up to a megabyte of memory at runtime. The other payload_size
allocations are for one-off things that run at the beginning of time,
but Poison and Events run repeatedly.

> +	if (rc)
> +		goto out;
> +
> +	do {
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
> +				       sizeof(pi), po, cxlds->payload_size);
> +		if (rc)
> +			break;
> +
> +		if (trace_cxl_poison_enabled())
> +			cxl_trace_poison(po, cxlr, memdev_name, pcidev_name);
> +
> +		/* Protect against an uncleared _FLAG_MORE */
> +		nr_records = nr_records + le16_to_cpu(po->count);
> +		if (nr_records >= cxlds->poison_max) {
> +			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
> +				nr_records);
> +			break;
> +		}
> +	} while (po->flags & CXL_POISON_FLAG_MORE);
> +
> +	mutex_unlock(&cxlds->poison_list_mutex);
> +out:
> +	kvfree(po);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
> +
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  {
>  	struct cxl_dev_state *cxlds;
> @@ -846,6 +926,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	}
>  
>  	mutex_init(&cxlds->mbox_mutex);
> +	mutex_init(&cxlds->poison_list_mutex);
>  	cxlds->dev = dev;
>  
>  	return cxlds;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 669868cc1553..49d891347e39 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -192,6 +192,8 @@ struct cxl_endpoint_dvsec_info {
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @lsa_size: Size of Label Storage Area
>   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
> + * @poison_max: maximum media error records held in device cache
> + * @poison_list_mutex: Mutex to synchronize poison list retrieval
>   * @mbox_mutex: Mutex to synchronize mailbox access.
>   * @firmware_version: Firmware version for the memory device.
>   * @enabled_cmds: Hardware commands found enabled in CEL.
> @@ -224,6 +226,8 @@ struct cxl_dev_state {
>  
>  	size_t payload_size;
>  	size_t lsa_size;
> +	u32 poison_max;
> +	struct mutex poison_list_mutex;  /* Protect reads of poison list */
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> @@ -349,6 +353,37 @@ struct cxl_mbox_set_partition_info {
>  
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  
> +struct cxl_mbox_poison_payload_in {
> +	__le64 offset;
> +	__le64 length;
> +} __packed;
> +
> +struct cxl_mbox_poison_payload_out {
> +	u8 flags;
> +	u8 rsvd1;
> +	__le64 overflow_timestamp;
> +	__le16 count;
> +	u8 rsvd2[0x14];

Let's use decimal values for size.

> +	struct cxl_poison_record {
> +		__le64 address;
> +		__le32 length;
> +		__le32 rsvd;
> +	} __packed record[];
> +} __packed;
> +
> +/*
> + * Get Poison List address field encodes the starting
> + * address of poison, and the source of the poison.
> + */
> +#define CXL_POISON_START_MASK		GENMASK_ULL(63, 6)
> +#define CXL_POISON_SOURCE_MASK		GENMASK(2, 0)
> +
> +/* Get Poison List record length is in units of 64 bytes */
> +#define CXL_POISON_LEN_MULT	64
> +
> +/* Kernel defined maximum for a list of poison errors */
> +#define CXL_POISON_LIST_MAX	1024
> +
>  /* Get Poison List: Payload out flags */
>  #define CXL_POISON_FLAG_MORE            BIT(0)
>  #define CXL_POISON_FLAG_OVERFLOW        BIT(1)
> @@ -395,6 +430,8 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> +		       struct cxl_region *cxlr);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> -- 
> 2.37.3
> 


