Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6278E69135C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBIWa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjBIWaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:30:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706725A91D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:30:24 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qb15so8883410ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RWE0TUz0ClhyYMw1rdJQckjY7Z69dbWT8ROMhj4VLk=;
        b=aMkSEq+2HrICw6SDl0II7+fRfPlsFp9cUY36bg9k0NSWe1NTk0tN9Uy1IXTS1CDD6v
         AmsZlqhowcVxQkUBgnjmouG5FMm+0A3tjCop10VtDo/wbrD/3TJKoB9tMQ2Duqjdl4hZ
         0JV/jZFZoqFpowdRB3And8gC1wfWcVmx+60SOwISa826lmw7DeOEusaPTJhEeresnars
         J0AcOR1Da9oWy7BsxxOCXbgN2g2NhMcABNERRtbnAWKXt1d+W5Mv1ISmAo+Nnd9hcDfu
         o/F5bvuFZRt3fk/mMBL7qY7ykVDkdlJ26lJ2aIpS4yn8nbYkmw0e9GfagPH4xGcFHw9w
         71+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RWE0TUz0ClhyYMw1rdJQckjY7Z69dbWT8ROMhj4VLk=;
        b=fQajKYuW7eipO9+AASREiHcpMAXbKAcO7Z4GnS8gtDGnOJ1SditP8rliiYdl76PbXs
         c5uhohOT5ahxaT2bgPky71uqqOq3haHpdzYxIaI1m3fcCvGB3R4EK3TXUA0gH0quQnRy
         6Oi2hvwR2s1OyiL652gkjPK1PsPZZAaxMCE3kZui8Ewlc8ucAZcLTnSHatdc4hJIyYMm
         j/3TK0Cy8ewKcldvw0m+E1eDES+0Zf6otIlR21UXS/LxqXBWW8enWpEQSlhyciJQ8+qe
         el/jY0fNi5BD3eUSyLkvv6VUHFZQywIJOyHw17cxezh9lqqtKCAyFH/s0MJv32pfGi6r
         iSCw==
X-Gm-Message-State: AO0yUKWYIeHDmG4BMZpw+FyzZkOYCOxa+s35uI7uH4V0LloqulUPbs0u
        cZeYtR2NGqMcxfxVr3NUm+CFvjeUijMwIMRdNqSK7Q==
X-Google-Smtp-Source: AK7set+Frbb3BGjz1IF2yXK4cqBXZ5sTV9QqkNab+FgdW5TiXIxTy9yO8COITT8r7LUJy9S6PbcWBxZ3k2QAEEvhB6c=
X-Received: by 2002:a17:906:52c8:b0:8af:2a8d:8d15 with SMTP id
 w8-20020a17090652c800b008af2a8d8d15mr1125555ejn.126.1675981822789; Thu, 09
 Feb 2023 14:30:22 -0800 (PST)
MIME-Version: 1.0
References: <20230125015738.912924-1-zokeefe@google.com> <ecb2cf3-45f0-8aae-3e1-da4e79de9c27@google.com>
 <20230209132846.122ad88e1c2bd0603a630e5c@linux-foundation.org>
 <1f344fc1-834d-f1df-8a2c-79918be5b22@google.com> <20230209141221.b7881fb0783a58571f2bca53@linux-foundation.org>
In-Reply-To: <20230209141221.b7881fb0783a58571f2bca53@linux-foundation.org>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 9 Feb 2023 14:29:45 -0800
Message-ID: <CAAa6QmRQqvOvEcb3BRsdr8Jb_XE+pFTVzzroXSUskRU=NOpRsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/MADV_COLLAPSE: set EAGAIN on unexpected page refcount
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 2:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 9 Feb 2023 13:50:30 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
>
> >
> > >
> > > I'm not seeing anything in the [1/2] changelog which indicates that a
> > > backport is needed.  IOW,
> >
> > Correct: it's just changing the errno for some racy cases from "you're
> > wrong, don't bother me again" to "it might be worth having another go":
> > not fixing an instability, as 2/2 was.
> >
> > >
> > > # cat .signature
> > > When fixing a bug, please describe the end-user visible effects of that bug.
> >
> > If whatever's being run by the end-user is coded to try again on -EAGAIN,
> > then the end-user will less often see occasional unexplained failures.
> >
>
> OK, thanks.  I redid the changelog's final paragraph thusly:
>
> : In this situation, MADV_COLLAPSE returns -EINVAL when it should return
> : -EAGAIN.  This could cause userspace to conclude that the syscall failed,
> : when it in fact could succeed by retrying.
>

This looks good to me. Thanks Andrew! Also thanks Hugh for being on
the lookout for this patch -- I hastily read through my emails
regarding which patches were merged where and had assumed this merged
with 2/2.

Also, apologies about the confusing v1 [1/2] and v2 [2/2] fiasco; in
hindsight that probably wasn't the most decipherable thing to do :)

Best,
Zach
