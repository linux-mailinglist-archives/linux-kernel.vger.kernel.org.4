Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E530572A880
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjFJCh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjFJChY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:37:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD3A1BD6;
        Fri,  9 Jun 2023 19:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686364641; x=1717900641;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4U5W2ohrD0Pl9iMzvKeWlSW5xHBrhNQGrNCbtEgvI+8=;
  b=E1/5TFml11aSKH4sxcHGA6Q8gx9h/438vaTjhY9nc+dbICaWWIdQnxH2
   4ThgpRfve/Gnt3Y0t1fh0Z6BBDQb0hmPC3HYaBlY209gLQUC9MYqSA7WD
   jYH44mavvhmCsAIMWWLSn+JAltRxueBsMwmaARiDBsnHkXOYCctxp4WSx
   JhTBrf8NIAcinSk6dJd48sP6q0hUH9aZf+s9HQx3ouDYXSPzMDwM94J3H
   nY8YxMFJUVDYoVxQU+Lk7bxbUcJryPl9S94nflp2G+lUfLNeoWV6OWNvb
   1F7Qo8zeeE2x+3Ewc7rfeK6xXjpAnBJaEVfDA4I0Yo87X7E39b2sd08zI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="347369272"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="347369272"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 19:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="1040672239"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="1040672239"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2023 19:37:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:37:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:37:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 19:37:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 19:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN50mwp0pDsyLUCvVutUKpYhWJPW0+gDxOP67SNnF2epU7fOV+H18qLdZEzj0UGzqod9L7vMMD9nLVYUbvxo029Ky8aZJNbhaYobRHvCPviCqRY2mdHlZ9OHaA/OnCVJP87coIAAoMlh1JMg2QbA1hlhvIOQ/ogqRe7nNVYdMuDMqMkbVlUkopxEgHx8JXtOEX2w4OI5d4WPXO5QUY+GrC1o0/MMLiISewyF6UVpAndSVDN1ZMCDSJI2CZCYHTzufL2T5jpHWog7trDFErZosJQCv40Jq/zH88OUzohw0GUogu9mexSEAFl/b9Z9CQWbNevdD8QEHdOtEZm29nEYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9oh9puUI+ymqShd+QYe0N0fXGM1h76NG540ZJPTCjo=;
 b=kkZhy3VIlBkKveLoVClwqOokLt0isLzafBwQoXx5YaK7P6u61ygBSVW/w5Gj6InsVIUH0M0kReBdTOo1flsw3aweSwpMwGsQG99bXBnzlSbfBdPwYkF9XAUtbwH1RlLcMDB6/Ki9Gf6V5cry22DAZbImu+RqLHlWDoz3/W40DPTU3bJ3tMEhDEuuHE9F1n4icncl3bxlJVFh2z+mISp18JXtksuaAcK0KGWew/WTydJxZpH2n3/9i5xNr/EpVM19fHrx9qkDf9QxZb44h+Gg2oMT3YWI6AtvxOpiRjPQ/Px6xxm60dUjXmwzqfNFPknBHdTtRI5ZKsJPu1lukgEjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7245.namprd11.prod.outlook.com (2603:10b6:208:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Sat, 10 Jun
 2023 02:37:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 02:37:19 +0000
Date:   Fri, 9 Jun 2023 19:37:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 17/26] cxl/port: Remove Component Register base
 address from struct cxl_dport
Message-ID: <6483e1dae75e4_e067a294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-18-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-18-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fbe2c0-dd20-4c08-6f66-08db695b9c61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRE5XbjKpEJ3aciGghGqw4Mp1/glvvIO9Ghdeb5aZudK4o/4z9E32jYJSrEnlLUGY/aQl7b0mQJqHGuNrlc8EenohK+om4SRhUn5IgZ47lw4/fdlNT8Lk65Qq53OWxSlKUAWu1807XcOgazOn0Gzvgq2saTzJAzTkHHmnaTX+0K+GxfPI/wGxHG1FluDMKOFJGSFIMbnrHj80i+32QO8Y1R5e1gzY15bm0Q8UzoYAXLmC5+lBfA7BWWcFnB46yVhuYym10M6XXDv4qQYo2rDRSq6QYjj0mbOjiP1elcHVsoU37MUWc7RSJdEKc6iGlGQ/+Ub+nJ51sJWnKyXwroRDFfz3ccnjJIfo5sH8oq7APzOc40Z8TeQo30/hRO4Amftzu+eZysQZSQOh9qEfRxulcAJTR4q6vfDx+CzP0F8FKZBN2Qkbj7xmy4qYAM0c46FZnZzJpgE1arEz6VgBu8K0LnvxBOANHUn0DwOMfwZ+NJVQuUTK9lpwDMkjLRdFLd/dvPKb+mRpBDQDfb/BbzlDkgVvfuRe18YZfq8P5MpQ8cIfgE3GMSLDhd0bPXKC1Lw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(478600001)(82960400001)(8676002)(8936002)(4326008)(316002)(38100700002)(66556008)(66476007)(66946007)(41300700001)(186003)(6512007)(6666004)(6486002)(6506007)(9686003)(26005)(86362001)(5660300002)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PnljoSlyhR8vCfU2mRviB1UYZ6Abtw7Sh//DIMafQrdeLZisYa07RcJ2Utfk?=
 =?us-ascii?Q?2qMrddht+89u0xufMwti+s5Y/UcJxtUe8tRJcqock/SjF0ePvH5NCk69oZJb?=
 =?us-ascii?Q?4yIp+FXjzUwAQV7Wx/qhnzbuHZtSDgWLUxQ8HwnXXdiFIVALjMUc4v4CSHrU?=
 =?us-ascii?Q?buLOEmyThvYwoveDLzbpNPpX2bG17uHh8W4sBL5xDTpeNT1jGjW1JCxpPp0X?=
 =?us-ascii?Q?8egqO+fXI3mD5q0fb4onO6QL7Cbe1wPtUnrQCQ892Ivhi2EvXCbzJetbTd2s?=
 =?us-ascii?Q?O7exrR8zcU/fe+/+dVEJ1QPCmzGxk0OIfgHsNooHxfCb4zZTOHbpTFEWD78t?=
 =?us-ascii?Q?tj427JGGQObeSdDky+/jw0rgA/W6oJZTWVos7DfhnNmpyWFsb1KC6SOQtTO2?=
 =?us-ascii?Q?c1W1YCo+DKXI1OausYMvSKEBq/1i6ovLkk1PdcXFikF9zRFlF/kNHaKQ4XlL?=
 =?us-ascii?Q?KuQTMVXxXC73jpWs66vzTGjXkDKhzu7u9Dl8NNN9ZtlbIRjF/6DtusC/KRsZ?=
 =?us-ascii?Q?b4Y+pGwto2zGJzpK0Gxam5up4BW9MtmAsjJrGEG9z33GH1JufLOF7xJYQczm?=
 =?us-ascii?Q?N0NIoIFlI0XedV6bdAlsYWg9UMcpHW2xZQQBOAzu0akmLJnZuY2V1exUt4QD?=
 =?us-ascii?Q?6DwyARvSpQiRRQSCXIfrQiGQ3o0htNfq+K8Rfse+jtVhypnTtDKrWTJ/DXcG?=
 =?us-ascii?Q?4L7wMvlTsnHgA4gd5nXdqUIZeeodrPEBSHY6Vm+44X+jDwzXa6894ufH/ufP?=
 =?us-ascii?Q?7bl2PB33DhZFTjAV7gpIBWngHLhE1Dd2ohbkPAi5FfXAFPqgUX02t2nKS9ny?=
 =?us-ascii?Q?zSX+N2MWCzUZYyTNK1HBTS+NxzwkK0NE1AWUPJjyETqC4J5SgWY2d2IaMw/b?=
 =?us-ascii?Q?+jBvXY5UN+9ulsLYPhrNZOp69cs++HADI7BEbp/mqy269SG8DHoa/MqNV4rY?=
 =?us-ascii?Q?RoMiLEZt7yoDxUi/x1CmBO1U1loVXeC+em/bx28CyYud+TRAXsqDEBugc+wC?=
 =?us-ascii?Q?uJFLjrrGQmQsPCK1sGjtYiEhMi1Ap/7zeBZT0IXhPx3xiWx56vnWDTrQ56Xj?=
 =?us-ascii?Q?zdSWiEWX+sbwKyiHX54DS0MLNUTQH7xy7pYK5QuBXb4QvWIfJJE9kCa3iFHG?=
 =?us-ascii?Q?owUvipgpMsjpZ8JPmIYNHErTiyk7dKCvJTXpc/MNZnnTX92D/RhZqceE4sGJ?=
 =?us-ascii?Q?sOH3yCz/GPkbAN2F++Z8Q995EN+Q/4JChg8gW5BTfV1EKdM9Siy2XOu4MQRN?=
 =?us-ascii?Q?K2QfS/dZXp6w+9KgfHLSOb2GTVuzpxUaewPCmxtI1KNn3iavM/SkwclEG0gq?=
 =?us-ascii?Q?hDqgPaP8NUYzF3ahRaLWh5cFLw3jqnXo6b3qyKTFUwpOZv8jIJX67F+5Qd71?=
 =?us-ascii?Q?u8epQub3lBWRsMNS4stG3cciz41dAo2sr7UYbWzCCbulgjUpiZaysypz6AeG?=
 =?us-ascii?Q?QOd4THAZi7rZHd2iWZs0U2Zr/dnzCI5ZIQ8KciPsN3OiknRvoLnJRmGEY1cb?=
 =?us-ascii?Q?QW2alB3w1tDLgW/yYoQAuKoV48y6KctONyHOZSvuq9IlUwVp4J37fTtu4jT7?=
 =?us-ascii?Q?JKLUa2oA2tF8f7AGuSq/j3M5MTJYMaEOdlYs66G9oc1pAI4kT4W3M579Ob/v?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fbe2c0-dd20-4c08-6f66-08db695b9c61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 02:37:19.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsYx3/wArEVrxCAKycg/fY3E4Qz+ZfUH6Q06KRoEMgP6W+UJ0HMP2O8eGNj55EEd5ZA9CFq0p2VD3IjsN3qxArGAZomDx4fgFG+44sQCc7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7245
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @comp_map instead. Remove the base address.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As I mentioned earlier this could have happened several patches back, so
looks good, but consider moving it earlier in the series for v6.
