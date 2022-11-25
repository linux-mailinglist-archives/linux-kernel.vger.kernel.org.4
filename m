Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592F6638471
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKYH0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKYH0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:26:30 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C552DAA8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:26:28 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 11so2570609iou.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xOXk4lCUYoouX6nn+zvnuXLeTTpo+x2XXG4tCRFIhrI=;
        b=DbIYC1nPguo/cUcch+jXoQcvwzlVhAWy29HS8t2wtdWwaZS646cbgwpEcGlmH0900S
         GtKKwl+4q5e2/JBjxgwCaXYoC82xNmS8Qfox+YuX+khFuWAhlBxPp8W1q0YWfPvK+wbp
         0R032MmrmsrdmA4QJryqPXJKS+7+Vgxyk09E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOXk4lCUYoouX6nn+zvnuXLeTTpo+x2XXG4tCRFIhrI=;
        b=xfqTCZcergWDF2vBrbq7ajiSM7ce1L5dj7oeeSCiNb9UnmgYr4f7fGDIWa3ht3RiRz
         C/+ak6yX2itWOUeAdxwE+ksU/B8uNIWSuDDYHl62+yeLBsuTcMcO80N8Bn333X00FdOn
         EJja7OVlJyM06doRl06ygx2ZlmyQMMIhg3yHnZagpSGM3fpNpGcQN9q74rqpM9e5KYYS
         Ky/2DGSnHQYMkREP0lMQKg3ka3E7m0ratgTTK0sMaduQfjI8RKOoy0iHvzQW+b2n0ObC
         R1aCAsVaIcJ8/01tB0qJ2fgtbLV0mRReOKi7N1hM06AH0Uo7MMa2Uzm2/TtrG3DwrqpJ
         SHhg==
X-Gm-Message-State: ANoB5plRDhHJ4z7yuQ7e7hWKeIeEriAENoYoj8dNU+J7DaMXcWzibLqX
        BH586HR66kSk3dBEuAw9k4l0T4soE0R6Ujov
X-Google-Smtp-Source: AA0mqf5bSLbn+zTppWXvhQXKUEs0YHu1dGDMO39G5I8V867vfif/2QOpdUYXxdc//Vb6PHYapdfneA==
X-Received: by 2002:a6b:4409:0:b0:6de:bd7d:ee08 with SMTP id r9-20020a6b4409000000b006debd7dee08mr7829217ioa.0.1669361187716;
        Thu, 24 Nov 2022 23:26:27 -0800 (PST)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id p13-20020a02b00d000000b00363e61908bfsm1138561jah.10.2022.11.24.23.26.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 23:26:26 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id g26so1875372iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:26:25 -0800 (PST)
X-Received: by 2002:a02:c897:0:b0:374:100a:b0c7 with SMTP id
 m23-20020a02c897000000b00374100ab0c7mr8004072jao.185.1669361185189; Thu, 24
 Nov 2022 23:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
 <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv> <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
 <Y4BrjfLSukrSbGn4@MiWiFi-R3L-srv>
In-Reply-To: <Y4BrjfLSukrSbGn4@MiWiFi-R3L-srv>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 25 Nov 2022 08:26:13 +0100
X-Gmail-Original-Message-ID: <CANiDSCueVsRMBjjmCDc+r5YjM0UzThLyFm10kp1cKZw4Pnv6kg@mail.gmail.com>
Message-ID: <CANiDSCueVsRMBjjmCDc+r5YjM0UzThLyFm10kp1cKZw4Pnv6kg@mail.gmail.com>
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan

On Fri, 25 Nov 2022 at 08:15, Baoquan He <bhe@redhat.com> wrote:
>
> On 11/25/22 at 06:52am, Ricardo Ribalda wrote:
> > Hi Baoquan
> >
> > Thanks for your review!
> >
> > On Fri, 25 Nov 2022 at 03:58, Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> > > > Usually crash_image is defined statically via the crashkernel parameter
> > > > or DT.
> > > >
> > > > But if the crash kernel is not used, or is smaller than then
> > > > area pre-allocated that memory is wasted.
> > > >
> > > > Also, if the crash kernel was not defined at bootime, there is no way to
> > > > use the crash kernel.
> > > >
> > > > Enable runtime allocation of the crash_image if the crash_image is not
> > > > defined statically. Following the same memory allocation/validation path
> > > > that for the reboot kexec kernel.
> > >
> > > We don't check if the crashkernel memory region is valid in kernel, but
> > > we do have done the check in kexec-tools utility. Since both kexec_load and
> > > kexec_file_load need go through path of kexec-tools loading, we haven't
> > > got problem with lack of the checking in kernel.
> >
> > Not sure if I follow you.
> >
> > We currently check if the crash kernel is in the right place at
> > sanity_check_segment_list()
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kexec_core.c#n239
>
> Please check below code in kexec-tools utility, currently we have to use
> kexec -p to enter into kexec_load or kexec_file_load system call. Before
> entering system call, we have below code:

So your concern is that the current kexec-tools does not let you pass
a crashkernel unless there is memory reserved for it?

Once the changes land in the kernel I can make a patch for that. I am
currently using this to test the code:

https://chromium-review.googlesource.com/c/chromiumos/platform2/+/3953579/4/kexec-lite/kexec-lite.c

>
> https://kernel.googlesource.com/pub/scm/utils/kernel/kexec/kexec-tools.git/+/refs/heads/master/kexec/kexec.c
>
> int main(int argc, char *argv[])
> {
> ......
>                 if (do_load &&
>             ((kexec_flags & KEXEC_ON_CRASH) ||
>              (kexec_file_flags & KEXEC_FILE_ON_CRASH)) &&
>             !is_crashkernel_mem_reserved()) {
>                 die("Memory for crashkernel is not reserved\n"
>                     "Please reserve memory by passing"
>                     "\"crashkernel=Y@X\" parameter to kernel\n"
>                     "Then try to loading kdump kernel\n");
>         }
>
> ......
> }
>
> >
> >
> > >
> > > However, even though we want to do the check, doing like below is much
> > > easier and more reasonable.
> > >
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 45637511e0de..4d1339bd2ccf 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -344,6 +344,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >
> > >         dest_image = &kexec_image;
> > >         if (flags & KEXEC_FILE_ON_CRASH) {
> > > +               if (!crash_memory_valid())
> > > +                       return -EINVAL;
> > >                 dest_image = &kexec_crash_image;
> > >                 if (kexec_crash_image)
> > >                         arch_kexec_unprotect_crashkres();
> > >
> > > So, I am wondering if there is an issue encountered if we don't do the
> > > check in kernel.
> > >
> > > Thanks
> > > Baoquan
> > >
> > > >
> > > > ---
> > > >
> > > > To: Eric Biederman <ebiederm@xmission.com>
> > > > Cc: kexec@lists.infradead.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > Cc: Philipp Rudo <prudo@redhat.com>
> > > > Cc: Baoquan He <bhe@redhat.com>
> > > > ---
> > > >  include/linux/kexec.h | 1 +
> > > >  kernel/kexec.c        | 9 +++++----
> > > >  kernel/kexec_core.c   | 5 +++++
> > > >  kernel/kexec_file.c   | 7 ++++---
> > > >  4 files changed, 15 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > index 41a686996aaa..98ca9a32bc8e 100644
> > > > --- a/include/linux/kexec.h
> > > > +++ b/include/linux/kexec.h
> > > > @@ -427,6 +427,7 @@ extern int kexec_load_disabled;
> > > >  extern bool kexec_in_progress;
> > > >
> > > >  int crash_shrink_memory(unsigned long new_size);
> > > > +bool __crash_memory_valid(void);
> > > >  ssize_t crash_get_memory_size(void);
> > > >
> > > >  #ifndef arch_kexec_protect_crashkres
> > > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > > index cb8e6e6f983c..b5c17db25e88 100644
> > > > --- a/kernel/kexec.c
> > > > +++ b/kernel/kexec.c
> > > > @@ -28,7 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > >       struct kimage *image;
> > > >       bool kexec_on_panic = flags & KEXEC_ON_CRASH;
> > > >
> > > > -     if (kexec_on_panic) {
> > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > >               /* Verify we have a valid entry point */
> > > >               if ((entry < phys_to_boot_phys(crashk_res.start)) ||
> > > >                   (entry > phys_to_boot_phys(crashk_res.end)))
> > > > @@ -44,7 +44,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > >       image->nr_segments = nr_segments;
> > > >       memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> > > >
> > > > -     if (kexec_on_panic) {
> > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > >               /* Enable special crash kernel control page alloc policy. */
> > > >               image->control_page = crashk_res.start;
> > > >               image->type = KEXEC_TYPE_CRASH;
> > > > @@ -101,7 +101,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > >
> > > >       if (flags & KEXEC_ON_CRASH) {
> > > >               dest_image = &kexec_crash_image;
> > > > -             if (kexec_crash_image)
> > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > >                       arch_kexec_unprotect_crashkres();
> > > >       } else {
> > > >               dest_image = &kexec_image;
> > > > @@ -157,7 +157,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > >       image = xchg(dest_image, image);
> > > >
> > > >  out:
> > > > -     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
> > > > +     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image &&
> > > > +         __crash_memory_valid())
> > > >               arch_kexec_protect_crashkres();
> > > >
> > > >       kimage_free(image);
> > > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > > index ca2743f9c634..77083c9760fb 100644
> > > > --- a/kernel/kexec_core.c
> > > > +++ b/kernel/kexec_core.c
> > > > @@ -1004,6 +1004,11 @@ void crash_kexec(struct pt_regs *regs)
> > > >       }
> > > >  }
> > > >
> > > > +bool __crash_memory_valid(void)
> > > > +{
> > > > +     return crashk_res.end != crashk_res.start;
> > > > +}
> > > > +
> > > >  ssize_t crash_get_memory_size(void)
> > > >  {
> > > >       ssize_t size = 0;
> > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > index 45637511e0de..0671f4f370ff 100644
> > > > --- a/kernel/kexec_file.c
> > > > +++ b/kernel/kexec_file.c
> > > > @@ -280,7 +280,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
> > > >
> > > >       image->file_mode = 1;
> > > >
> > > > -     if (kexec_on_panic) {
> > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > >               /* Enable special crash kernel control page alloc policy. */
> > > >               image->control_page = crashk_res.start;
> > > >               image->type = KEXEC_TYPE_CRASH;
> > > > @@ -345,7 +345,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > >       dest_image = &kexec_image;
> > > >       if (flags & KEXEC_FILE_ON_CRASH) {
> > > >               dest_image = &kexec_crash_image;
> > > > -             if (kexec_crash_image)
> > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > >                       arch_kexec_unprotect_crashkres();
> > > >       }
> > > >
> > > > @@ -408,7 +408,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > >  exchange:
> > > >       image = xchg(dest_image, image);
> > > >  out:
> > > > -     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
> > > > +     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image &&
> > > > +         __crash_memory_valid())
> > > >               arch_kexec_protect_crashkres();
> > > >
> > > >       kexec_unlock();
> > > >
> > > > ---
> > > > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > > > change-id: 20221124-kexec-noalloc-3cab3cbe000f
> > > >
> > > > Best regards,
> > > > --
> > > > Ricardo Ribalda <ribalda@chromium.org>
> > > >
> > >
> >
> >
> > --
> > Ricardo Ribalda
> >
>


-- 
Ricardo Ribalda
