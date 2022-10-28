Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88734611BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ1Uqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJ1Uqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:46:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608B623AB4F;
        Fri, 28 Oct 2022 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666989989; x=1698525989;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wKz1MaHy2MinJ11ypGqzOmC40hxAuZcJJzy9ExdCF3I=;
  b=Y8h1OQr0r1KKfzy5gCp3EnqMkhffibOEIAlcAG6XJKZN4lSj6IvNXJnl
   HU/AhDOqVBeeW/qGfRlrQLLoz7UPjdHqYYTrsjXOYvMg97HQOWASHqIur
   mSYID4R3FhHKwgY4SF5/XujccJ4i8+bTp41MGCCvKU2rWYvNZgcVM4AzB
   YLZVAqM5gNwaStXYN7ZS1PQy3ST/fcYjMGXYGcVEgOninU40cmMdU5WTe
   zVJov8QtsY4NEtSmYqwLaBfKQlot8mXv7QGRtlaaYE+xPx8Pa0dGEcsA8
   EYCaz0vLzP82yM5EA2lxkSydxNRZyYv55b/Fkgv05LpZxb5EjcW7Ha8zs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291884839"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="291884839"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 13:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="701872578"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="701872578"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2022 13:46:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 13:46:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 13:46:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 28 Oct 2022 13:46:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 28 Oct 2022 13:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZM7X5fnd6PKU42C3cLD+0qiF0h2MwB7QIdx1MdfNPxk/38VGuRa9MRrahG2sd5n0xtHcIYDDjdExA8wiSXo7Grbzasd9P7ioxsCaPBwsx5XlmRJ2KbgsRkd98C2z2/lRtQRRTu0MOei0OP2pycBhQ3pB9VeSIvootQOupor02ZCzVtjfTY5Fon3c44Ju4hPxm3ujisAsCoMbc5K0raznXEf9ukt7lLE2Zlh1hDMl4FyiRdyMjFr4LQoNZTXfg+VXb2jfW5gtkQtfAlGCIANwJRfmR15P89XJXOEt1XdMcfoYq5LraZVC0KL+MZaGQ65ZzRFhQyIWYELZbYN2Vgtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Soh2+IrEJmRD/gQkoGksaoirnHx/m4Rmkpll55YOoQk=;
 b=KXszn5bM74OPgCRcHbLh8RKNNf2mnKQhAoODGzB1FawCxKHN+Z9dU2wNbr2hEaP6YoctY8jg/MbRrb5/tbhTvuJ63T5LtnCzRiVVV9DCYRDaSycCEENRURDKA0q5XfgvG1BXzS816Ch5ApTiBb5NEIX6gr5yAyz3n50FCSjOW92et3UpHcugKVIOr65Zy3ApkiazsUynUtqYjGOrfgrc9Nzxf11p76uYrKXbUXE28AvdZ3L/rWwb7MxBracCYgszE8beFAYg2e4kpopqmCYpwJPBgqLO5GpTfN3KA46802JS6uOyYz6t9V2N8hKxzi3up/zIMtL2zlptN4hwor0UuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6847.namprd11.prod.outlook.com
 (2603:10b6:806:29e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Fri, 28 Oct
 2022 20:46:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5769.015; Fri, 28 Oct
 2022 20:46:25 +0000
Date:   Fri, 28 Oct 2022 13:46:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Jonathan Zhang (Infra)" <jonzhang@meta.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Robert Richter" <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Terry Bowman" <terry.bowman@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Message-ID: <635c3f9e39742_6be12941a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
 <63531a9dd51b9_4da32946c@dwillia2-xfh.jf.intel.com.notmuch>
 <151c093f-1e92-1c8e-957b-8781e488626a@amd.com>
 <63587b16dbb3_14192944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <69a14ac2-510e-fd8f-0854-60805a150663@amd.com>
 <D9381C12-A585-4089-873B-3707C17823D3@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <D9381C12-A585-4089-873B-3707C17823D3@fb.com>
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA1PR11MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: e09106a6-1e92-4a38-c51e-08dab9257a9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCgUrqwehCWkkuL/tHCVVGiKkSwYCrZZ8Wh29ZyUi7GQOg9M3phiii6OcJBTdCrYud6iQs0z7u5zRX7J5FbsnLuZ1qKazwqU/vcmY2nMqyaS0ZLfMyPv/sgmOIvXXT75hhe8r/4DmxhLVUaQDKxcfzrK/mM0ogvne8HexUZn3tZc77mTZWyrt57YkJkldUFnuSopRv6vvvRfzNyOtLnHaWQI6erhAgNNcm6T07yps+/m48H9fOI8t5Q5n1iauh5hnfGRHzOpJNE6HRY8Gvr2ibRWijzyd2YuJuW6NFggWtJmnBTNOY4W42679GXqQRSjOqb7h+fJEweTSgppnqPYaZ4BLZ8ZMTm8ahY0DxJaRq2RQWHbpp8Tu6HQncvxsCicPLhES5DyKwf1M+p+1taLwy6gcIrm6A2rOGU98wT5UirwU4R0TjgYk4349pgu+1MvfXZ5/MIlmBfURFpnNvaIKCgicaaGoP+Z0qb0eGhbQFhOKzCsaGUlTmtr0PC+tJ/g9G4XpBEVelVJs6hqvkg42ql/87b6xvru1KPPhi/4V8LmAcG3XdSFw0aAXRBVisbRF5tc//f0Sab7Ixua2H19u/6/KPAFqQhGKyMjtCHnaM6ku7WYarhjBgBzfyOhSUk2iI+0rgtYWl95MjcaLhmhNAtBPsQzbWxiOM0WTXCFjQbal6KknXT6gOJbqQF+nJ+P6GpSsGT5hYGG4QoEAcg53w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(53546011)(6512007)(82960400001)(86362001)(316002)(2906002)(186003)(83380400001)(4326008)(66946007)(54906003)(9686003)(6666004)(66476007)(26005)(110136005)(6506007)(66556008)(6486002)(38100700002)(5660300002)(478600001)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aOd863uLsqHkHQACnaQbU4MgfPf8u1JGGxivhhSAGNuVAusXH1gmlE8j4FDX?=
 =?us-ascii?Q?Ug4+U7VS0wr+e9VINph/P4ujWtg+gNlfardtbiHh+Da/gSNvNRoimwExqE4d?=
 =?us-ascii?Q?0eae3u87hULPZjZNCsqOzDnb25zgtsgvTL7O+wKkY8+izlkvC6/BCcDY8k6k?=
 =?us-ascii?Q?6dQeN5Ojv0zDvqdHYkd6ARUNFLlzVjNbPnVnw6ywe5FlYPsBCQ+ndhK6WLz+?=
 =?us-ascii?Q?9gm4nTbGtx3VnQTo8t6hlOkeNleQCihgXbp6AxprT5TT8jO8aVPCyAsBJ4/F?=
 =?us-ascii?Q?HTeBhDXHa9j2F2alJmFF5oPaXYA6SJZnvP8YXlIl999oo+1m+dEIxXGRWkm3?=
 =?us-ascii?Q?SXE5shP5ariljURmRtdJrnJVzAgRtfNflolas7KBBAc/OstcYC097qNh8UZR?=
 =?us-ascii?Q?tBrPUYh317JabgwVRyoZzLMO/OlPeiJpPAT6GxZEAAKNx/2t2ZDWe7JmzkQ2?=
 =?us-ascii?Q?YiEOzxtEBswSAzbZGdZtAuKJTqNgTIxwA53oxj99UrTj6Cun3Hl6OHhwiQQc?=
 =?us-ascii?Q?cYY7XPPNCGNztWKfyVZi1te3mJHA2AFQcaIF3aLXpURXn07jp37YBCafhK6g?=
 =?us-ascii?Q?r7aHTz38rXFSL/Wykct1buISWqk42cL9FsT6eZ9nL7sIQ1rT5LwdouYRC/F7?=
 =?us-ascii?Q?aNR6WMo/DzwMelnbkVCYNPHeMy3kUt2SE+ws9cfFaXtSzrhNgkN/prbJ7PSY?=
 =?us-ascii?Q?LNmMn0IxWNTLilbmpHWPQLDz7fmMIIRuQAgahsymUHlxD74rRS9VQ66sN7BI?=
 =?us-ascii?Q?3gVLxgOZGMRselwtV2JpsLTh9W5ljak9O0g4EEAluft4ee8hEeHXuGOhVQml?=
 =?us-ascii?Q?zeX4lk9iGIf9joS4YxO6b/H7xMunjMHdKiGomsGAW04+zuuxndId2wnhrb/n?=
 =?us-ascii?Q?//8htfoX4HGcX4K6kyejwtTQVBKYzRbjxmXsLmBK8QPlTzTW9U3PSTYeZrw8?=
 =?us-ascii?Q?kKNdrJcexqRz1wkPzKx6ybJLuAUkleO1SIiu4tO1rZn/8ODJT8ozDGuwIlIB?=
 =?us-ascii?Q?eidRt1N0E+d6v81f0FrCz7v3uiSl5huMFxy+1D5Yhrb5uIMHRsbOts39QvAE?=
 =?us-ascii?Q?uS6iasGAcljTPa5Ecw5OUyFnmkz7N+gW/QkZRUvqu4Xha1LMDIzH9+vNBEkd?=
 =?us-ascii?Q?TFuPAMJEMic6zeCcI3Eq2sxnV0QT5jC1kEPPmKOtIl2+2Tdjb5HUmLwkX/kR?=
 =?us-ascii?Q?n4YzF1WuyZQhbzr/ZfyIaqBbG2kmoR3BlIMmwR56AW7l2a6mJpXNTj71CS4p?=
 =?us-ascii?Q?AlGQNCjBmCwKPpZVpS4GWTP9Cn4EiQPsTo9gO3wphytLaY1Lq2OoKEg/QliY?=
 =?us-ascii?Q?QzXWjvQ9TKCSze036OHwvnYS7pPZCS+MccG+PWKx5tadl1SnGsN1MGhPIuyN?=
 =?us-ascii?Q?24qWD4XG24zJA7NCWE8zOWaAObPRCbZaC6kkDc8OM8mhMUwYwV6VugPwVk64?=
 =?us-ascii?Q?CzSa7u9ub4nFGSwPzl57josdNdMvkDZiqKDEcMsurGz61XN4GueqxRuaoM5A?=
 =?us-ascii?Q?FfwB1TLTn6fKWjrYkL9XgiOJ74S128Wfsz961VoceSSjtOgG7OBNGfanc06s?=
 =?us-ascii?Q?5eq6FGXw2fJamNF+hWGReUbDERzuAYSlEzs8Kn5iYXSjRFLkWKxV0YaMey3x?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e09106a6-1e92-4a38-c51e-08dab9257a9e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 20:46:25.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cKCXkeglJ6wxFkPLTtCc2mFt2aO9jo9oA7S+J8Fjg2/Gj1qLOlVCBJB/HMQeSltxUj6X0R6NoApydYwe3v1dqnWWZxQHStnKtb1RwR2VX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Zhang (Infra) wrote:
> 
> 
> > On Oct 26, 2022, at 12:31 PM, Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> > 
> > On 10/25/2022 5:11 PM, Dan Williams wrote:
> >> Smita Koralahalli wrote:
> >>> Hi Dan,
> >>> 
> >>> On 10/21/2022 3:18 PM, Dan Williams wrote:
> >>>> Hi Smita,
> >>>> 
> >>>> Smita Koralahalli wrote:
> >>>>> This series adds decoding for the CXL Protocol Errors Common Platform
> >>>>> Error Record.
> >>>> Be sure to copy Ard Biesheuvel <ardb@kernel.org>, added, on
> >>>> drivers/firmware/efi/ patches.
> >>>> 
> >>>> Along those lines, drivers/cxl/ developers have an idea of what is
> >>>> contained in the new CXL protocol error records and why Linux might want
> >>>> to decode them, others from outside drivers/cxl/ might not. It always
> >>>> helps to have a small summary of the benefit to end users of the
> >>>> motivation to apply a patch set.
> >>> Sure, will include in my v2.
> >>> 
> >>>>> Smita Koralahalli (2):
> >>>>>    efi/cper, cxl: Decode CXL Protocol Error Section
> >>>>>    efi/cper, cxl: Decode CXL Error Log
> >>>>> 
> >>>>>   drivers/firmware/efi/Makefile   |   2 +-
> >>>>>   drivers/firmware/efi/cper.c     |   9 +++
> >>>>>   drivers/firmware/efi/cper_cxl.c | 108 ++++++++++++++++++++++++++++++++
> >>>>>   drivers/firmware/efi/cper_cxl.h |  58 +++++++++++++++++
> >>>>>   include/linux/cxl_err.h         |  21 +++++++
> >>>>>   5 files changed, 197 insertions(+), 1 deletion(-)
> >>>> I notice no updates for the trace events in ghes_do_proc(), is that next
> >>>> in your queue? That's ok to be a follow-on after v2.
> >>> Sorry, if I haven't understood this right. Are you implying about the
> >>> "handling"
> >>> of cxl memory errors in ghes_do_proc() or is it just copying of CPER
> >>> entries to
> >>> tracepoints?
> >> Right now ghes_do_proc() will let the CXL CPER records fall through to
> >> log_non_standard_event(). Are you planning to add trace event decode
> >> there for CPER_SEC_CXL_PROT_ERR records?
> > 
> > Thanks! Yeah its a good idea to add. I did not think about this before.
> > I will send this as a separate patchset after v2.
> > 
> > I think with this cxl cper trace event support and Ira's patchset which traces
> > specific event record types via Get Event Record, we can start the userspace
> > handling probably in rasdaemon?
> Yes, I think this makes sense. rasdaemon could aggregate data and provide user
> with full picture:
> * Memory errors from both processor attached memory and CXL memory.
> * CXL protocol errors.
> * CXL device errors.
> Such errors may be handled either firmware first or OS first.

I have no concerns about rasdaemon subscribing to CXL RAS events, but
the nice thing about trace-events is that any number of subscribers can
attach to the event stream. So I expect cxl-cli to have a monitor of
these CXL specific events and that does not preclude rasdaemon from
also incorporating CXL events into its event list.
