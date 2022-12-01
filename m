Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACAF63F61A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiLARYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiLARYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:24:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8EA2CDCF;
        Thu,  1 Dec 2022 09:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669915455; x=1701451455;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GRxn5ZBVqZn1XBZ0hP23iK0+aKUsGAaW1jK6n3cvaho=;
  b=A2yX5EYOwWggzPWc4Z7xxn+JX0c+Hb2T4KRLTjmXSmFahJMd4OyPEpjP
   O2xSeFQxNPPVCRG3tNfc9LKtw3k5xfmWb4F7pGGXWF/OBiyeSOTdcT9xn
   MsiGQyFHjoPLVLkTM9xru4TmeH9YQVsf3zvdbFKH6T3qhFthxRNb5keex
   oDq59L/r45hTYmjza4W//UP+UzHY9a9eUvK9BICPgtOVVRlQOtK4hmxiu
   dwxFuk2xZckQd1jK2GYnPDuTmSebf5k8wXv7It7I+l47Cd9Zv623GcxcO
   QJ7U/2p1yAShGSKEvdj5c/RbH1ssrm37qOPMNjb2y+/Oo8phdOiNt8YxS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="313380431"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="313380431"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 09:23:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708154409"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="708154409"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 09:23:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 09:23:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 09:23:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 09:23:41 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 09:23:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFPbVaJLB2y6dMpXR9jRFTRNxeXq6DipFrzaHutMujCG+Ulw61CtB2Eo3HRvcVH+v6nbHYaQbo4VK6oZ0JkmCZRILTOxezXXtKJdQ7R/62fnihbde3l8m9P96u+VSt15riwYoFmc/pSe4xsvQWwQ57QUREYz0J701ONMtfX8toJlFi3KoyIFE5cazw68QivNdAiuPfsBdQVfprBki9ZHwWrUSCXNsZBwBDW5kl9BpJj+ZXDBq5fkuRaGMiV+U5bcs27vXjj/U64oaFP69Mc0gXiwL34wdv3zA6SqJ/0JT+eFuqxfZQGciS6TLzfA+/OMeNuwJaKr3hc3ae680qsP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GHFwi65wTfewOVZD7SjgMAN2GxgAPdRaaKhOclXN/E=;
 b=MgHToknF5LhdgAxlmwNN4j+VxaqFuJtS3pvxefekEtZO09USpwub/7rHnAZE7X8JC9cV7DMjNCieHaDYAu9dt31QqKRwFilwiTvOnNghJNRz0L5ph0OTVsdXs3YNUvbjazHe0SvXS3BcavZGN86acI1g+bZH8/chW7x/FqBa8f2A//QkfXwGHbw+Xhe2QiiXoJ20RxVhyksO/v6Yu7DY4AaI3ppQnt5SQ5d53V88urRPpCZnCgAkDthVtt8xfP6wnfM052P2qBG9RDvrEyTaUH9duzJJ0/mtTgvS26TEiJPPY3d/bg3qF8N3mYoDKVbo+nBK7V69RtaSihbfJ6sTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 17:23:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 17:23:38 +0000
Date:   Thu, 1 Dec 2022 09:23:33 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 08/11] cxl/mem: Wire up event interrupts
Message-ID: <Y4jjFcSxdUqcnn9v@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-9-ira.weiny@intel.com>
 <20221201142118.00002933@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201142118.00002933@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 7414b0f4-88d8-4d60-fad3-08dad3c0c8ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXiaFn2cKm8I44D0K6KhbgiZLG97fu4RTTvL6maT/yxDKkByZ4d5x8cKzRtdbygo+VknEFUSU7ugyd47IMvm1Z/Vpix+hGI4exuH0T67YEmn2V8DZQZCFXVhgZiLMsbEzmAwxm8oshCQ418RD1TYHlSKUPQtGH3yCfrG4Hog4yhEQ+T2ew30GkpmG05551872PPEO9K0cMMgw8dzTRwO6AjNnmir005v/nOVXj+/WrcjeK6k5KTt71NSa5WNl913ISBaUzUpm2XUP2mQT5ZSbh14if9vEh3/7vf5uDyrEKIehdL9YUJQgyAnRfG+xAHs85yKvK9X7hDNH+jSBfE4/Twl5rseN7uOYqEOSPHocubRVTHpNfyJd02jU9bvqhUCkKxb9IXMpHzeY6jIU7HVtpSoPEm4Zxbl4G7WE1LM3Tw+lIJ9muRGjTE2wJ2/vts5lE9lgHec0hQuhljH7orPipFvVHYZHk+VsqVEeXpz0GNWjW5MOxxwjuxBEBX5/rwpPDJ0lDnwHSPMRnmI75WZiDOLO4TrPoKTZzvp3K2xvny4/wZmBF46BxOZkYkAFhFD+htAwnOTSqDva7iGS3oUQoQ568RbvCUSKwFQ6eKMmmwMNTGBD6Iljn87E0c6N9KVDxX97lFnttFuIEtk5pL7Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(54906003)(6916009)(6486002)(316002)(86362001)(38100700002)(6666004)(83380400001)(6506007)(186003)(9686003)(2906002)(6512007)(26005)(44832011)(82960400001)(33716001)(5660300002)(8936002)(478600001)(41300700001)(66556008)(66476007)(4326008)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6coD0UCT6KoMx/HwcfQFr12hlK/kSESJfYdhrYItQPqOkLHoOW5msmblt0j?=
 =?us-ascii?Q?cUR2K5jd9nIhFDmv7mMAedTF30WTEO96Dpmj8D0G/BsgsAAsYxdRPeff7jra?=
 =?us-ascii?Q?kR5vgCBcXFIqvs8tRZ9iJA2QCCAa4bcu7DcvOT/ZcFiEymNwU+vyiLBnsKVV?=
 =?us-ascii?Q?OtAEKanbkqs3gV2hTRG9N7+hmdq+Hm9navSY0xO8dUVSx1Z9Lsjo/2PbVZ96?=
 =?us-ascii?Q?fLHlnXRysvHwy/euRogOlbJufpH5ygeFFtL9q+ZswDHkqXQEuQN4Eh1icfqL?=
 =?us-ascii?Q?+ruMwfLtp9NNO8aKCc0GL/IYe0jfYyFPlcoMU7jREoBS8aowQgkTsggiFipD?=
 =?us-ascii?Q?4nkkwjxNGoG71ipWLMf3wegw+EkfsaRGPDC4HIyXskadFDhOdDr+qPWyYpJS?=
 =?us-ascii?Q?c3oTwNSism0C+ysXHaPcFnvo2jxa7DnHDQtzndKUKHwy6bbvEGa13yXYqBOS?=
 =?us-ascii?Q?Jn/I2cVwsU64htux/Z9s1EtmODof8jdhtTm+mIz93iZMD+mrKjS3GQ1d9yV3?=
 =?us-ascii?Q?O13eTYyOpgAvW9IDAO0A24ETAvBp6Qx83PXNi74zfpcCYxrZb6ZKcOXtt5VH?=
 =?us-ascii?Q?YzCSD+iquxPurImv743Tt9N07YdABGbx4HdFxj22nOo6X3/ETqmCh03Hf14z?=
 =?us-ascii?Q?lzmwnkWH+7d2OI6AzfU16GsyDBmbCV7bfQcpSaoZRadE6pDaLmxP6ky52gLp?=
 =?us-ascii?Q?+RCHEcJynzIuBHUNpqemVwRtthZZVcDRzgO+uwQDEru3YGGPfrnXxccFF3ni?=
 =?us-ascii?Q?dXHvY+pi384HWuvie4c86r1RURJB8abilERek8FLe6g/+4ONjgXLiNuxf5ZV?=
 =?us-ascii?Q?5X30qhTelf8k5gs7VTqpkDqICQCOoaxvor36J9ksoP2Jm3o57iJRukAxsKQu?=
 =?us-ascii?Q?69EMmKnUHYvi/dpKwKqIskDpVm26vanjovXKXxWQYug8sCSSrThBkGuRJ/bH?=
 =?us-ascii?Q?FvK4JPstFXvar4ZQqG4EaagfUFr7aVhSFTeBTnawYqqUFHbV48HkN9/qxNFl?=
 =?us-ascii?Q?tqbjshUhPbgYHTRJsWiexILJ2Bf7Wwso+ainhzPAZdba1rzZkFmFUVQP0jIh?=
 =?us-ascii?Q?2lOKB2vs6X15SSXYqw7v85zl4KM5WV+3vncha0N7Z/SXZqhFWjA7je7Lze8l?=
 =?us-ascii?Q?itsku8dwYtL7YTd8b/BcUAXz0b9K0AEeaTT5856S7iTnaMdMhCRRhRASH05e?=
 =?us-ascii?Q?w3ARfvz4KcDQbwL/LGRkeHZ7CC/jcvZ1bzMo+py8yjFbNM33k2JqZBcZLpYx?=
 =?us-ascii?Q?NUoby/VzZrEzLdQA7+dcou+hjLtTAEAyzwD0htn5lz0EOyMn91vmmh1GW8BM?=
 =?us-ascii?Q?8z3/n2Xir0D/QAieJsFK7F+K4pd+bfVZDVg1a23XsbsNmFJMshaY2Iy8aIB1?=
 =?us-ascii?Q?wz1XVQ6yMbwD8/4NRZRhCeWsns/hDUXSVQdvoYC/Y8HRBPlwLkmAPrH4oeeu?=
 =?us-ascii?Q?CKhHp/vkkl9ZFL4RIC0i2TdDEhK/rSNA6zoOuDKyGFlSqqRwl1OIu9M710bU?=
 =?us-ascii?Q?M8P7PfXAzE04OI5wsCPHmU9U/pjYDfqXIX5M0cKliaNrPB648ofBDC8aC4Ks?=
 =?us-ascii?Q?Lq/GF3W56pQ4ZZiWM9/aCK+o109FbIroxqYdbhXM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7414b0f4-88d8-4d60-fad3-08dad3c0c8ad
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 17:23:38.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wu9Ib5HJQPDK7SbsCoDkSAztd/DYm9Tqv8bK6ZiXV8Akqbcv9xwxHvHmnXz/X1DXBtUrccg7TxuiHu4LSRElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 02:21:18PM +0000, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 16:27:16 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL device events are signaled via interrupts.  Each event log may have
> > a different interrupt message number.  These message numbers are
> > reported in the Get Event Interrupt Policy mailbox command.
> > 
> > Add interrupt support for event logs.  Interrupts are allocated as
> > shared interrupts.  Therefore, all or some event logs can share the same
> > message number.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> A few trivial comments, but only superficially code style stuff which you
> can ignore if you feel strongly about current style or it matches existing
> file style etc...

Thanks I'm leaving this one I think.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > 
> > ---
> > Changes from V1:
> > 	Remove unneeded evt_int_policy from struct cxl_dev_state
> > 	defer Dynamic Capacity support
> > 	Dave Jiang
> > 		s/irq/rc
> > 		use IRQ_NONE to signal the irq was not for us.
> > 	Jonathan
> > 		use msi_enabled rather than nr_irq_vec
> > 		On failure explicitly set CXL_INT_NONE
> > 		Add comment for Get Event Interrupt Policy
> > 		use devm_request_threaded_irq()
> > 		Use individual handler/thread functions for each of the
> > 		logs rather than struct cxl_event_irq_id.
> > 
> > Changes from RFC v2
> > 	Adjust to new irq 16 vector allocation
> > 	Jonathan
> > 		Remove CXL_INT_RES
> > 	Use irq threads to ensure mailbox commands are executed outside irq context
> > 	Adjust for optional Dynamic Capacity log
> > ---
> >  drivers/cxl/core/mbox.c      |  44 +++++++++++-
> >  drivers/cxl/cxlmem.h         |  30 ++++++++
> >  drivers/cxl/pci.c            | 130 +++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/cxl_mem.h |   2 +
> >  4 files changed, 204 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 450b410f29f6..2d384b0fc2b3 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -179,6 +179,30 @@ struct cxl_endpoint_dvsec_info {
> >  	struct range dvsec_range[2];
> >  };
> >  
> > +/**
> > + * Event Interrupt Policy
> > + *
> > + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> > + */
> > +enum cxl_event_int_mode {
> > +	CXL_INT_NONE		= 0x00,
> > +	CXL_INT_MSI_MSIX	= 0x01,
> > +	CXL_INT_FW		= 0x02
> > +};
> > +#define CXL_EVENT_INT_MODE_MASK 0x3
> > +#define CXL_EVENT_INT_MSGNUM(setting) (((setting) & 0xf0) >> 4)
> > +struct cxl_event_interrupt_policy {
> > +	u8 info_settings;
> > +	u8 warn_settings;
> > +	u8 failure_settings;
> > +	u8 fatal_settings;
> > +} __packed;
> > +
> > +static inline bool cxl_evt_int_is_msi(u8 setting)
> > +{
> > +	return CXL_INT_MSI_MSIX == (setting & CXL_EVENT_INT_MODE_MASK);
> 
> Maybe a case for FIELD_GET() though given the defines are all local
> it is already obvious what this is doing so fine if you prefer to
> keep it as is.
> 
> > +}
> ...
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 11e95a95195a..3c0b9199f11a 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -449,6 +449,134 @@ static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> >  	cxlds->msi_enabled = true;
> >  }
> >  
> > +static irqreturn_t cxl_event_info_thread(int irq, void *id)
> > +{
> > +	struct cxl_dev_state *cxlds = id;
> > +
> > +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> > +	return IRQ_HANDLED;
> > +}
> 
> I'm not a great fan of macros, but maybe this is a case for them.

Nor am I.  I particularly don't like when functions are defined with macros as
it makes git grep and cscope harder to use on the code.

> 
> > +
> > +static irqreturn_t cxl_event_info_handler(int irq, void *id)
> > +{
> > +	struct cxl_dev_state *cxlds = id;
> > +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> 
> Superficial and this is guaranteed to work (8.2.8 allow all sizes of read up
> to 64 bytes), but maybe should treat this as a 64 bit register as that aligns
> better with spec?

I suppose it does.  When I looked at that I only noticed the 32bit field and
thought the register was 32bits.  But most of our reads are to u32 fields.

I think it is fine for now.

> 
> > +
> > +	if (CXLDEV_EVENT_STATUS_INFO & status)
> 
> Another maybe FIELD_GET() case?

Are we using field get for individual bits?  I see we are for some things.  :-(

I was thinking the 'field' is 'Event Status' and the 32 bit read of the
register already got that.

> 
> > +		return IRQ_WAKE_THREAD;
> > +	return IRQ_NONE;
> > +}
> > +
> > +static irqreturn_t cxl_event_warn_thread(int irq, void *id)
> > +{
> > +	struct cxl_dev_state *cxlds = id;
> 
> Why id?

Shortened from 'dev_id' from the devm_request_threaded_irq() function
signature.

> I'd call it what it is (maybe _cxlsd) and not bother with
> the local variable in this case as it is only used once and doesn't
> need the type.
> 
> static irqreturn_t cxl_event_warn_thread(int irq, void *cxlds)
> {
> 	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);

Yea in this case it is pretty clear but I hate having to look at function
signatures to figure out what a (void *) callback type is supposed to be.

This ...

> > +static irqreturn_t cxl_event_warn_thread(int irq, void *id)
> > +{
> > +	struct cxl_dev_state *cxlds = id;

... helps to self document cxl_event_warn_thread() IMO, and the compiler will
optimize.

Thanks for looking!
Ira

> 
> 	return IRQ_HANDLED;
> }
> 
> 
> > +
> > +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> > +	return IRQ_HANDLED;
> > +}
> > +
> 
> ...
> 
> 
> 
