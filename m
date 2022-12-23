Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA03654B77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbiLWDBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABA97641
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 19:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671764461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VK82Nhu6JHr+tzvOCienuycRQvWqNfDLEqiJgirwkQM=;
        b=cAyd/yvaJ2Pz0Xz4A0yWroLaZJsJ8LVpozkA2JifvrE0Z0vBmBBqiMt1fxzDKUBUH3LQWx
        5pygwGaE188K61a6wIi4nvOWF2VUJyCpEPiA8z5E2m5Oh4Tdpfh1h1/ytN52itWUJp1+Pt
        Wna+ds545O+80lV0yOiXGf4Lng9gmFE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-U3tYaQ18P3ia-nU1C7HCEA-1; Thu, 22 Dec 2022 22:01:00 -0500
X-MC-Unique: U3tYaQ18P3ia-nU1C7HCEA-1
Received: by mail-oi1-f197.google.com with SMTP id 4-20020aca0b04000000b0035e9d1b2188so765014oil.17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 19:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VK82Nhu6JHr+tzvOCienuycRQvWqNfDLEqiJgirwkQM=;
        b=RDjcr+88+BQ46suvBYix8nbnBd/2HIAnVYCw5cU+Z7/uuFuN96WCxzpKKNEV9AXdTx
         ybMzOBVJqODdfEo6Q6yc4YhDLZZ/7bRC4XI3fgzoxKQwn+ouKqd3mVZ4P6z6rJZiQ7O+
         sKyr7itQiazBn8371/fWvzxzYQhrfciijO9zd9QCIrqnukMXQnEiOUCaZyJlT7GgrSQS
         idc/84m0fqbZYw7FuaKoYEWn+gKrdSOtALuxSijvUWEAMld9Q5NiE6rHab2U0eDbAl9i
         Y8nuBi2UkE9QNBknUVDmkh5db+gkngC0n6c0+/GSZ+IPOSrV11Y7a1nfJUiS3ayKb28z
         AUJQ==
X-Gm-Message-State: AFqh2kreLKUzJCiLIS7oLIbQbgDzA8YrWXF37LJNgm0PquAV8+vGyeAj
        thBPtmPtCk3MDomX2r64/e/vkApI2PaPf8OupVZiawdcXmHIBUJmGHb5oRxgazR7aFfaWpcO9G+
        a7JoHwfTpGsyMtdsCckjuTHQeTzthRLkMwzkbTCUe
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id 17-20020aca1111000000b0035e7a427ab5mr408464oir.280.1671764459673;
        Thu, 22 Dec 2022 19:00:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtIOVCwh9+wmHi8r4jbqvdTXxqGzFftGQO+ErpobPf+73EjJy6JS/t0taKiB9+4ROWrt8mVx4kFe/M/uwZYo6c=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr408461oir.280.1671764459516; Thu, 22 Dec
 2022 19:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com> <20221222060427.21626-5-jasowang@redhat.com>
 <CAJs=3_D6sug80Bb9tnAw5T0_NaL_b=u8ZMcwZtd-dy+AH_yqzQ@mail.gmail.com>
 <CACGkMEv4YxuqrSx_HW2uWgXXSMOFCzTJCCD_EVhMwegsL8SoCg@mail.gmail.com> <CAJs=3_Akv1zoKy_HARjnqMdNsy_n34TzzGA6a25xrkF2rCnqwg@mail.gmail.com>
In-Reply-To: <CAJs=3_Akv1zoKy_HARjnqMdNsy_n34TzzGA6a25xrkF2rCnqwg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 23 Dec 2022 11:00:48 +0800
Message-ID: <CACGkMEvtgr=pDpcZeE4+ssh+PiL0k2B2+3kzdDmEvxxe=2mtGA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq command
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     mst@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        eperezma@redhat.com
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

On Thu, Dec 22, 2022 at 11:55 PM Alvaro Karsz
<alvaro.karsz@solid-run.com> wrote:
>
> My point is that the device may complete the control command after the timeout,

This needs to be proposed to the virtio spec first. And actually we
need more than this:

1) we still need a way to deal with the device without this feature
2) driver can't depend solely on what is advertised by the device (e.g
device can choose to advertise a very long timeout)

> so, if I'm not mistaken, next time we send a control command and call
> virtqueue_wait_for_used we'll get the previous response.
>

In the next version, I will first put BAD_RING() to prevent future
requests for cvq.

Note that the patch can't fix all the issues, we need more things on
top. But it's a good step and it will behave much better than the
current code.

Thanks

