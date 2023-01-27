Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2B67E6C0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjA0Nbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjA0Nbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:31:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10E757A9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:31:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E90461C43
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36368C433D2;
        Fri, 27 Jan 2023 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674826300;
        bh=IunA0Pc8LL+zSuJ7WZCxCQOUJgXGl22zLfNJLSaAsn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZapjK9qAo4jtAF/ANodw/fxTC0/TbcBp0lzlRR08wC8qrMW0PRXVxuWXelZ5KOdf3
         npaNshhnj64hW1sMT40oieEvwtU0PcThEWgBZKPMR2nPmB72TrS1Xd5Kq4MbyIEz2m
         Sj0Df1cvD9xZGWxDu3O+uiPbC1LItfgRFAvO86Mc=
Date:   Fri, 27 Jan 2023 14:31:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <Y9PSObAeUyHK2cc3@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com>
 <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com>
 <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
 <20230127071152-mutt-send-email-mst@kernel.org>
 <87edrgp2is.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edrgp2is.fsf@ubik.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:47:55PM +0200, Alexander Shishkin wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
> >> >> When handling control messages, instead of peeking at the device memory
> >> >> to obtain bits of the control structure,
> >> >
> >> > Except the message makes it seem that we are getting data from
> >> > device memory, when we do nothing of the kind.
> >> 
> >> We can be, see below.
> >> 
> >> >> take a snapshot of it once and
> >> >> use it instead, to prevent it from changing under us. This avoids races
> >> >> between port id validation and control event decoding, which can lead
> >> >> to, for example, a NULL dereference in port removal of a nonexistent
> >> >> port.
> >> >> 
> >> >> The control structure is small enough (8 bytes) that it can be cached
> >> >> directly on the stack.
> >> >
> >> > I still have no real idea why we want a copy here.
> >> > If device can poke anywhere at memory then it can crash kernel anyway.
> >> > If there's a bounce buffer or an iommu or some other protection
> >> > in place, then this memory can no longer change by the time
> >> > we look at it.
> >> 
> >> We can have shared pages between the host and guest without bounce
> >> buffers in between, so they can be both looking directly at the same
> >> page.
> >> 
> >> Regards,
> >
> > How does this configuration work? What else is in this page?
> 
> So, for example in TDX, you have certain pages as "shared", as in
> between guest and hypervisor. You can have virtio ring(s) in such
> pages. It's likely that there'd be a swiotlb buffer there instead, but
> sharing pages between host virtio and guest virtio drivers is possible.

If it is shared, then what does this mean?  Do we then need to copy
everything out of that buffer first before doing anything with it
because the data could change later on?  Or do we not trust anything in
it at all and we throw it away?  Or something else (trust for a short
while and then we don't?)

Please be specific as to what you want to see happen here, and why.

thanks,

greg k-h
