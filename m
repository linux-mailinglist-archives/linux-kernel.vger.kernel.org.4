Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2F668C223
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBFPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjBFPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:48:06 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E171172F;
        Mon,  6 Feb 2023 07:47:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLglG1LHh9/YcRaUI0pwPTATLDH1qbM9RXC55kRGSJpCzBaFYOSkUucWz4QFiGdZk3u71rNG4Gl/s217fDl/OMqr1VCG6tYBkxlN9xm4HM1/a4o/bYdoI/Npls5ESEFG7LfwQb3wZkS0AI7mixeG5HAFv/BT4N2r8bql755A7okaIS8iLI4lAoZFWYY63EioVMHwygFq4xe2li9kmlvr14LKQy4vXHmD5SHDXs8z1amXGZSBLLAeklnkuM/bBoxOk2YB1ITy+o6nOB51utmjKfUMulKF/VOqiZQM8paEdCMOKduD+mon0DN4pQ6XiCEvlYJZlDqbztxHVpIX16Nt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MsJGbPin+XBuTeVhPIfXXdziS/8nFVXSz8PED1wGJQ=;
 b=b7PCfkOOAExMoKbge8Qh03oBJ8ZLGYg8zB7/SvB0dYq/nxfGz9pPqZNGhKolInk70zrVLcZFWbRXK7XBTSEip8Qw6YWBmnnWs/H6wFRTuNx4PuW9doalkNz0lFAsaRLToFQ72NCRoZgXkZQw7wa7EolvpckGvt/3rzlBB6e7JIKEB90ddbe6tpnd3gRlEhosf6bLKqondYEbz1vzIN/Umb53L45pStA+nyBhxD6lXImUHobtc26GxQjXCfo2VWkiu7w3yz/Fo2R9IwUKX6nJk1QHEDnEJUqRR/MR+olNKaJzxqqOx/9mkf5or6qc4+CS+/iu9lPY/8bvHhDHFPXlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MsJGbPin+XBuTeVhPIfXXdziS/8nFVXSz8PED1wGJQ=;
 b=uMR2cYEHwiOx8zLHk53H3Nk+nl0SHAMLSqXFEfxdrh72dZU1Did4xc+buitGPO7oGKbnK3PmGz7Wx3iVjkyY7uE3ppEdNIdeNUSLaIUCnr8bJvCekiY32rbSAhgR67aKrcqhxwrjJ9zILU/mAJP1YLZ+m+f1vFU6quKg4OkIZKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by CO3PR17MB5757.namprd17.prod.outlook.com (2603:10b6:303:17f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 15:47:33 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 15:47:33 +0000
Date:   Mon, 6 Feb 2023 06:23:29 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Fan Ni <fan.ni@samsung.com>
Cc:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference for resetting
 decoder
Message-ID: <Y+DjMTSoG9nZwN+e@memverge.com>
References: <CGME20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06@uscas1p2.samsung.com>
 <20221215170909.2650271-1-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215170909.2650271-1-fan.ni@samsung.com>
X-ClientProxiedBy: YT4P288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::27) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|CO3PR17MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d9fb5d-3d20-45d5-0dca-08db085975ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNWcl2Vhdb87ixWi2cGOLKFMe8oL91LTkijl9EDYxo08gvdziWdtyBPJs7mtuzI7lMqGW73xK3HuqHfk7IxKb1QjC2DoD4oJ8x+VwyRa/UdRGtcQdSrSTgHdGtvewakfTRzzufpwEEBIdgbL2EHP29xj9k9+dHKpxwNfMfRywaP/YwxPgH3TDjnXBjBSKHeGuwVKm376HTVkullAiEhKNq3PGf8Q0IOnoYKXWvXdmfJgee4vVnIyabOkJn1ZuCxCTZy6+UHd7ObRdJgpq1j6OLzeupBAprAvj68JjiM8+KcRTzJ3CUjlt7K4Ga8flo1pUYwJuJwKUHGbN1fX3EDb2NPQYcyAW/Z40VP6ih5ksWmXI6EvUfNQn2Yg2QHWYWT00F28S3L4tXarOdylKiNduq2R6ZOmHyn3khB0XHMoxKsgrp8DOqMp68N6myDZlXnS9FgBMcelplXQexPNgzucQeOq9SnPLQoWUzC29rHlhuhSRPAwNfWrmAQvzUkuOsNOekFKocLbTW2iu1Jqld+L3hpl+sIcsDKy0cjIw3Jo3L8+i1o1K8B5WRiqaaxph1HP1D+2aDWkxFvBMz3HLVOOP+A+FxuZfFv06Qzc2eDI2RpzJ7XR1Qzk0QHi4ATee+V3ilgwqEVAzMIKm4pAeUNBQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(396003)(39830400003)(346002)(451199018)(8936002)(41300700001)(5660300002)(7416002)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(2906002)(44832011)(54906003)(316002)(86362001)(36756003)(6666004)(6506007)(6486002)(478600001)(26005)(38100700002)(2616005)(186003)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?37YwuTBDkun4PGQ48tVXBYvNqYT6LXmhWxmX5K5ry0BGI3YlVFsYGCEhPXq8?=
 =?us-ascii?Q?QTTSAAdAC2LytvBPQ2FNnWXbdTuIT0huTue573zJpZT3LTju8GebDG9tkY4t?=
 =?us-ascii?Q?m9cPtH/AW7rT74MLA8fgEUL+YGKDhjfEcjODF3fQ8NU8lyfbEh5RHxo2uEMO?=
 =?us-ascii?Q?nVrVGLZHPuM/gMfWwHcOJhzRLtULqOxCq/B5mky1qH/M1LGTaUjAn9FGy8K7?=
 =?us-ascii?Q?WsPksi8kVsl6ebdD/w5atFIF9Ozsr94R+d1+5QlYGMPok78j/AgLgxvcYMvJ?=
 =?us-ascii?Q?vY0VDxdv/lGOjbXuhxeSJTeMzo0W2iIibG6D8tB7IDX3AkTt8kszNGo5oQYJ?=
 =?us-ascii?Q?VpXYloiyoHh4iBBVppi5fhlBGwR+QZJLI7Q+CMrgwaPpNV+P3vy8NKU+W3zH?=
 =?us-ascii?Q?XuLPqR/z/iIPG4ynzHeA+UR9rYWpkwXMHdOrnqZ4TomC+lBXJl7ntRy/r9in?=
 =?us-ascii?Q?/pnIsdkvNekS57vroP7Umi5TrfHhSr/zmKjHi7yXDL/amb35Pw4c7s7Cp8Kn?=
 =?us-ascii?Q?cn0oYf+b6+3WLiyGOZTh1rlCS4Teyk6aDnaM+8CfCVQzwnKy/PjVEsfQeaFj?=
 =?us-ascii?Q?Pg33LFyncH1uyz/OQQamR9mRkAr31P4GFO6PDTcr5f/5VGN4wYgP83kNRpSe?=
 =?us-ascii?Q?ct3BC+Ry/1zLjJhE+V0/hjF6y0W/BHZf1zh0qcQKIJdKLw2bhXuYxLRWltlO?=
 =?us-ascii?Q?nyTkC276XQAG/BkefzSRlN6WdOPJj3QWe1uYodKzrA20bIQGmgI60C5SVbF2?=
 =?us-ascii?Q?hs/R9OdJRPa4RVrSQLL9rp1LN86nlYZwFTabd7B2h4OSxrTfsfnKiZMuNSkj?=
 =?us-ascii?Q?ugtOrzmB3oREJpYkqyqgDh54LH3B6UFzphxWFAAeaQ7hQPdl26RYuoYcBjlo?=
 =?us-ascii?Q?AjCduc5CC3LINbiky6Fy31MDhkJqE+VsbyrQK3EfRRbcF67tMWv+aS8+EPoa?=
 =?us-ascii?Q?+sjqF/ZfacG0Ufequ++5TMPrT9gniSLfYUU9mYVRXlqzRivmEXBOsOXC1Bth?=
 =?us-ascii?Q?9N236rfzpMc0cP4wmFE4ZnqIegr2y1gAbq6sfnRiYP9Jc/g2/M8Pvi1+7a4u?=
 =?us-ascii?Q?GtnDpyXNHg4W5bYWGXyZ+u5lSEk/leE60LuzllJmHdgLlGDzThhvLSIX2qyk?=
 =?us-ascii?Q?7BiI0P9CUqNPOjDfQd6nFGgveWb7W2tmr67VcpH9aFDZdu38sXpqXkGjHnoH?=
 =?us-ascii?Q?1OnhDRfxG9KHPfDHO3eCDwSGi49jyl6wndLrPKG2OrztsSdhgxAX8KmCztFg?=
 =?us-ascii?Q?zyqSnvzXHJ5I9yRBtIi9WgcK+MGKHehD6gvvvxoswK/xVUCWdlGggOD2gUpW?=
 =?us-ascii?Q?IuUZb6ncHtz/IrFxhGUVf0/lXI/qCRt5b90gaNX6XmDRzmZBszRiyDvzhVFr?=
 =?us-ascii?Q?vrnAoTX5QsDwOYTdou/JTxZCJdzRve/3cYosICnykCeujJSd/BcizvG/lyhN?=
 =?us-ascii?Q?qbHVa+bIa2OproO5iEt7mC8BMBqKrDJTcm9Ck93k8xGPeIx/NwXfQsEd31pc?=
 =?us-ascii?Q?HDmJENKM8eqCjKY3tIFfd3KRm9yurr+hFw/cQPH/5wRU/WsAw8ZUIZkZWkur?=
 =?us-ascii?Q?iOBZKOcgdN5XbRkP0ZBP+mLQDz/zvKx3CQmGv9zy0pdLyI4UfWIJP72jqrLu?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d9fb5d-3d20-45d5-0dca-08db085975ea
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 15:47:32.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ne9H3N/LZ/UEt9q+A4B3YJjgbYsKexazIHIKT8lyDqd41A7N/1Qpy5HI8X4Pgi/W+84FFH/awFa8KHNHMGkXbcLtNa35RDdAdEayaqeA6r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR17MB5757
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:09:14PM +0000, Fan Ni wrote:
> Not all decoders have a reset callback.
> 
> The CXL specification allows a host bridge with a single root port to
> have no explicit HDM decoders. Currently the region driver assumes there
> are none.  As such the CXL core creates a special pass through decoder
> instance without a commit/reset callback.
> 
> Prior to this patch, the ->reset() callback was called unconditionally when
> calling cxl_region_decode_reset. Thus a configuration with 1 Host Bridge,
> 1 Root Port, and one directly attached CXL type 3 device or multiple CXL
> type 3 devices attached to downstream ports of a switch can cause a null
> pointer dereference.
> 
> Before the fix, a kernel crash was observed when we destroy the region, and
> a pass through decoder is reset.
> 
> The issue can be reproduced as below,
>     1) create a region with a CXL setup which includes a HB with a
>     single root port under which a memdev is attached directly.
>     2) destroy the region with cxl destroy-region regionX -f.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/cxl/core/region.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f9ae5ad284ff..3931793a13ac 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -131,7 +131,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  		struct cxl_port *iter = cxled_to_port(cxled);
>  		struct cxl_ep *ep;
> -		int rc;
> +		int rc = 0;
>  
>  		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
>  			iter = to_cxl_port(iter->dev.parent);
> @@ -143,7 +143,8 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  
>  			cxl_rr = cxl_rr_load(iter, cxlr);
>  			cxld = cxl_rr->decoder;
> -			rc = cxld->reset(cxld);
> +			if (cxld->reset)
> +				rc = cxld->reset(cxld);
>  			if (rc)
>  				return rc;
>  		}
> @@ -186,7 +187,8 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  			     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
>  				cxl_rr = cxl_rr_load(iter, cxlr);
>  				cxld = cxl_rr->decoder;
> -				cxld->reset(cxld);
> +				if (cxld->reset)
> +					cxld->reset(cxld);
>  			}
>  
>  			cxled->cxld.reset(&cxled->cxld);
> -- 
> 2.25.1


Should we try to get this upstreamed in 6.2-final?  Seems like a good
stable addition. Probably doesn't affect real hardware, but it certainly
affects QEMU.


Tested-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
