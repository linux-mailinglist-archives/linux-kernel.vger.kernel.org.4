Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2B26BB87C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjCOPvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjCOPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:51:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDD38092F;
        Wed, 15 Mar 2023 08:51:19 -0700 (PDT)
Message-ID: <31f4e939-39b2-7177-39e5-718518f349f7@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678895477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIMH61h63in3N/ZF2aIY4T0k0Py6+4Wi9gMt+OwiPPw=;
        b=hdewzUIbicQeGhsIgVO7mI845S5IO6Mrwhu5Qb+07pUBvy4RwcmWy/NlmvVLmLSNgowHz9
        EYCSKORKQN/L9i7zfZDSU34I1nw2+1uJ1mxZP+iWWX+Rubu6CeJGC9MKXc3g7si/eVisnM
        OJi2tAiDFiRtE49e2sVIodyYJa/8n0krTphN/kKdasJQLaG6tJ1uHZb3e0FxiklFz6qT/4
        B8qXKANaOgVkHXuuaJqFtp1JSxyHKo3+x8laBDtXVoTe90is1Vu+wMIz8/xfBkZihkG508
        hFJQCtWumoK2SDWrOUGIMIxlHf2bBLLgJCAWZgHWXsccxBkJlnKjLp4yiAGimQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678895477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIMH61h63in3N/ZF2aIY4T0k0Py6+4Wi9gMt+OwiPPw=;
        b=pV//z7RIaTx8cVCXCwPmBiif6IGCbSxMA/RKFHO8slkPjfBqzvpGQVW/8yOWdivhV37v2d
        VIP7aDXmcXjIJTCA==
Date:   Wed, 15 Mar 2023 16:51:16 +0100
MIME-Version: 1.0
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230313171036.268407-1-bage@linutronix.de>
 <20230313171036.268407-2-bage@linutronix.de>
 <CAK7LNARd8rQdwauAvgSo-+wxv=rU-4tTCtrzRJ2uhgWRrt6Xxw@mail.gmail.com>
 <63232be8-59f6-8b93-96be-730f5126f60c@linutronix.de>
 <CAK7LNAQ_EhN+6PhcStp8xEOuyLT77t4OJ=E33xTvqVZM-7+Z7A@mail.gmail.com>
Content-Language: de-DE-frami
From:   Bastian Germann <bage@linutronix.de>
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: Allow parallel build
In-Reply-To: <CAK7LNAQ_EhN+6PhcStp8xEOuyLT77t4OJ=E33xTvqVZM-7+Z7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.03.23 um 15:18 schrieb Masahiro Yamada:
> "dpkb-buildpackage -j<N>" sets not only DEB_BUILD_OPTIONS
> but also MAKEFLAGS.
> 
> 
> This is clearly explained in "man dpkb-buildpackage".
> 
> 
>   -j, --jobs[=jobs|auto]
>     ...
>    Will add itself to the MAKEFLAGS environment variable, which should
>    cause all subsequent make invocations to inherit the option, thus
>    forcing the parallel setting on the packaging ...

I see. The testing/unstable dpkg-buildpackage version changed the -j behaviour.
-j only sets DEB_BUILD_OPTIONS=parallel= now.

The man page now says:

        --jobs-force[=jobs|auto]
        This option (since dpkg 1.21.10) is equivalent to the --jobs option except that
        it will enable forced parallel mode, by adding the make -j option with the computed
        number of parallel jobs to the MAKEFLAGS environment variable.

> Your statement sounds like
> 
>   'MAKEFLAGS=-j<N> dpkg-buildpackage'
> 
> is the only way to build packages in parallel.

It is in v1.21.10 or later (or using --jobs-force which does the same thing).

> Apparently, dpkg-buildpackage provides a much shorter way
> and invokes internal Make in parallel.
> 
> 
> 
> 
>>
>> So it is not used to run the actual build, just the top level `make -f debian/rules` invocation.
>> You can set --jobs-force=16, which ends up in MAKEFLAGS but the point of the patch is that one can use
>> the usual way of parallelizing.
> 
> 
> What is the "usual" way in this context?

The usual way is dpkg-buildpackage -jN but that does not work with later versions.

> Do you mean
> 'DEB_BUILD_OPTIONS=parallel=16 dpkg-buildpackage -b'
> is the usual way for parallel building?
> 
> If so, I agree. This patch caters to this case.
> 
> 
> But, I think your code should go to debian/rules
> instead of scripts/package/deb-build-option.
> Kbuild's "make clean" works much faster with the parallel option.
> 
> 
> Also, the commit description should explain the
> benefit of this patch.

I will clarify the dpkg-buildpackage behaviour change and will move the stuff to debian/rules
in v2.
