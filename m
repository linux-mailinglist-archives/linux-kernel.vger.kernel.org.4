Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BDA60D858
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 02:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiJZALq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 20:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiJZALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 20:11:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684BEC8200;
        Tue, 25 Oct 2022 17:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666743102; x=1698279102;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m/24d8NCONGDmE7YSdpSdHczZ6swe6jJg6LxSOUlvfc=;
  b=iy/DkV2NqyoUa1NSqhHILAO8sk4ptcebiAyB2LJhccNi+RsGJbPqmbfz
   H+n2XSG+q5I1mnFUPPa+g8tKDn9qFnaBnl/GXYDnCTU1Ar4nErvzPrKjE
   hpCTLg34NBi4dnByb/qBzvz/wIcdwtOaz0HTv/jVw1aQDSg+xlp9EiNIq
   TcdqgZVOdZ4Lf217/Ea0S7JAfZRrtyoRkYyrQfSI409pSsu85xiWM4MhM
   p1eCay6F20PPLK/Jk+e9uA3/T7VbPOufsxsFd7wDyi4OwP1pV6jwFPDO1
   Nj934QeJFUiKtWl1Vk2d6DktoX9TGreKOzIuCjAp0fsb8Go8snKD5qmE3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="287539537"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="287539537"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 17:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="774390844"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="774390844"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2022 17:11:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 17:11:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 17:11:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 17:11:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 17:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN+Qwq1LyuPrCeFvrYXXThaDBEQ0BowvO+QQL7eJxWHEctF5gqZj15qzkkH0z/rUwP66Y5H1DC0Wr39qciWq8siXsXergcVZ2rQNRw92fCDA6JEPWVJziX0OKQVgPA72gsfj1IbD/y3e6mQq7eea25c+Pf7uZikrAotRyjgofQ4omQ/JtOChaN54zbOR3i/ynENXg3qJXzCYVMQWo72AME+u6/iY2cm/13w1g/wFaKXZU2QmSfsle71NwG9bC91hdU8IWBi1rE/SnpnZmpbUba5Mr0WupBkANNko/lnar7ewlZ9L+jQFxDMOCBL2NIto6jsaqYXSdAEOvefNUBmdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pikJY7dEXdh/N+n4IHjNgasn22lJ/EPIAN5O9zJsfJQ=;
 b=BVDZwkc3AtYrTX6LuA/WpZuRCtL7oBrSKn8RR7pXuk/FRPraiQDiXV4ZP5d5DtGseBD9u+VWFGeS2fZewbrPsNxeoLSBWOL5gt8bNzT+YioSxahV2FZQc6b+eULZzZUiwGr9pP4Idc+8BVHg+XTmYMCtfdOngIGPcieGPsXlOIJ5lSnQxY+FNimVnlhiaEhW7gAuKVL+mZQbVZmrXaTwmBF4M2jWLF0guisJIm4xVbWcfr9cDy/1JcFzdCuvEuzQxCOPTqm73BMnz/B6iatCvBQq+gHJzK7ZwUhBiaK9t2/eeGHY5KjaQEKlCydsTdGduLwM/0h8DTmpkif5Z0ej6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6260.namprd11.prod.outlook.com
 (2603:10b6:930:23::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Wed, 26 Oct
 2022 00:11:05 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Wed, 26 Oct
 2022 00:11:05 +0000
Date:   Tue, 25 Oct 2022 17:11:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Message-ID: <63587b16dbb3_14192944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
 <63531a9dd51b9_4da32946c@dwillia2-xfh.jf.intel.com.notmuch>
 <151c093f-1e92-1c8e-957b-8781e488626a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <151c093f-1e92-1c8e-957b-8781e488626a@amd.com>
X-ClientProxiedBy: BY3PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:a03:255::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY5PR11MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a36cd7-14f0-486f-227c-08dab6e692c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpDA3Lh9vCRxG3JK8efbphZU1tUudxJUOVBWib/thpzMizQCAKQmzvq60qZIkZnBodvRiEZYoY8P+QorV3y89KL/AfdL1P6A6EpcooIEcPn5xVoBzyrBJJp+sRuxUyXRN+ACiIZzjpu0oc2Jv2Hkl1YNLf1V5a4gkl/WwCUCgQ7dAXH6ryBZIYrkaC9uETJ7WH/9s5kzLcrfsfUqPYcHzUe+HGME6nywqqJebqv4gClijlrsdF195RJp8GzD0l54Ux2UGiTzpBK5qyM5L7eQvgPVvygZKJAGOUBjTHjD0UONhBcytepP8fgl/cWee739QF2LLYMs4J6k3Nm+zS9RtTlXhLc1DyjozwAfiDi+A2P2LQtH6pslPbI0uAWblOxePfa+lIQ5dSKtOvf20Jtag5naQCupNOxmY2Rw3ymg/0EIJU4Z8IubvyFMnz/tXuPjOwNi5Ds8DD/nzA42kETK6KryAoZ9vixoyvf2AR+yR0mA1Na749rdUC6i5uur+Iz2SexZxRNE+sYLOC7DrP/3LBy027ikqMr40K5NJldE76V1G56E0ZVJaexsBu5vqhI31Q+Gq3u3JlBiSkjy8FkS4NYXto/+m9krURy3Ix+qTAKL9IbT+29o5j550Jd1uypz9bZsuvUJIiC7Bq2J6yUZ8NGY3/VzJK/XWioPpPZ2WxPWPstpwuAP+yS054sQX6+KNvFo4gmcvJyluW7BUNKLIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(66556008)(186003)(478600001)(41300700001)(66946007)(66476007)(2906002)(4326008)(82960400001)(8676002)(110136005)(54906003)(83380400001)(6486002)(86362001)(316002)(38100700002)(9686003)(6512007)(6506007)(53546011)(6666004)(8936002)(5660300002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?26vUQEwfbX/Ag0ot8autMitW0kcgNZLm+lEr2bIb14dpA9GAhZ7jjiGiUIGj?=
 =?us-ascii?Q?y5rxejOWCK4PGK9F5688tO4NGE07FB0are8lnisb7OfLrBWx8XIrpHwiJ9KA?=
 =?us-ascii?Q?DGOOYZqssPJfMABqYL5y69kG9bH1MjTKxzBGXQhRL8AlxIO/zU5Mpfi7i1r9?=
 =?us-ascii?Q?kSev+2Ke5rEmnQ4ch0ReKSgbiPxT4YIMElaCesaCNs9FbT60veseLGD/JITd?=
 =?us-ascii?Q?gdA6gaRQvzVwqpjRZsKDALJKw1+BLAQHy9ZjqanmSfs9cUAF6n/J5Igj1q8+?=
 =?us-ascii?Q?fQEtm4vQwGnWEioR/k/y4frElLmAwnog2rIP5nuu2ZRcotMAyETscEIenZdR?=
 =?us-ascii?Q?/IyE4UV4BTxgzKBaFTd4ZJt+Wtc3NF5yGdMU0f7dyFsaSAYEUudfFAo5Jxtz?=
 =?us-ascii?Q?+6xscbYkX5p+tDph/7wGujpuwnVMUk7WRGUjYdMpABUamnOnU6NggmONxG2z?=
 =?us-ascii?Q?xiKGCGgh0gU6gftAJqVg0kvfUK/womoPcPWPI/yaVh8t5CICzlWTrr7rd6n+?=
 =?us-ascii?Q?MQ+3vnXLggfTKtKEUOfpKDfgItdX2RR1ba+zI2ku+BQy1z46UFnjLaxhPCOw?=
 =?us-ascii?Q?Kr4ihkYaDJ0nVuoqi1nTXp98WuM5131UB+Yn21laSQGcyBcjumjg8OIxOeWe?=
 =?us-ascii?Q?oaz7AfZFktpS2H3AZpxK1CxPhssXS81LrILvoDGSJP66qu9FQN8STWSQT7AN?=
 =?us-ascii?Q?8e97+kuZ37RKl8TzsMuS+XpM0vkU+LUazf2uqG8f+hWyI8NqcXx2UP/hCgGa?=
 =?us-ascii?Q?ZTfDh+LqwaM2kQa8fO6YvRJryhG6nIcvmwE5GsC70rPJaoGkWMt1tA1Entyw?=
 =?us-ascii?Q?5u9IewWoTwNWaiuiXgBD7pkXVpXXu0H/F06GhZnN0I7GREzwgtfKgZdv1yvI?=
 =?us-ascii?Q?3nGsdsQ4AjP8pMs7YyQBuU2J8zcQYmLQOwDRtcZnh4y51KTUyV6qLvRhAAmj?=
 =?us-ascii?Q?2g4EyqeY/TcE+Yipz+r3pT+0eNlPtW2d6rAzcQCEGnoc6KMeeSUrCPz7IoQ2?=
 =?us-ascii?Q?l/d4QW/bIe+OaHkfnk0LeVHItiB6mD5FYyWjdPEh6SY66W5GlkLSEISHr4Pu?=
 =?us-ascii?Q?tJceEs3JUdEAV/E5y/sqi7oBKN12smA/JY0K6Y80MpQTSE5KulgQ+hNdqBkp?=
 =?us-ascii?Q?ncZ4yJtU6yxHMqFvgpZqMNKNpUelmWWT8pHrcgqgBvf1wPqau5hsp7WOQFR9?=
 =?us-ascii?Q?iejutuPkny7o8LvG1JBig6iDH2qVXWIoHllPtEQGovi49dzu/gjm72m8tgPo?=
 =?us-ascii?Q?/iBVXKol+mduOuqyOcbymierzFLknSYwoePWAyvcKE867yQxHBtIBw0teqVe?=
 =?us-ascii?Q?XGS3yzCx+4J9TrxLo7XVu3GXXtFPKaY0OVqAaXPID9XEmyyTxYuuhPNF5u42?=
 =?us-ascii?Q?TiGP2Vmxnlq+JnhnU25i/WoZgOzhqe+w9IE1YpX4l/pLhuerJojYDgaSfZ36?=
 =?us-ascii?Q?wssFFk81vJ4EnX92rN1KUmdFVAAjeAgmT4bjfM/Df906vwKnGkgJaDYc0tci?=
 =?us-ascii?Q?AALy8g7rAUIOTiJAwfZSixi9r4OFrBhh1T7HYV/bgvC2OxVKA6zf2tg5+lNC?=
 =?us-ascii?Q?Pgf1nHDLyz8UJiD3aCtmXmGwGaozP5frLa794nXC2I4rWtmBwLTvuGurGvcf?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a36cd7-14f0-486f-227c-08dab6e692c2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 00:11:04.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pg7eyYlKPGo7fFOX+9Q3IPgErWGPn4h4+NfhTLkD1MWGAV6XSuPpDtu3MybfKfr7tjO8ShnqIx52oyoSr6gaxsQccD6J9BbNMDz6sjqwc9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6260
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smita Koralahalli wrote:
> Hi Dan,
> 
> On 10/21/2022 3:18 PM, Dan Williams wrote:
> > Hi Smita,
> >
> > Smita Koralahalli wrote:
> >> This series adds decoding for the CXL Protocol Errors Common Platform
> >> Error Record.
> > Be sure to copy Ard Biesheuvel <ardb@kernel.org>, added, on
> > drivers/firmware/efi/ patches.
> >
> > Along those lines, drivers/cxl/ developers have an idea of what is
> > contained in the new CXL protocol error records and why Linux might want
> > to decode them, others from outside drivers/cxl/ might not. It always
> > helps to have a small summary of the benefit to end users of the
> > motivation to apply a patch set.
> 
> Sure, will include in my v2.
> 
> >
> >> Smita Koralahalli (2):
> >>    efi/cper, cxl: Decode CXL Protocol Error Section
> >>    efi/cper, cxl: Decode CXL Error Log
> >>
> >>   drivers/firmware/efi/Makefile   |   2 +-
> >>   drivers/firmware/efi/cper.c     |   9 +++
> >>   drivers/firmware/efi/cper_cxl.c | 108 ++++++++++++++++++++++++++++++++
> >>   drivers/firmware/efi/cper_cxl.h |  58 +++++++++++++++++
> >>   include/linux/cxl_err.h         |  21 +++++++
> >>   5 files changed, 197 insertions(+), 1 deletion(-)
> > I notice no updates for the trace events in ghes_do_proc(), is that next
> > in your queue? That's ok to be a follow-on after v2.
> 
> Sorry, if I haven't understood this right. Are you implying about the 
> "handling"
> of cxl memory errors in ghes_do_proc() or is it just copying of CPER 
> entries to
> tracepoints?

Right now ghes_do_proc() will let the CXL CPER records fall through to
log_non_standard_event(). Are you planning to add trace event decode
there for CPER_SEC_CXL_PROT_ERR records?

I am not sure if the CXL CPER to trace record conversion belongs there,
or somewhere closer to trace_aer_event() invocations since the CXL
protocol errors are effectively an extenstion of PCI AER events.
