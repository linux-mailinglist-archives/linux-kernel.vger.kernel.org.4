Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E25767E71D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjA0NxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjA0NxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C06757B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674827538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R7PwQQfaQAAI4cWcMcSVvB/9kkzepsIAiNqYaNg7Vqg=;
        b=Bicu/tFl0PtlK5OTJuX7LIHSyGAAcNJXDlLyGYYGHpN1rKaTfR12/9o0HNmKV4giPqrVpC
        fHHSL5ytvK33RDdsCHy1Vk9qBh1dFqLgn3gh4cZmswA5Ju/frkowqorDWA7TpQAmzsiYgt
        2UBx3emKB6O+O1sIRy6xmccN8pZhbNg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-CiZ0Q0-HMPOxhds0MMtB1A-1; Fri, 27 Jan 2023 08:52:17 -0500
X-MC-Unique: CiZ0Q0-HMPOxhds0MMtB1A-1
Received: by mail-ej1-f69.google.com with SMTP id qf20-20020a1709077f1400b0086ec9755517so3434800ejc.15
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7PwQQfaQAAI4cWcMcSVvB/9kkzepsIAiNqYaNg7Vqg=;
        b=FGk3NoJIVKfMLbeMHaevEJGaeDKTLGTCRXaKGFrf9KaLptON9TLw4b549FtcVRuVFa
         NTf4TWpLMMpT11LAjRF1/zggOP0bt4tQnZqT7fSh+MsF8r7XH/axA4nW1MPm6SBYWdpM
         f+gHzOmTVyu6UP3X7K9c0VA6iAarm29rj/FnfuNX4UGV3wT2GRHfMA2t9NKTMVApy8Ed
         2DLGRefIBs6VuaKL9wJ/CcP3OE89iiOvM2m656NpFpCgRc5cdXEQzCDfSgBNGGZtW5at
         bNfS5RJ4waUlpa5LWE1jzNccqTPo8PCKheDo67i8rFFQGUnHPU/+YgA69miaQxjD6vEu
         PlPg==
X-Gm-Message-State: AFqh2koSkOTudE/o2TDfyaxo6De7hTwS3CRv/iB8crDDquHafmY4Bv7c
        vzd1O8SuCYXhq7vRh08IeTQMC62FhygBzH/pGWt+UNNe71Af0SUyI9gqX6NmclRL96fdZKTpaXC
        7z2Y1hPmVi8Am/CuHBa9T0TP3
X-Received: by 2002:a17:906:9f1c:b0:870:3c70:8c8d with SMTP id fy28-20020a1709069f1c00b008703c708c8dmr35780276ejc.17.1674827535253;
        Fri, 27 Jan 2023 05:52:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv6Rvl5hVCAcmib+Ajlnf9hxYLH9FQSlnb3lj94uj3kByJbvLhBcQF3Wx5PXW8TJDK2Yh5ogw==
X-Received: by 2002:a17:906:9f1c:b0:870:3c70:8c8d with SMTP id fy28-20020a1709069f1c00b008703c708c8dmr35780264ejc.17.1674827535048;
        Fri, 27 Jan 2023 05:52:15 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b0086faa5b06d4sm2262152ejc.181.2023.01.27.05.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 05:52:14 -0800 (PST)
Date:   Fri, 27 Jan 2023 08:52:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230127085006-mutt-send-email-mst@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
> pages.

That one's marked as dma coherent.

> It's likely that there'd be a swiotlb buffer there instead, but
> sharing pages between host virtio and guest virtio drivers is possible.

It's not something console does though, does it?

> Apologies if the language is confusing, I hope I'm answering the
> question.
> 
> Regards,
> --
> Alex

I'd like an answer to when does the console driver share the buffer
in question, not when generally some pages shared.

-- 
MST

