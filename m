Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967486F2924
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 16:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjD3OHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjD3OHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 10:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459CC2137
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682863607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qFwCkDXym+BO05vYF8vpXsanmPn3ffsSFSPl68Sv4Y=;
        b=XYw/CfNoqOxY6vkppd0il0Dg99SI+v1J3/1YUCsofcPnctsnzDTfg0zjMxTl24yWBBYyCG
        kwvbA+q/RINZcGSoSKduOiKttzO6O5DOcjbkW7LDa3eOLN4ESamfNOUXjemZtBXiPOOklF
        6CGduUcJ987g9tDn74UbMfjLNFf84vw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-aj73C3AbPLOL2zDwwpxJbg-1; Sun, 30 Apr 2023 10:06:45 -0400
X-MC-Unique: aj73C3AbPLOL2zDwwpxJbg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f3157128b4so68299415e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 07:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682863604; x=1685455604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qFwCkDXym+BO05vYF8vpXsanmPn3ffsSFSPl68Sv4Y=;
        b=PfUyxhsEBwOsarrP2CiHV7eoptsPEtLWbVFYqz2+oxvmva+/jhxBXwjPieue5nnxgm
         CcdxbESuAVgAvLmcSxutmoOnkgzhNXb8i72nXA+z76L2rhto+/Ov0t8pGLMvK/Hiwufh
         0HVuyF3VFbnpKpTb25cn3FjsvZVkz+SnVx28DXqJZRua96qKowGi6l2AQGj7CVgU+KwC
         C6QWFNLsY8iuAIGNQSdsis9nGLb7XyjoDIQHhxZnChqEaA+77hJTXg7ExPn+mPcAclwB
         io4WpzO01qxiYa9LnnnAWV2DlRGaoY+8pN/oeeSq3+7LUqIsDkaUQwNYv9Qt/6M8vnYW
         yjgw==
X-Gm-Message-State: AC+VfDxuEvN61+kNBUbouc7gDBgG/uRNMSfa/7/3/9/rY2hkIkyNRsUq
        J+3GIhm6m7xqk2G0NZotdO/UBNyAk52LF+SPE1GJ8kEC4mutWf3rwsc/cSBpFSwI5Vvw5t1d+if
        mvvGSulTVQ+1v5kIV0RRWXVme
X-Received: by 2002:a7b:c7c4:0:b0:3f1:6f57:6fd1 with SMTP id z4-20020a7bc7c4000000b003f16f576fd1mr8450905wmk.9.1682863604673;
        Sun, 30 Apr 2023 07:06:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49qr4fnugfdl0poBdeno2pyYNH1DJqISB5JrW9YRnjnc+eSzsu886AyGUm1JWAYtIvaYCRKA==
X-Received: by 2002:a7b:c7c4:0:b0:3f1:6f57:6fd1 with SMTP id z4-20020a7bc7c4000000b003f16f576fd1mr8450897wmk.9.1682863604398;
        Sun, 30 Apr 2023 07:06:44 -0700 (PDT)
Received: from redhat.com ([2.52.139.131])
        by smtp.gmail.com with ESMTPSA id z23-20020a7bc7d7000000b003f1751016desm29757833wmk.28.2023.04.30.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 07:06:43 -0700 (PDT)
Date:   Sun, 30 Apr 2023 10:06:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com
Subject: Re: [RFC PATCH net 0/3] virtio-net: allow usage of small vrings
Message-ID: <20230430100535-mutt-send-email-mst@kernel.org>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2023 at 04:15:15PM +0300, Alvaro Karsz wrote:
> At the moment, if a virtio network device uses vrings with less than
> MAX_SKB_FRAGS + 2 entries, the device won't be functional.
> 
> The following condition vq->num_free >= 2 + MAX_SKB_FRAGS will always
> evaluate to false, leading to TX timeouts.
> 
> This patchset attempts this fix this bug, and to allow small rings down
> to 4 entries.
> The first patch introduces a new mechanism in virtio core - it allows to
> block features in probe time.
> 
> If a virtio drivers blocks features and fails probe, virtio core will
> reset the device, re-negotiate the features and probe again.
> 
> This is needed since some virtio net features are not supported with
> small rings.
> 
> This patchset follows a discussion in the mailing list [1].
> 
> This fixes only part of the bug, rings with less than 4 entries won't
> work.

Why the difference?

> My intention is to split the effort and fix the RING_SIZE < 4 case in a
> follow up patchset.
> 
> Maybe we should fail probe if RING_SIZE < 4 until the follow up patchset?

I'd keep current behaviour.

> I tested the patchset with SNET DPU (drivers/vdpa/solidrun), with packed
> and split VQs, with rings down to 4 entries, with and without
> VIRTIO_NET_F_MRG_RXBUF, with big MTUs.
> 
> I would appreciate more testing.
> Xuan: I wasn't able to test XDP with my setup, maybe you can help with
> that?
> 
> [1] https://lore.kernel.org/lkml/20230416074607.292616-1-alvaro.karsz@solid-run.com/
> 
> Alvaro Karsz (3):
>   virtio: re-negotiate features if probe fails and features are blocked
>   virtio-net: allow usage of vrings smaller than MAX_SKB_FRAGS + 2
>   virtio-net: block ethtool from converting a ring to a small ring
> 
>  drivers/net/virtio_net.c | 161 +++++++++++++++++++++++++++++++++++++--
>  drivers/virtio/virtio.c  |  73 +++++++++++++-----
>  include/linux/virtio.h   |   3 +
>  3 files changed, 212 insertions(+), 25 deletions(-)
> 
> -- 
> 2.34.1

