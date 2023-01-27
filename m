Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ECD67E26D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjA0K7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjA0K7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96227B759
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674817116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HFcJR84Ivdwd5OdBWBVJmXHz74QDbr0DcFcXGw8g9+s=;
        b=gUXBgCXgBeNTt/CdM1c4UzljTnHG5WSvGGxxgI5P94sLe5DxRen0H9ZCdfaTcjFHFlkVKM
        rpzeLoELItWBHRirsAlWF/JpgAhXy6WI/0JZU8xm4wNVSF09szxgaT8n3BEiy4ELKWQFDT
        GPc8vGMK69KqgBycdqbTmAoGiI1t/+Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-SwHL1gpNOZWh0RGjaRnu5A-1; Fri, 27 Jan 2023 05:58:35 -0500
X-MC-Unique: SwHL1gpNOZWh0RGjaRnu5A-1
Received: by mail-wm1-f72.google.com with SMTP id h9-20020a1ccc09000000b003db1c488826so4462296wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFcJR84Ivdwd5OdBWBVJmXHz74QDbr0DcFcXGw8g9+s=;
        b=XsVR7sshm1183NnUIo3YHZuNO+hsU/OhCxyW3Ms914lLKofNcHYMEjbNqTvX2VkL7v
         5estz4pv55D5Ld1FvvTP11E/A9lDHeH+jg9a7hE/wlHD30137gdX98VHEcSVFSP8JtPR
         8JAU6U7hLPkWNkm/xxyh8A/hbPMfCwMeuIaINLu/aSObal7V/2Uh8pX3pZhlGkZHZnU6
         h0kCNK9NgnAiuLqgfKiRj56ctgXXxXtw8cmf8sBoXTjKS4rwLEDqbVx3TUEEAXFvRJJe
         IKVNhDPVtDcWe+NGzOvxOMAme4IcM1mzlc4aWnlQEKml++teKkqGmf0mezqgg/NSU4WS
         12lg==
X-Gm-Message-State: AO0yUKWvrrzgMQTNa+ZHkIDOdVWkBqomA2CIh+VP13eZgmY9vds1zG/d
        LkWndxt5yxpq+0gXRpY/52B5IXGjw7a8MA7S9GFyKAd4FuQ4AEEiKU3ctT3CklIU3roK6HccaPF
        KZ7lnDtI8ZGJaBAkJkPbtQ+GE
X-Received: by 2002:adf:e785:0:b0:2bf:c09e:e7bc with SMTP id n5-20020adfe785000000b002bfc09ee7bcmr6193456wrm.7.1674817114377;
        Fri, 27 Jan 2023 02:58:34 -0800 (PST)
X-Google-Smtp-Source: AK7set/VtT9x0wKextkzcIfFv9ipItxc2L0qOJGaLpXlCHlGb8GPoxQl1tE5XCj751BlFNolOBlC1w==
X-Received: by 2002:adf:e785:0:b0:2bf:c09e:e7bc with SMTP id n5-20020adfe785000000b002bfc09ee7bcmr6193441wrm.7.1674817114159;
        Fri, 27 Jan 2023 02:58:34 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id b14-20020adff90e000000b002be34f87a34sm3815513wrr.1.2023.01.27.02.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:58:33 -0800 (PST)
Date:   Fri, 27 Jan 2023 05:58:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 4/6] virtio console: Harden control message handling
Message-ID: <20230127055514-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
 <Y8lgIS+jygB7SGrn@kroah.com>
 <20230120074120-mutt-send-email-mst@kernel.org>
 <87y1pxp39k.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1pxp39k.fsf@ubik.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 06:41:27PM +0200, Alexander Shishkin wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Jan 19, 2023 at 04:22:09PM +0100, Greg Kroah-Hartman wrote:
> >> On Thu, Jan 19, 2023 at 03:57:19PM +0200, Alexander Shishkin wrote:
> >> > In handle_control_message(), we look at the ->event field twice, which
> >> > gives a malicious VMM a window in which to switch it from PORT_ADD to
> >> > PORT_REMOVE, triggering a null dereference further down the line:
> >> 
> >> How is the other VMM have full control over the full message here?
> >> Shouldn't this all have been copied into our local memory if we are
> >> going to be poking around in it?  Like I mentioned in my other review,
> >> copy it all once and then parse it.  Don't try to mess with individual
> >> fields one at a time otherwise that way lies madness...
> >> 
> >> thanks,
> >> 
> >> greg k-h
> >
> > I agree and in fact, it is *already* copied since with malicious
> > device we generally use a bounce buffer.
> 
> Right, but the code should probably be able to handle bad input on its
> own, or what do you think?

Basically I think it's ok to look at the same field twice unless
it's mapped as dma coherent. Is that what you are asking about?

> > Having said that, the patch is actually a cleanup, e.g. it's clearer
> > to byte-swap only once.
> > Just don't oversell it as a security thing.
> 
> Well, security was the original motivation, so that's what it said in
> the commit message. But we settled on [0] yesterday with Greg, which
> would replace this patch and 2/6.
> 
> [0] https://lore.kernel.org/all/87a62eqo4h.fsf@ubik.fi.intel.com/
> 
> Regards,

At this point I will drop this series and pls post new series
with just the stuff you want included. Include acks if patches
are unchanged.

Thanks!

> --
> Alex

