Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971D2629EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKOQUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbiKOQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:19:56 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0AD2AE05
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:19:55 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id x13so10099373qvn.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JcCEqYIQZOOW3mLsAeSEfYdVNjlujOJ+FTDMK5J8hqU=;
        b=0XcQb0XKrAE7kGWlkqjLHDFY1uFvnD2kx6mQo/hEXkamW5WmQH2aUdgKQBm97LAARe
         HGV+TE1mKbArWH3H7YuvdDD129gejNo+ZjjGPmwN330zTvhVIQZD0QEeTC+xQ+URRLWA
         fcD8KSijo7eQSGfmA4pUMGuks+gIjk69djFwAxP0rHtt+pKlFbaixfqklpts+7a5Q4fN
         FcYoTAVC8nfjvZoLRX83Hj8mYaTJhuPxhbJY4RiTlaxI58bXKeeJGPln2gaVMebT521k
         N+CPt+kZXQashop0lgUOMrC8x9mAJB3Qk6mfcuaKvw4/do0LiCb5JWqTx4fbgvIiKMYB
         LDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcCEqYIQZOOW3mLsAeSEfYdVNjlujOJ+FTDMK5J8hqU=;
        b=gXCfWc19QB1wk9WPl4AUd4tywIi3tN/aJkQVpZjj0BtAOvzz/ng4JT7lBEWgHKcH6K
         0W6JbUr1exGRja70K2Vft4P5wWJdrRv0rMe2+d7xEGfpd9eSL28pderPLOSeQ4tzR3Wc
         s5croaqK6dtyTUSd5fNOKOAHa1XUGgaZuIWjxp+8aHDqhCnwi0XCET9eRerlBwm3dXNV
         i7IUfbRT6Xo4o/vMCQtBwA3Jcsx5U0enfpB3A1PMGJyKEX2aK8kBnjPbN/vkbyUz1ztA
         jm+uSilqdWvxWuTfZqIP2rkbItJ5dbIFLtDhxvfxnMR7RhBdN/+ThBDKIy7j68Pp9KtL
         yq5A==
X-Gm-Message-State: ANoB5pmxjakc0m1DOLtZjdPtHnI9mjU40CavxDVCkGdEzNx9Z0DXzuDR
        zde3MmUx24dzCuTSFrZ+yHszXg==
X-Google-Smtp-Source: AA0mqf4gqjZV0ZLAW5zJJh2yh0+9OK2+I6qBnL6sv53qZitopB7a1JT6LjFIj83lNf2ZpQGIDqsP6Q==
X-Received: by 2002:a05:6214:1787:b0:4b1:92ca:9cd7 with SMTP id ct7-20020a056214178700b004b192ca9cd7mr17369301qvb.103.1668529194752;
        Tue, 15 Nov 2022 08:19:54 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id cm26-20020a05622a251a00b0039cc82a319asm7408289qtb.76.2022.11.15.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:19:54 -0800 (PST)
Message-ID: <648d74af500d21e21204d998e65f9efeb2cea204.camel@ndufresne.ca>
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hsia-Jun Li <Randy.Li@synaptics.com>, mchehab@kernel.org,
        hans.verkuil@cisco.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Date:   Tue, 15 Nov 2022 11:19:51 -0500
In-Reply-To: <CAAFQd5DZG9QDp-+e8Xs7gKL=ZLkm3hA1-=eJZe8hjoB42xE5qw@mail.gmail.com>
References: <20210114180738.1758707-1-helen.koike@collabora.com>
         <20210114180738.1758707-3-helen.koike@collabora.com>
         <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
         <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
         <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
         <03f6fd9ff6a757f6d1cb6cc552efcb0b94327104.camel@ndufresne.ca>
         <3b1edf81-bcc0-0b56-7e55-93da55d7f747@synaptics.com>
         <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
         <Y24LBrkveiXlmCMy@pendragon.ideasonboard.com>
         <CAAFQd5DZG9QDp-+e8Xs7gKL=ZLkm3hA1-=eJZe8hjoB42xE5qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 11 novembre 2022 =C3=A0 17:54 +0900, Tomasz Figa a =C3=A9crit=
=C2=A0:
> > > I feel like this would be only useful in the MMAP mode. Looking at ho=
w
> > > the other UAPIs are evolving, things are going towards
> > > userspace-managed allocations, using, for example, DMA-buf heaps. I
> > > think we should follow the trend and keep the MMAP mode just at the
> > > same level of functionality as is today and focus on improvements and
> > > new functionality for the DMABUF mode.
> >=20
> > I agree, but we will need an API to expose the memory constraints of th=
e
> > device, or userspace won't be able to allocate memory compatible with
> > the hardware or driver requirements.
>=20
> Yes, I fully agree and that's why I think we should rather focus our
> efforts in that direction rather than expanding the existing MMAP
> capabilities.

I was once told that MMAP was mandatory to support in v4l2 drivers. I'd lik=
e to
get some clarification on the subject for sure. We can't break compat, unle=
ss we
spin v4l3 here.

One thing that come to mind, is that its not true that a V4L2 driver can al=
ways
be importer only. For cards like Xplorer X1600P PCIe Accelerator [1] from B=
laize
(they are using a modified, but still generic, Hantro Driver), the CODECs m=
emory
should be allocated on the card for best performance. Only the driver is aw=
are
that there is memory on that card, and so it must export the buffers.

In a DMABuf import only future, that basically means the driver must implem=
ent a
DMABuf HEAP driver, and to make this usable by generic software, the constr=
aints
API need to support telling userspace that this Heap is to be used. This ga=
p
easily extend to DRM, which have per driver API to allocate memory, and in =
some
cases these API must be used (they don't have heaps for on-card memory
allocation). When this is happening inside the GFX stack, it works very wel=
l,
but when you need to integrate this with some V4L2 driver, its not really
practical and requires something like minigbm/gralloc, which is non-generic=
.

[1] https://www.blaize.com/products/ai-edge-computing-platforms/
