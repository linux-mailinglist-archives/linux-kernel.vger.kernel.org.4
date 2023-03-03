Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B1F6AA0B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCCUy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjCCUyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:54:25 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF208168A4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:54:23 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id g6so1486293iov.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677876863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zQI0xkYqE09E422jZvvbcH+svLGPeNM58zyYKZSvdo=;
        b=AbHi72L3phwWdi0uLYdWA+y9Dui8busq6kIgjH5/eyxr4oYg5P5XoHR6LyaOTxnB19
         yjpycFiCOOAofcMvyhDdSTDxn1UT0+QtGhemnYTzqvliXjeJmnx2Fo19uVd8WV1ly9GI
         ZHewZKFPhbT6/V9qayPskbb9nskkafrQLqp6TVD5I1Pbqw1puUhOMRvCNsn83FIgqEtW
         pYFC7GITUi0roPeMH4WkJ5qm71BknYTEKkeBUHU7js14EW+t3W8wJMKomNgg6VKmoXPT
         QFFuMUIkTGaNVJMFDfu503z05PhlGt4VHmM3zM2hMJt1iio3aE4MNAu0EYDSraE4p1So
         HmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677876863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zQI0xkYqE09E422jZvvbcH+svLGPeNM58zyYKZSvdo=;
        b=nve3IZHKhdypOOmU6IXVkAwZ6KHGAw7k56mLZKipHLq4sBELdya3DpX2pjBIM4hJ2x
         Lq3oYRZSrl8jBnYSPlW+9cro+ohJRwDNnXBGvhPYOxdX4joyOiT7la8vmNXQk42FWSk0
         k3N0zzbrm8/5g7Uy/jAHc7Af62jPt/zRCtVT1TZgkUVC0iJu4YehKewp08JIpa/hO5wB
         KzhHMJTFmO0zHzyA3QgC9lWQl0QO7lVBPyNNaN+RAj8kllTaGFE2kY8Q5/0KEDo8aG5I
         fxbUeDgQNChLH93+0yQ1cy7PpXiXMF7kugVh4IPCAA5IkR2m0VQBYOUDx+VoOjngSFwD
         e7zA==
X-Gm-Message-State: AO0yUKWeRkOOdNYNZ5rAE4eNypPX1XqIcB1bafylkn/16r7FBbd0KTCC
        23Oyko/snBuY8dOJLeuYLr/92f7O63JFTyMVrPeMUw==
X-Google-Smtp-Source: AK7set+zLGhBXccWhn0ZaiZy7nIRlQgmhhbTgRm0jqOzgD9AZy09eUm4aLyxqm2gPkhOO7I3dqBjfD/pX/DZqYLGruU=
X-Received: by 2002:a02:230d:0:b0:3c5:139d:6097 with SMTP id
 u13-20020a02230d000000b003c5139d6097mr1275362jau.5.1677876863128; Fri, 03 Mar
 2023 12:54:23 -0800 (PST)
MIME-Version: 1.0
References: <CAG_fn=WZnBtRujLyhouz1AmerSKB71oPej442JDOw2OaORbWQg@mail.gmail.com>
 <e1be073e8e53da8dcdd9e37ffc6e60d1375c59bb.camel@perches.com>
In-Reply-To: <e1be073e8e53da8dcdd9e37ffc6e60d1375c59bb.camel@perches.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 3 Mar 2023 21:53:46 +0100
Message-ID: <CAG_fn=XDzM_+nXpypPFG95r7EKRWhPGd7C=JZOy7kYrpcC+XDQ@mail.gmail.com>
Subject: Re: Infinite loop in checkpatch.pl
To:     Joe Perches <joe@perches.com>
Cc:     apw@canonical.com, dwaipayanray1@gmail.com,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 3, 2023 at 5:53=E2=80=AFPM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2023-03-03 at 15:28 +0100, Alexander Potapenko wrote:
> > Hi folks,
> >
> > I've noticed that checkpatch.pl chokes on the following file (also atta=
ched):
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > $ cat test-checkpatch.txt
> > diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> > @@ -504,6 +504,25 @@ static void
> > test_memcpy_aligned_to_unaligned2(struct kunit *test)
> > + EXPECTATION_NO_REPORT(expect);                              \
> > + volatile uint##size##_t uninit;                             \
>
> checkpatch isn't a syntax complete c parser.  Don't expect to be.

That's understandable, and I sure don't. But as a user I expect it to
not loop infinitely, and I think that's also reasonable.
The example I gave is not a randomly generated code snippet, but an
excerpt from a valid patch that I sent earlier today:
https://lore.kernel.org/lkml/20230303141433.3422671-4-glider@google.com/,
which checkpatch cannot process.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
