Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4096D2430
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjCaPlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaPlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:41:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8931DFA6;
        Fri, 31 Mar 2023 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680277304; x=1711813304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j22piGdNpFcD0Xm52EYLiQXxR1RIRcoCbgx4eDkM9Vw=;
  b=GwKO1SimrsNkpUH3BSQi21gW3vvmphryRKIID5e6JxRCGNWLSiruZNj3
   m7kKTq3b5RSAX+bzfpYGR2lydelLqhJr0S5K8/DzlIWzm6ZmqivbzBBBB
   QRMgUOclV+eMQQD8FwE/5ux2/LDPSoQEVkTCEeFBVMZXIk3aITc1UBnFd
   kaDc0C8pPr8o47PQ+WZ1mR5nk4PdpqS9khtPEZPuqgfpHgW5jSXriwdwK
   CoFjrbvWS39G+z1lJBQad7RlxxjCJIj0MgRxzy1BwWBi9YEEARhNHBt1i
   05bdvnFaB5KumnGLP5GSqS1AJiIPdcfqiMO6spX4M4D0yGhjFJLRIdiZO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343146537"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343146537"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="809089696"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="809089696"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.63.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:41:43 -0700
Date:   Fri, 31 Mar 2023 08:41:42 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v10 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <ZCb/No9ksoqaAUBJ@aschofie-mobl2>
References: <cover.1679448904.git.alison.schofield@intel.com>
 <7789c4ab210ca309b449ae948d3e56c44aaff38d.1679448904.git.alison.schofield@intel.com>
 <ce9221f4-88da-e16c-8dfb-e3438159f5d1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9221f4-88da-e16c-8dfb-e3438159f5d1@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:43:18PM -0700, Dave Jiang wrote:
> 
> 
> On 3/21/23 7:12 PM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices maintain a list of locations that are poisoned or result
> > in poison if the addresses are accessed by the host.
> > 
> > Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> 
> Maybe you need a comma here?
> 
> > list as a set of  Media Error Records that include the source of the
> 
> extra space between "of" and "Media"
> 
> > error, the starting device physical address and length. The length is
> 
> Should add a comma before "and length".
> 
> > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > 
> > Retrieve the poison list.

FYI - this is v10, but things you are pointing out do apply to v11.
I'll update the commit msg as you suggest.

> > 

snip

> > +
> > +struct cxl_mbox_poison_payload_out {
> > +	u8 flags;
> > +	u8 rsvd1;
> > +	__le64 overflow_t;
> > +	__le16 count;
> > +	u8 rsvd2[20];
> > +	struct cxl_poison_record {
> > +		__le64 address;
> > +		__le32 length;
> > +		__le32 rsvd;
> > +	} __packed record[];
> > +} __packed;
> 
> Pretty long struct name. poison_mbox_in and poison_mbox_out?

Yeah...I'll drop the _payload from each. Thanks!

> 
snip to end.

