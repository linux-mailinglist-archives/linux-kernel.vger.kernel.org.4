Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C486A4EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjB0WpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0WpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:45:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F59DBC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:44:30 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id d30so32290923eda.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQjk/PZKU2DKght8FRlaLknd5PbdlPsKTaWJTtSom5E=;
        b=Z4xnRTpH7LFm1OILM4uiVABZNuvqC1QrsSYJIARQFL78bwuG4XRSWhE7Enp6fOSluw
         rdHYa9x1Z+cn3fVGbmBxKZykE4bE6SsUwmzaGCyD3JjLg8I9RZNPBlqwL6m/+6a4U3er
         TbBcOL2ICWaKgVdJdGyY8tz7u6pVjwfsiVyAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQjk/PZKU2DKght8FRlaLknd5PbdlPsKTaWJTtSom5E=;
        b=TxMY/a2vwcU3nrAt6OvM9Vlyqywazfy2p7I3064+MuNfGOw0ek8sGnHj0mzI2fnn58
         0RR2G//YBPFq9Eh2suoZ0uYA6mJv50smruebpKrxNA3eKT4BYLMk22OLVIJ5QdZPZNdX
         XnKUtQrRJ6Y0oCLXjhffTXJDEp7HyN6OGFZF4dIM+fKkvW01TN1C9vOzug1BWMzXy0Zn
         bejfAbuuWVKgRIXUY7IBKrlSttsZmZPiGKWTDikgq6WvFBOejhvVAzq0AafrQKvX4+Ms
         nqrYwBfhpbYV6ATFsblvt3PxUqEJXrzrvOQKyMav0nyFed4d6Si/9zox7VZrjOXrnF/7
         r5Pg==
X-Gm-Message-State: AO0yUKU1JM1U6Po8IPCm7E2P9YVACUFMDiEeTAfFGNkoGtNN62C1lklT
        38+H9c1VnqdyjI7E1hnZzHhA1IiYgysrudEWHr0=
X-Google-Smtp-Source: AK7set90iPh7rFYYSrTvM2CaXvI9Gi8KsOZLIRHHvDPmrLACPaQ31hdg3oVCjlNXDkz1+XPpchgDtQ==
X-Received: by 2002:a17:907:d22:b0:8e6:266c:d195 with SMTP id gn34-20020a1709070d2200b008e6266cd195mr455009ejc.38.1677537825903;
        Mon, 27 Feb 2023 14:43:45 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id ml14-20020a170906cc0e00b008dcb559dbdbsm3668044ejb.88.2023.02.27.14.43.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 14:43:45 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id ee7so32390620edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:43:44 -0800 (PST)
X-Received: by 2002:a50:c351:0:b0:4af:70a5:4408 with SMTP id
 q17-20020a50c351000000b004af70a54408mr607608edb.5.1677537824536; Mon, 27 Feb
 2023 14:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20230225014529.2259752-1-davidgow@google.com>
In-Reply-To: <20230225014529.2259752-1-davidgow@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 14:43:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgK07PQ_DBBbAbSJ41t__6de1xZ6q7RRu-JS=2SU0wqLQ@mail.gmail.com>
Message-ID: <CAHk-=wgK07PQ_DBBbAbSJ41t__6de1xZ6q7RRu-JS=2SU0wqLQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix 'hooks.o' build by recursing into kunit
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 24, 2023 at 5:45=E2=80=AFPM David Gow <davidgow@google.com> wro=
te:
>
> +# Some KUnit files (hooks.o) need to be built-in even when KUnit is a mo=
dule,
> +# so we can't just use obj-$(CONFIG_KUNIT).
> +ifdef CONFIG_KUNIT
> +obj-y +=3D kunit/
>  endif

We actually have a pattern for this, although I guess it's rare enough
that "pattern" isn't necessarily the right word.

But you can find things like the Hyper-V drivers having similar
issues, and so the driver Makefile has

    obj-$(subst m,y,$(CONFIG_HYPERV))       +=3D hv/

See a few other cases with

    git grep "subst m,y,"

but I guess the "ifdef CONFIG_KUNIT" thing works too. I can only find
one case of that (in arch/mips/Kbuild).

Another way of dealing with this - that is more common for individual
object files rather than directories - is to just do

    kunit-dir-$(CONFIG_KUNIT) :=3D kunit/
    obj-y +=3D $(kunit-dir-y) $(kunit-dir-m)

which admittedly is also not a hugely common pattern, but does exist
in various places (see for example the 'sfp-bus.o' file and CONFIG_SFP
in drivers/net/phy/Makefile.

That last pattern is probably most common in scripts/Makefile.lib,
where we have things like

       hostprogs +=3D $(hostprogs-always-y) $(hostprogs-always-m)

which is similar but not the exact same thing.

Anyway, I guess I'll just apply that patch as-is, I just wanted to
point out that the particular pattern it uses may be simple, but we've
generally tried to just do our Makefile evaluations with "arithmetic"
rather than conditionals.

              Linus
