Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D4C624B04
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiKJTxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiKJTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:53:32 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE4D48775
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:53:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id r12so5199540lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1q6v3eGHpw+HM2AqEO3iJYqILo6CucTERSPm+RfTnjw=;
        b=C85SY3xhrF5dCpD27FtNezgbtUFWqnbdPOkE+ij03EE2xXhKYf7v/jj1tEpi5E3ofV
         xBtsrOQeAK4hZrUx1YWlSwszqf6QFtxgzYa7cig3tuHvgghjcYzWHV4PhpLn9K7TqAOX
         MDiaukaoqETrD5AY9FJAXBaO9vv1eQgQejhTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1q6v3eGHpw+HM2AqEO3iJYqILo6CucTERSPm+RfTnjw=;
        b=i+SpHd0V2LgWQBveHvSoLMv1zLDzuZ65scvBEvWyw0oddIbEhfjsNefI4Ag1bwp55j
         1DgA0/0EpcU33GzXPQUg7TdQ2ub8m08xMFDjPpLBKYTP4/E5GlC0KjD4H1kZSbdj0yn8
         gPIFOAPa8I/rE0gg+wsyKOIf/KLZZfnpgkUZ6TwELlkCoDwSHlgV0RKNQb4MN4J4Ay0X
         ZWOcgALva4DkHsK/GZ21h4gcwd0BpxVnhtlnSaLQwRTo9ZB31H5VL1xcV5A7Dfmgj5yZ
         wn1paiWn0sj9O7oq4kgI19DEXbsu1XHfDNRbyqJVV8ccWwhqiJ+qkewj9kaFs8ZyPF7e
         vYdg==
X-Gm-Message-State: ANoB5pm8oAeIZJSD2LCPaAqGqGyKiq6wPDgsE+bHjcKgbUNXcnAqzQIN
        wTH9pHafOI539pXlom0PzsC88SeyuLi6e8ci1dWB2Q==
X-Google-Smtp-Source: AA0mqf4hkotvXiXK/OJn2ht+ntId1qkckBKhiXIdykipj5vk/dKYU1iphCDSilEoYx/u5JiHtzLD5cJoC/LTNwJcLcc=
X-Received: by 2002:a05:6512:340e:b0:4b4:70d9:5c02 with SMTP id
 i14-20020a056512340e00b004b470d95c02mr716612lfr.27.1668109999145; Thu, 10 Nov
 2022 11:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20221103190549.3446167-1-dualli@chromium.org> <20221103190549.3446167-2-dualli@chromium.org>
 <Y2wtHBPMyxfkKiSg@google.com>
In-Reply-To: <Y2wtHBPMyxfkKiSg@google.com>
From:   Li Li <dualli@chromium.org>
Date:   Thu, 10 Nov 2022 11:53:08 -0800
Message-ID: <CANBPYPg=35-fwa18pdYBSVmQP1SLvSUyPWHUM8qFZ1-8XEm0Rw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] binder: return pending info for frozen async txns
To:     Carlos Llamas <cmllamas@google.com>
Cc:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, surenb@google.com, arnd@arndb.de,
        masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 2:43 PM Carlos Llamas <cmllamas@google.com> wrote:
>
> On Thu, Nov 03, 2022 at 12:05:49PM -0700, Li Li wrote:
> > From: Li Li <dualli@google.com>
> >
> > An async transaction to a frozen process will still be successsfully
>
> nit: sucessfully typo

Nice catch! Will remove the extra 's' in v2.

>
> > put in the queue. But this pending async transaction won't be processed
> > until the target process is unfrozen at an unspecified time in the
> > future. Pass this important information back to the user space caller
> > by returning BR_TRANSACTION_PENDING.
> >
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  drivers/android/binder.c            | 23 ++++++++++++++++++++---
> >  drivers/android/binder_internal.h   |  3 ++-
> >  include/uapi/linux/android/binder.h |  7 ++++++-
> >  3 files changed, 28 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 880224ec6abb..a097b89f6a7a 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2728,7 +2728,10 @@ binder_find_outdated_transaction_ilocked(struct binder_transaction *t,
> >   *
> >   * Return:   0 if the transaction was successfully queued
> >   *           BR_DEAD_REPLY if the target process or thread is dead
> > - *           BR_FROZEN_REPLY if the target process or thread is frozen
> > + *           BR_FROZEN_REPLY if the target process or thread is frozen and
> > + *                   the sync transaction was rejected
> > + *           BR_TRANSACTION_PENDING if the target process is frozen and the
> > + *                   async transaction was successfully queued
> >   */
> >  static int binder_proc_transaction(struct binder_transaction *t,
> >                                   struct binder_proc *proc,
> > @@ -2807,6 +2810,9 @@ static int binder_proc_transaction(struct binder_transaction *t,
> >               binder_stats_deleted(BINDER_STAT_TRANSACTION);
> >       }
> >
> > +     if (oneway && proc->is_frozen)
>
> Do you need the inner lock here for proc->is_frozen?

You're right. I'll add a new local variable and set it between the existing
binder_inner_proc_lock() and binder_inner_proc_unlock().

>
> > +             return BR_TRANSACTION_PENDING;
> > +
> >       return 0;
> >  }
> >
> > @@ -3607,9 +3613,16 @@ static void binder_transaction(struct binder_proc *proc,
> >       } else {
> >               BUG_ON(target_node == NULL);
> >               BUG_ON(t->buffer->async_transaction != 1);
> > -             binder_enqueue_thread_work(thread, tcomplete);
> >               return_error = binder_proc_transaction(t, target_proc, NULL);
> > -             if (return_error)
> > +             /*
> > +              * Let the caller know its async transaction reaches a frozen
>
> nit: I believe you meant s/its/when or similar?

Will change it in v2. Thanks!

>
> > +              * process and is put in a pending queue, waiting for the target
> > +              * process to be unfrozen.
> > +              */
> > +             if (return_error == BR_TRANSACTION_PENDING)
> > +                     tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
> > +             binder_enqueue_thread_work(thread, tcomplete);
>
> I wonder if switching the order of queuing the tcomplete here and waking
> up the target thread inside binder_proc_transaction() will have any
> performance implications if this task gets scheduled out.

Eventually the sender has to wait this whole function finish and then
call another
ioctl to actually read tcomplete back. If this task gets cheduled out,
it won't have
a chance to perform that reading operation even without this change. So there's
no difference.

>
> > +             if (return_error && return_error != BR_TRANSACTION_PENDING)
> >                       goto err_dead_proc_or_thread;
> >       }
> >       if (target_thread)
> > @@ -4440,10 +4453,13 @@ static int binder_thread_read(struct binder_proc *proc,
> >                       binder_stat_br(proc, thread, cmd);
> >               } break;
> >               case BINDER_WORK_TRANSACTION_COMPLETE:
> > +             case BINDER_WORK_TRANSACTION_PENDING:
> >               case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT: {
> >                       if (proc->oneway_spam_detection_enabled &&
> >                                  w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
> >                               cmd = BR_ONEWAY_SPAM_SUSPECT;
> > +                     else if (w->type == BINDER_WORK_TRANSACTION_PENDING)
> > +                             cmd = BR_TRANSACTION_PENDING;
> >                       else
> >                               cmd = BR_TRANSACTION_COMPLETE;
> >                       binder_inner_proc_unlock(proc);
> > @@ -6170,6 +6186,7 @@ static const char * const binder_return_strings[] = {
> >       "BR_FAILED_REPLY",
> >       "BR_FROZEN_REPLY",
> >       "BR_ONEWAY_SPAM_SUSPECT",
> > +     "BR_TRANSACTION_PENDING"
> >  };
> >
> >  static const char * const binder_command_strings[] = {
> > diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> > index abe19d88c6ec..6c51325a826f 100644
> > --- a/drivers/android/binder_internal.h
> > +++ b/drivers/android/binder_internal.h
> > @@ -133,7 +133,7 @@ enum binder_stat_types {
> >  };
> >
> >  struct binder_stats {
> > -     atomic_t br[_IOC_NR(BR_ONEWAY_SPAM_SUSPECT) + 1];
> > +     atomic_t br[_IOC_NR(BR_TRANSACTION_PENDING) + 1];
> >       atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
> >       atomic_t obj_created[BINDER_STAT_COUNT];
> >       atomic_t obj_deleted[BINDER_STAT_COUNT];
> > @@ -152,6 +152,7 @@ struct binder_work {
> >       enum binder_work_type {
> >               BINDER_WORK_TRANSACTION = 1,
> >               BINDER_WORK_TRANSACTION_COMPLETE,
> > +             BINDER_WORK_TRANSACTION_PENDING,
> >               BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT,
> >               BINDER_WORK_RETURN_ERROR,
> >               BINDER_WORK_NODE,
> > diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> > index e72e4de8f452..c21b3b3eb4e4 100644
> > --- a/include/uapi/linux/android/binder.h
> > +++ b/include/uapi/linux/android/binder.h
> > @@ -450,7 +450,7 @@ enum binder_driver_return_protocol {
> >
> >       BR_FROZEN_REPLY = _IO('r', 18),
> >       /*
> > -      * The target of the last transaction (either a bcTRANSACTION or
> > +      * The target of the last sync transaction (either a bcTRANSACTION or
> >        * a bcATTEMPT_ACQUIRE) is frozen.  No parameters.
> >        */
> >
> > @@ -460,6 +460,11 @@ enum binder_driver_return_protocol {
> >        * asynchronous transaction makes the allocated async buffer size exceed
> >        * detection threshold.  No parameters.
> >        */
> > +
> > +     BR_TRANSACTION_PENDING = _IO('r', 20),
> > +     /*
> > +      * The target of the last async transaction is frozen.  No parameters.
> > +      */
> >  };
> >
> >  enum binder_driver_command_protocol {
> > --
> > 2.38.1.431.g37b22c650d-goog
> >
