Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836EA687A96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjBBKqA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Feb 2023 05:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjBBKpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:45:25 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D5885D7;
        Thu,  2 Feb 2023 02:45:10 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id hx15so4642371ejc.11;
        Thu, 02 Feb 2023 02:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=po7aQyjY/NTYpssfxPmIQc5nJCER56LXRnmfZ8cj9AE=;
        b=2HKPgyqT1LS9CXxfW1HZOSEh/jRTpJldvNyS5+N7P8+UtV0HlE3qbwY8ap586L9Abm
         XqqUhoJ+vuSqgHk/eRKtzNyHiMn7kL+uNd7lpq7ox/sA0dS6HARIW5YubI/IuxG/lvJf
         c9ynYe3pkazzNhat7NOVV36bSwWaadr3Nm5bv1q9aCL4BwuXfQAvXCJyqeXeHOyzI1oq
         UbE9mrF0dkWEofcL8wLHW2UnrQBmtbEzIx86SowQVPDniKOGkdrhgybvWYxsmTDjYhBk
         psf2Hv8nJHe1L3Zav+6KUF+o/dJu6tf011kgHxP55lF/Tz0/0ddjNqele5yKpBW2NyKt
         atRw==
X-Gm-Message-State: AO0yUKXoAKTxIrqn8VzPbaowcnHwA8IyqjnJsW6mGPN23QbVhW5/+fYn
        XRU2x8SCVJTA2D7YYOMuPQGZUJjscxmVnMuCHLk=
X-Google-Smtp-Source: AK7set/SJyV8B7X24GPWCByzF5zo48o8FjN9pXhMtcFod1nL7p97Z+Yg7+/Q0kU0s0qNNpOZONRaJg6w41hn441KQ6Y=
X-Received: by 2002:a17:906:e56:b0:884:3298:12b with SMTP id
 q22-20020a1709060e5600b008843298012bmr1794851eji.125.1675334709049; Thu, 02
 Feb 2023 02:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20230131233755.58942-1-pedro.falcato@gmail.com>
 <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com>
 <20230202084953.3035c6e3@gmail.com> <CAJZ5v0iwO=xJ8A=vv4Khm6Z+Lb9hpZsZmyCjMeSHutMWRcp78g@mail.gmail.com>
In-Reply-To: <CAJZ5v0iwO=xJ8A=vv4Khm6Z+Lb9hpZsZmyCjMeSHutMWRcp78g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 11:44:57 +0100
Message-ID: <CAJZ5v0hbFNGugDJ3PGLzfNm7h7f8vTesUOZ0R_vkYGaxBWFCdQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Make custom_method use per-open state
To:     "Marty E. Plummer" <hanetzer@startmail.com>,
        Sebastian Grzywna <swiftgeek@gmail.com>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Hang Zhang <zh.nvgt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 11:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 2, 2023 at 8:50 AM Sebastian Grzywna <swiftgeek@gmail.com> wrote:
> >
> > Dnia 2023-02-01, o godz. 19:34:48
> > "Rafael J. Wysocki" <rafael@kernel.org> napisał(a):
> >
> > > On Wed, Feb 1, 2023 at 12:38 AM Pedro Falcato
> > > <pedro.falcato@gmail.com> wrote:
> > > >
> > > > Make custom_method keep its own per-file-open state instead of
> > > > global state in order to avoid race conditions[1] and other
> > > > possible conflicts with other concurrent users.
> > > >
> > > > Link:
> > > > https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/
> > > > # [1] Reported-by: Hang Zhang <zh.nvgt@gmail.com> Cc: Swift Geek
> > > > <swiftgeek@gmail.com> Signed-off-by: Pedro Falcato
> > > > <pedro.falcato@gmail.com> ---
> > > >  This patch addresses Hang's problems plus the ones raised by
> > > > Rafael in his review (see link above).
> > > > https://lore.kernel.org/lkml/2667007.mvXUDI8C0e@kreacher/ was
> > > > submitted but since there were still people that wanted this
> > > > feature, I took my time to write up a patch that should fix the
> > > > issues. Hopefully the linux-acpi maintainers have not decided to
> > > > remove custom_method just yet.
> > >
> > > Well, thanks for the patch, but yes, they have.  Sorry.
> >
> > Hi Rafael,
> > Can you please explain why you don't want to keep it, given there's a
> > patch?
>
> Because this interface was a bad idea to start with and its
> implementation is questionable at the design level.
>
> Granted, at the time it was introduced, there was no alternative, but
> there is the AML debugger in the kernel now and as far as debugging is
> concerned, it is actually more powerful than custom_metod AFAICS.  See
> Documentation/firmware-guide/acpi/aml-debugger.rst.
>
> If the AML debugger has problems, I would very much prefer fixing them
> to the perpetual maintenance of custom_method.
>
> > I find it really useful in my day-to-day as a firmware engineer.
> > I don't see much happening in git history of
> > drivers/acpi/custom_method.c , and I don't see anything that was
> > specifically changed in it in past 10 years to keep it being
> > functional. Without your more detailed explanation I have hard time
> > understanding your decision to remove it, since I'm not a kernel
> > developer myself.
>
> It's been always conceptually questionable, problematic from the
> security standpoint and implemented poorly.  Also its documentation is
> outdated.
>
> The patches fixing its most apparent functional issues don't actually
> address much of the above.
>
> The AML debugger should really be used for debug rather than
> custom_method and honestly, what's the purpose of it beyond debug?

The above said, if people really do care about custom_method, it can
be retained, but its documentation needs to be updated to cover the
current requirements (according to Rui, they have changed after some
upstream ACPICA changes).

Also note that the upstream ACPICA may not be guaranteed to avoid
breaking this interface in the future, as it depends on
acpi_install_method() that is provided by ACPICA specifically for the
use in the AML debugger.
