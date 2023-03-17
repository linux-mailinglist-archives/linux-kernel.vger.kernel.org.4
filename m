Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988DD6BDF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCQDYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCQDYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:24:09 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B8305EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 20:24:07 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-322fc56a20eso546725ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 20:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679023446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCSqGOebHu9n0+LN2hjA/D9CVT3lWroxcYCRN+ofeiQ=;
        b=rHQzdoi2CX9fQW340JoiFV/kpUBw4XktPqgu89JP3yjO4oGcmTVQBOiACKzLdUlqF+
         mT2cSicfgi+Gn2ZSP35qt6U3LR6SwQndxkRKNaMXcNRYmW+cOWZ+Tz1B/a1v5ftsoiwh
         +zNQ3b51dAt47ONi2TpJIxrVRY+QDZUM8mBrEyHx98fFgtxN4M4US/V/pT5H+Y9We1nF
         ETHAfEMphFlbPG60i2kU/ZjTYCp5vqgvQKqe1ysbA6wzN9nl+4bA7oqPSOdy4a743ddR
         d6oWBkwy59Qr2YR1EeeRHPlhJ6hWPY0jOJzWDbATlhrLcQstsIOO3neCxbcxVC394EID
         oFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679023446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCSqGOebHu9n0+LN2hjA/D9CVT3lWroxcYCRN+ofeiQ=;
        b=LJybrfu4gw/ygEj0r75oyE5ureVQQQAOrnRv46u11XkNiWg5YLdgCPpi3pMLqDpa8N
         IdrD8bWSqMi6Pi+dztLI2oZmTGaYnguSFrh3DxPatppQjT1cyP6HKGURar3AZ/rCg5cj
         nW2uhZKb0EVOgzxai2omaJt3GIbODo6bb0fKsLLtn3fMxByBOUfdxEzk3SsfXh/ocaNq
         +69y6fXCvmj+XFPp2l6y9R6K3vSsxmXHm7Mf05afjPu6CzYUxhCqPyk5YxH3hZ8yMCdO
         fFnmRPyji34C9+PEDteV/US2x+Q9+h8rDej4kGAAVRrCC7OxkWHyXXA8AQSkiOfOnS1u
         65Mw==
X-Gm-Message-State: AO0yUKVIA440rrh9AOoqO8UP70enVnG6OIfJoO0Udz15uRnJ5jGJPLNS
        rW46W41siTOaG4IohSlntzEzlO+piP1er36MYtxJFUQbwE7Ao1JIqg2kpA==
X-Google-Smtp-Source: AK7set8fy1ymfsgvlr9vEFIjHhSd8uxk3XJxK49NVVJzHl/PPrc60KC3nHEcL1q76E1x0k7Xt+TBhYxqkdMC9FClvzk=
X-Received: by 2002:a05:6e02:1bc1:b0:322:2970:1950 with SMTP id
 x1-20020a056e021bc100b0032229701950mr201121ilv.8.1679023446246; Thu, 16 Mar
 2023 20:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230317095025.49aa34f9@canb.auug.org.au> <7D15C431-1AB6-482E-B4B9-289A15C0E2E4@gmail.com>
 <20230317105513.591a6383@canb.auug.org.au>
In-Reply-To: <20230317105513.591a6383@canb.auug.org.au>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 16 Mar 2023 20:23:52 -0700
Message-ID: <CAP-5=fXzFUjbHE=qX89QX-CquT46L9-EcGEJ2L2--1k3ZMF_VQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the perf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 16, 2023 at 4:55=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi Arnaldo,
>
> On Thu, 16 Mar 2023 20:11:11 -0300 Arnaldo Carvalho de Melo <arnaldo.melo=
@gmail.com> wrote:
> >
> > Can you try adding NO_BPF_SKEL=3D1 to the make -C tools/perf command li=
ne?
>
> That made it build.  Can that be automated, or is there something else
> I need to install to make it work?  Or, at least can the error be made
> more informative?

Good idea. I'll look into a feature test to cover this. For context
the change that altered the behavior was:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
perf-tools-next&id=3Da980755beb5aca9002e1c95ba519b83a44242b5b

Thanks,
Ian

> --
> Cheers,
> Stephen Rothwell
