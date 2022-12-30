Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69C5659459
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 04:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiL3DLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 22:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiL3DLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 22:11:47 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4EE13D48;
        Thu, 29 Dec 2022 19:11:46 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2BU3BIee020234;
        Fri, 30 Dec 2022 12:11:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2BU3BIee020234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672369879;
        bh=edZ9gHnsXwtflB4Xm2fLMJuIuiM21/LDbxXQ5W5LH4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ovJ4J3lGTiasN1FAgiqSylCu1kk/d6pLUJytUBdO+7AzC98PknEHiBCprtws25ZjX
         w5pkOGUJsBCZwX/fBDwAGb5TTur6QCWu6oJBk/6izU4R6HjlRLm/WuTnJkyJpXwy4r
         joLi6yMwVu5Z5w6DasTnd3g7T70DRwzGTWMeqfspAPL8YpK5mI9a9hGg4UrddBTjTG
         i8EELLDgktUcmMNaShw2Ob2mwCtTL2egv0gohqA+3fF3q36O/vAqTQ72HyqetZSLXL
         wHNbe/iPfkIVKjBRt5Jumecj1kWFzZjWm6LkwFGnZJaMD8dYA3wqgaunh3FtnFOKby
         AfGbQlsE7Cy3A==
X-Nifty-SrcIP: [209.85.210.44]
Received: by mail-ot1-f44.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so12487094otp.9;
        Thu, 29 Dec 2022 19:11:19 -0800 (PST)
X-Gm-Message-State: AFqh2koI0265YuTzkS2tCr/ljYpSJRdKKa5wVJSV/x6uiXBKjnGCL7Bd
        ts1fg/n/LU5m5fzbOLBwJc1PwDB72G7XwhqaS8I=
X-Google-Smtp-Source: AMrXdXtyjNGQDKkaN9OyM0/D4600V7ght31O+A/dfo+c/yiyr7H6rYtevjWXtc8OKEU0p3E3z3dZhhJBwfHmQ6SMn1Q=
X-Received: by 2002:a9d:7e99:0:b0:670:64b2:ae66 with SMTP id
 m25-20020a9d7e99000000b0067064b2ae66mr1951907otp.225.1672369878134; Thu, 29
 Dec 2022 19:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20221229074310.906556-1-masahiroy@kernel.org> <20221229074310.906556-2-masahiroy@kernel.org>
 <Y62i1bwkYfhg2PSl@fjasle.eu>
In-Reply-To: <Y62i1bwkYfhg2PSl@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 30 Dec 2022 12:10:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATTUDpyzhdE253GU0u-m4GNW5+WFyxxj=7ML6BtRz4Thw@mail.gmail.com>
Message-ID: <CAK7LNATTUDpyzhdE253GU0u-m4GNW5+WFyxxj=7ML6BtRz4Thw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kbuild: make W=1 warn files that are tracked but
 ignored by git
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 11:23 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Thu, Dec 29, 2022 at 04:43:10PM +0900 Masahiro Yamada wrote:
> > The top .gitignore comments about how to detect files breaking
> > .gitignore rules, but people rarely care about it.
> >
> > Add a new W=1 warning to detect files that are tracked but ignored by
> > git. If git is not installed or the source tree is not tracked by git
> > at all, this script does not print anything.
> >
> > Running it on v6.2-rc1 detected the following:
> >
> >   $ make W=1 misc-check
> >   Documentation/devicetree/bindings/.yamllint: warning: ignored by one of the .gitignore files
> >   drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore files
> >   drivers/gpu/drm/tests/.kunitconfig: warning: ignored by one of the .gitignore files
> >   drivers/hid/.kunitconfig: warning: ignored by one of the .gitignore files
> >   fs/ext4/.kunitconfig: warning: ignored by one of the .gitignore files
> >   fs/fat/.kunitconfig: warning: ignored by one of the .gitignore files
> >   kernel/kcsan/.kunitconfig: warning: ignored by one of the .gitignore files
> >   lib/kunit/.kunitconfig: warning: ignored by one of the .gitignore files
> >   mm/kfence/.kunitconfig: warning: ignored by one of the .gitignore files
> >   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
> >   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
> >   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
> >   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
> >
> > These are ignored by the '.*' or 'tags' in the top .gitignore, but
> > there is no rule to negate it.
> >
> > You might be tempted to do 'git add -f' but I want to have the real
> > issue fixed (by fixing a .gitignore, or by renaming files, etc.).
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> > ---
> >
> > Changes in v3:
> >   - change working directory to srctree (Nicolas)
> >
> > Changes in v2:
> >   - Add $(srctree)/ to make it work with O=
> >
> >  Makefile           |  6 ++++++
> >  scripts/misc-check | 19 +++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >  create mode 100755 scripts/misc-check
>
> Tested-by: Nicolas Schier <nicolas@fjasle.eu>
>
> out of curiosity: do you plan to implement more checks in the misc-checks
> target?


I chose a generic name so I can put more in this script, but
honestly I have nothing else in my mind for now.




>
> Kind regards,
> Nicolas
>


-- 
Best Regards
Masahiro Yamada
