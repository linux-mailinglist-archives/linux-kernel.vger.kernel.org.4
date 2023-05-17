Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697B0705E56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjEQDrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjEQDrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D124EF5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684295167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PfcASjmldT4E+gvNyOZHYqWUJmOEKNVL/zpmvGD5wLo=;
        b=TRCo8C67FMVx1HdwG7HCKovVOWQlkKjUQ2V9/9k4/z58Z1VVFlswWUtVtgTFgutJDNebY3
        tX/uFO7nT2sgUOKX1yXvw21t8fOYyf9maRlb3dv5vWLTBCU8S/IW0aHdUnP+N/atUd1Y7b
        lPli3wvtyRd7oynPYX0I/EVVWA3gZf0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-3sWuYkDaMKupkU8wJvbtGg-1; Tue, 16 May 2023 23:46:06 -0400
X-MC-Unique: 3sWuYkDaMKupkU8wJvbtGg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f4fb0193c6so904315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295165; x=1686887165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfcASjmldT4E+gvNyOZHYqWUJmOEKNVL/zpmvGD5wLo=;
        b=btw36AmOk2t5Dcmg2eMjMcb5mPiXmaxmQiEYcF6MAEn3CNLkAKbxO5iBpn3MWrghD8
         VN56Wlo8RBmFfpc/+rUozFTZ5xw2ITXw8vwHLKRdVYjVu5AJibgROrQo/X+M7peNgJ0D
         O6ZjegCzX6TElx1Hk2fy4ZM0OwQH1vPhpSi3puUBeGtfNJm0BoeOT/0JebhPB+TtTWi2
         4n/TE3/AM8IrBVGQMTW3NtcW0vO/VGr1ob0Sie+Ojb4l1Z9b4xAJi9i9UJbwW6E2Di3t
         b0C/L3QbfbpGhbBm0xvOjP1cNornIJ2gSQvbYAdZjhui6PwIJE6KTex/s2Qc7+/V9Ab2
         1M8A==
X-Gm-Message-State: AC+VfDxaCFfwVQRSUS9NZBQohosWePjgEmS67fKlxWFjU0PW52ezIpmK
        hJhKmkMsTTIlpnbP7eOeqHng9zzPY8018yBCa0Se6eARZCdMWV8hOZIr9rEHR5XvTu1owmynjVR
        RS1MhKMdBc/iM2dXrf25gGuho1rV+Mvm3
X-Received: by 2002:a05:600c:22ca:b0:3f4:2158:289b with SMTP id 10-20020a05600c22ca00b003f42158289bmr25772117wmg.18.1684295165227;
        Tue, 16 May 2023 20:46:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qlXUDjUO4xvBFP3SbQJ9yKaFG+4DO3tMYcx+WnWhMF/m0M3HpvgIQwljf5Tf7Ysq0EWC19A==
X-Received: by 2002:a05:600c:22ca:b0:3f4:2158:289b with SMTP id 10-20020a05600c22ca00b003f42158289bmr25772106wmg.18.1684295164935;
        Tue, 16 May 2023 20:46:04 -0700 (PDT)
Received: from redhat.com ([2.52.6.43])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c230800b003f423a04016sm786764wmo.18.2023.05.16.20.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 20:46:04 -0700 (PDT)
Date:   Tue, 16 May 2023 23:46:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Message-ID: <20230516234444-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517025424.601141-1-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
> v1 -> v2:
> - Suggested by MST, use fast path for vring based performance
> sensitive API.
> - Reduce changes in tools/virtio.
> 
> Add test result(no obvious change):
> Before:
> time ./vringh_test --parallel
> Using CPUS 0 and 191
> Guest: notified 10036893, pinged 68278
> Host: notified 68278, pinged 3093532
> 
> real	0m14.463s
> user	0m6.437s
> sys	0m8.010s
> 
> After:
> time ./vringh_test --parallel
> Using CPUS 0 and 191
> Guest: notified 10036709, pinged 68347
> Host: notified 68347, pinged 3085292
> 
> real	0m14.196s
> user	0m6.289s
> sys	0m7.885s
> 
> v1:
> Hi,
> 
> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> 
> Jason and Stefan pointed out that a non-vring based virtqueue has a
> chance to overwrite virtqueue instead of using vring virtqueue.
> 
> Then I try to abstract virtqueue related methods in this series, the
> details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
> 
> Something is still remained:
> - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
>   virtio core, I'd like to rename them to vring_virtqueue_break
>   /vring_virtqueue_unbreak. Is this reasonable?

Why? These just set a flag?

> - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
>   /virtqueue_get_vring is vring specific, I'd like to rename them like
>   vring_virtqueue_get_desc_addr. Is this reasonable?
> - there are still some functions in virtio_ring.c with prefix *virtqueue*,
>   for example 'virtqueue_add_split', just keep it or rename it to
>   'vring_virtqueue_add_split'?
> zhenwei pi (2):
>   virtio: abstract virtqueue related methods
>   tools/virtio: implement virtqueue in test
> 
>  drivers/virtio/virtio_ring.c | 285 +++++-----------------
>  include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
>  include/linux/virtio_ring.h  |  26 +++
>  tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
>  4 files changed, 807 insertions(+), 300 deletions(-)
> 
> -- 
> 2.20.1

