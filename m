Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2367E84E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjA0Obv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjA0Obq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:31:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EB7FF0E;
        Fri, 27 Jan 2023 06:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 486CC61C1D;
        Fri, 27 Jan 2023 14:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7F1C433EF;
        Fri, 27 Jan 2023 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674829904;
        bh=+LRus+iJtP9b1Gg0DrsmsnfQzYQTRnZkqWmF3BfFAXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MFK1mvjC5yPz3eWStoEjKSNIdRl9NLTnpjP+4rt5p/i39k5ccB+Zzbjs8lGWC9Pz2
         GGXRr/K19MvC7Po85hdEmSDH3sVfn5t0UAxcAraCRFRRuViNy8l60E4VE3piF+Q3fY
         yungBmAGhKIoGcWxY6IzfqQfo1+FKPxIe5HAAgh61IrD+U2DKdBNzJEom3+Gm6PVDI
         q3pD+MRHAHWW1pSEUA0XnbJWjTR84SxdaJNpB9dFvvp0Jx6MeU6U2IUZ61hEkTiTsN
         UJU0EKL1JVNIFZSH4QcOq/3yhQ/R4S5bH2fnHbBM2eBmOVw5J8cvCm3zfsOiurtVHK
         SBD7AVJUY0bcg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1442977d77dso6633995fac.6;
        Fri, 27 Jan 2023 06:31:44 -0800 (PST)
X-Gm-Message-State: AFqh2kpdvzZIACdc8evmj+508MybTv2OvVh+bBfLUL9OFBG5YMEZzf0w
        KUGAQNFq+ztCq+lu3pRVbRNE1m0fHQMxhuLNO1Q=
X-Google-Smtp-Source: AK7set8amIa6z7tRWTk83cYkNweETJWmJHZG3C/kcz+y/nQcQwLnkdNJhWuo0dk3GoudjYP/ZwZeol8XNBhMIuw8sCw=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr1392365oaf.287.1674829903989; Fri, 27
 Jan 2023 06:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20221229074310.906556-1-masahiroy@kernel.org> <20221229074310.906556-2-masahiroy@kernel.org>
 <Y9PQxCTJGTRU1cuE@smile.fi.intel.com>
In-Reply-To: <Y9PQxCTJGTRU1cuE@smile.fi.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 27 Jan 2023 23:31:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJ6j7XEZ-poS+Qq+8nZ5iztLTuTSgkr+fMka7HYH8ekQ@mail.gmail.com>
Message-ID: <CAK7LNASJ6j7XEZ-poS+Qq+8nZ5iztLTuTSgkr+fMka7HYH8ekQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kbuild: make W=1 warn files that are tracked but
 ignored by git
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:25 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Dec 29, 2022 at 04:43:10PM +0900, Masahiro Yamada wrote:
> > The top .gitignore comments about how to detect files breaking
> > .gitignore rules, but people rarely care about it.
> >
> > Add a new W=1 warning to detect files that are tracked but ignored by
> > git. If git is not installed or the source tree is not tracked by git
> > at all, this script does not print anything.
> >
> > Running it on v6.2-rc1 detected the following:
>
> Since patch was published there is no sign it was ever meet Linux Next.
> What's the plan?


Oh?
I can see this patch in linux-next.


$ git log next-20230127 -- scripts/misc-check


-- 
Best Regards
Masahiro Yamada
