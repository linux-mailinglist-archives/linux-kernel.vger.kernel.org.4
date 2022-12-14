Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEF464D37B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLNXeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNXdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:33:40 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B01146
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:32:54 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id v3so3056958pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX38wRipK6YZXjwZPd7Su4K9Er1H54jvjyAx9rqRw1Q=;
        b=PDEg3nH3xgHnheIK+JiFoLehsOV0gTUq21j4kLrRR1ZLvl25FbD7m8LX1fSIYwz/87
         PIxzI5e9Pfn8V6aq1oOKcTbffZGDbFjXTXJhyLPaPkgFnINJjvhacuxaIOC1x6UwmVsZ
         d3iVOkBRfgId+oB/p//Pexfh3cuN+6pDvx6QMWBzGeykcVt02UbhvWYbj5G/9VF1Mrgi
         SOuvClJPMP6WbasvMUuLP1kVi84M3frkmNzV0VYdxvfWNm8RJXyMUXR2L9ZznH7S//1F
         vMvSYMesxZ8hHbbrwxzlnOR/mS/6Ywx+ti6WoVXe+D/TlHqjypG2vGA+5YOFEjXALgM4
         JWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX38wRipK6YZXjwZPd7Su4K9Er1H54jvjyAx9rqRw1Q=;
        b=ACZCFS+0CKXOBBv6B1Ozd2h0rcnMB6j/5tLxZw3Hcerso3dLINor49mM3fKgWqVu1b
         T+p8xBjb4VE6BX/FkASXbLP3LuC20CdEFkEZYgLmLAM+3yd5pe2IfiCCwYfWcTYuwvyI
         +88d1SDWYxWSjFBpChmM72M7y9wRZytpx351dixP+ezMwVslnTIWL6tFSKxAQq0x8Mbl
         EKIBcLyOLaxTILjQPVsvKzgOKEhCvNwseMQR5tFoAxLqIvzUVPMur4sxImzlPQZCzHTv
         WH5sn+nJT1FS6gndwNzIPRMwaT5XHDHnr4z1vmQBHtH5ZjUceoSWvBK2lOI1fzwY7lsS
         ICXw==
X-Gm-Message-State: ANoB5pmvMxNtEOgaAWazY93N/t7wiJB1qJ+FD4WDl22DV7EGYUQHkUf0
        /TOcZDsDCR1Dh9Dm7OacQDLDTZqB3KX9pzxzp7dCQw==
X-Google-Smtp-Source: AA0mqf6FrLS1D7V7SRNCy3k8CyVO9nDpptYhTX527VVCoLeeGz/DIxUaHIqaRhNRIJVDOOmwzpQTEeBAzUWYmJerZnw=
X-Received: by 2002:a63:f04d:0:b0:470:5d17:a62e with SMTP id
 s13-20020a63f04d000000b004705d17a62emr68719053pgj.620.1671060773915; Wed, 14
 Dec 2022 15:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <202212141053.7F5D1F6@keescook>
In-Reply-To: <202212141053.7F5D1F6@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 14 Dec 2022 15:32:16 -0800
Message-ID: <CALmYWFss4hGOgJaeah8p7q86xmE7AOwOazxggGCuY=A+ZUVWhQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:54 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Dec 09, 2022 at 04:04:47PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Since Linux introduced the memfd feature, memfd have always had their
> > execute bit set, and the memfd_create() syscall doesn't allow setting
> > it differently.
> >
> > However, in a secure by default system, such as ChromeOS, (where all
> > executables should come from the rootfs, which is protected by Verified
> > boot), this executable nature of memfd opens a door for NoExec bypass
> > and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug =
[1]: cros_vm
> > process created a memfd to share the content with an external process,
> > however the memfd is overwritten and used for executing arbitrary code
> > and root escalation. [2] lists more VRP in this kind.
> >
> > On the other hand, executable memfd has its legit use, runc uses memfd=
=E2=80=99s
> > seal and executable feature to copy the contents of the binary then
> > execute them, for such system, we need a solution to differentiate runc=
's
> > use of  executable memfds and an attacker's [3].
> >
> > To address those above, this set of patches add following:
> > 1> Let memfd_create() set X bit at creation time.
> > 2> Let memfd to be sealed for modifying X bit.
> > 3> A new pid namespace sysctl: vm.memfd_noexec to control the behavior =
of
> >    X bit.For example, if a container has vm.memfd_noexec=3D2, then
> >    memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> > 4> A new security hook in memfd_create(). This make it possible to a ne=
w
> > LSM, which rejects or allows executable memfd based on its security pol=
icy.
>
> I think patch 1-5 look good to land. The LSM hook seems separable, and
> could continue on its own. Thoughts?
>
Agreed.

> (Which tree should memfd change go through?)
>
I'm not sure, is there a recommendation ?

Thanks.
Jeff

> -Kees
>
> --
> Kees Cook
