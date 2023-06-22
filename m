Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C065973A059
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFVMBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjFVMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F161FFC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687435151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTTkA2sp2q9Z2LAXZ1QDFqA4SF11T5ulFHu3zl8eY5M=;
        b=HKcWs6DPAhU6wfPnHBl6G6Jy2lxAo47NSLCmBXEfeoO9iYb2vuqc8aqpgKWA5HPgrcvnV+
        saFjDIBqwl6RgNIDlRcw7k3z1ZPXrFs7namUC2su4EBicuGWq4G+hS35jVJEvKJSVAHjkB
        bQ612WGXELIjTpKkJMoDMLcARRUFHX8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-iUTq_4jMN1ueJNbrkVpQxw-1; Thu, 22 Jun 2023 07:59:10 -0400
X-MC-Unique: iUTq_4jMN1ueJNbrkVpQxw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355c9028so490729566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435149; x=1690027149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTTkA2sp2q9Z2LAXZ1QDFqA4SF11T5ulFHu3zl8eY5M=;
        b=G/Pd2iqvsH/J7hzjO8d/FFjczNayrhi/L+Ajxdcvqc5v4s2wAZJHW3gY6iaTI904Xp
         5vN+taj4u3ENyRwJ4WKW7bu5vtqP5EBQ11N4aXPeuYEEwMKWhI8Xiv4EktE8i7XS8XwD
         N0aPDQjqqCoRNKpaaRPSuJJzRI3BLsQzyE+JHBqF0JCn9uh2qZA55L0SmkKz/TuGizy3
         GqBXUVgP1msfumEUc3FtEsukiLP4HORTINUtP7ImuzcHOlzCHHE/aaKvGN4Q6dseXsQQ
         PK9XsHp2cVqJNzmQ0VrEy8igCDDWTIyhumrwu8KwS4wUtd/YZnC9d8+CRBC0pzr5Thkx
         eL3w==
X-Gm-Message-State: AC+VfDzQsFF9XMRLlEyosI+6PsPYlGIWaJIsOLQgZOs4x1IN3TAo8DLL
        ClVYC0kGSJ0g6oI0MFzeY0URauTs4hcD2eT9ko3btmB4lTDFBUjDOM+M+oboZphwH+C7oHSUaz9
        VwtlLxRwKgzwUJs/WjpQRSvGY
X-Received: by 2002:a17:907:da2:b0:988:e8e1:6360 with SMTP id go34-20020a1709070da200b00988e8e16360mr8670204ejc.8.1687435149351;
        Thu, 22 Jun 2023 04:59:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60H5p6tlUuyW+YXWTMB9vjFrAWl14WNSb9PT+fUHAJkRDpLgoKLJFf4fBEpXMrE8mEIpD8PQ==
X-Received: by 2002:a17:907:da2:b0:988:e8e1:6360 with SMTP id go34-20020a1709070da200b00988e8e16360mr8670182ejc.8.1687435149020;
        Thu, 22 Jun 2023 04:59:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ef:2a1f:ee44:7b4f:4310:5b81])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906711100b009884f015a44sm4484108ejj.49.2023.06.22.04.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:59:08 -0700 (PDT)
Date:   Thu, 22 Jun 2023 07:59:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fixup potential cpu stall
Message-ID: <20230622075819-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:18:14PM +0800, Xianting Tian wrote:
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.


I applied this after tweaking commit log to address Greg's comments.
In the future I expect you guys to do such tweaks yourself.

> Xianting Tian (3):
>   virtio-crypto: fixup potential cpu stall when free unused bufs
>   virtio_console: fixup potential cpu stall when free unused bufs
>   virtio_bt: fixup potential cpu stall when free unused bufs
> 
>  drivers/bluetooth/virtio_bt.c              | 1 +
>  drivers/char/virtio_console.c              | 1 +
>  drivers/crypto/virtio/virtio_crypto_core.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> -- 
> 2.17.1

