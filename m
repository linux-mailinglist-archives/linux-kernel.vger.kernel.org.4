Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43F67E497
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjA0MFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjA0MEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:04:14 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349F8002F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674820747; x=1706356747;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=R5kHSE0rO3d8c4n2LwYOk3QP/SJSE6nIeno9MGRs6Uo=;
  b=jj8/+vhFgkfMLPaaoSI6Pz0wnDnOOAih4K6o2QW1yQr9Inl7vcHHa3do
   zthd+KX9od6+oDybUZJpiyi1A/oCHD0vGS6VdZ0GNlj1MTMiqaNExnUOM
   Di7iHKJnBjOsd0/77mBVH7MDm0X0A77QK6UnOmkYStCvS3KDY85kwU3qJ
   W+/N4/UVhRsOP1T7m/QPo7yu1dEAdIalOggMCJ0FuHzKziBIOtrKV59xR
   2Duz7ZZovPoe/zfV63sCMAa/IqeXd3L1T1jFVsho9u2NLUU3N0b3HWtIf
   ua1sL5Vd6ZbFw3FHR4k5eIkVR3pQCNGV9mA3Srbt/YCTAFLfmotSdMuvT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354369957"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="354369957"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 03:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="613163108"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="613163108"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2023 03:55:43 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
In-Reply-To: <20230127055944-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
Date:   Fri, 27 Jan 2023 13:55:43 +0200
Message-ID: <87k018p4xs.fsf@ubik.fi.intel.com>
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
>> When handling control messages, instead of peeking at the device memory
>> to obtain bits of the control structure,
>
> Except the message makes it seem that we are getting data from
> device memory, when we do nothing of the kind.

We can be, see below.

>> take a snapshot of it once and
>> use it instead, to prevent it from changing under us. This avoids races
>> between port id validation and control event decoding, which can lead
>> to, for example, a NULL dereference in port removal of a nonexistent
>> port.
>> 
>> The control structure is small enough (8 bytes) that it can be cached
>> directly on the stack.
>
> I still have no real idea why we want a copy here.
> If device can poke anywhere at memory then it can crash kernel anyway.
> If there's a bounce buffer or an iommu or some other protection
> in place, then this memory can no longer change by the time
> we look at it.

We can have shared pages between the host and guest without bounce
buffers in between, so they can be both looking directly at the same
page.

Regards,
--
Alex
