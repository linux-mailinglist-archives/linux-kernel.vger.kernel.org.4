Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFE66428B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbjAJN4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbjAJN4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:56:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C660B92356
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673358861; x=1704894861;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oxJb91RDgRYw7n1T2G6NjX5+JlqB5CW4Su17TrsQ474=;
  b=mgwAOXtWF2k9yetWQQdDwKOEbF9NT/DB55lZmd89/lXmCez5kNenimgG
   2b0RD5uo7vbN88sKlmBOmWwJeQz5GgsRtp2QxcL6F/7lLC1XcZGjhPGmK
   YfA8+pnptZDNtKAiA6ad9PaSXhNBOoIBgyPCjmNlz+t5AVQI5dX4d6JTG
   UDEIFStEQJY0piR74lG8rx8IOj+9sZ4e8EYzvgbyE2ObxCmjhOgp60sXF
   x7FTPVPzzCPST6kxot2xO7DuqJuD67tuhrICOJFcXNABAfPRYqDn5f8Hb
   8W7bHoAtlmr38YHU8Gx5H5u5upsvucA7zIK307U0oS8EgPj6N+uOgWkUi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="310948069"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="310948069"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 05:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="745783476"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="745783476"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2023 05:54:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 05:54:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 05:54:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 05:54:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 05:54:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQNrYcJoj10gP5uq631dWK1WSAGJvWrGtF2QVYwkFElGJHb6nnuNY49+TABmv+89D2oBRwHMg+hHQUL1d17nVWgDMDzX/8e0JCxreYh/FZWf30K4UAJfdJZYmIwJXuMgb8uH2FiG13MnAArDO6JkesGvfVq5OOpt2jiKSxOuSQApGDp72s43P4CmfoJ0NBn682PmCuzU32GmK3h8ACnkyJjbnzYhSrUabcX5C9lWKNQyTjB3Grh6WjwPVfPd7VBoYo6F4zPa7Vk1aIfDHnGLMrQ7ZpTB03UUmPuAPPPlEkY9lqm91LLmSKATcBPvf7FftuTYGXqXdklajgHSOASUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpwvjur2CYneN2yUJktzF7TGQzn95LCCr8KFSadukWs=;
 b=Z/+EIELpGHUvsj6FiMomZ0aDVk9hsurSQ4ieRfM4UWFha+Lw5X24JLR5/Jc3v2VcpUnomvUoGfpw2COiyM8NXY2Sjc+GnRB2onX/Q1nGeXt3s0HJzdP2gXpHSNTeFhrfWjpvCjRBuPUqsLT9dQcI6g92kB42BccAGDan0CETPk0iu4fogoj4cT9jo2ER6UcZDJ7WC/K8MibUkA52yJPscFBQxgPzHA817ZIWX1oWh+erAj+u0UN4MyPyVqhOL1wIy0swyF3HiSLN/Ss0U4aeBiUL3FKuJlmT9/tWPaIul+9HhBDY6gNqE7LF28QCJ/oj7BU+wOMTWbGRyErl7ynP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 13:54:05 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 13:54:05 +0000
Date:   Tue, 10 Jan 2023 21:53:55 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y71t89JMgtRoNHM/@xsang-OptiPlex-9020>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
 <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
 <3f7fa3b3-9623-5c4c-94b1-a41dea6eaaf2@suse.cz>
 <Y7weKyxIY+QFYq6j@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7weKyxIY+QFYq6j@xsang-OptiPlex-9020>
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c060ea-edde-460b-31ae-08daf3122385
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMaexlhVeFvQ8J1b86Kzml4p4rbvCMl4KuoHtkiHIkDMD+H4WO5UOAaPOwm7dYsrzIXEtSbF0vx1+JGuKPg3cgnYX8p+qOF2156w0f6ZY7I08Asza/P+omzkO4BygboQW26Zw9vzBF2tY7ad8pBihTy3Ce0WV9d1ykvirdU1ucZhWm/9ef8XZK6FcbzHs/XrFRg50z0pb4SUSNPsm+hWz+T0hV8f1rZBhBG/qNY9Ij/UpQmBPulvV9WcZe8LceWp4yWCIQr0RbD3E6t+CYhYIAeVXThg7O9pyQgAuZI6bfBCRsx/nrUjniOcMcLHWZD/5I4RuXcH+SAymgTm8fEryJSjsNtGQhVlaTl7if84h2M9QJohSlhpcOokM0zII0dUsvBBALtx/8v2Fbps0MrkN4MtEkYJBqNddTlHkSUbWByzLNjLmJ2b4Di5SSn0wy7HU2gRGsJcRgoMjabs8GThYQ90nv8UPcBNSrFKII3lxb2KYyZjr7xx5eTDIMMX+4KKY2rT4nlJmgYGp7Q3XNO8T7kiTKP1niuBJ3A2m1YA3sq9sWFb+9pUcztV3AVAdawYH4L69pxfKO509a/uSN5HjJJR1sqREnpJ13HbDse/uyEmKkca2Kwi/azeo5iKWXg3CRwcC3meks7w8gDHSJz1bD18hMbzknJtUN3rNVaXSsmimVNh86Mbg7I2Nt1C7ysp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(316002)(5660300002)(44832011)(33716001)(26005)(6512007)(186003)(9686003)(478600001)(6486002)(41300700001)(66946007)(6916009)(54906003)(4326008)(66556008)(66476007)(8676002)(8936002)(83380400001)(86362001)(6666004)(6506007)(38100700002)(82960400001)(2906002)(579124003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?roJBT3RICc8DNZmNRHNcnWDYn1hYBp/Cosy6oTq/tV7a9XjC08tZLebrIbeD?=
 =?us-ascii?Q?wjqiAPX2opBMcWxmYQE1KVWYs07EJ1TWeLmc114mqR9Dj8Mz8l4KodR4qCCU?=
 =?us-ascii?Q?laD+8gVahgxm6kKHjA7sFa/K6/at7arECQch7fQWzZ1JXOcoy5fknl7PvXe4?=
 =?us-ascii?Q?OV8X9UUUSWBygTnUk2LgnGcSHTwOfEvo6N2vsRkkonkDI9VGgXNDMIc2knOs?=
 =?us-ascii?Q?lHpWtEz/NQSlRh7O5ibQZNvgSnpFwfzYaqqBC1UI/grOPuDO35CagOYfpit6?=
 =?us-ascii?Q?lhMcvvqEVczG32BzV0YrbIDDTxx0DUI2ueiDHDe8LhxpfcFFEzazLNzHBawj?=
 =?us-ascii?Q?wvefoChDrONenzVVZw7V5Z11Z9AiHdyN87ebpSi2aQ1oAPrkZ7P6oueeMoWE?=
 =?us-ascii?Q?819PMPQquaxB26xZKr+UvyhvOmB3AFuRhBH8SXq73WwN8Zw+w+XkDZDqqtjF?=
 =?us-ascii?Q?13CRBjoU9YUKq7qdYVy7ogszC8yxepCZP7l6RviXIDeJDbA//mT0tV1MF2UY?=
 =?us-ascii?Q?7J+YDaerGZPgTiGRwFt9ImR4Ifhflbnqayqt1r1DYxE4WjFtiza0Xt6CSWtL?=
 =?us-ascii?Q?PStL8t4nZjZbaP7E2EIV1aOgWKpeX9gk2jO50tLCI11T227ATkt7SJsuyWbh?=
 =?us-ascii?Q?GCtxftQ+AJNNiNch5cU1XJkO4Yr+8S2McyV5EGYUt+TYvzmkNrW6reATpN+c?=
 =?us-ascii?Q?5lpLONLng4P5/1y/uaNrhw/6L/e7cT1HQtEIw2Z+mfmoNF0YC3dlZbj61LS9?=
 =?us-ascii?Q?UTZXXhAm20TygbvrklvB4vhgQrE4mfcI6FRnlwTn6YXtnglbBW9cZ7D2yLmp?=
 =?us-ascii?Q?r1Q+IvNxiIAklT7HwYJ6w9HZwgIT5RDwcoHHB+EIN9XWEG4yA4PUuL2ds0t9?=
 =?us-ascii?Q?FKghaFKADJcFkBR8Jz2i+UqSudVK9hpBUZzn3Vk9YJ00D6VfPs12ZLxlo9Hk?=
 =?us-ascii?Q?gYZ59oqI8wlLKGyWE3Snq9rbylYaaEj4fOSZ0+W4E+W8x6fPRme1AmehhUtC?=
 =?us-ascii?Q?sJh6c+/LT5I1hC9VXvqJh1gJAUj5dvNAOv2FHHtQb4CUXrSj0NPmy8nyANSa?=
 =?us-ascii?Q?G7eUs7qe8+cH3wv0kJ1puoM2rUKU4u3sj7uuBjnWbU3vDs6gfEr8bIB9P+/D?=
 =?us-ascii?Q?di1xcK8kwx1z7lUZ8wm6d4NVL+0AkECs0o8bll1O+X9u/aYsGXA7mBKZsdsr?=
 =?us-ascii?Q?5xBQPxlK5LEKOrWg3ZIt2ggMcE6FLxnmV161hP/SxsDLZJADhKm6wnFqFTaS?=
 =?us-ascii?Q?kVJhb20LdiM4ganV13Q5qKA0TJgvPi8QzUjTAzFguZgtqSsyaDNvnvbGl85R?=
 =?us-ascii?Q?e0OzgahwlkNMDUo2BW52sMHZs+k5K1OamNt8FbUe1fEOFA0BorGAyNNkjDgr?=
 =?us-ascii?Q?Wx6X3p/e7RNnHKwaLIWIQNsgohp2ftN/DyBDVgqQmP/wXW+3kBtZX5ughika?=
 =?us-ascii?Q?KZC7JUr2PX3+P+yv1diOUlYzOFLPY8/Hp49adUrIT1C3bJg+BNJVCVJJDI4j?=
 =?us-ascii?Q?dj31kn9h9NewjW0S3bPO5ZFr992wpQHXTqnPhdBG+gd4zx5zKuGYLZjARDho?=
 =?us-ascii?Q?HCP6RruWluv+Hvy1CM/H/GjAa1RcgrdpDZagi+ZUjUEt94rf95ycaBzTNbBP?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c060ea-edde-460b-31ae-08daf3122385
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 13:54:05.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PRTgpDg2pUD8IPtT1lXlezwH4gOT6f7nWKLwYnp41FzRdOPMErAJ9CNXKoQojXjgFmIlkYLS+AjSXQbSgaP7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
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

hi all,

On Mon, Jan 09, 2023 at 10:01:15PM +0800, Oliver Sang wrote:
> 
> On Fri, Jan 06, 2023 at 11:13:15AM +0100, Vlastimil Babka wrote:
> 
> > And if the rate at the parent (has it increased thanks to the
> > DEBUG_PAGEALLOC?) is sufficient to bisect to the truly first bad commit. Thanks!
> 
> got it. Thanks for suggestion!
> 
> since 0af8489b02 is based on v6.1-rc2, we will test (both rectorture and boot)
> with same config upon v6.1-rc2 to see if it's really clean there.
> if so we will use dmesg.invalid_opcode:#[##] to trigger new bisect.
> 
> will keep you updated. Thanks

by more tests, we cannot make sure the v6.1-rc2 is clean, so we also checked
v6.1-rc1 and v6.0. from results, we have low confidence that we can make a
successful bisection based on them [1][2]. could you suggest?

a further information not sure if it's helpful, [1][2] are both i386 based.
we also tried to run boot tests on x86_64 upon commit 0af8489b02, whatever
with or without CONFIG_DEBUG_PAGEALLOC/CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT,
we never obseve similar issues (also run 999 times).


[1]
boot results:
=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/1/vm-snb/boot

            v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
---------------- --------------------------- --------------------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |             |             |             |             |
           :999          0%           2:999          0%           1:999          1%          11:999         21%         208:999   dmesg.invalid_opcode:#[##]
           :999          0%            :999          0%            :999          0%           2:999          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
           :999          0%           1:999          0%            :999          0%           4:999          4%          40:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
           :999          0%           1:999          0%           1:999          0%           4:999         11%         111:999   dmesg.kernel_BUG_at_lib/list_debug.c
           :999          0%            :999          0%            :999          0%            :999          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
           :999          0%            :999          0%            :999          0%           1:999          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c

[2]
rcutorture results:
=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
  gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing

            v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
---------------- --------------------------- --------------------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |             |             |             |             |
           :999          0%           3:999          0%            :999          1%           8:998         20%         200:999   dmesg.invalid_opcode:#[##]
           :999          0%            :999          0%            :999          0%            :998          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
           :999          0%            :999          0%            :999          0%           3:998          4%          42:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
           :999          0%           3:999          0%            :999          0%           4:998         10%         102:999   dmesg.kernel_BUG_at_lib/list_debug.c
           :999          0%            :999          0%            :999          0%            :998          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
           :999          0%            :999          0%            :999          0%           1:998          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c

> 
> > 
> > 
