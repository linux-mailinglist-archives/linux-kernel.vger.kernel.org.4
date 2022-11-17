Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7970C62DF84
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiKQPVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbiKQPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:20:10 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F66781AA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:15:21 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i5so1030376ilc.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0mda3tRJT+iEZZZtBKUMBVJCht+1W2dmNcWwzB9SAAk=;
        b=enDxqfxXT+UPRRkUoQ0pVpD4o1W5OZKMjO8TbYuZUg/EpmK5WvwM+tyhjnAfthIuWA
         P1j//kNZxtlDxkx1Ioxdba0X6zL6huywLOEp9wSSg0WWthpiEWIZElc0JsinjKRrMbeo
         hdAvB7d/tZJAv25MpanKHPy42mT2MjorJ44DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mda3tRJT+iEZZZtBKUMBVJCht+1W2dmNcWwzB9SAAk=;
        b=kZghLsOkQFxuk1ElCsmwsJ7ZKtj3z1C7SlCyOj9iz4mSjU3XmMB3e5Vb5Dx7O2YDKJ
         2MuUG5lH8PrMmAWAZVfAOBBb1uHjAgoFVXKLcQoQDIldYP4ibO9WBRlNALtwx25R/7of
         PNJ6wcbl8NpaSq2tht5i7U2Y5jkdRxVt/22fFYGvEMlInLgO6NAOg8AiAKUTOV0/UBiZ
         DXIfKLqDARCT9A1MmECDv8PRZnPggvxRfhAlb6dUdVI8C6vkHAethLdw9A0bzn8iVbAD
         ncitV27KgNFdqaqipAn4yVEMP3thUXaL61eC4Q4F9IEZMO8aoKEV6g9cuwlk467rrvpC
         xjPA==
X-Gm-Message-State: ANoB5pku1nYJgQCjySDCXv5vjF4SYKkjzGYZ4tzOGkaCLObYAvPWJf/v
        QKjp02I4rEHq0eaGt9lnnzKOR6aHgR5KUw==
X-Google-Smtp-Source: AA0mqf4KCpd6BPtrMkdZ+o4Dx19zbm/enXZC9c+HlQXDF9+37s5TN89uGT+TQYNctryKVFMCj/oCmQ==
X-Received: by 2002:a92:d03:0:b0:302:988e:4ea7 with SMTP id 3-20020a920d03000000b00302988e4ea7mr1349452iln.224.1668698120555;
        Thu, 17 Nov 2022 07:15:20 -0800 (PST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id o7-20020a056e02092700b003027f923d29sm417215ilt.39.2022.11.17.07.15.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 07:15:19 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id q21so1570404iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:15:18 -0800 (PST)
X-Received: by 2002:a02:c897:0:b0:374:100a:b0c7 with SMTP id
 m23-20020a02c897000000b00374100ab0c7mr1243939jao.185.1668698118410; Thu, 17
 Nov 2022 07:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
 <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org> <20221117160650.16e06b37@rotkaeppchen>
In-Reply-To: <20221117160650.16e06b37@rotkaeppchen>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 17 Nov 2022 16:15:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
Message-ID: <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp

Thanks for your review!

On Thu, 17 Nov 2022 at 16:07, Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi Ricardo,
>
> all in all I think this patch makes sense. However, there is one point
> I don't like...
>
> On Mon, 14 Nov 2022 14:18:39 +0100
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > Create a new toogle that disables LINUX_REBOOT_CMD_KEXEC, reducing the
> > attack surface to a system.
> >
> > Without this toogle, an attacker can only reboot into a different kernel
> > if they can create a panic().
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > index 97394bd9d065..25d019682d33 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -462,6 +462,17 @@ altered.
> >  Generally used together with the `modules_disabled`_ sysctl.
> >
> >
> > +kexec_reboot_disabled
> > +=====================
> > +
> > +A toggle indicating if ``LINUX_REBOOT_CMD_KEXEC`` has been disabled.
> > +This value defaults to 0 (false: ``LINUX_REBOOT_CMD_KEXEC`` enabled),
> > +but can be set to 1 (true: ``LINUX_REBOOT_CMD_KEXEC`` disabled).
> > +Once true, kexec can no longer be used for reboot and the toggle
> > +cannot be set back to false.
> > +This toggle does not affect the use of kexec during a crash.
> > +
> > +
> >  kptr_restrict
> >  =============
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 41a686996aaa..15c3fad8918b 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -407,6 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
> >  extern struct kimage *kexec_image;
> >  extern struct kimage *kexec_crash_image;
> >  extern int kexec_load_disabled;
> > +extern int kexec_reboot_disabled;
> >
> >  #ifndef kexec_flush_icache_page
> >  #define kexec_flush_icache_page(page)
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index cb8e6e6f983c..43063f803d81 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -196,6 +196,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
> >       if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> >               return -EPERM;
> >
> > +     /* Check if the system admin has disabled kexec reboot. */
> > +     if (!(flags & KEXEC_ON_CRASH) && kexec_reboot_disabled)
> > +             return -EPERM;
>
> ... Allowing to load a crashkernel doesn't make sense in my opinion. If
> an attacker is capable of creating a malicious kernel, planting it on
> the victims system and then find a way to boot it via kexec this
> attacker also knows how to load the malicious kernel as crashkernel and
> trigger a panic. So you haven't really gained anything. That's why I
> would simply drop this hunk (and the corresponding one from
> kexec_file_load) and let users who worry about this use a combination of
> kexec_load_disabled and kexec_reboot_disabled.

If for whatever reason your sysadmin configured kexec_reboot_disabed
it can be nice that when a user try to load it they get a warning.
It is easier to debug than waiting two steps later when they run kexec -e....

That is why I added it. But i am also ok removing it

>
> Thanks
> Philipp
>
> > +
> >       /* Permit LSMs and IMA to fail the kexec */
> >       result = security_kernel_load_data(LOADING_KEXEC_IMAGE, false);
> >       if (result < 0)
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index ca2743f9c634..fe82e2525705 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -929,6 +929,7 @@ int kimage_load_segment(struct kimage *image,
> >  struct kimage *kexec_image;
> >  struct kimage *kexec_crash_image;
> >  int kexec_load_disabled;
> > +int kexec_reboot_disabled;
> >  #ifdef CONFIG_SYSCTL
> >  static struct ctl_table kexec_core_sysctls[] = {
> >       {
> > @@ -941,6 +942,16 @@ static struct ctl_table kexec_core_sysctls[] = {
> >               .extra1         = SYSCTL_ONE,
> >               .extra2         = SYSCTL_ONE,
> >       },
> > +     {
> > +             .procname       = "kexec_reboot_disabled",
> > +             .data           = &kexec_reboot_disabled,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             /* only handle a transition from default "0" to "1" */
> > +             .proc_handler   = proc_dointvec_minmax,
> > +             .extra1         = SYSCTL_ONE,
> > +             .extra2         = SYSCTL_ONE,
> > +     },
> >       { }
> >  };
> >
> > @@ -1138,7 +1149,7 @@ int kernel_kexec(void)
> >
> >       if (!kexec_trylock())
> >               return -EBUSY;
> > -     if (!kexec_image) {
> > +     if (!kexec_image || kexec_reboot_disabled) {
> >               error = -EINVAL;
> >               goto Unlock;
> >       }
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 45637511e0de..583fba6de5cb 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -333,6 +333,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >       if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> >               return -EPERM;
> >
> > +     /* Check if the system admin has disabled kexec reboot. */
> > +     if (!(flags & (KEXEC_FILE_ON_CRASH | KEXEC_FILE_UNLOAD))
> > +         && kexec_reboot_disabled)
> > +             return -EPERM;
> > +
> >       /* Make sure we have a legal set of flags */
> >       if (flags != (flags & KEXEC_FILE_FLAGS))
> >               return -EINVAL;
> >
>


-- 
Ricardo Ribalda
