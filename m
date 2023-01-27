Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D11667E4F5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjA0MTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjA0MTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F18125B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674821579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDKTzv01CYcLKHmBuAfl2OIpCwnlZ9/jR50g20y4qAI=;
        b=FcOdV1gVrms3jbR7CQsDGlLfSshuTS6/KuJGyOJ1DJ2k9VT7PtMbafk8N6Ls+tZ61EMCsj
        keIrj4GiDITNvXuNiSQp/wLgEsUOgNc3tdRx42XqHiSEDYD7hUOdIctIwLuvDbpneFe71k
        NkHxfru3YdMPqgcp3+E9EFHKrJV0A4Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-qKs1n2SmMFKOjp8pDMvyxg-1; Fri, 27 Jan 2023 07:12:58 -0500
X-MC-Unique: qKs1n2SmMFKOjp8pDMvyxg-1
Received: by mail-wm1-f72.google.com with SMTP id bg32-20020a05600c3ca000b003dc0df8c77dso1344433wmb.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDKTzv01CYcLKHmBuAfl2OIpCwnlZ9/jR50g20y4qAI=;
        b=0I9KyqIULuA2FDGmyyb+CZs3w+S7Yw9Gbsi0znYmmN+NXoZ3RUJ7laSSbLghCDsO0F
         zTn30AAFzlyxjUGYMDa3u66LN8Z5SnNW1COy1OceMWBqA/bWxCX52btXeKKK8cthuMB3
         8aUe5S8aB3Yb9pTB9FfXQvAlLBFj3hVNgW6uzqCGgB82pUK4maCTJGoUxJhJ42HVYgVf
         DgheOaJAmedWWKnJ+QXUVBhmJ5wJWmfvPSqIMneIiqbPsZnkjgUVRLNOcmRMeL9h64uq
         ghU43fUOBilyoXAHzbQcSzW5jk6K95pbWNcfofpzv2hvIj3hcJKC2QUDfOE9TbApTi28
         O/Mg==
X-Gm-Message-State: AO0yUKXP/ST3HpSl67sPMHryCJ+HnQhuwQLcFcx5B71MAGQibaXgzT/V
        818l3/QI9nkIGazjoUDZ/VR9HbWrRvSdIB2IVJtn9z5bGalX8HBnoE6aWvrt4W/4j/EC5sQBd5W
        qN6N2wtHMuBiWmZ0GO/1PeUGD
X-Received: by 2002:adf:b355:0:b0:2bf:b5ec:4844 with SMTP id k21-20020adfb355000000b002bfb5ec4844mr10990499wrd.19.1674821577063;
        Fri, 27 Jan 2023 04:12:57 -0800 (PST)
X-Google-Smtp-Source: AK7set9GmxGoo8X9oAcX4fMwSdtSw/rq5da5Wkddl56eOmBN1nVCfWeny924/48xTuzSrJu0vw90VQ==
X-Received: by 2002:adf:b355:0:b0:2bf:b5ec:4844 with SMTP id k21-20020adfb355000000b002bfb5ec4844mr10990482wrd.19.1674821576836;
        Fri, 27 Jan 2023 04:12:56 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe450000000b002bbdcd15e44sm3788409wrm.37.2023.01.27.04.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:12:56 -0800 (PST)
Date:   Fri, 27 Jan 2023 07:12:52 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230127071152-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com>
 <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com>
 <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k018p4xs.fsf@ubik.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
> >> When handling control messages, instead of peeking at the device memory
> >> to obtain bits of the control structure,
> >
> > Except the message makes it seem that we are getting data from
> > device memory, when we do nothing of the kind.
> 
> We can be, see below.
> 
> >> take a snapshot of it once and
> >> use it instead, to prevent it from changing under us. This avoids races
> >> between port id validation and control event decoding, which can lead
> >> to, for example, a NULL dereference in port removal of a nonexistent
> >> port.
> >> 
> >> The control structure is small enough (8 bytes) that it can be cached
> >> directly on the stack.
> >
> > I still have no real idea why we want a copy here.
> > If device can poke anywhere at memory then it can crash kernel anyway.
> > If there's a bounce buffer or an iommu or some other protection
> > in place, then this memory can no longer change by the time
> > we look at it.
> 
> We can have shared pages between the host and guest without bounce
> buffers in between, so they can be both looking directly at the same
> page.
> 
> Regards,

How does this configuration work? What else is in this page?

> --
> Alex

