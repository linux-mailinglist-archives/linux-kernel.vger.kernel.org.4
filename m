Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4960470D0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjEWBsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjEWBsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:48:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5416EB7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:47:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f683e8855so624539566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684806476; x=1687398476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOGZYEghKs3nn4mexef6OEUtQ/86KDKLq99QlVJ/owA=;
        b=ZJaxkpAsmW2osgbozhA2kQz7mhYMPQ69oEqBCw3bFnsGfVq2QIkVEuINdNTL5UW2Zc
         YgR6DUSAMrP1Ncl5QZ3K1IxUbrNwOmY3C64uD0a16QbuFHRzdILQaUdDCHoEPHApFpX3
         rdFkKRwgXCwHucwvwNiciuUh0VaUq3X71sIMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806476; x=1687398476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOGZYEghKs3nn4mexef6OEUtQ/86KDKLq99QlVJ/owA=;
        b=hov8eRsR/9Nn0K8QZjKy+7pP0ak4N4C7wqF3mMMq+E47w0LAhvLNWATEP+KvQpr+Dm
         LsLxfk3PehvryPmuQoE5FHDoIqj5A5uHdzo1XvKv/Ikghn70u9PkdmipLnDMUl0hQR9o
         l3jN6vEXmTm6WPqufYI9zwa4LeKV2sU45OO2VU+Afi0JXKsGC5sXWhgjmz0tAJ8+6QDY
         30WJYap8tSrVNkC2NBgePbZG1tow7PCMIzHie2ZN6/efpXPiRE4Jd7t3X3hO2v6pwgo6
         QI5ULpgeyNQme0oVkdQGFIQuGki//O0uHVL9H9peyyCAMND26oCAVV1cp+wtieV+sDrQ
         LEOg==
X-Gm-Message-State: AC+VfDxSqvhmB1lrs1W3VI8/bzZ0XoJWzDmHt/D1LuDUUP5BePj2v2GX
        U5YBl2KHeq3aHQFIqvZ2KkTiZDraOuoD1gZGJA9nCF+3
X-Google-Smtp-Source: ACHHUZ5PsIuYNKT4mJtsrpYJWDQtc1Ci9cDsRDCaflRfvYqpJ0lx3NQOojn4YSkSQmIa13q+SIOINg==
X-Received: by 2002:a17:907:1b12:b0:8b8:c06e:52d8 with SMTP id mp18-20020a1709071b1200b008b8c06e52d8mr12836769ejc.36.1684806476574;
        Mon, 22 May 2023 18:47:56 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id ia18-20020a170907a07200b00968242f8c37sm3827712ejc.50.2023.05.22.18.47.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 18:47:54 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96ff9c0a103so227230366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:47:54 -0700 (PDT)
X-Received: by 2002:a17:907:86a2:b0:96f:a39c:86d6 with SMTP id
 qa34-20020a17090786a200b0096fa39c86d6mr9081820ejc.8.1684806474318; Mon, 22
 May 2023 18:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com>
 <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com> <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com>
 <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com> <b2bf7ae9-983d-6c20-0781-7f37a4454bfd@google.com>
In-Reply-To: <b2bf7ae9-983d-6c20-0781-7f37a4454bfd@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 18:47:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6L6yZnGCYVEmLgQY+KEHNsAW2V69mfdUCMk4qS=GnKA@mail.gmail.com>
Message-ID: <CAHk-=wi6L6yZnGCYVEmLgQY+KEHNsAW2V69mfdUCMk4qS=GnKA@mail.gmail.com>
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM checks
To:     David Rientjes <rientjes@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 5:52=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> Right now kernel.panic_on_warn can either be 0 or 1.  We can keep the
> lowest bit to be "panic on all warnings" and then bit-1 as "panic on debu=
g
> VM warnings."  When CONFIG_DEBUG_VM is enabled, set the new bit by
> default so there's no behavior change.

So right now CONFIG_DEBUG_VM being off means that there's nothing at
all - not just no output, but also no code generation.

I don't think CONFIG_DEBUG_VM in itself should enable that bit-1 behavior.

That may be what *you* as a VM person wants, but VM people are not
exactly the common case.

So I think we've got several cases:

 (a) the "don't even build it" case (CONFIG_DEBUG_VM being off)

 (b) the "build it, and it is a WARN_ON_ONCE()" case

 (c) the *normal* "panic_on_warn=3D1" case, which by default would panic
on all warnings, including any warnings from CONFIG_DEBUG_VM

 (d) the "VM person" case, which might not panic on normal warnings,
but would panic on the VM warnings.

and I think the use-cases are for different classes of kernel use:

 (a) is for people who disable debugging code until they feel it is
needed (which I think covers a lot of kernel developers - I certainly
personally tend to not build with debug support unless I'm chasing
some issue down)

 (b) would probably be most distros - enable the warning so that the
distro can report it, but try not to kill the machine of random people

 (c) would be most cloud use cases, presumably together with reboot-on-pani=
c

 (d) would be people who are actual VM developers, and basically want
the *current* behavior of VM_BUG_ON() with a machine that stops

and I think (d) is the smallest set of cases of all, but is the one
you're personally interested in.

             Linus



             Linus
