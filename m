Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1BD6A8422
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCBO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCBO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:28:25 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD915573
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:28:24 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id b5so6822743iow.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xMPcWX9J82fx546/2/UxZ96PyLg7wpVPFiDqKOfZ5I=;
        b=jOnksMU1dAwsE3ClLTB+Su7tMpzibSIW2s5mk8JhpXwjpAGuf+ol/j0wDpAOgpI00D
         RJDsK6iqB2fblNnA2kwcG4VbYRLJe7eIma9voxpT5WWyJhNlqVF/hrbmgHIs0GmBEYse
         uTB0ZrozIke7tGkwFd8p103W1GuVQtmvVZwBCfU5371hanm78mjpsiFOBecBTs0JEvMF
         /7JvJGybKX9df0nqxtfbeAUUFvnNexvoFWksmdJlKuid/oTfQsHCnneBU5H6M1rKH8wI
         iASdynbwx2juptR2fyKyCcA4MLxXHIT19zrLvUI6I6LN4fw/Nur7W+kp5ODkAwUouHHl
         AGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xMPcWX9J82fx546/2/UxZ96PyLg7wpVPFiDqKOfZ5I=;
        b=f1QVfr7IHAB2YYeEtCJigqfA17PRoetZ7mtj07Jz1o5msqbR8+prNrqmXxt2NTL9D/
         wYHgcNZcttUOH/0AW59xlIuOR23/uktUO5WxA85JIgo28CiFJOYX+g0L6Nl6H/Pv5Zz0
         zdSM+4KWFeseoKEjog4BBg52fk27lp8dGYzJXqn6i+0U0Htw0DaevJ8wdnZuJUMF5oWQ
         OUNxSZjVpRBzoaZ7pH/gcDQCGNrrUm6tluTCyw8Q+wIcZ+n8zX2giIFI+/qfW1rDBWmt
         vnWiJL5hFWm51V1yNpYvRMB0niFQNrJNVZAo+tPJb4jvO8CKpc7ShgIYaSfpISoPqU2Q
         2Rtw==
X-Gm-Message-State: AO0yUKVNESaSO/YBkDDG67LfU/7oS4zOGff/BKp/UbzRM3YeFqIw1lfy
        Ap15Tjhi4UUHavZWXOnqM+gPGWF7N4qY+g3ufBmdPA==
X-Google-Smtp-Source: AK7set//gciEjOc7e7//kyU0zcBwX8c6ckX6I0Bc10xXTnFRq6UmSVxHBK5CCpixAHyAa5oOsh3vkJjUuyaod5TRtPA=
X-Received: by 2002:a6b:7c09:0:b0:745:6788:149f with SMTP id
 m9-20020a6b7c09000000b007456788149fmr4528404iok.0.1677767303478; Thu, 02 Mar
 2023 06:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com> <CANpmjNMR5ExTdo+EiLs=_b0M=SpN_gKAZTbSZmyfWFpBh4kN-w@mail.gmail.com>
In-Reply-To: <CANpmjNMR5ExTdo+EiLs=_b0M=SpN_gKAZTbSZmyfWFpBh4kN-w@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Mar 2023 15:27:47 +0100
Message-ID: <CAG_fn=U9H2bmUxkJA6vyD15j+=GJTkSgKuMRbd=CWVZsRwR7TQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: kmsan: Don't rename memintrinsics in
 uninstrumented files
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, kasan-dev@googlegroups.com,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 12:14=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Wed, 1 Mar 2023 at 15:39, Alexander Potapenko <glider@google.com> wrot=
e:
> >
> > KMSAN should be overriding calls to memset/memcpy/memmove and their
>
> You mean that the compiler will override calls?
> All supported compilers that have fsanitize=3Dkernel-memory replace
> memintrinsics with __msan_mem*() calls, right?

Right. Changed to:

KMSAN already replaces calls to to memset/memcpy/memmove and their
__builtin_ versions with __msan_memset/__msan_memcpy/__msan_memmove in
instrumented files, so there is no need to override them.


>
> > __builtin_ versions in instrumented files, so there is no need to
> > override them. In non-instrumented versions we are now required to
> > leave memset() and friends intact, so we cannot replace them with
> > __msan_XXX() functions.
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Other than that,
>
> Reviewed-by: Marco Elver <elver@google.com>
Thanks!
