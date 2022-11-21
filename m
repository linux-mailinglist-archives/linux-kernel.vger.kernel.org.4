Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46F632A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiKUQxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKUQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:53:11 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD0BF5B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:53:08 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v1so20723974wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XSlNOu09gIpBtxVxT1c0KO71t0ZODsn5RpuG42ogge0=;
        b=VV8stsDo3VwgsUMQnraoyVo9OOAsRND2fxh0w9uHN1L/wPyuv/CepMh29qp51Ehvha
         dtvGluiQB3PthvZo49RjMNlpp92sd8qlsyLmPzisovKprxPCqZWpTf9bCF+f5IvJxT8N
         TlUK8Vckw3RZUjsaSV5ph2BMOqnlXn9vhpFMPeOk7nY4EdKa/dRFYQLOHMHwBJazHWjT
         ujA6SvMSG117DhdwBK6662ygykOVYGDTwqLunrUojEBRHq5zqM8EnlUZqQ6ptAxlYMjP
         S6aMgYvPoMRUd/vhbjU67K9x3X0GM333X+mZbhKEdANNK6OgXjumRUQUbCagAZ/kHeck
         pC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSlNOu09gIpBtxVxT1c0KO71t0ZODsn5RpuG42ogge0=;
        b=3iIZev1X19vzkRtybAf2reSVFDA4UVwrHv7s5g3KrnRemTZH95yq1InBrKtO7+fDUm
         Kam2rA5k+azoX7H5ybAlOsx9c+C5PNJdMmgDUA1JZKKuiXtDF0KRWAUTy741+jsuDKhd
         sHfJYC46gd1ON5JR8S10GVWfkhZa8/XcraizggUBP8cV2C5B4pqkS6Va6pmyM9RlO5FS
         F1ujeoGY/DVVKqkdY7DoQo4GyQKOVbnaWTCAzN0EcZ9aR+NjRD/vfcQEm9UKh12pPKYx
         l/VcY1aDuu+AcYUeyNI+u6LjMMnbDAcM37BrnzZYHaYmB7BwS+3LpSu3Q1jZkc7EQg6c
         D7kQ==
X-Gm-Message-State: ANoB5pmCY8UCvkTTWCXDJCMBWS1kcFTx/rRHDoIKT7QiEcq8H+tWEgmI
        +KR/uYkoy+8y1VQc0mvxHh1/CCsr+qWhPaPHpuyAUA==
X-Google-Smtp-Source: AA0mqf6kBBHgfvWnm61GjWbsASI39pORKm7i63/vxUjC62I7A3XYA92tLsjDF3xLQpzNkbn6NH0bkgd/kb9LoMj7olk=
X-Received: by 2002:a5d:6747:0:b0:22e:34ee:c67d with SMTP id
 l7-20020a5d6747000000b0022e34eec67dmr1093186wrw.300.1669049587112; Mon, 21
 Nov 2022 08:53:07 -0800 (PST)
MIME-Version: 1.0
References: <1668762999-9297-1-git-send-email-yangtiezhu@loongson.cn>
 <CAP-5=fXR58DQFkUW81KUs_f9cLTX=L28H1hkxXVzX3dUdRLBjw@mail.gmail.com> <ab41b1fe-4a59-2a6b-ee9f-785c98c48df5@loongson.cn>
In-Reply-To: <ab41b1fe-4a59-2a6b-ee9f-785c98c48df5@loongson.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Nov 2022 08:52:47 -0800
Message-ID: <CAP-5=fWtFktYKch+4Sv4zSHoW8SO96yEsyQgDKApyR20UjXhSA@mail.gmail.com>
Subject: Re: [PATCH] tools: perf: Use "grep -E" instead of "egrep"
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 6:59 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 11/20/2022 02:17 AM, Ian Rogers wrote:
> > On Fri, Nov 18, 2022 at 1:17 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >>
> >> The latest version of grep claims the egrep is now obsolete so the build
> >> now contains warnings that look like:
> >>         egrep: warning: egrep is obsolescent; using grep -E
> >> fix this up by moving the related file to use "grep -E" instead.
> >>
> >>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/perf`
> >>
> >> Here are the steps to install the latest grep:
> >>
> >>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
> >>   tar xf grep-3.8.tar.gz
> >>   cd grep-3.8 && ./configure && make
> >>   sudo make install
> >>   export PATH=/usr/local/bin:$PATH
> >>
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >
> > Hi Tiezhu,
> >
> > installing a newer grep tool in order to build/test perf is somewhat
> > burdensome, as such I don't think we should merge this change. Looking
> > at my Debian derived distro. I have grep 3.7, so I'd need to do this.
> > I imagine the majority of people are using a grep earlier than 3.8. I
> > agree there is a problem perhaps we can:
> >  - rewrite to just need grep and not egrep;
> >  - rewrite in a stable language with regex support, perhaps python;
> >  - have a grep/egrep wrapper that selects based on version number.
> >
>
> Hi Ian,
>
> I found this issue on Linux From Scratch system which uses grep 3.8 [0],
> we can see the following NEWS in grep-3.8 release announcement [1]:
>
> "The egrep and fgrep commands, which have been deprecated since
>   release 2.5.3 (2007), now warn that they are obsolescent and should
>   be replaced by grep -E and grep -F."
>
> Additionally, the next grep rpm/deb version is 3.8 on Fedora [2]
> and Debian [3], so use "grep -E" instead of "egrep" so we won't see
> the warning for various versions of grep.
>
> [0] https://linuxfromscratch.org/~thomas/multilib/chapter06/grep.html
> [1] https://savannah.gnu.org/forum/forum.php?forum_id=10227
> [2] https://packages.fedoraproject.org/pkgs/grep/grep/fedora-rawhide.html
> [3] https://packages.debian.org/sid/grep
>
> Thanks,
> Tiezhu

Thanks Tiezhu,

My grep is 3.7 and has -E support. In the changelog I see:

```
2021-08-14  Jim Meyering  <meyering@fb.com>

       version 3.7
       * NEWS: Record release date.
```

So I'm guessing 3.8 is newer than is necessary for this change, but
demonstrates the warning issue your change addresses. Arnaldo's build
compatibility scripts should be able to spot further issues.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
