Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BE374BFE1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGHXCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 19:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGHXCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 19:02:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDBBEB
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 16:02:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99342a599e9so406902166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688857323; x=1691449323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMLbgJOTu2WV/nORFtWqoUMvz+jr1XXDxLBzD5NfFBo=;
        b=G3ixqQbEgwVVzxkTyfDBAx40rwpQxINs7b96PxFa7jMCRhQ6dRH/+LatOP6/cymep2
         8CjpPpT76GnLYYbUsCwxZlQNv7W2H9vMPaewx1JV2zf6c6eMzcBtiGw+2KoAtIp/qnIq
         vUqbo/mQMvwgWRDjJwwWuUC2uLM+9nm9n5m9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688857323; x=1691449323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMLbgJOTu2WV/nORFtWqoUMvz+jr1XXDxLBzD5NfFBo=;
        b=O9x0cxdEzJ85co4nRKsKoEgIUAxluVsAIeQkuSNTfSK6hHYCHbUCQCveE0KLqQkJo6
         SVFY+BLIexjiAvzx1/uQNBf5C4ragkBATNy0eKLW+Wp/cyjMKzuFgoKppLCjMIVXnjVr
         qvvjMaa0A3s8ziGmNk5w7iJGr7CtxeSzebL3IDoXSD8gvvh1zsZvAOY2Z1t76UZSJY7a
         DW/yixTL9ceaTtSqZIsCn+wNqVp9UvjE3jpKs5bxI6rY0NM4PL5ZZd2ZX/TZ//oYA6pO
         SjGI4vIjq/yhFRvlcM0tIpNPnphH0uZXuu/0wHZRIoDFYRXUSbEdBR4OCae0Qr66i3wD
         2kmQ==
X-Gm-Message-State: ABy/qLazu9aX4II6fpvQz4fpt4bpJO5Kbdwe/8QUeoakwa4JpOM7Gs2t
        m3lv79UE+MxzyJeQwpuH/xFZtwNli7mVfUVkbPclwU6u
X-Google-Smtp-Source: APBJJlFtn/DdrX8mffKOxODvnFaPj7yBJin3tyvTluMKNcOgFWcBIF0j2AqOdLjJUacaCfBUD/rZCw==
X-Received: by 2002:a17:906:1046:b0:993:d5bd:a763 with SMTP id j6-20020a170906104600b00993d5bda763mr4516112ejj.20.1688857323582;
        Sat, 08 Jul 2023 16:02:03 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id gf3-20020a170906e20300b00992665694f7sm4004816ejb.107.2023.07.08.16.02.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 16:02:03 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51d7f350758so4319245a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 16:02:03 -0700 (PDT)
X-Received: by 2002:aa7:d383:0:b0:51a:50f2:4e7a with SMTP id
 x3-20020aa7d383000000b0051a50f24e7amr7201378edq.13.1688856837545; Sat, 08 Jul
 2023 15:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <CAHk-=whhXFQj0Vwzh7bnjnLs=SSTsxyiY6jeb7ovOGnCes4aWg@mail.gmail.com> <CAJuCfpHuFc1P=Wo6Oy0T0u-H1B_JsbRgqhVJxY7D64ZY1zh7Cg@mail.gmail.com>
In-Reply-To: <CAJuCfpHuFc1P=Wo6Oy0T0u-H1B_JsbRgqhVJxY7D64ZY1zh7Cg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 15:53:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9NQdt3-yHRXExdnu-QpUfXsqiSujkSTg6AdGjabPs6g@mail.gmail.com>
Message-ID: <CAHk-=wi9NQdt3-yHRXExdnu-QpUfXsqiSujkSTg6AdGjabPs6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, peterx@redhat.com, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 at 15:36, Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Sat, Jul 8, 2023 at 2:18=E2=80=AFPM Linus Torvalds
> >
> > Again - maybe I messed up, but it really feels like the missing
> > vma_start_write() was more fundamental, and not some "TLB coherency"
> > issue.
>
> Sounds plausible. I'll try to use the reproducer to verify if that's
> indeed happening here.

I really don't think that's what people are reporting, I was just
trying to make up a completely different case that has nothing to do
with any TLB issues.

My real point was simply this one:

> It's likely there are multiple problematic
> scenarios due to this missing lock though.

Right. That's my issue. I felt your explanation was *too* targeted at
some TLB non-coherency thing, when I think the problem was actually a
much larger "page faults simply must not happen while we're copying
the page tables because data isn't coherent".

The anon_vma case was just meant as another random example of the
other kinds of things I suspect can go wrong, because we're simply not
able to do this whole "copy vma while it's being modified by page
faults".

Now, I agree that the PTE problem is real, and probable the main
thing, ie when we as part of fork() do this:

        /*
         * If it's a COW mapping, write protect it both
         * in the parent and the child
         */
        if (is_cow_mapping(vm_flags) && pte_write(pte)) {
                ptep_set_wrprotect(src_mm, addr, src_pte);
                pte =3D pte_wrprotect(pte);
        }

and the thing that can go wrong before the TLB flush happens is that -
because the TLB's haven't been flushed yet - some threads in the
parent happily continue to write to the page and didn't see the
wrprotect happening.

And then you get into the situation where *some* thread see the page
protections change (maybe they had a TLB flush event on that CPU for
random reasons), and they will take a page fault and do the COW thing
and create a new page.

And all the while *other* threads still see the old writeable TLB
state, and continue to write to the old page.

So now you have a page that gets its data copied *while* somebody is
still writing to it, and the end result is that some write easily gets
lost, and so when that new copy is installed, you see it as data
corruption.

And I agree completely that that is probably the thing that most
people actually saw and reacted to as corruption.

But the reason I didn't like the explanation was that I think this is
just one random example of the more fundamental issue of "we simply
must not take page faults while copying".

Your explanation made me think "stale TLB is the problem", and *that*
was what I objected to. The stale TLB was just one random sign of the
much larger problem.

It might even have been the most common symptom, but I think it was
just a *symptom*, not the *cause* of the problem.

And I must have been bad at explaining that, because David Hildenbrand
also reacted negatively to my change.

So I'll happily take a patch that adds more commentary about this, and
gives several examples of the things that go wrong.

                Linus
