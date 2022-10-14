Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712C95FF36D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiJNSHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJNSG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:06:59 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629C9286FF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:06:58 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id i9so3766931qvo.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ch6qXOBT3Q0ocySQGQG2KLhZbSalwxj2bTbWL/3dxw4=;
        b=yKjU3nkQMthh7ZPA4yLoU1sNa/IAtFJF6wu+AbdAkaWmO9EQsNjxL3+90sG8fUs/Ec
         JgVAEwjNXkdcnqQvL5FwvyZ17kXPDhHNLa0Yhrf1JQatWsq6b74PHiu3VqrfihaPSwUq
         Gx+TgQTMtCGROzDMG4NHQNSbD/zBWrIxfyPuAAgm99R/vH+LD7RJUxcIfte8rhCA1Cdx
         nCsrs1whzQJLxekbq+Cy2ag6vzLqz9wAGfm/vGTlQ/nN0y9YFL/+RUb1uf0rLJsm08kV
         iHwyNQw+L6co7EtTTtySi0gKdQSUcBtpJWQfGo9a9JpdtlXJJK65GTxZKdsGVlJqjxXh
         uLSA==
X-Gm-Message-State: ACrzQf1pCdtXWMHh9O21yTCX9c9YF3YMN+Yh+ATozn/JOflSuMGctQ0R
        oW4yHgB7qMdZmqfF8JWXV4WYwkU5AKtYDQ==
X-Google-Smtp-Source: AMsMyM5choQHAfUTNtG+7cn9txPovMlufi2gFmMHcq6otcAgb1TD6vz+ML3+SPA8zrqLdw/Qf96TGA==
X-Received: by 2002:a05:6214:e49:b0:4b3:f24e:91ac with SMTP id o9-20020a0562140e4900b004b3f24e91acmr4936110qvc.41.1665770817226;
        Fri, 14 Oct 2022 11:06:57 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t200-20020a3746d1000000b006cbcdc6efedsm2831440qka.41.2022.10.14.11.06.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 11:06:56 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 126so6519347ybw.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:06:56 -0700 (PDT)
X-Received: by 2002:a25:cd01:0:b0:6c2:6f0d:f4ce with SMTP id
 d1-20020a25cd01000000b006c26f0df4cemr5234242ybf.365.1665770815994; Fri, 14
 Oct 2022 11:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local> <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Oct 2022 20:06:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
Message-ID: <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
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

On Thu, Oct 13, 2022 at 8:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 13, 2022 at 8:29 PM Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> > On Thu, Oct 13, 2022 at 02:57:18PM +0200, Geert Uytterhoeven wrote:
> > > The first step is
> > > https://korg.docs.kernel.org/lore.html#requesting-archival-of-an-existing-list
> > >
> > > It doesn't make much sense to start collecting archives if the lore
> > > collector hasn't been activated yet.
> >
> > The archiver is now subscribed to the list. Once we have the archives, we can
> > complete the setup.
>
> Thank you, I have triggered the export from Gmail. After I have received
> the export archive, I will merge it with my local pre-Gmail archives.

I have just sent my merged archive for linux-um.lists.infradead.org
and the old user-mode-linux-devel.lists.sourceforge.net (starting
from 2003-09-02) to Konstantin.

If you you have older archives, or want to fill in the possible gaps,
you can follow the procedure [1] starting from my
linux-um-known-ids.txt.xz[2], and share the new emails with Konstantin.

Konstantin: I believe there is a bug in the sending procedure [3]:

    tar cf full-archives.tar dir-with-mbox-files

I guess that should be

    tar cf full-archives.tar ~/linux-kernel-announce

instead?

Thanks!

[1] https://korg.docs.kernel.org/lore.html#merging-multiple-archives-into-one
[2] https://drive.google.com/file/d/1d68UBC4pOCgQicz_a3vIsJAhDy9CTQnH/view?usp=sharing
[3] https://korg.docs.kernel.org/lore.html#send-the-archive-to-helpdesk

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
