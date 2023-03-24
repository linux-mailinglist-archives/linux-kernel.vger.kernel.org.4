Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975EC6C7F06
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjCXNnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjCXNnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:43:31 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF2C199D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:43:22 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5416698e889so33894677b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679665402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoPSMDIKswenyKMLwakUVFyLrEYZv6ETqG+RWnAbawk=;
        b=Up80v/qu76RAS29JlQYjbyxodFQPEq4RgpkxG2vG52kPHsVqjqEpesF/PkSR/iMNmF
         OVeP3AQNPJt747+mSR0WCC6pSxadZAn1NAALXCP3icqEyguIsfP4XdubLYmP60NYjYqo
         EZNJQz4OIXq3tWUHgP6cK4CphHRjKU5ccvZh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679665402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoPSMDIKswenyKMLwakUVFyLrEYZv6ETqG+RWnAbawk=;
        b=xb2Odb2aja/XTczeyH7mrVE+qZtCToco6mJw/KLc4bkKjrAZHNQQR6t6L8FhD2cx/v
         iFyTGhrO1RmbEDcYn+ct8Z/BSB/drx/zgYvNf4sIO2gr5c/ULlAuXoANi3sPcNDiJDl8
         +p3kC3BV/KVpnubyy+Etd4ESDxgoAbiQJlyDbnepPNTSQddu99K8fZRkHWoj9EFehLlY
         bCEIho9TSNqKKibU2513uA1IQ3Y69sNFZn5E++qygvuUScs0icuxGW7Qn14tAMPk6EYY
         RvrQ/MGinakA0yrQYdokTTdOBietQgAvWA6Dq8RtStDu3gqvPQgLsmornQfLZLON+FzP
         l9oQ==
X-Gm-Message-State: AAQBX9cLIKOWjWcUNzhPrEe2brz1eT3umWOD7qrJjGTiyZznPfjvlTO1
        4ZK7Vl1zI8a8BPqvJXf4tZ88Yzsl2Mfe5jFxih3BQg==
X-Google-Smtp-Source: AKy350YSl5ZKGqZtN91bQxYTVOy+Bl+W5kNTIeP/6xLDFMyOg8AWlTHv1+SDvKIJfn924kgfwoKzeTc0nI9z9/rGXPA=
X-Received: by 2002:a81:a709:0:b0:545:4133:fc40 with SMTP id
 e9-20020a81a709000000b005454133fc40mr1065593ywh.9.1679665401960; Fri, 24 Mar
 2023 06:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz> <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
In-Reply-To: <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 24 Mar 2023 09:43:10 -0400
Message-ID: <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
Subject: Re: WARN_ON in move_normal_pmd
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 9:05=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Fri, Mar 24, 2023 at 12:15:24PM +0100, Michal Hocko wrote:
> > Hi,
> > our QA is regularly hitting
> > [  544.198822][T20518] WARNING: CPU: 1 PID: 20518 at ../mm/mremap.c:255=
 move_pgt_entry+0x4c6/0x510
> > triggered by thp01 LTP test. This has been brought up in the past and
> > resulted in f81fdd0c4ab7 ("mm: document warning in move_normal_pmd() an=
d
> > make it warn only once"). While it is good that the underlying problem
> > is understood, it doesn't seem there is enough interest to fix it
> > properly. Which is fair but I am wondering whether the WARN_ON gives
> > us anything here.
> >
> > Our QA process collects all unexpected side effects of tests and a WARN=
*
> > in the log is certainly one of those. This trigger bugs which are mostl=
y
> > ignored as there is no upstream fix for them. This alone is nothing
> > really critical but there are workloads which do run with panic on warn
> > configured and this issue would put the system down which is unnecessar=
y
> > IMHO. Would it be sufficient to replace the WARN_ON_ONCE by
> > pr_warn_once?
>
> What about relaxing the check to exclude temporary stack from the WARN
> condition:
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 411a85682b58..eb0778b9d645 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -247,15 +247,12 @@ static bool move_normal_pmd(struct vm_area_struct *=
vma, unsigned long old_addr,
>          * of any 4kB pages, but still there) PMD in the page table
>          * tree.
>          *
> -        * Warn on it once - because we really should try to figure
> -        * out how to do this better - but then say "I won't move
> -        * this pmd".
> -        *
> -        * One alternative might be to just unmap the target pmd at
> -        * this point, and verify that it really is empty. We'll see.
> +        * Warn on it once unless it is initial (temporary) stack.
>          */
> -       if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
> +       if (!pmd_none(*new_pmd)) {
> +               WARN_ON_ONCE(!vma_is_temporary_stack(vma));
>                 return false;
> +       }

Wouldn't it be better to instead fix it from the caller side? Like
making it non-overlapping.

Reading some old threads, I had tried to fix it [1] along these lines
but Linus was rightfully concerned about that fix [2]. Maybe we can
revisit and fix it properly this time.

Personally I feel the safest thing to do is to not do a
non-overlapping mremap and get rid of the warning. Or is there a
better way like unmapping the target from the caller side first,
before the move?

Michal, would you also mind providing the full stack you are seeing
just so we know it is the same issue (i.e. triggered via exec)?

thanks,

 - Joel

[1] https://lore.kernel.org/lkml/20200712215041.GA3644504@google.com/
[2] https://lore.kernel.org/lkml/CAHk-=3DwhxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=
=3D_fPcdQ2ocQ@mail.gmail.com/
