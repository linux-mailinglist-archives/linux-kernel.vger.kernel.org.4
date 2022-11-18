Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4A62F3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbiKRLYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiKRLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:24:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B025C4;
        Fri, 18 Nov 2022 03:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668770609; x=1700306609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CPRqb+N9sWSwuA8doPF+bdmmjaG5kfr5h+4RR2E29Mo=;
  b=cWhfrQEzrzwBuABYHj/S+MUYdVRVSo8p1g3sqIrgUCQ9LUuQstb2OaGc
   SrwDngu0INf0zVWZcsalm7ck6cRt/9gOPgP3Lfv3LnwX4r1p5Qajx8K31
   ANYuRAcN4lUf3DT9zFBfxuWwEXdAPMtLxT1hHiqnuWebIjAz2IsP8BZoI
   InvJ1PqWPxc3EmsLEBj63s7PrIWLUz4isDuSV0StHlN7OXh3nGIW9Bopc
   byNlQu5J/gNIF56s4KwtJhof+50jdStWo1WN0b+/B/hdUiqN/3yuYIkpj
   y6AK2Qi/b/Ui2K2KXOQV42fCs5H+NI11bUO44+YsYbL5CGxPrtMbFjtBh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314933887"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="314933887"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 03:23:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642485162"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="642485162"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2022 03:23:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 03:23:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 03:23:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 03:23:23 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 03:23:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROwXnvCzIgpuFN3qMc2LVtwhDeaJkcymkb8MmTaqQSLyD3xC+Wq4BvS0sQpkD01NmCRxil70oyhvMX4o/lj2/pMeECKMCnFaS61A9WMQhFV9pARv6ZR0H76BGfXFRKA/QxqCIAlUtJ1mLAbGJIVgFXiKgD97E8HQycR0ZFUtFo1Ot4m/ndOTXL3FcIq5Prxc85L9cpDXJnaINBi3Z22kqS81rQsLiFJR19azBuB/UTXKjC+F9yMfNplJIy3aqSl0wQvSlzkV7S/GbnY2i9iZtaHIvhTr+/E+gCR1oHD2Ut3dQqnnVIDUtBwH5Bzct72GajljOWDZvk8/ju3Ju5XKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRSz/iOrwKzAG9uAG4srK3KQJb6LN0RgmvTlm9nvq1g=;
 b=JjcT3amrj1W3au3gDn5IvsULo1ykkmGwabg72JQ7OrXsbhvaBw5m1vXTU1D2afu+4QOgb2V+L6i6ivmZAq+kGespaQQ2vYdHDCE/RSbh4+9tNPRxdbHE7DN9/ZWrWhx2/dyG9bp/5KOYlIjMTM3zazgnW9jMSp7RmaU8JwIMp3t2oVR43htcCpa958WzIeckkD29wFGo1EF+OIarmoLTKBNPvTQqnfzFo2jsuZ6DUPhYvpymo2VkNpsnhiipnyLU5jHgDZsGc3STD6/y9TrP0O03NzE9YJ5Q5y2F1vGInhh5KrJRc+T+dK74ukIzwuFLUpOO5Ww/lEYPPxP4ZoguaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 11:23:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::3849:238:f7bb:f1d1]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::3849:238:f7bb:f1d1%7]) with mapi id 15.20.5791.027; Fri, 18 Nov 2022
 11:23:16 +0000
Date:   Fri, 18 Nov 2022 19:23:02 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <rafael.j.wysocki@intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <guohanjun@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] ACPI: pfr_update: use ACPI_FREE() to free acpi_object
Message-ID: <Y3drFvDUME3vYIFD@chenyu5-mobl1>
References: <20221118063219.2612473-1-bobo.shaobowang@huawei.com>
 <20221118063219.2612473-3-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221118063219.2612473-3-bobo.shaobowang@huawei.com>
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: 502151ad-4250-4b4a-8e36-08dac95749dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfRD7KS1hVMGEdukS8rir3jdsBs6gmipvt1K0hAZ5CATgRfZ9RfAYIugwhmfO8gbdL1nf1EA7YEPdSPxw89MMx0E7ZqAva+xw6liKnV6O9YplB5svdPYZOx4zZpIeRvY8mxyuSwTk8pm+78wRjbPJHxlRsZBHGVvkKKnWgvGQitkarh5Nn6aRBCdlw8mDnhClkMzMj7oFcDcvUsqsj+qhmcTE+/9PCeq9CZfedvx60qcJezvCYbFfdS2gQfg6Xok8zN+XLxQnRWe5QUXnXPqOVlO47xNZDo3UuQHltGB5mhczS4MsPry7pSkTWup1j+sQ7iIIfvRIILk9Uko0zMbLBSYI+TxJkaOITjhNXkI2KVGjgC1qbGDkyCfaM7+1VC2PzzBtsqFi4LO7PNh/Zk9oR+YaIYmWkCmS68is8bpe1v/B0RxpCn44bgTw7cLXXnBHEyhvymautJd33c6lxuYgz9ZG93PIWgD3bxO+tUknSjEz5O5esVBm0bTvJHMg+FHTmozUY0uX8TK7r0vBaU6CsERmD00+E4xy3NYCHqAHMw0HmUigpc55Wy+1Zo9Ul66ANzu3ZpH+l3ouuiK6BGuiWbWCu4C39wGj6ytsdcMQ4KjTkTrnro5T8r4mbnxngvLTpzpc77ANmTCX5nFLqy+zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(26005)(6512007)(6666004)(53546011)(33716001)(107886003)(2906002)(8676002)(5660300002)(82960400001)(6486002)(186003)(6506007)(66476007)(83380400001)(66556008)(66946007)(4326008)(4744005)(4001150100001)(316002)(41300700001)(8936002)(9686003)(6916009)(478600001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JC6qhOa6HBpgaCY8KXGie8T63qOetY5JPAIgknUIkAD13IG9N3D70puXG2a8?=
 =?us-ascii?Q?B34vZggqVVKD7Rr6Po109WOKo+9b5/KF9HGzVJxA3S4ynCBpiUcQQkVFJPYp?=
 =?us-ascii?Q?ogC18X5oV1kQW9IKoQjcRsU3hksjyXwMMPYycrNcutftbjq3GNOWm8vl9pdW?=
 =?us-ascii?Q?ZOHkucJcHoVJIF1RGzf5+JKvlfvUj7NhTlkeLYMRPxCWgQSLobsRbIR1hN3W?=
 =?us-ascii?Q?Qhf4MXzXMA8J6WgkbShx1fft2LGfoUSOk+K5dGsJayHOqpTixPeRII76sFZx?=
 =?us-ascii?Q?H8TtVRwEbT9nmN64HkjvuKvtWtWcuqxvCG7DV7m6zfBZa+Rtro9zBmGbii+R?=
 =?us-ascii?Q?lyFCu9aV+e441FmYu1retXBtSYu2FDW8V3A9bjfLZf/MMbjR2vAvVtlXKmmq?=
 =?us-ascii?Q?BdS6l/aQvEaVxig9bhHCy+lLYwse/Wh4ZGhC7jtv0UsC0jDMBCsGidDOCnM8?=
 =?us-ascii?Q?ayf/jl8+W57hMbfaqSyv5NOocmqM3neu1SRL0Rf6VjaBkXPsIT/U8+8Wl6fI?=
 =?us-ascii?Q?rJKhZ4+brVX7a4JYs276ZNj1YXzTTPZHDgA4c+2VwtW/6mhhZH+Dc2qBzEEC?=
 =?us-ascii?Q?cjkqxs2kvtg6+yIrbXNkrUWZW+pFvZmDWCr6t/ApKqIisK4PmO3WTI7m+Q0p?=
 =?us-ascii?Q?Gr1tbAISo+mboJgLDrafQpa+cfv49R4ylvq4ztba+LeVqQWoge/2FyveQt5L?=
 =?us-ascii?Q?c6FoE5SWF9Wpc4xQfgmA5ezJhp31oiAsgP/0FNBGL3JLzR+fTRkp6T97EmP4?=
 =?us-ascii?Q?NpZ/J7xgsqCIvTsDyvj1LfNmBPxnTIO6M0sg3YkB+0G0abntrK3JnaKDrhb7?=
 =?us-ascii?Q?FchC6cplOuNXIkfO/9oJChPaGD8NtEHb3OPGoADybQ8dI/UwAm4G6ooWyRQx?=
 =?us-ascii?Q?4j6aFxFuUzwhzBgMWMBY9Quid3tgwHGyFcxw/wg+bxbN4lExv3u8AffQQLmi?=
 =?us-ascii?Q?MiijLAWCjRld7eeO91RXGjE92O5P8U0/RVVS4Q3sp0ttI/ovOETgvJJo0yO5?=
 =?us-ascii?Q?TArE7KVQaf879beX4guUh0mqKXXS+5uvIF34QkJgre4XXYxuxBqsmgAIJz2C?=
 =?us-ascii?Q?s/Kt8PFx6PBcG6HrE6XpULMyVTjjh9nC/PvCGMgspamLQyDbYcNIN+f1JZOJ?=
 =?us-ascii?Q?gJLWPGGrAVIe9VEdRfPWMSCTbxcWy1F7jkzgm4Lfc70iAJeKbSdyUboMfBL9?=
 =?us-ascii?Q?lueUKfmUv6ZJxTHcgJiOccmFUUKP+UcbTSfW+isAOuRRuX+Qw6LtJ3WCVIWZ?=
 =?us-ascii?Q?iMZsY5PNhLx8glx4j8HShQ00D9gMTLVRi3frwBZd2oL9of2eVifVg1BHfWeR?=
 =?us-ascii?Q?TRUD9N3JvHCM50idU//cGJ541K9n/QV2c/zR6U2nVWP3n0q0flEDPMjYoy/G?=
 =?us-ascii?Q?+2/HHAif1HLtv5JTQE+G/Rp/SKg4tZBGhjz2sgEwY326x+VjGPfJH0OuYrPe?=
 =?us-ascii?Q?1Qvi0V+l7gIXh11yIfeDurmlL6nNDG3iAJM6NkkFcVUqL151xqmFjn9JMj7B?=
 =?us-ascii?Q?bZfwksiSieYaWXKWrffEvMmWqen9Erd0bkPn4IjedwOSDfQS+VpawxhOzxVJ?=
 =?us-ascii?Q?L+gVjQonXmxud6c7fRZMVsX6sLBSAXDkf+uvGClW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 502151ad-4250-4b4a-8e36-08dac95749dc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 11:23:16.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMtJBp69h2082hIoheAN7cwpNJ9NnIxNMeACbjY9bNg896fZw5e6+jmAXuE47h6Ui9Mjl6S8E57nafGd6TuuVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-18 at 14:32:19 +0800, Wang ShaoBo wrote:
> acpi_evaluate_dsm_typed()/acpi_evaluate_dsm() should be coupled with
> ACPI_FREE() to free the ACPI memory, because we need to track the
> allocation of acpi_object when ACPI_DBG_TRACK_ALLOCATIONS enabled,
> so use ACPI_FREE() instead of kfree().
> 
> Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
