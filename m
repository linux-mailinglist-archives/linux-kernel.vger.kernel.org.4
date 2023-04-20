Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D426E9759
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjDTOj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjDTOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:39:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54452709
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682001563; x=1713537563;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KI+QFemO8bbuKFCsayQEuJF4nS52S9BdzhVvu+aIvzg=;
  b=TaLF0YkaQEB7eSHB3gF4+p/A14ok53+7UjbYjvAefccfoybYl8LYtcG8
   QsoHPxfWymm60CUwj5gW4CCxxLLQz2md5pteIuzl5KFDcNR1UgLU0/BJm
   cYnCXE2DKlYzin48ieAgxacjsTn8BGtfB5L4QtuaLHVbl9bQ560aaIWSm
   PBakd6dlsFY0vrKRec0dxl4rWpY5Iwdxl+/6WWJq4d85YZeKjIPVcNwsD
   zicoNUWQrEsoximIiWsRPRMOGEXBzYsAIj2apDYMuPvIzx4wOjZs5spPY
   43NEBm+QFezjcml+vXe5HhSly8mGSD9QkXEmjqluDC0mWb8E5+FJmIBiR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="410988533"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="410988533"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="938084602"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="938084602"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2023 07:39:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 07:39:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 07:39:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 07:39:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 07:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e74wiJ4foZgRGb3lWDgZk8wjFon7HhdbzwZSvZ5naj/r5Mxx0JeYwKVVJ2KlOv70/NYhr7kzW5pvwuZcYTcRnIyF+mr8S+L24OLZojBbf5gQR88xKd/tO+w2BII9A9guNozPnj+0mZzdqyXK/9BYJ0TdPQqKWFnhmbCF8/yC3ibTBdciGeO4SJ/x/mAYbvuc7RTvbcZe2jMfvo44Oq4TywQHqkGdtAdVCaE8eQT3nL+8MZcat/94t+3rADk7yMqgHrw4B4Ibk2VpucKtcCGayNSCRK6nbHq0Xj27vfS4AKwNj7Auykmm385t8j+90Eom6hNQ8kFuPjtnfeWMw2Mntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j04qVw9gOENLM8QImQeYOjW0O2lJghg+OJ6c65nAFM=;
 b=d4gE6ywEpNlS4tbj/cc8WCGbxsIQl+yvMc/kP86VAiXTu0Qa/TFRgWAVIywqLVIpTmBLbm1GVB+W5PmJb0bEbPj9khrYAHgKhacRqqShJ09aJA4UCg8MkqyvboXPGqku9xgHeJoIhwcG8ECZmSRafGwY+I86LCAq1Oxve8d7v/GwjeblwwSGSMyDbI5rDlYIKdlPU5plbEFuRULXV2N9W3fEqsB61qdTNkz3RtXCQJVSFHZbtIQgQP0nFWpCRP5/WGVwFM8vVjuTZT2LNl6u/LFYiA2LwRRcEV89curuR4t3UesJTupviawQIzRJgh1qcnRKFyp79/ZM3bnlhZqXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM4PR11MB5520.namprd11.prod.outlook.com (2603:10b6:5:39f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 14:39:20 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 14:39:20 +0000
Date:   Thu, 20 Apr 2023 22:39:10 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230420143910.GB154815@ziqianlu-desk2>
References: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
 <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
 <20230420095610.GA153295@ziqianlu-desk2>
 <c01ddfc5-9410-14e1-55f7-c24f44447f8a@efficios.com>
 <20230420125048.GA154262@ziqianlu-desk2>
 <721f4b8b-c238-53b1-9085-a9dae6a961e1@efficios.com>
 <20230420133519.GA154479@ziqianlu-desk2>
 <7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com>
 <20230420141852.GA154815@ziqianlu-desk2>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230420141852.GA154815@ziqianlu-desk2>
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM4PR11MB5520:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e35b36-eab9-4a57-c8c7-08db41ad0695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCe7QJbVvAHfHbGWf/GIEqMTFBLxnKLa6itEXBSe5nijI191msURmIc14Bj5uNJT4V8KVPSaBOlTXeyatPPELz0kSp6KCwvfhaO5FnKF4ii4tikhIff2WMx0cN1vqM3qdH3uui51JrKg5xpnUlQGKWz5y+FwPJJEG/WpRa0gMhfRkexK56ac5fQYTURPcfDc28D+iPn2fX8tDcSqXcrgf6SXUVLcZC0LahMOUXkQ92ahzFf3PXGYDJa1z8ORdI+JGH/qQITiXJFolIyIQN5eMCV8VF7+7wo9ap6xx2I9MN7lJ6Jimk9KU1bbikKAQBVffFXqXuthgoi1z55rb2ddvrWFdFsP6go1V7fb37Po7QmnUZ2ceFhhLVTjIc1dc7BiUprUHsbPkLfvgia6McVQDVsZuXj+am0uUMvwHzN4/d/j7dvJotn7K3APj7vhRS/PaTNdq14RotJX18nzVdz7ZIN6en3CKqDAeeZBWoUbPegLJNQ7GP1JOs5l1RugfQEXZYSJQz7rArVAB9NoHggTfBm5X6V0JGkETwT+RejYd10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(33716001)(6512007)(6506007)(1076003)(26005)(9686003)(186003)(316002)(53546011)(6916009)(8676002)(8936002)(2906002)(44832011)(86362001)(33656002)(5660300002)(478600001)(6666004)(66556008)(54906003)(4326008)(83380400001)(41300700001)(82960400001)(38100700002)(66946007)(66476007)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVmWVJ5bERRWHg1b0h6OW8xOGg3Uk1GSGQ2b0sxdHlySkVpeUt1a0ZLN3F0?=
 =?utf-8?B?c20waGRGSDZ3anRkQlNSSzRHVGxlNnBhSEI4UHE0V09HWnJFN0tTa0M2eDBP?=
 =?utf-8?B?WEVtKzJFK0tNOEhsSXBOWm5ucTBjdW01SUJHaHdVaVpNem00NVo2R1ZBUGo5?=
 =?utf-8?B?QWhJSzVGSnIwdnl1VGU4dGJtc3ZPWWdiclFEQjEvTjdRMXRLZUJRM1pJR0Mv?=
 =?utf-8?B?SW1NR1Y3dXBxQ0RJd1lCUC85dG01bnZCd0wvYzJCb2luZE1XajFQdkJuZk5B?=
 =?utf-8?B?anJvV1dkS3lvbTdtYTRCNVVXNTJSWFdLQ2crSkFrZXAwcEM3T0ZKTDVuZGxD?=
 =?utf-8?B?VEZUa0ViMkxiU3FMUll4WWtVdm9zaGE2VUV3UVZiMXZaWS9vNmdraFZNeXlH?=
 =?utf-8?B?SDFCQkk1SFNaaitnVkduYjFSYng2a1BlMXJ3dzlyNEJBSFdZcHBuMHVsaGYw?=
 =?utf-8?B?bGVCMHRNWWpoRXBLenZQMjZtS0VzWHRBZE51bmhmK0o0RnNjN1Vxem9EVjFG?=
 =?utf-8?B?TUN6eitPZVhBWXRyMitQSHU5VlVsRHFwbDJDS2l0bld6THNZT3lBSmdxclc4?=
 =?utf-8?B?b0FKSnkzM0NrcDd5QWVGUUNaZ0RXSWRQVU5JdEI0cm1idndMZ0xoYzlMM2R4?=
 =?utf-8?B?L1NocHdVaUtkMldJUWFYczNDRTBwOTJacFFnZmtMSkRra2ppWFl0T1BZaGRV?=
 =?utf-8?B?NW0wVGZUSjNoOHNGbjRBRnVxYXdEQ2FsNlltQ2ZVQjRGeVZ6cXFXVDZSWVZN?=
 =?utf-8?B?eWkxNjM1VkxRN0FKcnpOQisrbjBnaTk0c1lqd2RZVHhxcnQrWDYyMGlBVU9s?=
 =?utf-8?B?VnIwQjB6SForMVIwa1RMdXlvbzNTV3NvbEVPdmZvaGFyQXJ0SjFhYmlvNXpv?=
 =?utf-8?B?S25NQ0VTYTJPTU5lMWJzQWlScGZhMzBLd1d1UmF4Z05VbEpkWlpwa1JLelNh?=
 =?utf-8?B?Y0hhSUZXVjdmQ1hiZzdGbHJvL3dZY0x6WWVrL3JUMUpQK0huOXpZR3J4Q2VG?=
 =?utf-8?B?OTAyLzRmOVQ0cXlPSlhZbXYwNE9RZjkxWUlaT2Q1TjhxYlJFRTAyWDE4Wisx?=
 =?utf-8?B?NVNEVU9zNjdNTWFaUlFSYVFUN21LSUNYcjMxZDNIWjdnQkRLVnNHdUp6NnJR?=
 =?utf-8?B?Y0hTeHVlajF2Z1ljRDRnaG4wckxadlQ1U0VhZkdmMXJSVnBhQTg3RS9yaU9z?=
 =?utf-8?B?dnVWSldtZHIyUXpReEsrY1JIMnpFQ3FPUnB5dlk3NFNYRTZkR3FRVWE1ZmlI?=
 =?utf-8?B?SjVIMXdQbTFrWlNPVzFTWjlQVUFMM3BUT3NwMUkzbDRLblJZTDhnd002OWI2?=
 =?utf-8?B?ZWNSUDNwTDdiWmdQSVZnT21mNlNQcHM4MWFqNGhjN2t5b0s5aHBuRkZuQVpx?=
 =?utf-8?B?M0N5cG1rakdtbE14WjhuQjZHR1g4VVVwaEY1Rmt2c215OUlMZllJdFk5VG1E?=
 =?utf-8?B?ci9iNFczbW1jZFZJazJZSGdtSmltL1ZjcWxlWGp1eXkrdzF5UTNRNFlFb096?=
 =?utf-8?B?NzZwU3VrbzNjeHBwbVRrajZPUzdnSmhhV2lLRE9yWEZlMkhYblduS2ZKRzZX?=
 =?utf-8?B?MXovTU9hQ2k4TklpQWVlYmV6cmdyZUd5ZHdNM1R1K2szVlVmWFpXbW90Wll6?=
 =?utf-8?B?SEhzUjI0L2lkNWZlOEtEUFZNbzZmUnpHK09SOFFTQU04dXRMdXJybU9BYTZ4?=
 =?utf-8?B?Mk9OS2pHL3p6R0hNYWhZM2tGK05sdFZZalFmRG1rNkNaZ2VQNWNDSGUvOTRk?=
 =?utf-8?B?RzUzMW94ZmpOcmt4Ym9TVVdCLzJWcHA4S0JvWGRoNzdGVHYvenBDMjZmN3U2?=
 =?utf-8?B?cFVOTm80VlRaSExDc0RaeHdiREFOdU83dXJGU1QyZWZyMG8wSFIxc1BpSWp1?=
 =?utf-8?B?UTZjaVVYem9GOWw1eUNEQlVXVDlmVFZYMHZDUnplRElJOHlzZnRqYllPQUEw?=
 =?utf-8?B?Yi9laU84Y0FieWVtZlNlODFmQVo1ZXAzNXZ4bEUyVDQxUVlYTVIzTlRmTXNT?=
 =?utf-8?B?Yzd2UVdtdVF4WTB5RXg0REZwZ1RMUjBlRFZ0K29FZU14QzZiRUV3VCsyd2F6?=
 =?utf-8?B?MHNrUlJnZXg5TlVjTFFnbjVXNnByVUp0STNEaEw3MHlNUXk1cGFZQWU5L0hk?=
 =?utf-8?Q?nHEr+ZDKcxx1w82ShGkWRrOdN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e35b36-eab9-4a57-c8c7-08db41ad0695
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:39:20.0286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHRYHzTCyEyOPt9eEuORtOUBTxA+SNKXqevxQ6eSqEktKYutSjTogD0Z4C4DVCqqQzN82tR7rmONH4ks3Ve5zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:18:52PM +0800, Aaron Lu wrote:
> On Thu, Apr 20, 2023 at 09:54:29AM -0400, Mathieu Desnoyers wrote:
> > On 2023-04-20 09:35, Aaron Lu wrote:
> > [...]
> > > > > > 
> > > > > > Then we clearly have another member of mm_struct on the same cache line as
> > > > > > pcpu_cid which is bouncing all over the place and causing false-sharing. Any
> > > > > > idea which field(s) are causing this ?
> > > > > 
> > > > > That's my first reaction too but as I said in an earlier reply:
> > > > > https://lore.kernel.org/lkml/20230419080606.GA4247@ziqianlu-desk2/
> > > > > I've tried to place pcpu_cid into a dedicate cacheline with no other
> > > > > fields sharing a cacheline with it in mm_struct but it didn't help...
> > > > 
> > > > I see two possible culprits there:
> > > > 
> > > > 1) The mm_struct pcpu_cid field is suffering from false-sharing. I would be
> > > >     interested to look at your attempt to move it to a separate cache line to
> > > >     try to figure out what is going on.
> > > 
> > > Brain damaged...my mistake, I only made sure its following fields not
> > > share the same cacheline but forgot to exclude its preceding fields and
> > > turned out it's one(some?) of the preceeding fields that caused false
> > > sharing. When I did:
> > > 
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 5eab61156f0e..a6f9d815991c 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -606,6 +606,7 @@ struct mm_struct {
> > >                   */
> > >                  atomic_t mm_count;
> > >   #ifdef CONFIG_SCHED_MM_CID
> > > +               CACHELINE_PADDING(_pad1_);
> > >                  /**
> > >                   * @pcpu_cid: Per-cpu current cid.
> > >                   *
> > > mm_cid_get() dropped to 0.0x% when running hackbench :-)
> > 
> > Now we are talking! :)
> > 
> > > 
> > > sched_mm_cid_migrate_to() is about 4% with most cycles spent on
> > > accessing mm->mm_users:
> > > 
> > >         │     dst_cid = READ_ONCE(dst_pcpu_cid->cid);
> > >    0.03 │       mov     0x8(%r12),%r15d
> > >         │     if (!mm_cid_is_unset(dst_cid) &&
> > >    0.07 │       cmp     $0xffffffff,%r15d
> > >         │     ↓ je      87
> > >         │     arch_atomic_read():
> > >         │     {
> > >         │     /*
> > >         │     * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
> > >         │     * it's non-inlined function that increases binary size and stack usage.
> > >         │     */
> > >         │     return __READ_ONCE((v)->counter);
> > >   76.13 │       mov     0x54(%r13),%eax
> > >         │     sched_mm_cid_migrate_to():
> > >         │       cmp     %eax,0x410(%rdx)
> > >   21.71 │     ↓ jle     1d8
> > >         │     atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
> > > 
> > > With this info, it should be mm_users that caused false sharing for
> > > pcpu_cid previously. Looks like mm_users is bouncing.
> > 
> > I suspect that the culprit here is mm_count rather than mm_users. mm_users
> > just happens to share the same cache line as mm_count.
> > 
> > mm_count is incremented/decremented with mmgrab()/mmdrop() during
> > context switch.
> > 
> > This is likely causing other issues, for instance, the
> > membarrier_state field is AFAIR read-mostly, used for
> > membarrier_mm_sync_core_before_usermode() to issue core
> > sync before every return to usermode if needed.
> > 
> > Other things like mm_struct pgd pointer appear to be likely
> > read-mostly variables.
> > 
> > I suspect it's mm_count which should be moved to its own cache line
> > to eliminate false-sharing with all the other read-mostly fields
> > of mm_struct.
> > 
> > Thoughts ?
> 
> Makes sesne, I was wondering where the write side of mm_user is. Let me
> see how that goes by placing mm_count aside from other read mostly fields.

With the following naive padding for mm_count:

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5eab61156f0e..866696e2d83e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -604,7 +604,9 @@ struct mm_struct {
                 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
                 * &struct mm_struct is freed.
                 */
+               CACHELINE_PADDING(_pad1_);
                atomic_t mm_count;
+               CACHELINE_PADDING(_pad2_);
 #ifdef CONFIG_SCHED_MM_CID
                /**
                 * @pcpu_cid: Per-cpu current cid.

mm_cid_get() is about 0.1% and sched_mm_cid_migrate_to() is about 0.2%
for hackbench on SPR :-)

Thanks,
Aaron
