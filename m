Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C846A88EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCBTEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBTEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:04:45 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333FD56536
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:04:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f13so1086459edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 11:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677783859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AnYuQNqFQzpvHhao5pD6YcV74LJjlnHRsuGa2HUaWQ=;
        b=SsugrDxTzxQaFR4GfzqNTP07kufWy48KpQ6Tgqx9YqxlSUMdjbwKXpsZfyQdfu19v7
         bLlUbt5oZ11YyQwxfAIPuCFCEcBAOdwB0hX8i282S4mGyermCha8uIDspd5yJEgf4sT7
         1BhWIOmng/AcxZVFVolW8cVBXu7aJI3tL4r6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677783859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AnYuQNqFQzpvHhao5pD6YcV74LJjlnHRsuGa2HUaWQ=;
        b=Wgm9/OWuwy0fLGy0a5gOLWPmp/tyYjjr9cO2FZZYfYK68GK/WiEvC+EOkLNealxJbU
         zFaMz8nflvUyONYn5sllL+xnFO97sP8lXWiljrrpkadODDJEj2AxALXsVoD/eMrV+fsm
         Y+ql9yTsf1h+wXMfTTO5Q2szY5hvFhNJkRnUWPJ75XgRdtkV89Pylvbha/nqzQ6t0AkQ
         NJUukYNPakiqkS/rRdnS3gek9Da4b07fiTJNjIM3VFbeOSyXtVt4V073jcDFNshCIXKG
         J/Wu9KsobQRXlpbf9W8gVfLlw0v4+nBa+MF7SHfVwSIfipNClJHo3PBVVSnLriNkXmMX
         LUFw==
X-Gm-Message-State: AO0yUKVS3RKCYsIrR4j6+A0X1SFwc2pnpKOnPcCxivQWdPUtohMutGDm
        SHzuZZl8mvSjKClT+NaoJzfzLf3qgRaCuVxwARg=
X-Google-Smtp-Source: AK7set/uTJcnM50cmdZv7Hjti585hDnAcABgr1JVRUXPWloHyocKIT9wvxg4NYyqz8F9WQmWy0FIfA==
X-Received: by 2002:a17:907:1deb:b0:7c0:e30a:d3e5 with SMTP id og43-20020a1709071deb00b007c0e30ad3e5mr11151919ejc.18.1677783859001;
        Thu, 02 Mar 2023 11:04:19 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709062f0a00b008d47cd2edfbsm20414eji.60.2023.03.02.11.04.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 11:04:17 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id s26so969509edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 11:04:16 -0800 (PST)
X-Received: by 2002:a50:aa94:0:b0:4c2:1a44:642e with SMTP id
 q20-20020a50aa94000000b004c21a44642emr1116225edc.5.1677783856044; Thu, 02 Mar
 2023 11:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
In-Reply-To: <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2023 11:03:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
Message-ID: <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 10:22=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Ops, I meant "names_cache", here:
>         names_cachep =3D kmem_cache_create_usercopy("names_cache", PATH_M=
AX, 0,
>                         SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL)=
;

That code just needs a __GFP_SKIP_ZERO.

It might be best if we actually exposed it as a SLAB_SKIP_ZERO thing,
just to make it possible to say - exactly in situations like this -
that this particular slab cache has no advantage from pre-zeroing.

This doesn't sound like a vfs issue, this is a hardening issue where
apparently people now use that INIT_ON_ALLOC_DEFAULT_ON in "real use"
and then you notice how horrid the performance impact can be.

But there might also be some possible interactions with KASAN etc.

Adding some hardening people to the cc.

           Linus
