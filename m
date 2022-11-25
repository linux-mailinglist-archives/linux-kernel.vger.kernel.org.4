Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB19D638501
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKYIKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiKYIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:10:38 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E6B21E0B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:10:32 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id m15so1690244ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FyoJ3wh1zU6rXnKtzOIFMV/jsmUS095GoAtKhXCHW70=;
        b=nV0bE+vJgfgD+catJc8ZhzBmWAaw4fNkDdyCwh33D/XTWEaXgmhKd9z4TQ3Z51YuKv
         hTPGv/A/IxHb5U4g/1ck7KstdnBWex0SrW8OAE/3KcRAcfppaFW3WjRx2DOcqUywEJ4t
         AJnZ1OpJ4FHmEg8O3FLPJv6Ae5xfI/pXeXPiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyoJ3wh1zU6rXnKtzOIFMV/jsmUS095GoAtKhXCHW70=;
        b=IfSaFAzxQ7pov2sWYiR5Cn2Lxqck/HqCw49pgC7kjXA6DXpvLDpYVp04P2w7wyTjbv
         CHOeC6feS5lF2d5U4KBfww4Y/vZk7pYT9biLz5iUWNrjuHrTpEt2HX4Wv6AFIciEn8uq
         2tn0GZ2MxM7p/2+V9dB0tTKHaCB5wnCP/o9nAfSGq2nwjEfJB+jJVg9b+Z4j8tjdlh0F
         1aSMjzpbgQ4xA6OiJyH87R9jv41UH1f1JGHJjdUUhe1/ANd6wMyV3HvKFiPwCRPsxjmn
         18yYrCAIavCrxdpLYGqou047rMzNdFMIK4sDSBzPutuBa+ndeEFUlF4CcxXd4UJf5r0E
         yIwg==
X-Gm-Message-State: ANoB5pkJrvIcJPpSB5Jr0CN0BHq7fPVHJDBYykXIcdE31ZWozvn3159K
        14BMQWFMtvVZaMRQ4VfRhJhHK8iRVuU4Ai9i
X-Google-Smtp-Source: AA0mqf7ZTRokouE7/24bM8f/PUJq5OiMLo8Cbn9RxfcIq44TZa3HRSzyMPDJ6YoQLP8ciMwtbx76OA==
X-Received: by 2002:a92:6c12:0:b0:2eb:1f07:5a7e with SMTP id h18-20020a926c12000000b002eb1f075a7emr8420968ilc.0.1669363831366;
        Fri, 25 Nov 2022 00:10:31 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id d4-20020a0566022d4400b006ca9e36fec8sm1217446iow.54.2022.11.25.00.10.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:10:28 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id 11so2625461iou.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:10:27 -0800 (PST)
X-Received: by 2002:a05:6638:3d03:b0:373:9d0a:33a0 with SMTP id
 cl3-20020a0566383d0300b003739d0a33a0mr7887998jab.286.1669363826467; Fri, 25
 Nov 2022 00:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
 <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv> <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
 <Y4BrjfLSukrSbGn4@MiWiFi-R3L-srv> <CANiDSCueVsRMBjjmCDc+r5YjM0UzThLyFm10kp1cKZw4Pnv6kg@mail.gmail.com>
 <Y4Byd94oeoGCuTGq@MiWiFi-R3L-srv>
In-Reply-To: <Y4Byd94oeoGCuTGq@MiWiFi-R3L-srv>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 25 Nov 2022 09:10:15 +0100
X-Gmail-Original-Message-ID: <CANiDSCvtLNBUF_tJQUak-6LB92q=JnCGyAQ5ekKyQ-cG6_UHeg@mail.gmail.com>
Message-ID: <CANiDSCvtLNBUF_tJQUak-6LB92q=JnCGyAQ5ekKyQ-cG6_UHeg@mail.gmail.com>
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

On Fri, 25 Nov 2022 at 08:45, Baoquan He <bhe@redhat.com> wrote:
>
> On 11/25/22 at 08:26am, Ricardo Ribalda wrote:
> > Hi Baoquan
> >
> > On Fri, 25 Nov 2022 at 08:15, Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 11/25/22 at 06:52am, Ricardo Ribalda wrote:
> > > > Hi Baoquan
> > > >
> > > > Thanks for your review!
> > > >
> > > > On Fri, 25 Nov 2022 at 03:58, Baoquan He <bhe@redhat.com> wrote:
> > > > >
> > > > > On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> > > > > > Usually crash_image is defined statically via the crashkernel parameter
> > > > > > or DT.
> > > > > >
> > > > > > But if the crash kernel is not used, or is smaller than then
> > > > > > area pre-allocated that memory is wasted.
> > > > > >
> > > > > > Also, if the crash kernel was not defined at bootime, there is no way to
> > > > > > use the crash kernel.
> > > > > >
> > > > > > Enable runtime allocation of the crash_image if the crash_image is not
> > > > > > defined statically. Following the same memory allocation/validation path
> > > > > > that for the reboot kexec kernel.
> > > > >
> > > > > We don't check if the crashkernel memory region is valid in kernel, but
> > > > > we do have done the check in kexec-tools utility. Since both kexec_load and
> > > > > kexec_file_load need go through path of kexec-tools loading, we haven't
> > > > > got problem with lack of the checking in kernel.
> > > >
> > > > Not sure if I follow you.
> > > >
> > > > We currently check if the crash kernel is in the right place at
> > > > sanity_check_segment_list()
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kexec_core.c#n239
> > >
> > > Please check below code in kexec-tools utility, currently we have to use
> > > kexec -p to enter into kexec_load or kexec_file_load system call. Before
> > > entering system call, we have below code:
> >
> > So your concern is that the current kexec-tools does not let you pass
> > a crashkernel unless there is memory reserved for it?
>
> No, my concern is why we have to do the check in kernel if we have done
> that in kexec-tools utility. You didn't say your kexec-lite need this
> until now. I think it's fine to add the check in kernel if you prefer to
> do the check in kernel, but not in kexec-lite.
>
> The motivation or reason you want to make the change is very important.

kexec-lite is just to test the kernel code. It is easier to follow
than kexec-utils and supports 32bit userspace on a 64bit kernel.


I think it was clear. The motivation is to enable the use of
crashkernel when it is not statically predefined.

Any suggestions on how I can make it more clear?



>
>
> >
> > Once the changes land in the kernel I can make a patch for that. I am
> > currently using this to test the code:
> >
> > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/3953579/4/kexec-lite/kexec-lite.c
> >
> > >
> > > https://kernel.googlesource.com/pub/scm/utils/kernel/kexec/kexec-tools.git/+/refs/heads/master/kexec/kexec.c
> > >
> > > int main(int argc, char *argv[])
> > > {
> > > ......
> > >                 if (do_load &&
> > >             ((kexec_flags & KEXEC_ON_CRASH) ||
> > >              (kexec_file_flags & KEXEC_FILE_ON_CRASH)) &&
> > >             !is_crashkernel_mem_reserved()) {
> > >                 die("Memory for crashkernel is not reserved\n"
> > >                     "Please reserve memory by passing"
> > >                     "\"crashkernel=Y@X\" parameter to kernel\n"
> > >                     "Then try to loading kdump kernel\n");

Having that check ALSO is unserspace is fine. It lets kexec show a
more meaningful error message. But we should not rely on userspace
checks.

This patch is not about adding an extra check on the kernel, but to
enable extra functionaliry.

> > >         }
> > >
> > > ......
> > > }
> > >
> > > >
> > > >
> > > > >
> > > > > However, even though we want to do the check, doing like below is much
> > > > > easier and more reasonable.
> > > > >
> > > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > index 45637511e0de..4d1339bd2ccf 100644
> > > > > --- a/kernel/kexec_file.c
> > > > > +++ b/kernel/kexec_file.c
> > > > > @@ -344,6 +344,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > >
> > > > >         dest_image = &kexec_image;
> > > > >         if (flags & KEXEC_FILE_ON_CRASH) {
> > > > > +               if (!crash_memory_valid())
> > > > > +                       return -EINVAL;
> > > > >                 dest_image = &kexec_crash_image;
> > > > >                 if (kexec_crash_image)
> > > > >                         arch_kexec_unprotect_crashkres();
> > > > >
> > > > > So, I am wondering if there is an issue encountered if we don't do the
> > > > > check in kernel.
> > > > >
> > > > > Thanks
> > > > > Baoquan
> > > > >
> > > > > >
> > > > > > ---
> > > > > >
> > > > > > To: Eric Biederman <ebiederm@xmission.com>
> > > > > > Cc: kexec@lists.infradead.org
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > > > Cc: Philipp Rudo <prudo@redhat.com>
> > > > > > Cc: Baoquan He <bhe@redhat.com>
> > > > > > ---
> > > > > >  include/linux/kexec.h | 1 +
> > > > > >  kernel/kexec.c        | 9 +++++----
> > > > > >  kernel/kexec_core.c   | 5 +++++
> > > > > >  kernel/kexec_file.c   | 7 ++++---
> > > > > >  4 files changed, 15 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > > > index 41a686996aaa..98ca9a32bc8e 100644
> > > > > > --- a/include/linux/kexec.h
> > > > > > +++ b/include/linux/kexec.h
> > > > > > @@ -427,6 +427,7 @@ extern int kexec_load_disabled;
> > > > > >  extern bool kexec_in_progress;
> > > > > >
> > > > > >  int crash_shrink_memory(unsigned long new_size);
> > > > > > +bool __crash_memory_valid(void);
> > > > > >  ssize_t crash_get_memory_size(void);
> > > > > >
> > > > > >  #ifndef arch_kexec_protect_crashkres
> > > > > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > > > > index cb8e6e6f983c..b5c17db25e88 100644
> > > > > > --- a/kernel/kexec.c
> > > > > > +++ b/kernel/kexec.c
> > > > > > @@ -28,7 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > > > >       struct kimage *image;
> > > > > >       bool kexec_on_panic = flags & KEXEC_ON_CRASH;
> > > > > >
> > > > > > -     if (kexec_on_panic) {
> > > > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > > > >               /* Verify we have a valid entry point */
> > > > > >               if ((entry < phys_to_boot_phys(crashk_res.start)) ||
> > > > > >                   (entry > phys_to_boot_phys(crashk_res.end)))
> > > > > > @@ -44,7 +44,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > > > > >       image->nr_segments = nr_segments;
> > > > > >       memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> > > > > >
> > > > > > -     if (kexec_on_panic) {
> > > > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > > > >               /* Enable special crash kernel control page alloc policy. */
> > > > > >               image->control_page = crashk_res.start;
> > > > > >               image->type = KEXEC_TYPE_CRASH;
> > > > > > @@ -101,7 +101,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > > >
> > > > > >       if (flags & KEXEC_ON_CRASH) {
> > > > > >               dest_image = &kexec_crash_image;
> > > > > > -             if (kexec_crash_image)
> > > > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > > > >                       arch_kexec_unprotect_crashkres();
> > > > > >       } else {
> > > > > >               dest_image = &kexec_image;
> > > > > > @@ -157,7 +157,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > > >       image = xchg(dest_image, image);
> > > > > >
> > > > > >  out:
> > > > > > -     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
> > > > > > +     if ((flags & KEXEC_ON_CRASH) && kexec_crash_image &&
> > > > > > +         __crash_memory_valid())
> > > > > >               arch_kexec_protect_crashkres();
> > > > > >
> > > > > >       kimage_free(image);
> > > > > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > > > > index ca2743f9c634..77083c9760fb 100644
> > > > > > --- a/kernel/kexec_core.c
> > > > > > +++ b/kernel/kexec_core.c
> > > > > > @@ -1004,6 +1004,11 @@ void crash_kexec(struct pt_regs *regs)
> > > > > >       }
> > > > > >  }
> > > > > >
> > > > > > +bool __crash_memory_valid(void)
> > > > > > +{
> > > > > > +     return crashk_res.end != crashk_res.start;
> > > > > > +}
> > > > > > +
> > > > > >  ssize_t crash_get_memory_size(void)
> > > > > >  {
> > > > > >       ssize_t size = 0;
> > > > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > > index 45637511e0de..0671f4f370ff 100644
> > > > > > --- a/kernel/kexec_file.c
> > > > > > +++ b/kernel/kexec_file.c
> > > > > > @@ -280,7 +280,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
> > > > > >
> > > > > >       image->file_mode = 1;
> > > > > >
> > > > > > -     if (kexec_on_panic) {
> > > > > > +     if (kexec_on_panic && __crash_memory_valid()) {
> > > > > >               /* Enable special crash kernel control page alloc policy. */
> > > > > >               image->control_page = crashk_res.start;
> > > > > >               image->type = KEXEC_TYPE_CRASH;
> > > > > > @@ -345,7 +345,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > > >       dest_image = &kexec_image;
> > > > > >       if (flags & KEXEC_FILE_ON_CRASH) {
> > > > > >               dest_image = &kexec_crash_image;
> > > > > > -             if (kexec_crash_image)
> > > > > > +             if (kexec_crash_image && __crash_memory_valid())
> > > > > >                       arch_kexec_unprotect_crashkres();
> > > > > >       }
> > > > > >
> > > > > > @@ -408,7 +408,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > > >  exchange:
> > > > > >       image = xchg(dest_image, image);
> > > > > >  out:
> > > > > > -     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
> > > > > > +     if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image &&
> > > > > > +         __crash_memory_valid())
> > > > > >               arch_kexec_protect_crashkres();
> > > > > >
> > > > > >       kexec_unlock();
> > > > > >
> > > > > > ---
> > > > > > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > > > > > change-id: 20221124-kexec-noalloc-3cab3cbe000f
> > > > > >
> > > > > > Best regards,
> > > > > > --
> > > > > > Ricardo Ribalda <ribalda@chromium.org>
> > > > > >
> > > > >
> > > >
> > > >
> > > > --
> > > > Ricardo Ribalda
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
