Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2428740423
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjF0TxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjF0TxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:20 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817A82733
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:53:16 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-401f4408955so63261cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895595; x=1690487595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLuI5nD00PYdmR0TV738RD1rmcrLwafP6/VBiaRjU1Q=;
        b=cSzqkm1d1b4AFhkJhViS8sDaJIf+PxUmJXSE1RGhTP6iCCCv38N0BIynlZA09gF4vP
         CpD6cB948INT3shzg+B7IOADAv1mqcb/d284GyeFR7u9Nxq4fDQ/N55DBiaX1FAvlzfk
         Diqjm5prhKaUtRZovQzs1wF6v5Q6+/PTGp2bJ1qMeOcIgAPHCQA7qRmQdIafxnNqmWqw
         MmjY3XWZjlu7Udq8ZL4PTQmd0SnSMlK0whx7TLERo3Mx3XYKbbGU17QRSaLVpQvt3Swx
         Vpc3OrS2B1C1fo8P7o8jU3KS9Lj2Cj+HHmHBerMNwmv6JLhJCO1FQ9ZNhdOIV5ceoHUs
         sJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895595; x=1690487595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLuI5nD00PYdmR0TV738RD1rmcrLwafP6/VBiaRjU1Q=;
        b=OrntAA7hy5QobBzf9OChg/T/qt7rzdFBhpmYuDgCTkHinueLbeAgtQxlgIt+w4rS6z
         rm+ATv1FrrL99DHJvS0DWMlgd5pjD9M0SLMJxXGMKVNNxcniTCB6vnx/xuU7tgTbwph9
         gncYF0nrGpxqkIzKaoxkkso6DS7gRBC82ckp89RaOagEBkvYr20oTEVbUhD7UWSpXGQs
         8IlwnepMKXS8CJu75IKRRsOpWUBQHOUcqboVDPzepqcBURk0/eVmfqTwVdunPNi+iLph
         1z4O+AYxDP15Fi3lpQX5owNHKuWDQSI8B7WMgZoLD0shKWY+Nqu0QQ920gwnquendiYm
         a4WA==
X-Gm-Message-State: AC+VfDxVDbJwXbIaktYCdS4k3GwG33n0XBcVOA7w7LlyyIO42TqCbA7Q
        ZHYL/48eimF546y4gna6WkJm8QvTjABH2Ex0bOp6Qw==
X-Google-Smtp-Source: ACHHUZ4WywyCYGtPMuvdFcpW2dqCRu0tWKd63P8E6CytwoFeUoTgkNgf73pWryoHaPsc+KPEWJlGKZA+hMjAqZ0nE+U=
X-Received: by 2002:a05:622a:285:b0:3f8:175a:4970 with SMTP id
 z5-20020a05622a028500b003f8175a4970mr37184qtw.18.1687895595463; Tue, 27 Jun
 2023 12:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230624002708.1907962-1-maskray@google.com> <ff7c875a-8893-9b7d-e2fa-200f1601e666@meta.com>
 <CAM9d7cjyKmKk+z1z8qatjaC7xwwJa_PFE0DJzJ=_mFjS6taz_A@mail.gmail.com>
In-Reply-To: <CAM9d7cjyKmKk+z1z8qatjaC7xwwJa_PFE0DJzJ=_mFjS6taz_A@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Tue, 27 Jun 2023 12:53:04 -0700
Message-ID: <CAFP8O3L_fGJWAcNEhFGBZF4mRi6ObOyupto5o4z80Zaa3x7PDw@mail.gmail.com>
Subject: Re: [PATCH] perf: Replace deprecated -target with --target= for Clang
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:29=E2=80=AFPM Namhyung Kim <namhyung@gmail.com> =
wrote:
>
> Hi Fangui and Yonghong,
>
> On Sun, Jun 25, 2023 at 11:25=E2=80=AFAM Yonghong Song <yhs@meta.com> wro=
te:
> >
> >
> >
> > On 6/23/23 5:27 PM, Fangrui Song wrote:
> > > -target has been deprecated since Clang 3.4 in 2013. Use the preferre=
d
> > > --target=3Dbpf form instead. This matches how we use --target=3D in
> > > scripts/Makefile.clang.
> > >
> > > Link: https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de=
0a68135afc7f95def6277
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
>
> After 10 years of deprecation, time to change. :)
>
> Applied to perf-tools-next, thanks!

Thank you!


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
