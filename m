Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394C0720920
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjFBS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjFBS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:28:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280A0E4C;
        Fri,  2 Jun 2023 11:27:39 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39817f3e08eso1617303b6e.1;
        Fri, 02 Jun 2023 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685730458; x=1688322458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCpdjBkJUYgIy9lNltbYiGa3ZgStuC7RDZQxLOMxnlo=;
        b=Il2Q5vnEuOsVPn39znvA45ROyAzkapbksPf6Y4YCIcrxkofev6N1e6Esex7ub+8eHC
         4Q0PKtXWaY7Ui4KlAWPrBoqDO7G1JxOHAy3ZiL7nnVsCXVhl5rZ532vtPGvhy7bInST5
         dOupD8gMSF4cQ9CHL0PjeONm2DStZANIIQ/HxinhYDm55+dkSOfcGQPnQz4KjeKIDNPK
         cgQhkqJJxnKXoYHtsPH8ya1QT2Cw+Ifer9AaLesI99NWxiXxNyUKwKab2E8b+VNInVKQ
         Z2HHaXXWnyMk65a132dg0Pb5VL67/kjXvsNz859c/xrAxlIjgOFj5rP4f+C5B4r+Ovij
         ta6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685730458; x=1688322458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCpdjBkJUYgIy9lNltbYiGa3ZgStuC7RDZQxLOMxnlo=;
        b=MMMIRLoEhWGsG9QJuViKyCfandCNXbZWfPeZZgpYLYsELP5Ffq6n8kfuOLysngQlV2
         3rh3V79eaCuqU8BXlgrao+h+4/e754v2Mlv+kWOhkM/umQfIXBzIbobQfja8KZNzORJ2
         dPnbkJIyIGoU6eJcqcLt/V/0qxR6A/Wp2AcvijKkbXQMpgt2Fh8sEFHFmB7Q73BfG8fk
         mF0NTDCZBL5oQqB0FqEPmOfSdirxl0UpC0an9uuwbB24DBhiJi7bVuvGrN/0LDNH1G+E
         YS0rD6b+dJbFkk0nfc/ql/jiM7Tr4wbRvCPfF/oEJ0tkaqeyMhpdodP42S/Q1keNuSV1
         Gyjg==
X-Gm-Message-State: AC+VfDz4aPxC1bmQc5F6GK4SL93MPIxb1ju/fs6T0BAbVt24bhYQDI4k
        aIHU7ahq5PeP5Di54Rjhzgwo/5wEoSbIS9H+p5LRxraL
X-Google-Smtp-Source: ACHHUZ6ddlIl1+vBO8rCXN3FsE7YAPPqd/gZ7JG3nMzrTa+Henmjmwa66Dam8+jtNM3QCKQhQ94Yn+n8o9qtcuYzxUM=
X-Received: by 2002:a05:6808:15:b0:389:4f7b:949d with SMTP id
 u21-20020a056808001500b003894f7b949dmr707601oic.22.1685730458405; Fri, 02 Jun
 2023 11:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <ZHO4/Z+iO+lqV4rW@work> <202305301608.2982BD3CAF@keescook>
In-Reply-To: <202305301608.2982BD3CAF@keescook>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 2 Jun 2023 14:27:27 -0400
Message-ID: <CADnq5_O6fzoCOo5YEAEv=D8ComZaYShx5ot=TQBmdFf8ReEKrg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu/discovery: Replace fake flex-arrays with
 flexible-array members
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, May 30, 2023 at 7:08=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Sun, May 28, 2023 at 02:26:37PM -0600, Gustavo A. R. Silva wrote:
> > Zero-length and one-element arrays are deprecated, and we are moving
> > towards adopting C99 flexible-array members, instead.
> >
> > Use the DECLARE_FLEX_ARRAY() helper macro to transform zero-length
> > arrays in a union into flexible-array members. And replace a one-elemen=
t
> > array with a C99 flexible-array member.
> >
> > Address the following warnings found with GCC-13 and
> > -fstrict-flex-arrays=3D3 enabled:
> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1009:89: warning: array s=
ubscript kk is outside array bounds of =E2=80=98uint32_t[0]=E2=80=99 {aka =
=E2=80=98unsigned int[]=E2=80=99} [-Warray-bounds=3D]
> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1007:94: warning: array s=
ubscript kk is outside array bounds of =E2=80=98uint64_t[0]=E2=80=99 {aka =
=E2=80=98long long unsigned int[]=E2=80=99} [-Warray-bounds=3D]
> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1310:94: warning: array s=
ubscript k is outside array bounds of =E2=80=98uint64_t[0]=E2=80=99 {aka =
=E2=80=98long long unsigned int[]=E2=80=99} [-Warray-bounds=3D]
> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1309:57: warning: array s=
ubscript k is outside array bounds of =E2=80=98uint32_t[0]=E2=80=99 {aka =
=E2=80=98unsigned int[]=E2=80=99} [-Warray-bounds=3D]
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3D3 [1].
> >
> > This results in no differences in binary output.
> >
> > Link: https://github.com/KSPP/linux/issues/21
> > Link: https://github.com/KSPP/linux/issues/193
> > Link: https://github.com/KSPP/linux/issues/300
> > Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.htm=
l [1]
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
