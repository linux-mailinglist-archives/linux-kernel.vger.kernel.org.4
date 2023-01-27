Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC2F67E894
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjA0Orm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjA0Ori (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9448327E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674830813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpgxDVEC7+0c0qata4U+nz7dWR4hklZ05tT76C3hVlU=;
        b=UpvEWpCNLPK5MkSxe/oy8OS3epbJyvsq8IXGk02gOKZtoqm8UrJ50t52UGb369n/puGQCo
        WsL5d9R3eTq/JP/WvibR/dN+x4lWOXiXGzyusUDH1M3LKcXHxjXe9d44h+9S9SztWPdcON
        4NHl8SEfuxjhDMDoPqQAW7XWbcGMRuA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-2YaA9jaFPeS9mWXW7FcvMw-1; Fri, 27 Jan 2023 09:46:51 -0500
X-MC-Unique: 2YaA9jaFPeS9mWXW7FcvMw-1
Received: by mail-ed1-f70.google.com with SMTP id s14-20020a056402520e00b0049e0bea1c3fso3693059edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpgxDVEC7+0c0qata4U+nz7dWR4hklZ05tT76C3hVlU=;
        b=Lcqv7IlyDeBE3mvqJz4iSJzVPyr9LmIBPJLhO0hppdW3rYfbuOjETEkBgtW/d5I5b9
         viWsBcz205sjXXbgL16vTk9vj6N2oDuYb+hGv28FIM0JjM+3viwcyiM2mtd8Garzaofl
         E90ansIZ++m/5ZSOeO/fC4DsGtnILFj5TLWSQp8tzlABt+MbsfvZy3hD2TaLVvo+rcQa
         iPAok8r9y0g0Dgn690UlSh4a3IT91a5FI7SI4uP7f/KrOljFpNv+93Yb91FG9l7lgWmF
         Hsn99HXn5GJIkA9jisdk1Zm38RUr96NqkPCzs99YxIak7L27/zcFa+CQuoPmFNGceO9H
         agpw==
X-Gm-Message-State: AO0yUKUYyoJbzPhlUGR02MItn6gI6egJjzkOkhv07piLA/jNJBtkpzhb
        7QyjRJYsR504IfKwlmN+zRNYjHH0UaFyELAYE8VHIV3LycecMBz+rPP4uhyfDQOtdTmL5e3yP01
        xGlv7e3pLUu1za+NgiKaU+eQ8
X-Received: by 2002:a17:907:ea3:b0:87c:6aa5:ce24 with SMTP id ho35-20020a1709070ea300b0087c6aa5ce24mr1556477ejc.71.1674830810144;
        Fri, 27 Jan 2023 06:46:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+G9T3BxQ2uASepzL4Az/FbSILbMgk/fWjAvHrhUKtSSSXMQoFwgu2i+XKQHEZyOl3z79y1qg==
X-Received: by 2002:a17:907:ea3:b0:87c:6aa5:ce24 with SMTP id ho35-20020a1709070ea300b0087c6aa5ce24mr1556459ejc.71.1674830809916;
        Fri, 27 Jan 2023 06:46:49 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id w9-20020a170906184900b007c0f217aadbsm2320342eje.24.2023.01.27.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:46:49 -0800 (PST)
Date:   Fri, 27 Jan 2023 09:46:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230127094425-mutt-send-email-mst@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
> 
> Meanwhile, in the shared page, it can change from correct to incorrect,
> but it won't affect us because we have this consistent view at the
> moment the snapshot was taken.
> 
> > Please be specific as to what you want to see happen here, and why.
> 
> For example, if we get a control message to add a port and
> cpkt->event==PORT_ADD, we skip validation of cpkt->id (port id), because
> we're intending to add a new one. At this point, the device can change
> cpkt->event to PORT_REMOVE, which does require a valid cpkt->id and the
> subsequent code runs into a NULL dereference on the port value, which
> should have been looked up from cpkt->id.
> 
> Now, if we take a snapshot of cpkt, we naturally don't have this
> problem, because we're looking at a consistent state of cpkt: it's
> either PORT_ADD or PORT_REMOVE all the way. Which is what this patch
> does.
> 
> Does this answer your question?
> 
> Thanks,
> --
> Alex


Not sure about Greg but it doesn't answer my question because either the
bad device has access to all memory at which point it's not clear why
is it changing cpkt->event and not e.g. stack. Or it's restricted to
only access memory when mapped through the DMA API. Which is not the
case here.

-- 
MST

