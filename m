Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCC96DCCE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDJVoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDJVov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:44:51 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F8173E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:44:50 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h198so12574278ybg.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681163089; x=1683755089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fqJKygNcTwYXqE/W6HnsQWcXW83jUHOxTtEqQQFCCQ=;
        b=c8gGW9KEuUs7rOxRy31qPsb5UswCPfrRfqTb0L97WfXCBmTDp1kP7o+kOv1iiUZNxa
         Lc7XrALeZ43cdvsL5ChYw5E/BViCfJHj8cjUk8BE7YDRTUWxDMcsG0D0W7VYXtSQefgp
         fbV5QjibYa0q+unpvL5PUVWs5aGUlCfuih1I8/0uqSWe42iN3cO9WgV68A2tDis0uF67
         J4dWNfpWzVf5r+xmiIMt+6kgDAeHk+TSdkHiA5C4OjKepRdlTcaQrQErR/Ao/ae/Y7Yo
         K/5VYanNEQOKwqVaYLvETpgywJl6QxAlUozFRcx6V4ypX4MQabwP9YpEWDJvnRmBHT5W
         QKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681163089; x=1683755089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fqJKygNcTwYXqE/W6HnsQWcXW83jUHOxTtEqQQFCCQ=;
        b=zirOf7dFFhXjbBENXt6PxNeVq/64ebzYEvf+bv9S3EO2XffAn2T8DLIp9uwoWaAsA+
         glfRvBIhNPsCctpA9ZG+LtDGk3ycwPkQAQPfCVTjctzhreioxYYo644OhptIPik2R42s
         PyFTyBHFQDENasdM0IUvsHnOVFqv+ELy6j+qbjy8unkDqMnavKszEjwVdAsiEmpb+IgG
         IRTIfVqtSqTcmwu6GbQBIZfQ14Rb0suq9HEX0AkgCHpHz19Nc4QR2aO7hZnuY05F0mdq
         OuArqsIfLSSKls3XDtYd3abUZlbmcv/T5kPFrpwbN8ZVcsQdNCSCtVdLDqafB5IhWza0
         6Qfg==
X-Gm-Message-State: AAQBX9epVAKMgVUcvr0hJ+VlkDzY3GPmitSADZhIOC5bhqOPg6pnvVRt
        uDk3mta1br1tswBHMBRQrIUGbE9J8XcPd/cUNH2U
X-Google-Smtp-Source: AKy350bw7pWEBerXtD57WYRkTF0n63gFcuFSKH0/ueLBXUsY3z6l7NJlgmPBBAhKqYb2e6cxx21TLQycOA6L5f9O+wE=
X-Received: by 2002:a25:d70d:0:b0:b68:7a4a:5258 with SMTP id
 o13-20020a25d70d000000b00b687a4a5258mr7739153ybg.3.1681163089576; Mon, 10 Apr
 2023 14:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com> <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
 <ZC8eZ/RTX//0urV/@char.us.oracle.com> <CAHC9VhR06pa2mDwW26XFqiry11Ubz2_3YKj+ayftu0JdYx9m9w@mail.gmail.com>
 <93ef5db7-fb4d-bf3f-9456-3fb6e7d5ca29@oracle.com> <CAHC9VhRKzv4+fbSK8+fV7v+N5Eaevtag7YvSW1YwJrxs5gAyHQ@mail.gmail.com>
 <fa0a4afb-14ce-a387-ec0e-2098c5bec8c3@oracle.com>
In-Reply-To: <fa0a4afb-14ce-a387-ec0e-2098c5bec8c3@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Apr 2023 17:44:38 -0400
Message-ID: <CAHC9VhT4r4HwrfZMVbG8DWbfvVRGH_AMGpdVUS_YLmUR7L3uvw@mail.gmail.com>
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

On Mon, Apr 10, 2023 at 5:28=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.com> =
wrote:
> On 4/10/23 1:22 PM, Paul Moore wrote:
> > On Mon, Apr 10, 2023 at 3:20=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.c=
om> wrote:
> >> On 4/6/23 2:43 PM, Paul Moore wrote:
> >>> On Thu, Apr 6, 2023 at 3:33=E2=80=AFPM Konrad Rzeszutek Wilk
> >>> <konrad.wilk@oracle.com> wrote:
> >>>> On Thu, Apr 06, 2023 at 02:39:57PM -0400, Paul Moore wrote:
> >>> ...
> >>>
> >>>>> Before we go any further, can you please verify that your issue is
> >>>>> reproducible on a supported, upstream tree (preferably Linus')?
> >>>> Yes. Very much so.
> >>> Okay, in that case I suspect the issue is due to the somewhat limited
> >>> granularity in the lockdown LSM.  While there are a number of
> >>> different lockdown "levels", the reality is that the admin has to
> >>> choose from either NONE, INTEGRITY, or CONFIDENTIALITY.  Without
> >>> digging to deep into the code path that you would be hitting, we can
> >>> see that TRACEFS is blocked by the CONFIDENTIALITY (and therefore
> >>> INTEGRITY too) setting and DEBUGFS is blocked by the INTEGRITY
> >>> setting.  With DEBUGFS blocked by INTEGRITY, the only lockdown option
> >>> that would allow DEBUGFS is NONE.
> >>>
> >>> Without knowing too much about blktrace beyond the manpage, it looks
> >>> like it has the ability to trace/snoop on the block device operations
> >>> so I don't think this is something we would want to allow in a
> >>> "locked" system.
> >> blktrace depends on tracepoint in block layer to trace io events of
> >> block devices,
> >>
> >> through the test with mainline, those tracepoints were not blocked by
> >> lockdown.
> >>
> >> If snoop block devices operations is a security concern in lock down, =
these
> >>
> >> tracepoints should be disabled?
> > Possibly, however, as I said earlier I'm not very familiar with
> > blktrace and the associated tracepoints.  If it is possible to snoop
> > on kernel/user data using blktrace then it probably should be
> > protected by a lockdown control point.
> >
> > Is this something you could verify and potentially submit a patch to re=
solve?
>
> blktrace can not snoop kernel/user data. The information it got from
> kernel is kind of "io metadata", basically include which process from
> which cpu, at what time, triggered what kind of IO events(issue, queue,
> complete etc.), to which disk, from which sector offset and how long.
> blktrace has no way to know what's inside that io. I am kind of think
> this is safe for lockdown mode.

Well, you could always submit a patch* and we would review it like any
other; that's usually a much better approach.

* Yes, there was a patch submitted, but it was against a distro kernel
that diverged significantly from the upstream kernel in the relevant
areas.

--=20
paul-moore.com
