Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471576C921B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 04:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCZC1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 22:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZC1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 22:27:03 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD197359D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 19:27:01 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id qh28so4590780qvb.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679797619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e6MdwF8dxq5T17Hd4Ut5Up4l3/CTfKzbkFdh3c/8I8g=;
        b=TSuXUA1/rCTle+jIAbff5cgl68pVipoCkyZahYjwXFVw3yy1QD3Se9VxkbwLihlFG+
         CV7XufO3H3RccEfcaTc/NESCLXd3E4MQZntSAiNWJgXL5kkSuO+kpDkA9Cs4pQ/YumPJ
         RIThw5pxBIn3QSlN69CniIwpd5RO/fFYFjyBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679797619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6MdwF8dxq5T17Hd4Ut5Up4l3/CTfKzbkFdh3c/8I8g=;
        b=r5sLKqAwMdfuQOflaAazIdGQcU4pHddA/yFzGuAGylEihFDEhVf3E8qFFR4GDSfYsA
         os791f9ku0bGxHmWjR6n189yMX93wDSrPhGLRwOLHyMlbcgxdeKcDJAi6VZiuf62Zi95
         sMkNo/d75n4umVIwMlf7eeHLo6Jj5KQHpSB6pGa3Zmmv6D7O36miFMihcSrecVjfO9Rc
         LgwBnMWZAVVrDGxdK6ukaOcmJfDFRT+Ejr1iy4kAn5gRWebVq+Hx0YDGqBAi1mw2LSM4
         wYPG7d8NWMO2DyKj45w71foUyeqgiqiGlYYdoth+ZhCP5yjdNABqR+FxR3x/ZOo/wheX
         setw==
X-Gm-Message-State: AAQBX9elRLpfdQuKVY0qgUkOFbSuNLsu7rKb1y7MqtM6P06WrHorZ3hj
        7w0LwRbmyzK7Offvv/OU5fG84g==
X-Google-Smtp-Source: AKy350bHA3idHLx/NThEJb96p4xme+KXCB6533BCD9gxM/MB05zOeON9I4FFg/vk5Y1P76eUJovAjw==
X-Received: by 2002:a05:6214:27e1:b0:5d1:acb8:f126 with SMTP id jt1-20020a05621427e100b005d1acb8f126mr11149062qvb.38.1679797619643;
        Sat, 25 Mar 2023 19:26:59 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id ne19-20020a056214425300b005dd8b9345a1sm1889591qvb.57.2023.03.25.19.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 19:26:58 -0700 (PDT)
Date:   Sun, 26 Mar 2023 02:26:58 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARN_ON in move_normal_pmd
Message-ID: <20230326022658.GB3142556@google.com>
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz>
 <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
 <CAHk-=whuXx+cyGhFKjU0qjzvgna8iDA8YcqDDyH3cQywixuMgA@mail.gmail.com>
 <20230325163323.GA3088525@google.com>
 <CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com>
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 10:06:59AM -0700, Linus Torvalds wrote:
> On Sat, Mar 25, 2023 at 9:33 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > I actually didn't follow what you meant by "mutually PMD-aligned". Could you
> > provide some example address numbers to explain?
> 
> Sure, let me make this more clear with a couple of concrete examples.
> 
> Let's say that we have a range '[old, old+len]' and we want to remap
> it to '[new, new+len]'.
> 
> Furthermore, we'll say that overlapping is fine, but because we're
> always moving pages from "low address to high", we only allow
> overlapping when we're moving things down (ie 'new < old').
> 
> And yes, I know that the overlapping case cannot actually happen with
> mremap() itself. So in practice the overlapping case only happens for
> the special "move the stack pages" around at execve() startup, but
> let's ignore that for now.
> 
> So we'll talk about the generic "move pages around" case, not the more
> limited 'mremap()' case.
> 
> I'll also simplify the thing to just assume that we have that
> CONFIG_HAVE_MOVE_PMD enabled, so I'll ignore some of the full grotty
> details.
> 
> Ok?
[...]
> 
> we could easily decode "let's just move the whole PMD", and expand the
> move to be
> 
>     old = 0x1e00000
>     new = 0x1c00000
>     len = 0x400000
> instead. And then instead of moving PTE's around at first, we'd move
> PMD's around *all* the time, and turn this into that "simple case
> (a)".

Right, I totally get what you mean. You want to move more than the 4k pages
in the beginning of the mapping. In fact the whole PMD, which extends further
below the destination to capture the full PMD that the first 4k pages are
located in.  With that you get to just move PMDs purely all the way.

I think that is a great idea.

> NOTE! For this to work, there must be no mapping right below 'old' or
> 'new', of course. But during the execve() startup, that should be
> trivially true.

Exactly it wont work if there is something below old or new.

So for that very reason, we still have to handle the bad case where the
source PMD was not deleted right? Because if there is something below new,
you'll need to copy 1 PTE at a time till you hit the 2MB boundary, because
you can't mess with that source PMD, it is in use to satisfy mappings below
new. Then you'll eventually hit the warning we are discussing. I guess even
if one can assure that there is no mapping below new for the execve() case,
it still cannot be guaranteed for the mremap() case I think.

But I agree, if there is no mapping below old/new, then we can just do this
as an optimization. I think all that is needed to do is to check whether
there are any VMAs at those locations, but correct me if I'm wrong as I'm not
an mm expert.

> See what I'm saying?

Yep.

And as you pointed out in the mremap example, this issue can also show up
with non-overlapping ranges if I'm not mistaken.

I get your idea. Allow me to digest all this a bit more, and since it is not
urgent and this stuff is going to take some careful work with proper test
cases etc, let me take this up and work on it. But your idea is loud and
clear. I am also working on sending you that RCU PR and working hard to not
screw that up so it is a bit busy :-P.  And thank you again for the great
idea and discussion! Looking forward to working on this.

thanks,

 - Joel

