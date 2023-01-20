Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693F7675A40
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjATQlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjATQlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:41:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF9E39CD5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674232891; x=1705768891;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=O6hXbtgh6Uq7IHfnbRaJzZU+JzJyUzqxHcKuTZ5XDnI=;
  b=MR9xSx8WwffASMSgUw6+0H1q4B4yrU5s+Ya2wSIG5Gs1+JOatdMbdKnr
   9RNCqOs9QRYtywm32X8Rsn0sh3D1lzVWwRI5fueSocm2sO0yZTX7+jeSy
   BBg7GPC16c0R5K8X0WByYVFap5U8tDbWBeKkChHjDCwWjXiKW0sh/Z73M
   ry4wQ9gzeUUQWkq60nLKTn/0tQJKOuxIsViL0I0A88P3bSeaiOgl5LpAM
   QzrpNzXfvjJKsgzhEiGFR82FBPMK8hzc+BiLdg+XAVffrl7WzB+YsnMtp
   hDQai5EXsh2Bcz2WY2U4fJnIEM82tKnuK7lp2I6giSzjmNr3dpRC7J1Gq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="352874603"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="352874603"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="906017161"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="906017161"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jan 2023 08:41:28 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 4/6] virtio console: Harden control message handling
In-Reply-To: <20230120074120-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
 <Y8lgIS+jygB7SGrn@kroah.com>
 <20230120074120-mutt-send-email-mst@kernel.org>
Date:   Fri, 20 Jan 2023 18:41:27 +0200
Message-ID: <87y1pxp39k.fsf@ubik.fi.intel.com>
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

> On Thu, Jan 19, 2023 at 04:22:09PM +0100, Greg Kroah-Hartman wrote:
>> On Thu, Jan 19, 2023 at 03:57:19PM +0200, Alexander Shishkin wrote:
>> > In handle_control_message(), we look at the ->event field twice, which
>> > gives a malicious VMM a window in which to switch it from PORT_ADD to
>> > PORT_REMOVE, triggering a null dereference further down the line:
>> 
>> How is the other VMM have full control over the full message here?
>> Shouldn't this all have been copied into our local memory if we are
>> going to be poking around in it?  Like I mentioned in my other review,
>> copy it all once and then parse it.  Don't try to mess with individual
>> fields one at a time otherwise that way lies madness...
>> 
>> thanks,
>> 
>> greg k-h
>
> I agree and in fact, it is *already* copied since with malicious
> device we generally use a bounce buffer.

Right, but the code should probably be able to handle bad input on its
own, or what do you think?

> Having said that, the patch is actually a cleanup, e.g. it's clearer
> to byte-swap only once.
> Just don't oversell it as a security thing.

Well, security was the original motivation, so that's what it said in
the commit message. But we settled on [0] yesterday with Greg, which
would replace this patch and 2/6.

[0] https://lore.kernel.org/all/87a62eqo4h.fsf@ubik.fi.intel.com/

Regards,
--
Alex
