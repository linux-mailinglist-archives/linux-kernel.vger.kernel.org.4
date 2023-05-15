Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C210170413E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245079AbjEOXBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245411AbjEOXBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:01:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252ECDD94
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:01:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9659c5b14d8so2247291366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684191663; x=1686783663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10cFuMF+WVG9ce0NQecfKwGM15VTiPed2+yziwbzR84=;
        b=CpQjZwi6SYoQ1hphStaI1SRS+LwxGPaFEZ/kkJWhmp5TGEe1A20AVLaqYhKzHSQyIL
         suTLF7KlpGYfXq3m23wfjHe4+/smLpxs093OXArEcYYg9ypq/3EmxpaqST2tZdR4yo2m
         BzrEMHLLijfzAy6kx/7nVp3LN1AgROGwBaioE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684191663; x=1686783663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10cFuMF+WVG9ce0NQecfKwGM15VTiPed2+yziwbzR84=;
        b=NS1upjoLPHkdR6D7cyE5Q23gvBfj/N79AG+XnJaPSuuxjS219IAsbPZC9uJ5vi0oEc
         vXkMWgAF/EQ1/5UrG5OZMAXQc8hKsRxf/eR83RpbrES/SKgHh8PvTsE3/jD8xB02t2gL
         sU+BaGCXPTgMKaPLW1+rA7Oc+NbFefjZAG295qcOe0heK9b3IrbOgTrCeVr1DJSID9+b
         8W45X8VRilklLFJIVhtc/qg50LDjHN97iAbh0HH9HGuMfPKGd33HwRTOq1KYPfS6suDM
         mUH0oCvKZFWw+sVvDZhsyYJaAMZ3sU9PvegyGyf/2/3Kz3UFkAosuph3lUip4UlLJVqA
         tglw==
X-Gm-Message-State: AC+VfDygWpqUG4yNl8eJ3d+FiI41FFmsUCLJWCoEkUlQK8Z429C1IvXz
        brmxtZAPviRfU6ge2SAnuTmukDxwSuhdHdK0anEdSww5
X-Google-Smtp-Source: ACHHUZ71dsVDw2l3exJMhL4g3Vw3Etepah2yS8S23lJDQTkBiooNRsSsYPDklOeIsa9YICgZTAe++Q==
X-Received: by 2002:a17:907:97c8:b0:966:17b2:5b0b with SMTP id js8-20020a17090797c800b0096617b25b0bmr33546804ejc.49.1684191663412;
        Mon, 15 May 2023 16:01:03 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00960005e09a3sm10172131ejb.61.2023.05.15.16.01.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 16:01:03 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f4271185daso90054445e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:01:03 -0700 (PDT)
X-Received: by 2002:a17:907:6d8e:b0:966:5c04:2c61 with SMTP id
 sb14-20020a1709076d8e00b009665c042c61mr26963047ejc.8.1684191305862; Mon, 15
 May 2023 15:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com> <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com> <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner> <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
In-Reply-To: <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 May 2023 15:54:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
Message-ID: <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     Mike Christie <michael.christie@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 3:23=E2=80=AFPM Mike Christie
<michael.christie@oracle.com> wrote:
>
> The vhost layer really doesn't want any signals and wants to work like kt=
hreads
> for that case. To make it really simple can we do something like this whe=
re it
> separates user and io worker behavior where the major diff is how they ha=
ndle
> signals and exit. I also included a fix for the freeze case:

I don't love the SIGKILL special case, but I also don't find this
deeply offensive. So if this is what it takes, I'm ok with it.

I wonder if we could make that special case simply check for "is
SIGKILL blocked" instead? No normal case will cause that, and it means
that a PF_USER_WORKER thread could decide per-thread what it wants to
do wrt SIGKILL.

Christian? And I guess we should Cc: Oleg too, since the signal parts
are an area he's familiar with and has worked on.. Eric Biederman has
already been on the list and has also been involved

Oleg: see

  https://lore.kernel.org/lkml/122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.=
com/

for the context here.

              Linus
