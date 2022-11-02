Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367EC616343
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKBNB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiKBNBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:01:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411712872D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:01:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n83so19094314oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 06:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yggPcK5TIy9S6ZT52DUYZYz36AXCmMT/bN7wqCeS1aw=;
        b=GGoxflpeBD4PlWvUvbzWx/ExOWXpLVPaGPWsA5VJ7zBECqzFfKTDyYrSvR9QX44E4Z
         0L830fD72/n3XPMb//OpKzXSwLW7xNUJsHBkCLwIv6jFEFrgwTds5T1+dNAw7nyXDDHm
         k9mxk85yYzWyn6/Rd23eT+G76vju+rvKmlLwP/KuJcMXJbojryZ92nsxTrvF79wZK+Zg
         Speo3j7nNv7IaR4Ome2EJZ5jibL+lr5cXatvdXglwK/ALECdVLnwwsfaAegHCppkCo35
         QPVVxDDOGjd3sb5iBw7cm0t9NtocEy4lGYfBuFEE94H/CLMO0la4smU+p2seJ4nwiY9O
         Ty7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yggPcK5TIy9S6ZT52DUYZYz36AXCmMT/bN7wqCeS1aw=;
        b=1rQv2Ot5uV5EWC9cGhD9MO0QVmnHwNM+slJACNeqBtAgZDD17W8A2Ek9Bta78HJn3K
         oFasIMn2UYNjqweMCJRSwfMRRslTUhDeheW03wFA9G9bhd12L7KtjDjOKyYZmrbFxYWD
         qrMnQVJEg58fBUxZha7KykFo9GkXXvEcTPCEJB9Bh2lpcfGv2pY9V1QSDBBwhygFBxDh
         2i7bj7LHC6yUV2Tq608yD8cx5pnE5NsNDbrAaxy0INgjf2rlv931yPNIJCRWQ8eSJQ5U
         W9KGqYGF9dTcoWVA6O/6DbSyBGIjBgN5wM2OEfUvlagzO313fOuqEwSo3BvpNj9IU2k9
         nYSg==
X-Gm-Message-State: ACrzQf2y89uFn339+8xJVLZugyC5gopcODvGAVt6yIQKWD7sHNjMMfGN
        c0JWIVv38fzkumhIMs6Ev9jHk+3b+otESu2fGLg=
X-Google-Smtp-Source: AMsMyM6qZQxXTSO2TswGy9TB1D8Odto/9aPMXtUQBP2MbhygDgD/F+xKh7vTLDPRvs/CUg5hTSU2HPJ9sIao/ppsy6k=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr13266615oiw.96.1667394110491; Wed, 02
 Nov 2022 06:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221016174158.16638-1-fmdefrancesco@gmail.com>
 <CADnq5_MDp6WUYTUO+Lo=XMSLdaYcwu5i2MWid9u1U2hKiyqoYg@mail.gmail.com> <1753145.VLH7GnMWUR@suse>
In-Reply-To: <1753145.VLH7GnMWUR@suse>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Nov 2022 09:01:38 -0400
Message-ID: <CADnq5_MfEGsxKxh459DZsHUjUspQLd7zagtrEeFMC4Upk-zTEw@mail.gmail.com>
Subject: Re: [RESEND PATCH] drm/amd/amdgpu: Replace kmap() with kmap_local_page()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 7:21 PM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On luned=C3=AC 17 ottobre 2022 18:53:24 CET Alex Deucher wrote:
> > Applied.  Thanks!
> >
>
> The same report about which I just wrote in my previous email to you is a=
lso
> referring to this patch which later changed status to "Not Applicable".
>
> It points to https://patchwork.linuxtv.org/project/linux-media/patch/
> 20220812175753.22926-1-fmdefrancesco@gmail.com/
>
> Can you please let me understand why?

I'm not sure I understand what you are asking.  The patch is applied:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/a2c554262d39f81be7422fd=
8bee2f2fe3779f7f5

Alex

>
> Thanks,
>
> Fabio
>
>
>
