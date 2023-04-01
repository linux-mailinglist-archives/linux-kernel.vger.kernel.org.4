Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D626D3152
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDAObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDAObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:31:48 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C511AD27;
        Sat,  1 Apr 2023 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680359504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMrbsGp2VbSuKBP42mT23UvlOXpqHOgBiKJ7nTY4v2c=;
        b=GrRe12vSlJYlfUja0UIhZA/bhg+HyUD+h3ORFit2lWeN8k0evumUNlAmn/of32pQZkb8Iq
        OFFx6AUYaqh4qspAh+JrJ++/6jOjfefooPQ+0c+1fXJ+ftGKRMGaA4Ly24MPkHBZRk0V7j
        szECRpOr+X05RzncynymXdY1baUJAiU=
Message-ID: <425c1b8ea20002c6344a574cd094b4c715c67ba6.camel@crapouillou.net>
Subject: Re: [PATCH v2 0/3] usb: gadget: functionfs: DMABUF import interface
From:   Paul Cercueil <paul@crapouillou.net>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     michael.hennerich@analog.com, nuno.sa@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Date:   Sat, 01 Apr 2023 16:31:42 +0200
In-Reply-To: <c6ce737d-25cc-7f22-7c0f-c0ba1420e57d@collabora.com>
References: <20230322092118.9213-1-paul@crapouillou.net>
         <c6ce737d-25cc-7f22-7c0f-c0ba1420e57d@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

Le vendredi 31 mars 2023 =C3=A0 11:40 +0200, Andrzej Pietrasiewicz a =C3=A9=
crit=C2=A0:
> Hi Paul,
>=20
> W dniu 22.03.2023 o=C2=A010:21, Paul Cercueil pisze:
> > Hi,
> >=20
> > This small patchset adds three new IOCTLs that can be used to
> > attach,
> > detach, or transfer from/to a DMABUF object.
> >=20
> > Changes since v1:
> > - patch [2/3] is new. I had to reuse a piece of code that was
> > already
> > =C2=A0=C2=A0 duplicated in the driver, so I factorized the code.
> > - Make ffs_dma_resv_lock() static
> > - Add MODULE_IMPORT_NS(DMA_BUF);
> > - The attach/detach functions are now performed without locking the
> > =C2=A0=C2=A0 eps_lock spinlock. The transfer function starts with the
> > spinlock
> > =C2=A0=C2=A0 unlocked, then locks it before allocating and queueing the=
 USB
> > =C2=A0=C2=A0 transfer.
> >=20
>=20
> Can you share an example use case for these new features?
> Is there a userspace that excercises the new ioctls?

We use it at Analog Devices to share buffers between the IIO subsystem
and the USB stack, which makes it possible to stream data samples
between a host computer and high-speed transceivers as fast as
possible, in a zero-copy fashion.

This will be used by Libiio:
https://github.com/analogdevicesinc/libiio/pull/928/commits/dd348137ce37153=
2fd952a2b249cfd96afaef7d1

The code that uses these IOCTLs is not yet merged to the "master"
branch, but will be as soon as this patchset is accepted.

Cheers,
-Paul
