Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006DA73EBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjFZUWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFZUWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:22:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13AB8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687810954; x=1719346954;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8l6FjuAue5jdxJaNt3fBPls3n8BMPp3fy1j7UqRXSPk=;
  b=htFyFvKXWrcQ7tet+6PeRF62zd0hNExWTuadQoM3bxyQZR4te8tAGAwW
   m2pSYlhNQxgunG+XTn5DEcmC9u9gjE+M96N8khEqRAt6NMYePJtTHszQL
   eNdPOXnkJsv4fZWa3Ru58/TySqO127KjYGxaq8xV6usoFh4yhUIj0qAHk
   l7MdkY9k207HLZ0IjwEQEgiH33TDghpoNEeBYrDNoHPHq8qUoBPvE+CQl
   f1tgemPO56P00viNYH6dBFsGhVhl62rXiQoi1/B2Jzm3JHEi/fNreGwbh
   p8iCfXGH48IDNd+2a0uqtI+NLCI96sUQLlkcM1w9xSCKhg09NjO8kLTVK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="425044167"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="425044167"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 13:22:30 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="751288161"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="751288161"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 26 Jun 2023 13:22:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 13:22:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 13:22:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 13:22:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 13:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhqUIw8ALL/3TxsMrBPVPZIxe7RqcRd26Oy8ykFqa+uDtVvBG5lk5aagQku/qkzQuOULp1EPSo7/m35tlFOpb44U/HjqOMbe0zB75Tv31yhbZ9ID7I7RKatQP4OlrS/inpeNuJJwzrdAf6sJrhPftR+p+a0bYQdLIpllsjIBLLf3G189y2TkDScL0qSXA4CXSfolTlojt0Nfx2fK7Y5rabVuWneuEbF3+ULiFdhUkRiO5Ac91cWwPQnuCj1nkZ87pNzP6rx44XNzyfGGz2BU+QsMKUgz6J0O7EwDlTuDNvo9UovIAUZWxQqyobEymy//z2EeVJPs/n1XxoYiQ7xBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QN7Vqpk8PLuxajH0fWq3QocsuFGBL2NXlAd89bHrqA=;
 b=Q8d4zAtcGry3OJqpNUm7WRrc2SdFuXwASgxlNZZ4Xg68KWw4Li+QM0kRvZQgIn7rQhwAbBBKC3f7EdO9dQtmnuDZK6PNzEPq9cEtHGU7fD9bwFPOX61cvVXym7FCYqPAo801W9t1EKMr2Or3Y/HvocdGM9gRPhFglmUJU8yQifad0rZ5znG3aDQWhqQ7J27drbnj/sVqAOVDb2WmtaF1R1yvFJfsum0YwgL4U1dJWTAglVZvyW5+czi/d983R3f8TYbGiqrqbrxMYDm40Lmp6UF6snxtBqLN/+T5bpsXMt1x8caBWaqiFCzBEua3DpVefbZrJNoXq6O3lSXI4nKihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 20:22:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 20:22:28 +0000
Date:   Mon, 26 Jun 2023 13:22:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        "Deepak R Varma" <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH] drivers/target: Call page_address() on page acquired
 with GFP_KERNEL flag
Message-ID: <6499f37e43ec9_75179294c3@iweiny-mobl.notmuch>
References: <20230614164454.GA390511@sumitra.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230614164454.GA390511@sumitra.com>
X-ClientProxiedBy: SJ0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 715165c0-74d7-4eda-3311-08db76830fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUxe5OHsMWb2DIBAnI+LyFxli9Tzif2qtDNZoECrQzhUTDIAL48zzFYjWZLtfSvUq6kyq6LhByoHxSkSU/hCIIbIULKQSLPJTDVOAQgwNUtCiKpuqoUvHIinwdztAPxSazAnwLF4xSkEYUPsqKgPf33wOkC7m39pGwLFhZZoME8B94k+BARkrTjUxc+up0lUOmJEQUOb9AJnCmhsgW4gbdYPkhCTlAyrIOdHeQaT9V3Un7N1qexJCUcWcOL75r9UOvBalgXORBLAMbFU7ZwpBR0ZuSs1ozP2L8J53KqlD3TW/5OqeqjtOY+VKTvDsXUvgajXN3ZXPwOMJ6TsVCHNrO5gwUCOlwNJ/pcbtHkzm+DkGymj0CZfv3dPrPwh17Fc/po5RBvYpt+cXNoCGmRpl/vKodWTNhy0YU5uh/VLekQN+4IQen38K27I3ZrMrEH521pCSvs4al09Ot9uMc+YVEd84BWr6WHc8faizi7NIuGC6wfh7eSIZt/C/YZBGcmAYP07/9z6M/M74lvih27Q0Rnpc7nBjNId6/9inictBkT/QgWB9uzs7FociaM+M05j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(4744005)(2906002)(6666004)(6486002)(38100700002)(83380400001)(82960400001)(26005)(9686003)(6512007)(186003)(110136005)(41300700001)(54906003)(86362001)(478600001)(66476007)(66556008)(4326008)(66946007)(316002)(6506007)(5660300002)(44832011)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vK5HQ61gsk7888jyU6L/T4rH0U0Ll+M1fyMFoF+nK5zAJgMfj3mWl9Mx+3VS?=
 =?us-ascii?Q?28nsH6DlnQMneGQlADpRvRFssJNKTqJT2MlHxsZa+RdmiX/x6LiwFSWIPzeC?=
 =?us-ascii?Q?NDlUbjIeN9GsXK/yrPMYkQBaQOylPJKsYk9STbFDf33/AMBhQWVv3Bh4xfBU?=
 =?us-ascii?Q?P3cUGjuYWEvUyHZ2DyFWSCpqGzk9iweE4LbJpf1l71AnKMsXwXbwW0yzWPx5?=
 =?us-ascii?Q?MKMdKQnI4nN9htzjl/2JhkNOLvNQTj13qLLJAfKkqE/yzWayYCJrsaRKNDls?=
 =?us-ascii?Q?O5jSOKF7azDTIolkrukb/Y8pIiTs6VXWZqbA3jCCcUxQikvowSZmDcqCy56I?=
 =?us-ascii?Q?+VdZJsLk2QJtOp995rqH3UAk4FhStry0WBeU69mQJ8ZewRgvHa7bd8eO4ECz?=
 =?us-ascii?Q?odOOrqC3trPipgmeVcPCZPBKyDkvlyQJ93iaFAn/P14ItxmyVzr0qxrITlKH?=
 =?us-ascii?Q?7kYEoKAgfAhYALRBrqk4tFHX8pLKmIY5tZ0nvWoOvpngCybvC4MFAIn1ZXjH?=
 =?us-ascii?Q?WkPPYGbH9AqzkMAnOAswzHEKgXFzjvHwBaYmymOEVxwzpGRs+8nSrYIQ9kTJ?=
 =?us-ascii?Q?9wiLeE8OI59wqEOMwOwKNNzFYwA7XkNhE5BY539cf4a/k/Js4DWCYzHbTv4A?=
 =?us-ascii?Q?RvXtzfqZCIfKiXy1jFckJ5pzBJgE/QtoZDAv8ipZdBxEN6Rewy6HECGckIXT?=
 =?us-ascii?Q?dBQrZT4apMuLAVXPoWxtTY3yDTspQJqxThqcRJSN8RcRVrRQyS2C/Lj8H5fy?=
 =?us-ascii?Q?EFxh/CenNp6hi++KeIf+5RUAi7A37P9NX0U0IzByUhmK4yg9Q8QnuOi9IJtt?=
 =?us-ascii?Q?RYDq0LHTqRNykfe1DsDLS2KBnoJmIZdRJBWOsHOZ5wkUDRwFiiemWvNtrzw3?=
 =?us-ascii?Q?Qi8idKHXd/9PCcKI+6Gn68reyycG6qNTS32J5GcZltc7xW5LvVWKCDMWbotk?=
 =?us-ascii?Q?uhvwlaoXmBwALbfSMoumef4gS2jdwS/7g5UqDfysvsh8wcOBbPuqQYTbxc5a?=
 =?us-ascii?Q?SRNEtD/hRKfKKas49ZuqSkwfuINlbZVhYSPrf8RPL0ppQl2hmz4O/o5l2a1l?=
 =?us-ascii?Q?7Wm+zSu0XBazvjiVz2+//+0pPyNthWmziC+udZrUmnJjUiTmW26mgveE72PR?=
 =?us-ascii?Q?eE96ZCqbGW7GR7qcM86Y/+OUnt8NPRp2IwUR6cXU6naeddq78BmZY2DtAZFj?=
 =?us-ascii?Q?ChWqdxu5Y2JWA1CY1s+AiTIgAhqsFF/Bpuh4GutNXDRmj8Lg8p9UnNyf4G+G?=
 =?us-ascii?Q?svmHm2ni8R38tfzodzPrff9E0g/XHQbik8N0WAOA0pwe0PbOLDVkFxTjsIOi?=
 =?us-ascii?Q?lGoFpLgZkUE+XEtnYalCb+sg1QUKMIb1K4iJYAD9yo2/zYQry5Lq6CIbqUPV?=
 =?us-ascii?Q?a6NkmMhO70GY3j1nMCMcGiLwyt9INeSfEquHqYJLhH9nYli2GdkvWzb3jLuB?=
 =?us-ascii?Q?qdBUM4Tu9NQ1tNPASz5/5QQheq4rOPoPH090aSeWEDD4qbswV7rInKMZxKCp?=
 =?us-ascii?Q?NkDIzU2ZP4SAFm71yiHq/KbYWFM2lvqdBsxl9XZo8/tWKMFZnX2NJMVEXwhX?=
 =?us-ascii?Q?H6IhR7TGLzFdUUmqEvy+r+mqJCw0kQ+ZvqF+X+yu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 715165c0-74d7-4eda-3311-08db76830fc0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 20:22:28.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9047QTJf67Ns5SKMSHSgkKrxnPa+SE5czCWp2oerK2eGbxsiirEGZzjLsuse8EO/g/ub2cH7qg6GTyY4VCsfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
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

Sumitra Sharma wrote:
> rd_allocate_sgl_table() acquires a page with alloc_pages(GFP_KERNEL, 0).
> Pages allocated with GFP_KERNEL cannot come from Highmem. This is why
> there is no need to call kmap() on them.
> 
> Therefore, use a plain page_address() on that page.
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>

LGTM:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/target/target_core_rd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
> index 6648c1c90e19..d8ea6aff39a2 100644
> --- a/drivers/target/target_core_rd.c
> +++ b/drivers/target/target_core_rd.c
> @@ -159,9 +159,8 @@ static int rd_allocate_sgl_table(struct rd_dev *rd_dev, struct rd_dev_sg_table *
>  			sg_assign_page(&sg[j], pg);
>  			sg[j].length = PAGE_SIZE;
>  
> -			p = kmap(pg);
> +			p = page_address(pg);
>  			memset(p, init_payload, PAGE_SIZE);
> -			kunmap(pg);
>  		}
>  
>  		page_offset += sg_per_table;
> -- 
> 2.25.1
> 


