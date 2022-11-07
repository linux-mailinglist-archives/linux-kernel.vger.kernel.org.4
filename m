Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EDC61FDE5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiKGSuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiKGSus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:50:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA86C20BE1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:50:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v17so11909638plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F6Iijyy/39XMB5DWSlZ4cyFVlxZqZqXMo2iBv4u9CM=;
        b=KnjutuB4R3SwMHEc5hufYGnDlgQTQIzehE4y/tIoueLHrhYyJj7FX813dKiht99s5Z
         /j2LirqdNiHU4DG4JULK3cYIDOOllICNuZLgo8tsJxipEsCSjD1zuuPx8KEhsEtTAcv+
         hvw4N8LDFlFcPTwSC6gl/jMo1wDUocbJXM18MCV1L5b6d6260j0gQPH7mXHjaMs4xmS4
         hj0iWKkvhtK2mwvWu5zwhh61pKPr2u0iXh5DvOmKAV5stpUS60mJO1aoi0B+33b2ygOE
         uz74UcaXUCJLX731mvZA1egMCcZLB22Ahe+JkjTVvXIcxtRZMJm4gjulMlBwfSTGBm0u
         YK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6F6Iijyy/39XMB5DWSlZ4cyFVlxZqZqXMo2iBv4u9CM=;
        b=ewBzCLcW/UqPLY634L7SUJwUwz6+aTZN43GEYWXhsd7TsL9viP0BgVvNyRVD+x2xeu
         EnGq4whK7uYjnMYeNhHePzeXG1XNPti1m5AIsZQzHjpLiPN3sD10UlfLfd9j3+FdGdYg
         UwjojeWkkd5sLKx85SMADLiVlBUy1EyIBxqhIrvnX35hlxtssmDc7gmeIszoH7CaUhuI
         IC/iM4KlAg00pCW/w86t3sVgYusRbeqhE8UXR1eL8WK8UVMo9ZF6batxml0gt05ikI/l
         MyS3lx+2YPJ3PE6ZVdLHN0RP0FXCSwQav/+Q1guCPExNeFJbqlENlIxX+NVu/OqeSlpy
         j3VA==
X-Gm-Message-State: ACrzQf1NzMwxUevVrauwkhMlGeQTFfiUcjH25FFhZEaleacaRnSA9Ck4
        FUdjm0rDORU32YrZAVTj/opdeURx2FmzcmR/shE=
X-Google-Smtp-Source: AMsMyM4JRASTk7uGXBgx86EaCOJTBDqvYoGoEq9e+xUimN/ehKNSvXyXwK7O6oAuPd7F5PpdfxBPs4aFiiXR6DAx3jM=
X-Received: by 2002:a17:90a:558c:b0:213:8cf1:2ac2 with SMTP id
 c12-20020a17090a558c00b002138cf12ac2mr56909211pji.67.1667847047525; Mon, 07
 Nov 2022 10:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20221018200125.848471-1-jthoughton@google.com>
 <20221104021035.GA297167@hori.linux.bs1.fc.nec.co.jp> <Y2UTUNBHVY5U9si2@monkey>
 <20221107042544.GA436198@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20221107042544.GA436198@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Nov 2022 10:50:35 -0800
Message-ID: <CAHbLzkpb5+sPmKLNjoL27mNoVFiKnNCwU6JJY_R7VquJL7VG5Q@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 6, 2022 at 8:25 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Fri, Nov 04, 2022 at 06:27:44AM -0700, Mike Kravetz wrote:
> > On 11/04/22 02:10, HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3 =E7=9B=B4=E4=B9=
=9F) wrote:
> > > On Tue, Oct 18, 2022 at 08:01:25PM +0000, James Houghton wrote:
> > > > This change is very similar to the change that was made for shmem [=
1],
> > > > and it solves the same problem but for HugeTLBFS instead.
> > > >
> > > > Currently, when poison is found in a HugeTLB page, the page is remo=
ved
> > > > from the page cache. That means that attempting to map or read that
> > > > hugepage in the future will result in a new hugepage being allocate=
d
> > > > instead of notifying the user that the page was poisoned. As [1] st=
ates,
> > > > this is effectively memory corruption.
> > > >
> > > > The fix is to leave the page in the page cache. If the user attempt=
s to
> > > > use a poisoned HugeTLB page with a syscall, the syscall will fail w=
ith
> > > > EIO, the same error code that shmem uses. For attempts to map the p=
age,
> > > > the thread will get a BUS_MCEERR_AR SIGBUS.
> > > >
> > > > [1]: commit a76054266661 ("mm: shmem: don't truncate page if memory=
 failure happens")
> > > >
> > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > >
> > > I did some testing and found no issue. So I agree with this patch.
> > > Thank you very much.
> > >
> > > Tested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > >
> > > As for whether to go with HGM patchset or not, I have no strong opini=
on.
> > > As you stated in another email this patch is correct without HGM patc=
h,
> > > so it's OK to me to make this merged first.
> >
> > Thanks Naoya.
> >
> > This is a late thought, but ...
> > Should this patch and Yang Shi's shmem patch be backported to stable re=
leases?
> > Both address potential data corruption/loss, so it certainly seems like
> > stable material.
>
> Yes, I agree that backporting these could be helpful.

+1

>
> So I think that I'll try to backport commit a7605426666 and its dependenc=
ies
> to 5.15 (and older LTS if possible).  For this patch, just adding "Cc: st=
able"
> should be enough for now.

Thanks, Naoya.

>
> Thanks,
> Naoya Horiguchi
