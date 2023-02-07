Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B29168D38D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjBGKHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjBGKG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:06:59 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67CD51C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:06:57 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id 6so7574671vko.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F1f6fg1Ju5/GylO5RYS7YswcL9SMWGJBP511vx2aSQ=;
        b=1JIij/0h7xx2+KunzO91Jtltqcw85/+ghFfvGffsJIa31FEgF6EaIXYINVuoKpgT9f
         riSir9SbmAb8OywsgmFDu+fJpB5ojW9q6HtsarNuAPmFfaOQyQUYqMWJfKLRwpd8M2rF
         oxMCF2J7lENtJTYbihoG344ew0eTLbW3mJ9fPS0Nih2bSPYhBdqcHvg9FxiSHj3hv4SG
         3y1PXPjEo172NXT2+qRdG2HetNHiW1mof185n80sBka+6BIOeP55ShQau9lctxH9HTyK
         q+6NZNZTpCbR6zHEIewLA+ZJj2uWpRnOxtNMLs7Qa+twPN7czaSQ0alUwg0GecPEewJr
         PEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F1f6fg1Ju5/GylO5RYS7YswcL9SMWGJBP511vx2aSQ=;
        b=bTRqKJLBsPAvM7dinp2bAw0CIips0TGwA4kOkvnC6OGvbEqN0plGOdnKA3PtpR9XhR
         T8PVTiJMgHn3Dds8nzz+SJLK4xAtGy0Nixtf3xhN3JwjHanr9HCAsm8dbWHi7unZ6kFP
         wte8bbEz16c9bZymJanQbwgk1QF7sB6xc3y6Msl1UWqKUm0OTsX2HcrYOkt34bmcHH5I
         S1trWx4P6IFXylMNrhx8x3IUc+SU55oGEI4pFNRHH+ZTYK25E+LlgtaQDQGQBc/gHybV
         chRJrsVLVG+9iCN2+G40Wh2H/drGHC/IFDvv58h5WnBF7FlWQY4NGURSaKimVxDgmyo+
         sNHA==
X-Gm-Message-State: AO0yUKVHQc6d9KEjv+40vZmiKjVLATiKSBAtyRzZ2FJ0blW0N/HUQwkP
        HMnSt1XGC0+cUfelWgpZV7Lp4Q4WWStJjREmqfaxCQ==
X-Google-Smtp-Source: AK7set8Bj8gAcLpasR5AdxjuMr8vbshN3umCqfQFPoYPpz3YZBHK9u2zhhRO+VrNsERB1PuheKvCcZvhgQ1sXD8dq5Y=
X-Received: by 2002:a1f:9d02:0:b0:3dd:f6a9:4b73 with SMTP id
 g2-20020a1f9d02000000b003ddf6a94b73mr323152vke.12.1675764416761; Tue, 07 Feb
 2023 02:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp> <20230203100418.2981144-2-mie@igel.co.jp>
 <20230203051445-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203051445-mutt-send-email-mst@kernel.org>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 7 Feb 2023 19:06:45 +0900
Message-ID: <CANXvt5ppfpQ5jQy8BAHPdeVc881vqXig=RaNmBoePPYrNkMm-w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] virtio_pci: add a definition of queue flag in ISR
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023=E5=B9=B42=E6=9C=883=E6=97=A5(=E9=87=91) 19:16 Michael S. Tsirkin <mst@=
redhat.com>:
>
> On Fri, Feb 03, 2023 at 07:04:15PM +0900, Shunsuke Mie wrote:
> > Already it has beed defined a config changed flag of ISR, but not the q=
ueue
> > flag. Add a macro for it.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > Signed-off-by: Takanari Hayama <taki@igel.co.jp>
> > ---
> >  include/uapi/linux/virtio_pci.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virti=
o_pci.h
> > index f703afc7ad31..fa82afd6171a 100644
> > --- a/include/uapi/linux/virtio_pci.h
> > +++ b/include/uapi/linux/virtio_pci.h
> > @@ -94,6 +94,8 @@
> >
> >  #endif /* VIRTIO_PCI_NO_LEGACY */
> >
> > +/* Ths bit of the ISR which indicates a queue entry update */
>
> typo
> Something to add here:
>         Note: only when MSI-X is disabled
I'll fix both that way.
>
>
> > +#define VIRTIO_PCI_ISR_QUEUE         0x1
> >  /* The bit of the ISR which indicates a device configuration change. *=
/
> >  #define VIRTIO_PCI_ISR_CONFIG                0x2
> >  /* Vector value used to disable MSI for queue */
> > --
> > 2.25.1
>
Best,
Shunsuke
