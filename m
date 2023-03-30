Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A86CF81B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjC3AOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjC3AOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:14:36 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F81BC0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:14:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l14so11414260pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680135274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqTaJc++Fy4uDfLa9Ft8mislQO1Ik1i1kHjA6mm3OCE=;
        b=RQwnmDixUP+HPRQomoP/B6+oWwXu7KGgw5gFVbJxVr6oc17bKo+QeJS1OtPAZ/jEUZ
         eDCa/x0xH5hRckbJkWfj5F8gbC40EaTc5itNie86YmN+QLWeAtoUl70w+5W0MD1aUXUM
         aAhKl+2NcSVYvC8c/ipD9kONgK8vP6KLbET8fJU7mCuNNOZoyrOzy7celiIbuCx6BFB+
         BOBuCAFY3bHdVgOnkoIbbosIzo9CW3j7UxtnB2m5lK/BxDVugo+yTZ4cislAqz/UFQBK
         /I3vh7D9VQ6gkLJ8iJZZ392GP1cSyz01oDa/jmGxQwkVtgq/fNWnvYAiSmMEnZMvOdDD
         7MrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680135274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqTaJc++Fy4uDfLa9Ft8mislQO1Ik1i1kHjA6mm3OCE=;
        b=0qYsW5fr14i55xT9udZCQMq1bhFZH3MjyTesuIRux/5HdgF9lnDM/KWR/ElqSuhejQ
         xKhGQXcqIBuA0q//McVlAX+tPEaPREV9oyG5pNAuBT3OoY6c3zwCoi3Cl9fcXTFqBBk/
         GdxPLq7olPr8VI7xkObv/rmIKNoIp4hQT7kBqZVl4aVUczPkHF248VdR3h3d79P5M+wc
         vat9HnQ3GzUAIgs4X7WcPuS3fP0ufhubO0ompMJ0m1kD6/9u9aG3ABPqqqTag+iAS43n
         Pc6HSwKXRP10uNJ82NRNigR0eDxZb6OT6rrxLBcRNfA2Du89nKh5M9i/oYDTARySaumt
         cXLw==
X-Gm-Message-State: AAQBX9e/1Ezp3tZHbdwV0rpFYkdUzqKPXSRSlOAtM6JB7qt76yGBN0tg
        D+vG+0jGHXs2BTPYp6AJOdvXOQdUVnPCBcdWwao=
X-Google-Smtp-Source: AKy350Zq2BBdKRE15QvmxRG+ExUHY5peBCSxcGVhTnap9IqgKRDor+A2f1W6nwzESs937NDCtQfvcBlrM34mtaECKnY=
X-Received: by 2002:a05:6a00:b93:b0:62b:e52e:1bb with SMTP id
 g19-20020a056a000b9300b0062be52e01bbmr9897401pfj.0.1680135274513; Wed, 29 Mar
 2023 17:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230329145330.23191-1-ivan.orlov0322@gmail.com> <20230329145304.66add47ba9b9fafb71b1e13d@linux-foundation.org>
In-Reply-To: <20230329145304.66add47ba9b9fafb71b1e13d@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 29 Mar 2023 17:14:23 -0700
Message-ID: <CAHbLzko=aWBPk5a1P2fgR9yAgc52WG-HX_OBV8=iWFy_D4_eNQ@mail.gmail.com>
Subject: Re: [PATCH] mm: khugepaged: Fix kernel BUG in hpage_collapse_scan_file
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Zach O'Keefe" <zokeefe@google.com>
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, himadrispandya@gmail.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 2:53=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 29 Mar 2023 18:53:30 +0400 Ivan Orlov <ivan.orlov0322@gmail.com> =
wrote:
>
> > Syzkaller reported the following issue:
> >
> > ...
> >
> > The 'xas_store' call during page cache scanning can potentially
> > translate 'xas' into the error state (with the reproducer provided
> > by the syzkaller the error code is -ENOMEM). However, there are no
> > further checks after the 'xas_store', and the next call of 'xas_next'
> > at the start of the scanning cycle doesn't increase the xa_index,
> > and the issue occurs.
> >
> > This patch will add the xarray state error checking after the
> > 'xas_store' and the corresponding result error code.
> >
> > Tested via syzbot.
> >
> > Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?id=3D7d6bb3760e026ece7524500fe4=
4fb024a0e959fc
> > Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> > ---
> >  mm/khugepaged.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 92e6f56a932d..4d9850d9ea7f 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -55,6 +55,7 @@ enum scan_result {
> >       SCAN_CGROUP_CHARGE_FAIL,
> >       SCAN_TRUNCATED,
> >       SCAN_PAGE_HAS_PRIVATE,
> > +     SCAN_STORE_FAILED,
> >  };
> >
> >  #define CREATE_TRACE_POINTS
> > @@ -1840,6 +1841,15 @@ static int collapse_file(struct mm_struct *mm, u=
nsigned long addr,
> >                                       goto xa_locked;
> >                               }
> >                               xas_store(&xas, hpage);
> > +                             if (xas_error(&xas)) {
> > +                                     /* revert shmem_charge performed
> > +                                      * in the previous condition
> > +                                      */
> > +                                     mapping->nrpages--;
> > +                                     shmem_uncharge(mapping->host, 1);
> > +                                     result =3D SCAN_STORE_FAILED;
> > +                                     goto xa_locked;
> > +                             }
> >                               nr_none++;
> >                               continue;
> >                       }
>
> Needs this, I assume.
>
> --- a/include/trace/events/huge_memory.h~mm-khugepaged-fix-kernel-bug-in-=
hpage_collapse_scan_file-fix
> +++ a/include/trace/events/huge_memory.h
> @@ -36,7 +36,8 @@
>         EM( SCAN_ALLOC_HUGE_PAGE_FAIL,  "alloc_huge_page_failed")       \
>         EM( SCAN_CGROUP_CHARGE_FAIL,    "ccgroup_charge_failed")        \
>         EM( SCAN_TRUNCATED,             "truncated")                    \
> -       EMe(SCAN_PAGE_HAS_PRIVATE,      "page_has_private")             \
> +       EM( SCAN_PAGE_HAS_PRIVATE,      "page_has_private")             \
> +       EMe(SCAN_STORE_FAILED,          "store_failed")

I'm a little bit reluctant to make the error code list longer, can we
just return SCAN_FAIL? IIUC this issue should happen very rarely,
maybe not worth a new error code.

Basically the rollback approach makes sense to me. IIRC Zach was
looking into the same problem, loop him in. He may share some
thoughts.

>
>  #undef EM
>  #undef EMe
> _
>
>
