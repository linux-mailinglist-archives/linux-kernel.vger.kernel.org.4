Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFF642017
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiLDWmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLDWm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:42:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9293F13D74;
        Sun,  4 Dec 2022 14:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670193746; x=1701729746;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a/GBs77JumAtLKC1QgT/dq4nHC9S1bkcVE4XxC3BDb8=;
  b=DsCX6vfc9KJMeD/Ooadciw2FU9VY+fUF6GP6Np5bhDqO5fnecQJQjftg
   IL7hLpWp2nCbA2JKfir6h2WRgcc6HD+7qmAhBMOYGzAKh0hbBw5ICa60b
   WT1j8LoVLcuxOWGuqNAvdkM8zkZFT6+xMJJ7PrT1PzvnkLjTUM/hKpMJu
   mJNrHrXlwUt6Ju6hZ9n2Qw/a71kLsrgoW67zlnnU5uWVr1IIG4ujwI2sT
   +2hsSmXgyVRBgd/cSY/05wSagliZB4K12GC+aWkua6XXxGryNZ23ag5Td
   qNna4dpP5+Vog8D4ydHR6zDhZx/knStWIv7M9VlupAwcvQN9bzCg2LCu3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316252473"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316252473"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 14:42:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="819990665"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="819990665"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2022 14:42:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 4 Dec 2022 14:42:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 4 Dec 2022 14:42:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 4 Dec 2022 14:42:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 4 Dec 2022 14:42:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acyVYHEMx+h/TDGH5lhkQ059ex9LGVjxPw1joWjoTgMlpMRUjHj8nJPtm4Ob/toWoYakbQ5bsXvNwgB+m45cI8XJZ/ueuBPSruntvS8wte42bSTCFnGueFIIUqjMyWQUgwVo4tWcs/bSiF5UiUagp6bhhaFyNxqZUu11cFBuqiw0ZIFZ/Od3rT6jHOPgJBuaJILOhBaJsKDy3F83BP4HChoSIBcEZrP61UpOGPH8uuVd7shKShIoKuPezupx+V2CVgGnJjc03wHSN+K1AmD9dXWGm0Xl/5D/aNCuLqZZUBafyJVskuu3o796HdjNvq6h+rlRKhzrHJTto+yAm42Zfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lHWzgXG2uHPPIOk0vSFCzmtlJKXXtnOI9kma5ET0p4=;
 b=C+0f8v8+p/lbBwKBhlkN869LglAvqg8LgcxG3NZAWOiYGPTCtl4cALKoYQvN+WIk3eLmNPQbDzq8W55xCv9QpFzT+kkYx9t/lfgTL8JIQyzI2uWb4wVA7IgyqXJ2HXJ+IZhgshyeeFQpuho/NLJ0kKD1dovLhu2bGS1ezLaZcPTrCjc16Y4ldmP8Ne0kyCobIGd2NQ2oEZMconxOj7Tm2wZt+Qt7OZALnVY3GvtmLeRTUU9JQpOKdnZmXdcS2x0PG4ZxgaYfMsnzcXzcp+wM3LJP9wlUMM49BmuAIk/Eo9eamNQSkKQ+XFSniyzOPxJzUMHZmhYGtyi6k9iXzzyr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB5565.namprd11.prod.outlook.com
 (2603:10b6:5:39e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Sun, 4 Dec
 2022 22:42:22 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 22:42:21 +0000
Date:   Sun, 4 Dec 2022 14:42:10 -0800
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
Subject: RE: [PATCH v3 1/6] trace, cxl: Introduce a TRACE_EVENT for CXL
 poison records
Message-ID: <638d224226ebf_c957294fa@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1668115235.git.alison.schofield@intel.com>
 <5746274c905f57f117987c8268c9f6dc9bd33337.1668115235.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5746274c905f57f117987c8268c9f6dc9bd33337.1668115235.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM4PR11MB5565:EE_
X-MS-Office365-Filtering-Correlation-Id: d79584b9-ecdd-4fdb-33db-08dad648ce41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsr6+OlRclF2Ix3UcqwCH0EGFrJvB2jxVDPQxzrtWaz7QVUjRSK3tP3p26UKhD9lBv9U7w+DCswZCbqYPtHofRNgAHfto3lwSizZ3oMBZxB68GaD7WTJhiyuue1RDtN36cMBhxZbQBhpooaatzRhUUHYkKAgD4S18sfBR+Ngpl0KeMo+7b9wnvwBD4uA363K/c9g/WqV0epQaPlPk5n1YceOBPke42HZJJd95ZpXeK6cts6xs/4y9YAme7jv3YeRXnJZdXwMPyks/e0n6NcOMwzKaNQ8czThYKz+wEXFEQAtrmOT9c5ITC1iC7zavXaBNZB79jgPsVMtRwGJv6m7+f9QtJ4ox21eQ6UMS5QKPKM/wSsTZK9oN9wrymAswAgx10V/VoTk2VjQBn2FB8R4UlbEFTHHuEEwH6lo6WLMfsvaC7K3DoO8Ny319yaBKhQfDP6h3qUcWonCoGzaV1cajoBArFRs0N4Jj0O4U0xlHqlN6xSF1zN7eDT9jchSTqZyEPiAx+6TyvfLlqCvY8UkeZP7D3FO+MhI5J7wbdFr8x0zpzstUmlhsgQDeesoqi60jHCx4jcoc0oGOkDJ34pSd/AmefGHPWLv7KRXMR49SVr9GdmwTbSNetooK0HRUOXf1HfNwvPtvPv6VzQllWptAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199015)(83380400001)(186003)(6512007)(9686003)(41300700001)(8936002)(38100700002)(82960400001)(26005)(5660300002)(110136005)(6506007)(4326008)(6486002)(2906002)(6666004)(316002)(478600001)(86362001)(66946007)(66476007)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZfvwuqLcuGeujnWKPqUMdbDSTIcydqfS71NTn05xnRX7eXbkVYwxRcDgNYZ?=
 =?us-ascii?Q?SEe2iSARqPUEzuRgc/NcyaHxSQjXX1sPJFqDl8GPOIQdx0QgzPIlwFmR+3qk?=
 =?us-ascii?Q?5o7j8bildrPM5NGDq0nMvePIxY/3qSlAiLct9bphfqPyWYX+I4QUlnHnVe+o?=
 =?us-ascii?Q?n9Hkx2x1d+aVn4AGnDmIILw8szEXnPliTYt4VzqkZFJNRPt6pxBEHlJFDJit?=
 =?us-ascii?Q?nuaj66IWhT3RsMxjALjVZegRDtASdz6tDcrdbW9LcVdDpHYHhlra/3cCEaMF?=
 =?us-ascii?Q?C1PeP8SXirMJl84ENL5EZhYeUYHo/1QfYSSviq3v1c7duj8JtSMPKiZSZW4r?=
 =?us-ascii?Q?qe22GE9pOIcgTDN0Ik5bPFmxZRY1Hcyej/DfCFgHhhiz6gr4zYAPo9N+detn?=
 =?us-ascii?Q?gatXboDk2oPj5OVlEmUiC6UTqR7vc8xadvisodk5M9bQDknNvBfm+GbTeUaa?=
 =?us-ascii?Q?CKVJ1IR++kPy28x8NfATiT/dU1hXZxqjdMQbDsQeQKNN79OJ8renzno9Wrip?=
 =?us-ascii?Q?OLYGrmiFIA37Hp43S1qkqkWposcd7p5HC9/xRerMqxWebsLEBPM3hBqtagVh?=
 =?us-ascii?Q?f2HWkNwdjkCx1mFcGqx3uf13Ar2wVvchxmKekR4fJ1m6qhbmQ78PL5Gxxs43?=
 =?us-ascii?Q?mJOiu7bmZ0lcNp8iJ1Tn0Aqgji4AzMiYhBZ8gnNp7R3TshjJ7t3pJQ5vzBTF?=
 =?us-ascii?Q?Bcbsw6pKifyPRFhGtc76R9IOHOzsrFAJZjIFqi7/nOckiuC6b3/FrudcWrJa?=
 =?us-ascii?Q?2BGW14mzvCiLeF2hnTmAG+eelIWN28WTddtOA9RNiq5umKCQljyofguVKM+/?=
 =?us-ascii?Q?+gVP5kiIwO0xJjR4+xbCCjVo02LRiwuwKCjzY57UokvdTa5LLnTtqIwdpEEZ?=
 =?us-ascii?Q?gQe+nh67hrEfFDFkYTFRmn8JWqtBgrEpJDhgKmLzwNx3WItGr6YJxY9OGwMl?=
 =?us-ascii?Q?vsQ5GJ4UHVwV2YVOmLACCZDKNB6LQUv0cpo/2AYrlvOl8E2fw6HUmajw/EmP?=
 =?us-ascii?Q?N+gDbzcC/z35Oh6IkEo86PiDPIA3TC7D7DiijwjZl4gF7JZjSDImuQHetfCN?=
 =?us-ascii?Q?Rb215WslpL94BVKtf0HzubYUP78/1IaHSiVtE4D8nsQm0PTeOvZTlvLqjcB4?=
 =?us-ascii?Q?+iIcBe3kfrgC4rVUMMHrA0A6KnCHqIBl6nbvWIrNLDa7fcdne0oZp3muB7Hw?=
 =?us-ascii?Q?WD4sDr02FsC0FhxA0LUoPnjl/vD5RWrIWS3fvHu/3K2ob6rlfKYwsMXngzXL?=
 =?us-ascii?Q?eod846CK6j/4xzHuSD2WuRalmQXYgITVWmgKAUZ7uQmWLpFWHf2n+E5DhPbv?=
 =?us-ascii?Q?4Ie21FrfZuoyOUELZKDkBpBzFkhT4QxvtWZPr1fbEAnTcH1W/XfnrIyiBblg?=
 =?us-ascii?Q?VzQNcFEgZ1p0TcxxyIZ2MPdwEZQ8gFJttAp+Bb01AG+6sQotx6US3zslkETo?=
 =?us-ascii?Q?dlmik+SFw2qUfAFPGPbUPmAKj5xh6G2Xr4Q8BmvaiUg2LGGJYXX0g102hHMM?=
 =?us-ascii?Q?98aJKoUnRZPpnh22J2rJWnEHwsO3/4pmForpj0w42Kj+Zs6Z7ikMoBmqZGSi?=
 =?us-ascii?Q?qHdgsdEbf8FtgGL6Ip68eCa656EEOn31kwFScMWwDgwTeVdpHGHfaU46LLBU?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d79584b9-ecdd-4fdb-33db-08dad648ce41
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 22:42:21.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jBEZ9dHEEnXXXs7eV9dYAgcXVPUvjQesQp6YUpUqjqYm1lJEefqB/2U2L/SMEvccmlp42la4MPiU+DE28OXqckps2A8VWX4ZY5+AvxiQyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices may support the retrieval of a device poison list.
> Introduce a trace event that the CXL subsystem can use to log
> the poison error records.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/cxlmem.h       | 14 +++++++
>  include/trace/events/cxl.h | 80 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 include/trace/events/cxl.h
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..669868cc1553 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -347,6 +347,20 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +/* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
> +
> +/* Get Poison List: Payload out flags */
> +#define CXL_POISON_FLAG_MORE            BIT(0)
> +#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
> +#define CXL_POISON_FLAG_SCANNING        BIT(2)
> +
> +/* Get Poison List: Poison Source */
> +#define CXL_POISON_SOURCE_UNKNOWN	0
> +#define CXL_POISON_SOURCE_EXTERNAL	1
> +#define CXL_POISON_SOURCE_INTERNAL	2
> +#define CXL_POISON_SOURCE_INJECTED	3
> +#define CXL_POISON_SOURCE_VENDOR	7
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> new file mode 100644
> index 000000000000..03428125573f
> --- /dev/null
> +++ b/include/trace/events/cxl.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl
> +
> +#if !defined(_CXL_TRACE_H) ||  defined(TRACE_HEADER_MULTI_READ)
> +#define _CXL_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +#include <cxlmem.h>
> +
> +#define __show_poison_source(source)                          \
> +	__print_symbolic(source,                              \
> +		{ CXL_POISON_SOURCE_UNKNOWN,   "Unknown"  },  \
> +		{ CXL_POISON_SOURCE_EXTERNAL,  "External" },  \
> +		{ CXL_POISON_SOURCE_INTERNAL,  "Internal" },  \
> +		{ CXL_POISON_SOURCE_INJECTED,  "Injected" },  \
> +		{ CXL_POISON_SOURCE_VENDOR,    "Vendor"   })
> +
> +#define show_poison_source(source)			     \
> +	(((source > CXL_POISON_SOURCE_INJECTED) &&	     \
> +	 (source != CXL_POISON_SOURCE_VENDOR)) ? "Reserved"  \
> +	 : __show_poison_source(source))
> +
> +#define show_poison_flags(flags)                             \
> +	__print_flags(flags, "|",                            \
> +		{ CXL_POISON_FLAG_MORE,      "More"     },   \
> +		{ CXL_POISON_FLAG_OVERFLOW,  "Overflow"  },  \
> +		{ CXL_POISON_FLAG_SCANNING,  "Scanning"  })
> +
> +TRACE_EVENT(cxl_poison,
> +
> +	    TP_PROTO(const char *memdev, const char *pcidev, const char *region,

Same feedback as on the Events patch, make these arguments a 'struct
device *', 'struct pci_dev *', and 'struct cxl_region *' to maximize
type-safety. Otherwise you could do something like pass "region0",
"mem1", and "0000:64:09.0" in the wrong order and the compiler cannot
help prevent that.

> +		     const uuid_t *uuid, u64 dpa, u32 length, u8 source,
> +		     u8 flags, u64 overflow_t),
> +
> +	    TP_ARGS(memdev, pcidev, region, uuid, dpa, length, source,
> +		    flags, overflow_t),
> +
> +	    TP_STRUCT__entry(
> +		__string(memdev, memdev)
> +		__string(pcidev, pcidev)
> +		__string(region, region ? region : "")
> +		__array(char, uuid, 16)
> +		__field(u64, dpa)
> +		__field(u32, length)
> +		__field(u8, source)
> +		__field(u8, flags)
> +		__field(u64, overflow_t)
> +	    ),
> +
> +	    TP_fast_assign(
> +		__assign_str(memdev, memdev);
> +		__assign_str(pcidev, pcidev);
> +		__assign_str(region, region ? region : "");
> +		if (uuid)
> +			memcpy(__entry->uuid, uuid, 16);
> +		__entry->dpa = dpa;
> +		__entry->length = length;
> +		__entry->source = source;
> +		__entry->flags = flags;
> +		__entry->overflow_t = overflow_t;
> +	    ),
> +
> +	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> +		__get_str(memdev),
> +		__get_str(pcidev),
> +		__get_str(region),
> +		__entry->uuid,
> +		__entry->dpa,
> +		__entry->length,
> +		show_poison_source(__entry->source),
> +		show_poison_flags(__entry->flags),
> +		__entry->overflow_t)
> +);
> +#endif /* _CXL_TRACE_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cxl
> +#include <trace/define_trace.h>
> -- 
> 2.37.3
> 


