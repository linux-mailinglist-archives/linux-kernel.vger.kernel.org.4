Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C171208B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbjEZG62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjEZG61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE81AD
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685084261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ze1eBV4qRCm3f7jG4VXgl0UZTu4+F/diGmfSJICaiCw=;
        b=d5q4DXgPwsSEQeTtuUBnZevL7a0WmWOiGE2M0jTc9tQosCawLWmmUPtL83E0reaZTEqCx+
        msBz+xCSh3Mx62iMwN/7DkcyrD+VA5WZ0CxixDBYTo8WUfo2XgSdK5NvE2DdY4rljD9ogs
        qYEBExJFfvAyhlpp844adsGbdKjxarE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-iOcPg2YXPHaiW6Js8NLepA-1; Fri, 26 May 2023 02:57:39 -0400
X-MC-Unique: iOcPg2YXPHaiW6Js8NLepA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2af2f4e71a2so1865451fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685084258; x=1687676258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze1eBV4qRCm3f7jG4VXgl0UZTu4+F/diGmfSJICaiCw=;
        b=HEK9tfpqZcFSW6xsZvSAFRXLPiiPu/hKbLYPbLv8pa+EXoP6XQy30b432Dhkvwzxyk
         plxeujsJKR3U3rIsTbBnUEFvPOltnPnomDmKbCfmBMYZq8N47AxoQuhZyhkp/geojqt1
         1xXLngqzOphIg95LcSuc4KYr3wBReEqAAI3xpY74826fhV+TM9J9zeAFYWD6TYoTXdDI
         mSm4Uh8VWmBOwr0PGC4mxfFY9MZ0eRj7cLG1wAWLmWLNv2jWG2Ag6jn97JIEV3oeVNGs
         HuLx8TktUHclPOCBNCdVrG30tMuYUJ5gcn5rmvg8miSzu5foH348YMi3AB1ah/6M9qCf
         vTMQ==
X-Gm-Message-State: AC+VfDxaBNfkUS2Eqt0ifjbCoIIXW81v2I6PlNKAY3Mgxrd7Wcp/tNS9
        zW537buVYv9MYL71WTRYaDcMtpKjv70pGZ5Jjv7IxnZh59ejyjDNZkFuuoEL0yHU73FQTy+KPPG
        b+cm5g6ZYLuYsm+bc5EEiUVZhbXRE52W3sjpfhQip
X-Received: by 2002:a2e:988a:0:b0:2af:19dd:ecda with SMTP id b10-20020a2e988a000000b002af19ddecdamr270643ljj.45.1685084258267;
        Thu, 25 May 2023 23:57:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RUV+CPVbAikpmqLlt9KyfhEdW/YgA62KOwWCN81f6RByJJ2V+wLWEBsXzQPG8RpdaSOEsVayioAzSUl9FlpE=
X-Received: by 2002:a2e:988a:0:b0:2af:19dd:ecda with SMTP id
 b10-20020a2e988a000000b002af19ddecdamr270630ljj.45.1685084257924; Thu, 25 May
 2023 23:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com> <20230526054621.18371-4-liangchen.linux@gmail.com>
In-Reply-To: <20230526054621.18371-4-liangchen.linux@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 26 May 2023 14:57:26 +0800
Message-ID: <CACGkMEsnto9APpDo1uzVJAWBwk9f8pt6D=J41tdf1ZQ63ADK9Q@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] virtio_ring: Introduce DMA pre-handler
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, pabeni@redhat.com, alexander.duyck@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 1:47=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> Currently, DMA operations of virtio devices' data buffer are encapsulated
> within the underlying virtqueue implementation. DMA map/unmap operations
> are performed for each data buffer attached to/detached from the virtqueu=
e,
> which is transparent and invisible to the higher-level virtio device
> drivers. This encapsulation makes it not viable for device drivers to
> introduce certain mechanisms, such as page pool, that require explicit
> management of DMA map/unmap. Therefore, by inserting a pre-handler before
> the generic DMA map/unmap operations, virtio device drivers have the
> opportunity to participate in DMA operations.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>

So Xuan is doing AF_XDP for the virtio-net that allows the DMA to be
mapped at least by the virtio-net.

It looks like a way to allow virtio-net to map and unmap the DMA
buffer by itself, but this patch goes into another way which seems to
query the address from the virtio core.

Personally, I think map and sync by the virtio-net driver seems clean.
But we can see.

Thanks

