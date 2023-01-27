Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E361367E5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjA0MsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjA0MsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:48:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0496517CDA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674823679; x=1706359679;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mxekl2cqQ4LegMUrThTVNTlOizOCL+t9xGZVLQ0oOf0=;
  b=JKWs7Mj4dmNxgjsQPOUHmKB3XGXiWqsYgxt6DzD5OptWmOSAGAQaeERu
   bP83C6XBdT31uO/PdCXZ+70IY4kyRBbI4KCKDLL/VhYDM9IgISD8x4AoX
   pZnlVRXnNGYBNfDL6/r9DmkHqs94HO8KDDepqAs32jfXCcVh66WtN5Jgz
   K3n1OoXvMGg6EMJF+K4/xBSoR/Zykl93GSQraJEMsFXWqTCErmcxfCChG
   31gYS/c09EK+lVR11D6/KrsQx+hwEuoPIFr7ufmLvheHEfo03DeVfHubP
   Jjbh4ovJCp3sfKSOjqsqLamjoULniLK7pqsz5DFuYoABQHVV5Bp6XjbmA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="325750768"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="325750768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 04:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="693694330"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="693694330"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2023 04:47:56 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
In-Reply-To: <20230127071152-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
 <20230127071152-mutt-send-email-mst@kernel.org>
Date:   Fri, 27 Jan 2023 14:47:55 +0200
Message-ID: <87edrgp2is.fsf@ubik.fi.intel.com>
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
>> >> When handling control messages, instead of peeking at the device memory
>> >> to obtain bits of the control structure,
>> >
>> > Except the message makes it seem that we are getting data from
>> > device memory, when we do nothing of the kind.
>> 
>> We can be, see below.
>> 
>> >> take a snapshot of it once and
>> >> use it instead, to prevent it from changing under us. This avoids races
>> >> between port id validation and control event decoding, which can lead
>> >> to, for example, a NULL dereference in port removal of a nonexistent
>> >> port.
>> >> 
>> >> The control structure is small enough (8 bytes) that it can be cached
>> >> directly on the stack.
>> >
>> > I still have no real idea why we want a copy here.
>> > If device can poke anywhere at memory then it can crash kernel anyway.
>> > If there's a bounce buffer or an iommu or some other protection
>> > in place, then this memory can no longer change by the time
>> > we look at it.
>> 
>> We can have shared pages between the host and guest without bounce
>> buffers in between, so they can be both looking directly at the same
>> page.
>> 
>> Regards,
>
> How does this configuration work? What else is in this page?

So, for example in TDX, you have certain pages as "shared", as in
between guest and hypervisor. You can have virtio ring(s) in such
pages. It's likely that there'd be a swiotlb buffer there instead, but
sharing pages between host virtio and guest virtio drivers is possible.

Apologies if the language is confusing, I hope I'm answering the
question.

Regards,
--
Alex
