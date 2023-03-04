Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3666AA7DF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCDDnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCDDnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:43:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523887DB7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:42:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f13so17820606edz.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677901375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRI2r+nGaYoc/6DC9g4x/BneKMapCVAkn7Icxvx9UyE=;
        b=gOk0r7IRyae11l5C54SWiNiUvgkha+5UOxrFtkZuCOq5WzJBwVOKijP66ljuIoVkMx
         OgBLbxOMIQM6b5q0q40eiJtRBjqVkHEcxVbohaNPqvci2K/m+zuK0VJWL7uN4XlbAgw+
         xOiDFKE8EoNI8PDeqzIG4PT5dQQoYmga5jmXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677901375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRI2r+nGaYoc/6DC9g4x/BneKMapCVAkn7Icxvx9UyE=;
        b=1BqbzTT0KXZT9VbnV19sYWN8Ersm7a8sLC4wr6r90X/fQZ1M/X8iAvJ1O+pnDB8ai9
         cquxTZ1uARoSGzHmqZt7M2sPq5bmyueaQJ8S7BgS9/D0mfrFwz3huYRKoTmMNFg4X3oL
         pEbBEoW2wMeLWHXXViWe8eqSvuDqkws2klE9AsmygylO2YlOAOnSVR/kiPNuuow9Y5ue
         62Fn9AhGyy8kX/zQTV06Bgu/vYHZFcNN2j+4Pa/oDRBYD7kOuymind3dl4KgabTH5jj8
         bKZ/JBFwzcgoyLg7ygz8R/ejj8etZWTMJKoaHek20iBV/ofnXwADLLjBce9HDMkazE2S
         qsHg==
X-Gm-Message-State: AO0yUKU4aYxHHeAXkEwNGJjNlxjwAPmC/m/AF2crbw6f+QYa/EHmhhIa
        4qPk4RD1ifLxIdnPSEAUddaVVD6KY9rgej+ZuO+Nvg==
X-Google-Smtp-Source: AK7set8GmtsBPIYN9NGQ+PXiLp7/wzdRogbSmtvyTOfS6kNBomLmLAXKupTt0/OOnZXQ8k9RhcF/6Q==
X-Received: by 2002:a17:907:7e9c:b0:8b2:e6f6:c20a with SMTP id qb28-20020a1709077e9c00b008b2e6f6c20amr5822300ejc.11.1677901375671;
        Fri, 03 Mar 2023 19:42:55 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906578700b008b904cb2bcdsm1661153ejq.11.2023.03.03.19.42.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 19:42:54 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id a25so18076878edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:42:53 -0800 (PST)
X-Received: by 2002:a50:9f47:0:b0:4bc:13f5:68a5 with SMTP id
 b65-20020a509f47000000b004bc13f568a5mr2310202edf.5.1677901373386; Fri, 03 Mar
 2023 19:42:53 -0800 (PST)
MIME-Version: 1.0
References: <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com> <ZAK6Duaf4mlgpZPP@yury-laptop>
In-Reply-To: <ZAK6Duaf4mlgpZPP@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 19:42:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
Message-ID: <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 7:25=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Did you enable CONFIG_FORCE_NR_CPUS? If you pick it, the kernel will
> bind nr_cpu_ids to NR_CPUS at compile time, and the memset() call
> should disappear.

I do not believe CONFIG_FORCE_NR_CPUS makes any sense, and I think I
told you so at the time.

This all used to just work *without* some kind of config thing, First
removing the automatic "do the right thing", and then adding a config
option to "force" doing the right thing seems more than a bit silly to
me.

I think CONFIG_FORCE_NR_CPUS should go away, and - once more - become
just the "is the cpumask small enough to be just allocated directly"
thing.

Of course, the problem for others remain that distros will do that
CONFIG_CPUMASK_OFFSTACK thing, and then things will suck regardless.

I was *so* happy with our clever "you can have large cpumasks, and
we'll just allocate them off the stack" long long ago, because it
meant that we could have one single source tree where this was all
cleanly abstracted away, and we even had nice types and type safety
for it all.

That meant that we could support all the fancy SGI machines with
several thousand cores, and it all "JustWorked(tm)", and didn't make
the normal case any worse.

I didn't expect distros to then go "ooh, we want that too", and enable
it all by default, and make all our clever "you only see this
indirection if you need it" go away, and now the normal case is the
*bad* case, unless you just build your own kernel and pick sane
defaults.

Oh well.

                   Linus
