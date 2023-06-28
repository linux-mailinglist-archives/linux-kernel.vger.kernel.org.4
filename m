Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7386C7408D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 05:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjF1DKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 23:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF1DKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 23:10:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC19B297B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:09:58 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bd77424c886so5482238276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687921798; x=1690513798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vagTGpTUaZlXydrigYBV1OCPnqllXVBPgX2++V6MWg4=;
        b=rCbJWy+WBhexAYaZLgCj2xNvXbG6ankNokcPs7WfRtizxvxmlQCUydEN2BRWtw6CAy
         E1MZltbxf1Hw34ZUjhZFgDXHsziHluQnJC0OVWvKwye6zbGatQJaDsAwqn9E5zsn+cHg
         SwbiS4iv6tv1+rbm6/8TGzQOeHm9wBMsu988u/UO+Ox8zwfg7dTa0BMgkXNGF7+Pys65
         qJA1LCbWbMFthy5uOg4iIYoTL31RL4VxwfXEQVerGDY/Q+P2TfDooDgl8XsQE2JI9ZVX
         C6XWcRIbPFgSQG5AfleMe4ztE2JcfaeBe4S3lr6TB8uCVl5TgFJF8MB5D7PZUAk+N7Mg
         l7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687921798; x=1690513798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vagTGpTUaZlXydrigYBV1OCPnqllXVBPgX2++V6MWg4=;
        b=Y4CgMIY3IZ6YuDnTFRZhCKZMa3wjzU/jRvbcXgV0BMP6Ts1anpCg7KW1m5/EKJe70K
         skxvueSY3ogiBxn4xb4JGuJmIiWb+k/qQe6z2Qxc6Kxs0X/7a7XpziL0V0IJP58tHWs6
         gq8xuQA1u6qFgn79rPPlr2659ohoeqwuNR1mxXJZiOBqvb4sGNPvHrtQdK4RZ5Vxe3+6
         V523pFvzNuEDiFR1BBHAKvkjTKKavx2aF3T42fH3SHF4Wtvybo/VgcxEXYPLldkmAVRp
         MiKTS0Qo3DXW/Pysl+aW1wGEuyv7NZC4KdpO6E1VlSjruV/D5jI4vLQVRzMr0Cwiusbk
         riSg==
X-Gm-Message-State: AC+VfDz2UTHTxpEpqKQSgF7nYr+NJuq3reXGh4Z2EOe81hbwzq8Ym3SK
        5dqxia2PHOciFf5Wikl0VOUp1Aly/HfxarKDeJ9opw==
X-Google-Smtp-Source: ACHHUZ7hgdQdjC9qnYIhyF8art6M0NO7Xb10alW4Mpwp89HcOw8cINPIDN4eso8ktdtVuN/7Gt4HUbL8ufPkLDiUE6Q=
X-Received: by 2002:a25:41d3:0:b0:ba7:ca1d:70f3 with SMTP id
 o202-20020a2541d3000000b00ba7ca1d70f3mr32633255yba.39.1687921797930; Tue, 27
 Jun 2023 20:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com> <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner> <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner> <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
 <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
 <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
 <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com> <ZJuSzlHfbLj3OjvM@slm.duckdns.org>
In-Reply-To: <ZJuSzlHfbLj3OjvM@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 20:09:46 -0700
Message-ID: <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 6:54=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jun 27, 2023 at 02:58:08PM -0700, Suren Baghdasaryan wrote:
> > Ok in kernfs_generic_poll() we are using kernfs_open_node.poll
> > waitqueue head for polling and kernfs_open_node is freed from inside
> > kernfs_unlink_open_file() which is called from kernfs_fop_release().
> > So, it is destroyed only when the last fput() is done, unlike the
> > ops->release() operation which we are using for destroying PSI
> > trigger's waitqueue. So, it seems we still need an operation which
> > would indicate that the file is truly going away.
>
> If we want to stay consistent with how kernfs behaves w.r.t. severing, th=
e
> right thing to do would be preventing any future polling at severing and
> waking up everyone currently waiting, which sounds fine from cgroup behav=
ior
> POV too.

That's actually what we are currently doing for PSI triggers.
->release() is handled by cgroup_pressure_release() which signals the
waiters, waits for RCU grace period to pass (per
https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L258)
and then releases all the trigger resources including the waitqueue
head. However as reported in
https://lore.kernel.org/all/20230613062306.101831-1-lujialin4@huawei.com
this does not save us from the synchronous polling case:

                                                  do_select
                                                      vfs_poll
cgroup_pressure_release
    psi_trigger_destroy
        wake_up_pollfree(&t->event_wait) -> unblocks vfs_poll
        synchronize_rcu()
        kfree(t) -> frees waitqueue head
                                                     poll_freewait()
-> uses waitqueue head


This happens because we release the resources associated with the file
while there are still file users (the file's refcount is non-zero).
And that happens because kernfs can call ->release() before the last
fput().

>
> Now, the challenge is designing an interface which is difficult to make
> mistake with. IOW, it'd be great if kernfs wraps poll call so that severi=
ng
> is implemented without kernfs users doing anything, or at least make it
> pretty obvious what the correct usage pattern is.
>
> > Christian's suggestion to rename current ops->release() operation into
> > ops->drain() (or ops->flush() per Matthew's request) and introduce a
> > "new" ops->release() which is called only when the last fput() is done
> > seems sane to me. Would everyone be happy with that approach?
>
> I'm not sure I'd go there. The contract is that once ->release() is calle=
d,
> the code backing that file can go away (e.g. rmmod'd). It really should
> behave just like the last put from kernfs users' POV.

I 100% agree with the above statement.

> For this specific fix,
> it's safe because we know the ops is always built into the kernel and won=
't
> go away but it'd be really bad if the interface says "this is a normal th=
ing
> to do". We'd be calling into rmmod'd text pages in no time.
>
> So, I mean, even for temporary fix, we have to make it abundantly clear t=
hat
> this is not for usual usage and can only be used if the code backing the =
ops
> is built into the kernel and so on.

I think the root cause of this problem is that ->release() in kernfs
does not adhere to the common rule that ->release() is called only
when the file is going away and has no users left. Am I wrong?
Thanks,
Suren.

>
> Thanks.
>
> --
> tejun
