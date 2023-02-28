Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB16A5FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjB1TiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjB1TiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:38:12 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D49EC9;
        Tue, 28 Feb 2023 11:38:09 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1755e639b65so641494fac.3;
        Tue, 28 Feb 2023 11:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677613088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PVieRPuEMOm+nHzPuq4QMxD7wCV7l2uEG4OOeeLhgTo=;
        b=YtdcuiZxfo3pvq1EBxEjMVDJt7xsOjpqKK7yjHlMcKGm6zRNFa8DLgbRUNG4TbT9y8
         XBtvslNJByhKIrCLCJ23dQtmvnnfDLVDIhXj9f4NY/5OOBLv/Ytd1iSF79T3BzW5W7gf
         RyWZgAVw7X/hmAyac+viOivzUgUIbQfEsDOripCar4FpJ2USzdD75I/gsz34YJuJsqKd
         zfv+jcd7iZL9mLzhuXjg9fWxY8yszD6D0pDwdFXqwUcZQ9RUrilpBISJTAytSXVEF2Mo
         vsBsKEdDYIyfnZXBwZPog4D0jmkYANALCDhl7UVWnQDtkfLNVfzJXZ/SzceH9dd0BMUJ
         cojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677613088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVieRPuEMOm+nHzPuq4QMxD7wCV7l2uEG4OOeeLhgTo=;
        b=wvmvYe+/n9xE8FVt0WuHyxanfLFuUUnCp/GGpXzXAc/rCQ0GPAwBqOjYNT4v1++3rY
         UqZoC1OGwv6GDOShFbUTqAjFVI78MqwmR3Uu37iyGFZgmJw9TvCxUvRrCSLw63FqtOLW
         BJWSBt4vM8ztzliwL3wz5LOCiX7FX6oE1U7/otAP1XT25xla9bNmFYFD89csCe4D6sh7
         kMerxd8aGTPg6rYDL9Qk+aj7fDzbzQDiPTOCrMmVuAm0m8FEFgEC1UQd0ASdHsePLy0u
         mJ352GarI+1bfXtmn5Nnmzh/xoaGQIQfFMHxu7YwOzFU4ZNRREcEPrnZtQUzq+X0hv8z
         joLg==
X-Gm-Message-State: AO0yUKVukHodzhnPOAcv02JS9VR53HcMkXlfazWsFi3vSnbdNt9UJZ+6
        5ffUre9gB6Ynv0RRww3q+1a+EVAcD92fOfKSGTE=
X-Google-Smtp-Source: AK7set8/X1E/XPetbsmctxmF0pvmxBCTcKKMQYCtY5r6xSJk5qanEEVUtccQFCDLkVD6xABYiPhsKBl7fbBep2x+JN4=
X-Received: by 2002:a05:6871:6a9e:b0:16e:873e:b06b with SMTP id
 zf30-20020a0568716a9e00b0016e873eb06bmr869979oab.3.1677613088636; Tue, 28 Feb
 2023 11:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20230227193535.2822389-1-robdclark@gmail.com> <20230227193535.2822389-6-robdclark@gmail.com>
 <20230228112215.6d3f1f3d@eldfell>
In-Reply-To: <20230228112215.6d3f1f3d@eldfell>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 28 Feb 2023 11:37:57 -0800
Message-ID: <CAF6AEGt01HQ7kJmTWrycwDG=Rc_vy1dQ+SPFeX7vD19e+69hBw@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] dma-buf/sync_file: Add SET_DEADLINE ioctl
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:22 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Mon, 27 Feb 2023 11:35:11 -0800
> Rob Clark <robdclark@gmail.com> wrote:
>
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The initial purpose is for igt tests, but this would also be useful for
> > compositors that wait until close to vblank deadline to make decisions
> > about which frame to show.
> >
> > The igt tests can be found at:
> >
> > https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/fence-deadline
> >
> > v2: Clarify the timebase, add link to igt tests
> > v3: Use u64 value in ns to express deadline.
> > v4: More doc
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/dma-buf/dma-fence.c    |  3 ++-
> >  drivers/dma-buf/sync_file.c    | 19 +++++++++++++++++++
> >  include/uapi/linux/sync_file.h | 22 ++++++++++++++++++++++
> >  3 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index e103e821d993..7761ceeae620 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -933,7 +933,8 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
> >   *   the GPU's devfreq to reduce frequency, when in fact the opposite is what is
> >   *   needed.
> >   *
> > - * To this end, deadline hint(s) can be set on a &dma_fence via &dma_fence_set_deadline.
> > + * To this end, deadline hint(s) can be set on a &dma_fence via &dma_fence_set_deadline
> > + * (or indirectly via userspace facing ioctls like &SYNC_IOC_SET_DEADLINE).
> >   * The deadline hint provides a way for the waiting driver, or userspace, to
> >   * convey an appropriate sense of urgency to the signaling driver.
>
> Hi,
>
> when the kernel HTML doc is generated, I assume the above becomes a
> link to "DOC: SYNC_IOC_SET_DEADLINE - set a deadline on a fence", right?

Heh, kernel docs completely miss the sync_file uABI.. I'll add a patch
to correct that in order to make these links work properly.

BR,
-R

> >   *
> > diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> > index af57799c86ce..418021cfb87c 100644
> > --- a/drivers/dma-buf/sync_file.c
> > +++ b/drivers/dma-buf/sync_file.c
> > @@ -350,6 +350,22 @@ static long sync_file_ioctl_fence_info(struct sync_file *sync_file,
> >       return ret;
> >  }
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
> > +     dma_fence_set_deadline(sync_file->fence, ns_to_ktime(ts.deadline_ns));
> > +
> > +     return 0;
> > +}
> > +
> >  static long sync_file_ioctl(struct file *file, unsigned int cmd,
> >                           unsigned long arg)
> >  {
> > @@ -362,6 +378,9 @@ static long sync_file_ioctl(struct file *file, unsigned int cmd,
> >       case SYNC_IOC_FILE_INFO:
> >               return sync_file_ioctl_fence_info(sync_file, arg);
> >
> > +     case SYNC_IOC_SET_DEADLINE:
> > +             return sync_file_ioctl_set_deadline(sync_file, arg);
> > +
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
> > index ee2dcfb3d660..49325cf6749b 100644
> > --- a/include/uapi/linux/sync_file.h
> > +++ b/include/uapi/linux/sync_file.h
> > @@ -67,6 +67,21 @@ struct sync_file_info {
> >       __u64   sync_fence_info;
> >  };
> >
> > +/**
> > + * struct sync_set_deadline - set a deadline hint on a fence
> > + * @deadline_ns: absolute time of the deadline
>
> Is it legal to pass zero as deadline_ns?
>
> > + * @pad:     must be zero
> > + *
> > + * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank)
>
> Does something here provide doc links to "DOC: SYNC_IOC_SET_DEADLINE -
> set a deadline on a fence" and to the "DOC: deadline hints"?
>
> > + */
> > +struct sync_set_deadline {
> > +     __u64   deadline_ns;
> > +     /* Not strictly needed for alignment but gives some possibility
> > +      * for future extension:
> > +      */
> > +     __u64   pad;
> > +};
> > +
> >  #define SYNC_IOC_MAGIC               '>'
> >
> >  /**
> > @@ -95,4 +110,11 @@ struct sync_file_info {
> >   */
> >  #define SYNC_IOC_FILE_INFO   _IOWR(SYNC_IOC_MAGIC, 4, struct sync_file_info)
> >
> > +/**
> > + * DOC: SYNC_IOC_SET_DEADLINE - set a deadline on a fence
> > + *
> > + * Allows userspace to set a deadline on a fence, see dma_fence_set_deadline()
>
> Does something here provide doc links to struct sync_set_deadline and
> to the "DOC: deadline hints"?
>
> > + */
> > +#define SYNC_IOC_SET_DEADLINE        _IOW(SYNC_IOC_MAGIC, 5, struct sync_set_deadline)
> > +
> >  #endif /* _UAPI_LINUX_SYNC_H */
>
> With all those links added:
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>
>
> Thanks,
> pq
