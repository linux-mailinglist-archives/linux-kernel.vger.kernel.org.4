Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF046F9E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEHEAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEHEAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47643618B
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 20:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683518355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhV1HCZuC1ykzH7ZXQCmd5NhspBHpB8ROhzdIJyNs4g=;
        b=i9NKIxm9wjRVgzOxeOhnXXuHwwn+x1WJpYWPE9F+aTOq7XB9tcTL9s2WnO0voTWSN6/gCe
        s8KY33+lBHqlXlcKwr63jkozOiJktu70UfinbHZEXyF3Wpt6k6ZMyfX2CTRLa3NENZYzZG
        2mIvXJmsjJcwbpTYVK4TPxmzHvYBAAc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-enCLMK7yPo291kSpWsZyag-1; Sun, 07 May 2023 23:59:13 -0400
X-MC-Unique: enCLMK7yPo291kSpWsZyag-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ac7c596692so20262141fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 20:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683518352; x=1686110352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhV1HCZuC1ykzH7ZXQCmd5NhspBHpB8ROhzdIJyNs4g=;
        b=gEngARNyqbbwlj+IMU06tL4Tg1zRi/ube4NspCXtdSS7KsBi6XGR0OzJa+x6A1g+aG
         zBhFZxa0jIOJMQTE6qJ+1V9llakGYra/9576imO28xE7MhmqNLB2/y08dwxz6zr4+odQ
         UWzIC5H6NRqg+C0w4PahErz+80t3/Umqk8fEXC7NoFc8W5dLQpINTrAIHuIrD8oVE6Hr
         Qt5HaGOARRyky1o1j1wban384fJdCBcr4ybE4iPnw9lKzhHDA/FKiucl9KKPDnqZWxoh
         tj9p2i6FrDD6A0VuZLBITduG7uI3k1C5dp8Y9hMzx0zFopzElkhyqVE7D975Q75TIfUz
         6Vnw==
X-Gm-Message-State: AC+VfDxmbh6NpR0msscpjfp7vOAEQ+BGq/zScgH6pvctqhtCREEe0aE3
        X0h6UEMWIsQLcZyo2mIp2KXIoIW5IZfnEmiRREsgWCbirs7QxFxeiP3WhJR9Ga0Z3q6anTFwvWq
        yW1Q60AoC0E2Bd7+nn9gMQGdZR/ET6RH/6YpIFN1N
X-Received: by 2002:a2e:9a8c:0:b0:2a8:d021:4121 with SMTP id p12-20020a2e9a8c000000b002a8d0214121mr2603309lji.26.1683518351981;
        Sun, 07 May 2023 20:59:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HJcVoKi2ee89Revfy5S+1yRrWBbXV9kLn9T7LqZGtjxjvcGzOFe2CnWI1zMNd6LM+SIeINluarYhhWMghnT4=
X-Received: by 2002:a2e:9a8c:0:b0:2a8:d021:4121 with SMTP id
 p12-20020a2e9a8c000000b002a8d0214121mr2603307lji.26.1683518351704; Sun, 07
 May 2023 20:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp> <20230427104428.862643-3-mie@igel.co.jp>
In-Reply-To: <20230427104428.862643-3-mie@igel.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 8 May 2023 11:59:00 +0800
Message-ID: <CACGkMEsOw08UWdNfhVd8q2-SwCt+jwMbeYwYQ+OMN+2RiHBZag@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] virtio_pci: add a definition of queue flag in ISR
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 6:44=E2=80=AFPM Shunsuke Mie <mie@igel.co.jp> wrote=
:
>
> Already it has beed defined a config changed flag of ISR, but not the que=
ue

Typo should be "been".

> flag. Add a macro for it.
>
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Other than this,

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/uapi/linux/virtio_pci.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_=
pci.h
> index f703afc7ad31..d405bea27240 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -94,6 +94,9 @@
>
>  #endif /* VIRTIO_PCI_NO_LEGACY */
>
> +/* Bits for ISR status field:only when if MSI-X is disabled */
> +/* The bit of the ISR which indicates a queue entry update. */
> +#define VIRTIO_PCI_ISR_QUEUE           0x1
>  /* The bit of the ISR which indicates a device configuration change. */
>  #define VIRTIO_PCI_ISR_CONFIG          0x2
>  /* Vector value used to disable MSI for queue */
> --
> 2.25.1
>

