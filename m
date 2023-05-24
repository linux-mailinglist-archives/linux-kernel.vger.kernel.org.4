Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB070EC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjEXETg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXETd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:19:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C9C1;
        Tue, 23 May 2023 21:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684901972; x=1716437972;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FqXV4t7/xsLZSFTsflui+wopIGUZMhP+Yy+2YToq9A4=;
  b=VZ6mWgFULsXnd7QP15h9fKDLbBft96KxurMjJyhMWMSAPJqxwBdtLRgJ
   K2TSYAVguqqOBYE43R+T2ucL2YMlJped8tP4XoXYKEa3Up0+N/Wwashmw
   XPJH5WGvM9Hnh8KDV0EMuadHcm6TtTfHwNAm6jEUjPbVIuIQYMXwod1Zl
   04FPuyFoJGf2w9eBKJPE+Lfz+SFeFHYdld8k4GLPy2bl8fpeeCCEjCa4b
   0Fbur4LQvBrvsLzKgYxhdtZO52MggDPiuR3DavR62qX8tfHGokvbsauPO
   8xyhn/xPrReAVhiouMoFbeAQaG8jg6R39iNReyoOnhGsfY8bIuP2zJsXR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="352293742"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="352293742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 21:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="735007914"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="735007914"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 23 May 2023 21:19:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 21:19:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 21:19:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 21:19:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 21:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3w27wWmVBBU6pCUAiIDnOXy2cvelzxFXC/CqVqpQ7zoCz+t3VH5o0jMAFT8MkBkCsQ4LC4w0qbvp5Ftgir2Db4AgHMZqVzN7bzUzJDw5QPqgHtcXjGeNgYMlS4HzjCpi0kz2MmYoBcVxVf/UdkKmeLgL6kQAPGDNSNq7k6BrxutriIPcLGNxBNtuxmQonW5XGR357iE0PWcoMLWVlRSsVTXxvzFrT3I5DcqoYJK8DRwu9xxm/KlxkuFrexFsHcShzdLgeUWnyOeIF6skdbgp/lcm3dvaUAkZNy7E66fK5RHNMbRWV9+Th7HB4/b5MPmk8VRYgPWat4XOisicDHuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyAKwNl0zlzBOt6S/URStrlN6jrF5uwJCoYpvwtqze8=;
 b=XPTP0ypL/2kRL4ErrVgEeASN8ThpY961Ic+YgT3ImfK7RFSKgsuxwXU6bMdiHjZigq0LoKU8Shr97hQ4x7JcsXbJQtaWJWS00i28gYf3/DaQsNySE0R9SE6qJvve0KHYcPZ2Cuzb7NwHG8dTTu3sNYPBN4qluaJQQjtNNNtbhPk3xsbgFE/Pms9kpEm9XVVjP9sH7v5jre0f0G3D0enfYeNtU/bOHjaZgtcF3WRf3YHahs9dPCansKmRIvry5KzO3ISx1qzniHakQ30wtY/8FVsV5EKalSmwRtJFcpt0abveRcICcXX6ml9EnZ+kN4QX/UY8rJTO//ZaEbQIwr8n/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6423.namprd11.prod.outlook.com (2603:10b6:8:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 04:19:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 04:19:28 +0000
Date:   Tue, 23 May 2023 21:19:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] cxl: Handle background commands
Message-ID: <646d904ce9d8d_250e294a3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230523170927.20685-1-dave@stgolabs.net>
 <646d2a394342c_33fb3294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <ho6fq5f6dd3bj25kidhsnwlqj2xgd5rmjkh7t33lmaqclh3a5f@5udgwp4nvsfe>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ho6fq5f6dd3bj25kidhsnwlqj2xgd5rmjkh7t33lmaqclh3a5f@5udgwp4nvsfe>
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7418791a-0684-4d62-cc70-08db5c0e101c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4/F+4DRGtNp4SeshlIzhRBdc9hGWv8sBj2LVHCiGbyEqFGfY+57/j6G6j4tQv4N7VmuWZxsxr/5iouiyRBUqF1+xdqLlck8HbSb8ch2UyVJnYVdP1x0aL8wP2FiDHh1IEAixQropsamsJM96+xQyMgtLCa/dq7iA57iJd9HCJrCD22v6mkiYz9+23U7BqYXmlCZc8qfpRVm9vNWdwtp5iaZYEUg5duzGLtqiRNyBkJuNEdRoetEVyzDuZ/VuiJl2lPwtVyLS/s7nPmldDIMj8VgoG2Od/3wq3x87kN1W1nNvfI0Uf3ZqTR1bLehZ5+/PjUHwF7cnI22r1104XXJtnLGUmUtd+a0AgYhvHhpmts7oNK7dJJp9BwsgskqIw9ZYkF3Sxv0At1UFzYBEnR3fWcB4QVhVleKoPTXyjWVjsCtwFokhg44XaKn1kTQ51npSUnkxKko/eQ0LgS5nFAbOaTvPUgXkyTCOH3P9po+MLRFYeFMyFaU/CmigSqe1r6OY8rkuFjDnStjNc0w/XqxtyQFiXRkAf0zcuhEE4Dd6/kLR8Gm3QNAiel9Yeo1qrZe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(4326008)(82960400001)(5660300002)(8676002)(8936002)(86362001)(2906002)(38100700002)(83380400001)(316002)(41300700001)(110136005)(6666004)(478600001)(6486002)(186003)(66556008)(66476007)(66946007)(6506007)(6512007)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZMoPRnsq1BN+CNEvnNGeP8/1sF310BhIEoe2kvIfpU02ah4Msdj/YKdiBbe?=
 =?us-ascii?Q?DAjAXM2TMJEkU6IsSOx32nosxeVOHTIiuLLzr/tvsTbl2GWE4Cc+AL2s63ZX?=
 =?us-ascii?Q?w+wP6lqv41MIcRn523/10lguaupVbxOXAf5k0STQeqgOEJOHXjdBA/L5fMF6?=
 =?us-ascii?Q?cCjGNrs7cvSxoy/ODhS+uln9BAIipaBtYnrbaRGFJn/05EgmPmsQT/5uVVCB?=
 =?us-ascii?Q?LLT6kDCHh6IcnNO1bu1Ztx9OZCvjO99t5d7bfic3QKRD3oSjvoXqjUVrmy31?=
 =?us-ascii?Q?by0bkHElfVQxEsfJbq4I46hqxn8X/TgBzsCNM8YbCPPz3gJr59sCrPIPgOxt?=
 =?us-ascii?Q?n1HI+RqtGUk1izicR2u5KmakM802f4j7G5QLTNLqONnATph+1GLxLGe0NPgV?=
 =?us-ascii?Q?ptUHDoP4fb8FrBjizLMvVj5pbLB0fzjHhnKM9sRnXXys3rbWnVyudEVARLWC?=
 =?us-ascii?Q?Lh1TVQCFcVCJR+58IdKLFeqWPd6MidZkpKSr/pyV5AYUMQSV00cwfiWxZ7Lb?=
 =?us-ascii?Q?XrHtkonGlziz4wFok5FRoOdYT3RcbTgknerGPMheGv+lkwALL9bt/JweHL9g?=
 =?us-ascii?Q?d2LtyMQvvvr1nHk7FIFOdtOQefxtTwompS5XGjGHCsebZZ/LSvq/l6loL25R?=
 =?us-ascii?Q?ArTy9xzQNhBtjCrCrvaUwN2FjJVEbPCEVx9X5tYkC1hscQVRpwjVfm3HEWVk?=
 =?us-ascii?Q?K0z+PspRq+wnFlTdEHsZelhBLWE503t9bjb/+aFzRvhlgqs72zdBQnFfizxX?=
 =?us-ascii?Q?+rd5veGaUv6vTMh0skOO7D02A1DxL7lNaRpNEXWML2YtODaAUHcclLnEsvqw?=
 =?us-ascii?Q?uH3z3MAUL6sPGQEcb+EueJKOxTL7TXQ3dQRJxiQiWNNhhCwvlFx4zjZ5ZMDa?=
 =?us-ascii?Q?zcuvRupchP7rqh1VUqL1kCZ9mEdNGldMSqcOpLbX4d0Y7wkGHeQ1elAK+DMa?=
 =?us-ascii?Q?8GET+fjh/4H0+GYea681f3to1DNQ2VfLZgvRfY/2eGPoEZMy6+ae4K4LuasA?=
 =?us-ascii?Q?wvTXjTKl705ceTmZ8QnLXqugL6JU3ASB807GPbR2VRyo8zjeepTH6M9vQUv0?=
 =?us-ascii?Q?y+MCDkfvZaeVsOSQSVBWtZS7Ad23MkmZFEwmMhhEWXEb/QA2OQCKWU5OUTge?=
 =?us-ascii?Q?KzoQI+bizh4mEuYka9yPh5Zytf+Bp52msTMnu5ur00AjaJK4jxFaMON/4Ux0?=
 =?us-ascii?Q?1rJ4roHkyBhMfwx/ocppGYIN41hVAn/OsPAAyZieYv+z58SIWRJCFelWY4N5?=
 =?us-ascii?Q?j15Lc0LkHxvFlpr6DlnpSdRFa16MNnt7uiXm/544Psf8F9PwxKlzTjQn5JPB?=
 =?us-ascii?Q?O12NeMKGiDTbULNmrWly8iBKCOFbsDogl/YdWlDTqk6kgifTGq1FxFcoRy0z?=
 =?us-ascii?Q?PvOgeCSt1D5j64Jl0r+fVo6Dfm0Yb+ySGhbbwDnuDdp8OKMomn4L5oFgezjV?=
 =?us-ascii?Q?W1TRHWqATY9dMsfB2lDWvV+IJfqiQbMH7p3kG+iA3Jh9vhRcM/cyyha3OZrL?=
 =?us-ascii?Q?hx8NPbGkranDoC1qAPggzKKNIzyFJbY0z+rUOVrr+d0nK92N1gcBZ7BSImz+?=
 =?us-ascii?Q?3BsESPa5cOJCth/PcNbjnL5+/wqIr70412tgPvz3cbGbvhnrWTKfqIIaAJJg?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7418791a-0684-4d62-cc70-08db5c0e101c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 04:19:27.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc1PRs+pUJr3lAtmBv7X2tFbgkcH8P0E2ktfQwmVfVBs9sRzqs3Rb2jZ1Wz5C+ZgHJHmy+3+p2rSTUhZY417FJslX8ULX1yNXEbnoqy6yVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6423
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

Davidlohr Bueso wrote:
> On Tue, 23 May 2023, Dan Williams wrote:
> 
> >Like Linus I want to see the conflicts. Whenever possible base on latest
> >Linus tag like v6.4-rc3.
> 
> So I'm clear, do you want me to resend this series based on -rc3?

No, not this time but for next time my preference is "when in doubt, pick
a mainline tag".

> Frankly I'm always confused as to what is the correct/preferred branch to
> do development on.

My plan is to do better about publishing topic branches for
work-in-progress items like this. So now we have for-6.5/cxl-background
for this common baseline for sanitization and firmware update. At least
one of those will need to be queued before this topic moves forward
since the new infrastructure needs a user.

The problem with picking 'next' or to a lesser extent 'fixes' as a
development baseline is that it ties unrelated topics together. If
something happens and we decided a topic neeeds to drop out of 'next' or
be rebased, that's much easier to do if random topics have not grown
implicit silent depenendencies over time.

Like in this case these patches do not apply to v6.4-rc3 because they
collide with the movement of cxl_await_media_ready() to cxl_pci.
However, nothing about that media-ready fix is needed for background
command support so the patches can just depend on a mainline tag.
