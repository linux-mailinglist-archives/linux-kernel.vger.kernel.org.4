Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845F26C390A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCUSTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCUSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:19:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CBF2A141
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:19:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so10053434wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679422756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErwMWlj0m7Ed7L44j6GJW0I53a91wVg7S8I7G3LRnVM=;
        b=EZdlirTe300sQ6VFDfG085i0dBjvCVKPtqtSEqx95CsXVKzc7qvyLONaW0wSU6nz9h
         kmpEexqxpQmaBeYRVRvg9kgTuHkpuiaj9kPWH3KCUp3LrUZqCVeN6G24qljPn9MxIz1n
         Pkqs7HZzUreH6LxwvbcimptTSmLChxbn4v6pYmIi8vFbZ6ZLSxsDubcReVg1giWyYgK2
         dKZEolVPLSr1d1fmJstQSIOh8DdBjd8kTBMFlLp+8JYCLqelEi/1L1NGUjp0NgB/m2vv
         5vDRKZ3n9oZnVo7qE1Dh0zJD9Gzgl1LpoLgI8RVbUjkJEppvuGS8FIoCRVkpeZk4l/Ck
         tXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErwMWlj0m7Ed7L44j6GJW0I53a91wVg7S8I7G3LRnVM=;
        b=l/n7K3FVJCJwNy6SjjKdI0voERdddmsSNO8HBJGdj4vYHlL8FWCj7xGoQWOwvWg1hJ
         PXAY5o6DJ88kmkFh3uaW3ZQgmE8PBAWiMqCeouBnB1aI5SJwMweMh6v21oKsogkxfofH
         9kHiu3kO+R9miZYTrkSg3ApZSifJihiBuLS9ac5gvNWauVfxG+77qBTOLjYnNggGlDHz
         bSVcOeuG2Xr/jnYCVbKKmPH1ol7GOml2rOo655H67ZkvpGaisDr6miNQ01ZYRGMsD7HY
         E+TNz69e+rVrW326w3iV30RZTzx9LXAj5MFASSbB4SyXqa4KjUG3dHTZmQEx3ndL+UBo
         m6vQ==
X-Gm-Message-State: AO0yUKWCCWnBk/XKrNMOri9MmTLubSY1cBKSLVvt0+P21arqtr3hn3lJ
        tYwaIVJQUVBVfRBQ1bdchnYPnvqZ7HV5o0NYuQA=
X-Google-Smtp-Source: AK7set/W+oxb1F20/H2SfPQwyX+8aj6mad+9PU8lSKyowTNxrcuvAWMo38d9A8ngua1w9H3DHCSfyReldMJ8Yyr2OFA=
X-Received: by 2002:a1c:7404:0:b0:3dc:433a:e952 with SMTP id
 p4-20020a1c7404000000b003dc433ae952mr3174878wmc.33.1679422755859; Tue, 21 Mar
 2023 11:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com>
In-Reply-To: <20230308073201.3102738-1-avagin@google.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 21 Mar 2023 11:19:03 -0700
Message-ID: <CANaxB-yLtPvd7z-9-dAGAM98hjFqTpN_oHbbpCawtFrPW6JBWQ@mail.gmail.com>
Subject: Re: [PATCH 0/6 v5 RESEND] seccomp: add the synchronous mode for seccomp_unotify
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Andrei Vagin <avagin@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
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

On Tue, Mar 7, 2023 at 11:32=E2=80=AFPM Andrei Vagin <avagin@google.com> wr=
ote:
>
> seccomp_unotify allows more privileged processes do actions on behalf
> of less privileged processes.
>
> In many cases, the workflow is fully synchronous. It means a target
> process triggers a system call and passes controls to a supervisor
> process that handles the system call and returns controls back to the
> target process. In this context, "synchronous" means that only one
> process is running and another one is waiting.
>
> The new WF_CURRENT_CPU flag advises the scheduler to move the wakee to
> the current CPU. For such synchronous workflows, it makes context
> switches a few times faster.
>
> Right now, each interaction takes 12=C2=B5s. With this patch, it takes ab=
out
> 3=C2=B5s.
>
> v2: clean up the first patch and add the test.
> v3: update commit messages and a few fixes suggested by Kees Cook.
> v4: update the third patch to avoid code duplications (suggested by
>     Peter Zijlstra)
>     Add the benchmark to the perf bench set.
> v5: Update the author email. No code changes.
>
> Kees is ready to take this patch set, but wants to get Acks from the
> sched folks.

Peter, could you review the second and third patches of this series?

Thanks,
Andrei
