Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AED709FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjESTVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjESTVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:21:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8FF115
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:21:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5112cae8d82so1566878a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684524110; x=1687116110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3UOfbb4Sozljqzvq4nyP3R59tkdsUwJloQlEWrn99E=;
        b=TufFSf/w57t3rdGZZ9k6NrvIRRg0IOJU214TyZ65AkRlDZn5JY0ZSEgAy6ko17UGvN
         hORZlxyJMmAIdywEHHMZYr/bOWwvfL83yYW425at2d5hb1512YCLonwpz23h4NT6OyPZ
         qloGnG+htrWYlevBiv+vP5NSrMJ5r7DnNDAk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684524110; x=1687116110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3UOfbb4Sozljqzvq4nyP3R59tkdsUwJloQlEWrn99E=;
        b=brT36xkQS5iHoKrm6mvuvl/juhSLrrMTkJeGnl4C7puCPAKp4AR75Ed2a/qS7mBnCT
         hDta2W5e5b4t29joNe4m4/wC+LE0nPlZkJWZ5gUeJZTuNkxrVYg1yEYeyHoX/no1xDE+
         4YliaB318Fx6Ll2IDNnSac5ulHdxigI1NeYKDqdgMhR8yo2/Hsg9UpuWtFuQ7Ki3kfv7
         DPgxTUwARsAe7UokEWx/LnTbA8mkBLEWUcrWWBCN65wZZVAaECbNUI3XbuWIvI8h442R
         vjdeWtmZyapp1KU/SqfqwMGpF+CLZmIV4AfGU6XMsTb1XfRPMYeLzoOYVodTm4MlqAkX
         i9IQ==
X-Gm-Message-State: AC+VfDx4V1N10sbW5vgczx36ajqE6Ryh9fWJji7wrfcYZDiKvd7S+bXs
        2iyzIoTRgo2F5zx5DfOeE4HpAyLfqvFjvdsX45vZ63QW
X-Google-Smtp-Source: ACHHUZ7/jUMBu7zKuVi5J1KMJGjZ8tr+xAjlaMMyii8/iiGvUtOqGDdDiz5eZgByNWYYMv1UKbGPhA==
X-Received: by 2002:a05:6402:514e:b0:504:a248:3741 with SMTP id n14-20020a056402514e00b00504a2483741mr2726081edd.14.1684524110598;
        Fri, 19 May 2023 12:21:50 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id z5-20020aa7c645000000b0050bc6983041sm62934edr.96.2023.05.19.12.21.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 12:21:49 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso4814040a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:21:49 -0700 (PDT)
X-Received: by 2002:a17:907:26ca:b0:962:46d7:c8fc with SMTP id
 bp10-20020a17090726ca00b0096246d7c8fcmr2445592ejc.21.1684524109262; Fri, 19
 May 2023 12:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org> <20230519190934.339332-2-joel@joelfernandes.org>
In-Reply-To: <20230519190934.339332-2-joel@joelfernandes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 12:21:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
Message-ID: <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
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

On Fri, May 19, 2023 at 12:09=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> +static bool check_addr_in_prev(struct vm_area_struct *vma, unsigned long=
 addr,
> +                              unsigned long mask)
> +{
> +       int addr_masked =3D addr & mask;
> +       struct vm_area_struct *prev =3D NULL, *cur =3D NULL;
> +
> +       /* If the masked address is within vma, there is no prev mapping =
of concern. */
> +       if (vma->vm_start <=3D addr_masked)
> +               return false;

Hmm.

I should have caught this last time, but I didn't.

That test smells bad to me. Or maybe it's just the comment.

I *suspect* that the test is literally just for the stack movement
case by execve, where it catches the case where we're doing the
movement entirely within the one vma we set up.

But in the *general* case I think the above is horribly wrong: if you
want to move pages within an existing mapping, the page moving code
can't just randomly say "I'll expand the area you wanted to move".

Again, in that general mremap() case (as opposed to the special stack
moving case for execve), I *think* that the caller has already split
the vma's at the point of the move, and this test simply cannot ever
trigger.

So I think the _code_ works, but I think the comment in particular is
questionable, and I'm a bit surprised about the code too,. because I
thought execve() only expanded to exactly the moving area.

End result: I think the patch on the whole looks nice, and smaller
than I expected. I also suspect it works in practice, but I'd like
that test clarified. Does it *actually* trigger for the stack moving
case? Because I think it must (never* trigger for the mremap case?

And maybe I'm the one confused here, and all I really need is an
explanation with small words and simple grammar starting with "No,
Linus, this is for case xyz"

                  Linus
