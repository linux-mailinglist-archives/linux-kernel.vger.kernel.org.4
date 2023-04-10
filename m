Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4436DCD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDJWBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDJWBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:01:11 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A03A19B9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:01:10 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54c17fa9ae8so223416347b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681164069; x=1683756069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bED5ulcYb93j7wfobicz3Hdy0GnTvYMsiawFSUzL6rc=;
        b=XzRGT16d9rRlYCQG9GGVljhDILPR2ri+sbEeL1QSJb5nhg6MEtND6YxMfqgjkyCIDO
         lTtnDv4+ALmYDsiqFWYUBeYXMCQj5dfKhHcb7k+UhMIgAUxYCSSoZEzGSaWq+EKe6XEA
         eNzw/z/QMnyF+ory62D7Rk1lOdX096anN2YCtvH7H+4rV4z1b22lPX2C1fG2GwYHdFKz
         mYU87suz8C+zZaftzWv5lZX9b+pcHdWbOBm1mwcHR5LPsne3m7ADaTbmNZSjw4gOJKIt
         kYs0kSJYSHhqyJ/rJcTfz8Uu/OrdmX4b6xny3YfUKkTtk4bmtaFr8+00MKTY5T75NRPX
         pkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164069; x=1683756069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bED5ulcYb93j7wfobicz3Hdy0GnTvYMsiawFSUzL6rc=;
        b=A9NTRjQ35BswKYFU6nnhYFkE81bxu0Kksu/Jvj7lBaaG9VoPVicfPlJyVa290uYKOE
         +b8Um58y3N7/qGEd/2KWa/I9zEzkXBDHLeiSgbbZCUMWr08+wxdFv+DQhs6zC2vSDcOa
         Rjmz8Ya0AhJj04xJ6mIdx1kwQEvK37OQJEOJd7VQ46qXRkWodwtMJ8tq347p8pqMafzV
         si68OdLKowboQYUjqxKm6prCNgC0Az2/fJKDzCPhwFJiSl8e9XiJhJvUfxo4XTDkibP9
         7RxDXDbKEZQduQ4W2xtT39P+8YzvhNGYRZmxQNd7KxV+bZFXv5x4vmZtqdTPtmmXtL73
         /zPQ==
X-Gm-Message-State: AAQBX9cl7Mjxfo293tsiiJMJxA9MeTCcwyFUyqackHteIWhr53D0S2s6
        p+PO43IgfQ+8rnVUggxio+nUWkyTeuBrAd+fWvLMpK5LTl/DJ+wvmA==
X-Google-Smtp-Source: AKy350Yi3gA7dvgXkn1sNPNyxzSbt7y/VHwseoXjrAGhdGRJuckRp8GKqQoI2CMH2yRGDas8Uzngwo1roVjDAwykMXY=
X-Received: by 2002:a81:a744:0:b0:54f:69a4:151e with SMTP id
 e65-20020a81a744000000b0054f69a4151emr326196ywh.8.1681164069123; Mon, 10 Apr
 2023 15:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com> <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
 <ZC8eZ/RTX//0urV/@char.us.oracle.com> <CAHC9VhR06pa2mDwW26XFqiry11Ubz2_3YKj+ayftu0JdYx9m9w@mail.gmail.com>
 <93ef5db7-fb4d-bf3f-9456-3fb6e7d5ca29@oracle.com> <CAHC9VhRKzv4+fbSK8+fV7v+N5Eaevtag7YvSW1YwJrxs5gAyHQ@mail.gmail.com>
 <fa0a4afb-14ce-a387-ec0e-2098c5bec8c3@oracle.com> <CAHC9VhT4r4HwrfZMVbG8DWbfvVRGH_AMGpdVUS_YLmUR7L3uvw@mail.gmail.com>
 <cdde1e4e-142e-3859-71ba-f7bacf0dbaae@oracle.com>
In-Reply-To: <cdde1e4e-142e-3859-71ba-f7bacf0dbaae@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Apr 2023 18:00:58 -0400
Message-ID: <CAHC9VhSiviD9uHmB5sK4vgBBYnhUBPFyu+zM+O2m4ycie3RVqQ@mail.gmail.com>
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, joe.jin@oracle.com,
        Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 5:52=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.com> =
wrote:
> On 4/10/23 2:44 PM, Paul Moore wrote:
> > On Mon, Apr 10, 2023 at 5:28=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.c=
om> wrote:
> >> On 4/10/23 1:22 PM, Paul Moore wrote:
> >>> On Mon, Apr 10, 2023 at 3:20=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle=
.com> wrote:
> >>>> On 4/6/23 2:43 PM, Paul Moore wrote:
> >>>>> On Thu, Apr 6, 2023 at 3:33=E2=80=AFPM Konrad Rzeszutek Wilk
> >>>>> <konrad.wilk@oracle.com> wrote:
> >>>>>> On Thu, Apr 06, 2023 at 02:39:57PM -0400, Paul Moore wrote:
> >>>>> ...
> >>>>>
> >>>>>>> Before we go any further, can you please verify that your issue i=
s
> >>>>>>> reproducible on a supported, upstream tree (preferably Linus')?
> >>>>>> Yes. Very much so.
> >>>>> Okay, in that case I suspect the issue is due to the somewhat limit=
ed
> >>>>> granularity in the lockdown LSM.  While there are a number of
> >>>>> different lockdown "levels", the reality is that the admin has to
> >>>>> choose from either NONE, INTEGRITY, or CONFIDENTIALITY.  Without
> >>>>> digging to deep into the code path that you would be hitting, we ca=
n
> >>>>> see that TRACEFS is blocked by the CONFIDENTIALITY (and therefore
> >>>>> INTEGRITY too) setting and DEBUGFS is blocked by the INTEGRITY
> >>>>> setting.  With DEBUGFS blocked by INTEGRITY, the only lockdown opti=
on
> >>>>> that would allow DEBUGFS is NONE.
> >>>>>
> >>>>> Without knowing too much about blktrace beyond the manpage, it look=
s
> >>>>> like it has the ability to trace/snoop on the block device operatio=
ns
> >>>>> so I don't think this is something we would want to allow in a
> >>>>> "locked" system.
> >>>> blktrace depends on tracepoint in block layer to trace io events of
> >>>> block devices,
> >>>>
> >>>> through the test with mainline, those tracepoints were not blocked b=
y
> >>>> lockdown.
> >>>>
> >>>> If snoop block devices operations is a security concern in lock down=
, these
> >>>>
> >>>> tracepoints should be disabled?
> >>> Possibly, however, as I said earlier I'm not very familiar with
> >>> blktrace and the associated tracepoints.  If it is possible to snoop
> >>> on kernel/user data using blktrace then it probably should be
> >>> protected by a lockdown control point.
> >>>
> >>> Is this something you could verify and potentially submit a patch to =
resolve?
> >> blktrace can not snoop kernel/user data. The information it got from
> >> kernel is kind of "io metadata", basically include which process from
> >> which cpu, at what time, triggered what kind of IO events(issue, queue=
,
> >> complete etc.), to which disk, from which sector offset and how long.
> >> blktrace has no way to know what's inside that io. I am kind of think
> >> this is safe for lockdown mode.
> > Well, you could always submit a patch* and we would review it like any
> > other; that's usually a much better approach.
> >
> > * Yes, there was a patch submitted, but it was against a distro kernel
> > that diverged significantly from the upstream kernel in the relevant
> > areas.
>
> Sure, i will submit a new one.
>
> Before that, may i ask this question? It may affect the approach of the
> patch.
>
> Lockdown blocked files with mmap operation even that files are
> read-only, may i know what's the security concern there?
>
> static int debugfs_locked_down(struct inode *inode,
>                     struct file *filp,
>                     const struct file_operations *real_fops)
> {
>      if ((inode->i_mode & 07777 & ~0444) =3D=3D 0 &&
>          !(filp->f_mode & FMODE_WRITE) &&
>          !real_fops->unlocked_ioctl &&
>          !real_fops->compat_ioctl &&
>          !real_fops->mmap)
>          return 0;
>
>      if (security_locked_down(LOCKDOWN_DEBUGFS))
>          return -EPERM;
>
>      return 0;
> }

I think the comment block at the top of that function describes it well:

/*
 * Only permit access to world-readable files when the kernel is locked dow=
n.
 * We also need to exclude any file that has ways to write or alter it as r=
oot
 * can bypass the permissions check.
 */

--
paul-moore.com
