Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93C9606F40
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJUFMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJUFM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:12:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C194C1826E8;
        Thu, 20 Oct 2022 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666329137; x=1697865137;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=M6U+H+WiJoZFbo69HzugaWUWdYVZ7pMiXGVI+TJOAlA=;
  b=ElG0aeZdX2s0VotMro8iFqkkpAEhg4rKLVn/kWn+XECGgcIc+AwuYthE
   TkAh6+HUXJGbZuaaHeOnByoD4HUSGfg3AbgNUfBDaE8BBwGTcphjN+oF2
   0rA1oncYw0KbZ2C42j85KtuJqmqDc2W8a52e7D+XNd2m1c+6Huom4oghg
   SmRDWJWTSWfKJaBUz35z9rMQnVl1BaOUPeBOO5iR9nFejocGlThZYpBkq
   5WToZ1GhFOkXtgqPjX3dUSiD0n4mntknikH1yhRJZQGuHyZ4Jd01u607B
   F/3cAPl8pUC1xdj/uLiKwNtxOcIi3uhyjlpXuronD2Yh+eLlG09xDc/mo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304526880"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="304526880"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630282071"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630282071"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2022 22:12:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 22:12:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 22:12:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 22:12:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 22:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5c2O+5KWYhju2Qg2i+cGv7fVLzbagp4Zc0CjKh/pMsZdy47brxY4vMag1bpZsKN4G4CpnZpv/wx8OxE1tDyCI1gsnS6UmWZe0TMpUyE55eHxuRGO4fj/nW6Fmbf68RjFfeCHvdTMOA0e5I2+KUM+EvwLWxcJm22i4Ys5jlT8lHYBOYJdGNCKgXhnMXjQjiYSlz4TceZxMlVhNmqIg4HbD48p0Y2UIfJ0Kf6WJF0OoxNgaewk/qNR3SLu5k5lvvoAXnga0LmyzGFgEkywvjonwTr3BjIk7syRDGIkERGhSf4OFBklP19+2VXIIE+UkKt5TlqTwS2mEQkghfQh4aYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hvl5/d8Cpx8h+yccysszSWFtEjyZ5rsLGW+ou9mqpE=;
 b=R9gW6oK/KkUDqvC5ueQ30C6qQdqLN5a+PHgRuILw8yMmxqZ0ocNqfE/aKrOCaP0Y87OC6IXm7B0j0fwz3G6I3OwTm1BeofQfz+rTz6Vp8wfWqAUVe2fOSoYP0Emu57TSclc2D2E8F93kR3izHcLnIqv6fCcedpYJrFrpMd4UmpDFPyMPuZXmcUe5gZn1vJG2NWSeja9viUwTHLk1Bt4/hg7FeZtzQGOJ3t/dF6Ez2wCRB/Yd1Et4Sm6jRDTWI8eVoZyqpSOMR6mg2nAkUTGqAhTJw7ojS+O56bd2JvbhLd5gjQGEVqAU7j3fgH0EHNGx3WvSYf3qU8/pHsQft0a4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4593.namprd11.prod.outlook.com (2603:10b6:5:2a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 21 Oct
 2022 05:12:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 05:12:03 +0000
Date:   Thu, 20 Oct 2022 22:11:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <yazen.ghannam@amd.com>
Subject: Re: [RFC V2 PATCH 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <Y1IqHTlyD3L7CS9a@iweiny-desk3>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-3-ira.weiny@intel.com>
 <e29a0dfc-b8b0-ace7-0db9-d63ea6e635c3@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e29a0dfc-b8b0-ace7-0db9-d63ea6e635c3@amd.com>
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a84bda5-be19-4189-05bc-08dab322ca30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgqqibuWIiJ3w2t5amy6bhBScKz5kSNYHzm7sbviI6YIAJbTCWTK9W0O0GfbrG9sAVU3mXplIsKdpAVA/m2FaIkxKjU1Pl+oYT4H/FnLdt4P/BjbNpxdSVU0oDvkhVjsq3amn2uKoViLqg55/D0Nk2dBKFggRL0CG2rEnJ7ys8wPaNICc18yWRG5MUeAQg1OmsE6j4HyaB/HzthKtMzGSLoJe5Ti/ChkaQ5cVmVWYXHIk44m8AyKBG591y2MC2lKmlw9Yrvd/jJ9dOY0BEVCrEE1qvWTGy8sGNFt6atyRB1u5pIhsBUrqT8QZ5QLK9wwEoBapFuUXjx0nPhEc486UgnXgHmuDGoK3nm23IbZelYyjUHx4ohpDsWjkHMBFLpUtkXbCl2OuOmiW0tFcd6JkBNViSNusfWZcX+VNAIwtaov9Vjkch6iwftXoyPhaeryTrbVvAFuaJwTDUA6fIffd8UvHTSuEjBhTd82zFKSmbX1WvmzYMm5lqRQW/a1D3QzLgKff0w+K20yu+UO+KcRYOqzm26LCT6OBgKz71i49Om2joWNVuYHynbP0zyz+q7BpPbdBzuTdN1dF8erpKHGaK3S6NUvNgaeWnyVdWys0mThVVN6lMLgx5Zgs40k5WdSuROei281c+sCMlDlReASI+BcgFCjd847XfV3HQd5Rub/1njL11Qf/49wIIMoPma4QH9vrwMG4ZDyQsaSGqL1f41p3bs8jubr2iNUHWxXwXqynWckTVGVohUG3CcsliW8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(6666004)(186003)(6506007)(53546011)(478600001)(9686003)(6512007)(26005)(6486002)(2906002)(83380400001)(6916009)(316002)(54906003)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(41300700001)(86362001)(5660300002)(44832011)(38100700002)(33716001)(82960400001)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UR9uXeZqjK588wQd2F5ssStIKVRic0FmuFZd/Yfiwq73rWyHjzfxAriILa?=
 =?iso-8859-1?Q?VyXIqvq5eSSVydCyYapyj1iWlsL5mfl6aXbLAMpsrW/6+EAOTd9jV0rDM8?=
 =?iso-8859-1?Q?skyOiVLjrBXBo5eP8/+U3mCPUgamVTQuIhK6H4C5n4YpHp4QX7FIbMR7qC?=
 =?iso-8859-1?Q?pTU+RRDQDzW49cKgcnlgXyhXgZiRepuBDTr8yHWZ2hxufYTaKfVPy1aOXd?=
 =?iso-8859-1?Q?PuFY7ig87thZu+rHwOYeLortk0NYNbjbqP6MSgSg3gkksBKxU8admXjx82?=
 =?iso-8859-1?Q?bckK//oq3BHYvovBqzsGO2ryijxetLGHsMofoB9vhCmvcXgFFm6B7Rop1F?=
 =?iso-8859-1?Q?i1j3jm0CAzNowsRjwTeRxL+TFMlss1g6aHrQxqImNZQxnSMGb3tbuDGLTy?=
 =?iso-8859-1?Q?YTFnQtgaRwH+K/nzXwd0UTmjUE6pJnzynxwynrYkF5yDNRuB2VNlnuVfia?=
 =?iso-8859-1?Q?WGwfnEav5rxVO5wkxIo6DLHJiI/sB83mAnZ1xc2geqALQIMgfpdd0UwBds?=
 =?iso-8859-1?Q?PDxo/xNl9N09sNpcHGInpS9N2jcOu9IUPj8C+6jgaFcFPt4hVzefA0a14r?=
 =?iso-8859-1?Q?W6bAAeWS2roRRl7Kz1bB1Ko6ROQr5Z/REGiSK7ChMOTtZHSuXz8A1LC+7m?=
 =?iso-8859-1?Q?dBtp+PPQ2BOvFcO8VgKTb3LrkReAEVy7nono+2TrRafwAiUCNBZksmKabh?=
 =?iso-8859-1?Q?t6zOP8F0GDmTBFDj5VDo5KRiWFNTqe4WO/BZ3N3COyg2ytvHoMy346EhQC?=
 =?iso-8859-1?Q?pwJC+z3+h4LCMOGMD0aOo+87CRe6hgcVKch3OOnwqScSIScbzrWl4dk8/c?=
 =?iso-8859-1?Q?ht+Orzlbz8QcNqgKmokdGknX8cqjTw7ESc1OPvngPZ+N/hF14zhS2Eu4Wc?=
 =?iso-8859-1?Q?eImJB5am0KMPnrngo8u/2OyFJTIt7s2laT2u4boX4HBhxk7vWNrerIoqQp?=
 =?iso-8859-1?Q?heIj2eYZG7KoqtrylVbxQUauDdqW0i6lsftarvwgBt6x/ovvhk2TRBjDS+?=
 =?iso-8859-1?Q?ow7locRDBMS5qAzbgH9fNGQ44DjyxvPsRoahLFopuOueorinGkQK2g9nAj?=
 =?iso-8859-1?Q?oBwp4XV3goyqNklIPUkGhpc4h1V0augAgRgk839WTNLKeo1ytJolq9DLwJ?=
 =?iso-8859-1?Q?pwnNM5tXJ7sm+ALHUvl8AtdbGNC02oH3LOR/6GkB8d2syj0jpXvSZOBil4?=
 =?iso-8859-1?Q?zlm9DlCaZuitXojTkYhsajWetwXIih97+yACkjWdqJdZDd7bTFzqgUA/W8?=
 =?iso-8859-1?Q?rzZi2F1lh0J1pFc7ZskGPL1U2O3eTx7xmg58sChEq6eV1jL0p1xJmLtTfE?=
 =?iso-8859-1?Q?kAUwe//m5lnK4yr/x8Rujed8m9aBgKN7MmSbIMLdHxsTiQ8fK1IgsdVC0A?=
 =?iso-8859-1?Q?/CIl50VS6/mTAbFGrb0WQEkqZ3zVVNkgc5OYgGHPIaTvs4s+PeaeXaorA/?=
 =?iso-8859-1?Q?814m8ISly0DGhNIRbIWcRqJABDOEG5qilvhAuA0XwL86uGCsVBtnm8FWi9?=
 =?iso-8859-1?Q?fxPFySqo14T3A+2cC//+l8+ikdXM7KnIISsXiNtfCulNhMXMNeSESfv/m3?=
 =?iso-8859-1?Q?XaGPjp0WeVV9/144Y20pnx8qke1Ry3apxtHwbw0f3gp0CMpqlfwx4UocxI?=
 =?iso-8859-1?Q?eCN5FZ/Y/uoj4bOWTp3aCLL8zWdRJeDrxX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a84bda5-be19-4189-05bc-08dab322ca30
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 05:12:03.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaJFw/rmh34R+ekDHCw9to7nSrZvhF9awTJXouGjZP0boe9mw8jUrVapp1jL4pKZ8NiNk/LFp9CMFNMkdNvWlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4593
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 04:50:30PM -0500, Smita Koralahalli wrote:
> Hi Ira,
> 
> On 10/10/22 5:41 PM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > 

[snip]

> > +
> > +/**
> > + * cxl_mem_get_event_records - Get Event Records from the device
> > + * @cxlds: The device data for the operation
> > + *
> > + * Retrieve all event records available on the device and report them as trace
> > + * events.
> > + *
> > + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> > + */
> > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> > +{
> > +	enum cxl_event_log_type log_type;
> > +
> > +	dev_dbg(cxlds->dev, "Reading event logs\n");
> > +
> > +	for (log_type = CXL_EVENT_TYPE_INFO;
> > +	     log_type < CXL_EVENT_TYPE_MAX; log_type++)
> 
> Why should we loop through each event log here?

The idea was to clear all the event logs.  I think this made more sense before
the addition of the optional dynamic capacity log.

>
> What if the event
> record doesn't exist in the event log?

An empty log does not cause any issue.  The query will simply return 0 records
which is valid.

> 
> I got some Mailbox error messages like this while bootup..
> [  346.387010] cxl_pci 0000:7f:00.0: Sending command
> [  346.387181] cxl_pci 0000:7f:00.0: Doorbell wait took 0ms
> [  346.387197] cxl_pci 0000:7f:00.0: Mailbox operation had an error: cmd
> input was invalid
> [  346.387205] cxl_pci 0000:7f:00.0: Event log 'Warning': Failed to query
> event records : -6
> ..
> 
> Can we just read the "Event Status" field from Event Status Register
> (Device Status Registers Capability Offset + 00h) 8.2.8.3.1 in CXL Spec,
> determine if the records exist and just query those event logs?

Likely the hardware does not have the dynamic capacity log and so the code is
asking for something invalid.  I did not think of that when I added that new
log.  Checking status register looks to be the proper solution.

I'll throw in some testing in QEMU for this.  I'll also have to implement the
status register in QEMU to fully test.

Thanks for the testing!  :-D

Ira

> 
> Thanks,
> Smita
> 
> > +		cxl_mem_get_records_log(cxlds, log_type);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> > +
> >   /**
> >    * cxl_mem_get_partition_info - Get partition info
> >    * @cxlds: The device data for the operation
