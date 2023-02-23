Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA66A137D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBWXGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBWXGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:06:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD834DBE3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677193590; x=1708729590;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oMq/9wtNcq8S8rdvRNkYnjdeVn2Drny8Dzhwf4vMjYI=;
  b=DCoj4ewB7AsRvF5PX8+JuXnbyeg6pkh0KGJbH/pWvphIlIu+ztK1YrvU
   MEz0hTnau761gkkGTfMStL0xKHg2NGYvPFxPeltrYb8DUPGfJ3E4xIwyz
   CdmbGcQD/YirlTst+7iz2F7UkpVUjsey2PwBDcHUrdx3uxjGAj6YeqpkE
   sPSXGGciy89wesRQrsCoLOWikgd5KiOq3D6HDUpxcfbsnHubbwS3F8Ywe
   dSETkbg7YAoAKpYFQINPGPlJblQNmLd0oMOzGew2eljjqKvtX7HQBn6v+
   EpbX+KyjvrwnriiF5yWR+QbmwRa/sEv7kvlLkqTO1xKa6pcSQRj3PtOAW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="312981436"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="312981436"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 15:06:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="736579953"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="736579953"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2023 15:06:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 15:06:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 15:06:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 15:06:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 15:06:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNqcivTiBmGiFmsfEp5hAYaHj2anB+i62k4A922Ku+5wDrTbiGgWkY7gFkv6CKrOwZ0GQiBK87ReYfOb2FBM87xeoyXp9Spsc0h2nJyXhVLID9HeGz9eDm9s/HYHY2UBEbEXAAlMfhxYvmJlh7IiAutzL4jQbsRbppY1P/JYGPxiedS1Tc4NrPv8azlsLiX016BcdTvOcaGJSkAjtZFf6nyvxsRS/UMHy32ZOmUR8Jrf1WubxIykQZgU1iRT1iQ1Enb387JWaVWl+7HdWhe5bUIPzzydW1Attxkwhob68+Vtd0apWnGUiZ1PfmtTpIhn2EL4VD8z9bNTPJGVvHIveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apM8EjMMBmJEkNnHjIQlnzEMaFEoLu2lIvqtLknso7E=;
 b=SpZzdMJbdBw0xAv1BDkZb14Sdz5xPfuCZtMcaGwsihQHwaXfKpfiFh+iWGUOlyuSLNOJ/IwHlWzCUiemuAWgBoYmyVS8BMnH7NncQtP5O/ZVT302wX0b4L7rXpQpGTq1SIcvEdRQ7CtH5R/Mm9lKHXx2unNi4egX/1tGn1kVHE3cXYmrurMh7vtxkETsOFq3LdFg+JKUkCuyNI4NEmcqdxqv3xSzK7YDxwiNpQ5V9ERNn9BBFWccjbO7aoCsCCfRnLPlF+zLgdkffUGptbRvbWrMnvuIyc9WJudvjibhVhtAQFVxQKUU750zkplElh8xJ57LE+4zGxmaJL/wu8mk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 23:06:11 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::8336:f7ca:715a:b8d]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::8336:f7ca:715a:b8d%8]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 23:06:11 +0000
Date:   Thu, 23 Feb 2023 15:06:06 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] libnvdimm: Fix some kernel-doc comments
Message-ID: <63f7f15ecb595_20753229494@iweiny-mobl.notmuch>
References: <20230220071256.72513-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230220071256.72513-1-yang.lee@linux.alibaba.com>
X-ClientProxiedBy: BYAPR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::25) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: ee29c754-7965-4f12-bdbd-08db15f28da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hbc7BqGQbZWMjYRoQCYYQl070rHQOf8owyvbt2abjaKVoupy4YmhScYe8TDnnRfEcvOJyR2Bbky7Q9N41mpaebjfCam6NWm9TNNgSmUP9qWvHcCLOEpgcf8KapqHKzxTHY3GG36zWBzblBr/uXfvxz/nSlR53S9OsqUI82zWxl1V9T6tXNQ0i+oJI2z8XD1UybSQW2zx5eHUD3O7kx5whfT2TwSfocnJsi4LXGwDbL23s39IMiqdbhJ6/1urlbuPq43071rtDllf2WOg+zPax7fNInTSQzcvrBwl2wwJQtIFqQoLDNcxRd5kAKoj0c0P2ssBR/5yc0x5mYLy8HoSIMqF6gpnyi5YXqnN28MZNmEmb9B+d6u9Kr+kIVpiQNP6o+eP47bYY1qf5GEGCFKPavyZIjyGYagzQvI8WhZXtEAfysTCtq8zeFmbK9E/v/tsxWuH6Pt7e5YZFAZ605+5MdqON8u6E8ORabrgdB13O1tgNmJKyAWxfL7LGJuJn+KfWxGf3uVNlQOeuW4NzSTq+d++RSoVWLvO4yeDmqKvbTg5HeAbeShXuI6a57sRPQCjiIBaoZMPrBv72vvRqyxfUCddZaaqfXstIzIW+fflakMmYOfj4VM2lkBJSoqVEnmo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199018)(2906002)(44832011)(86362001)(82960400001)(38100700002)(478600001)(966005)(6486002)(186003)(9686003)(6512007)(26005)(66476007)(66556008)(54906003)(6636002)(83380400001)(66946007)(41300700001)(316002)(4326008)(6666004)(6506007)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AGjqcIJbO16Uv2Dlotjb6gxmIgYNyuIKTTgbkKCO7I5nQZH01SeXoYWOCdg2?=
 =?us-ascii?Q?IsSyNNsVwixkeEdNhjSGClfSv4BuT6CKZg8tO3gKJicYcQuenCO+axlXKbwN?=
 =?us-ascii?Q?RKtLnoqQ7IUT21BxxAr1YB+ZSYpN5nYxILszoFPZkJbGHTZzl0JdEifG8ozS?=
 =?us-ascii?Q?2CyJB/waqIdgDAv3vm66mIhrpYUqLufgwLe3mhx2QkHprtEhoBkUBmRPsoiy?=
 =?us-ascii?Q?xZqpERCY8hJJG6zR9zMbwrxjThel5zPQyol4CoUdZQx4VdtM78SzE4iqkXeY?=
 =?us-ascii?Q?dX7e0LFRpw6AAZI3fpEib7mx8oxaQ0NtBPe52ICJCwqwA1lhpZz0SjxV3fEO?=
 =?us-ascii?Q?qlyXPRItD33O1LjqSNewjmLiRIiFqyMyKcLDtkanZn9LQjdQUL+2FtRG1vWa?=
 =?us-ascii?Q?HkZ8vEgBaQBbhXNB/4YuRWxNOpryKzvgB0a3pm98CnyRP7gj7vctz/USp5GD?=
 =?us-ascii?Q?6GumHdNANYjLlRxQZS6J+YIE0iFsmw4d5PJBH6N1naea0yXqF2ntVICdvaxm?=
 =?us-ascii?Q?IRi2vsqMXlNnoNSa1TTucTQFsMk4Ehjyf9V+nKsMOYZC+qQ2dHFKmilyaKrU?=
 =?us-ascii?Q?DUu+y1UUpUz7SRWlfxEYgDXPk3W3hN7WAgCpM+fza5zH9l5Anf2YXcioH1LF?=
 =?us-ascii?Q?XdLmVa04JyJjkV/B7V5MlfWCZWfUrjcYlruzTWP64BjXwBMch2vAY9Hvf5ve?=
 =?us-ascii?Q?QUFYqymRHLwrJc4HN71WxJ5E8+PrBekwzyvt3Vw06i6e1N7ZNum3j0t6D/h9?=
 =?us-ascii?Q?8YOTGlPeyBUIH9lmCFIqinqsQfYE7Zg0SfqpOjMh/0e0Tr/KqkehmS7JKjcr?=
 =?us-ascii?Q?RMMM24br5tGtvEW+Te29WLlcHa8Cu1i/uxOyr1zqO+W33XW2LZ2lQwTRs5ER?=
 =?us-ascii?Q?M1SsUtuKdEFYvLYQDNh953nUjP6yulLvDneFyDGFt9R6pFuga6bvd4Y6i8ep?=
 =?us-ascii?Q?ZjxyeN1+/yBrPku7SvD5EkG4oejcDXgVkcdYbM1UbZ31wF36vfj7iXMDT0EP?=
 =?us-ascii?Q?s9KLjUKPcDm8u77rj2/1NNMyxrM/JQh/Zt/xOAmx9J6o4BoezUf+RsA7fNi3?=
 =?us-ascii?Q?CTO59MwE2w3sELuh/7QIY0NWQwv4F+yZYmoG5pVlWoLXvaJhlFRLOk4tV5K7?=
 =?us-ascii?Q?TR/UVrD+ARDxJQoK3MY1h7gNxXr/yubOn20JUk8/+u0GXj8QMiWMOXeEXHkb?=
 =?us-ascii?Q?2cDoBhve+TrfBj5aOZ1BroUd7UYFzZ+5QSGRFFnKdiOr4KZF8ordYLri4V07?=
 =?us-ascii?Q?QMFiZRvKZJWRls24TOE1CDWwruMD1X8RRej4GAUzY535JNjvDsmiYkSOXeIz?=
 =?us-ascii?Q?p2guwOriUbB3cGWRAAt7IRmflWum52Lmo6yNQ6AuWmmyK6UMB6Lb2XNWwbGO?=
 =?us-ascii?Q?8GTHLrRt9PqcwwJYyZFXBCqMm0SjueRPr98yDO5E3C8Z7tNmSsjWK0vxGHu4?=
 =?us-ascii?Q?wGemFg6F1gZ55ftSY77NcMXcPVYTwPr6RVLkwtVtwzrDuRuEXkwLgn4V5uxx?=
 =?us-ascii?Q?MaQHhdZO/MBmPLPg2IJaddTuJTyuJH8n0xtEDq+4I19CehUU4h4wvf7l6Xka?=
 =?us-ascii?Q?muxzV3DhCDAwuLvkf7NliTdMsdRCLINx8rb5agIZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee29c754-7965-4f12-bdbd-08db15f28da0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 23:06:10.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03OkvFa3MEDc76B+bKIvkQklod54Vo7OYuX1PubL0HW81ca5ibmKxzn8nuc8YJxtwQ6Di6Wyww6HsjJwSTDn6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Li wrote:
> Make the description of @nvdimm to @ndd in function
> nvdimm_init_nsarea() and nvdimm_allocated_dpa () to silence the warnings:
> drivers/nvdimm/dimm_devs.c:59: warning: Function parameter or member 'ndd' not described in 'nvdimm_init_nsarea'
> drivers/nvdimm/dimm_devs.c:59: warning: Excess function parameter 'nvdimm' description in 'nvdimm_init_nsarea'
> drivers/nvdimm/dimm_devs.c:844: warning: Function parameter or member 'ndd' not described in 'nvdimm_allocated_dpa'
> drivers/nvdimm/dimm_devs.c:844: warning: Excess function parameter 'nvdimm' description in 'nvdimm_allocated_dpa
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
 Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4118

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/nvdimm/dimm_devs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 957f7c3d17ba..fc152e6016ca 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -53,7 +53,7 @@ static int validate_dimm(struct nvdimm_drvdata *ndd)
>  
>  /**
>   * nvdimm_init_nsarea - determine the geometry of a dimm's namespace area
> - * @nvdimm: dimm to initialize
> + * @ndd: dimm to initialize
>   */
>  int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd)
>  {
> @@ -836,7 +836,7 @@ struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
>  
>  /**
>   * nvdimm_allocated_dpa - sum up the dpa currently allocated to this label_id
> - * @nvdimm: container of dpa-resource-root + labels
> + * @ndd: container of dpa-resource-root + labels
>   * @label_id: dpa resource name of the form pmem-<human readable uuid>
>   */
>  resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
> -- 
> 2.20.1.7.g153144c
> 


