Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269A774A39C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjGFSLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjGFSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:11:53 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62C21BEB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:11:49 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so1049130276.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688667109; x=1691259109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yoi+Ui/n5ymlKlL4emJAwTL06zox3wOS5TKB3nBjTn0=;
        b=0ABh7BnJQaOkCm2vwnIyXS85Dm6oN23GDz6XekxiM5iuuvfjXA0V3sc+fj0ZJlKrmW
         JoRoMZlnwm4pe0qo0/HKiKXtoo2kjmt5Eyl7hzUSwj4Mo+R5UpHYRIdR6UXkQgI2Kl8q
         cxoI72dPLw8DGkocfdomCxadLgQTPkz+3PIELCGbAXIpeDwnsx6wRaQsldAAZ9lhYLsb
         HGkcTDMjjasKMcZ8ijtbTGQkQO1Ms+l5fzaabqAyGAM9CXJPihwsb2gxQNwsCmehMJTu
         RlWbpR719cRHDOMj62gy8n1T5g2b7wEy4PNreo2IScT9KDTvIsh+eBx5Rggsy4b+SYse
         Kgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688667109; x=1691259109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yoi+Ui/n5ymlKlL4emJAwTL06zox3wOS5TKB3nBjTn0=;
        b=Fxxh8Tfs8b9xZ45b6eCd53/pdwrCbeCDeiB5uUWYJNDB1qmavjRqn3qkm2bSSFoiN8
         XGU8QA+heZDAO4E3fungikKAXc0GcJGcez/aCj3sb4gDv0Iv5fv/BiCqHeMikknorg49
         ABosTORYiivTdu2MoZD1MHRvcd6T5znGnQCYFyD9x5eyySfJFrsC59XVUtJgjyEsD0vT
         FYV2/9zP3RW5U3GjqcYwiFTZ1d8zmRv3IqfWuQ3S/AozNWHc4ft5j1XCbnMX/Y6MjMqw
         n3x38phc7KXY+sPCf6EoXBhtEm8+sryHz5u1g8cspN8lkCUR8p4/trOVBgBg8lP+GxKM
         PIsA==
X-Gm-Message-State: ABy/qLZCi6eEv49tHyZ9yTDCiRPL70ZiLXNVQZN6+YimP2k0eaezQP+9
        Qmfnq7nwGVpkdq/HT5mr/JURfy0vjEcjVmeAX8adUw==
X-Google-Smtp-Source: APBJJlGzNm7UqJPEd+Fa/QFQbbOPQMaa0im+Vjq7G71we1CRLlzVfDB7RlSZeu3QRdeWXIuihMzHbms3Qmv6PKSyiFA=
X-Received: by 2002:a25:6085:0:b0:c18:1300:6339 with SMTP id
 u127-20020a256085000000b00c1813006339mr2566303ybb.52.1688667108853; Thu, 06
 Jul 2023 11:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230623164015.3431990-1-jiaqiyan@google.com> <20230623164015.3431990-2-jiaqiyan@google.com>
 <20230705233541.GC41006@monkey>
In-Reply-To: <20230705233541.GC41006@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Thu, 6 Jul 2023 11:11:37 -0700
Message-ID: <CACw3F53LeNww_fxAHyhH6-5OLv0obgswEtKq7Q20gwmf4Crk5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/hwpoison: delete all entries before traversal
 in __folio_free_raw_hwp
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 4:36=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.co=
m> wrote:
>
> On 06/23/23 16:40, Jiaqi Yan wrote:
> > Traversal on llist (e.g. llist_for_each_safe) is only safe AFTER entrie=
s
> > are deleted from the llist.
> >
> > llist_del_all are lock free with itself. folio_clear_hugetlb_hwpoison()=
s
> > from __update_and_free_hugetlb_folio and memory_failure won't need
> > explicit locking when freeing the raw_hwp_list.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  mm/memory-failure.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
>
> After updating the reason for patch in commit message as suggested by Nao=
ya,

Thank you both Mike and Naoya! I will add the explanation in the next versi=
on.

>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> --
> Mike Kravetz
>
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 004a02f44271..c415c3c462a3 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1825,12 +1825,11 @@ static inline struct llist_head *raw_hwp_list_h=
ead(struct folio *folio)
> >
> >  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool mo=
ve_flag)
> >  {
> > -     struct llist_head *head;
> > -     struct llist_node *t, *tnode;
> > +     struct llist_node *t, *tnode, *head;
> >       unsigned long count =3D 0;
> >
> > -     head =3D raw_hwp_list_head(folio);
> > -     llist_for_each_safe(tnode, t, head->first) {
> > +     head =3D llist_del_all(raw_hwp_list_head(folio));
> > +     llist_for_each_safe(tnode, t, head) {
> >               struct raw_hwp_page *p =3D container_of(tnode, struct raw=
_hwp_page, node);
> >
> >               if (move_flag)
> > @@ -1840,7 +1839,6 @@ static unsigned long __folio_free_raw_hwp(struct =
folio *folio, bool move_flag)
> >               kfree(p);
> >               count++;
> >       }
> > -     llist_del_all(head);
> >       return count;
> >  }
> >
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
