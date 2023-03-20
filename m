Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3A6C1E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjCTRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjCTRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:36:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C40328E7F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679333537; x=1710869537;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pen5e47sKk+rsJ/F/sJG12VCSyWJmSJIVNS0Xt+kjeE=;
  b=SAziWf5atpRwYBKvEzhdSBGWGuZwBGtKKQboKOJGkokUSO5t4Lp0cI93
   hOawlkRa9mREfla67Z2sKT5sYzxAWSCjyJ6d5m5U0JMENS7XP0Eubs/O4
   WvFI36i9vqTfw6q80rJ1KhG9S+fpzYH3b18LuJyOjG+g06r4FCKPLXK5f
   0F0npUp8DszA23hvQl/Z7wB8VGEz3livnYnfFmhtQV1YvAnm25kwbA6Zm
   o4la4AOpRd3KrKdwMQr+LP9ZGsd4iehP+UdiO0/j/L1BRdSi/tg9qWlbD
   aXLTY1N4Me+g0lGwgtZ64orn5DfBzR5mJkTCjwxOSLyj4rfFuIDGMxlgL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="425002329"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="425002329"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 10:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713648695"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="713648695"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2023 10:30:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:30:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:30:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 10:30:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 10:30:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk2nXciCteCwN4TEivU8VHuJre8T1DTXmLKnzDXKKIM+ci/TcyZ5hLpjdaLbBtAemWRuCVTMxOwTZlkHzjJcQlvZPWb63rPt8D965QCr3y/gm+qUMjxu70ICctF71R0Q9Bl6H6zjO9+2FO3eb3bYiEZumsN0DnqHrACQZIAYwO85mLzfdyTaqMjGUlxgj53NzPrIV5/a54hGp+ZpDzoQAhNwZgyzFRVqAsi4iPxpip5fX9ERO3TTgic3nMznUut3OK9rFSqypJnvg4X05vC37INxXM3c8qHskOxNVZPujlyYDsev42scNgcB0db5ccdhXvJ68MmyivJqrSxKJzKDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzGC03OiE9g7JG7dHjyL4DYvWPn0VWBwnVJecr8Wvkk=;
 b=QiHQf3eOtHom7lmo6eX9FAOlu6idj/XqCnHAFM77lxKxPf9m//EUdIi+kLSYdy5s0E0X7OBs/oUDBzlS6AIVWmcfwQ6ROzjtfFjgZjqG+sL27JyHfEL3Yyd3LhrGgqqtIO5eLLxYZa1SnU/8vszP7MztA5v+F6QYV8NV4H1Un9jyT4TWGCUdhDTosv+z/PivUtcOtOJ1EakjGv5XhdN5iMVECXbXPBxlU0ujDQlYUAQy98AlarBo8dqTmAqXiee0A/FauAdCSlP62zPX56Hbc6nUWHrPSBMLHtGrM5gu5ARRXTKwtoDzicUl2AALR5ZXLmlmF1uS58w1VU4TVFwtSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:30:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:30:06 +0000
Date:   Mon, 20 Mar 2023 10:30:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Message-ID: <6418981ac577c_1dee2948f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
 <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
 <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
 <641401d75d039_1dee294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <eae85bab-cdb6-b8b3-8014-2e7f3916bfe2@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eae85bab-cdb6-b8b3-8014-2e7f3916bfe2@fujitsu.com>
X-ClientProxiedBy: SJ0PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be83370-89fd-4e7f-46a7-08db2968bed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wUXnqGrod77lAVy8mEM4NB3LGAtmB2klurcfjCSEclIT6JW3xdOsnY3wVxfhEPQwxN82DICgzTZ9hh3dlqIoPjG/xNQd9xeKCzUL4W00F6x4kflog7lhkODIUxKRrs2AW7Wihd9NxYWkgtTHmW9GPYbfTtgZ8GWsAok03iuqMvbjBbvERHqIKWS2O3fKjjExBO2Om044T0jWlk8Ym0j8QXL9SN2rtjZXH3ND3OteFJ9zSmN+Vt6siVq+FdqmxK/oDaPGa69NAfiEYzRJIQFT2RRF28+IcEYLhcGga+tpibu5/BVGQiMmZV/gsj4xk9b9R3RjKDEWfF1hrnt+Vq6aRRhAEj9pMGKDvaJWKjTsbIMR3Op/paqGnB2aRbCifWFGLCGCyZZQqEFscJkcjADViRyX/3+agmPhYIIt3TIv+Vtq0d0k69jO5Ri8ggfRKgGSwmdS+37RpT871lNyO1cmI9kQOcGtyr7UygYsx7GZ5bE5szNpPyIt9APsT8haUNU6ICceAoY3imiKOBtYLznYm3Vr2BAgfBFAtxLTzxzmkcssQiHAvr9zWJttPMDOix3ecVUD888HXWSUuQYimZ3QWuzphcDEHxqas7WxqAgVXgxPLs6b5qPzRw0QivJMIlOlc2/AEkeViVRvPyZpoYClQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199018)(38100700002)(82960400001)(86362001)(478600001)(6666004)(2906002)(9686003)(110136005)(316002)(8676002)(4326008)(6512007)(66946007)(41300700001)(6506007)(66476007)(4744005)(66556008)(8936002)(186003)(26005)(6486002)(5660300002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yk87kjB5jPXcPJZkTOdvHDfx4hg46v0CfnM5ThSH3gI1oZpVQA1Q2mk0bJgO?=
 =?us-ascii?Q?raynx176r/LXPn9DpcHD7YX3VCuvL0ztKoUScNINRIWo4iRG0u7ebyQzPYX2?=
 =?us-ascii?Q?kSCcRKpWZTyd4iRBzyMuy7+rsR46WVVtPbT4Bblz0rwOldymtHcvrHWLF65e?=
 =?us-ascii?Q?4k8/artBBkBoBMhDKlnKGLRt1ZtDe6SC3HRqHz/PYRchVAD0KIVlA1Fn+0rc?=
 =?us-ascii?Q?13nq/uYZjh+ImpZoh1leQgKrwfck91vyWj+Ag+Ijbf+7apHm9B0Z8Sy9cwBu?=
 =?us-ascii?Q?Lbgk26x23kA6MTI332qB2RoFS/WSoS8kKql1kGAjO0d7o6L5OyGpbdFkLV51?=
 =?us-ascii?Q?RBGualNMOr3sdqFsQysI3B8Siml20UXaB4bMtn+L0hodpyt41b5ItXCewGi1?=
 =?us-ascii?Q?2blepN/O84nI8nG42y9dak4gFvKKwL6M8JgVr/cZ+/IAUgHQdRFDgPr6kjqB?=
 =?us-ascii?Q?4sZuy20CoadHFPi/b6wKytklIf7ocWsdd9oo5Xb63X7lnudUsAaF3+VN5B2D?=
 =?us-ascii?Q?8ym6JUVB0gJS5y9eNpgJg3CkKPp3Jq9RcOmaQ/IcmFruW43r5Xzwovjim4wC?=
 =?us-ascii?Q?M/4WBnFtK55Nmwp2oCAWC8acRwBI5Qm/cYdws5VLR/GkOpd+DNCGCb5wX+D+?=
 =?us-ascii?Q?907WbZAHiRu1XSld4854RYGasNhguvpMrGzZTdRX6arqTQS9dGtnAd3WvxhZ?=
 =?us-ascii?Q?93usUoZPh4uSbxo1wwNr6CyCs/CI1SjJ7Gc139B5Tt2Nq7w28TUrvLyjBU9I?=
 =?us-ascii?Q?pO/N12oAwoxIXi5YsgxKSqWMXNpRBcVQa6FTWysmy/5f3zDZWYU3pAhp3tFL?=
 =?us-ascii?Q?cvdwxZNFlgAA6BdYvGR8il4aE6Pn4CR/3NGVKCCnD+HCoMC1MaRb1ZKVQnxY?=
 =?us-ascii?Q?mIVdq9B3BSSgytsQkk0n8aFKApjjS4a31qr858SPp8N0N0dSbP9sH83YQND2?=
 =?us-ascii?Q?fWsgRwuPr82yqeYfVIuanvSJDOFvbKuX30Q/blRC4ZJhWXUNfBKe7XFlw8q4?=
 =?us-ascii?Q?GURm6EV5n+cB38Wscg2DhZUkVyMO7A/cIb3/k/ID11ln8j8VXGOfcc1nw7ve?=
 =?us-ascii?Q?D9WZ5lCpTAKXHI5i2Cls3pogxLhrJo6PgGgRyIMcjIZFm2qeWQ8AyRSk3QIC?=
 =?us-ascii?Q?Sm2oH/bL6sVpgTzv64aZQeCCcmyRmxhE2U9ODVqKKCoEze3HrT9nP+Vg2agT?=
 =?us-ascii?Q?dRzF9BJiS0qjqn6Va4yFvwYzocfAkghKC1dTHltPyiDzVSA4PzWFH+2XBZi6?=
 =?us-ascii?Q?JjQlTMBTZtSE/Zbv+z62CEKFokByA+hPlqbalOjKoTY3bWWHTmSe6jR79gXg?=
 =?us-ascii?Q?q4j57O3waXuVEKfZZDgnQ6QzZyPTszaoLBuqLezvwyXyoOBYaOYX63SzD7bk?=
 =?us-ascii?Q?nGegW3dzBTQmFz685AjQW2L0q1csO1+nkNB4wXfjhPSeteIqU6N/Wbe6uvJP?=
 =?us-ascii?Q?Ge0Ge8Z+dJK3V4ozXRtDCiL7cqn5igIaqhtY1EWKy09DyvCHnr4aoT0x8t3Z?=
 =?us-ascii?Q?OhAiqODznJ+wMfzTfB/Otj06usv+H6jhMALTMdVnXiwtpSV2MU6gvzECM5TG?=
 =?us-ascii?Q?zcCf4QnoEuCaGaqr10zmsgMALy5oclPSFdpIpP0k//yV/30M7me3t4otfcI3?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be83370-89fd-4e7f-46a7-08db2968bed3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:30:05.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oD8XA0wtfWoFzsifRqTG3IBsgrRTerFCo+cAdyXFBBZFm2CymIQ8m+xk6hw/CXiaoN+LisZjCWVJA6uoopzoPJX1kc8V3Blvdc2DGOpZyUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lizhijian@fujitsu.com wrote:
[..]
> >> Dan,
> >>
> >> Configure the kconfig with ACPI_NFIT [=m] && LIBNVDIMM [=y], and add extra kernel booting parameter
> >> 'initcall_blacklist=libnvdimm_init'. Then kernel panic!
> > 
> > That's expected though,
> 
> Do you mean we just keep it as it is.

Yes.

> 
> 
> > you can't block libnvdimm_init and then expect
> > modules that link to libnvdimm to work.
> Ah, we would rather see it *unable to work* than panic, isn't it.

That part is true, but consider the implications of adding error
handling to all code that can no longer depend on initcall ordering, not
just libnvdimm. This would be a large paradigm shift.

Now I do think it would be a good idea to fail device_add() if the bus
is not registered, but I *think* that happens now as a result of:

5221b82d46f2 driver core: bus: bus_add/probe/remove_device() cleanups

...can you double check if you have that commit in your tests?
