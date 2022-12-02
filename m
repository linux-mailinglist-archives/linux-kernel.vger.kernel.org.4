Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70511640EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiLBTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiLBTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:43:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96153ECE4B;
        Fri,  2 Dec 2022 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670010221; x=1701546221;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AZoN6zQ+dKY0dPWBJno2xPxVV6jLPqm9nwtUIjRRs1s=;
  b=aitNotDouP6Vz+31M60ue8UnLvSLrYn0mHInCy81lDANuIa0uGzEXfch
   JU/0NAxlUHWHYvWQ3Z2TbmJI4tAT8JK/TEfjDItOLXwfIwlWLo7FPDlnZ
   Ujs72usb0ZTrrdgKu/NHHUdZjfT6N9Hg4MZeyD3M4TdmQwhYzb9YCq4k2
   pwmjv6cmmtHxgNLAxcsBkYFB8s+pmorkNWvrHMtmaaVtGIOixrdg0md3P
   26UnzYvxSAMhpAwVb92EUkBRRg7WlB8aWW7JXyugjNeKJ3zmf3+aiVFkC
   oUU5SVUha0Oa9pDYoyuQHwPVE/IcJGSgXFljrX1yX0pNWxsOWy7PUeYld
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="380321658"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="380321658"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 11:43:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787403340"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787403340"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2022 11:43:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 11:43:36 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 11:43:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 11:43:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 11:43:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIKs2u08TUm1Q7TNkYdF0S7wlwbEH2lS3w0nSFUpQ4cCJnxG2ElHMleBKtC5MMhtipIXU+iu0ynCKJaU6SXX/qnLWvH7/y9O4GmBOilNeWYLU/4NZWq3sbqXaRfoKKXquAeh7cT5JsAVmWtcs2C8+tLKrBB+s8OyosUkbbO6rm/oFLWaZ0TJKdlmRCGelp2Yi10risGPMNQZzLuevMlniZ9G3TB3gwHf6SKfzmw4UFfEy2m6etF4PjbW885KQODkA/g86oKROz37hiILc5NRCiTaZvQCDwWa6Riz/yymeqEU9sbfrqduloVbKIhpE+5tdFhWw/a8dja9IxvBM5EknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXy1m2OeYCFYO0OdObj7FxOj5w38daKgSR3IUAaZqAA=;
 b=eEpOjWAf0xMT/3nV6yxfcuezp2tntbo0V9RUnCzjqycrsLlTy5QHHo3Za2sqsFSbCUpmY+yPaec8zajUTrp/6zeutk4t546cvYHiovWz1pky0x6C8jE22lUZToqh0yov6t2cCyQIlZeGf8NxLEYMg8CvexCkzIsb3KcgMxt49vbKuLSlsrrTRHKhrQXWSXKqrn59uIHYJaLSC627EAFIj7EylWr8C5aRtoOzxeGnYsPaIJTZ2Uzq4r7l7uXhJGfi9iQLL/LGylDrXrHXHQpB3XhzKyU04EJXkC5/J+q5SfGwinrpz2x6i2+Zz5qIB7W5jtRTSJ5qr889LFomhcWadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4549.namprd11.prod.outlook.com
 (2603:10b6:208:26d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 19:43:31 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 19:43:31 +0000
Date:   Fri, 2 Dec 2022 11:43:29 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 08/11] cxl/mem: Wire up event interrupts
Message-ID: <638a55611405d_3cbe02942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-9-ira.weiny@intel.com>
 <6389ab5156083_c9572947c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20221202141901.00003016@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221202141901.00003016@Huawei.com>
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN2PR11MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 054aca5e-5aad-4b96-183d-08dad49d7e00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjq//TSyLFpP8ftGvlM70LbWjwRU+e29ve3hS9tDvgD8vuekTxjKmkKnFXenX4stv9HLzH5rygQfcklx9rPpTY1jZXtvKIYbwGLtW1wB9cVKNYijWXMNX9Y6eLuDf8tEFFBEohKumwWVynxK/0h3hlSOi5rON8PSCAeP5pI2r6lC0O4tbB1WU+F0sFWWSMjk32mTP4XnDrk1N5esFsi1Qzc/2UV3AIBXnuMOXCQ0LyYvcueHbIJsvZs5dZSnfo4VtE+tBfT7huQxgM+I0xQvO7crzjnwjpgy+RHnlp5ct0tnOlnIOTrfMs7vNQqouMxjRtC8HTD0Nxa31TZ1dQrv7CBHSE/jGVTETPQqS+64MQ4a1D85xzOgE0eNEupqhS0umYimVkCs1zhVvb6LP3BLfuqtnOtzQXFhpNuGpZZovah3t2qhgc1K+sZ6JEcObS2K82sFNYXR6bz70pjHHISTmfMXb5gDAacQ2TtdORdO6tIsJrSk8wWni+CJalycZtJVoAjIFdm66RG3CRJR9zbHjuWwufCeg6dGGMrZ+Q54x2QdfMzKmY3fAacAmyTwcV9ia0CT4fNil8m2mR5uuAVzpGjXbT2b5FNU3QcsJH/Z2ztIPOYZSBnz0MC2p1Rh9gAr/MOPT4fV2Z3zqeYdb8P+Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(38100700002)(2906002)(82960400001)(8936002)(4326008)(41300700001)(5660300002)(83380400001)(86362001)(66476007)(66556008)(66946007)(6486002)(478600001)(110136005)(54906003)(316002)(9686003)(8676002)(6512007)(26005)(186003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vyBUquaVhPjKe8Y+OAvHGK4JHEHrWKvIGcngoXVsc2r/6Vi+FWYyxJJpsZsN?=
 =?us-ascii?Q?G6cC9PDpip2ykN/LDtb00Jqw8reLtZWS56tUEQfU3IyTlhMG9KCbdWev6bvE?=
 =?us-ascii?Q?x/1ckYubWRgbH+mKL1OZdgzTEC9kTmxlNzEcbz4pyk4Iya1Q7vJSqza4B/a9?=
 =?us-ascii?Q?So9ddKCHVTIfxIu3MndFDTGhEL/Ld9Jr4UM9zugenLQ9qCRe6myNivSYx5L2?=
 =?us-ascii?Q?VBw4goLenSjgpHPhh4aJE+LRhcbShvkaqU9XmQNXSi4KzatejXgWsACXkfuB?=
 =?us-ascii?Q?9+U6RhXX44aRm1Ma/taCdemX+6IS9VAo0SKN9UOX82y3ahlAJyK2iqM66Xab?=
 =?us-ascii?Q?bNVLGBn4nWXWT1rrMYLj1q0w4ZfMmo+0j8hGTT4Z7qVQ+VZjzYFWQme+SPvS?=
 =?us-ascii?Q?uZ0HGyZrBLRBcUHOtnDHO5oOzMjJ+5iNnZhTsAYv5ezuiuTIPYbYQW6vl7Fr?=
 =?us-ascii?Q?q2ZRtIiyDpu9qlpBGLyCniBl0O9fjLiFn4n/ygfaZxDRy1Q2axxymdpTtCBm?=
 =?us-ascii?Q?GIqpV8bxIPixF90jYVrixdWY7l+e4VcfurK3x5ny3xHT4OPrMQQyy15eLj2D?=
 =?us-ascii?Q?wbEKIUF467tX9qF0pseuc3I/xt7tolOiRTv5M9pV1Mkag0GDJGMN/H2MyFBy?=
 =?us-ascii?Q?m10NbAX5LFx5tksnvIear6ze2mNXYn2esgsR7uSTJPXzDw/cDPz/ooX5Rqfd?=
 =?us-ascii?Q?3iBn0k0e8IfobK+iTpV9U0DeyZ5DybUALODEPO7ztnCS3ZUW4XTmFkbRHJ7n?=
 =?us-ascii?Q?iNXX61kKeczO2zwFhagjgOfE9Y0rMFKk7qLiZKB6vI7gXPDr/x/AHddmlkJC?=
 =?us-ascii?Q?BOVF8kKGdFS4e1yklG31TFGkU46BKO8N6nNfUC+ZNoE0L0w0LlWA1zCK5oop?=
 =?us-ascii?Q?0j4gHaj/lN2SI3Bcrto0PdErrM4GEBMV2LGfSo4ddXLHFXBt/yr2DEDN3uTj?=
 =?us-ascii?Q?n2HVBKk0V84gNP1agTMmKDJQKpqWRDMy5Qx3A11Y4SnGerlLf2gSD4OEV5IG?=
 =?us-ascii?Q?9Wf4hzCQAefYyli3XacllTIDxOOpjhtMlu84uARb/WhlZj4gWgIk7bxe6z+T?=
 =?us-ascii?Q?/oLnEYpkwRMjQGJ82fKjauEsWMgZ9IMKtkiEXAQKtwB8iI7PlVxi0z2FBRHg?=
 =?us-ascii?Q?UheSbtzLnuBmzYfvl4GsDMez2/eE6e5cLJaQOg6yG617Lue4DYpuwwzVYACr?=
 =?us-ascii?Q?eMssW0zbNkDMDEeNkaxe/lHZ4jlk9Qx80KDZSFDo/Fy1yXc4LBNtyhmFw563?=
 =?us-ascii?Q?Xk4UArS9q4rlWm4OJw0Hn1bOOiKcopEBt2BaYkR9rI/DBJZ30BxxtG8DU/KC?=
 =?us-ascii?Q?8t0/x3gZgH/reKKCoNaNFrwrDXZ365P7ERLgXG01xWYcOt6lgadJmXqO5jux?=
 =?us-ascii?Q?aq+WEalQAVyWBm6GNumErjFSOBufDfrLFoMza51IgiIXeErsH0bsNwMRAmB6?=
 =?us-ascii?Q?zvCmy4KqwDEUtRdckjt0sCFuuteuDCi+sFojpdK8SXnfYVvCQuHmJND0hQtM?=
 =?us-ascii?Q?uqudfZPhB/O5ZA4vLALo3+apfOGlyHdH3o8nZWXnQ+AuvB4srOrJof9gsgSV?=
 =?us-ascii?Q?ctgedMOdbtPS5f1A/JV0rqQdgT5XOJgP1aJjL9U/qD3Ctk2L/iB8NRmbPeFJ?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 054aca5e-5aad-4b96-183d-08dad49d7e00
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 19:43:31.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyG2NLJDYoN8JQ+ZmzbYu4exTdYL5ogLu9OmEd8DoX5rkmn4XO2NURUhIez1SrESVfyWLqME9BHfZFs2zTtdcC3/KH4LRTNYZG1h9cHn5SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> 
> > > +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> > > +			     struct cxl_event_interrupt_policy *policy)
> > > +{
> > > +	int rc;
> > > +
> > > +	policy->info_settings = CXL_INT_MSI_MSIX;
> > > +	policy->warn_settings = CXL_INT_MSI_MSIX;
> > > +	policy->failure_settings = CXL_INT_MSI_MSIX;
> > > +	policy->fatal_settings = CXL_INT_MSI_MSIX;  
> > 
> > I think this needs to be careful not to undo events that the BIOS
> > steered to itself in firmware-first mode, which raises another question,
> > does firmware-first mean more the OS needs to backoff on some event-log
> > handling as well?
> 
> Hmm. Does the _OSC cover these.  There is one for Memory error reporting
> that I think covers it (refers to 12.2.3.2)
> 
> Note that should cover any means of obtaining these, not just interrupt
> driven - so including the initial record clear.
> 
> ..
> 
> > > +
> > > +static irqreturn_t cxl_event_failure_thread(int irq, void *id)
> > > +{
> > > +	struct cxl_dev_state *cxlds = id;
> > > +
> > > +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> > > +	return IRQ_HANDLED;
> > > +}  
> > 
> > So I think one of the nice side effects of moving log priorty handling
> > inside of cxl_mem_get_records_log() and looping through all log types in
> > priority order until all status is clear is that an INFO interrupt also
> > triggers a check of the FATAL status for free.
> > 
> 
> I go the opposite way on this in thinking that an interrupt should only
> ever be used to handle the things it was registered for - so we should
> not be clearing fatal records in the handler triggered for info events.

I would agree with you if this was a fast path and if the hardware
mechanism did not involve shared status register that tells you
that both FATAL and INFO are pending retrieval through a mechanism.
Compare that to the separation between admin and IO queues in NVME.

If the handler is going to loop on the status register then it must be
careful not to starve out FATAL while processing INFO.

> Doing other actions like this relies on subtlies of the generic interrupt
> handling code which happens to force interrupt threads on a shared interrupt
> line to be serialized.  I'm not sure we are safe at all the interrupt
> isn't shared unless we put a lock around the whole thing (we have one
> because of the buffer mutex though).

The interrupt is likely shared since there is no performance benefit to
entice hardware vendors spend transistor budget on more vector space for
events. The events architecture does not merit that spend.

> If going this way I think the lock needs a rename.
> It's not just protecting the buffer used, but also serialize multiple
> interrupt threads.

I will let Ira decide if he wants to rename, but in my mind the shared
event buffer *is* the data being locked, the fact that multiple threads
might be contending for it is immaterial.
