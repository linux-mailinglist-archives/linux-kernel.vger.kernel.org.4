Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4FA6753F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjATL4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjATL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B125A45FD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674215751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSseqynolRz7PSqM1s8S1KWufbOig9tOH/7xArRYSoc=;
        b=INqAIl1LHXjJh6Zt9eeQ8RWVSNM3MIuDUOM/K+xoViZ0Avw+hZXuhm5ukikiKezoJ5LvH7
        Q9QZiv68FCAQzPwkUr7n65FZgonIV9prgjsO4c4KSIkbLpNyrfhsXQko7DXpyAAHl1Pwbo
        i0AdK7PGGYeFyzBiHdxIQGSWtRkU8Aw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-LSIEI00xPNuWPcAjv-We8w-1; Fri, 20 Jan 2023 06:55:45 -0500
X-MC-Unique: LSIEI00xPNuWPcAjv-We8w-1
Received: by mail-wm1-f70.google.com with SMTP id m7-20020a05600c4f4700b003d971a5e770so2904635wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSseqynolRz7PSqM1s8S1KWufbOig9tOH/7xArRYSoc=;
        b=NFUlDPKzIhZUrW6NNKbz6eRI3VUoI8KDQiqYu8hU0A+7LBVsGcQhIZL7bTN8H8ncL1
         OuWxZC6Lju1JxJtm/SHfEiOT0j/+mMvh6H28rSn2mn2xiCitj1UjoVOB4mTnzDbdVjQX
         /yRhh91HOjQBjuA08Als2R9t92p1+HtMZYhhO1BfkSIvJiqZXqvcFiZuxOSWoUuu4CXP
         8UZp9qMqiMptA7ASSxSO4t274A4Pj0Fl5GYrtu4YmaE/X01eosb9mtJWmQYnvfr7xQKG
         LRPNkkmevEQjvj8OuICenq6fpEdP5DVATN19TePilucZKM8sFKQl9he+F+ucKKAzuJm8
         wTkw==
X-Gm-Message-State: AFqh2kr6Hn/e4BjDXXWgeNKYPubCVEnWWyVdtr/q6tjTni6n8wpMtllT
        8D2v2hAN3pj+wJG4BhMyDI6o1NX+mHo8p4yYm+9ozf70BpwNnGhhs+yHYt7Na5eesmg9LwfQJkO
        8KoABT+qrFbHcUyIkP8IVrywu
X-Received: by 2002:a05:600c:181a:b0:3d2:2043:9cbf with SMTP id n26-20020a05600c181a00b003d220439cbfmr13938709wmp.10.1674215743597;
        Fri, 20 Jan 2023 03:55:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuOcvaB+LCHhfsBeCZmk1/bVqC5w78IurqnA4dYjWOnrtFroLGFV2PoZ6naZCe1IposyXGIiw==
X-Received: by 2002:a05:600c:181a:b0:3d2:2043:9cbf with SMTP id n26-20020a05600c181a00b003d220439cbfmr13938687wmp.10.1674215743276;
        Fri, 20 Jan 2023 03:55:43 -0800 (PST)
Received: from redhat.com ([2.52.19.29])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b003db2e3f2c7csm3089265wmo.0.2023.01.20.03.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 03:55:42 -0800 (PST)
Date:   Fri, 20 Jan 2023 06:55:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v1 0/6] Harden a few virtio bits
Message-ID: <20230120065402-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:57:15PM +0200, Alexander Shishkin wrote:
> Hi,
> 
> Here are 6 patches that harden console, net and 9p drivers against
> various malicious host input as well as close a bounds check bypass
> in the split virtio ring.

Hardening against buggy devices is one thing,
Hardening against malicious devices is another.
Which is this?
If really malicious, aren't there any spectre considerations here?
I am for example surprised not to find anything addressing
spectre v1 nor any uses of array_index_nospec here.


> Changes since previous version:
>  * Added Christian's R-B to 3/6
>  * Added a speculation fix per Michael's comment on the cover letter
>  * CC'ing lkml
> 
> Alexander Shishkin (3):
>   virtio console: Harden control message handling
>   virtio_net: Guard against buffer length overflow in
>     xdp_linearize_page()
>   virtio_ring: Prevent bounds check bypass on descriptor index
> 
> Andi Kleen (3):
>   virtio console: Harden multiport against invalid host input
>   virtio console: Harden port adding
>   virtio 9p: Fix an overflow
> 
>  drivers/char/virtio_console.c | 19 ++++++++++++-------
>  drivers/net/virtio_net.c      |  4 +++-
>  drivers/virtio/virtio_ring.c  |  3 +++
>  net/9p/trans_virtio.c         |  2 +-
>  4 files changed, 19 insertions(+), 9 deletions(-)
> 
> -- 
> 2.39.0

