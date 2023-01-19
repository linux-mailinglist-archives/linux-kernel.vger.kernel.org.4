Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7E2674148
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjASSwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjASSwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:52:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713A75A24
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674154327; x=1705690327;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=198neVMP8EywBCc7ZP7lxKw0QfugbhK+fU6rK1K3njk=;
  b=hEy4i66ZzthbUES7/2aucndC0FiuE64Rq+WbvqBx7+eBD1Yhbx3MwB4M
   BpugqVcRLo5qfDaYF41qJ/6VbckWsoA8mzk2v4Yol/nZ6qxIB7dxKEZfw
   xQd0uVEWVt7F8VdDKpXhjux3P3Njzk5m1zjyHPkaL0O4akwLw4uCipIlr
   wdDEuGD3D55KZVF8AWZndpD/m5sdO47gyDiiOwX6/u15ZoYRLlbFqKvpQ
   oJ3IeecdCmCMdcpDZl5c6xQ5s/qDkm+R19hLzmHIwBBO+qB3yVr5+L97K
   0Kv1G2o+q6e9gtgj/rf4mYHdUUjkExQCWdY+mGpmXgB4EH5IZuVKeNz2E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326662598"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="326662598"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 10:52:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905652116"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="905652116"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jan 2023 10:52:03 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 1/6] virtio console: Harden multiport against invalid
 host input
In-Reply-To: <Y8lfHKz08EVeNa5o@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
 <Y8lfHKz08EVeNa5o@kroah.com>
Date:   Thu, 19 Jan 2023 20:52:02 +0200
Message-ID: <87fsc6qrvx.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Jan 19, 2023 at 03:57:16PM +0200, Alexander Shishkin wrote:
>> From: Andi Kleen <ak@linux.intel.com>
>> 
>> --- a/drivers/char/virtio_console.c
>> +++ b/drivers/char/virtio_console.c
>> @@ -1843,6 +1843,9 @@ static int init_vqs(struct ports_device *portdev)
>>  	int err;
>>  
>>  	nr_ports = portdev->max_nr_ports;
>> +	if (use_multiport(portdev) && nr_ports < 1)
>> +		return -EINVAL;
>> +
>>  	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
>>  
>>  	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);
>> -- 
>> 2.39.0
>> 
>
> Why did I only get a small subset of these patches?

I did what get_maintainer told me. Would you like to be CC'd on the
whole thing?

> And why is the whole thread not on lore.kernel.org?

That is a mystery, some wires got crossed between my smtp and vger. I
bounced the series to lkml just now and at least some of it seems to
have landed on lore.

> And the term "hardening" is marketing fluff.   Just say, "properly parse
> input" or something like that, as what you are doing is fixing
> assumptions about the data here, not causing anything to be more (or
> less) secure.
>
> But, this still feels wrong.  Why is this happening here, in init_vqs()
> and not in the calling function that already did a bunch of validation
> of the ports and the like?  Are those checks not enough?  if not, fix it
> there, don't spread it out all over the place...

Good point! And there happens to already be 28962ec595d70 that takes
care of exactly this case. I totally missed it.

Regards,
--
Alex
