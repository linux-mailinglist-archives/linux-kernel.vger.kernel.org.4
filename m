Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8119266A155
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjAMR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjAMR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:59:08 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0518E99C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:52:13 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d62so7116683ybh.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xeo8qLgvq3RAyROFUCt35wkutSfWDp8XJ4vtPJZ25wQ=;
        b=spT5XiaL0xTK/sMQVdD9NnklrwAgoXK3aun0hemMPSyc2CPUZD08GVesdpQsjm3d8D
         UeBTZCDzbTkq7SxeWvGB4hwMCrJX86W7S2CHWDDXgLVM2xZBZFw3nn6gFUeUHIxbiyIX
         gqixKmK+aORuZUp8Wie8OYLH5L6TK3bfT0rqVp9UPD1Ez//Ghs4txvCyLQMhsrqGohTJ
         bejCHVrade0Rxj2u6bYgmkRBpTNkmWyVMgvK274+YZghm0aTNMN7U22ZdqlUKLAWu7Pr
         L9QdprBSrEzDYqgyDc945Fm4hkbwHaO9deXzeaTt0kTncG2fQo1e34Zwt2IBReSdghpr
         UKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeo8qLgvq3RAyROFUCt35wkutSfWDp8XJ4vtPJZ25wQ=;
        b=cP1CMkx1f2p8+TeGrhsFUOXA/5hpKPRSGZIJzFDM9LcDc9eR4hgCnj89P8uGIAv75z
         cXo5j7btsDEMDd4Gj2jxrPZWuS20oUa4G7mTI7DhTsNy7eDbpIislY43c3BKyGXLShxc
         z0Xnv+qmYFXLoValpMrKq7y4+AbsnE4q5guwIRkbE9DAdRmw96G1vMrz6QGwhochKkNd
         LtLPsNemOv4ADZ7dw1eOKPd8524BueeilH+UDsn88F5CnNA7dSPOddgX9vxuN5izynms
         9qIoUUgZxVMtNlNMZSJDc/ub4KzgUMBTqvUdqtgymKtvr3GqQ865T6e4WqIYH0AU3EOv
         OB1g==
X-Gm-Message-State: AFqh2kr5cVWNFZ5m5C8S130+SGEGdMLRlePYmajorLuFcUWNzVELtI+/
        mdrLJU/PU82/TKThXQeEjEKK6XpV2WMc3lDy/SUTiQ==
X-Google-Smtp-Source: AMrXdXsQ8E6MeaHNSVCi6nZJNWDRD1UukV9PyuUENt+uWBToTATvEIb46yk8oi/VMFhJ0GLP3X9kCsnvKTyJEYWsnaw=
X-Received: by 2002:a25:bdcc:0:b0:714:2cb3:2450 with SMTP id
 g12-20020a25bdcc000000b007142cb32450mr8305881ybk.431.1673632332567; Fri, 13
 Jan 2023 09:52:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
 <20230113022555.2467724-1-kamatam@amazon.com>
In-Reply-To: <20230113022555.2467724-1-kamatam@amazon.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 13 Jan 2023 09:52:01 -0800
Message-ID: <CAJuCfpEH7kC=S8S_SRLW-X483kpaL4xdn5b35Ou08V7b56QdJA@mail.gmail.com>
Subject: Re: another use-after-free in ep_remove_wait_queue()
To:     Munehisa Kamata <kamatam@amazon.com>
Cc:     ebiggers@kernel.org, hannes@cmpxchg.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mengcc@amazon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 6:26 PM Munehisa Kamata <kamatam@amazon.com> wrote:
>
> On Thu, 2023-01-12 22:01:24 +0000, Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, Jan 9, 2023 at 7:06 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Mon, Jan 9, 2023 at 5:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Sun, Jan 8, 2023 at 3:49 PM Hillf Danton <hdanton@sina.com> wrote:
> > > > >
> > > > > On 8 Jan 2023 14:25:48 -0800 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > > > > >
> > > > > > That patch survived the repro in my original post, however, the waker
> > > > > > (rmdir) was getting stuck until a file descriptor of the epoll instance or
> > > > > > the pressure file got closed. So, if the following modified repro runs
> > > > > > with the patch, the waker never returns (unless the sleeper gets killed)
> > > > > > while holding cgroup_mutex. This doesn't seem to be what you expected to
> > > > > > see with the patch, does it? Even wake_up_all() does not appear to empty
> > > > > > the queue, but wake_up_pollfree() does.
> > > > >
> > > > > Thanks for your testing. And the debugging completes.
> > > > >
> > > > > Mind sending a patch with wake_up_pollfree() folded?
> > > >
> > > > I finally had some time to look into this issue. I don't think
> > > > delaying destruction in psi_trigger_destroy() because there are still
> > > > users of the trigger as Hillf suggested is a good way to go. Before
> > > > [1] correct trigger destruction was handled using a
> > > > psi_trigger.refcount. For some reason I thought it's not needed
> > > > anymore when we placed one-trigger-per-file restriction in that patch,
> > > > so I removed it. Obviously that was a wrong move, so I think the
> > > > cleanest way would be to bring back the refcounting. That way the last
> > > > user of the trigger (either psi_trigger_poll() or psi_fop_release())
> > > > will free the trigger.
> > > > I'll check once more to make sure I did not miss anything and if there
> > > > are no objections, will post a fix.
> > >
> > > Uh, I recalled now why refcounting was not helpful here. I'm making
> > > the same mistake of thinking that poll_wait() blocks until the call to
> > > wake_up() which is not the case. Let me think if there is anything
> > > better than wake_up_pollfree() for this case.
> >
> > Hi Munehisa,
> > Sorry for the delay. I was trying to reproduce the issue but even
> > after adding a delay before ep_remove_wait_queue() it did not happen.
>
> Hi Suren,
>
> Thank you for your help here.
>
> Just in case, do you have KASAN enabled in your config? If not, this may
> just silently corrupt a certain memory location and not immediately
> followed by obvious messages or noticeable event like oops.

Yes, KASAN was enabled in my build.

>
> > One thing about wake_up_pollfree() solution that does not seem right
> > to me is this comment at
> > https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L253:
> >
> > `In the very rare cases where a ->poll() implementation uses a
> > waitqueue whose lifetime is tied to a task rather than to the 'struct
> > file' being polled, this function must be called before the waitqueue
> > is freed...`
> >
> > In our case we free the waitqueue from cgroup_pressure_release(),
> > which is the handler for `release` operation on cgroup psi files. The
> > other place calling psi_trigger_destroy() is psi_fop_release(), which
> > is also tied to the lifetime to the psi files.  Therefore the lifetime
> > of the trigger's waitqueue is tied to the lifetime of the files and
> > IIUC, we should not be required to use wake_up_pollfree().
> > Could you please post your .config file? I might be missing some
> > configuration which prevents the issue from happening on my side.
>
> Sure, here is my config.
>
>  https://gist.github.com/kamatam9/a078bdd9f695e7a0767b061c60e48d50
>
> I confirmed that it's reliably reproducible with v6.2-rc3 as shown below.
>
>  https://gist.github.com/kamatam9/096a79cf59d8ed8785c4267e917b8675

Thanks! I'll try to figure out the difference.
Suren.

>
>
> Regards,
> Munehisa
>
>
> > Thanks,
> > Suren.
> >
> > >
> > >
> > > >
> > > > [1] https://lore.kernel.org/lkml/20220111232309.1786347-1-surenb@google.com/
> > > >
> > > > Thanks,
> > > > Suren.
> > > >
> > > > >
> > > > > Hillf
> >
> >
