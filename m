Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB51C5EEBBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiI2Cay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiI2Cat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F6116C15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664418647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8QXNXLRU8PMLEfJJoJq8W3G/s1ic9t+BxxX2dS4vHJU=;
        b=ZhhImkAHGwDkpw6utFarjw7GS0rpxQQVcPZ6IBK+sZAPr7pabAHN9kWhTG0RGba8t3StlO
        X/fkDkinp0TaCcwHA3zrdb2Rbk76mwAXh/ww298O5moN/QOvtt5n1eoT4hfrfGWYnaIxwE
        6VVwuPKjShQY/T6A41ZG/qvwEn1WvZM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-G3Fc7wrNONSTtKZIamy-7Q-1; Wed, 28 Sep 2022 22:30:45 -0400
X-MC-Unique: G3Fc7wrNONSTtKZIamy-7Q-1
Received: by mail-ot1-f71.google.com with SMTP id 61-20020a9d0843000000b0065bed802a93so135681oty.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8QXNXLRU8PMLEfJJoJq8W3G/s1ic9t+BxxX2dS4vHJU=;
        b=E+y64iV7iWmItuDqA24g5Np1ZZjQ9K/Xi+Q2N8jNbqX3TsAvHrTCi3UxVFZpBLjeRC
         3OsfyeNJnTfuwRTJcmxuC0GbhatDzN2uAFG7GiqGyQoE/vgAfk7SPYVnfUiekRES9iVW
         Hsb9TnMB1bUsMpsZIWT3PKoJYYT9S/28mxC+jRBnE0cnt0wJq6Q871Nv2QnV9fiUIJpJ
         5UrD75NGBOkTwtuxCEaFKJNVoFQO6CbcHq961Kmulbsn9ZKzPo94N9gnKcwBCKM44Hcm
         OtLzN6MRBghxsc92f7YWY5L/7MuBVbbdGMZ7JJm+fgpjF/YasyA/8RafJ9EXX/DZnzBX
         JcCA==
X-Gm-Message-State: ACrzQf0L1UpXXEqaEt0eTu3FeCDFuB3v1ICLvn1dZ4IdnaaA2QRbHHKV
        XjS0E2rOZYWYUrxkDWSuSM085LKxtIJUeAd32LVokhHR06Yoa7iJ+vk9Qp37mgm1N3QNjJoI4Pk
        Hsfu6dMbvhUU2XY8WmNGGc4EnuYPXDlP+rp/WsXyE
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id bx34-20020a0568081b2200b00350c0f670ffmr5693950oib.35.1664418644863;
        Wed, 28 Sep 2022 19:30:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6cxjoIrT/eaGTsGJqz/dQ3DlD17JUKEQBrtUsl3H1pjCxun/bNtxts+L+mNLuXNM3li37fisri9ZvMxKU3JK0=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr5693942oib.35.1664418644678; Wed, 28
 Sep 2022 19:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220928104628.521-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20220928104628.521-1-angus.chen@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 29 Sep 2022 10:30:33 +0800
Message-ID: <CACGkMEtaMRifeDDDk3kb7QY-1mO1V2t6PFjgRXwRoN8NbRaD=A@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_pci: avoid to request intx irq if pin is zero
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 6:47 PM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> The background is that we use dpu in cloud computing,the arch is x86,80
> cores.We will have a lots of virtio devices,like 512 or more.
> When we probe about 200 virtio_blk devices,it will fail and
> the stack is print as follows:

Not for this patch, but I wonder if it's time to introduce per cpu
virtio interrupts instead of per device ones? This may help in this
case.

Thanks

>

