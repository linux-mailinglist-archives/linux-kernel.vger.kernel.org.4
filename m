Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3857374A872
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGGB10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGB1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:27:24 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DDD1BF3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:27:23 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-57764a6bf8cso16969027b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 18:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688693242; x=1691285242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1SxDMIjddYMTWvLw55OpsQUTvqGqbuqYUQWp4AxT1A=;
        b=VyFaPZEdU3Wco9SeFT6m+gV08lyDo20IojW2XfGAOCwXFd8/GJtKA3wQwk0a8L7dMi
         q7WQ9uG1RIq8/loWStNajDWosAj/xZ8csQ3yrf2l84/h0jYFmo2a3KMd+AkLaG+uWmm9
         wZG/IYZjhDkwi7dNdpUeUCgQJC6B4euutmYwgl+hhZLHKm7TjhjIIhKYt7mitr0YPuTd
         DKwLtCZtAPjC9zCC+LU4BIMNYV65iJY5bd8LnSFXRcrLTYGk1Y9tKAVj17tfD7ZxE4Yf
         zTaVbW9m/ee+HJqxXrccVYEIL5bf0BpQMgzgDAr61tY5FELzQTgtVeP32gurTRjZHRCx
         2LYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688693242; x=1691285242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1SxDMIjddYMTWvLw55OpsQUTvqGqbuqYUQWp4AxT1A=;
        b=ZdqNR4OwLx3GV22+E5b5iENvkUK9OTVYYvg2hk8mgCdb2u1BjpEy8bZyl9i87JiZzI
         2OO4b8UawonLqI1a+OUxVQRFkFrlSnJgFM/xzFMlQ47c+ifLTDCh8dwKRZWb/M3ghaRR
         jz5oi3BNdkhyBmqZ6hf0Z0LHTOxTTaLQX+9K3Do0i/oyvzz4j6ZkmbJU7QxarlhnsJou
         kFZfNFqg6jS4jJirVjsNOsrTcDg1utjqs1ADMJ4mh8RSBb8hpYgqtLp9hEymcTnhyfT7
         /OnsIT4GKI7JaPciE09jtH2n86KQSYAk1jgdzAQ9kcAfx2hiSJdPs4SawwF8cSEMgXEv
         e4Jw==
X-Gm-Message-State: ABy/qLZMV2bwudlQx7U96HSmdIJXz/GbonICsStP1qmjfPrJTV7xi/8t
        JagmaZsj3Uwan+ppl1PCBQ+FMMFkFe+SX+v1X6DaJ3pdbWi+OQv0FVWxZA==
X-Google-Smtp-Source: APBJJlEkZpYLtp06kMSSDqhHnsv85+pIttuiuqxskOkf2sUemuD2r4Jd4NKMREAeFZHXwLiG72/TZRg8wKAbq4LrVkg=
X-Received: by 2002:a81:7bc1:0:b0:579:f7d6:cfe6 with SMTP id
 w184-20020a817bc1000000b00579f7d6cfe6mr3083472ywc.51.1688693242551; Thu, 06
 Jul 2023 18:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230623164015.3431990-1-jiaqiyan@google.com> <20230623164015.3431990-3-jiaqiyan@google.com>
 <20230705235705.GE41006@monkey> <CACw3F511Hk-XM46fYnciKy6=t0bdmGpu9y1qsqrpJOA0zFKWhw@mail.gmail.com>
 <20230706220612.GA3768@monkey>
In-Reply-To: <20230706220612.GA3768@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Thu, 6 Jul 2023 18:27:11 -0700
Message-ID: <CACw3F51gnG7vUowL-Q4_DBRL=DAHsr7hvcBMT90OF_dLQLoDaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm/hwpoison: check if a subpage of a hugetlb folio
 is raw HWPOISON
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

On Thu, Jul 6, 2023 at 3:06=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.co=
m> wrote:
>
> On 07/06/23 11:25, Jiaqi Yan wrote:
> > On Wed, Jul 5, 2023 at 4:57=E2=80=AFPM Mike Kravetz <mike.kravetz@oracl=
e.com> wrote:
> > > On 06/23/23 16:40, Jiaqi Yan wrote:
> > > >
> > > > +bool is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
> > > > +{
> > > > +     bool ret;
> > > > +
> > > > +     spin_lock_irq(&hugetlb_lock);
> > > > +     ret =3D __is_raw_hwp_subpage(folio, subpage);
> > > > +     spin_unlock_irq(&hugetlb_lock);
> > >
> > > Can you describe what races the hugetlb_lock prevents here?
> >
> > I think we should sync here with __get_huge_page_for_hwpoison, who
> > iterates and inserts an entry to raw_hwp_list. llist itself doesn't
> > ensure insertion is synchronized with iterating from
> > __is_raw_hwp_subpage.
> >
>
> Ok, makes sense.  And, since this is only called in the file read patch
> when we encounter a PageHWPoison(page), the overhead of the lock cycles
> is not of concern.

Yes, thanks for pointing this out, (which I forgot), as
is_raw_hwp_subpage() is after PageHWPoison check in
hugetlbfs_read_iter. I think both this and the reason why holding the
lock is worth mentioning in the commit msg.


>
> You can add,
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> --
> Mike Kravetz
