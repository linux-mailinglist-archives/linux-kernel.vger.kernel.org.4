Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A545A66D55D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbjAQE2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjAQE16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C5A658A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673929631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8UBWWLwvMiOr6L+z7we+Q7JSzanvEE4bw3BkUZVsmF0=;
        b=J1diJfZNx8sxBaCni+jthlEO1aIFjwAYY3MJFW7HIkwTK4g/cN7cRIl8JGxhnW6FozP9Jj
        vbvtA3IVXtx5FNRYJsEhkfPmrD0p+f6ACrxEBGJ361WDw0CmZh0CDpAx88ViSC2nPo4KzE
        M6+j9Uj0TbZt2PMVu1PpIF5QAiLZTfU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-bbNclhtFMv66ZL-xTnfhIA-1; Mon, 16 Jan 2023 23:27:09 -0500
X-MC-Unique: bbNclhtFMv66ZL-xTnfhIA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-15ef646668bso2497133fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UBWWLwvMiOr6L+z7we+Q7JSzanvEE4bw3BkUZVsmF0=;
        b=ec6NB4hxn4EgNJQOpOAb0lKqpFJdt1a7BWjjMr7EEAhk6QLIYiAhN2AOPXZE5SESLA
         Xvpb/sIo+EmoyNfWKri9PSD4AVOgbuFx0m0PJe7ruMNFly/V4H2jzFo1rP/zcyL9MSfU
         /bLfxTB26U8zgBInU6C3yfue0vrpF+8eG49+Ikte6LEq4wXqQ6qDcQCSUX6NI5acFf2Y
         9CKaHC4E/aGxc7wL+Z1JDZVkoBB0tytpSxJAcLez/VHnZUQvLcTf/l5OaPo6N5wLbOJl
         eVS+Iqqh8Qh+F/BQYqE3v2NTh5OyQsWH1Q9D0ytMGZ/1CCsue86AzZU05claK5ewOr7o
         f8/A==
X-Gm-Message-State: AFqh2ko1x4+RooPvWIH7cFrfBnvFJkUTxUuxpIzcqmzFhEhq+uIuSD4L
        weCrbdhu4W3Z/QnwU5X7loJ4fqJbvCRBLvStrbIsJ5a6vAqDg29NFgbXQYuS/FiX6jS6zU/eHNI
        3vJBjVROQYIMRoevvLJsJkNCF5nA9y1Ae/oUeQwoL
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id y14-20020a056871010e00b0015b96b59916mr158815oab.280.1673929628344;
        Mon, 16 Jan 2023 20:27:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtupA/6WBzUmJl+6Zu/dq8kAyUyACJiGdlm+VS0K02Srz3uqlvAppZX93F9SuB1/bC3rktvXfYdCFvGM2GZCKk=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr158814oab.280.1673929628131; Mon, 16
 Jan 2023 20:27:08 -0800 (PST)
MIME-Version: 1.0
References: <75a2cb16-9e39-4123-de8e-b846c9b482f0@norrbonn.se>
In-Reply-To: <75a2cb16-9e39-4123-de8e-b846c9b482f0@norrbonn.se>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 17 Jan 2023 12:26:57 +0800
Message-ID: <CACGkMEu-hZ2x8EnstJ_FQ7tWMj=zLf7GAcwyHuAzvQQncTqEYg@mail.gmail.com>
Subject: Re: vhost-net
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 4:59 PM Jonas Bonn <jonas@norrbonn.se> wrote:
>
> Hi,
>
> I have a question about using vhost-net with an IFF_TUN device.  I'm
> uncertain about the behaviour I'm seeing which is:
>
> i)  on RX, the descriptor contains no Ethernet header, which is what I
> was expecting
> ii)  on TX, the first 14 bytes of the transmitted _IP_ packet are lost;
> if I prepend an extra 14 bytes (zeroes) before the IP packet and extend
> the packet length accordingly, then things appear to work as expected.
>
> In vhost_net_build_xdp() it appears that the userspace packet data is
> copied verbatim to an XDP packet structure that assumes the presence of
> an ethernet header; as such, the IP header is copied into the ethernet
> header area.  I think this accounts for losing the first 14 bytes of the
> IP header...
>
> If I set SO_SNDBUF to something less than INT_MAX, then the XDP path is
> bypassed and transmission of IP packets works.  This means that knowing
> the value of SO_SNDBUF becomes important in the userspace application in
> order to know whether an extra 14 bytes needs to be prepended to the IP
> packet... which is awkward, at best.

It's a bug.

>
> For an IFF_TUN device, should vhost-net not be adding an implicit
> ethernet header in _build_xdp()?

Probably.

Actually, this makes me think that we should disable XDP for TUN?

> Can this be done without backward
> compatibility implications?
>

The path is used by vhost-net only, so I think we are fine.

Patch is more than welcomed.

Thanks

> Thanks,
> Jonas
>

