Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3346F78B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 00:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEDWAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 18:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEDWAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 18:00:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F146F12E84;
        Thu,  4 May 2023 15:00:50 -0700 (PDT)
Date:   Fri, 5 May 2023 00:00:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683237649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3+C1REhPi4ePpc6dWVYIWzuQXA4e7IkkVuH6hIesBE=;
        b=W9h14UwN8V+yCn5peley2dgaswydgOzH1O5sBA4vGVYfbxDD1zMc/oFOEgxFrSBOzJyn/U
        paJsL21EkSRSlPfGHknsCt0JIzdOzhWuNBWVwJHrWS+t5AiHfBHnCNakF7xxRpFUnW0ThI
        OPSPtXbhFQkbqa//aWgbTmxC42GDzcFRi/4PIaC2HagHK8Ik8rVC3gfWC9TefC6dzoSs5l
        1J+h3gt06UpYZkAyXjoTIEInljZM3ygdkOsunMwSxfC7e0HO12E1Clf7d/2GBWtBWhR+V2
        q+l8RWyYiBX8T8b8GuwbKRPMc3towlnTMRHhpW9e01hh2AD1gBqrZ5yeqrA74A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683237649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3+C1REhPi4ePpc6dWVYIWzuQXA4e7IkkVuH6hIesBE=;
        b=5d6Rokg8Ojozf9C3qB9UzYffajpr+raioQw9h58eecN/JNequN7TNwGVyyPZb/oUgQp/34
        E3i7Jmd8pRVIYTAQ==
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] scripts/tags.sh: Fix gtags generation for O=
 kernel builds
Message-ID: <ZFQrD3qKIMGjI9Zd@lx-t490>
References: <20230504201833.202494-1-darwi@linutronix.de>
 <20230504201833.202494-2-darwi@linutronix.de>
 <20230504213246.GB1666363@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504213246.GB1666363@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Thu, 04 May 2023, Nathan Chancellor wrote:
>
> On Thu, May 04, 2023 at 10:18:33PM +0200, Ahmed S. Darwish wrote:
...
> > +	suffixparams=
> > +	if [ -v O ]; then
>
> I think
>
>   if [ -n "$O" ]; then
>
> would match the style preferred by Kbuild (though that is usually for
> portability sake, which probably does not matter here since bash is
> explicitly requested). Perhaps not worth addressing if there is no other
> reason for a v2.
>

Thanks, I'll do it. I've just discovered that a v2 is necessary anyway.

If O= has a "~", for example as in:

    make O=~/build/ gtags

the snippet below:

> > +		suffixparams="-C $tree $O"
> > +	fi
> > +	all_target_sources | gtags -i -f - $suffixparams
                                           ^
will fail since the "~" in the O= directory path won't get dereferenced
before getting passed to the gtags call (an eval is needed).

I'll submit a v2 shortly.

Kind regards,

--
Ahmed S. Darwish
Linutronix GmbH
