Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7576B851C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCMWrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCMWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:47:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF5B17149;
        Mon, 13 Mar 2023 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678747607; x=1710283607;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4xmTux/tEUOIQRfMRn07gpE+ITnSjmTePkgVuWDSqWw=;
  b=OpsvJN8zi05CQoC3OfUJyKsHLWn3RLsNPMuB9Mek5gRqwomiNhwj1xCm
   /GDjCL6sLIcYoztyl5e2D+IrvjKAZRhzkXbpha+A+ox6W3JftLYPSvrRl
   Dzl925MTgE8Xhbwelhayn3aMZtbsptPC7hsgVvD/dkZporVP5a3LMvdKD
   K9dkznxHCUk+MUHe6pUA+reyjqU7dXcXR5f00q52ktRkBPmyhryotpNEX
   eui9wsjC6a6BbIRWEeM21aUGzGemt+ZIK1q0K1YryAg3vKyBdC3Ls/M7U
   QlPoMymWgOY9ZgWu8/+gjPSMRoxMazXn1OfaxFYaX81qBxXjplFiv/qzv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="338822538"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="338822538"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="656117321"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="656117321"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2023 15:45:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:45:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:45:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 15:45:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 15:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFFEIhGETkDB+dlv3MTy4qP5/E4IC/BF5xDmVlt14KBV5xkj85YbtUOHHDZhw6xNaxQmKkcseJH3VI0mIMEm8xygUicAFtMSqIMNo+wavOWdUMVtYv430edhX2AqkUiwlLIAzHYWys8FQhlJYdEdp0xXDEuutHiBLM9P19RXiWwkqHB8FQ4VQUw7mKmL/zHhdmYNmmKyWlKxIkuY10uzWhebvb4/Z4j+n0Ylha+fPYu+/1+CeEj8g0GUu1fRh05bJUWiEIQSIeMheQIDO8ps7cs5E4fsmHx8VYxUrNxkzD+ErSTQ/lO2qpBfsVPydW1wUymitNHSXVv57cV8EA7/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxorPhgT//X88Lo7v6cyS6wJPeQagREO0T8sLATkc54=;
 b=awH8p203NglmkpybgqI21Fxe3r/Yye5A9pBdvZtbprtFAPhN1rXHFghhPy7UuuwgtPSkeF+yhTllbbNuhpsPNPgNghg872PiKz8qdDANyJ2MwwmnDLOXLKOqVxQ5BOc9whOq9CpN9gC2Z8i0zuyKnqd1LPVfXR7y1gUcgaNFLuxz5emqXM2wapIjt9GVFQrAKH0RxbSAcuDfy3Id1+Uudpd7mywYnchnIXo87YnHUdQDR5Al2KT71IfBR4SEbSgCLBpZ7qjm/QRAtLvrKPjQr60BEXRNICGc3XNj3Zj+RyjgAiK4rvDoJOEo+rivHgPC8oF1YIZgqO+uSFczL80nIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Mon, 13 Mar
 2023 22:45:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:45:23 +0000
Date:   Mon, 13 Mar 2023 15:45:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <640fa7801ec54_22c07f29470@iweiny-mobl.notmuch>
References: <cover.1678468593.git.alison.schofield@intel.com>
 <5edd09350fef0030aa18ab232ac8cdd82e0eb5b0.1678468593.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5edd09350fef0030aa18ab232ac8cdd82e0eb5b0.1678468593.git.alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:a03:54::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3a70be-aea7-42ca-93c8-08db2414a1bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVao0Vd1hoT6qCRVFXrzZmBmd7tzX+7JCuYTyALAbJTYBpo2wAbciDLk+UWDqJV7nEvN7cVteExKU3vb8KDvc9KIF76qsFEwMJgWBqolmB4fCRr/XFrpHYNylTrbGwiqFSZfWN7KGWWLBv02QuOEwQktyk7wRddVIcIbA0xzcL8FrpvQFNHRXJziviGfm7fUK2FFHJhSECX4thNYEKWVtmsFtfbJGKG7oV/dQTLv+2rgVoCLOuuCDxOgwmycsInbObE9LDvRvFqAfgfeDmcGZa8mmyzQWBW0H3zKmC6EWnG0GF75a3t0AiUAH+A+lbocK4hhk2etIVp+ZrZ+FAtiv+eC0D+XBCDtd6JwhEpQipFPQXyPyogEtSLUeNc5n3iGT9hdpQajIyq08Aw718ePW06BYkm9jPA2aZfVvprjYzugqPPfrDeMTSrF3KQv2wa9HPgLy9jozDyfUh/7+Mz5zWosfsSmppM7WKMdYPwNPPl6s5eGhW0Ni5liAxc7nVOIqA40/e7lnJwp6rw21A3M2JZQY9hcOkqGg3JSuCMH3EJfpIKyejBOsXSbgnekfps5USmrDU+rhzNnBKp+z5Lxzcm+hxtnsvRfn9fcxVVb676GkdkGTYQaFmTWu5rBlACGQS99/au/53+q7ofPuxaAow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199018)(186003)(82960400001)(6486002)(54906003)(478600001)(316002)(38100700002)(86362001)(110136005)(6506007)(83380400001)(6512007)(41300700001)(26005)(9686003)(44832011)(8936002)(5660300002)(4744005)(66946007)(4326008)(66476007)(2906002)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPJS5IbIqo8bh9cIfyJeB2vzrm0afap9p1NVPmzeI9tQzuWud3Mlgvr5CiEU?=
 =?us-ascii?Q?0dsHmzh2b3FkzReQA6ETds/2uHbIs7SSWegy1UK+YhnDy+I8Qm8eQ3J1OZYR?=
 =?us-ascii?Q?6XsvrK6Jkftha/A9lHHxvWx29BPkSE3geJD7UgAovpk0CBnSug3oBEhyETK2?=
 =?us-ascii?Q?N6fU0E91aDUEF/jAcLIFFyoR+xmW1KzVaQF1/1f/WqSuAThaBTjZNNeJAvkp?=
 =?us-ascii?Q?uvmQHljEX/XT6vx29fAo1LFRiUGtvwTkmUGbn4Qc2/bRAenqHZ/rEFqtw6i0?=
 =?us-ascii?Q?Y/hygdGh47j9bhzJbxHkYGn3pqLICzyOq6ciC9kXmOvj+Yw4TgDOToPnS0CO?=
 =?us-ascii?Q?qZjIQe96nAhq1ykwZo5+IMw+b2kd67xYdOaosmMBFfXwR7DLVapOfOv0T654?=
 =?us-ascii?Q?V6HqOODECk3PXMNYrHvMShhuOZIKIGL1Y9gpk5uEnKjZ2Eg5uX/qUYDxUQWE?=
 =?us-ascii?Q?4JX43MtrBcXFxQOEznH4++mIGdSjrBKVKHyvzGJB3N6b2WF8G0UUWVR+MhGN?=
 =?us-ascii?Q?LT+MyldHFq7qQGRj5QK9shnRukYXeUrgEfkiGIk1+sa2P8bNOFTmoLSKcyGC?=
 =?us-ascii?Q?OV7sd14a25FdBe7P+iwdL/kbfuG4NQ/p6dRgSL872ZxnhMzWsV0Jv5/qZrET?=
 =?us-ascii?Q?S3Zp7RLivfpptGgEthte8ZkhXh0xHvcflODNZzCmF4gr1Tu39eaUF1/1EShn?=
 =?us-ascii?Q?SaPxsan4eTvWZeFLa2pueuHO3EKxczuqdEbzYmyF/WhyLfn540Yh3X73eGtQ?=
 =?us-ascii?Q?Pn5AdRSaGCmOhiya6fZHuNSvBwu2Tqhi91EVyJlXtrPFacLT5e6JPqw9nBvL?=
 =?us-ascii?Q?gHS96TV5eHZ6plKndeE2zMzQqdO10maPm6v4ym+wzKQxW/Py3mxdCQg80V/O?=
 =?us-ascii?Q?LBLqJPZVGfQNUQN/ZM4kIM2xGjes8xcXQjSx4tfAkhnjBc+jdNlFw9y5SH7N?=
 =?us-ascii?Q?FyEJfeh8lbmoh1bZ/+CiGDjlGzUsFvnxPtn+xzcQDc5i4YTYIChKuu89EH8i?=
 =?us-ascii?Q?c7c+SRXXBhwFGMCicEwgYeuzgkuudUkx4k610PuiE/uHEHwfWkH1J658iYsY?=
 =?us-ascii?Q?MQ4LuuTqum7EXGmdXGJ7+YqdzIHgb7jlVl+Nb3c006PUiUuL367Mss+WuO1X?=
 =?us-ascii?Q?FWRldUmqQzBQrLPUPrjevdVtiAK+QYi64ITvi+iDXSKPL1SsEMYboYepsO5U?=
 =?us-ascii?Q?IaGX7XHwNOpRHwx2G974gn6biIc6pMyIv8XwVlCUsV5/4pBe7T6p0BmoLQgR?=
 =?us-ascii?Q?/uUAUNWfod46/63Sz0D6VGsYN0ss14yfVubZr/6oF0NagcSz67+GNBd+D001?=
 =?us-ascii?Q?1Pk37WpebV880nQc+WGJonnjYeD6X3tCmkih7dFLoZLygmYQJzxBAz2xJjpJ?=
 =?us-ascii?Q?mOcA8lP9V4yqFoWOENkTXVWdLURVCwBSNqvB5G0b+wFHQW2mvbgzC/BLb6aY?=
 =?us-ascii?Q?R3jtYX3xEivmk/Yd/bFsxNcgUlIVZ/KhEepiwNh2XgqKvR9QCGNdjKedneVk?=
 =?us-ascii?Q?XlYvjM5/jeP040MHADfpdXG+gYV1BYuhOrQo/0okKLaOJ1ZT321PwBX1XL0I?=
 =?us-ascii?Q?I7v4LZZKCMT96KA0C8qw7nCEK7kIoz2mZufGb/NO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3a70be-aea7-42ca-93c8-08db2414a1bb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 22:45:23.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8W+zNIsfMag4XbUeLvq6uQ3CjTRzm+jIBUC1cHHFdDRoohYsv1H6egqJLU2Elasq8K2GJ7nYcwbIh4JrlFHZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074
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
> Retrieve the poison list.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
