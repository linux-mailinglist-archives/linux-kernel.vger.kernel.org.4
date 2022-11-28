Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A855E63A03B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiK1DxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK1DxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:53:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28738AD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:53:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso5464749pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF1ge54xIUAlHX2n++cnMUpCa6Myhy4vGKBhQP7XRwo=;
        b=N51njAkDPRiOvWBJH4TPhl1rnQ6neieaIE+cew6kxfjHluLG7+EMzZzDDNtTGHGfcr
         9Jh+WxwP+N6kB6VIS4R/KwFFzt27vDQqypOd82UiEGdu3TTVPNnwVnZT3IiVj+invY6y
         GOceA9n6zIdpWzkbEnTXm042AyYYqbOcpmi0bdUm/9a/utH74s4zfLeHQ/6E6KLc1DPy
         207LZrRBpbu8OgbNts8XwsW6qA/VDzRJzxujROxsnnrEijRJs1LLROke2qhcmzjv7VtZ
         u9/5RbH9FYjOj0rt1ELKI5XOdV6/DtLhAJsGKN3qUfuHWkC5JEN3E/Y7OrIbilp0wjRn
         cFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UF1ge54xIUAlHX2n++cnMUpCa6Myhy4vGKBhQP7XRwo=;
        b=ipkKTBZDxVCCPleafBjKxWvBX/Q4svkQxT6bljbnYblt1alOc6HvTFoMGKYquWoZ+s
         Iu+NOZfglDl7Y77fhnK3YDnvUCpxbqlcAuaszEkESqSSQr0/6oWB8qf7/DW+uZ9zm/FY
         +mdeOI8eBbd7LquZ3+/C7gTghjfkvKauEup3ipABnzDWijJtpDDivyTTxwaPW2uXpSRf
         RR2ajCwTshUHTkt9LyPRoAPis1qgvc7hQaw03Knxwk2ilj8y+QxKDH1mFUafpH1vje4h
         gloP53Pg4j6SNihuWhgDNr767imF1yP23binw8NP6qnrJ4JQyHBI/6BtLwXdfTtRWfT9
         Hbww==
X-Gm-Message-State: ANoB5pmcR1Ql4vFEv9QIMOE5LuYwbCtvuPvJV+cUKykplCBC2Us/02s6
        pZP0x0PkCPxpQsT91AtfE6OiSTUEEHOH0gOdsxEv
X-Google-Smtp-Source: AA0mqf7wQ2Uzn8UK+DPd4zA53So8KNWWgBEQFu8jmGln9wvg2shTpNANXvScuOP43LvWLdpGWPhbL0yBMvrh277NzsY=
X-Received: by 2002:a17:902:9892:b0:186:c3b2:56d1 with SMTP id
 s18-20020a170902989200b00186c3b256d1mr30991891plp.15.1669607583130; Sun, 27
 Nov 2022 19:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20221123201552.7865-1-casey@schaufler-ca.com> <20221123201552.7865-2-casey@schaufler-ca.com>
 <94ac3c49-550b-c517-680f-ba653d568f72@digikod.net>
In-Reply-To: <94ac3c49-550b-c517-680f-ba653d568f72@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 27 Nov 2022 22:52:52 -0500
Message-ID: <CAHC9VhSza-P0hG_iSdW8MCAKaykUW5eLBkpg=bb4-D_=7-j3+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] LSM: Identify modules by more than name
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:30 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> On 23/11/2022 21:15, Casey Schaufler wrote:
> > Create a struct lsm_id to contain identifying information
> > about Linux Security Modules (LSMs). At inception this contains
> > the name of the module and an identifier associated with the
> > security module. Change the security_add_hooks() interface to
> > use this structure. Change the individual modules to maintain
> > their own struct lsm_id and pass it to security_add_hooks().
> >
> > The values are for LSM identifiers are defined in a new UAPI
> > header file linux/lsm.h. Each existing LSM has been updated to
> > include it's LSMID in the lsm_id.
> >
> > The LSM ID values are sequential, with the oldest module
> > LSM_ID_CAPABILITY being the lowest value and the existing modules
> > numbered in the order they were included in the main line kernel.
> > This is an arbitrary convention for assigning the values, but
> > none better presents itself. The value 0 is defined as being invalid.
> > The values 1-99 are reserved for any special case uses which may
> > arise in the future.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >   include/linux/lsm_hooks.h    | 16 ++++++++++++++--
> >   include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
> >   security/apparmor/lsm.c      |  8 +++++++-
> >   security/bpf/hooks.c         | 13 ++++++++++++-
> >   security/commoncap.c         |  8 +++++++-
> >   security/landlock/cred.c     |  2 +-
> >   security/landlock/fs.c       |  2 +-
> >   security/landlock/ptrace.c   |  2 +-
> >   security/landlock/setup.c    |  6 ++++++
> >   security/landlock/setup.h    |  1 +
> >   security/loadpin/loadpin.c   |  9 ++++++++-
> >   security/lockdown/lockdown.c |  8 +++++++-
> >   security/safesetid/lsm.c     |  9 ++++++++-
> >   security/security.c          | 12 ++++++------
> >   security/selinux/hooks.c     |  9 ++++++++-
> >   security/smack/smack_lsm.c   |  8 +++++++-
> >   security/tomoyo/tomoyo.c     |  9 ++++++++-
> >   security/yama/yama_lsm.c     |  8 +++++++-
> >   18 files changed, 141 insertions(+), 21 deletions(-)
> >   create mode 100644 include/uapi/linux/lsm.h

...

> > diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> > new file mode 100644
> > index 000000000000..47791c330cbf
> > --- /dev/null
> > +++ b/include/uapi/linux/lsm.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Linux Security Modules (LSM) - User space API
> > + *
> > + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> > + * Copyright (C) 2022 Intel Corporation
> > + */
> > +
> > +#ifndef _UAPI_LINUX_LSM_H
> > +#define _UAPI_LINUX_LSM_H
> > +
> > +/*
> > + * ID values to identify security modules.
> > + * A system may use more than one security module.
> > + *
> > + * Values 1-99 are reserved for future use in special cases.
>
> This line should be removed unless justified. What could be special
> about IDs? The syscalls already have a "flags" argument, which is enough.
>
> > + */
> > +#define LSM_ID_INVALID               0
>
> Reserving 0 is good, but it doesn't deserve a dedicated declaration.
> LSM_ID_INVALID should be removed.
>
>
> > +#define LSM_ID_CAPABILITY    100
>
> This should be 1=E2=80=A6

No.  Scratch that, make that an emphatic "No".

If you want to argue for a different reserved low-number range, e.g.
something with a nice power-of-2 limit, I'm okay with that, but as I
wrote earlier I feel strongly we need to have a low-number reserved
range for potential future uses.

--=20
paul-moore.com
