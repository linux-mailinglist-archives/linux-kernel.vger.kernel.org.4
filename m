Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2DF65A5E6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 18:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiLaROo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 12:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:14:43 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8AD1090
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 09:14:42 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id g4so26428412ybg.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 09:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibcFxu0r5aq7fCHqB6aB5eCpGsM5NrAZ+yiZYLfhytk=;
        b=FqC5ZHepDUgE405pYH8EmwSWX1cJpDrq3DsvdLz05MSCJG4wA3RlisgtkAmUyfwTz3
         5P3zJs6ZtJOWLsticvL2lWfgRwwHBj2Jb28Mfgn8imbegCKA84hF8QLuG9VW6o2xRjbz
         92MGLlU8JTrAjRuECvpmdNjQL+6Dn++LhP76w4/uRrAvgZlUIKjwadjk1iMnJLrUv8cH
         13DamiJZWSUQ57VYq7pZYjQyFJYwbfXI3i7aoAhDa30HQyLr/bWbampPjAxjr5g0i2aU
         ixMjDtu4n/iNapU6JiiDS/NOwiV5v2MyCULU97sRKi6gCRr4uKc/OHLlUifI6rui5Txh
         m2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibcFxu0r5aq7fCHqB6aB5eCpGsM5NrAZ+yiZYLfhytk=;
        b=DJrYVmeccNgILD2OL5gAi/gyUuysYO4XsZaD9GGOXxmnZiMbAbiLpQar/XEiPOt78W
         y1DJ8gOt5GQM+Ko6q9wGZ/eab4Fh6gPCme7DC2IvBuR/iBEl2AONmzgxvQkW9mPIjDTL
         siQKsZCZtx0IBxvGnl7Bi3LjHurvwkJeLHv4Pk7+qpwli6bV8gIWdeiYW1LHgOxyl/Kg
         j/7fKoREcP3M22gz3bGmO8yq3CzcSg9IOiN/+iReX+sfiUBqwsry4XvfDIf1YV/O6e1V
         slUL4x+1IPnO+2ycPj9oTicra5x2k+MPflkE43pUPC0xQLK2HniWJnjw0URNFJOhw6tJ
         1Gfw==
X-Gm-Message-State: AFqh2ko7PVQL3lPjXdsaHnKJPyxmmum4Jg+iNzF6paE474gAJn7sz0hG
        BYaCMqdkKJCPwtVzTJ3+SlqRW7br6lki0SOvQyQ=
X-Google-Smtp-Source: AMrXdXuslAzvIwIYCQUhi4DGuPioVVUYKYBx8ue+3JA7sF5tKjP2nd+0zRsqz7Ruq1y66L0EPiynhlaxPJ4owVG1JZY=
X-Received: by 2002:a25:4c81:0:b0:6f9:ece2:7b87 with SMTP id
 z123-20020a254c81000000b006f9ece27b87mr4093697yba.485.1672506881526; Sat, 31
 Dec 2022 09:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20221230163512.23736-1-dmitrii.bundin.a@gmail.com> <Y69E0diWostgY2pj@kernel.org>
In-Reply-To: <Y69E0diWostgY2pj@kernel.org>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Sat, 31 Dec 2022 20:14:30 +0300
Message-ID: <CANXV_XzMVGHy5SP-2=QyO6YvpZAzLU4ZwFL3b8KOucr9rwkzhg@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: add mm introspection utils
To:     Mike Rapoport <rppt@kernel.org>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, x86@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 11:07 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> The commit message does not mention it's x86-specific.
> Not sure how gdb scripts handle per-arch functionality, but at the very
> least this should be stated in the commit message.
>
Thanks for pointing this out. Will fix it. I put the command's code
under the if utils.is_target_arch("x86") ... else
gdb.GdbError("Virtual address translation is not supported for this
arch") as it's done in other scripts and have plans to implement the
same functionality for ARM in the foreseeable future.

On Fri, Dec 30, 2022 at 11:07 PM Mike Rapoport <rppt@kernel.org> wrote:
> Any particular reason to make it ALL CAPS?
Actually, no. Do you propose to reformat the output with a lower case?

On Fri, Dec 30, 2022 at 11:07 PM Mike Rapoport <rppt@kernel.org> wrote:
> What will happen here with 5-level paging?
This is safe to do since the PS bit of PML5/PML4 is reserved and it's
not possible that a 5 or 4 level entry maps a page.

On Fri, Dec 30, 2022 at 11:07 PM Mike Rapoport <rppt@kernel.org> wrote:
> Please don't use magic numbers.
This was actually a page_offset_base in case the
CONFIG_DYNAMIC_MEMORY_LAYOUT option is disabled. Will fix it.
