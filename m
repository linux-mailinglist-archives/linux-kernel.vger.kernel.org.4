Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355796878FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBBJgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjBBJfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:35:54 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A0B88F01;
        Thu,  2 Feb 2023 01:35:24 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id p26so4122843ejx.13;
        Thu, 02 Feb 2023 01:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4P+6DJXMGU/GZ6vC+OA7Rv2lwEcUeLQojPFdj2bMYU=;
        b=1wpFaF0JJoOmsBhpQcnNXAtTKL1PYZOGSTE32mv02CxHwk+YVimytfWUZ/gxWxWM18
         18+MeFygUWFLJgHtRQO7Ujp9QWUvcyWPEU1MEUI7ck6LGDvHBKmyXVLGxLl3zWjHrjOY
         RwhiFsM7PSJev5GAekI0aaLgjGUg7LYBJ2VaLSSFMm7CEUXi724S86pXzuV42ac/O09t
         EGkAUc9hs9btAHzeBCt7umXWrKWApqqJ+iu9nFW/oebiwTwwIsXlT3swwSdGSZ1RLiBI
         wP6D8CBhG5HfLB7L2ncO9/aYXrZIoDq33/zV/dxXbILBavn/FRG+Cr5mW2khKudcyxuk
         8Mpw==
X-Gm-Message-State: AO0yUKVW6UWQy8Q951Dtbojc6a75viv4fh8M9cFFwQyf0WEYN1q8ilvV
        L0qugfeAdB18HidTgaDvtqmfHKNyRnHi+uvWHPU=
X-Google-Smtp-Source: AK7set9sKQAZXmRj4+REuiGeggHYJ4JQtQBqgzxnG0dm+vm9SPQgzRMqJSX3pLIlMO165L8G/PnH4sIuciDlDxViMNA=
X-Received: by 2002:a17:906:6886:b0:877:612e:517e with SMTP id
 n6-20020a170906688600b00877612e517emr1692509ejr.152.1675330502794; Thu, 02
 Feb 2023 01:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20230131233755.58942-1-pedro.falcato@gmail.com> <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 10:34:51 +0100
Message-ID: <CAJZ5v0ifTg24nNYa-jPkVqmg=gjqmow2ahkm2NV2eDy6Z9HEsg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Make custom_method use per-open state
To:     "Marty E. Plummer" <hanetzer@startmail.com>
Cc:     rafael@kernel.org, Pedro Falcato <pedro.falcato@gmail.com>,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        swiftgeek@gmail.com, zh.nvgt@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 2:04 AM Marty E. Plummer <hanetzer@startmail.com> wrote:
>
> From: "Rafael J. Wysocki" <rafael@kernel.org>
>
> > On Wed, Feb 1, 2023 at 12:38 AM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> > >
> > > Make custom_method keep its own per-file-open state instead of global
> > > state in order to avoid race conditions[1] and other possible conflicts
> > > with other concurrent users.
> > >
> > > Link: https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/ # [1]
> > > Reported-by: Hang Zhang <zh.nvgt@gmail.com>
> > > Cc: Swift Geek <swiftgeek@gmail.com>
> > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > ---
> > >  This patch addresses Hang's problems plus the ones raised by Rafael in his review (see link above).
> > >  https://lore.kernel.org/lkml/2667007.mvXUDI8C0e@kreacher/ was submitted but since there were still people
> > >  that wanted this feature, I took my time to write up a patch that should fix the issues.
> > >  Hopefully the linux-acpi maintainers have not decided to remove custom_method just yet.
> >
> > Well, thanks for the patch, but yes, they have.  Sorry.
>
> Honestly, I think that's a bit of a cop out. This is git. git revert exists,
> and you're crippling the abilities of quite a lot of coreboot/etc development.

Perhaps they can try to use the ACPI debugger that's in the kernel now
instead of a known-broken interface?
