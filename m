Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC56669F864
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjBVPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjBVPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:55:23 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9C3B3F2;
        Wed, 22 Feb 2023 07:55:21 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id u15so171705qkk.4;
        Wed, 22 Feb 2023 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saj3BiOUv8TiUw3L7YFkO0PUJ/tXd3q9uJ49ovUM8sE=;
        b=CmKTWrxIKlz7AVFTXvHeSdE538LnVJ9hef0GchgKdtiu3KSU5PthdxEke4Yza0DhE6
         LCBRXHANN/uH3a9sa84d8Hj+Xk889MqBHP8ndvBbpdcB7thMY3GlA/lZqBWBWzaPmJo0
         Fjqk/rLzUY6L0Gbpy7U23GyqH93ATd4ZU0h3YBmZWObkCvdslWOFysVsCff7lnpsHdAx
         2WoOdn9Ejdl9VtyN0vLkuswbYdc8A4LlgL3dew+fnwt+ulzkzVYP6FDAPOqs21buZT7J
         PC+UPBwXTzRtfw9ZmtdSaAYqGUK6Yv6f82h26Ir76Juc1Pcs5jdTYdMwiA9isr9nHmIi
         0fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saj3BiOUv8TiUw3L7YFkO0PUJ/tXd3q9uJ49ovUM8sE=;
        b=z7sfHwTX9udi6PLpF8+Y0ZQ4XwmcVyAr+aVPqVqzHmtG2KMRTCzwI+yP0520O0Agx/
         VMOoXEisy9iYAaDVAoxpb/bI2Khii9dEoqHLcFcNQYa8RxeGnUXFSdShq7PWz4RlPXaP
         msfR/1A2gVRivV82g98rL1dAouueePwKFshzeY0EBP+0sFNZuEh5AEkRFZwZeoUfpsSV
         e5R3/6sl9SUufvsoNsWgxG+QpaodkJ/C/TTucMeEuK85t1qrky7n0txCIOAMyIxfZMcm
         7Nb3ceyTQek6AEjDxR3y+jMuGfNPxdcdYXznlkDZQ8LNJm2H37gCd9cKTBgGyrJafbiK
         3Ltg==
X-Gm-Message-State: AO0yUKUK6ytQOG08UMzPNjZSrqO4GIpnJRbnOwLH2OFurvbX0RzSg3Sd
        PcAISqhvh04+TLMs6qtz2eJUgW7r9I19kqgud9Q=
X-Google-Smtp-Source: AK7set8bf6lP1s6ypm6jnpmXdn70rTkn5YmDMmCpMTW3NxWzHOTkop5Jow8BwPhs9IsE+pN9We1E32jaWMhSMe6NUHQ=
X-Received: by 2002:a05:620a:831a:b0:742:3e52:f855 with SMTP id
 pa26-20020a05620a831a00b007423e52f855mr53039qkn.2.1677081320370; Wed, 22 Feb
 2023 07:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-4-robdclark@gmail.com>
 <b056a87c-b6b2-25e0-25c7-f7d422793a3e@linux.intel.com>
In-Reply-To: <b056a87c-b6b2-25e0-25c7-f7d422793a3e@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 22 Feb 2023 07:55:08 -0800
Message-ID: <CAF6AEGv6vaoV_Rro8zSkwtBVTkeQXLdEOnCNBp_8xbkaxa_nOg@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] dma-buf/fence-chain: Add fence deadline support
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 2:27 AM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 18/02/2023 21:15, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Propagate the deadline to all the fences in the chain.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for this o=
ne.
> > ---
> >   drivers/dma-buf/dma-fence-chain.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fe=
nce-chain.c
> > index a0d920576ba6..4684874af612 100644
> > --- a/drivers/dma-buf/dma-fence-chain.c
> > +++ b/drivers/dma-buf/dma-fence-chain.c
> > @@ -206,6 +206,18 @@ static void dma_fence_chain_release(struct dma_fen=
ce *fence)
> >       dma_fence_free(fence);
> >   }
> >
> > +
> > +static void dma_fence_chain_set_deadline(struct dma_fence *fence,
> > +                                      ktime_t deadline)
> > +{
> > +     dma_fence_chain_for_each(fence, fence) {
> > +             struct dma_fence_chain *chain =3D to_dma_fence_chain(fenc=
e);
> > +             struct dma_fence *f =3D chain ? chain->fence : fence;
>
> Low level comment - above two lines could be replaced with:
>
>         struct dma_fence *f =3D dma_fence_chain_contained(fence);
>
> Although to be fair I am not sure that wouldn't be making it less
> readable. From the point of view that fence might not be a chain, so
> dma_fence_chain_contained() reads a bit dodgy as an API.

It does seem to be the canonical way to do it since 18f5fad275ef
("dma-buf: add dma_fence_chain_contained helper").. looks like I
missed that when I rebased.  I guess for consistency it's best that I
use the helper.

BR,
-R

> Regards,
>
> Tvrtko
>
> > +
> > +             dma_fence_set_deadline(f, deadline);
> > +     }
> > +}
> > +
> >   const struct dma_fence_ops dma_fence_chain_ops =3D {
> >       .use_64bit_seqno =3D true,
> >       .get_driver_name =3D dma_fence_chain_get_driver_name,
> > @@ -213,6 +225,7 @@ const struct dma_fence_ops dma_fence_chain_ops =3D =
{
> >       .enable_signaling =3D dma_fence_chain_enable_signaling,
> >       .signaled =3D dma_fence_chain_signaled,
> >       .release =3D dma_fence_chain_release,
> > +     .set_deadline =3D dma_fence_chain_set_deadline,
> >   };
> >   EXPORT_SYMBOL(dma_fence_chain_ops);
> >
