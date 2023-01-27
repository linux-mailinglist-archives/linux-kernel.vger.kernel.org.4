Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97CF67E7FE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjA0ORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjA0ORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:17:51 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814164EE1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674829070; x=1706365070;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YSLo2Eg7xACX5j9lFrWlTXd/5fp84SzG0tsDWpLVJ/Y=;
  b=e7PTPfq5VhR2+oFc3XQ+88ZFGKiCRhklIjYf3lfWpLnslVNnGUFeS+Ce
   o51rrvqcyYPFEGG8npUW/l1bhtnLIaMsshTdSpfHni/HwAKwgOZF66laR
   qMsugTPiSyjM/7jaLSI0aITZG2WiKU57809ub8lTvG+mNy5rSF2gVjWeg
   Kwz+lGGkXo9VNye+65c4PWgb264ve87xg7zyDgVMIZoloCTZbTjRHAAEs
   Vo7Y8b045Y6VobNGg/IOs2IrICvO/Daal570kcdA3NYgM6MInYmCDYUVP
   ZlkHVZSryfnT7234IRP6eu88MBlGcJjCFF824T2apYtgKcsqzAlIDK5e0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="307437888"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="307437888"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 06:17:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="665270926"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="665270926"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2023 06:17:46 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
In-Reply-To: <Y9PSObAeUyHK2cc3@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
 <20230127071152-mutt-send-email-mst@kernel.org>
 <87edrgp2is.fsf@ubik.fi.intel.com> <Y9PSObAeUyHK2cc3@kroah.com>
Date:   Fri, 27 Jan 2023 16:17:46 +0200
Message-ID: <87bkmkoyd1.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Fri, Jan 27, 2023 at 02:47:55PM +0200, Alexander Shishkin wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
>> >> We can have shared pages between the host and guest without bounce
>> >> buffers in between, so they can be both looking directly at the same
>> >> page.
>> >> 
>> >> Regards,
>> >
>> > How does this configuration work? What else is in this page?
>> 
>> So, for example in TDX, you have certain pages as "shared", as in
>> between guest and hypervisor. You can have virtio ring(s) in such
>> pages. It's likely that there'd be a swiotlb buffer there instead, but
>> sharing pages between host virtio and guest virtio drivers is possible.
>
> If it is shared, then what does this mean?  Do we then need to copy
> everything out of that buffer first before doing anything with it
> because the data could change later on?  Or do we not trust anything in
> it at all and we throw it away?  Or something else (trust for a short
> while and then we don't?)

The first one, we need a consistent view of the metadata (the ckpt in
this case), so we take a snapshot of it. Then, we validate it (because
we don't trust it) to be correct. If it is not, we discard it, otherwise
we act on it. Since this is a ring, we just move on to the next record
if there is one.

Meanwhile, in the shared page, it can change from correct to incorrect,
but it won't affect us because we have this consistent view at the
moment the snapshot was taken.

> Please be specific as to what you want to see happen here, and why.

For example, if we get a control message to add a port and
cpkt->event==PORT_ADD, we skip validation of cpkt->id (port id), because
we're intending to add a new one. At this point, the device can change
cpkt->event to PORT_REMOVE, which does require a valid cpkt->id and the
subsequent code runs into a NULL dereference on the port value, which
should have been looked up from cpkt->id.

Now, if we take a snapshot of cpkt, we naturally don't have this
problem, because we're looking at a consistent state of cpkt: it's
either PORT_ADD or PORT_REMOVE all the way. Which is what this patch
does.

Does this answer your question?

Thanks,
--
Alex
