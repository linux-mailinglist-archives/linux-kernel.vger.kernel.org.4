Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A39727783
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjFHGmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjFHGmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:42:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A16128;
        Wed,  7 Jun 2023 23:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686206540; x=1717742540;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w9rLXufmRzCTwEvoIvZ68n7kOsn0KAfi6bYJJm338ss=;
  b=Za4pgQcF5tT8AbimWHiXba8IgtfLFEss9Fu0MwMxpRn5/pdBdnx8m8cP
   DvSirowmRj5Su98y04OsDgrGO9/W/wx8teQRZitmo3k74xR7dOf6McSge
   /a1GSE7+fi1f6oY8HT2pUi1frBTRGAnmQMcLquxZqZxrR3ztKxUeJFQzJ
   w4/SXP+6Djj3lX73DUpjK+JmWWPAFwl5mWnZ5W+OOoQQM96p8E0IzL9PR
   3pViJa9L2EJH+bZJ/rXIm2dgMlJNV07oiAkUrCn+7jp/Qjg7f9KKA62HC
   bUi1cw/ttUd3GtPI4OW/frjyqR1VOdmB0qxLsSJP+FWZipG5gk6yz/pVS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="357232471"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="357232471"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 23:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="822477276"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="822477276"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2023 23:42:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 23:42:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 23:42:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 23:42:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 23:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dxyk/guq4SWMrkR7eMA+aiYenA8x1YqYoYiFrs6luusEt7HVs5UhBQMBb9PNsNuI0fiNJIdL1VWIpLhohhcN2Fx7yCXJKHY6M4O0AB4Tlz/Q1p9MMydR7GY2/YZ9Mu0A/LBheRmKrPdDsmcob8qYRWZbHLU78ztnjvowQRM8W0u6VuunxaEcVP8zzLa96kbD71N6nC2zr1yR07wEEfJnC1MtZQYcSW2tYeaPQhVAevpSHlvb/BIOlYKlUNT4nbOxrmGV6gpFfq284UI2UxupgyKiXnk5ZGe1lYBmRsj4DFfuZkHeu10Jee47ur0AUsdYGbXjXtjsg+NesM70xT5vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zXQFXWfpXoT+dwF4Zgq5OPgihbBiE3lxeYKCwIWXcE=;
 b=L9iNVpIVbIvIRtiwkRAS/aQtM9qiAtqEk84D9sXgXVHYapSv5mYN+s3ai2j7nsyEnrHKyF0EVKF592gC9ZZS8RTp59IX8Be4fOq2gGyJQpbQ5NBIk9HaRyC1B9AaOnI9mi/5ZWqYd4wYk7k4PBw3ZV0pa0e32V/KSATIgD78QWXvVrRrqsIoAcpdllhataibPvy/0gLOYdjhh2B8+ONBHtSfSk6h8cyVp2sPvd2pS2k8rswj9VlcgelJYb+LarOqtFMMilqS1XFow97J1Rf5uU6XrPbOVL5HHL/mII4Xg1KaoNW1pqlUIsUcvbVVzKUbU7gZ9l172V56GmNyDtt/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 8 Jun
 2023 06:42:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:42:17 +0000
Date:   Wed, 7 Jun 2023 23:42:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 03/26] cxl: Rename member @dport of struct cxl_dport
 to @dev
Message-ID: <64817846759c9_e067a294f5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-4-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf18843-6f44-4f42-771e-08db67eb801f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Xx3KB3q/o5wZ4ZUnYrxmQoZwSWtBVaepOcsTpCtD9JP7umiPFcjKG7T9yYID0e+dmWNTLcS5saEa0pBp7fmgaMOcCiQE31QAbiPqtvLKi8RSSs1VMxXU7q9jECENpsYnWadCQtW/kqVpVUhCptgpWvrNymsGaTAA2cFF4Wc05Z3SpXpMq0ft6FtJZO0Sllg3Ib+8fDwAqHhixCQn8/NRjUmv3P0zmRF0MwvKrIFZmYONEzWkhel+fsaYg4opSOqrEJjURl5ehX/ELtn89mk8V/nwGFwc3vS4coPh4v6Xir2gSx81jSCj9EayU7sIi9UY4pKtmLpNw/JsAvXEqAvjNnjwfiujfynwEH/bHMy8dqs+QHaWcihHUH0/z+w7F7cyyRvy3w7kPm6otsEm+RpLsUu4ynX2EutQA6HLJv53JlkILyFgb1MmggLhqxubHijRcaWXqY7ePulo/HefiNRndXuPWJWjhq8Vz5+0M3rRxvzQciFriN0Xchoup9XGIzTDCYG6ms1XqxhhXCaty5OIw6Iq+APffu6P7OPDwK4+BkutWsGzos+47GgJlFaaQkH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(26005)(186003)(6506007)(6512007)(9686003)(83380400001)(38100700002)(86362001)(82960400001)(316002)(2906002)(478600001)(4326008)(4744005)(66556008)(66476007)(8936002)(8676002)(66946007)(5660300002)(41300700001)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uuj4WqfUfiWAQnM7aNjLfWxE4gh8A2BliuKGoUhu7fHI60uNVZVdVcEDHyOP?=
 =?us-ascii?Q?Ke/nzjgF96eVeCwM+ghNlsmCgY1xcDS5jOuR6ZiplCWXU88Am34kXk9jmsW4?=
 =?us-ascii?Q?cmDToE09eYOocx1oOjysMmMIP9Ns+OyWAZAQK6Dhpdxnirf3wAAj+7pQKnjq?=
 =?us-ascii?Q?W/BGi4ewF+b35F5vem7fGHBLBxReJaV0mQHDKjcUsWFHW9igtHLLaiKti3e8?=
 =?us-ascii?Q?EgaJlUyPbwxZphDHp2DwdjhYPEP8WVWIGNvKjWbysFLjp9yO/l6Tmode9S3s?=
 =?us-ascii?Q?4rY49UUtHZ9PNfsNQPgosQPCw7CXuyvFxjkRt7/fHBvTaOjNXjJG6wBnyKlD?=
 =?us-ascii?Q?gFA1kkPYWst/v8/BjswRl/jVSpvFy3EI59yabKrdWRmNuGAle/CJiZpSQDxP?=
 =?us-ascii?Q?hyGyEfgVJe/w/u2D8BQwiTYjyzN3BuBvCQgNgfR4gLH8tEzxM0f3p0Y3GGoK?=
 =?us-ascii?Q?zz+pubfA70KwPNKrZwpZ96zB4A0M9hVeKHYjcWWtr5QTQPIxCM10OI1Y2j98?=
 =?us-ascii?Q?9yTJmXNCeWgK85lbqsWZrL22NxT0wacpRW36Mwrq3wtbbyW1XRei2featrSR?=
 =?us-ascii?Q?8ocpqcIZBdC8pzFowJVWX6TdOH4sBAppbuszURmIZgYPYmZXsXxucR0c7tL1?=
 =?us-ascii?Q?XM9WvuywGF0DSb17JCIZNl1mMvV6CWPSCZm4mWrXJJwnR3UqvO16UzZcC/Av?=
 =?us-ascii?Q?ynHmN00bz8kEt0mZtMcLyrdkPXOxtJIJaRtoS+fIW0wi4y6/1fQgKoUB1Sjo?=
 =?us-ascii?Q?ooxjy/gjPCpBaEoJCJzIYMUI5mQC2a1h3B0HjM2HMrFN/ksC6s6HWmWVvmdo?=
 =?us-ascii?Q?DZy0UOfkUkPMU69Ak+nD5YNq9xZilUh5QePwgiOmBXVDgn09sC7HmyihDeKn?=
 =?us-ascii?Q?pGBj+IK3Pf/YXHHO7Az/Vn7c3rvKSh9lx7rjP4VmAxqQAtMj2vAWudN3HBef?=
 =?us-ascii?Q?WL7/mVYQ04cgWBa+zCivfMEKr234KOdwA5+TNlBocOi3P7QO/AXy/Xn60NmR?=
 =?us-ascii?Q?ehpaJXttkLs8orqLJIPf7c+i4rLhJicpsQEitH50APJ0+Gb+tY5d+F6m2pcY?=
 =?us-ascii?Q?13P2IIc6hdZ9sh7eL6C7zlJ3d1gVKVd/gdvv/TZSY1VxRrJuhnBkM7QwAuHP?=
 =?us-ascii?Q?u5oZ//UX0hXLtRS0fTNK8JmVrNAoO3l2mkUnMVVjvyiqCUQ4V/80q1i0DdwH?=
 =?us-ascii?Q?AuWtR/pv88AMTYO8XiKGagzCrHBlLrL6Y677EaIDwdLx1zZ1UjqA9eBJIQx2?=
 =?us-ascii?Q?9WlYRVp/009+F5cg8KYbxo/9yBAI4SnolTVRgdRF3F+YJdGgtmXcILeFxlqj?=
 =?us-ascii?Q?J3CX7os3sQyjWOG7lRjJG+twaZDHy7jsUphKJG+GRiciMCfon+G9zXcNx/Pd?=
 =?us-ascii?Q?s7QCJylD/w5FbgWsjkbB/WcOEaelMCUEZGEwcWvYugxJJgdAeYWO7X8do71B?=
 =?us-ascii?Q?EPr4hNvs5kpzWr6h7jDgLpPb2ImIvktg/DNjeHivLgooLd+5MTbRUKztY4Ve?=
 =?us-ascii?Q?MTFIRBElVU3dSum+5AE5Li30RZBGKj04mPPjowRGzPzdkPFt7QUpoaaSU2HA?=
 =?us-ascii?Q?u254xvcQHT7+abN1gzoDIYqxqi9tb7bTy0Ow00+i4MYqdiEZUtRJKM2AduK4?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf18843-6f44-4f42-771e-08db67eb801f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:42:16.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8lZoNFy/YCysUVOlmuR/B/WbYPjjWKbzXrwnAFwOG8c3vSuci/WafHQw+3RIjTumPkTxIzW2yQ+rcwBVDNH6J478Qimgw8dlTWCWrAFZkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
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

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Reading code like dport->dport does not immediately suggest that this
> points to the corresponding device structure of the dport. Rename
> struct member @dport to @dev.

This one I don't agree with.

This can switch to ->dport_dev if you like. The reason for ->dport was
for symmetry with the ->uport of a 'struct cxl_port'. So if you change
this to ->dport_dev then also make the ->uport_dev change for symmetry.

Unlike a 'struct cxl_port' a 'struct cxl_dport' is not a device in its
own right which is what I see when I read dport->dev.

> 
> While at it, also rename @new argument of add_dport() to @dport. This
> better describes the variable as a dport (e.g. new->dport becomes to
> dport->dev).

There is already other occurrences of dport_dev as an argument, so I
think that works here too.
