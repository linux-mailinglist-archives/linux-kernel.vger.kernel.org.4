Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0C5EEC47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiI2DBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiI2DBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:01:42 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1162CDD0;
        Wed, 28 Sep 2022 20:01:41 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id x17so13276uai.11;
        Wed, 28 Sep 2022 20:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=138hauZAuEksj4SEPaWiskeQij9mz5A2aU/o8ozjnHk=;
        b=aVPLrrxVa04StoVYIny/i3QNO7j3nt/KqmDhi4qdZvnRzzbDfMdxveuWO1eBNHHv1c
         4hklN1Id7RO/S83XwxAcC8dJX1mXR3ur9WM+3R5LIyj0Igf3IG+F+iJKZRaHqeQhA3oQ
         2gKfHypJI3BJYC3qj1+tBoKL2f5W2mXXvelLxXzUgoJP7Rcob6HRyaT6hS3ZwG5i/8Qf
         4K8v8pseJvkSWFlxcr8P4USbWXf8kWLpkAv2nTyWCHQz9gVn0bjR8GXNDu8bu75tjo0J
         yIzPWqxrIIn9Hz53iUEGuNyLhtXdd0hxFC5KqKGC6e5zqgkc4vT0OIv8Dgs1RUFeFjrp
         44FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=138hauZAuEksj4SEPaWiskeQij9mz5A2aU/o8ozjnHk=;
        b=3lbVq65uTIXGvMUS9UQvmcExoikEDGJxOlBUW3hQnbpdiLJl584zM/mc60t050E+oF
         9TIXxAJlLdK7cMhYCG7a8AauuA1XuUzuwrBNTqnwmE7XeCF1iPiJPxrSFde9BNhzqka+
         j8/ARSGwkll/MpHQtU+p2b/fmSo2hmNo9dszzkz6NkbBb7YY2V6Se1O5qTNc2M8bHwiq
         iG7cOc6mHXHxK6SF6M9Yqe7Wisbo6fC9iJ/h+HP5Dp0wVUtpVbnNMjskruOViov6SXHe
         8rTM+I7YTNxcKbOha7Akxa2XZCqvi7HAuwoDbxF4IH6mG6ih2b3s4MKPdyNDrAG5v39K
         lI5A==
X-Gm-Message-State: ACrzQf3xyFCLs+Tzkp2hPzWef0RZcQ6ZksYSwmBaHZuC+lG9ChRvmAcn
        In/8HKIXRYg7n+vb9GRNUDTJHRY74p+cRTu2Cm8D9mpS7ZBkh9Nlqiw=
X-Google-Smtp-Source: AMsMyM7invLzfRmtHGlacWelt1bfdvxKJNUTpc3kU+BuxHgYkawtMvyu5Osv0D6g6/2tqMwIaQ7lX2qtgGB23kg9omc=
X-Received: by 2002:ab0:25d3:0:b0:3ae:6580:2adc with SMTP id
 y19-20020ab025d3000000b003ae65802adcmr520430uan.23.1664420499071; Wed, 28 Sep
 2022 20:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAB7eexK_jr1LWOO9RWrBF9as7gAS9kpHjrZFRuRrRJF=1H4W6A@mail.gmail.com>
 <404508f8-37bb-a3bd-4319-6b6d7a7e076e@cybernetics.com> <af3d2628-bf00-d897-d140-415985c29bfd@interlog.com>
In-Reply-To: <af3d2628-bf00-d897-d140-415985c29bfd@interlog.com>
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Thu, 29 Sep 2022 11:01:27 +0800
Message-ID: <CAB7eexKm-0eO11KO2Brp_djcgXHO=1gARfkUN13ZV8BNHBxURw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sg_release
To:     dgilbert@interlog.com
Cc:     Tony Battersby <tonyb@cybernetics.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your solution! I am sorry that I was not able to extract
the reproducer. But I am improving the solution to reproduce the crash.
If I succeed in reproducing it, I will check it for you as soon as possible!

Best Regards,
Rondreis

On Thu, Sep 29, 2022 at 5:45 AM Douglas Gilbert <dgilbert@interlog.com> wrote:
>
> On 2022-09-22 17:29, Tony Battersby wrote:
> > On 9/20/22 10:46, Rondreis wrote:
> >> Hello,
> >>
> >> When fuzzing the Linux kernel driver v6.0-rc6, the following crash was
> >> triggered.
> >>
> >> HEAD commit: 521a547ced6477c54b4b0cc206000406c221b4d6
> >> git tree: upstream
> >>
> >> kernel config: https://pastebin.com/raw/hekxU61F
> >> console output: https://pastebin.com/raw/73a8RzBY
> >>
> >> Sorry for failing to extract the reproducer. But on other versions of
> >> Linux, I also triggered this crash.
> >>
> >> I would appreciate it if you have any idea how to solve this bug.
> >>
> > sg_release() calls "kref_put(&sfp->f_ref, sg_remove_sfp)" which
> > eventually does "kref_put(&sdp->d_ref, sg_device_destroy)" which does
> > "kfree(sdp)", but sg_release() continues to access sdp afterward.  Try
> > the following patch.
> >
> >>From 82ca6785c40eded6229183a53752fc5e43db4a94 Mon Sep 17 00:00:00 2001
> > From: Tony Battersby <tonyb@cybernetics.com>
> > Date: Thu, 22 Sep 2022 11:05:30 -0400
> > Subject: [PATCH] scsi: sg: fix memory-use-after-free on device removal
> >
> > Fix memory-use-after-free race when closing a sg fd to a removed device.
> >
> > Link: https://lore.kernel.org/linux-scsi/CAB7eexK_jr1LWOO9RWrBF9as7gAS9kpHjrZFRuRrRJF=1H4W6A@mail.gmail.com/
> > Reported-by: Rondreis <linhaoguo86@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> > ---
> >   drivers/scsi/sg.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> > index 340b050ad28d..f44cbe42dba9 100644
> > --- a/drivers/scsi/sg.c
> > +++ b/drivers/scsi/sg.c
> > @@ -388,6 +388,7 @@ sg_release(struct inode *inode, struct file *filp)
> >               return -ENXIO;
> >       SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp, "sg_release\n"));
> >
> > +     kref_get(&sdp->d_ref);
> >       mutex_lock(&sdp->open_rel_lock);
> >       scsi_autopm_put_device(sdp->device);
> >       kref_put(&sfp->f_ref, sg_remove_sfp);
> > @@ -402,6 +403,7 @@ sg_release(struct inode *inode, struct file *filp)
> >               wake_up_interruptible(&sdp->open_wait);
> >       }
> >       mutex_unlock(&sdp->open_rel_lock);
> > +     kref_put(&sdp->d_ref, sg_device_destroy);
> >       return 0;
> >   }
> >
>
>
> Hi Rondreis,
> Have you been able to test the above patch from Tony?
>
> Doug Gilbert
>
