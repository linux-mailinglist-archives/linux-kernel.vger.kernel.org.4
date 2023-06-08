Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885C5727405
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjFHBOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjFHBOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:14:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641C4269F;
        Wed,  7 Jun 2023 18:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686186873; x=1717722873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gO+lMUFOMtF86g33IEbbJRriA7EosR1AL/e/CfpKJkc=;
  b=H/DDclUnhZ9qZL1f0G1x0h13RfWK7fdTd/TPxeKTaHwqBnUd7le1NVw9
   vvqp2eqWp9UcUDdzRXQN+4tvM0AgqFF7U5Dsz9WdTyYRR4GyFr2flCWVC
   NfevmL4bpPPKmwGuAIUq17zNqF3eTDjBT6NNb1F1gLS+SWVawq+QPis5/
   P7j2M11089g1S42c1/xWM4MRiausw1qJm1fEV3t1uIYYD3WM63K4bXfOZ
   JLi97r26fMYESmgsuhoh27wkzaviYyDPVDCsr9vJWscsLoGVVO8SS/ygI
   ttALHFJgrLa6YS1FP5NqOzMsfpo9/xPsmifgI+BUdu8txh3c9St8vXPxB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="336785424"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="336785424"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 18:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709762545"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="709762545"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2023 18:12:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 18:12:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 18:12:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 18:12:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 18:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHBPwI4rW8eRhjh7urA/rbh8nyo4L18qwm7/qreuWvidp7sWmQgCXefyC3Px3k8gKkJz2VEGcX2/ewsNgF7F0REB36ueliQvoPXEx5AaB9CoHxH7OECTlZCuPRMiPPhPsRvnZP7IPVb0jF1xCc0ahzDKYCgc6EtCOekolhrkyssXKDnMqxigNN2uFlBSm7Lc/MR9sooPiMW7u037p0OvOVq9DWIMRzZUgP66NZfBRlT44WQcK6UJwQr3vUZ12akpAsCS+wCyty2coUiTuTuia5IpGnTFCLZ0nkfc3t3C7O2VpTWvUjdUTd0Znd3guIBIMhdGQaSJdsQWB12EBZZRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZBrqbT5zQQWq79pBM7uB0CS8Kkw04h5rKRDsJqhQaA=;
 b=KSszCJfesEEIPd9pNZmstsqI416JEvT3oYmmqkaJRs7HQ6FyTgojOPWwNPkVevEkWtBzuGdLMn9XZYAEhE/aN+TZD1TbuHfjFRS9wMzmAQo0M1jrPJxQR2E6xim096gjmefSYVUbFW/Y8SYMazglVWtJaaYYNvDohGNs/HUNzGbnF9BglKBLEPNhwTBfLoS6Fut5AyjsVbOoWtgqL7DPTsAy+T5IWALVnWj7AaG/MEmgNanfyEavvBIPZJ8+cKwQ0K8TWtQpl0iSQ8WEbaZcTgZg/nvs+vT19LcyjDOLoj5huy2wQ5TeVSr/aGti0Y9NbF0MupIO8dPoWYpK+j41nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 01:11:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:11:57 +0000
Date:   Wed, 7 Jun 2023 18:11:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Terry Bowman <terry.bowman@amd.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 01/26] cxl/acpi: Probe RCRB later during RCH
 downstream port creation
Message-ID: <64812ada79a39_142af8294e6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-2-terry.bowman@amd.com>
 <648128e846a9_142af82947c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <648128e846a9_142af82947c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:a03:54::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 6919e2f6-3217-45d3-cdcf-08db67bd5aca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WF2ifcJucjsyVl3UITFSW8lk5EhVyje7hz0Tcc71Yjy/fvYUpsviMdexZGXOqpwLJmS7YqzHBXac4OD1GLgQJF6iekUBVn+hl/9Iv+kaHQlD2LAVLdew9knhe4YsE1vWG9PNiSqLfki3Mu7rDMtpWyI22FQRKYMXxKfMPr0mxtzRaIluGn8E0Jrkk9F38HfzBmlfxFOn+9bPVbUoWMSCICtfhClFQID0HJTZhh90YIyvrR1oAvwuBvrz+3IJB8cvvqSbvzFpvsRnQEvZSiGY4o2o/snF96W3gigTsUHke37U9cYIJhFJPmmhQTGMNlvhLj8zlkQ05PQ0Ql+RxN1SoE4hUYvGZmqCxC1yK80dx+SRaqIiTC5lA5RtNuY9IY2cQCC3cS1m1NnP7iYyZ9H/6EB6EzmFdFPGivJ+5JQrjVYV4PROB0q6psSe1PteqhhP0GnCnrH3nlZHJn45xrTm5iHVHXjONxUPfp2tXfc19Udgyvbfw+eA1VfYe1IeI11O0TEzASvDso4FFMOlzKM4ENViQvVchMiI+PDCtOnHN0EVfYweB5E8ktdWlHrHX8oW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(26005)(6506007)(41300700001)(6512007)(186003)(5660300002)(9686003)(8676002)(8936002)(83380400001)(110136005)(478600001)(66476007)(4326008)(66946007)(66556008)(6666004)(6486002)(82960400001)(38100700002)(316002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7a8IZmnuzBQU45itztsOaE7YdTPRJGi/FF5FSM2nqiSkUud/Zp0fWqr5pRIP?=
 =?us-ascii?Q?JkYRnScTNm5cj+15WhtLzN5PTzO3ABI6rXHuY4PeYuIwLDtiHNSjlKtJEOzc?=
 =?us-ascii?Q?NIB1ekReBMtqO1/+Ioq+M/Eu11XATUZcM4lC/BAkfrgHjibPe+cAA1acJF8z?=
 =?us-ascii?Q?9I99cxi9YtmGoTITy/Sps7aA2dzQ46FF0P7n2kjnxT6rZrcCuwK9vOOdOiOn?=
 =?us-ascii?Q?9UGzjQ06Yx9TgkCNY9yqNDDHiYwDVp1T3bncEMUGaZMvC0iH1FAJ9v17cyIz?=
 =?us-ascii?Q?LgDsysbzSD1XytCCDo45Zk+ZHLgec4UudfESZnxl/QCgGmgWXahZ/SZJLOYk?=
 =?us-ascii?Q?t2m5hUKuWodsSdhlAn6mtrQSwRv4OOSyMLJo14euuK/l116RvA5jYDd4p65F?=
 =?us-ascii?Q?Q9q8OKrvvJhkA+OWA9U5c8GPwawN1LU2VNJfomvqigpLUR7+u89Mkhub8Bzy?=
 =?us-ascii?Q?5ypZ7plx6RHrL78eFngoBP4KA+FfRSl9QSMkbFAW/3NrajWlt3ZPR0jZe628?=
 =?us-ascii?Q?Is33bOhDrSF7PgxHndFKVZdUgPf/Buls64W6PfYlkCZ+k2cdj1Lxe5HJFogz?=
 =?us-ascii?Q?DwQ7GKSAIVPsUDldV2wW/U39stl30rzFOB9eEpdVIyJ9zsYa4r9woVepBD/c?=
 =?us-ascii?Q?kIDuLL3eNC8X5vh4DfWTKJs1tRLIXJXqDLYfCdmHvc/+Y8B2yUuOkYssWE93?=
 =?us-ascii?Q?WWWf3haXP2wMcEqB9+Y+/DlNL//oDwwaIjVt/iPUH1LZkuhebSNAMQi6+N5J?=
 =?us-ascii?Q?Ebgr6lop1SUwrlwVJk1U+K+SuGt3AT497B7iktKnqcf6yj6Cww3xKf+RYUJ6?=
 =?us-ascii?Q?GIqjtJ2jNyt4o8uacxhTNsJb2nRhP2XymXjzc8uiJSZ1c6a7lr4jMd7fUHdT?=
 =?us-ascii?Q?Aut0EkCwaSHIOGlKHLWwkPkHukr6Rf2jlsql/uc0hupqtbop8BoLuWCb3Bx/?=
 =?us-ascii?Q?+jb4F6yF9oD0zUeX1XZCZ+91r1cbiJsfB3nHQNxBp15ZDcSmc3HDgjrCf7C2?=
 =?us-ascii?Q?uZpEQi5hp88tlIM9zbBhwg88APamwpr/9icB6KNpun9wt4ovkThF7tAr/Kzw?=
 =?us-ascii?Q?KZH7XUGjo94Bo4nqYya/B0MXBW+HMNuEHUSGG1Rjc46JazQR7vVU9Htd0r3E?=
 =?us-ascii?Q?Ij0AlKX0ROf2IBgpjz+FzWn4SX4qth0KRFcWX7zecfEWpvFhXJ6/Noi/H7ak?=
 =?us-ascii?Q?WXdaSyN+9Kgzd+nukAjlD1ypSQ5ZkI6/OsitVuFh/HCiRvUy0JaYuhoGF415?=
 =?us-ascii?Q?aIyWFUuNXy7HgJhbdgJcQ5a+4nk5waFT2ePd+EsZ2HO4vq5vz+Z9M5knIWIy?=
 =?us-ascii?Q?1Xp8rQutguFDmKRTOWQjTacy5AFSp3jCX3uPW4nKJaiY4mxPYTnWAyp53VdT?=
 =?us-ascii?Q?oecbbRtwNHyVXpNtL5pwCRDPIEkeYITggRFXw2zU/f1691TB1qBYlGKs0ZYy?=
 =?us-ascii?Q?q0yJvMPTXMpIEM1dKJsVqts6tZOc00gfHLlC68yFpI+nM/w3hDsnkzOw7Fb9?=
 =?us-ascii?Q?xpQ8vkU4fKqbIVF3SNbzGZ10qPe2v0fs8kpI7MaMIRPFfYAojM3e+ytNl/Uu?=
 =?us-ascii?Q?LCv4LHdDhmLhxfEhDSDCxKCRHQMWUPrV2iSY6LNmp6tJD9D/gaN+gp2e0z07?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6919e2f6-3217-45d3-cdcf-08db67bd5aca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:11:57.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECZlhfXuiA7YTShMLFLKT07ebzpZPLa2gwii2V13Zw7cBIOBZvXR9M65gj/EmwJs6RKoe70gp0Aj8Emv7ZDi1fyciClMZ6kNXO1Btgt9Wl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4886
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > The RCRB is extracted already during ACPI CEDT table parsing while the
> > data of this is needed not earlier than dport creation. This
> > implementation comes with drawbacks: During ACPI table scan there is
> > already MMIO access including mapping and unmapping, but only ACPI
> > data should be collected here. The collected data must be transferred
> > through a couple of interfaces until it is finally consumed when
> > creating the dport. This causes complex data structures and function
> > interfaces. Additionally, RCRB parsing will be extended to also
> > extract AER data, it would be much easier do this at a later point
> > during port and dport creation when the data structures are available
> > to hold that data.
> > 
> > To simplify all that, probe the RCRB at a later point during RCH
> > downstream port creation. Change ACPI table parser to only extract the
> > base address of either the component registers or the RCRB. Parse and
> > extract the RCRB in devm_cxl_add_rch_dport().
> > 
> > This is in preparation to centralize all RCRB scanning.
> 
> I really like the approach of this patch, the cleanups just make sense,
> the changelog is great...
[..]
> To be clear, I feel this is my maintenance burden to bear, I don't fault
> you for not using cxl_test, but I am invested in keeping it operational.

On to patch2... 

$ stg push
Pushing patch "cxl-rch-prepare-for-caching" ... done (conflict)
Error: 8 merge conflict(s)
       CONFLICT (content): Merge conflict in tools/testing/cxl/test/mock.h
       CONFLICT (content): Merge conflict in tools/testing/cxl/test/mock.c
       CONFLICT (content): Merge conflict in tools/testing/cxl/test/cxl.c
       CONFLICT (content): Merge conflict in tools/testing/cxl/Kbuild
       CONFLICT (content): Merge conflict in drivers/cxl/mem.c
       CONFLICT (content): Merge conflict in drivers/cxl/cxl.h
       CONFLICT (content): Merge conflict in drivers/cxl/core/regs.c
       CONFLICT (content): Merge conflict in drivers/cxl/core/port.c
Now at patch "cxl-rch-prepare-for-caching"

...oh, looks like you are trying to keep cxl_test going. I had stopped
at patch1 because that one already raised a circular dependency build
error:

depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock

Let me see what's going on here...
