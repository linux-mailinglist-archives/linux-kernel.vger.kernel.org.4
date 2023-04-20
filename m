Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0052B6E950C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDTMvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDTMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:51:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1DA7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681995060; x=1713531060;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Msbs0GUKrOQPEM/gPKaiQT4vewk6sQElHJ7qFQ/IRgU=;
  b=jupCxoldQn0N1iayc660BJToNen3HQryKnlaoh++xBf7cJKEFxkvWNqn
   1tpfo/5MJ1AVWVFXlQnR65QRVcygnekhA+GUrszaWC6Cmuz8J+4UgkSot
   oMjGIrYBdqcvBNj36YUI+ErhlNq+P5ZiP0IGo/WnERp7WMbM37KRwl5B+
   QvAZjLe0szLR3PasJNdTAymNUTJAfruB92F4iEsExFJfXXUDhuY3hH4eu
   AGyYB766EZdwguXLMT19ieqIs8ndjRpCE3mzK/4/g2UqZXFLnUNKyNKAW
   6GB05GKvHDRZf5eBTzX0H6LQ0KQ87uIp6JF6/WeYeom//dMBB1YGlDWU2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347588292"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="347588292"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 05:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691909793"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="691909793"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2023 05:50:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 05:50:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 05:50:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 05:50:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 05:50:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9bsLRSr54x4SagVpEgD+Ibmh1kddFTnINrbb0T3284O98DiE+a8rrxy2cOul0txJH6bVEsyQ7LXawh5/mHWnwtFYWWOmh5Oz0NZz9Cz/sOUD1SGgiwyyFmJxinsDw4Rdk086uH1q5sweaG0uGGWY5e2OiGN1FwzXPs6lEOxiX8FfB5BxT+4tVos0O0BRymYu48IEVMCj45AKP+BgntGqQcFfZVtEUdVw1rozedru77FBclG0brzC1Tat/rXwH+SBcptMcmxYrwA+hpGNqQy/akCTOFRiXxO3qlKersOAOimVVShA2gQwNRdrA/wsY877cD5ee94mB1ekRZm2cScjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8Of9LhuqQnzNjpHMmqtCS4AQkV/a4I7QVskMc2MpxI=;
 b=divxmw5Q+w59DS+QfNTm0msNfGAgEktGwOXBgjKhmhskZ1d7pjKnd32aqh22o4fibBsZ90LCnefXQ1TPC1j/CsU5D/g5pbB0fF2MTpmhcnM4syah6/22+aRa9A8TqJ4uXU7Mz2BAdTGaLfg3AlImQMmVgvOdMdPGLeJj7Efy0+z6dT2UkiJvtg3O5Tx8gbz5xJGJm3d0z9+u9grV1ohCYq7QmJG/oyc/gxqdw51qBmMzY092AiDMe/ZauTQpy85x+qKEjNxKBMnuA8R4KTEd4bkw0YkjwUlAJhB7c+3DVkY72hSSJrDnmFoi9fjHu2ZWZXe1MzRKOkUlrhNakEEjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 12:50:57 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 12:50:57 +0000
Date:   Thu, 20 Apr 2023 20:50:48 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230420125048.GA154262@ziqianlu-desk2>
References: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
 <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
 <20230420095610.GA153295@ziqianlu-desk2>
 <c01ddfc5-9410-14e1-55f7-c24f44447f8a@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c01ddfc5-9410-14e1-55f7-c24f44447f8a@efficios.com>
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CO1PR11MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b065fd-3b84-4446-97f1-08db419de2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwTSCqDUjutVDDI+ZfaGZMeTpRaFT84tjb8xMwTmLl7pi9D3pIKP5NoZelpoxt4Yj/6bHAM3ktawU4y2JK221aZYMQbJNv+69pdIGeqfFLU0irPx6ZUjQ7XKB9KRBIi2XQ2GRbM5RV06rx+CpTt9IzWgtvBjEaWo+1m5pui5yh1Opc5VxxJYeyKjWnXlLk9lzXccugqKgcvWFy7idwmLR1E4371ETbveE1KpysVflXvyuSsoWapN5ITTRdyMkXN+y8g5aEFWOXgE2WMMx82tb4fjsVZNC7tMmm3v8O4BrJQ43meSitlbCh25oF08yGa8fLK1M/2alMe8FSpFcI9aROt9McnF0a1//huxoAF5hKewU8RhhNWLOzil77mdMiaUdEQoQ/TfKXGancXYzvL37SMaNpNB8H1Ui6/qP4M/Fl7pVTFhWPWeAiTtbq0IuG3stmJt7aqB2CX7lbhYrJ0UjSYJBYunbJHr1nj+byAkDJbJMMbr4leeWYsBnjyke/krKO183HAaBi6pdbwLCJ3cooQ2I+bBYHfa6ezY/5v+9pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(66556008)(6916009)(66946007)(4326008)(66476007)(478600001)(316002)(54906003)(8936002)(5660300002)(8676002)(41300700001)(82960400001)(38100700002)(53546011)(186003)(83380400001)(6486002)(9686003)(6666004)(26005)(6512007)(6506007)(966005)(1076003)(33716001)(33656002)(86362001)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M094YkhnRjFjUlFEV0JPYjBqckpQV0hmYVJpM29BNnUyeXhra09mVDczVUlv?=
 =?utf-8?B?ZURDTmNjSUo3ZzFxaXhMR2dsZlRBay9sRGNYZTR3WWtHbW9hQlBhVC9vV3Rt?=
 =?utf-8?B?SHdoaEZ0Yk5tU0M2bGJHdWw1eFYvRkl6MTNMZWY5RGFCeHBTNnE2ek1JWjNk?=
 =?utf-8?B?ZjVKNUpzNWp0d2Z1ay9HajBOM0hmVldGWjVmSlhITXlONmpLNk50QVdjcnVF?=
 =?utf-8?B?Wm9qK1RQc1R5T1dNcG1NMmJaWmRwa0tNemc5VHhhZjhIRFB1ZVVHeFh2ektv?=
 =?utf-8?B?clYvVFJpeWZSWXl2MW8ycTgwS1Z1U1VDaHpyTWp5NlNETTJjcXNGWEFxTkRP?=
 =?utf-8?B?OVBJSTVCVC92RE5uandnTWJPQW90R2dzWmFvY0xZeHZZazhObjhkMlJUb1NQ?=
 =?utf-8?B?YXF5WjlaNFhJTkNkQzlUV3p4VGRuV3piVis4cHhYbGR4dzRxdjNuMlBObUlN?=
 =?utf-8?B?c0ticjNsTEt1bHZzQWJWVmhqN0crQ1lpaGRYdjNIc2dCTFZENTh2UVFNek1r?=
 =?utf-8?B?c0hmQmp2SnJGUUw0VWRXRWJHSFNCQk1YZ0hDK0JXUElsRG9Vb0NYeTRaYTY5?=
 =?utf-8?B?S3FYak1xcGhxZTJIWmNUdE5YdUNnaUovVjhtOHVnMTZZQUtzalQwdU1hL09E?=
 =?utf-8?B?MVRJOEsrdDlFcXVMS1pXUGVmVXJLaUQ5Z2ltZi9OZXFKZU5HQW9FdmZMV3hU?=
 =?utf-8?B?Z2ZpUmYrV24xdk9GdzNSUlJqaG03M3h4SmNRTjg5YWsxbVFCSVBDRStDd0Ir?=
 =?utf-8?B?SWJpWU9HSjFvNmdFSG1jYmVRMlBnUWRXdEFENEtDOFNPS0o3eDVweWErakxK?=
 =?utf-8?B?aXpiY09lNWdPNGFlVGhCbzhUU2piclpaaHZkM3l0bXh3VkFhTEk5cVlNbmdU?=
 =?utf-8?B?eFpqd1RoRElDYzhORFkrMW9nZm1DM1daUlloS2JQR0NZeE1PNnFVblpvNTlj?=
 =?utf-8?B?VllTZ0J2dWNXY0Y3SUZZWjB3V1RxbXRFblJBVDRaVHlSa0ZNTzhXaVZpRzF6?=
 =?utf-8?B?NEZPTUx6NHlBSUR4WDh3Wi9mKyt1UEdZQTR4VFM2c25Ka0lPZm5tUERTbW0v?=
 =?utf-8?B?OU5qSzRaYjlFcm8wVUk4UFJydDdsTUphMXVKbTdqZEFPeGFZMXhwSGxrUmtV?=
 =?utf-8?B?cXdSNDVnb1pPd2xPMUFlRi8xUVNXL3d4TVlGNzcxS1YvQVlrSzYrWENkWGhv?=
 =?utf-8?B?cTN0R2VITVJhdUVVZmxib29XV0xKRlREQlZpZDM2QTBiWnoxN1p2bmhmZFNN?=
 =?utf-8?B?OWxWM2N1SWRtQWpUK0FxR01PVVFtUm1JUzRqQjluemFkbFE3TlhlV0xYclQ5?=
 =?utf-8?B?ZUVTM2ZTS3dVb1NSN2hlTW5BVEdUL1dsUlZuNTRqZ0tRRS9pendFNFAxa2xa?=
 =?utf-8?B?OTFEblZnSWI4U1lkVmx1Ynl6N2hHaUVGQmdLYnoycFFQcUx1TFBYTUxDdHUy?=
 =?utf-8?B?eXBqTEYxaG05S0FBWVo4ZmM2VUZCcGZMN2c4eThDNnNZVmlyLzRkMWl6Yjdo?=
 =?utf-8?B?bE4zOXNOcTl0amswMkNsb2lTb1hWUElyWjFSd0M5dWNQaDlBYWlvRlRiMEZr?=
 =?utf-8?B?RCt3MzFRNS92ME1JK0YrTUdLWTBRQ1lDYVhTZU54S2YzUlRaTGJ6am12aUJr?=
 =?utf-8?B?ditQLzJySGlLak9uL2N0TExVOHJNejkxalVMK0tGcXIxVGgvcGlxTkpFS2pD?=
 =?utf-8?B?TXNFaG9vNG1xRG9WNVI4dkM4bVpqUUN2cG1oZEsrQ2dpcG5lQVNOTWJ0ZXdE?=
 =?utf-8?B?ekVXWXJUNy9TajVyUDl3cHJVWnB1Y2VlTGZaNURiTlAycGROVDAvTW5hblF5?=
 =?utf-8?B?bTNnTVJZK05ZSjNTbkFCU1MvajJDelJ2Ukp6bkUwdlNRTDg3eG9YU2k4MzBE?=
 =?utf-8?B?eTRFWnlhRy9CSnBleVpwaGI2dnBvR2E2ZXZ6NzFHaTdpWHJRbGgrRFBpMndj?=
 =?utf-8?B?L244NVh2SkZXa1haNEpqQ29zVG5PTm9BUUhLbldGM2xiMkN3cU1SUHJ2aWth?=
 =?utf-8?B?TVlMQXhpRUxxREpZdnRmdFVkTE9hM2pXS3VTRzlnQWV1SlRqTzlkZS9UeHU3?=
 =?utf-8?B?UnN4SGlTdjNFcm1ITk96K3lTeU50U0NZd1JlUDh1RUtJbUhkUkYrSExjMDhN?=
 =?utf-8?Q?uR3ggvDwTjkb0fi84H5QfPJo4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b065fd-3b84-4446-97f1-08db419de2af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 12:50:57.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SON5XSsiR7S1u2zejejQxnUCYdeUp1CfkV4C/KsQNZ0KmzAFAxlHAQHR9My/WRhx0WYeMT9a7krn1JgmAtKeDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 08:41:05AM -0400, Mathieu Desnoyers wrote:
> On 2023-04-20 05:56, Aaron Lu wrote:
> > On Wed, Apr 19, 2023 at 11:50:12AM -0400, Mathieu Desnoyers wrote:
> > > Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> > > sysbench regression reported by Aaron Lu.
> > 
> > mm_cid_get() dropped to 5.x% after I disable CONFIG_DEBUG_PREEMPT, using
> > __this_cpu_X() doesn't help, I suppose that is because __this_cpu_X()
> > still needs to fetch mm->pcpu_cid.
> > 
> > Annotate mm_cid_get():
> > 
> >         │     static inline int mm_cid_get(struct mm_struct *mm)
> >         │     {
> >    0.05 │       push   %rbp
> >    0.02 │       mov    %rsp,%rbp
> >         │       push   %r15
> >         │       push   %r14
> >         │       push   %r13
> >         │       push   %r12
> >         │       push   %rbx
> >    0.02 │       sub    $0x10,%rsp
> >         │     struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
> >   71.30 │       mov    0x60(%rdi),%r12
> >         │     struct cpumask *cpumask;
> >         │     int cid;
> >         │
> >         │     lockdep_assert_rq_held(rq);
> >         │     cpumask = mm_cidmask(mm);
> >         │     cid = __this_cpu_read(pcpu_cid->cid);
> >   28.44 │       mov    %gs:0x8(%r12),%edx
> >         │     if (mm_cid_is_valid(cid)) {
> > 
> > 
> > sched_mm_cid_migrate_to() is 4.x% and its annotation :
> > 
> >         │     dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
> >         │       mov     -0x30(%rbp),%rax
> >   54.53 │       mov     0x60(%r13),%rbx
> >   19.61 │       movslq  0xaf0(%rax),%r15
> > 
> > The reason why accessing mm->pcpu_cid is so costly is still a myth to
> > me...
> 
> Then we clearly have another member of mm_struct on the same cache line as
> pcpu_cid which is bouncing all over the place and causing false-sharing. Any
> idea which field(s) are causing this ?

That's my first reaction too but as I said in an earlier reply:
https://lore.kernel.org/lkml/20230419080606.GA4247@ziqianlu-desk2/
I've tried to place pcpu_cid into a dedicate cacheline with no other
fields sharing a cacheline with it in mm_struct but it didn't help...

Thanks,
Aaron
