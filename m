Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2F2686330
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBAJyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjBAJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:53:59 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED234A211
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:53:58 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h17so18789894ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXBLBJgX4EaRecabGDlsbhKYn/5vHTxOlvqGwGoHBPg=;
        b=kGuhkOUGRiUBb82xnq/SP0PH18a2BT8S1d4JOz6WZAZJ1pjUkuD2ixPSt46h0gUfdn
         J3o7C+wF049nP5XsvuPSv8RTjjoa+/1JV25eSAFAAv2IOBY89cp3vnPTRwYpWB2pc5H6
         amZqseA7VDjMshiL4mh2kEhmuLUFXriQM27ALI2dFc8fl17ujHHsZznv3QFMa4A7hrgi
         XUJIrFiCgPSrYWwCLPGPLNvO0v5FGURdM1IFSgnm93n1+YkLwpLK3thl+ZyURoKwx/zO
         ocsJuUvX9Dq8NAHuAgOXho0n+QyU73sM+n8n5iF30fuV/k+QzbmwhlTNOMaOXeEE4xlr
         hIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXBLBJgX4EaRecabGDlsbhKYn/5vHTxOlvqGwGoHBPg=;
        b=iQjYjS/GBcZL580iWbzc5cgfEqhnM06nWqMACrk+77iUSXyxt+5AdYCQrIGcwX4oRB
         3wI3WwprQSoYKuN2+z6Ib4iVNlXGSjXDt+R52+EO7VAFItkORx85F68Amwpgqhez1FDK
         GAfHlRaO0ly1vXICDFdaAwQxSWJTSxageE67unttmemp/m/xFXB9WfVUrCLR3LcqMh0G
         mHum4smJHCH7oZ8ZKShZoXi5H5M9QroEtXd2To3OAngvggFs8VVc7k3+7kqLbRgUJa2A
         j+qeXi4jWt3bKYeoQuN6WHpKwmdvSGOindvpQUCHQKKYuyTGMKkSlvwI+btisBElt6iK
         PYNw==
X-Gm-Message-State: AO0yUKWs1M+WXVuNW3wGQFAoMqXSch25hOODrZ37cJ5U90RqS3OjocJl
        SuYzeElhR4jFfHucXFm+8BXreqNlIbO800NmfiFh/g==
X-Google-Smtp-Source: AK7set/SnkQ6D+DOsTEIwKu7gH1tVuc4Aop2ZxyXy/5CnDm05inFo7TpmqVd2reBirxiOQVXt78QUDARAskOvz3HHq0=
X-Received: by 2002:a05:651c:231b:b0:290:7402:78a1 with SMTP id
 bi27-20020a05651c231b00b00290740278a1mr233501ljb.183.1675245236576; Wed, 01
 Feb 2023 01:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20230127162409.2505312-1-elver@google.com> <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
 <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com>
 <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N> <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
In-Reply-To: <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Feb 2023 10:53:44 +0100
Message-ID: <CACT4Y+Yriv_JYXm9N1YAMh+YuiT57irnF-vyCqxnTTux-2Ffwg@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Allow restricted kernel breakpoints on user addresses
To:     Marco Elver <elver@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Konovalov <andreyknvl@gmail.com>
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

On Wed, 1 Feb 2023 at 10:34, Marco Elver <elver@google.com> wrote:
>
> On Mon, 30 Jan 2023 at 11:46, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
> > > This again feels like a deficiency with access_ok(). Is there a better
> > > primitive than access_ok(), or can we have something that gives us the
> > > guarantee that whatever it says is "ok" is a userspace address?
> >
> > I don't think so, since this is contextual and temporal -- a helper can't give
> > a single correct answert in all cases because it could change.
>
> That's fair, but unfortunate. Just curious: would
> copy_from_user_nofault() reliably fail if it tries to access one of
> those mappings but where access_ok() said "ok"?

I also wonder if these special mappings are ever accessible in a user
task context?
If yes, can a racing process_vm_readv/writev mess with these special mappings?

We could use copy_from_user() to probe that the watchpoint address is
legit. But I think the memory can be potentially PROT_NONE but still
legit, so copy_from_user() won't work for these corner cases.

> Though that would probably restrict us to only creating watchpoints
> for addresses that are actually mapped in the task.
>
> > In the cases we switch to another mapping, we could try to ensure that we
> > enable/disable potentially unsafe watchpoints/breakpoints.
>
> That seems it'd be too hard to reason that it's 100% safe, everywhere,
> on every arch. I'm still convinced we can prohibit creation of such
> watchpoints in the first place, but need something other than
> access_ok().
>
> > Taking a look at arm64, our idmap code might actually be ok, since we usually
> > mask all the DAIF bits (and the 'D' or 'Debug' bit masks HW
> > breakpoints/watchpoints). For EFI we largely switch to another thread (but not
> > always), so that would need some auditing.
> >
> > So if this only needs to work in per-task mode rather than system-wide mode, I
> > reckon we can have some save/restore logic around those special cases where we
> > transiently install a mapping, which would protect us.
>
> It should only work in per-task mode.
>
> > For the threads that run with special mappings in the low half, I'm not sure
> > what to do. If we've ruled out system-wide monitoring I believe those would be
> > protected from unprivileged users.
>
> Can the task actually access those special mappings, or is it only
> accessible by the kernel?
>
> Thanks,
> -- Marco
