Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864B8741AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjF1VY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjF1VXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:23:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C4E44BA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:20:25 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-570002c9b38so2929557b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687987224; x=1690579224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ekfb+8jnQjb0rMmjY0dUBWnVd1jyDWvH/VVzXj3W494=;
        b=R2n4QZrHf3/xwAib6xY0y711Iyw3WIznurApfcQV7ejZRUMS1k67mPtaIiPFIuLlXE
         8dPI3Qs3YD+aY7tIAVvyCNo/a6Fp2JkgIXSgkfBR+lOEcP3/gi5eLJ9SOor/KznLreuT
         4EDJNnAT0WZOS3KqfqAa1PXdzOpNc26ORy17cYTNalHr4IDvSFtlxiZdTwOaL76NJBWe
         HdCrxIXITAnjY8t23Nl4gEYynIp8HIhvmBR9FgEhmbBql0Bo5oNaY4lnnJys0XdVdr8E
         oKIqFC8ihWhsGh+RAKQT/00liaaxuwXfDVc9DQFwSYVUcBw2PasyeHrtMs7yo8nk7SSp
         DUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687987224; x=1690579224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ekfb+8jnQjb0rMmjY0dUBWnVd1jyDWvH/VVzXj3W494=;
        b=H3DE6/xeIDX0t1JsAMlGcPV8ZvzSmidHPRIbxFAFSsk2laqIRB3yptXZe778Y0Z7iH
         FoF+Ie60Zrq91Fo3WEzjADKd6IE4M7YPCmze4aDVjlNzR+7EO7C4A0WuFpxRly+smNXk
         czdSW24HnUwVHu8RH51PeXs0VFWe9/YdSpDiSNhdxRKmWe1Rk4M2qmeVqyLAf9dGB4RK
         jjr8MtLaaLoxy0+QZCt+XK1G5FtIpL1u4upS6SpiYZ4afzrd7A4d112y1RdW9a4R9yik
         gj0vTLitrqnPi4KVqNAgZZbL5M+1d8pXPF11RLZyAXV8TQTJy3d0m08hGr7cVnXIhOIC
         5dBA==
X-Gm-Message-State: AC+VfDyLngFMk0+TIsMGIjcq5D6DrB68Aw+fvKhkaiCe1MK4ayaha4OC
        vHDLGHARVWIt+KFVnYFnU8vVzX6UOVTDEOBguj3HYg==
X-Google-Smtp-Source: ACHHUZ6D85D5C1w3H+xEQN6Qdcb+sVlnGnAqgw1jLsztz/k1XxsLPD3iC+7hS3DXqruaRS7h92OBnYdR5JvpawJr7xU=
X-Received: by 2002:a25:25c6:0:b0:ba8:296c:e59c with SMTP id
 l189-20020a2525c6000000b00ba8296ce59cmr30093218ybl.53.1687987224132; Wed, 28
 Jun 2023 14:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230628180534.31819-1-quic_jhugo@quicinc.com> <CANDhNCqUkhiWgjCuLVX=vpBsHYj9zto95HoBH1f4XqOEkx9Zhw@mail.gmail.com>
In-Reply-To: <CANDhNCqUkhiWgjCuLVX=vpBsHYj9zto95HoBH1f4XqOEkx9Zhw@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 28 Jun 2023 14:20:12 -0700
Message-ID: <CABdmKX0A8mqz5cS4+CqjRgpQQKuSp=3SvE1KJ_di09VjJQVoGg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Liam Mark from DMA-BUF HEAPS FRAMEWORK
To:     John Stultz <jstultz@google.com>
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>, sumit.semwal@linaro.org,
        benjamin.gaignard@collabora.com, labbott@redhat.com,
        Brian.Starkey@arm.com, andersson@kernel.org,
        linux-media@vger.kernel.or, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 1:39=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> On Wed, Jun 28, 2023 at 11:05=E2=80=AFAM Jeffrey Hugo <quic_jhugo@quicinc=
.com> wrote:
> >
> > @codeaurora.org email addresses are no longer valid and will bounce.
> >
> > I reached out to Liam about updating his entry under DMA-BUF HEAPS
> > FRAMEWORK with an @codeaurora.org address.  His response:
> >
> > "I am not a maintainer anymore, that should be removed."
> >
> > Liam currently does not have an email address that can be used to remov=
e
> > this entry, so I offered to submit a cleanup on his behalf with Liam's
> > consent.
> >
> > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 76b53bafc03c..1781eb0a8dda 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6168,7 +6168,6 @@ F:        kernel/dma/
> >  DMA-BUF HEAPS FRAMEWORK
> >  M:     Sumit Semwal <sumit.semwal@linaro.org>
> >  R:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > -R:     Liam Mark <lmark@codeaurora.org>
> >  R:     Laura Abbott <labbott@redhat.com>
> >  R:     Brian Starkey <Brian.Starkey@arm.com>
> >  R:     John Stultz <jstultz@google.com>
> > --
>
> Acked-by: John Stultz <jstultz@google.com>
>
> Though probably worth adding TJ as a reviewer?

Yes please!
