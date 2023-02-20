Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCEF69D11B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjBTQJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBTQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:09:20 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600B1B571;
        Mon, 20 Feb 2023 08:09:16 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w7so1594554oik.13;
        Mon, 20 Feb 2023 08:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qKwgEmFMvHxp8bhwKryOQIDMT3gDmSzeZYz7HFGi0A=;
        b=mcwIt39UTsOH/VD2CWB0f3XpfojSkJOsoHINEprOWCQfhExKIq9ldl6m1/7kJxUMJE
         g2ReIRbkPxlH8TDlSVNoy2zlDUBCWenL+AQSSKunKqtko03Q8eruiXp1s2mNTNfxxjAP
         5p1Qh6HvyEvUDwdiURvsx+ioU1hJKOg4Q8C+NQFppWyjKXeiL4RqqGHdwJFuwTmzKsp4
         OTVREXLeRILTF/F1FE9MTvoo4Vx2Zz5iU2OP+DwxW7sl6Y1JuWFjuLElVqkdLhCjrEFJ
         +WvBKHUtxeIuBOp/j/kuq4B2yS35No16DshXpt/B8oBI+93LUFEkYrYRD4R0U/fe1KsZ
         647A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qKwgEmFMvHxp8bhwKryOQIDMT3gDmSzeZYz7HFGi0A=;
        b=FCo0B6WmeRZuNqoiwqO8OzGtKCcOFFrpJ1GkjMOt0g5jnWy7eUcaGihpoFwoVj1qe1
         Be69pDj9k24oQMQp6wUWfv76MI+NTQfpg4d2Fc7h0zSgQP6J6tmfeFt95Qm9kEodxdJW
         UnDEqyDErGzkKna6DimzBPUxvaApWMi1DtDz1HLxhFLMj0gpbtPKtLlZq7ZPqqocFRJz
         1XkBEemEcuyWVLTYqshVzoGWNbDq9hiI/Do1p29ZlYqOVJfz0TM3cvGvyUTt7LNFYfHJ
         irj8sqE90WMvINBzlFiDyZ05Y30Du0w4IXMl+1QJ9guXQV3jQa52nQCcy8OohVATxnug
         w4bQ==
X-Gm-Message-State: AO0yUKWaTdqkXH74sn0GPzzpOIGrGcy2Bx4J1lb13y3/YLbU/+m6Ok/P
        IeNvQXN4wUismDV0p6JplNDxmdVy+trE26/qns0=
X-Google-Smtp-Source: AK7set+aFRYNQDGiaDd/8xtOQGQcGZhiqPbhDzJH2jTmHgUMuPs3oBV9oiMJLS3mZRVOrAjR6iKZ0/p6GM5gSm52s04=
X-Received: by 2002:a05:6808:ec7:b0:364:c0a5:1fcf with SMTP id
 q7-20020a0568080ec700b00364c0a51fcfmr1103306oiv.58.1676909355341; Mon, 20 Feb
 2023 08:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-6-robdclark@gmail.com>
 <37ec0125-8d0b-7d87-321d-ed4c7c7b32a7@amd.com>
In-Reply-To: <37ec0125-8d0b-7d87-321d-ed4c7c7b32a7@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Feb 2023 08:09:04 -0800
Message-ID: <CAF6AEGtAHXQ05tWoXdbx3_TK+11+XN6J9wuXssSh3PswUhvwgg@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] dma-buf/sync_file: Add SET_DEADLINE ioctl
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 12:27 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 18.02.23 um 22:15 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The initial purpose is for igt tests, but this would also be useful for
> > compositors that wait until close to vblank deadline to make decisions
> > about which frame to show.
> >
> > The igt tests can be found at:
> >
> > https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/fence-d=
eadline
> >
> > v2: Clarify the timebase, add link to igt tests
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/dma-buf/sync_file.c    | 19 +++++++++++++++++++
> >   include/uapi/linux/sync_file.h | 22 ++++++++++++++++++++++
> >   2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> > index af57799c86ce..fb6ca1032885 100644
> > --- a/drivers/dma-buf/sync_file.c
> > +++ b/drivers/dma-buf/sync_file.c
> > @@ -350,6 +350,22 @@ static long sync_file_ioctl_fence_info(struct sync=
_file *sync_file,
> >       return ret;
> >   }
> >
> > +static int sync_file_ioctl_set_deadline(struct sync_file *sync_file,
> > +                                     unsigned long arg)
> > +{
> > +     struct sync_set_deadline ts;
> > +
> > +     if (copy_from_user(&ts, (void __user *)arg, sizeof(ts)))
> > +             return -EFAULT;
> > +
> > +     if (ts.pad)
> > +             return -EINVAL;
> > +
> > +     dma_fence_set_deadline(sync_file->fence, ktime_set(ts.tv_sec, ts.=
tv_nsec));
> > +
> > +     return 0;
> > +}
> > +
> >   static long sync_file_ioctl(struct file *file, unsigned int cmd,
> >                           unsigned long arg)
> >   {
> > @@ -362,6 +378,9 @@ static long sync_file_ioctl(struct file *file, unsi=
gned int cmd,
> >       case SYNC_IOC_FILE_INFO:
> >               return sync_file_ioctl_fence_info(sync_file, arg);
> >
> > +     case SYNC_IOC_SET_DEADLINE:
> > +             return sync_file_ioctl_set_deadline(sync_file, arg);
> > +
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_f=
ile.h
> > index ee2dcfb3d660..c8666580816f 100644
> > --- a/include/uapi/linux/sync_file.h
> > +++ b/include/uapi/linux/sync_file.h
> > @@ -67,6 +67,20 @@ struct sync_file_info {
> >       __u64   sync_fence_info;
> >   };
> >
> > +/**
> > + * struct sync_set_deadline - set a deadline on a fence
> > + * @tv_sec:  seconds elapsed since epoch
> > + * @tv_nsec: nanoseconds elapsed since the time given by the tv_sec
> > + * @pad:     must be zero
> > + *
> > + * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank)
> > + */
> > +struct sync_set_deadline {
> > +     __s64   tv_sec;
> > +     __s32   tv_nsec;
> > +     __u32   pad;
>
> IIRC struct timespec defined this as time_t/long (which is horrible for
> an UAPI because of the sizeof(long) dependency), one possible
> alternative is to use 64bit nanoseconds from CLOCK_MONOTONIC (which is
> essentially ktime).
>
> Not 100% sure if there is any preferences documented, but I think the
> later might be better.

The original thought is that this maps directly to clock_gettime()
without extra conversion needed, and is similar to other pre-ktime_t
UAPI.  But OTOH if userspace wants to add an offset, it is maybe
better to convert completely to ns in userspace and use a u64 (as that
is what ns_to_ktime() uses).. (and OFC whatever decision here also
applies to the syncobj wait ioctls)

I'm leaning towards u64 CLOCK_MONOTONIC ns if no one has a good
argument against that.

BR,
-R

> Either way the patch is Acked-by: Christian K=C3=B6nig
> <christian.koenig@amd.com> for this patch.
>
> Regards,
> Christian.
>
> > +};
> > +
> >   #define SYNC_IOC_MAGIC              '>'
> >
> >   /**
> > @@ -95,4 +109,12 @@ struct sync_file_info {
> >    */
> >   #define SYNC_IOC_FILE_INFO  _IOWR(SYNC_IOC_MAGIC, 4, struct sync_file=
_info)
> >
> > +
> > +/**
> > + * DOC: SYNC_IOC_SET_DEADLINE - set a deadline on a fence
> > + *
> > + * Allows userspace to set a deadline on a fence, see dma_fence_set_de=
adline()
> > + */
> > +#define SYNC_IOC_SET_DEADLINE        _IOW(SYNC_IOC_MAGIC, 5, struct sy=
nc_set_deadline)
> > +
> >   #endif /* _UAPI_LINUX_SYNC_H */
>
