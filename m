Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE6705E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjEQD6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEQD57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB630FE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684295830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SF1C6Ii/3dDFs+yLRzrDuFD5U/ERayv1kcGi9vPuHdM=;
        b=e5twVMP550f8gYzLK3CdWA7vjrZxo4F3XfxVup5K88RhlF6NEwtX0HuoEL+meQqBhtxEPm
        75V+uonGSFJK/pyB9HWOjcnsVnJW4ZKgrTQQRfP6eBE1kCynlxGctsJfTULODQy2VyJaNM
        qJgiZik6MKHaCIVzHatnEt+7wBcxXTc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-m82V8dvKP7SM5QKWHhTiXA-1; Tue, 16 May 2023 23:57:09 -0400
X-MC-Unique: m82V8dvKP7SM5QKWHhTiXA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3078b9943d6so68646f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295828; x=1686887828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SF1C6Ii/3dDFs+yLRzrDuFD5U/ERayv1kcGi9vPuHdM=;
        b=c0mag2H0qxnLWTmiycrmr0zGodCW/nLj6emc1X2fe1SG0KRIYQ1qDoANcJNc/pxonr
         Ux7ACfAmX9Nf7NjTZmd0GpITeoAHZ74ZiBcsMub+gmxxSwETVjzc9zmK+QVqjIsd13pD
         oMMD/sOVlePZSsj+Sv2QnAzrTAYc15k9VQiaKOI3hR8EcZu6hab9kkOLMX5Wa7pSIbIF
         gradsLJf7KKSvPGBTwY9QBWYK+F4qYlnZ/Sw1eiianmVTeK8wvGyqZqdwrFFBKs5x5Se
         RXGFL0DJsxQkKeUt29qrDG+fo/X3FF4tQ93dcr1cr4efmIFJ7QbtFFc4APGyLGysURzb
         7jkQ==
X-Gm-Message-State: AC+VfDzNSE6fU1AMzOHR7b5h/mcOFP4TOXvGlO4+cGyVqwK3xbsH6vM+
        yD8Jf4pdCWBfv6OFmDOGreglpJHYKMveQYlB+2ZLAo+DzKIvClUkEXBrD2Qt07dekXIQRK6F30v
        mx4s6hnGABxZ0r29bbml2V0xowFnqr0lO
X-Received: by 2002:adf:fe05:0:b0:306:f6c:1063 with SMTP id n5-20020adffe05000000b003060f6c1063mr27718186wrr.38.1684295827944;
        Tue, 16 May 2023 20:57:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6tMdwniV2/Yl2o/aQZF/VVc4cBdt1RKQYwGpF5htMgQeuGGC6Mzgt027tn3iFNOt3EKaEyjA==
X-Received: by 2002:adf:fe05:0:b0:306:f6c:1063 with SMTP id n5-20020adffe05000000b003060f6c1063mr27718177wrr.38.1684295827638;
        Tue, 16 May 2023 20:57:07 -0700 (PDT)
Received: from redhat.com ([2.52.6.43])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d5267000000b002fe96f0b3acsm1409753wrc.63.2023.05.16.20.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 20:57:07 -0700 (PDT)
Date:   Tue, 16 May 2023 23:57:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Message-ID: <20230516235541-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
 <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:51:03AM +0800, zhenwei pi wrote:
> 
> 
> On 5/17/23 11:46, Michael S. Tsirkin wrote:
> > On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
> > > v1 -> v2:
> > > - Suggested by MST, use fast path for vring based performance
> > > sensitive API.
> > > - Reduce changes in tools/virtio.
> > > 
> > > Add test result(no obvious change):
> > > Before:
> > > time ./vringh_test --parallel
> > > Using CPUS 0 and 191
> > > Guest: notified 10036893, pinged 68278
> > > Host: notified 68278, pinged 3093532
> > > 
> > > real	0m14.463s
> > > user	0m6.437s
> > > sys	0m8.010s
> > > 
> > > After:
> > > time ./vringh_test --parallel
> > > Using CPUS 0 and 191
> > > Guest: notified 10036709, pinged 68347
> > > Host: notified 68347, pinged 3085292
> > > 
> > > real	0m14.196s
> > > user	0m6.289s
> > > sys	0m7.885s
> > > 
> > > v1:
> > > Hi,
> > > 
> > > 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> > > https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> > > 
> > > Jason and Stefan pointed out that a non-vring based virtqueue has a
> > > chance to overwrite virtqueue instead of using vring virtqueue.
> > > 
> > > Then I try to abstract virtqueue related methods in this series, the
> > > details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
> > > 
> > > Something is still remained:
> > > - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
> > >    virtio core, I'd like to rename them to vring_virtqueue_break
> > >    /vring_virtqueue_unbreak. Is this reasonable?
> > 
> > Why? These just set a flag?
> > 
> 
> Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols
> exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.

I just do not see why you need these callbacks at all.

> > > - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
> > >    /virtqueue_get_vring is vring specific, I'd like to rename them like
> > >    vring_virtqueue_get_desc_addr. Is this reasonable?
> > > - there are still some functions in virtio_ring.c with prefix *virtqueue*,
> > >    for example 'virtqueue_add_split', just keep it or rename it to
> > >    'vring_virtqueue_add_split'?
> > > zhenwei pi (2):
> > >    virtio: abstract virtqueue related methods
> > >    tools/virtio: implement virtqueue in test
> > > 
> > >   drivers/virtio/virtio_ring.c | 285 +++++-----------------
> > >   include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
> > >   include/linux/virtio_ring.h  |  26 +++
> > >   tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
> > >   4 files changed, 807 insertions(+), 300 deletions(-)
> > > 
> > > -- 
> > > 2.20.1
> > 
> 
> -- 
> zhenwei pi

