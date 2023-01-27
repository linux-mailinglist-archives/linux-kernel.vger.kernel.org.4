Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A67A67E86A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjA0Oh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjA0Ohw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:37:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898E457EA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:37:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 59D4CCE28B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB2EC433EF;
        Fri, 27 Jan 2023 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674830257;
        bh=4P+BnZZYqm9/jN3n52aAZ3KaAO6LHlKsf7XWo/0ZLdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTjYikNJyDwHGBo8C8xfWCcMjouYJznEdDemUlvRnCT23G/aZnffjkU9uixx6fZs8
         4r63JJJYczHJmQodCQoi4d7cx18TDW+gvppWE6ARRxazqzw2TRir08fT9H6yojbE0e
         TnYCoqLUA75xM9nC06ZHaZDBQQFFJ1mlzb6VW5y0=
Date:   Fri, 27 Jan 2023 15:37:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <Y9PhrjovJvxMuF9+@kroah.com>
References: <Y8lfz8C5uvx2w4fC@kroah.com>
 <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com>
 <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
 <20230127071152-mutt-send-email-mst@kernel.org>
 <87edrgp2is.fsf@ubik.fi.intel.com>
 <Y9PSObAeUyHK2cc3@kroah.com>
 <87bkmkoyd1.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkmkoyd1.fsf@ubik.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:17:46PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Jan 27, 2023 at 02:47:55PM +0200, Alexander Shishkin wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
> >> >> We can have shared pages between the host and guest without bounce
> >> >> buffers in between, so they can be both looking directly at the same
> >> >> page.
> >> >> 
> >> >> Regards,
> >> >
> >> > How does this configuration work? What else is in this page?
> >> 
> >> So, for example in TDX, you have certain pages as "shared", as in
> >> between guest and hypervisor. You can have virtio ring(s) in such
> >> pages. It's likely that there'd be a swiotlb buffer there instead, but
> >> sharing pages between host virtio and guest virtio drivers is possible.
> >
> > If it is shared, then what does this mean?  Do we then need to copy
> > everything out of that buffer first before doing anything with it
> > because the data could change later on?  Or do we not trust anything in
> > it at all and we throw it away?  Or something else (trust for a short
> > while and then we don't?)
> 
> The first one, we need a consistent view of the metadata (the ckpt in
> this case), so we take a snapshot of it. Then, we validate it (because
> we don't trust it) to be correct. If it is not, we discard it, otherwise
> we act on it. Since this is a ring, we just move on to the next record
> if there is one.

So you do an additional extra copy of everything, making the bounce
buffer useless?  :)

> Meanwhile, in the shared page, it can change from correct to incorrect,
> but it won't affect us because we have this consistent view at the
> moment the snapshot was taken.

Wonderful, copy everything out then, the whole page, don't do it
piecemeal field by field.  And then justify it to everyone whose
throughput you just tanked...

good luck!

greg k-h
