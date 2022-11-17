Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0962E9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiKQX4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiKQX4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:56:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2143F07C;
        Thu, 17 Nov 2022 15:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668729370; x=1700265370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n0qUJOG0byq0SPUuwsEBJ84opL30x/2Du43C1wJEuyA=;
  b=ZyndG8WyOBkeZPGFXtGlh3Md41RJTP4jTxuBMFgdznsBH/35YsKQ4EFP
   zCDcqp4ueL298vhPpqvpWGb9q0TS0S5Yy2PLxzeJ0dbdtOqW0CPZecEZw
   Kc0xWvV2PyYfuckYRvPe0iJRQRBI+Or43VT8TcU5rnbF+gwyWVo43BL4+
   MGRXWTIDl682KiQdqZIbnhj7zNa4dqoDnCciKc8YfsTZtTqXTBvrC/0jg
   DRlsbPRDjY8ZODAknozi9tRaGS1zC3ejMY9uupymWUbN1dE6RV+FK+Kjn
   6/gK+6cpvL05UDhdPJxEZT9+4k7726uuT7HbJtqaipG7Bs78BxgXrhrRL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296372045"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="296372045"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 15:55:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="729027474"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="729027474"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.84.12])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 15:55:17 -0800
Date:   Thu, 17 Nov 2022 15:55:15 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <Y3bJ4/Vt2LTFy443@aschofie-mobl2>
References: <cover.1668115235.git.alison.schofield@intel.com>
 <46c7c7339224744fce424b196da3e5566effec17.1668115235.git.alison.schofield@intel.com>
 <20221116124118.0000144b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116124118.0000144b@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:41:18PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 19:12:40 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices maintain a list of locations that are poisoned or result
> > in poison if the addresses are accessed by the host.
> > 
> > Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> > list as a set of  Media Error Records that include the source of the
> > error, the starting device physical address and length. The length is
> > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > 
> > Retrieve the list and log each Media Error Record as a trace event of
> > type 'cxl_poison'.
> > 
> > When the poison list is requested by region, include the region name
> > and uuid in the trace event.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
> 
> I've forgotten most of previous discussions around versions of this series
> so I may well repeat things that were covered earlier!
> 
> A few things inline.
> 
> Thanks,
> 
> Jonathan
Thanks Jonathan. Got 'em all.
> 
> 
> > ---
snip
> > 
> >  
> > +	memcpy(&val, id.poison_list_max_mer, 3);
> 
> This is ugly.  I've lost track of last discussion about get_unaligned_le24()
> and using it on elements of a packed structure.  At very least can we
> do a memcpy to a u8[3] array and then use get_unaligned_le24() on that if
> we can't use it directly on the structure element?
> 

Done, like this -
val = get_unaligned_le24(id.poison_list_max_mer);

> 
snip
> > +
> > +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > +		       struct cxl_region *cxlr)
> > +{
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	const char *memdev_name = dev_name(&cxlmd->dev);
> Could just do this where it's used rather than here.
> 
> > +	const char *pcidev_name = dev_name(cxlds->dev);
> Same with this.
> 

Done.

> 
snip
> ...
> 
> 
