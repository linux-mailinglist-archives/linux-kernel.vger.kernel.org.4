Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A920711ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbjEYXo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbjEYXo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:44:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7C134
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:44:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-253e0edc278so231362a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685058265; x=1687650265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MtMvxa1FpsMo6UflDdFy9L2eB9JlUp+OX5y/F4LoJec=;
        b=PYcX1uT4ItnzIsy9a8EPsZkhiE6xNnb/ETTCZZwtT0zpb0En/AlcmLBSIX07HQG+Yd
         KVhF0SwYRcOa0qxApFbKM82tOOTQxyuxJ12Xz1QoIQz+ZlQmv4gAu0gjZCGmwOLh5R5z
         D0MfuM55G4L8wVUfphDESGV6KuSJTjoH371Hm1rLCQvIbAPlWjADP1pRVZZsxp0eUd9A
         +bC8WzVFr0eJ60nXkcR71ndV0z+w4yVooQWa2DUMQ8Q4JGlVcgjoaJDw3Ik2YQarLEc6
         4TsVXZjYYJWX7Q+u/AqTcpZlBwrfMPtjC1VjapPvP8PGgKABVKn5/REIUDbqmbygDsLf
         cIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685058265; x=1687650265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtMvxa1FpsMo6UflDdFy9L2eB9JlUp+OX5y/F4LoJec=;
        b=gzzvw+Oz0VfaZQSdPjwA9cPbT91Fl/j5NDSkTFwUjpOz4gEkNZFuEJJgBFJ1MV81u8
         NdpmcmpGFd1lrOhkGIk6ZLqdQQbte/xPRpJp22sYqa1GGW8oEWNEIYmfN4KOMMwGj7oX
         FkYxJro0E99AbeMwMrRkzDVrHk/U7n7cAs8zov9vhPDQJ9pn8MppzHkNMUSZLg+rjX5P
         4F5wrHabe1Urdk1JUzJGryeCMJCUHqW4bNp3vCQLZt0mTfU9XpbpRGa7BGoTPJYWDEXz
         3yGNArndyq0ZfRk0BeIxtZkJJIHwqTwNpascl5vV7ZBDTGIiCQaukv5DQfIcK0C8Z2yS
         +jqA==
X-Gm-Message-State: AC+VfDwIjL4QhYAQf6YNcjWSQONX3mIiGnVfQfsahgAu9ciqbTWg9Ko5
        cyQQdW0y9hnrknOZAXbms5gu9fIBkOkAynKT7LlmYA==
X-Google-Smtp-Source: ACHHUZ7bZP9nM2sZgnTSqi06yVhQo9FeMemZO3V3CQ0NVKBD17oiTWY/6dynXofqoXWU8nyV/X8O4jJkVDs6U1blWcA=
X-Received: by 2002:a17:902:ba8d:b0:1af:d19a:a67b with SMTP id
 k13-20020a170902ba8d00b001afd19aa67bmr355608pls.33.1685058265086; Thu, 25 May
 2023 16:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230523090607.1433-1-masahisa.kojima@linaro.org>
 <CAFA6WYOOEwd=jWk1LEaj9K2GkjfV+kfPYOfwPkJVoWXJKGoQXA@mail.gmail.com>
 <CAC_iWjKxXrEgpqgnpt8g0ummdb1mFbwgMVTSVqfRTNbXOwhz2w@mail.gmail.com> <CAMj1kXGxTcsWxwKayf8YDy_iocPJu2reWgMBtRfs8ZNin4fPpg@mail.gmail.com>
In-Reply-To: <CAMj1kXGxTcsWxwKayf8YDy_iocPJu2reWgMBtRfs8ZNin4fPpg@mail.gmail.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Fri, 26 May 2023 08:44:14 +0900
Message-ID: <CADQ0-X8njokPZQn+4oJn10yTHqDCByTLGDL7Yvdw+rKGWVzJwg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] introduce tee-based EFI Runtime Variable Service
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, 26 May 2023 at 01:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 24 May 2023 at 10:01, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sumit,
> >
> > On Wed, 24 May 2023 at 10:56, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > On Tue, 23 May 2023 at 14:36, Masahisa Kojima
> > > <masahisa.kojima@linaro.org> wrote:
> > > >
> > > > This series introduces the tee based EFI Runtime Variable Service.
> > > >
> > > > The eMMC device is typically owned by the non-secure world(linux in
> > > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > > for EFI Variables, it is implemented by interacting with
> > > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > > and tee-supplicant. The last piece is the tee-based variable access
> > > > driver to interact with OP-TEE and StandaloneMM.
> > > >
> > > > Changelog:
> > > > v3 -> v4:
> > > > - replace the reference from EDK2 to PI Specification
> > > > - remove EDK2 source code reference comments
> > > > - prepare nonblocking variant of set_variable, it just returns
> > > >   EFI_UNSUPPORTED
> > > > - remove redundant buffer size check
> > > > - argument name change in mm_communicate
> > > > - function interface changes in setup_mm_hdr to remove (void **) cast
> > >
> > > I don't have detailed insights into how EFI spec mandates StandaloneMM
> > > should be implemented. But utilizing OP-TEE as the underlying
> > > transport here looks fine to me. FWIW,
> > >
> > > For the series:
> > > Acked-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > Thanks!
> >
> >  FWIW the PI spec describes some of the functionality and how that
> > should be accessed.
> > There's a EFI_MM_COMMUNICATION_PROTOCOL which is not used here.
> > Instead the entry point is via an SMC to op-tee and the payload
> > adheres to what the PI spec describes in its EFI_MM_COMMUNICATE_HEADER
> >
>
> Thanks for the resend
>
> Could you please double check whether this needs any changes in
> relation to this patch?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=d86ff3333cb1d5f4

I need to set a tee-based query_variable_info().
I will rebase to efi-next and send an updated version.

Thanks,
Masahisa Kojima
