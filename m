Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD28870A53D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 06:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjETEPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 00:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjETEOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 00:14:37 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E9910C0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:14:35 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-561e919d355so40456617b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684556075; x=1687148075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKFHfOt79bbdBaqzdxN8j2hMfFW7vnWoSDGot+W6SPQ=;
        b=odsgxA2RlfA0x9AR6QIquA0XdW6aJrY4qb4To/ev0n2Nb+/LnsNeFrn81LhPY9rFuA
         1uqRimOmf0Uu3yoCEi0c0jcDlbWWvDHsLLLLi1K4R8nShrkTNhRpkXiqYyWW91flPVfo
         JG/hA1reIyP3XffNCEI/DPzFJDCDIrTQYs/K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684556075; x=1687148075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKFHfOt79bbdBaqzdxN8j2hMfFW7vnWoSDGot+W6SPQ=;
        b=CcW+AIhIaRBGG1dnodmhX0+e9iSvUX6glR+p270Dn9dbH9RrdbWU/cSl+7tyxsBzVY
         WbYYJLXGl2keJM3vMCn2p92lKNtc+VcT36HcC/s++0Hb5KsB5nQBl7arqErlY4qNbA8X
         /QTswVB/VAAjwMQvUnuFxVuaMw6QeLurvM6wLFqwBcC+faMEDdhxB58Lc41wLhuGxnHr
         xT/knw0c8jerk7RbML+s+lc8qkXr/6lMl2B1f+VM4z5VFncNXHPYFk1yJX5Ea6n66y5M
         f4+zqNcfTTekF5soa+sM9lDPwq0wRk+QGAalkS2GI45pdgGVe8gX/JCtfJtK13Cb/6HE
         C4yw==
X-Gm-Message-State: AC+VfDxj7LrWUldpr/kCt99rQTb6m6AXoMXqbzUeVi/LOAfY6bqbsvc/
        9sZhaeJaG3GR9cnBMzni7GeR4UECchmPZQno38UZkg==
X-Google-Smtp-Source: ACHHUZ7tfCjlDBaP5aEQ+3HWr/iR0SS0VdC+C2u8MYDeXBPtfyAYgxcbSrH6X0ewKCgIva89J2vjPqHQfCz3uK1maW4=
X-Received: by 2002:a0d:cb16:0:b0:561:a80b:6647 with SMTP id
 n22-20020a0dcb16000000b00561a80b6647mr3869821ywd.45.1684556074663; Fri, 19
 May 2023 21:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
 <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
 <CAEXW_YT1qr9F1QaABthUx6qxWPYYom-oW7XMVExzrHLWdhUGKg@mail.gmail.com>
 <CAEXW_YTqjGG4Y06brQthe4UMqprTJm=xk=P7i5gTpm2rZRZkXQ@mail.gmail.com> <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com>
In-Reply-To: <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 20 May 2023 00:14:23 -0400
Message-ID: <CAEXW_YS-ScBYeTtj7PTZSSYXeApsZ1vhTpBFtq5jNA_R9055=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 12:01=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, May 19, 2023 at 8:57=E2=80=AFPM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > I also realize that I don't really need to check whether the masked
> > source address falls under a VMA neighboring to that of the source's.
>
> I don't think that's true.
>
> You can't start randomly moving other source vma's that may have other co=
ntents.

If the beginning part of the PMD is not mapped at the destination, I
thought maybe a whole PMD could be moved to it. But I guess not
because we don't want those contents to be accessible. So then in that
case we have to forbid the optimization for all intra-VMA moves except
those involving the stack. I will think more about it.

Thanks,

 - Joel
