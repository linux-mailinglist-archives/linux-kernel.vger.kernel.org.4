Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098846DC57F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDJKDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjDJKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:03:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9344D3580;
        Mon, 10 Apr 2023 03:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E94C61198;
        Mon, 10 Apr 2023 10:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE77C4339B;
        Mon, 10 Apr 2023 10:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681121022;
        bh=X6mFdrcKBloByjl+W+HqhTL0wxXMHJsugPyYCIhiCuQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BXKaFHIauq0W0rEqTd0dU4B313rWlL/ab5aUxj23oPqxYYDxfeD8UdorVlEHCgN52
         kY+L6h0Of+F/fSfFeCPKA5o23nc0M0RScNtORjnXoU4hw2Q3pmujZzviQI1yhWdEdJ
         UvYxTe9oZTIwQiQGFIeDiYl05ptRMeHeEo158Y/aHy62emMgLNxD/hd1cgB2dDKLCn
         HtHLZM019uiDOliPMHCrzctOyC69cc+Z3yMqCUhpbgY1W83YkY/0vopNeoPVt7urqO
         D4qW+N5iXcExVXt48enOYupVy8QYw7FRkIEM1rMl4ng2UIVANDqska3oAPKISMLp2h
         6QiWs+HApLPag==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1842e8a8825so5317354fac.13;
        Mon, 10 Apr 2023 03:03:42 -0700 (PDT)
X-Gm-Message-State: AAQBX9dk+LdZK4izVP217e8q+qo2HYfpxyLYLYRoGDu3ow2BDbGFtWA7
        vqw14hqGW/0w5EAXESQyDYefIQweaSAcg8Ncotw=
X-Google-Smtp-Source: AKy350ZSMPsXHOZRqPbQgGcdegDIS4ZvZkviKutYNlqfA6bckwfU2TPWc8FRAmTHiCTn7pfKyZgtA7inGf0zF4Q/NSs=
X-Received: by 2002:a05:6870:5594:b0:17f:f1f4:b006 with SMTP id
 n20-20020a056870559400b0017ff1f4b006mr4967756oao.11.1681121021823; Mon, 10
 Apr 2023 03:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230407203456.27141-1-quic_johmoo@quicinc.com> <20230407203456.27141-2-quic_johmoo@quicinc.com>
In-Reply-To: <20230407203456.27141-2-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 10 Apr 2023 19:03:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
Message-ID: <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023 at 5:35=E2=80=AFAM John Moon <quic_johmoo@quicinc.com> =
wrote:
>
> While the kernel community has been good at maintaining backwards
> compatibility with kernel UAPIs, it would be helpful to have a tool
> to check if a commit introduces changes that break backwards
> compatibility.
>
> To that end, introduce check-uapi.sh: a simple shell script that
> checks for changes to UAPI headers using libabigail.
>
> libabigail is "a framework which aims at helping developers and
> software distributors to spot some ABI-related issues like interface
> incompatibility in ELF shared libraries by performing a static
> analysis of the ELF binaries at hand."
>
> The script uses one of libabigail's tools, "abidiff", to compile the
> changed header before and after the commit to detect any changes.
>
> abidiff "compares the ABI of two shared libraries in ELF format. It
> emits a meaningful report describing the differences between the two
> ABIs."
>
> The script also includes the ability to check the compatibility of
> all UAPI headers across commits. This allows developers to inspect
> the stability of the UAPIs over time.
>
> Signed-off-by: John Moon <quic_johmoo@quicinc.com>



BTW, is there anybody (except the submitters) who loves this tool?
(or anybody who has ever evaluated this?)

I am the only person who pointed out something.



I put some more comments from users' point of view.





[1] The number of lines of the error log.


According to this tool, it looks like we broke a lot of UAPI
headers in the previous MW (between v6.2 and v6.3-rc1).

Not only in the previous MW, we always broke so many UAPI
headers, this script says.


The following command outputs 2380 lines.


$ ./scripts/check-uapi.sh -q -b v6.3-rc1 -p v6.2 2>&1  | wc
   2380    9438  104953


I do not know how many are real breakages, and
how many are false positives.

Anyway, I will not check the 2380 lines of the error log.


And, please note that the help message explains '-q' is the *quiet* mode.
It is the opposite. This is super noisy.




[2] Be careful!


While testing the patch submissions of this,
I messed up my repository multiple times.

The script takes some time because it builds many objects
internally.

However, once this script starts running, you must not hit Ctrl-C.
If you do it, your repository will be sprinkled with a ton
of untracked files.

Apply this patch, and run "./scripts/check-uapi.sh -p v6.0"
and hit Ctrl-C.

Repeat it a couple of times, and "git status" will show you
something horrible.


You will never know when git is checking out a commit
because this script hides it by 'git checkout --quiet'.


So, this tool should show a caveat at least.


'git checkout' should not be hidden, or
maybe a caveat message should be shown.


CAVEAT
This tool runs 'git checkout' a couple of times internally.
If you interrupt it, your worktree might be messed up.












--
Best Regards
Masahiro Yamada
