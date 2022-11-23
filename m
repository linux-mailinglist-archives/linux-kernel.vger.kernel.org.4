Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC06353CF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiKWI6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiKWI6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:58:25 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C375EC7BF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:58:23 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d12so259060ilv.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RIByAvzTpWTfKPQ5ysGNwwFAiPYN+RCVA5NjkuuWc2Q=;
        b=G9Q9zGhnDUmT+5CDQKFEt0UxAEGqBXGpnoZP1YPcaaXGl8R/o4BDpTAp042600L285
         ci6oLJ/Car9Bf7J2ZlAbggrwWr1h2sjrivIXRgssFRmqnJMOV7W3Ond5Xpxmu18aaBbQ
         369AbgUAPjKzY3IeoCDywLPpPDWlBoR6iC/VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIByAvzTpWTfKPQ5ysGNwwFAiPYN+RCVA5NjkuuWc2Q=;
        b=f2HjUNqQ1JOvsGNTPa0bfdNlTDsyYofAPHkTx6GpBkJf/T0YmOCVtBqrG06POX4MEo
         pbiR09/xSRUGNWsLF3OoUJ5ZBr9Iz3NyxWmvHuKLlOCMkn6PgT0Ni2wvuBaZooDVnH5o
         Ci0GMhI5SM4uE2shS0+G6M27gwHNceTDdlWbyVOycDhfyr3sriEaLqr1xohSKxL1dO8V
         /ZrAiCqRl6xJ5KBGCPxaLNPL2MDfmTFE0K3TaFJoTB/zzMyafmuZgNJJk4wSbdMOsZKR
         o7YEaaUJWdpxfqRmRYprVxT2yv+0XnrJ8dGsvcG8Qws7XSmQ5685fzh7n7/phhlVXa3T
         spYg==
X-Gm-Message-State: ANoB5plZ3JqTt/qJ/nd/iQETY7JLsygVEHoYiOWYsKgc4L+fnp+x2i3m
        iKHcE6XLIKHYjGI6kqBxvmX6vh191h2llA==
X-Google-Smtp-Source: AA0mqf5vw549QDBxJ1o9BmcXBbDqdiq9Hzf18yNMkQR3Rai7nBxgmTZGquPlu3/roKBmEnzp8Hr74g==
X-Received: by 2002:a05:6e02:12c2:b0:302:e38e:761b with SMTP id i2-20020a056e0212c200b00302e38e761bmr392411ilm.61.1669193902491;
        Wed, 23 Nov 2022 00:58:22 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id a11-20020a92d10b000000b002ff36cb0a62sm5588093ilb.27.2022.11.23.00.58.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:58:20 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id c7so12690741iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:58:19 -0800 (PST)
X-Received: by 2002:a05:6602:4011:b0:6de:a999:203b with SMTP id
 bk17-20020a056602401100b006dea999203bmr8655222iob.144.1669193899391; Wed, 23
 Nov 2022 00:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
 <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
 <20221117160650.16e06b37@rotkaeppchen> <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
 <20221121150948.6f7c1f1f@rotkaeppchen>
In-Reply-To: <20221121150948.6f7c1f1f@rotkaeppchen>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 23 Nov 2022 09:58:08 +0100
X-Gmail-Original-Message-ID: <CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
Message-ID: <CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp

Thanks for your review.

My scenario is a trusted system, where even if you are root, your
access to the system is very limited.

Let's assume LOADPIN and verity are enabled.

On Mon, 21 Nov 2022 at 15:10, Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi Ricardo,
>
> On Thu, 17 Nov 2022 16:15:07 +0100
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > Hi Philipp
> >
> > Thanks for your review!
>
> happy to help.
>
> >
> > On Thu, 17 Nov 2022 at 16:07, Philipp Rudo <prudo@redhat.com> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > all in all I think this patch makes sense. However, there is one point
> > > I don't like...
> > >
> > > On Mon, 14 Nov 2022 14:18:39 +0100
> > > Ricardo Ribalda <ribalda@chromium.org> wrote:
> > >
> > > > Create a new toogle that disables LINUX_REBOOT_CMD_KEXEC, reducing the
> > > > attack surface to a system.
> > > >
> > > > Without this toogle, an attacker can only reboot into a different kernel
> > > > if they can create a panic().
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > >
> > > > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > > > index 97394bd9d065..25d019682d33 100644
> > > > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > > > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > > > @@ -462,6 +462,17 @@ altered.
> > > >  Generally used together with the `modules_disabled`_ sysctl.
> > > >
> > > >
> > > > +kexec_reboot_disabled
> > > > +=====================
> > > > +
> > > > +A toggle indicating if ``LINUX_REBOOT_CMD_KEXEC`` has been disabled.
> > > > +This value defaults to 0 (false: ``LINUX_REBOOT_CMD_KEXEC`` enabled),
> > > > +but can be set to 1 (true: ``LINUX_REBOOT_CMD_KEXEC`` disabled).
> > > > +Once true, kexec can no longer be used for reboot and the toggle
> > > > +cannot be set back to false.
> > > > +This toggle does not affect the use of kexec during a crash.
> > > > +
> > > > +
> > > >  kptr_restrict
> > > >  =============
> > > >
> > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > index 41a686996aaa..15c3fad8918b 100644
> > > > --- a/include/linux/kexec.h
> > > > +++ b/include/linux/kexec.h
> > > > @@ -407,6 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
> > > >  extern struct kimage *kexec_image;
> > > >  extern struct kimage *kexec_crash_image;
> > > >  extern int kexec_load_disabled;
> > > > +extern int kexec_reboot_disabled;
> > > >
> > > >  #ifndef kexec_flush_icache_page
> > > >  #define kexec_flush_icache_page(page)
> > > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > > index cb8e6e6f983c..43063f803d81 100644
> > > > --- a/kernel/kexec.c
> > > > +++ b/kernel/kexec.c
> > > > @@ -196,6 +196,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
> > > >       if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> > > >               return -EPERM;
> > > >
> > > > +     /* Check if the system admin has disabled kexec reboot. */
> > > > +     if (!(flags & KEXEC_ON_CRASH) && kexec_reboot_disabled)
> > > > +             return -EPERM;
> > >
> > > ... Allowing to load a crashkernel doesn't make sense in my opinion. If
> > > an attacker is capable of creating a malicious kernel, planting it on
> > > the victims system and then find a way to boot it via kexec this
> > > attacker also knows how to load the malicious kernel as crashkernel and
> > > trigger a panic. So you haven't really gained anything. That's why I
> > > would simply drop this hunk (and the corresponding one from
> > > kexec_file_load) and let users who worry about this use a combination of
> > > kexec_load_disabled and kexec_reboot_disabled.
> >
> > If for whatever reason your sysadmin configured kexec_reboot_disabed
> > it can be nice that when a user try to load it they get a warning.
> > It is easier to debug than waiting two steps later when they run kexec -e....
>
> I'm having second thoughts about this patch. My main problem is that I
> don't see a real use case where kexec_reboot_disabled is advantageous
> over kexec_load_disabled. The point is that disabling
> LINUX_REBOOT_CMD_KEXEC is almost identical to toggling kexec_load_disabled without
> a loaded kernel (when you don't have a kernel loaded you cannot reboot
> into it). With this the main use case of kexec_reboot_disabled is
> already covered by kexec_load_disabled.

>
> However, there are two differences
>
> 1) with kexec_reboot_disable you can still (re-)load a crash kernel
> e.g. to update the initramfs after a config change. But as discussed in
> my first mail this comes on the cost that an attacker could still load a
> malicious crash kernel and then 'panic into it'.

That crash kernel must be already in the signed malicious kernel.
which reduces the chances of attack.
Plus an attacker must be able to panic the current kernel at will,
instead of just call reset.

>
> 2) kexec_load_disabled also prevents unloading of a loaded kernel. So
> once loaded kexec_load_disabled cannot prevent the reboot into this
> kernel.
>
>
> For 1) I doubt that this is desired at all. My expectation is that on
> systems where a sysadmin restricts a user to reboot via kexec the
> sysadmin also wants to prevent the user to load an arbitrary crash
> kernel. Especially as this still keeps the loophole open you are trying
> to close.
>
> So only 2) is left as real benefit. But that is an extremely specific
> scenario. How often does this scenario happen in real life? What
> problem does kexec_reboot_disable solve different implementation
> (also in userspace) cannot?
>
> Sorry about being this pedantic but you want to introduce some new uapi
> which will be hard if not impossible to change once introduced. That's
> why I want to be a 100% sure it is really needed.

No worries. Completely understand :). Thanks for taking this seriously..


Best regards!
>
> Thanks
> Philipp
>
>
> > That is why I added it. But i am also ok removing it
> >
> > >
> > > Thanks
> > > Philipp
> > >
> > > > +
> > > >       /* Permit LSMs and IMA to fail the kexec */
> > > >       result = security_kernel_load_data(LOADING_KEXEC_IMAGE, false);
> > > >       if (result < 0)
> > > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > > index ca2743f9c634..fe82e2525705 100644
> > > > --- a/kernel/kexec_core.c
> > > > +++ b/kernel/kexec_core.c
> > > > @@ -929,6 +929,7 @@ int kimage_load_segment(struct kimage *image,
> > > >  struct kimage *kexec_image;
> > > >  struct kimage *kexec_crash_image;
> > > >  int kexec_load_disabled;
> > > > +int kexec_reboot_disabled;
> > > >  #ifdef CONFIG_SYSCTL
> > > >  static struct ctl_table kexec_core_sysctls[] = {
> > > >       {
> > > > @@ -941,6 +942,16 @@ static struct ctl_table kexec_core_sysctls[] = {
> > > >               .extra1         = SYSCTL_ONE,
> > > >               .extra2         = SYSCTL_ONE,
> > > >       },
> > > > +     {
> > > > +             .procname       = "kexec_reboot_disabled",
> > > > +             .data           = &kexec_reboot_disabled,
> > > > +             .maxlen         = sizeof(int),
> > > > +             .mode           = 0644,
> > > > +             /* only handle a transition from default "0" to "1" */
> > > > +             .proc_handler   = proc_dointvec_minmax,
> > > > +             .extra1         = SYSCTL_ONE,
> > > > +             .extra2         = SYSCTL_ONE,
> > > > +     },
> > > >       { }
> > > >  };
> > > >
> > > > @@ -1138,7 +1149,7 @@ int kernel_kexec(void)
> > > >
> > > >       if (!kexec_trylock())
> > > >               return -EBUSY;
> > > > -     if (!kexec_image) {
> > > > +     if (!kexec_image || kexec_reboot_disabled) {
> > > >               error = -EINVAL;
> > > >               goto Unlock;
> > > >       }
> > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > index 45637511e0de..583fba6de5cb 100644
> > > > --- a/kernel/kexec_file.c
> > > > +++ b/kernel/kexec_file.c
> > > > @@ -333,6 +333,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > >       if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> > > >               return -EPERM;
> > > >
> > > > +     /* Check if the system admin has disabled kexec reboot. */
> > > > +     if (!(flags & (KEXEC_FILE_ON_CRASH | KEXEC_FILE_UNLOAD))
> > > > +         && kexec_reboot_disabled)
> > > > +             return -EPERM;
> > > > +
> > > >       /* Make sure we have a legal set of flags */
> > > >       if (flags != (flags & KEXEC_FILE_FLAGS))
> > > >               return -EINVAL;
> > > >
> > >
> >
> >
>


-- 
Ricardo Ribalda
