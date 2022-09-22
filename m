Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABEB5E56BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIUXaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIUXaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:30:11 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2C5A142
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:30:09 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id s13so5633111qvq.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=UjiEh0d7e1MycsC8HruOfW5g/90n8MVOkif6MIdUj1Y=;
        b=eYa4JlqGWtQtNLvg7owy6IMmJ/3kOrjOhM3OysMQPAtUP7r9CONrKiCsR7PATmzfI+
         vREAKkLo2j2sKA9nZ1DqvCvHeTmVGo886+qX9mnQOLrocwV4VR9pu6SrQcunZlmzSbkR
         TCVyh/4fiUkRJpkF6xp3neOPSFj1CVCMl0d8v+Nv630TGdynL4DRTfVWdSjeRlVuAcdT
         Iz3wZZUNo+7LiTbLEK7eG0IFY5YkcXMz/hfPjZ6G4FaAfmoVFjk49CGXUeG5oSs1EOx0
         dqJRCDpvHjmKxa7nGayd2Ha3X9YF2N/CBk6Y9KScUkfufv27896P27kzUWUMgnHCN2LZ
         mx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UjiEh0d7e1MycsC8HruOfW5g/90n8MVOkif6MIdUj1Y=;
        b=at8QSJwFuJI4Kh2IX4aChP5X0Ro8Kra1Nn6F/BMvN0RQFOoivPI51j0WG7pBj+pc8U
         spZww1rt/OLW3kpMxfwCoNjjrnMlK3sOM4aYU+Yuwxvc3/7MJKRLSggAYOFVKYO28XhV
         Y7jizlwDjiMGPzt/uV+lxaMDCTRYu1IDqgOe8kUzYDNeKFiFrqCrBxboq/66Ekpg64WA
         lZ4EcNxHA9/sExJ5Nxrh1n+QUGXkEwPWaroTCCciyBfjlh6Lshoku1GnGrVM8GC5lPeR
         1809N1pkSjWc/HKGM9DgUCieFM5jFblF+TIkI5SFzdMVnjJutfOHstR+dSiurzyBtHR4
         xxUg==
X-Gm-Message-State: ACrzQf2CNdSGMYBmL8XQjKTNZpsYaVryeYicC2RoHrTQmgKJBdwKqc/l
        +o4DYqJY7wFix2xFv/yhi45cJr/oCj20lwf2YhMNfg==
X-Google-Smtp-Source: AMsMyM4mx2UnxOMCTmWIRfSMamMkujx4o0TIT0q2gPyAxAQgSiqwHqfqtmzyZgOnKu4q4DDYvy3IwK+whdyZ43VHNRs=
X-Received: by 2002:ad4:5be2:0:b0:4ad:791c:8724 with SMTP id
 k2-20020ad45be2000000b004ad791c8724mr432356qvc.56.1663803008708; Wed, 21 Sep
 2022 16:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220802071240.84626-1-cloudliang@tencent.com>
 <YxjAZOGF9uSE2+AT@google.com> <fdfb143a-45c4-aaff-aa95-d20c076ff555@oracle.com>
 <08cd7add-b2a5-da3f-1d2c-efa0e7c80511@gmail.com>
In-Reply-To: <08cd7add-b2a5-da3f-1d2c-efa0e7c80511@gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Wed, 21 Sep 2022 16:29:42 -0700
Message-ID: <CALzav=fBj5VAntEZ57k3zECu0Hj7O_cACR88vQX6rs3mkVH4Xw@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: Fix a compile error in selftests/kvm/rseq_test.c
To:     JinrongLiang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jinrong Liang <cloudliang@tencent.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Sep 16, 2022 at 3:03 AM JinrongLiang <ljr.kernel@gmail.com> wrote:
>
>
>
> On 2022/9/8 00:54, Liam Merwick wrote:
> > On 07/09/2022 17:01, Sean Christopherson wrote:
> >> On Tue, Aug 02, 2022, Jinrong Liang wrote:
> >>> From: Jinrong Liang <cloudliang@tencent.com>
> >>>
> >>> The following warning appears when executing:
> >>>     make -C tools/testing/selftests/kvm
> >>>
> >>> rseq_test.c: In function =E2=80=98main=E2=80=99:
> >>> rseq_test.c:237:33: warning: implicit declaration of function
> >>> =E2=80=98gettid=E2=80=99; did you mean =E2=80=98getgid=E2=80=99? [-Wi=
mplicit-function-declaration]
> >>>            (void *)(unsigned long)gettid());
> >>>                                   ^~~~~~
> >>>                                   getgid
> >>> /usr/bin/ld: /tmp/ccr5mMko.o: in function `main':
> >>> ../kvm/tools/testing/selftests/kvm/rseq_test.c:237: undefined
> >>> reference to `gettid'
> >>> collect2: error: ld returned 1 exit status
> >>> make: *** [../lib.mk:173:
> >>> ../kvm/tools/testing/selftests/kvm/rseq_test] Error 1
> >>>
> >>> Use the more compatible syscall(SYS_gettid) instead of gettid() to
> >>> fix it.
> >>> More subsequent reuse may cause it to be wrapped in a lib file.
> >>>
> >>> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> >>> ---
> >>
> >> Reviewed-by: Sean Christopherson <seanjc@google.com>
> >>
> >
> > Can a 'Cc: stable@vger.kernel.org' be added also as e923b0537d28 got
> > backported to v5.15.58
> >
> > Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> >
> >
> >>
> >> Paolo, do you want to grab this for 6.0?  It doesn't look like we're
> >> going to have
> >> a more elegant solution anytime soon...
> >
> Ping?

+1, please grab this. Every new branch I create (for new development
and to review upstream code) I have to remember to cherry-pick this
patch in because I use Clang.
