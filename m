Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAF860815E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJUWSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJUWSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:18:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBE72AA176;
        Fri, 21 Oct 2022 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666390694; x=1697926694;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IJLTszyD4DnCO09oP/LcGxM7JfeUY2H+hPIckXRXV/c=;
  b=e03wsyVQJFXkNWiMoa0tF90a+rJJOkXNOI4JdpwKEdER13tHTDFYunWr
   J2f+Ete23GSRTrjlUQE06CIZ6cZeFiE7GAw1eOEUHFx+um7oR/7gP1dGn
   hUSA3rfJocOTUhdns6Hb6ERrJzUioYc9pDjRXPLBIdAeuj09CT+Tixs7E
   WbUdRA0ktUL+85ZQ6H8n3BCFR8S3gFFaGyRCplIEMPnNN03x2KBOwQFjS
   rs7eRQJUT21NUf8+6Me/ENGnmL94QT+PAaak13zkLyfNnx32PXoThJYUl
   rReapdEs1b85xOW4C3JPdYwdtexXOmsUuIome7B9sMEUBl3upLaPqiq6g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="305847631"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="305847631"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="699520953"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="699520953"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2022 15:18:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:18:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:18:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 15:18:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 15:18:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2gEWSyDM7lP78qM501gIaVE5yBDAJor3ZsMNuHE56PqAv/6ZxUBk9CBV8w5dDvNLzAKSXd1JmQPzwJLl6jdK2RJ7gc8VIBT078PZHK1VnsQaPaBqL5PKl3eFn1VxB/H/Rt8mxyfSZAifsardnBfv56uMwlQ68I5bES2Ggx0a7ixfxTBpBfitSKpbk0/3j9hs5cJBAkVMWcftPghSOmpK2BejXTMkkRqzDRuQzxenYoFinek4qUPVN8xmH7CksESmoslg3upCcTuMPDTsTRLvDbuKV/vnJ8sPYKSH2lpv41C/2sZdYDZfSr8RVpPrALleDMl2rQ+SO5FkLpnzkJv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCQmBRIVsnR72LgbVk8EjCHxvq5QnEXGhtjJnur6Gws=;
 b=DVRFLSoQUMTJQ1U2lp7FZab7EQcaSBYB6i2Q8aG+YHtMKPvh+QU9rQImBciCfGqXYBnhtxQr+6DicZVaiahEUAYl9oYFaJ8dueL6mA+xHnAzf+ED4z4NA2CV+lvbOR2vg9F69yNqAkABELazPlwx9+XVZ3mQPIU9LdSMlwcQ97wJTYeo5PJRjSqo75uBfS0e3lXIouIe7mz8Id2MOR8A+lieoBCt9jlJyInmrCl1Sof17/PfCHvwIiroKyBjNRhfL7TpEKnpEId/GYCJkRoUjnopo4JVvH1Ti4O8zDeh9nC9s42+pfPCQLSBQ4akgw3HwxiUAXRrNFbLSYkTNYkfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB6947.namprd11.prod.outlook.com
 (2603:10b6:806:2aa::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 22:18:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 22:18:09 +0000
Date:   Fri, 21 Oct 2022 15:18:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Robert Richter" <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Terry Bowman" <terry.bowman@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: RE: [PATCH 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Message-ID: <63531a9dd51b9_4da32946c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7209ce-a0a7-405c-6ae4-08dab3b22253
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jhdp+GBTlV2bqJa0ppqsfQvyoVsT3BBIgHDwYsnodahVnfYFXigWXSZBoGDACxxUK9fZPonLlud6MFkz/o18ctusZsyU9BaH1aIDNIqAG8gLTOIL9ghEbykM/D5EmaQlxApD7ztWbtTqC8/1XpmsrTWsARmHA7tSH0caK8Ljq0jdSafVu3yo/9XU/g0qTZfIjo02J3+8HGlGyu1iVdOxzIjWCaiqzBPtLWrC9FbfO75t9/VPc1Mj11EgQe7H8HL+L4DL7jIl+FipGXNi3qfNiheIx4weQ0EEYCVv+Hx2YU30f9njGHxMysImeaMzsSrpdXhcm9tQR2CR4gHquPugQWJDPtjIKXP0xPhCjOMMCYk53n9bY8KZW5yTrsHsyZMDJBJmxLN9SHgPfKUZZbn31rmbChiSWBoMdNIhCfTxCAeHWdrfHnFJ0XLglSix6QABBsG/62q/6CVBqtJD1saKDdUoXv39mW4dUTX4vhuZl5IeDQIWB4aSkq7Crp+bKKyUmZYYIefxC86dT640iK4Z8bm5unkV+/FJis60BBT9YEIYzHvCDQTiJcs4bKnIMKxZSXDk3tt1b7NsTo0hvGhhmwBgtPB47FZ9vOwwKQKqifoZhp4dfjpcCxIR87GCYBaybju3xn8IaWt2COnnoDM1XzA4HRbQEKIgTNeVe7t2bnanVMoZsHcszocsPelzZJBNgNYqdKaWnZlMsfYuA5kpoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(316002)(26005)(38100700002)(82960400001)(86362001)(66946007)(66556008)(4326008)(54906003)(66476007)(8676002)(186003)(6512007)(6486002)(6666004)(9686003)(6506007)(478600001)(2906002)(41300700001)(8936002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yLprweDNLMh/1ZeCTlcep4oDoXVV1k71mhJcT13m4Rfrs27I+2VDi0o99Mnw?=
 =?us-ascii?Q?5zGpF37UV+ygKBPbxmTEvaaouCp2yyh4knL981imCj2GqJ2sYzMXWiCMp2vu?=
 =?us-ascii?Q?IWO9w7fCAI9l0nS/y7VOvvIu3mWt76QPm5x9FrDZCX9t5eHLuQyMcs/DNTP/?=
 =?us-ascii?Q?7XSoaGCNFIFCdguZaMcknMIf38GFp78915xgIuMZpyy1PnqlVLsxj33PMaOt?=
 =?us-ascii?Q?rIaVTdADnceDeNu2JjVbGhDi0oFWiXY4nePJiqQRD962ezssXZnO7CZJEBhQ?=
 =?us-ascii?Q?bRncqzPr38geCRIZBmX+lAThiu0/aPUAcWmaeytyLJoJQGv5FSwwmRWhnLY7?=
 =?us-ascii?Q?RjKBuToKtlTZ+q3u9Xo7S8myynvlEFw3aC67Y11FnEu09OCYGHKxxNZCEQiv?=
 =?us-ascii?Q?yoWUp9/ksc8PcDZBEqVbNQnKGAwuw6VL1/64bTMhMZmZ38gy0EC8p7J2WPOA?=
 =?us-ascii?Q?GamHBi87/InVhAR7bhhzLiaFzqhnCjB2ZZrIn163LHmk+jYDlFmGpyGhZOQy?=
 =?us-ascii?Q?8NmFObqZa1qlt7lCg/qsY7cmSaIHtV77shKzteavNcq/SoLXDcSxHyPZi4xD?=
 =?us-ascii?Q?oMZjcjz6Wn5Hjyq7GaRKJN1Dg+GKUOvKO7av4JeLxaaIuv0NprTeQSTnszDq?=
 =?us-ascii?Q?Qy0gAOl6OsQi38+JKFKvcuZsS/wN0w7nQ9Yr3bGvuoZZVRcz3mjxHm9feOha?=
 =?us-ascii?Q?62zokUdumMqTQODNEWf8kpGvLBWM3r+s+24H5JNz+dEv1bcBgMRAWx6aeW6h?=
 =?us-ascii?Q?ChELpk2zRby9wnG4hajoCU6O6FrEXcSJZXmM2k4P43WYmnAYgv+4FkBHhR3X?=
 =?us-ascii?Q?i4L1jxHgHSneAr5i/8Rnuj8WCVlQVAcb3a8j6XNPYLNOdA/Ep61PsYzCvKk+?=
 =?us-ascii?Q?vyUgFA3KDtQPSgfmVTnSkVSfvtsq7WP6w877zkKJsOyIQyJEMijCpN4V6kPv?=
 =?us-ascii?Q?zurgLZJedebXmm5dvT+NiMq2rnB5KyrUSa18VDIdz1MV/daP9KMs/f+1tp/v?=
 =?us-ascii?Q?igyAEVlwnzEfkgYwQNewAW3AC2aEo/2Jp+fu1rEZz1E2Shbo65zAZhc2qFmS?=
 =?us-ascii?Q?bjoM39k4p0VkkWuEmZihfYGSiItIk6i5uIolxCoWV3F4bXH+VNPpGHP1r9m7?=
 =?us-ascii?Q?NMHeLciddzd6gSBrebKn5ck2p6wOdVYaO96plUH6JNb5qQZKiRpYM7TxbQnH?=
 =?us-ascii?Q?rKHqhEi5+OfcG5GzqnITHxyOworVIPtdy+2k9MV9i42zVXox13XEkZWYKrk+?=
 =?us-ascii?Q?3Y5P7fvZPwrvuJ4Uc0iP7VeO85Fe2HfwJEUBxnQyNO/HDCWR5DErHLDLhOXs?=
 =?us-ascii?Q?hVbcCqOHL4xPJYiImPsHLhM2+d70zgYiSD/NCb2ON3hxJ2c2m8CZklTq5Wnq?=
 =?us-ascii?Q?LGSejxgrpFOIsPM/0EVpd2w5+zbmSCv3Qj3E6PP1Shvb7LmjfIrDV3c9cL7P?=
 =?us-ascii?Q?QMBtY5YbVRAR2QDkCMA6fL66Ph4jX0Z1+0LXGzDxoQ2hZ0629GlKDkNep/Yc?=
 =?us-ascii?Q?9dJvITc2bDAe7FZU++obD6vzv6hIMXQeyLRxnzg0OdPlfB9KVc3uNj+g3Lxe?=
 =?us-ascii?Q?B0tAIeSTjdzqemYHvPRFArvZtKYrSClMFCKtB9MZb6BTbX7qXpowoSpQenap?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7209ce-a0a7-405c-6ae4-08dab3b22253
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 22:18:09.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mdfOZWQVdtkoMg5DfGo4rlN+73+BZN8R5vjOkgl4gpiBSQqrVRiDhv/yGC/Br9bVVGu8vT+ErYWgqmS/YUG44C44YHLo5Unkjx51REa9yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Smita,

Smita Koralahalli wrote:
> This series adds decoding for the CXL Protocol Errors Common Platform
> Error Record.

Be sure to copy Ard Biesheuvel <ardb@kernel.org>, added, on
drivers/firmware/efi/ patches.

Along those lines, drivers/cxl/ developers have an idea of what is
contained in the new CXL protocol error records and why Linux might want
to decode them, others from outside drivers/cxl/ might not. It always
helps to have a small summary of the benefit to end users of the
motivation to apply a patch set.

> 
> Smita Koralahalli (2):
>   efi/cper, cxl: Decode CXL Protocol Error Section
>   efi/cper, cxl: Decode CXL Error Log
> 
>  drivers/firmware/efi/Makefile   |   2 +-
>  drivers/firmware/efi/cper.c     |   9 +++
>  drivers/firmware/efi/cper_cxl.c | 108 ++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper_cxl.h |  58 +++++++++++++++++
>  include/linux/cxl_err.h         |  21 +++++++
>  5 files changed, 197 insertions(+), 1 deletion(-)

I notice no updates for the trace events in ghes_do_proc(), is that next
in your queue? That's ok to be a follow-on after v2.
